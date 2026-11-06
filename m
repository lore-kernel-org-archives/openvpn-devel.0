Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559CD606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tkk/5lpP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mgRLjImj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NGUrODxk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dfl9ai+m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MtvCRl+ADpUfZcHNH9pMv1eHMxWY03y0T45b+M4fBKg=; b=Tkk/5lpPLlRYaNKwPgLHYwbZHW
	wwyxhqMANcilZY8gZ3VvPJ+wpnCpm8hYYTvy+g+cKSHQwgY7tF+KRi8zYjeSBcMTsEhkLvJ6vioxN
	76aOVETrY+M6Ob3JUdeYvGj34eNig4CyfkJZ+YZgR0X5AOfUFPadIje+t6TeQ4I073k4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPRuu-000000001bQ-3gyQ;
	Fri, 06 Nov 2026 21:56:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPRus-000000001bI-2BKp
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 21:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=27cb1FzgpRAai2Ni2CUZtTQTODiAmvdyEC5bZGjyzpM=; b=mgRLjImjXp7XOFO6hnOhfFVSV0
 rgNQDJ0kl6CqDtHV9EWzQFNwdgDxlcNrf0xTuDRhQD3YOL/5wwWhNNO/5vw+EnWBGFkuUfbbDBVjg
 5lVIFwksn07pwpcsFAZVarfEDtE7BSTKGEyaXqJnmenvyds1VD5y/9xyKycF82HFAMtc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=27cb1FzgpRAai2Ni2CUZtTQTODiAmvdyEC5bZGjyzpM=; b=NGUrODxkGPJ9BFQo4T5Zpl/d7u
 AoMVh7Y48Xc4PDgK9hYYGfCVC2hzafkzPE8gUSIrq07M+cKqZ0rBnQ7DKYmg431JH73K2eISfwDd8
 bvvunx0hgG4/fk9pbMQSUxwTOhe5l62Ni0Ipmh8pYxGlyTTu1/FK+CDR/fF8RE/T1ctQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPRum-000000008A9-28Yp for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 21:56:08 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so12852905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 13:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794002158; x=1794606958; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=27cb1FzgpRAai2Ni2CUZtTQTODiAmvdyEC5bZGjyzpM=;
 b=dfl9ai+m02ftVY4sQY5UOuNhDperWla92G3NRDurVs574VqUh/u2B8no7CllsISBkV
 2Bdg6XGp+wDHCavMLrSWQkNTq/6uG5DsthRfceJ48fSgACRt9urYCGFrNr8hSlFrPry2
 50oX8+vh+aB+CkQTGZBgJr0oa4CcjS4i1g3boj1j2ZcVDiaiRzAqu+o3xw/vuyey6gT2
 pF1w1FTKlcBKALk+1syvP2lfH12BHZzBb7IsSsBN06xlwd9Na2IldV4SBLq68HqidJze
 Edw/Kndyaxj24RsdmYtdqQvSnbRmtyXzcE5QBHlBxIl+h5z2x9Btv1oOqsm37Fj3UJ+w
 +/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002158; x=1794606958;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=27cb1FzgpRAai2Ni2CUZtTQTODiAmvdyEC5bZGjyzpM=;
 b=TubaK0EISUMy11+O6m64JpnvMNPOiNZCGjkN04Vf7thXF0LtF6e1trxpbR3d9D8k+f
 dUr9eiW+VkWdD+xtN9r4xMfAeu1klB0qunCQ1RkXDbIcsHdnmJS/FGtAGXR17ZZr5gje
 VWKeEo4FFSrbGyZTC84WTqakjLLi5b2z25oaWavah5FRKrJmw8ZvzFkN+MmoNeyZKGpW
 rigY3iUlJa97kGhmwL9/oQoIaiFZ66ykB2+iz1rwR+6FKoAqQVuG+W9OflpsVXyT9KtC
 TNlrAavtjIlnr2tciW3QR8G4Mjdy6bS2HngW3BiXNrrGG8o7kYcUt1+kAKlqh58KKqP4
 +5bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByioP+/qBvvUazTUjRNXhhpX7I1i6SXX/IYzMn01Q2r26+mhtRDzuDGr31mAjPqV7wuU/pRPXq+4vuckAaI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8jmR6C3JKfwslml9SFSaz/LSG4X8w8DevyQM9CJgcFfWmdVqoN
 1r9A72ru2GqsOxk7vg7lvb2+cp68hWsI+nvGkYkaREdp+Jib9TF4vDAo0gx2U0iN2a7Wmwf17Yj
 RvPoPnEYLUivDXiX+KVdWKVA0AL9mWw0sYmwRmG6FtBRXxcz9AWHUwtCFA+XJdfovXHKU
X-Gm-Gg: AYBFou2t/FfY4uSywPUYVo856+tGqRnfsR7OkzdKbnEnLhdtvA82iDWz0XgUzVNUhaf
 ZFppJprPcIlTAy6/To3heExNtjekFqTXA+2nSRlfGWCmF09am269vsvo4EclrCTEaqDtt+xYKzn
 PvmwbeFOJs0nAj6sV7wcpfWsdLYIoCh6LlqKDbedaS7eVj3QRKAsLvrSURx/8Ec17HVYxzZA0Y6
 SerlwdPyu4+xGvjU4OhYfoFTm6ls3rnJ21HFfTLLr4T/jXv2WO1waqtkWa84zbygq3BcfMuxbeT
 EqjUcIafDppaYsN3TI9us3x5skPvmEFOF2KQ0T55OH+V9XwtQua/8L+NSuZOj+BrnljKRnKveMt
 onaFTvBXT39/ErGyZ2oT6g7SlcCAWZVWgVHBW7sdYFTuTxOtJflLjHkep3lJdvFqakjIOHdkQE8
 J87fAVsKFWqjS6pmoXZESi2TUugjCe6C4DYQesdB42EFwZaW5jfvqlzbvZA1h0JXXXP30ifEQPu
 VpDy7no9CFoC/7F1ttfGIvbC6VkC5LTLlgiVGBtjfjxK6CLsf+Wz6OIY48L0SGRtaXPyDwurc6c
 ZTZEisgR2a9J40ttlQtQHg4Qt4Fu/i4st/ONhukjGzpS+HOn85wIH+dE8WOEm5p2bDZXOCfexZk
 2cksN7eR1jlJpT9CRorypmWNJEXXEHIKZ0ln+Kl2v46A6x6oCPqVLZPgVM6cL4oE01ttobUdRGe
 OWlYbkp+QYST8h4g==
