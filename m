Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A4606D82D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UBlmw0aE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Desi2tiV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V9XGG1Sn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UJ8AwcVP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=j4C7NM8ynZjvb1im1O6tioDfvLKpmKcFgPTkMChJ9lw=; b=UBlmw0aEwZNl3rjd8aWPNNdbpQ
	Et9rppriP/cqidc9BJgf8F4HW3Gh6JhmWRHHJOvnYhEDe5bwcxjpe2/9ItxxUFkp6u6F98ibFGjLm
	4zqu+Xmb5KvffXsdEqWlg+wpwndeNZWtWmu6IXWZ6nD0huPZ4KY9g8IZ5t/BIZE7sRro=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODsi-0000000011x-46dr;
	Tue, 03 Nov 2026 12:44:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODsI-0000000011X-0DxF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0zHAhKpDsvz4TrCPjBYbNOAHla5KK7ieBNkDlbh8+Sk=; b=Desi2tiV05DYRoUCAOKL6BiN2I
 plagoLKsUuLGiTk5f2ZlSVeQOsnIIaeM6CO3efMOqaREu92NwOmX7frW/+N6DjWMqE0KrtjfD0HDJ
 KFf8zMNgCGBUKAd+8AHnVLBGpe4gjrQN5DutRnqOQk6Y9Hli0FTZC+Ji1Qcwnqjmtn50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0zHAhKpDsvz4TrCPjBYbNOAHla5KK7ieBNkDlbh8+Sk=; b=V9XGG1SnN3IrI0XumMvgynyuYt
 JHVN2pbKzFYb6T0StjmATQ1jWIiIPZGm6iC2aDdJK7XoDeY2bAYRZg7Wprdud+9o2zy+2SpamM4mQ
 PHpsNg4Ggo+qwNm6+luXlYhGOhJ8rCc6raiUf6S8esSo9TjyIVA6nBVFW7fngh22ySqw=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODsF-000000002Oc-0QtP for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:25 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so6628835e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793709856; x=1794314656; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0zHAhKpDsvz4TrCPjBYbNOAHla5KK7ieBNkDlbh8+Sk=;
 b=UJ8AwcVPzdis6X75XPSuhvAHyMM3YlLLdNdovGw9gT5CqqXLM/czzorxwa31IvqCE2
 KKEgwgW0+kJng4HKDi4Nr72kGJ3JpTmGTaNgn1zUjB1mZgRYELIgrx0ceuAbZiL0EZCY
 4lsNs7qxxZXJoK2qzXWG31iCyS2SjURA0Z24PwRZJ4N9Mdu6HX2+os0Umq7QiG39aSI9
 W71wplj2CmWPEInmEDEjXIuhXlajX+8HRRgRH7JR/bhsxMVq5JAMgNV3QRSWqvzwwQjL
 G39WglIH4sIXoThdNUjubDXeuGmvKUIxA7aouxb3azeYDQ1jb56y4QCtHaKA3t2cksQr
 OFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709856; x=1794314656;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zHAhKpDsvz4TrCPjBYbNOAHla5KK7ieBNkDlbh8+Sk=;
 b=xvW7hzfbip4bKOgTFqEYCTAzkpFj1853QSXp/TgmqEg9OrpooOmbefnojnBG1z6K6U
 6nV3hOzezJWmToAFrP1yQhdKbWelMUv2sGC5G0gcvo/ifTwRTOe/sodeg5sQXDsAN3yb
 HBPMHNV/xjzGAhM2fy+fNnbRWM07o6+iui0M59rQmsVnIX85CSVlMACIP4mg9m9Ai4tA
 +4Ak8F6wCNCNgvzOtoBQYu/QvdATn4Y6CetXSRWZA82O+v8fZXZuOOFMpyiEcfOl/uWy
 sJpQd299GOrVHmexROlBPscQDJ6I9H8W/7ytowmMN0b4EslXRD/qRT3cl0ULtVihDiR0
 5kTw==
X-Gm-Message-State: APuU4Z941w0jKnHMqTXD6yzZJQxL2N4FaJ/7uU00MbBI8uTWzouWIoNM
 IBdPDfNoB0WReB12NX2vP/f7mU5vpOA86yu6l5O/Vrgj/CgeITRojCsS+LfO1RZVWBrx4YwIICe
 Yg/8TAC8kg9ov5XA6ebGUTfQcmj9g4aSU5cS2haYZcEJLo+BcdvXMKzi9eM95BaPEp+z2sJQ06a
 qpOI7HvA==
X-Gm-Gg: AYBFou2CStPaXdjedUym7trdb+FZeJ4u2BJ90M6dettyoXVBcbfzkqyPc2GvDT5nPiZ
 um921cVqBM986HLWXjkR2k+eiyV3/kWlP9hUNSgq7aKARR1sj7HEdh+k1SAQILb4cnoyxtouI8D
 bSXokdR6tcENHv+y6ItDZZPCE+Oh0dORystQLmkXrVN4JRNOBoqq2YptJDm+7nBcCf0nG9M0B/7
 liHV24PAP1IcfQ88TmihOO2J5ujUgNhrnlQxAhnbybrGtxGw8Fbvv3fhGASQbQRWChLNG5Dlrdb
 biJ4qTEmw5YJvMG5AqTta3Ue1xu0Hu1iHonZR6zOk6pdIYbuyAho1NOWiWB+/LBtHH1flpuAHVJ
 eKAcwQatVtfYruBkkVGmXEX9qS0NS2MTS7Y5rM6oRpg1hPTnhsWqhstTDfOS42bk4Fu3roxZaHy
 ZoVmyhIY1RJhTb2THVx0xCodh5gbJOIqOze7u5Nb99f5M0lih+koOteVx+JE4fo7ViMpLCOOP0n
 rhzfMHjJ+w6SXvKcVfiz9cr/FM/dzzAnQgQCPPcSq+XV/FDNBbYtbqHF6z+D9bCZxM2UYVhrtPG
 1zQd0imw4USWwby3qDh0QO1RvjIQPwLCVXxdCL64MYlsmXOuesvV7/S8s2Ag4Dley/FsjPYyo/K
 2Z0dll1/Q4g7vewT8/zoOCTVsHpvZHPvl4UyRnpa4GVboRLVsQt6x5VJJW2OESmyc/1qwDu2ZyI
 fb0ds07RaUCS2vZQ==
X-Received: by 2002:a05:600c:6555:b0:4a1:d45a:3ae9 with SMTP id
 5b1f17b1804b1-4aa8b05fa4bmr311142905e9.15.1793709855988; 
 Tue, 03 Nov 2026 04:44:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba2415sm25491607f8f.50.2026.11.03.04.44.14
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:44:15 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:44:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
X-Gerrit-Change-Number: 2106
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2106?usp=email>
X-Gerrit-Commit: 6fd0e4b10e28bf743f2e99bbf519ebc8c41e744b
References: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkllZTNmZjFmNWYzZWM5MzMxZjYxYjBhN2YxZjNiOWNhNTE1NzU1MzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a7f35847c7105da5771aabef97332dd682e87fc3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xODsF-000000002Oc-0QtP
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0111964560654765413=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0111964560654765413==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mb5xXDAfI7k="; charset=UTF-8

--mb5xXDAfI7k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2106?usp=3Demail )


Change subject: Make parameter o=
penvpn_net_ctx_t const where possible
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Make parameter openvpn_net_ctx_t const where poss=
ible

After move the gc_arena inside the various iproute2 related
function =
most of the openvpn_net_ctx_t parameters can be made const=2E

This does no=
t make net_ctx_free and net_ctx_reset const as those
functions are intended=
 to modify the net ctx even though none of
them do anymore=2E

Change-Id: I=
ee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
Signed-off-by: Arne Schwabe <arne@=
rfc2549=2Eorg>
---
M src/openvpn/lladdr=2Ec
M src/openvpn/lladdr=2Eh
M src/=
openvpn/networking=2Eh
M src/openvpn/networking_freebsd=2Ec
M src/openvpn/n=
etworking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
6 files changed, =
55 insertions(+), 55 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/06/2106/1

diff --git a/src/openvpn/lladdr=2Ec=
 b/src/openvpn/lladdr=2Ec
index 195245f=2E=2E8c3be91 100644
--- a/src/openv=
pn/lladdr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -15,7 +15,7 @@
 
 #ifdef TARG=
ET_LINUX
 static int
-set_lladdr_linux(openvpn_net_ctx_t *ctx, const char *=
ifname, const char *lladdr)
+set_lladdr_linux(const openvpn_net_ctx_t *ctx,=
 const char *ifname, const char *lladdr)
 {
     uint8_t addr[OPENVPN_ETH_A=
LEN];
 
@@ -48,7 +48,7 @@
 #endif /* TARGET_LINUX */
 
 int
-set_lladdr(ope=
nvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const struct e=
nv_set *es)
+set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, c=
onst char *lladdr, const struct env_set *es)
 {
     if (!ifname || !lladdr=
)
     {
diff --git a/src/openvpn/lladdr=2Eh b/src/openvpn/lladdr=2Eh
index=
 0c8b416=2E=2E9ab6578 100644
--- a/src/openvpn/lladdr=2Eh
+++ b/src/openvpn=
/lladdr=2Eh
@@ -5,5 +5,5 @@
 #include "misc=2Eh"
 #include "networking=2Eh"=

 
-int set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *=
lladdr,
+int set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, c=
onst char *lladdr,
                const struct env_set *es);
diff --git a/=
src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index 25233c8=2E=2E=
7ad6e2e 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networkin=
g=2Eh
@@ -101,7 +101,7 @@
  *
  * @return          0 on success, negative e=
rror code on error
  */
-int net_iface_new(openvpn_net_ctx_t *ctx, const op=
envpn_net_iface_t *iface, const char *type,
+int net_iface_new(const openvp=
n_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,
     =
              const void *arg);
 
 /**
@@ -113,7 +113,7 @@
  *
  * @return =
         0 on success, a negative error code otherwise
  */
-int net_iface_=
type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MA=
X]);
+int net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, c=
har type[IFACE_TYPE_LEN_MAX]);
 
 /**
  * Remove an interface
@@ -122,7 +12=
2,7 @@
  * @param iface     interface to delete
  * @return int 0 on succes=
s, negative error code on error
  */
-int net_iface_del(openvpn_net_ctx_t *=
ctx, const openvpn_net_iface_t *iface);
+int net_iface_del(const openvpn_ne=
t_ctx_t *ctx, const openvpn_net_iface_t *iface);
 
 /**
  * Bring interface=
 up or down=2E
@@ -133,7 +133,7 @@
  *
  * @return          0 on success, a=
 negative error code otherwise
  */
-int net_iface_up(openvpn_net_ctx_t *ct=
x, const openvpn_net_iface_t *iface, bool up);
+int net_iface_up(const open=
vpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);
 
 /**
  * =
Set the MTU for an interface
@@ -144,7 +144,7 @@
  *
  * @return          0=
 on success, a negative error code otherwise
  */
-int net_iface_mtu_set(op=
envpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t mtu);
+int=
 net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t =
*iface, uint32_t mtu);
 
 /**
  * Set the Link Layer (Ethernet) address of =
the TAP interface
@@ -155,7 +155,7 @@
  *
  * @return          0 on success=
, a negative error code otherwise
  */
-int net_addr_ll_set(openvpn_net_ctx=
_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);
+int net_addr_ll=
_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_=
t *addr);
 
 /**
  * Add an IPv4 address to an interface
@@ -167,7 +167,7 @=
@
  *
  * @return          0 on success, a negative error code otherwise
  =
*/
-int net_addr_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *=
iface, const in_addr_t *addr,
+int net_addr_v4_add(const openvpn_net_ctx_t =
*ctx, const openvpn_net_iface_t *iface, const in_addr_t *addr,
            =
         int prefixlen);
 
 /**
@@ -181,7 +181,7 @@
  * @return          0 =
on success, a negative error code otherwise
  */
 