X-Received: by 2002:a05:600c:818e:b0:4b3:9540:47a6 with SMTP id
 5b1f17b1804b1-4b6dff86e38mr63251765e9.28.1794002157633; 
 Fri, 06 Nov 2026 13:55:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e2e9ad95sm11109065e9.3.2026.11.06.13.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:55:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 21:55:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
X-Gerrit-Change-Number: 2106
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2106?usp=email>
X-Gerrit-Commit: 5b08a76c1a3215c9c927909e695ccd8e83eb6895
In-Reply-To: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
References: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkllZTNmZjFmNWYzZWM5MzMxZjYxYjBhN2YxZjNiOWNhNTE1NzU1MzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85e2c00cdcd34dd0ed50aa678f20aad623c52be3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPRum-000000008A9-28Yp
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
Content-Type: multipart/mixed; boundary="===============5637917685878665344=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5637917685878665344==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mkmZGgEt4fI="; charset=UTF-8

--mkmZGgEt4fI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2106?usp=3Demail )

Change subject: Make parameter openvpn_net_=
ctx_t const where possible
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Make parameter openvpn_net_ctx_t const where possible

After =
move the gc_arena inside the various iproute2 related
function most of the =
openvpn_net_ctx_t parameters can be made const=2E

This does not make net_c=
tx_free and net_ctx_reset const as those
functions are intended to modify t=
he net ctx even though none of
them do anymore=2E

Change-Id: Iee3ff1f5f3ec=
9331f61b0a7f1f3b9ca51575533d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2106
Message-Id: <20261103193058=2E14082-1=
-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20=
261103193058=2E14082-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
M src/openvpn/lladdr=
=2Eh
M src/openvpn/networking=2Eh
M src/openvpn/networking_freebsd=2Ec
M sr=
c/openvpn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
6 file=
s changed, 55 insertions(+), 55 deletions(-)




diff --git a/src/openvpn/l=
laddr=2Ec b/src/openvpn/lladdr=2Ec
index 554975c=2E=2E8bd572a 100644
--- a/=
src/openvpn/lladdr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -15,7 +15,7 @@
 
 #i=
fdef TARGET_LINUX
 static int
-set_lladdr_linux(openvpn_net_ctx_t *ctx, con=
st char *ifname, const char *lladdr)
+set_lladdr_linux(const openvpn_net_ct=
x_t *ctx, const char *ifname, const char *lladdr)
 {
     uint8_t addr[OPEN=
VPN_ETH_ALEN];
 
@@ -48,7 +48,7 @@
 #endif /* TARGET_LINUX */
 
 int
-set_l=
laddr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const=
 struct env_set *es)
+set_lladdr(const openvpn_net_ctx_t *ctx, const char *=
ifname, const char *lladdr, const struct env_set *es)
 {
     if (!ifname |=
| !lladdr)
     {
diff --git a/src/openvpn/lladdr=2Eh b/src/openvpn/lladdr=
=2Eh
index 0c8b416=2E=2E9ab6578 100644
--- a/src/openvpn/lladdr=2Eh
+++ b/s=
rc/openvpn/lladdr=2Eh
@@ -5,5 +5,5 @@
 #include "misc=2Eh"
 #include "netwo=
rking=2Eh"
 
-int set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, co=
nst char *lladdr,
+int set_lladdr(const openvpn_net_ctx_t *ctx, const char =
*ifname, const char *lladdr,
                const struct env_set *es);
dif=
f --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index 252=
33c8=2E=2E7ad6e2e 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn=
/networking=2Eh
@@ -101,7 +101,7 @@
  *
  * @return          0 on success, =
negative error code on error
  */
-int net_iface_new(openvpn_net_ctx_t *ctx=
, const openvpn_net_iface_t *iface, const char *type,
+int net_iface_new(co=
nst openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *t=
ype,
                   const void *arg);
 
 /**
@@ -113,7 +113,7 @@
  *
  =
* @return          0 on success, a negative error code otherwise
  */
-int =
net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_T=
YPE_LEN_MAX]);
+int net_iface_type(const openvpn_net_ctx_t *ctx, const char=
 *iface, char type[IFACE_TYPE_LEN_MAX]);
 
 /**
  * Remove an interface
@@ =
-122,7 +122,7 @@
  * @param iface     interface to delete
  * @return int 0=
 on success, negative error code on error
  */
-int net_iface_del(openvpn_n=
et_ctx_t *ctx, const openvpn_net_iface_t *iface);
+int net_iface_del(const =
openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);
 
 /**
  * Bring=
 interface up or down=2E
@@ -133,7 +133,7 @@
  *
  * @return          0 on =
success, a negative error code otherwise
  */
-int net_iface_up(openvpn_net=
_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);
+int net_iface_up(=
const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);
 =

 /**
  * Set the MTU for an interface
@@ -144,7 +144,7 @@
  *
  * @return =
         0 on success, a negative error code otherwise
  */
-int net_iface_=
mtu_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t =
mtu);
+int net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const openvpn_ne=
t_iface_t *iface, uint32_t mtu);
 
 /**
  * Set the Link Layer (Ethernet) a=
ddress of the TAP interface
@@ -155,7 +155,7 @@
  *
  * @return          0 =
on success, a negative error code otherwise
  */
-int net_addr_ll_set(openv=
pn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);
+int n=
et_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *ifa=
ce, uint8_t *addr);
 
 /**
  * Add an IPv4 address to an interface
@@ -167,=
7 +167,7 @@
  *
  * @return          0 on success, a negative error code ot=
herwise
  */
-int net_addr_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net=
_iface_t *iface, const in_addr_t *addr,
+int net_addr_v4_add(const openvpn_=
net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *addr,
  =
                   int prefixlen);
 
 /**
@@ -181,7 +181,7 @@
  * @return  =
        0 on success, a negative error code otherwise
  */
 
-int net_addr_=
v6_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_a=
ddr_v6_add(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
=
                     const struct in6_addr *addr, int prefixlen);
 
 /**
@@=
 -193,7 +193,7 @@
  *
  * @return          0 on success, a negative error c=
ode otherwise
  */
-int net_addr_v4_del(openvpn_net_ctx_t *ctx, const openv=
pn_net_iface_t *iface, const in_addr_t *addr,
+int net_addr_v4_del(const op=
envpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *ad=
dr,
                     int prefixlen);
 
 /**
@@ -205,7 +205,7 @@
  *
  *=
 @return          0 on success, a negative error code otherwise
  */
-int n=
et_addr_v6_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+i=
nt net_addr_v6_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t =
*iface,
                     const struct in6_addr *addr, int prefixlen);
 =

 /**
@@ -218,7 +218,7 @@
  *
  * @return          0 on success, a negative=
 error code otherwise
  */
-int net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx,=
 const openvpn_net_iface_t *iface,
+int net_addr_ptp_v4_add(const openvpn_n=
et_ctx_t *ctx, const openvpn_net_iface_t *iface,
                         c=
onst in_addr_t *local, const in_addr_t *remote);
 
 /**
@@ -231,7 +231,7 @@=

  *
  * @return          0 on success, a negative error code otherwise
  *=
/
-int net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_=
t *iface,
+int net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const open=
vpn_net_iface_t *iface,
                         const in_addr_t *local, co=
nst in_addr_t *remote);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE */
@@ -=
251,7 +251,7 @@
  *
  * @return          0 on success, a negative error cod=
e otherwise
  */
-int net_route_v4_add(openvpn_net_ctx_t *ctx, const in_add=
r_t *dst, int prefixlen,
+int net_route_v4_add(const openvpn_net_ctx_t *ctx=
, const in_addr_t *dst, int prefixlen,
                      const in_addr_=
t *gw, const openvpn_net_iface_t *iface, uint32_t table,
                  =
    int metric);
 
@@ -269,7 +269,7 @@
  *
  * @return          0 on succes=
s, a negative error code otherwise
  */
-int net_route_v6_add(openvpn_net_c=
tx_t *ctx, const struct in6_addr *dst, int prefixlen,
+int net_route_v6_add=
(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
 =
                     const struct in6_addr *gw, const openvpn_net_iface_t *=
iface, uint32_t table,
                      int metric);
 
@@ -287,7 +287,=
7 @@
  *
  * @return          0 on success, a negative error code otherwise=

  */
-int net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, i=
nt prefixlen,
+int net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_=
addr_t *dst, int prefixlen,
                      const in_addr_t *gw, cons=
t openvpn_net_iface_t *iface, uint32_t table,
                      int met=
ric);
 
@@ -305,7 +305,7 @@
  *
  * @return          0 on success, a negati=
ve error code otherwise
  */
-int net_route_v6_del(openvpn_net_ctx_t *ctx, =
const struct in6_addr *dst, int prefixlen,
+int net_route_v6_del(const open=
vpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
            =
          const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint=
32_t table,
                      int metric);
 
diff --git a/src/openvpn/n=
etworking_freebsd=2Ec b/src/openvpn/networking_freebsd=2Ec
index 04051a6=2E=
=2E88fd5c0 100644
--- a/src/openvpn/networking_freebsd=2Ec
+++ b/src/openvp=
n/networking_freebsd=2Ec
@@ -82,28 +82,28 @@
 }
 
 int
-net_route_v4_add(op=
envpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t =
*gw,
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, =
int prefixlen, const in_addr_t *gw,
                  const char *iface, ui=
nt32_t table, int metric)
 {
     return net_route_v4("add", dst, prefixlen=
, gw, iface, table, metric);
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t =
*ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_add(const op=
envpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
          =
        const struct in6_addr *gw, const char *iface, uint32_t table, int m=
etric)
 {
     return net_route_v6("add", dst, prefixlen, gw, iface, table,=
 metric);
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr=
_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_del(const openvp=
n_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,=

                  const char *iface, uint32_t table, int metric)
 {
     r=
eturn net_route_v4("del", dst, prefixlen, gw, iface, table, metric);
 }
 
 =
int
-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, i=
nt prefixlen,
+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct =
in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, =
const char *iface, uint32_t table, int metric)
 {
     return net_route_v6(=
"del", dst, prefixlen, gw, iface, table, metric);
diff --git a/src/openvpn/=
networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index 7a0f4f7=
=2E=2Ed987478 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/op=
envpn/networking_iproute2=2Ec
@@ -59,7 +59,7 @@
 }
 
 int
-net_iface_new(op=
envpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)=

+net_iface_new(const openvpn_net_ctx_t *ctx, const char *iface, const char=
 *type, const void *arg)
 {
     struct argv argv =3D argv_new();
 
@@ -73,=
7 +73,7 @@
 }
 
 int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *if=
ace, char type[IFACE_TYPE_LEN_MAX])
+net_iface_type(const openvpn_net_ctx_t=
 *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     /* not sup=
ported by iproute2 */
     msg(M_WARN, "%s: operation not supported by ipro=
ute2 backend", __func__);
@@ -81,7 +81,7 @@
 }
 
 int
-net_iface_del(openvp=
n_net_ctx_t *ctx, const char *iface)
+net_iface_del(const openvpn_net_ctx_t=
 *ctx, const char *iface)
 {
     struct argv argv =3D argv_new();
 
@@ -94=
,7 +94,7 @@
 }
 
 int
-net_iface_up(openvpn_net_ctx_t *ctx, const char *ifa=
ce, bool up)
+net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface,=
 bool up)
 {
     struct argv argv =3D argv_new();
 
@@ -108,7 +108,7 @@
 }=

 
 int
-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint3=
2_t mtu)
+net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface=
, uint32_t mtu)
 {
     struct argv argv =3D argv_new();
 
@@ -122,7 +122,7=
 @@
 }
 
 int