-int net_addr_v6_add(ope=
nvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_addr_v6_add=
(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
          =
           const struct in6_addr *addr, int prefixlen);
 
 /**
@@ -193,7 +1=
93,7 @@
  *
  * @return          0 on success, a negative error code otherw=
ise
  */
-int net_addr_v4_del(openvpn_net_ctx_t *ctx, const openvpn_net_ifa=
ce_t *iface, const in_addr_t *addr,
+int net_addr_v4_del(const openvpn_net_=
ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *addr,
      =
               int prefixlen);
 
 /**
@@ -205,7 +205,7 @@
  *
  * @return  =
        0 on success, a negative error code otherwise
  */
-int net_addr_v6=
_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_add=
r_v6_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
  =
                   const struct in6_addr *addr, int prefixlen);
 
 /**
@@ -=
218,7 +218,7 @@
  *
  * @return          0 on success, a negative error cod=
e otherwise
  */
-int net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const ope=
nvpn_net_iface_t *iface,
+int net_addr_ptp_v4_add(const openvpn_net_ctx_t *=
ctx, const openvpn_net_iface_t *iface,
                         const in_ad=
dr_t *local, const in_addr_t *remote);
 
 /**
@@ -231,7 +231,7 @@
  *
  * @=
return          0 on success, a negative error code otherwise
  */
-int net=
_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
=
+int net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const openvpn_net_if=
ace_t *iface,
                         const in_addr_t *local, const in_add=
r_t *remote);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE */
@@ -251,7 +251=
,7 @@
  *
  * @return          0 on success, a negative error code otherwis=
e
  */
-int net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, =
int prefixlen,
+int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in=
_addr_t *dst, int prefixlen,
                      const in_addr_t *gw, con=
st openvpn_net_iface_t *iface, uint32_t table,
                      int me=
tric);
 
@@ -269,7 +269,7 @@
  *
  * @return          0 on success, a negat=
ive error code otherwise
  */
-int net_route_v6_add(openvpn_net_ctx_t *ctx,=
 const struct in6_addr *dst, int prefixlen,
+int net_route_v6_add(const ope=
nvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
           =
           const struct in6_addr *gw, const openvpn_net_iface_t *iface, uin=
t32_t table,
                      int metric);
 
@@ -287,7 +287,7 @@
  *
 =
 * @return          0 on success, a negative error code otherwise
  */
-int=
 net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixl=
en,
+int net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *ds=
t, int prefixlen,
                      const in_addr_t *gw, const openvpn_=
net_iface_t *iface, uint32_t table,
                      int metric);
 
@@=
 -305,7 +305,7 @@
  *
  * @return          0 on success, a negative error c=
ode otherwise
  */
-int net_route_v6_del(openvpn_net_ctx_t *ctx, const stru=
ct in6_addr *dst, int prefixlen,
+int net_route_v6_del(const openvpn_net_ct=
x_t *ctx, const struct in6_addr *dst, int prefixlen,
                      =
const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table=
,
                      int metric);
 
diff --git a/src/openvpn/networking_=
freebsd=2Ec b/src/openvpn/networking_freebsd=2Ec
index 04051a6=2E=2E88fd5c0=
 100644
--- a/src/openvpn/networking_freebsd=2Ec
+++ b/src/openvpn/networki=
ng_freebsd=2Ec
@@ -82,28 +82,28 @@
 }
 
 int
-net_route_v4_add(openvpn_net_=
ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_=
route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefix=
len, const in_addr_t *gw,
                  const char *iface, uint32_t tab=
le, int metric)
 {
     return net_route_v4("add", dst, prefixlen, gw, ifac=
e, table, metric);
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t *ctx, cons=
t struct in6_addr *dst, int prefixlen,
+net_route_v6_add(const openvpn_net_=
ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  co=
nst struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
=
     return net_route_v6("add", dst, prefixlen, gw, iface, table, metric);
=
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, i=
nt prefixlen, const in_addr_t *gw,
+net_route_v4_del(const openvpn_net_ctx_=
t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
         =
         const char *iface, uint32_t table, int metric)
 {
     return net_=
route_v4("del", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
-net_r=
oute_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixl=
en,
+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *=
dst, int prefixlen,
                  const struct in6_addr *gw, const char=
 *iface, uint32_t table, int metric)
 {
     return net_route_v6("del", dst=
, prefixlen, gw, iface, table, metric);
diff --git a/src/openvpn/networking=
_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index 4685465=2E=2E68e6=
dfe 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/openvpn/netw=
orking_iproute2=2Ec
@@ -59,7 +59,7 @@
 }
 
 int
-net_iface_new(openvpn_net_=
ctx_t *ctx, const char *iface, const char *type, const void *arg)
+net_ifac=
e_new(const openvpn_net_ctx_t *ctx, const char *iface, const char *type, co=
nst void *arg)
 {
     struct argv argv =3D argv_new();
 
@@ -73,7 +73,7 @@=

 }
 
 int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char =
type[IFACE_TYPE_LEN_MAX])
+net_iface_type(const openvpn_net_ctx_t *ctx, con=
st char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     /* not supported by =
iproute2 */
     msg(M_WARN, "%s: operation not supported by iproute2 backe=
nd", __func__);
@@ -81,7 +81,7 @@
 }
 
 int
-net_iface_del(openvpn_net_ctx_=
t *ctx, const char *iface)
+net_iface_del(const openvpn_net_ctx_t *ctx, con=
st char *iface)
 {
     struct argv argv =3D argv_new();
 
@@ -94,7 +94,7 @=
@
 }
 
 int
-net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool u=
p)
+net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)
=
 {
     struct argv argv =3D argv_new();
 
@@ -108,7 +108,7 @@
 }
 
 int
-n=
et_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
+=
net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t=
 mtu)
 {
     struct argv argv =3D argv_new();
 
@@ -122,7 +122,7 @@
 }
 
 =