-net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_if=
ace_t *iface, uint8_t *addr)
+net_addr_ll_set(const openvpn_net_ctx_t *ctx,=
 const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct argv argv =
=3D argv_new();
     int ret =3D 0;
@@ -142,7 +142,7 @@
 }
 
 int
-net_addr=
_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, i=
nt prefixlen)
+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *if=
ace, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv =3D arg=
v_new();
 
@@ -158,7 +158,7 @@
 }
 
 int
-net_addr_v6_add(openvpn_net_ctx_t=
 *ctx, const char *iface, const struct in6_addr *addr,
+net_addr_v6_add(con=
st openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
=
                 int prefixlen)
 {
     struct argv argv =3D argv_new();
@@=
 -174,7 +174,7 @@
 }
 
 int
-net_addr_v4_del(openvpn_net_ctx_t *ctx, const =
char *iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_del(const o=
penvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefix=
len)
 {
     struct argv argv =3D argv_new();
     const char *addr_str =3D=
 print_in_addr_t(*addr, 0, &argv=2Egc);
@@ -190,7 +190,7 @@
 }
 
 int
-net_=
addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_add=
r *addr,
+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, =
const struct in6_addr *addr,
                 int prefixlen)
 {
     struct=
 argv argv =3D argv_new();
@@ -206,7 +206,7 @@
 }
 
 int
-net_addr_ptp_v4_a=
dd(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_=
addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_a=
ddr_t *local,
                     const in_addr_t *remote)
 {
     struct =
argv argv =3D argv_new();
@@ -224,7 +224,7 @@
 }
 
 int
-net_addr_ptp_v4_de=
l(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_a=
ddr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_ad=
dr_t *local,
                     const in_addr_t *remote)
 {
     struct a=
rgv argv =3D argv_new();
@@ -242,7 +242,7 @@
 }
 
 int
-net_route_v4_add(op=
envpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t =
*gw,
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, =
int prefixlen, const in_addr_t *gw,
                  const char *iface, ui=
nt32_t table, int metric)
 {
     struct argv argv =3D argv_new();
@@ -280,=
7 +280,7 @@
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struc=
t in6_addr *dst, int prefixlen,
+net_route_v6_add(const openvpn_net_ctx_t *=
ctx, const struct in6_addr *dst, int prefixlen,
                  const str=
uct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     st=
ruct argv argv =3D argv_new();
@@ -313,7 +313,7 @@
 }
 
 int
-net_route_v4_=
del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_a=
ddr_t *gw,
+net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t =
*dst, int prefixlen, const in_addr_t *gw,
                  const char *ifa=
ce, uint32_t table, int metric)
 {
     struct argv argv =3D argv_new();
@@=
 -339,7 +339,7 @@
 }
 
 int
-net_route_v6_del(openvpn_net_ctx_t *ctx, const=
 struct in6_addr *dst, int prefixlen,
+net_route_v6_del(const openvpn_net_c=
tx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  con=
st struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
 =
    struct argv argv =3D argv_new();
diff --git a/src/openvpn/networking_si=
tnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 0c99d38=2E=2E97ff7bd 10064=
4
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=
=2Ec
@@ -669,7 +669,7 @@
 #ifdef ENABLE_SITNL
 
 int
-net_iface_up(openvpn_=
net_ctx_t *ctx, const char *iface, bool up)
+net_iface_up(const openvpn_net=
_ctx_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;=

     int ifindex;
@@ -711,7 +711,7 @@
 }
 
 int
-net_iface_mtu_set(openvpn=
_net_ctx_t *ctx, const char *iface, uint32_t mtu)
+net_iface_mtu_set(const =
openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sit=
nl_link_req req;
     int ifindex, ret =3D -1;
@@ -742,7 +742,7 @@
 }
 
 in=
t
-net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface=
, uint8_t *addr)
+net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openv=
pn_net_iface_t *iface, uint8_t *addr)
 {
     struct sitnl_link_req req;
  =
   int ifindex, ret =3D -1;
@@ -1038,7 +1038,7 @@
 }
 
 int
-net_addr_v4_ad=
d(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int pre=
fixlen)
+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, c=
onst in_addr_t *addr, int prefixlen)
 {
     inet_address_t addr_v4 =3D { 0=
 };
     char buf[INET_ADDRSTRLEN];
@@ -1057,7 +1057,7 @@
 }
 
 int
-net_ad=
dr_v6_add(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr =
*addr,
+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, co=
nst struct in6_addr *addr,
                 int prefixlen)
 {
     inet_add=
ress_t addr_v6 =3D { 0 };
@@ -1077,7 +1077,7 @@
 }
 
 int
-net_addr_v4_del(=
openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefi=
xlen)
+net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, con=
st in_addr_t *addr, int prefixlen)
 {
     inet_address_t addr_v4 =3D { 0 }=
;
     char buf[INET_ADDRSTRLEN];
@@ -1096,7 +1096,7 @@
 }
 
 int
-net_addr=
_v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *a=
ddr,
+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, cons=
t struct in6_addr *addr,
                 int prefixlen)
 {
     inet_addre=
ss_t addr_v6 =3D { 0 };
@@ -1116,7 +1116,7 @@
 }
 
 int
-net_addr_ptp_v4_ad=
d(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_a=
ddr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_ad=
dr_t *local,
                     const in_addr_t *remote)
 {
     inet_add=
ress_t local_v4 =3D { 0 };
@@ -1144,7 +1144,7 @@
 }
 
 int
-net_addr_ptp_v4=
_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+ne=
t_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in=
_addr_t *local,
                     const in_addr_t *remote)
 {
     inet_=
address_t local_v4 =3D { 0 };
@@ -1196,7 +1196,7 @@
 }
 
 int
-net_route_v4=
_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_=
addr_t *gw,
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t=
 *dst, int prefixlen, const in_addr_t *gw,
                  const char *if=
ace, uint32_t table, int metric)
 {
     const in_addr_t *dst_ptr =3D NULL,=
 *gw_ptr =3D NULL;
@@ -1224,7 +1224,7 @@
 }
 
 int
-net_route_v6_add(openvp=
n_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_=
add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen=
,
                  const struct in6_addr *gw, const char *iface, uint32_t =
table, int metric)
 {
     inet_address_t dst_v6 =3D { 0 };
@@ -1275,7 +127=
5,7 @@
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t =
*dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_del(const openvpn_n=
et_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
  =
                const char *iface, uint32_t table, int metric)
 {
     inet=
_address_t dst_v4 =3D { 0 };
@@ -1301,7 +1301,7 @@
 }
 
 int
-net_route_v6_=
del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net=
_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int=
 prefixlen,
                  const struct in6_addr *gw, const char *iface,=
 uint32_t table, int metric)
 {
     inet_address_t dst_v6 =3D { 0 };
@@ -1=
328,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char=
 *iface, const char *type, const void *arg)
+net_iface_new(const openvpn_ne=
t_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 {
    =
 struct sitnl_link_req req =3D {};
     int ret =3D -1;
@@ -1431,7 +1431,7 =
@@
 }
 
 int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, cha=
r type[IFACE_TYPE_LEN_MAX])
+net_iface_type(const openvpn_net_ctx_t *ctx, c=
onst char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_link_=
req req =3D {};
     int ifindex =3D if_nametoindex(iface);
@@ -1463,7 +146=
3,7 @@
 }
 
 int
-net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
=
+net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
     str=