int
-net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *ifa=
ce, uint8_t *addr)
+net_addr_ll_set(const openvpn_net_ctx_t *ctx, const ope=
nvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct argv argv =3D argv_n=
ew();
     int ret =3D 0;
@@ -142,7 +142,7 @@
 }
 
 int
-net_addr_v4_add(op=
envpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixl=
en)
+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const=
 in_addr_t *addr, int prefixlen)
 {
     struct argv argv =3D argv_new();
 =
    struct gc_arena gc =3D gc_new();
@@ -160,7 +160,7 @@
 }
 
 int
-net_add=
r_v6_add(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *=
addr,
+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, con=
st struct in6_addr *addr,
                 int prefixlen)
 {
     struct ar=
gv argv =3D argv_new();
@@ -179,7 +179,7 @@
 }
 
 int
-net_addr_v4_del(open=
vpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen=
)
+net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const i=
n_addr_t *addr, int prefixlen)
 {
     struct argv argv =3D argv_new();
   =
  struct gc_arena gc =3D gc_new();
@@ -198,7 +198,7 @@
 }
 
 int
-net_addr_=
v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *ad=
dr,
+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, const=
 struct in6_addr *addr,
                 int prefixlen)
 {
     struct argv=
 argv =3D argv_new();
@@ -217,7 +217,7 @@
 }
 
 int
-net_addr_ptp_v4_add(op=
envpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_addr_=
ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t=
 *local,
                     const in_addr_t *remote)
 {
     struct argv =
argv =3D argv_new();
@@ -237,7 +237,7 @@
 }
 
 int
-net_addr_ptp_v4_del(ope=
nvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_addr_p=
tp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t =
*local,
                     const in_addr_t *remote)
 {
     struct argv a=
rgv =3D argv_new();
@@ -257,7 +257,7 @@
 }
 
 int
-net_route_v4_add(openvpn=
_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
=
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int p=
refixlen, const in_addr_t *gw,
                  const char *iface, uint32_=
t table, int metric)
 {
     struct argv argv =3D argv_new();
@@ -297,7 +29=
7,7 @@
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6=
_addr *dst, int prefixlen,
+net_route_v6_add(const openvpn_net_ctx_t *ctx, =
const struct in6_addr *dst, int prefixlen,
                  const struct i=
n6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     struct =
argv argv =3D argv_new();
@@ -332,7 +332,7 @@
 }
 
 int
-net_route_v4_del(o=
penvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t=
 *gw,
+net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst,=
 int prefixlen, const in_addr_t *gw,
                  const char *iface, u=
int32_t table, int metric)
 {
     struct argv argv =3D argv_new();
@@ -360=
,7 +360,7 @@
 }
 
 int
-net_route_v6_del(openvpn_net_ctx_t *ctx, const stru=
ct in6_addr *dst, int prefixlen,
+net_route_v6_del(const openvpn_net_ctx_t =
*ctx, const struct in6_addr *dst, int prefixlen,
                  const st=
ruct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     s=
truct argv argv =3D argv_new();
diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec
index 0c99d38=2E=2E97ff7bd 100644
-=
-- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2E=
c
@@ -669,7 +669,7 @@
 #ifdef ENABLE_SITNL
 
 int
-net_iface_up(openvpn_net=
_ctx_t *ctx, const char *iface, bool up)
+net_iface_up(const openvpn_net_ct=
x_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;
  =
   int ifindex;
@@ -711,7 +711,7 @@
 }
 
 int
-net_iface_mtu_set(openvpn_ne=
t_ctx_t *ctx, const char *iface, uint32_t mtu)
+net_iface_mtu_set(const ope=
nvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sitnl_=
link_req req;
     int ifindex, ret =3D -1;
@@ -742,7 +742,7 @@
 }
 
 int
-=
net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, u=
int8_t *addr)
+net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_=
net_iface_t *iface, uint8_t *addr)
 {
     struct sitnl_link_req req;
     =
int ifindex, ret =3D -1;
@@ -1038,7 +1038,7 @@
 }
 
 int
-net_addr_v4_add(o=
penvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefix=
len)
+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, cons=
t in_addr_t *addr, int prefixlen)
 {
     inet_address_t addr_v4 =3D { 0 };=

     char buf[INET_ADDRSTRLEN];
@@ -1057,7 +1057,7 @@
 }
 
 int
-net_addr_=
v6_add(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *ad=
dr,
+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, const=
 struct in6_addr *addr,
                 int prefixlen)
 {
     inet_addres=
s_t addr_v6 =3D { 0 };
@@ -1077,7 +1077,7 @@
 }
 
 int
-net_addr_v4_del(ope=
nvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixle=
n)
+net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const =
in_addr_t *addr, int prefixlen)
 {
     inet_address_t addr_v4 =3D { 0 };
 =
    char buf[INET_ADDRSTRLEN];
@@ -1096,7 +1096,7 @@
 }
 
 int
-net_addr_v6=
_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr=
,
+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, const s=
truct in6_addr *addr,
                 int prefixlen)
 {
     inet_address_=
t addr_v6 =3D { 0 };
@@ -1116,7 +1116,7 @@
 }
 
 int
-net_addr_ptp_v4_add(o=
penvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_addr=
_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_=
t *local,
                     const in_addr_t *remote)
 {
     inet_addres=
s_t local_v4 =3D { 0 };
@@ -1144,7 +1144,7 @@
 }
 
 int
-net_addr_ptp_v4_de=
l(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_a=
ddr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_ad=
dr_t *local,
                     const in_addr_t *remote)
 {
     inet_add=
ress_t local_v4 =3D { 0 };
@@ -1196,7 +1196,7 @@
 }
 
 int
-net_route_v4_ad=
d(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_add=
r_t *gw,
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *d=
st, int prefixlen, const in_addr_t *gw,
                  const char *iface=
, uint32_t table, int metric)
 {
     const in_addr_t *dst_ptr =3D NULL, *g=
w_ptr =3D NULL;
@@ -1224,7 +1224,7 @@
 }
 
 int