uct sitnl_link_req req =3D {};
     int ifindex =3D if_nametoindex(iface);
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iee3ff1f5f3ec9331f61=
b0a7f1f3b9ca51575533d
Gerrit-Change-Number: 2106
Gerrit-PatchSet: 2
Gerrit-=
Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Q=
uartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--mkmZGgEt4fI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2106?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Make parameter openvpn_net_ctx_t c=
onst where possible<br><br>After move the gc_arena inside the various iprou=
te2 related<br>function most of the openvpn_net_ctx_t parameters can be mad=
e const=2E<br><br>This does not make net_ctx_free and net_ctx_reset const a=
s those<br>functions are intended to modify the net ctx even though none of=
<br>them do anymore=2E<br><br>Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51=
575533d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-=
by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2106<br>Message-Id: &lt;20261103193058=2E1=
4082-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/open=
vpn-devel/20261103193058=2E14082-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by=
: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/llad=
dr=2Ec<br>M src/openvpn/lladdr=2Eh<br>M src/openvpn/networking=2Eh<br>M src=
/openvpn/networking_freebsd=2Ec<br>M src/openvpn/networking_iproute2=2Ec<br=
>M src/openvpn/networking_sitnl=2Ec<br>6 files changed, 55 insertions(+), 5=
5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lladdr=2Ec b/src/o=
penvpn/lladdr=2Ec</span><br><span>index 554975c=2E=2E8bd572a 100644</span><=
br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>+++ b/src/openvpn/lla=
ddr=2Ec</span><br><span>@@ -15,7 +15,7 @@</span><br><span> </span><br><span=
> #ifdef TARGET_LINUX</span><br><span> static int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-set_lladdr_linux(openvpn_net_ctx_t *ctx, const =
char *ifname, const char *lladdr)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+set_lladdr_linux(const openvpn_net_ctx_t *ctx, const char *if=
name, const char *lladdr)</span><br><span> {</span><br><span>     uint8_t a=
ddr[OPENVPN_ETH_ALEN];</span><br><span> </span><br><span>@@ -48,7 +48,7 @@<=
/span><br><span> #endif /* TARGET_LINUX */</span><br><span> </span><br><spa=
n> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_lladdr(open=
vpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const struct en=
v_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_lladd=
r(const openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, con=
st struct env_set *es)</span><br><span> {</span><br><span>     if (!ifname =
|| !lladdr)</span><br><span>     {</span><br><span>diff --git a/src/openvpn=
/lladdr=2Eh b/src/openvpn/lladdr=2Eh</span><br><span>index 0c8b416=2E=2E9ab=
6578 100644</span><br><span>--- a/src/openvpn/lladdr=2Eh</span><br><span>++=
+ b/src/openvpn/lladdr=2Eh</span><br><span>@@ -5,5 +5,5 @@</span><br><span>=
 #include &quot;misc=2Eh&quot;</span><br><span> #include &quot;networking=
=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-int set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const cha=
r *lladdr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int set_l=
laddr(const openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,=
</span><br><span>                const struct env_set *es);</span><br><span=
>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span=
><br><span>index 25233c8=2E=2E7ad6e2e 100644</span><br><span>--- a/src/open=
vpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><=
br><span>@@ -101,7 +101,7 @@</span><br><span>  *</span><br><span>  * @retur=
n          0 on success, negative error code on error</span><br><span>  */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_new(open=
vpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_iface_new(const=
 openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type=
,</span><br><span>                   const void *arg);</span><br><span> </s=
pan><br><span> /**</span><br><span>@@ -113,7 +113,7 @@</span><br><span>  *<=
/span><br><span>  * @return          0 on success, a negative error code ot=
herwise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-int net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char t=
ype[IFACE_TYPE_LEN_MAX]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+int net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, c=
har type[IFACE_TYPE_LEN_MAX]);</span><br><span> </span><br><span> /**</span=
><br><span>  * Remove an interface</span><br><span>@@ -122,7 +122,7 @@</spa=
n><br><span>  * @param iface     interface to delete</span><br><span>  * @r=
eturn int 0 on success, negative error code on error</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_del(openv=
pn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int net_iface_del(const openvpn_net_ctx_t=
 *ctx, const openvpn_net_iface_t *iface);</span><br><span> </span><br><span=
> /**</span><br><span>  * Bring interface up or down=2E</span><br><span>@@ =
-133,7 +133,7 @@</span><br><span>  *</span><br><span>  * @return          0=
 on success, a negative error code otherwise</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_up(openvpn_net_ct=
x_t *ctx, const openvpn_net_iface_t *iface, bool up);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int net_iface_up(const openvpn_net_ctx_t =
*ctx, const openvpn_net_iface_t *iface, bool up);</span><br><span> </span><=
br><span> /**</span><br><span>  * Set the MTU for an interface</span><br><s=
pan>@@ -144,7 +144,7 @@</span><br><span>  *</span><br><span>  * @return    =
      0 on success, a negative error code otherwise</span><br><span>  */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_mtu_set(op=
envpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t mtu);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_iface_mtu_set(co=
nst openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t mtu)=
;</span><br><span> </span><br><span> /**</span><br><span>  * Set the Link L=
ayer (Ethernet) address of the TAP interface</span><br><span>@@ -155,7 +155=
,7 @@</span><br><span>  *</span><br><span>  * @return          0 on success=
, a negative error code otherwise</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int net_addr_ll_set(openvpn_net_ctx_t *ctx=
, const openvpn_net_iface_t *iface, uint8_t *addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int net_addr_ll_set(const openvpn_net_ctx=
_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);</span><br><span>=
 </span><br><span> /**</span><br><span>  * Add an IPv4 address to an interf=
ace</span><br><span>@@ -167,7 +167,7 @@</span><br><span>  *</span><br><span=
>  * @return          0 on success, a negative error code otherwise</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_=
addr_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const=
 in_addr_t *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t net_addr_v4_add(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *=
iface, const in_addr_t *addr,</span><br><span>                     int pref=
ixlen);</span><br><span> </span><br><span> /**</span><br><span>@@ -181,7 +1=
81,7 @@</span><br><span>  * @return          0 on success, a negative error=
 code otherwise</span><br><span>  */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int net_addr_v6_add(openvpn_net_ctx_t *ctx=
, const openvpn_net_iface_t *iface,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int net_addr_v6_add(const openvpn_net_ctx_t *ctx, const ope=
nvpn_net_iface_t *iface,</span><br><span>                     const struct =
in6_addr *addr, int prefixlen);</span><br><span> </span><br><span> /**</spa=
n><br><span>@@ -193,7 +193,7 @@</span><br><span>  *</span><br><span>  * @re=
turn          0 on success, a negative error code otherwise</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_addr_v4_=
del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr=
_t *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_ad=
dr_v4_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, c=
onst in_addr_t *addr,</span><br><span>                     int prefixlen);<=
/span><br><span> </span><br><span> /**</span><br><span>@@ -205,7 +205,7 @@<=
/span><br><span>  *</span><br><span>  * @return          0 on success, a ne=
gative error code otherwise</span><br><span>  */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-int net_addr_v6_del(openvpn_net_ctx_t *ctx, cons=
t openvpn_net_iface_t *iface,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int net_addr_v6_del(const openvpn_net_ctx_t *ctx, const openvpn_n=
et_iface_t *iface,</span><br><span>                     const struct in6_ad=
dr *addr, int prefixlen);</span><br><span> </span><br><span> /**</span><br>=
<span>@@ -218,7 +218,7 @@</span><br><span>  *</span><br><span>  * @return  =
        0 on success, a negative error code otherwise</span><br><span>  */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_addr_ptp_v4_ad=
d(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int net_addr_ptp_v4_add(const openv=
pn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,</span><br><span>      =
                   const in_addr_t *local, const in_addr_t *remote);</span>=
<br><span> </span><br><span> /**</span><br><span>@@ -231,7 +231,7 @@</span>=
<br><span>  *</span><br><span>  * @return          0 on success, a negative=
 error code otherwise</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const =
openvpn_net_iface_t *iface,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const openvpn=
_net_iface_t *iface,</span><br><span>                         const in_addr=
_t *local, const in_addr_t *remote);</span><br><span> </span><br><span> #en=
dif /* ENABLE_SITNL || ENABLE_IPROUTE */</span><br><span>@@ -251,7 +251,7 @=
@</span><br><span>  *</span><br><span>  * @return          0 on success, a =
negative error code otherwise</span><br><span>  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-int net_route_v4_add(openvpn_net_ctx_t *ctx, c=
onst in_addr_t *dst, int prefixlen,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in=
_addr_t *dst, int prefixlen,</span><br><span>                      const in=
_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,</span><br><s=
pan>                      int metric);</span><br><span> </span><br><span>@@=
 -269,7 +269,7 @@</span><br><span>  *</span><br><span>  * @return          =
0 on success, a negative error code otherwise</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int net_route_v6_add(openvpn_n=
et_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int net_route_v6_add(const openvpn_ne=
t_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span>  =
                    const struct in6_addr *gw, const openvpn_net_iface_t *i=
face, uint32_t table,</span><br><span>                      int metric);</s=
pan><br><span> </span><br><span>@@ -287,7 +287,7 @@</span><br><span>  *</sp=
an><br><span>  * @return          0 on success, a negative error code other=
wise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int =
prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_r=
oute_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixl=
en,</span><br><span>                      const in_addr_t *gw, const openvp=
n_net_iface_t *iface, uint32_t table,</span><br><span>                     =
 int metric);</span><br><span> </span><br><span>@@ -305,7 +305,7 @@</span><=
br><span>  *</span><br><span>  * @return          0 on success, a negative =
error code otherwise</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-int net_route_v6_del(openvpn_net_ctx_t *ctx, const stru=
ct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+int net_route_v6_del(const openvpn_net_ctx_t *ctx, const struc=
t in6_addr *dst, int prefixlen,</span><br><span>                      const=
 struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,</sp=
an><br><span>                      int metric);</span><br><span> </span><br=
><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networ=
king_freebsd=2Ec</span><br><span>index 04051a6=2E=2E88fd5c0 100644</span><b=
r><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><span>+++ b/src/=
openvpn/networking_freebsd=2Ec</span><br><span>@@ -82,28 +82,28 @@</span><b=
r><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-net_route_v4_add(openvpn_net_ctx_t *ctx, const =
in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+net_route_v4_add(const openvpn_net_ctx_t =
*ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><=
span>                  const char *iface, uint32_t table, int metric)</span=
><br><span> {</span><br><span>     return net_route_v4(&quot;add&quot;, dst=
, prefixlen, gw, iface, table, metric);</span><br><span> }</span><br><span>=
 </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int p=
refixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_=
v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefix=
len,</span><br><span>                  const struct in6_addr *gw, const cha=
r *iface, uint32_t table, int metric)</span><br><span> {</span><br><span>  =
   return net_route_v6(&quot;add&quot;, dst, prefixlen, gw, iface, table, m=
etric);</span><br><span> }</span><br><span> </span><br><span> int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_del(openvpn_net_ct=
x_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_del(const open=
vpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *g=
w,</span><br><span>                  const char *iface, uint32_t table, int=
 metric)</span><br><span> {</span><br><span>     return net_route_v4(&quot;=
del&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_ad=
dr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *d=
st, int prefixlen,</span><br><span>                  const struct in6_addr =
*gw, const char *iface, uint32_t table, int metric)</span><br><span> {</spa=
n><br><span>     return net_route_v6(&quot;del&quot;, dst, prefixlen, gw, i=
face, table, metric);</span><br><span>diff --git a/src/openvpn/networking_i=
proute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>index 7a0=
f4f7=2E=2Ed987478 100644</span><br><span>--- a/src/openvpn/networking_iprou=
te2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br=
><span>@@ -59,7 +59,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(=
openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *ar=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(con=
st openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void =
*arg)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new=
();</span><br><span> </span><br><span>@@ -73,7 +73,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, =
char type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, =
char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><br><span>     /* n=
ot supported by iproute2 */</span><br><span>     msg(M_WARN, &quot;%s: oper=
ation not supported by iproute2 backend&quot;, __func__);</span><br><span>@=
@ -81,7 +81,7 @@</span><br><span> }</span><br><span> </span><br><span> int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_del(openvpn_=
net_ctx_t *ctx, const char *iface)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+net_iface_del(const openvpn_net_ctx_t *ctx, const char *ifac=
e)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new();=
</span><br><span> </span><br><span>@@ -94,7 +94,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool =
up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_up(con=
st openvpn_net_ctx_t *ctx, const char *iface, bool up)</span><br><span> {</=
span><br><span>     struct argv argv =3D argv_new();</span><br><span> </spa=
n><br><span>@@ -108,7 +108,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ifa=
ce_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_mtu_set(const ope=
nvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</span><br><span> {</s=
pan><br><span>     struct argv argv =3D argv_new();</span><br><span> </span=
><br><span>@@ -122,7 +122,7 @@</span><br><span> }</span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr=
_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *=
addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_ll_se=
t(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *=
addr)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new=
();</span><br><span>     int ret =3D 0;</span><br><span>@@ -142,7 +142,7 @@=
</span><br><span> }</span><br><span> </span><br><span> int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-net_addr_v4_add(openvpn_net_ctx_t *ctx=
, const char *iface, const in_addr_t *addr, int prefixlen)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+net_addr_v4_add(const openvpn_net_ct=
x_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)</span><b=
r><span> {</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span> </span><br><span>@@ -158,7 +158,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface, const struc=
t in6_addr *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ne=
t_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, const struct=
 in6_addr *addr,</span><br><span>                 int prefixlen)</span><br>=
<span> {</span><br><span>     struct argv argv =3D argv_new();</span><br><s=
pan>@@ -174,7 +174,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_v4_del=
(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int pref=
ixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_v4_d=
el(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, =
int prefixlen)</span><br><span> {</span><br><span>     struct argv argv =3D=
 argv_new();</span><br><span>     const char *addr_str =3D print_in_addr_t(=
*addr, 0, &amp;argv=2Egc);</span><br><span>@@ -190,7 +190,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-net_addr_v6_del(openvpn_net_ctx_t *ctx, const char =
*iface, const struct in6_addr *addr,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *=
iface, const struct in6_addr *addr,</span><br><span>                 int pr=
efixlen)</span><br><span> {</span><br><span>     struct argv argv =3D argv_=
new();</span><br><span>@@ -206,7 +206,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in=
_addr_t *local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_=
addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_a=
ddr_t *local,</span><br><span>                     const in_addr_t *remote)=
</span><br><span> {</span><br><span>     struct argv argv =3D argv_new();</=
span><br><span>@@ -224,7 +224,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_=
addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t =
*local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_ptp=
_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *l=
ocal,</span><br><span>                     const in_addr_t *remote)</span><=
br><span> {</span><br><span>     struct argv argv =3D argv_new();</span><br=
><span>@@ -242,7 +242,7 @@</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4=
_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_=
addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_rout=
e_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,=
 const in_addr_t *gw,</span><br><span>                  const char *iface, =
uint32_t table, int metric)</span><br><span> {</span><br><span>     struct =
argv argv =3D argv_new();</span><br><span>@@ -280,7 +280,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-net_route_v6_add(openvpn_net_ctx_t *ctx, const struc=
t in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6=
_addr *dst, int prefixlen,</span><br><span>                  const struct i=
n6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><span=
> {</span><br><span>     struct argv argv =3D argv_new();</span><br><span>@=
@ -313,7 +313,7 @@</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_del(ope=
nvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *=
gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_del=
(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const i=
n_addr_t *gw,</span><br><span>                  const char *iface, uint32_t=
 table, int metric)</span><br><span> {</span><br><span>     struct argv arg=
v =3D argv_new();</span><br><span>@@ -339,7 +339,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_ad=
dr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *d=
st, int prefixlen,</span><br><span>                  const struct in6_addr =
*gw, const char *iface, uint32_t table, int metric)</span><br><span> {</spa=
n><br><span>     struct argv argv =3D argv_new();</span><br><span>diff --gi=
t a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</sp=
an><br><span>index 0c99d38=2E=2E97ff7bd 100644</span><br><span>--- a/src/op=
envpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sit=
nl=2Ec</span><br><span>@@ -669,7 +669,7 @@</span><br><span> #ifdef ENABLE_S=
ITNL</span><br><span> </span><br><span> int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-net_iface_up(openvpn_net_ctx_t *ctx, const char *ifac=
e, bool up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ifac=
e_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)</span><br><s=
pan> {</span><br><span>     struct sitnl_link_req req;</span><br><span>    =
 int ifindex;</span><br><span>@@ -711,7 +711,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uin=
t32_t mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface=
_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</sp=
an><br><span> {</span><br><span>     struct sitnl_link_req req;</span><br><=
span>     int ifindex, ret =3D -1;</span><br><span>@@ -742,7 +742,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-net_addr_ll_set(openvpn_net_ctx_t *ctx, con=
st openvpn_net_iface_t *iface, uint8_t *addr)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+net_addr_ll_set(const openvpn_net_ctx_t *ctx, con=
st openvpn_net_iface_t *iface, uint8_t *addr)</span><br><span> {</span><br>=
<span>     struct sitnl_link_req req;</span><br><span>     int ifindex, ret=
 =3D -1;</span><br><span>@@ -1038,7 +1038,7 @@</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in=
_addr_t *addr, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, =
const in_addr_t *addr, int prefixlen)</span><br><span> {</span><br><span>  =
   inet_address_t addr_v4 =3D { 0 };</span><br><span>     char buf[INET_ADD=
RSTRLEN];</span><br><span>@@ -1057,7 +1057,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface, const s=
truct in6_addr *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, const st=
ruct in6_addr *addr,</span><br><span>                 int prefixlen)</span>=
<br><span> {</span><br><span>     inet_address_t addr_v6 =3D { 0 };</span><=
br><span>@@ -1077,7 +1077,7 @@</span><br><span> }</span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr=
_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, i=
nt prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ad=
dr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t =
*addr, int prefixlen)</span><br><span> {</span><br><span>     inet_address_=
t addr_v4 =3D { 0 };</span><br><span>     char buf[INET_ADDRSTRLEN];</span>=
<br><span>@@ -1096,7 +1096,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_add=
r_v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *=
addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_v6_de=
l(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *a=
ddr,</span><br><span>                 int prefixlen)</span><br><span> {</sp=
an><br><span>     inet_address_t addr_v6 =3D { 0 };</span><br><span>@@ -111=
6,7 +1116,7 @@</span><br><span> }</span><br><span> </span><br><span> int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_ptp_v4_add(open=
vpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+net_addr_ptp_v4_add(const openvp=
n_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br><spa=
n>                     const in_addr_t *remote)</span><br><span> {</span><b=
r><span>     inet_address_t local_v4 =3D { 0 };</span><br><span>@@ -1144,7 =
+1144,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_ptp_v4_del(openvpn_=
net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+net_addr_ptp_v4_del(const openvpn_ne=
t_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br><span>  =
                   const in_addr_t *remote)</span><br><span> {</span><br><s=
pan>     inet_address_t local_v4 =3D { 0 };</span><br><span>@@ -1196,7 +119=
6,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_add(openvpn_net_ctx=
_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_add(const openv=
pn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw=
,</span><br><span>                  const char *iface, uint32_t table, int =
metric)</span><br><span> {</span><br><span>     const in_addr_t *dst_ptr =
=3D NULL, *gw_ptr =3D NULL;</span><br><span>@@ -1224,7 +1224,7 @@</span><br=
><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-net_route_v6_add(openvpn_net_ctx_t *ctx, const s=
truct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct=
 in6_addr *dst, int prefixlen,</span><br><span>                  const stru=
ct in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><=
span> {</span><br><span>     inet_address_t dst_v6 =3D { 0 };</span><br><sp=
an>@@ -1275,7 +1275,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_d=
el(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_ad=
dr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_=
v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, c=
onst in_addr_t *gw,</span><br><span>                  const char *iface, ui=
nt32_t table, int metric)</span><br><span> {</span><br><span>     inet_addr=
ess_t dst_v4 =3D { 0 };</span><br><span>@@ -1301,7 +1301,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const struc=
t in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6=
_addr *dst, int prefixlen,</span><br><span>                  const struct i=
n6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><span=
> {</span><br><span>     inet_address_t dst_v6 =3D { 0 };</span><br><span>@=
@ -1328,7 +1328,7 @@</span><br><span> </span><br><span> </span><br><span> i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openv=
pn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(const op=
envpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)=
</span><br><span> {</span><br><span>     struct sitnl_link_req req =3D {};<=
/span><br><span>     int ret =3D -1;</span><br><span>@@ -1431,7 +1431,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-net_iface_type(openvpn_net_ctx_t *ctx, =
const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+net_iface_type(const openvpn_net_ctx_t *ctx, =
const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span>=
<br><span>     struct sitnl_link_req req =3D {};</span><br><span>     int i=
findex =3D if_nametoindex(iface);</span><br><span>@@ -1463,7 +1463,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-net_iface_del(openvpn_net_ctx_t *ctx, cons=
t char *iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_i=
face_del(const openvpn_net_ctx_t *ctx, const char *iface)</span><br><span> =
{</span><br><span>     struct sitnl_link_req req =3D {};</span><br><span>  =
   int ifindex =3D if_nametoindex(iface);</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail">ch=
ange 2106</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2106 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--mkmZGgEt4fI=--


--===============5637917685878665344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5637917685878665344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5637917685878665344==--