-net_route_v6_add(openvpn_n=
et_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_add=
(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
 =
                 const struct in6_addr *gw, const char *iface, uint32_t tab=
le, int metric)
 {
     inet_address_t dst_v6 =3D { 0 };
@@ -1275,7 +1275,7=
 @@
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *ds=
t, int prefixlen, const in_addr_t *gw,
+net_route_v4_del(const openvpn_net_=
ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
     =
             const char *iface, uint32_t table, int metric)
 {
     inet_ad=
dress_t dst_v4 =3D { 0 };
@@ -1301,7 +1301,7 @@
 }
 
 int
-net_route_v6_del=
(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_ro=
ute_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pr=
efixlen,
                  const struct in6_addr *gw, const char *iface, ui=
nt32_t table, int metric)
 {
     inet_address_t dst_v6 =3D { 0 };
@@ -1328=
,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *i=
face, const char *type, const void *arg)
+net_iface_new(const openvpn_net_c=
tx_t *ctx, const char *iface, const char *type, const void *arg)
 {
     st=
ruct sitnl_link_req req =3D {};
     int ret =3D -1;
@@ -1431,7 +1431,7 @@
=
 }
 
 int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char t=
ype[IFACE_TYPE_LEN_MAX])
+net_iface_type(const openvpn_net_ctx_t *ctx, cons=
t char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_link_req=
 req =3D {};
     int ifindex =3D if_nametoindex(iface);
@@ -1463,7 +1463,7=
 @@
 }
 
 int
-net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
+ne=
t_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
     struct=
 sitnl_link_req req =3D {};
     int ifindex =3D if_nametoindex(iface);

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iee3ff1f5f3ec9331f61=
b0a7f1f3b9ca51575533d
Gerrit-Change-Number: 2106
Gerrit-PatchSet: 1
Gerrit-=
Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--mb5xXDAfI7k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Make parameter openvpn_net_ctx_t const where possible<br><br>A=
fter move the gc_arena inside the various iproute2 related<br>function most=
 of the openvpn_net_ctx_t parameters can be made const=2E<br><br>This does =
not make net_ctx_free and net_ctx_reset const as those<br>functions are int=
ended to modify the net ctx even though none of<br>them do anymore=2E<br><b=
r>Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br=
>M src/openvpn/lladdr=2Eh<br>M src/openvpn/networking=2Eh<br>M src/openvpn/=
networking_freebsd=2Ec<br>M src/openvpn/networking_iproute2=2Ec<br>M src/op=
envpn/networking_sitnl=2Ec<br>6 files changed, 55 insertions(+), 55 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/06/2106/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lladdr=2E=
c b/src/openvpn/lladdr=2Ec</span><br><span>index 195245f=2E=2E8c3be91 10064=
4</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>+++ b/src/op=
envpn/lladdr=2Ec</span><br><span>@@ -15,7 +15,7 @@</span><br><span> </span>=
<br><span> #ifdef TARGET_LINUX</span><br><span> static int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-set_lladdr_linux(openvpn_net_ctx_t *ct=
x, const char *ifname, const char *lladdr)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+set_lladdr_linux(const openvpn_net_ctx_t *ctx, const=
 char *ifname, const char *lladdr)</span><br><span> {</span><br><span>     =
uint8_t addr[OPENVPN_ETH_ALEN];</span><br><span> </span><br><span>@@ -48,7 =
+48,7 @@</span><br><span> #endif /* TARGET_LINUX */</span><br><span> </span=
><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_ll=
addr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const =
struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, const char *ll=
addr, const struct env_set *es)</span><br><span> {</span><br><span>     if =
(!ifname || !lladdr)</span><br><span>     {</span><br><span>diff --git a/sr=
c/openvpn/lladdr=2Eh b/src/openvpn/lladdr=2Eh</span><br><span>index 0c8b416=
=2E=2E9ab6578 100644</span><br><span>--- a/src/openvpn/lladdr=2Eh</span><br=
><span>+++ b/src/openvpn/lladdr=2Eh</span><br><span>@@ -5,5 +5,5 @@</span><=
br><span> #include &quot;misc=2Eh&quot;</span><br><span> #include &quot;net=
working=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, co=
nst char *lladdr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, const char *=
lladdr,</span><br><span>                const struct env_set *es);</span><b=
r><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2E=
h</span><br><span>index 25233c8=2E=2E7ad6e2e 100644</span><br><span>--- a/s=
rc/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh<=
/span><br><span>@@ -101,7 +101,7 @@</span><br><span>  *</span><br><span>  *=
 @return          0 on success, negative error code on error</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_n=
ew(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *ty=
pe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_iface_ne=
w(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const cha=
r *type,</span><br><span>                   const void *arg);</span><br><sp=
an> </span><br><span> /**</span><br><span>@@ -113,7 +113,7 @@</span><br><sp=
an>  *</span><br><span>  * @return          0 on success, a negative error =
code otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int net_iface_type(openvpn_net_ctx_t *ctx, const char *iface,=
 char type[IFACE_TYPE_LEN_MAX]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+int net_iface_type(const openvpn_net_ctx_t *ctx, const char *i=
face, char type[IFACE_TYPE_LEN_MAX]);</span><br><span> </span><br><span> /*=
*</span><br><span>  * Remove an interface</span><br><span>@@ -122,7 +122,7 =
@@</span><br><span>  * @param iface     interface to delete</span><br><span=
>  * @return int 0 on success, negative error code on error</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_de=
l(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int net_iface_del(const openvpn_ne=
t_ctx_t *ctx, const openvpn_net_iface_t *iface);</span><br><span> </span><b=
r><span> /**</span><br><span>  * Bring interface up or down=2E</span><br><s=
pan>@@ -133,7 +133,7 @@</span><br><span>  *</span><br><span>  * @return    =
      0 on success, a negative error code otherwise</span><br><span>  */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_up(openvpn=
_net_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int net_iface_up(const openvpn_net=
_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);</span><br><span> <=
/span><br><span> /**</span><br><span>  * Set the MTU for an interface</span=
><br><span>@@ -144,7 +144,7 @@</span><br><span>  *</span><br><span>  * @ret=
urn          0 on success, a negative error code otherwise</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_mtu=
_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t mtu=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_iface_mtu=
_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32=
_t mtu);</span><br><span> </span><br><span> /**</span><br><span>  * Set the=
 Link Layer (Ethernet) address of the TAP interface</span><br><span>@@ -155=
,7 +155,7 @@</span><br><span>  *</span><br><span>  * @return          0 on =
success, a negative error code otherwise</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int net_addr_ll_set(openvpn_net_ctx=
_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int net_addr_ll_set(const openvpn_ne=
t_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);</span><br><=
span> </span><br><span> /**</span><br><span>  * Add an IPv4 address to an i=
nterface</span><br><span>@@ -167,7 +167,7 @@</span><br><span>  *</span><br>=
<span>  * @return          0 on success, a negative error code otherwise</s=
pan><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int=
 net_addr_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, =
const in_addr_t *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int net_addr_v4_add(const openvpn_net_ctx_t *ctx, const openvpn_net_ifac=
e_t *iface, const in_addr_t *addr,</span><br><span>                     int=
 prefixlen);</span><br><span> </span><br><span> /**</span><br><span>@@ -181=
,7 +181,7 @@</span><br><span>  * @return          0 on success, a negative =
error code otherwise</span><br><span>  */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int net_addr_v6_add(openvpn_net_ctx_t=
 *ctx, const openvpn_net_iface_t *iface,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int net_addr_v6_add(const openvpn_net_ctx_t *ctx, cons=
t openvpn_net_iface_t *iface,</span><br><span>                     const st=
ruct in6_addr *addr, int prefixlen);</span><br><span> </span><br><span> /**=
</span><br><span>@@ -193,7 +193,7 @@</span><br><span>  *</span><br><span>  =
* @return          0 on success, a negative error code otherwise</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_add=
r_v4_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in=
_addr_t *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int n=
et_addr_v4_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *ifa=
ce, const in_addr_t *addr,</span><br><span>                     int prefixl=
en);</span><br><span> </span><br><span> /**</span><br><span>@@ -205,7 +205,=
7 @@</span><br><span>  *</span><br><span>  * @return          0 on success,=
 a negative error code otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int net_addr_v6_del(openvpn_net_ctx_t *ctx,=
 const openvpn_net_iface_t *iface,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int net_addr_v6_del(const openvpn_net_ctx_t *ctx, const open=
vpn_net_iface_t *iface,</span><br><span>                     const struct i=
n6_addr *addr, int prefixlen);</span><br><span> </span><br><span> /**</span=
><br><span>@@ -218,7 +218,7 @@</span><br><span>  *</span><br><span>  * @ret=
urn          0 on success, a negative error code otherwise</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_addr_ptp_=
v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int net_addr_ptp_v4_add(const =
openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,</span><br><span> =
                        const in_addr_t *local, const in_addr_t *remote);</=
span><br><span> </span><br><span> /**</span><br><span>@@ -231,7 +231,7 @@</=
span><br><span>  *</span><br><span>  * @return          0 on success, a neg=
ative error code otherwise</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-int net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, c=
onst openvpn_net_iface_t *iface,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+int net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const op=
envpn_net_iface_t *iface,</span><br><span>                         const in=
_addr_t *local, const in_addr_t *remote);</span><br><span> </span><br><span=
> #endif /* ENABLE_SITNL || ENABLE_IPROUTE */</span><br><span>@@ -251,7 +25=
1,7 @@</span><br><span>  *</span><br><span>  * @return          0 on succes=
s, a negative error code otherwise</span><br><span>  */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int net_route_v4_add(openvpn_net_ctx_t *c=
tx, const in_addr_t *dst, int prefixlen,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int net_route_v4_add(const openvpn_net_ctx_t *ctx, con=
st in_addr_t *dst, int prefixlen,</span><br><span>                      con=
st in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,</span><=
br><span>                      int metric);</span><br><span> </span><br><sp=
an>@@ -269,7 +269,7 @@</span><br><span>  *</span><br><span>  * @return     =
     0 on success, a negative error code otherwise</span><br><span>  */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_route_v6_add(open=
vpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int net_route_v6_add(const openv=
pn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><sp=
an>                      const struct in6_addr *gw, const openvpn_net_iface=
_t *iface, uint32_t table,</span><br><span>                      int metric=
);</span><br><span> </span><br><span>@@ -287,7 +287,7 @@</span><br><span>  =
*</span><br><span>  * @return          0 on success, a negative error code =
otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-int net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst,=
 int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int =
net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pr=
efixlen,</span><br><span>                      const in_addr_t *gw, const o=
penvpn_net_iface_t *iface, uint32_t table,</span><br><span>                =
      int metric);</span><br><span> </span><br><span>@@ -305,7 +305,7 @@</s=
pan><br><span>  *</span><br><span>  * @return          0 on success, a nega=
tive error code otherwise</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-int net_route_v6_del(openvpn_net_ctx_t *ctx, const=
 struct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int net_route_v6_del(const openvpn_net_ctx_t *ctx, const =
struct in6_addr *dst, int prefixlen,</span><br><span>                      =
const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table=
,</span><br><span>                      int metric);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/n=
etworking_freebsd=2Ec</span><br><span>index 04051a6=2E=2E88fd5c0 100644</sp=
an><br><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><span>+++ b=
/src/openvpn/networking_freebsd=2Ec</span><br><span>@@ -82,28 +82,28 @@</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-net_route_v4_add(openvpn_net_ctx_t *ctx, c=
onst in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+net_route_v4_add(const openvpn_net_ctx=
_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><b=
r><span>                  const char *iface, uint32_t table, int metric)</s=
pan><br><span> {</span><br><span>     return net_route_v4(&quot;add&quot;, =
dst, prefixlen, gw, iface, table, metric);</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, in=
t prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_rou=
te_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pre=
fixlen,</span><br><span>                  const struct in6_addr *gw, const =
char *iface, uint32_t table, int metric)</span><br><span> {</span><br><span=
>     return net_route_v6(&quot;add&quot;, dst, prefixlen, gw, iface, table=
, metric);</span><br><span> }</span><br><span> </span><br><span> int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_del(openvpn_net=
_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_del(const o=
penvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t=
 *gw,</span><br><span>                  const char *iface, uint32_t table, =
int metric)</span><br><span> {</span><br><span>     return net_route_v4(&qu=
ot;del&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><span> }=
</span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6=
_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr=
 *dst, int prefixlen,</span><br><span>                  const struct in6_ad=
dr *gw, const char *iface, uint32_t table, int metric)</span><br><span> {</=
span><br><span>     return net_route_v6(&quot;del&quot;, dst, prefixlen, gw=
, iface, table, metric);</span><br><span>diff --git a/src/openvpn/networkin=
g_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>index =
4685465=2E=2E68e6dfe 100644</span><br><span>--- a/src/openvpn/networking_ip=
route2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span>=
<br><span>@@ -59,7 +59,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_n=
ew(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void =
*arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(=
const openvpn_net_ctx_t *ctx, const char *iface, const char *type, const vo=
id *arg)</span><br><span> {</span><br><span>     struct argv argv =3D argv_=
new();</span><br><span> </span><br><span>@@ -73,7 +73,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-net_iface_type(openvpn_net_ctx_t *ctx, const char *ifac=
e, char type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+net_iface_type(const openvpn_net_ctx_t *ctx, const char *ifac=
e, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><br><span>     /=
* not supported by iproute2 */</span><br><span>     msg(M_WARN, &quot;%s: o=
peration not supported by iproute2 backend&quot;, __func__);</span><br><spa=
n>@@ -81,7 +81,7 @@</span><br><span> }</span><br><span> </span><br><span> i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_del(openv=
pn_net_ctx_t *ctx, const char *iface)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+net_iface_del(const openvpn_net_ctx_t *ctx, const char *i=
face)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new=
();</span><br><span> </span><br><span>@@ -94,7 +94,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bo=
ol up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_up(=
const openvpn_net_ctx_t *ctx, const char *iface, bool up)</span><br><span> =
{</span><br><span>     struct argv argv =3D argv_new();</span><br><span> </=
span><br><span>@@ -108,7 +108,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_=
iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_mtu_set(const =
openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</span><br><span> {=
</span><br><span>     struct argv argv =3D argv_new();</span><br><span> </s=
pan><br><span>@@ -122,7 +122,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_a=
ddr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_=
t *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_ll=
_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_=
t *addr)</span><br><span> {</span><br><span>     struct argv argv =3D argv_=
new();</span><br><span>     int ret =3D 0;</span><br><span>@@ -142,7 +142,7=
 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-net_addr_v4_add(openvpn_net_ctx_t *=
ctx, const char *iface, const in_addr_t *addr, int prefixlen)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+net_addr_v4_add(const openvpn_net=
_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)</span=
><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -160,7 +1=
60,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_v6_add(openvpn_net_ctx=
_t *ctx, const char *iface, const struct in6_addr *addr,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+net_addr_v6_add(const openvpn_net_ctx_=
t *ctx, const char *iface, const struct in6_addr *addr,</span><br><span>   =
              int prefixlen)</span><br><span> {</span><br><span>     struct=
 argv argv =3D argv_new();</span><br><span>@@ -179,7 +179,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-net_addr_v4_del(openvpn_net_ctx_t *ctx, const char =
*iface, const in_addr_t *addr, int prefixlen)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+net_addr_v4_del(const openvpn_net_ctx_t *ctx, con=
st char *iface, const in_addr_t *addr, int prefixlen)</span><br><span> {</s=
pan><br><span>     struct argv argv =3D argv_new();</span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span>@@ -198,7 +198,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-net_addr_v6_del(openvpn_net_ctx_t *ctx, const c=
har *iface, const struct in6_addr *addr,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const ch=
ar *iface, const struct in6_addr *addr,</span><br><span>                 in=
t prefixlen)</span><br><span> {</span><br><span>     struct argv argv =3D a=
rgv_new();</span><br><span>@@ -217,7 +217,7 @@</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface, cons=
t in_addr_t *local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const =
in_addr_t *local,</span><br><span>                     const in_addr_t *rem=
ote)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new(=
);</span><br><span>@@ -237,7 +237,7 @@</span><br><span> }</span><br><span> =
</span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_add=
r_t *local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr=
_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_=
t *local,</span><br><span>                     const in_addr_t *remote)</sp=
an><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span=
><br><span>@@ -257,7 +257,7 @@</span><br><span> }</span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_rout=
e_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const=
 in_addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_=
route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefix=
len, const in_addr_t *gw,</span><br><span>                  const char *ifa=
ce, uint32_t table, int metric)</span><br><span> {</span><br><span>     str=
uct argv argv =3D argv_new();</span><br><span>@@ -297,7 +297,7 @@</span><br=
><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-net_route_v6_add(openvpn_net_ctx_t *ctx, const s=
truct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct=
 in6_addr *dst, int prefixlen,</span><br><span>                  const stru=
ct in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><=
span> {</span><br><span>     struct argv argv =3D argv_new();</span><br><sp=
an>@@ -332,7 +332,7 @@</span><br><span> }</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_del=
(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr=
_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4=
_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, con=
st in_addr_t *gw,</span><br><span>                  const char *iface, uint=
32_t table, int metric)</span><br><span> {</span><br><span>     struct argv=
 argv =3D argv_new();</span><br><span>@@ -360,7 +360,7 @@</span><br><span> =
}</span><br><span> </span><br><span> int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in=
6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_add=
r *dst, int prefixlen,</span><br><span>                  const struct in6_a=
ddr *gw, const char *iface, uint32_t table, int metric)</span><br><span> {<=
/span><br><span>     struct argv argv =3D argv_new();</span><br><span>diff =
--git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec=
</span><br><span>index 0c99d38=2E=2E97ff7bd 100644</span><br><span>--- a/sr=
c/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking=
_sitnl=2Ec</span><br><span>@@ -669,7 +669,7 @@</span><br><span> #ifdef ENAB=
LE_SITNL</span><br><span> </span><br><span> int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-net_iface_up(openvpn_net_ctx_t *ctx, const char *=
iface, bool up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_=
iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)</span><b=
r><span> {</span><br><span>     struct sitnl_link_req req;</span><br><span>=
     int ifindex;</span><br><span>@@ -711,7 +711,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface,=
 uint32_t mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_i=
face_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)=
</span><br><span> {</span><br><span>     struct sitnl_link_req req;</span><=
br><span>     int ifindex, ret =3D -1;</span><br><span>@@ -742,7 +742,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-net_addr_ll_set(openvpn_net_ctx_t *ctx,=
 const openvpn_net_iface_t *iface, uint8_t *addr)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+net_addr_ll_set(const openvpn_net_ctx_t *ctx,=
 const openvpn_net_iface_t *iface, uint8_t *addr)</span><br><span> {</span>=
<br><span>     struct sitnl_link_req req;</span><br><span>     int ifindex,=
 ret =3D -1;</span><br><span>@@ -1038,7 +1038,7 @@</span><br><span> }</span=
><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, cons=
t in_addr_t *addr, int prefixlen)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *ifa=
ce, const in_addr_t *addr, int prefixlen)</span><br><span> {</span><br><spa=
n>     inet_address_t addr_v4 =3D { 0 };</span><br><span>     char buf[INET=
_ADDRSTRLEN];</span><br><span>@@ -1057,7 +1057,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface, con=
st struct in6_addr *addr,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, cons=
t struct in6_addr *addr,</span><br><span>                 int prefixlen)</s=
pan><br><span> {</span><br><span>     inet_address_t addr_v6 =3D { 0 };</sp=
an><br><span>@@ -1077,7 +1077,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_=
addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *add=
r, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ne=
t_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_add=
r_t *addr, int prefixlen)</span><br><span> {</span><br><span>     inet_addr=
ess_t addr_v4 =3D { 0 };</span><br><span>     char buf[INET_ADDRSTRLEN];</s=
pan><br><span>@@ -1096,7 +1096,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net=
_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_ad=
dr *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_v=
6_del(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_add=
r *addr,</span><br><span>                 int prefixlen)</span><br><span> {=
</span><br><span>     inet_address_t addr_v6 =3D { 0 };</span><br><span>@@ =
-1116,7 +1116,7 @@</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_ptp_v4_add(=
openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_ptp_v4_add(const op=
envpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br>=
<span>                     const in_addr_t *remote)</span><br><span> {</spa=
n><br><span>     inet_address_t local_v4 =3D { 0 };</span><br><span>@@ -114=
4,7 +1144,7 @@</span><br><span> }</span><br><span> </span><br><span> int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_ptp_v4_del(open=
vpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+net_addr_ptp_v4_del(const openvp=
n_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br><spa=
n>                     const in_addr_t *remote)</span><br><span> {</span><b=
r><span>     inet_address_t local_v4 =3D { 0 };</span><br><span>@@ -1196,7 =
+1196,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_add(openvpn_net=
_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_add(const o=
penvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t=
 *gw,</span><br><span>                  const char *iface, uint32_t table, =
int metric)</span><br><span> {</span><br><span>     const in_addr_t *dst_pt=
r =3D NULL, *gw_ptr =3D NULL;</span><br><span>@@ -1224,7 +1224,7 @@</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-net_route_v6_add(openvpn_net_ctx_t *ctx, const=
 struct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+net_route_v6_add(const openvpn_net_ctx_t *ctx, const stru=
ct in6_addr *dst, int prefixlen,</span><br><span>                  const st=
ruct in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br=
><span> {</span><br><span>     inet_address_t dst_v6 =3D { 0 };</span><br><=
span>@@ -1275,7 +1275,7 @@</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4=
_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_=
addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_rout=
e_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,=
 const in_addr_t *gw,</span><br><span>                  const char *iface, =
uint32_t table, int metric)</span><br><span> {</span><br><span>     inet_ad=
dress_t dst_v4 =3D { 0 };</span><br><span>@@ -1301,7 +1301,7 @@</span><br><=
span> }</span><br><span> </span><br><span> int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const str=
uct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct i=
n6_addr *dst, int prefixlen,</span><br><span>                  const struct=
 in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><sp=
an> {</span><br><span>     inet_address_t dst_v6 =3D { 0 };</span><br><span=
>@@ -1328,7 +1328,7 @@</span><br><span> </span><br><span> </span><br><span>=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(ope=
nvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(const =
openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *ar=
g)</span><br><span> {</span><br><span>     struct sitnl_link_req req =3D {}=
;</span><br><span>     int ret =3D -1;</span><br><span>@@ -1431,7 +1431,7 @=
@</span><br><span> }</span><br><span> </span><br><span> int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-net_iface_type(openvpn_net_ctx_t *ctx=
, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+net_iface_type(const openvpn_net_ctx_t *c=
tx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</s=
pan><br><span>     struct sitnl_link_req req =3D {};</span><br><span>     i=
nt ifindex =3D if_nametoindex(iface);</span><br><span>@@ -1463,7 +1463,7 @@=
</span><br><span> }</span><br><span> </span><br><span> int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-net_iface_del(openvpn_net_ctx_t *ctx, =
const char *iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
et_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)</span><br><sp=
an> {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><spa=
n>     int ifindex =3D if_nametoindex(iface);</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail=
">change 2106</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
106?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2106 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--mb5xXDAfI7k=--


--===============0111964560654765413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0111964560654765413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0111964560654765413==--

