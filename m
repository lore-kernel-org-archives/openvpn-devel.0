Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772D606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hedxPm2y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cIk8O3st;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PwcK2AiR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EMBejk8v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sqS88Ml4+Z+YPWZ8bqyXZRmBC0IwnxVF4CtGwE0VUds=; b=hedxPm2yKfrJke8SNkOHIorYco
	3Dfsgj+fpwu8cCzuT5nnJqRU4x2EouSsu59ZTPVKwVhHM+IcmzIAQjLYGkhRl3CENgB77669vwUGg
	4ZvQW+mbbCUSOQMBBli+56jyaoFGH4Hw8r+jLshI9dHEe3+F2Kk1SFXHkb7XxfSczg8k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0i0-000000006NC-1aKK;
	Mon, 16 Nov 2026 17:41:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0hy-000000006N1-3e0z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0SyfoNQE7Ad8f20QnxFOy+uY/ulNR0ROrH90gVJpjJQ=; b=cIk8O3ste+Yq+MLJZ/j4hhJcth
 Ohu56NWNN43SCVhrQu5Iop0FnEYOdrRjvi5vmoBXoZHGAzsugUEm9/+ruC1YhaUi5u5kvSiOMhEXa
 yGO5OC9hdIqw3b6Yc6x8QEDSfwZl3stmbxStKlsIM5FsJafa1UQNkDXoR3CW9DRtutg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0SyfoNQE7Ad8f20QnxFOy+uY/ulNR0ROrH90gVJpjJQ=; b=PwcK2AiRxvjSXfB5JxQ77jSlkb
 tjGp2WwGV2h7cisDxBVxXUX48zsMhrTeS06yn8jAS0pCCD65YoLTa3y0seAq/Q2gJo6esFUJh7bDk
 Ydi50boUsWnY/S6U91/EohCZUzKs+J+2b9F4sI1GafEXR2ju1WRtjxHfE0KZ7ix5IeEA=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0hw-000000002J6-3lXl for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:41:34 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so21810645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794850886; x=1795455686; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0SyfoNQE7Ad8f20QnxFOy+uY/ulNR0ROrH90gVJpjJQ=;
 b=EMBejk8vY7RDm6JcaTEXE4ItBu4brASvtTSbKu2A+Rm91/9tqMVThihlVsNPp7d6fK
 V09Hb5nm3rYiIS/tIE+bqoBDxxSdxbheS8i1QgRJVL4mnh1+eyJ7qvfx6wMz6ua9Sk6u
 DGX0n30/2FCJrLmKlmuSVJA3VEk1A9A8surU6xs0AtmnCGfjIy4fbo2cl+UbzePUsB7i
 1L7WQ1ndSZoDJMy35V+pp8Ps349uufW3PdRKDXIRV3F4cZYYQ1Ze6LlbRs7uyLWIP6yO
 npHsCchBNjOWzliKP0zV9yHXd4+G9kbEPqzAyQabUBlii4xXUISV1slx7pWLL2jRnQff
 NkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850886; x=1795455686;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0SyfoNQE7Ad8f20QnxFOy+uY/ulNR0ROrH90gVJpjJQ=;
 b=m7IGmHwo9eOYA1Swsj0P3a2wHjOfCQ/dBbkEu5GrLk7TbO822716OR05+UTs/QSPLS
 SSvNKs6sqH9bJ65hBAw3gMiz+j8EOcIGR/ABshxgMTE75Ko3KS7XA+nRht1zwe9ieRI5
 fvI4GNdsVQO3cWlkbtjqS8m78tDcYEFu1c7cWx5K4+xhiQuheQni0LRHuFZP88uieOF7
 +FdNoGFBW7OPUg/Mxg7uIu9MCQArPuqwCwV//I1qoCB7ZJfysR/a4OPDatpYXsc5Iy+E
 X50oTKRDiAXNB09SaxMzkixbaHfdmPsB5EIZRi0zUCdOwJwGlk/Q1n1v+S+hQog9Zo6C
 6gBA==
X-Forwarded-Encrypted: i=1;
 AL+hErHsZA61sO+cCYLM/irp+xw78/seDmIgW+wV7YKU3hpCWDNLsowaqT3SPO05VrqB0sqmDPklApWnGYPl8JmG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+qwqmoH8K9NFgKxKmGSvO0dhm5scC8ThYFrL7+B9kFgoOUSmTJ
 nYFZ05nbFcuRIoKOzHAe8KzQOCFtoP4p9KreSYlpVdXPCiqLh4lT8yU30JjBtvpiL6SZd5UHblT
 hUZRUfpoR1D1yvnonJSnhPY8bLbj9NYgdAJV96Sg7EVlxlonOMaAUreGgIh4vBRMziLcb
X-Gm-Gg: AYBFou3jTIS2WWufmFYuVsFT/GG4gOeqAL3uuGNncf5OovDsZkBqvz1VUbqUKN2tiTn
 vKkrjMKMdUIJOCtCUnaOZIZjRMDSaXAPuUiI+eSdJoIiMoGReI7sRFL4iMhKShQ7y9KqDwcqQ9D
 Ay91z8+TsZlca0UKkqjLWbiZIQha0l6SnnzytHTmRXDLmFIQWpJz0WOxMKAoFF7fg9Lwd5k46wY
 DbINyRtOrT4SBBEG7ioTu3/NHL/MV8w+zuS9bkiSpf8pXdBvgo9NaazK7ArDdeCmj7tUQMCev97
 azz2Axkh3UNcmB4FtgvQyBbXqlbLQB0HEOzLq6Kpv+Xls9O8xE41221BzJ8rPbnxhmLKR3TIP+u
 xtAXCb6733arV7VgNi87h1uMPxzj7rp8cSiA+RZO5NiDH5ZpPtTdh056CE55eKY1ZUE5Xw7PjYq
 Ubp1tNo/lBXpN7lIrQswPKw+SxzLx74In+dYgebQvxB/bTVqNSrDuNIiF5PSW56IP5eT8EpGFRV
 4MPQs2RsGnMMKbF+MFgyjaI5CCt8RvhzukZvhqGM1apDzNKSEj8ZEASHHZYDnJdTRhDhNVAcmK3
 wFvaHoHk8z6H/CSnr9DC4GaXgZODu+dB8Y7Mb3AzMIP54JW3FXDTPSYXmdaB3VHxaFbg26nMJMq
 rNiJjb6RnKYh6fEhs45Xf5ZDPH4zpvGAg845llE0vnDc2PgEOY2VK+b7MXthquY+vaTAAcMEnss
 gp/H6nJoKVcqgU7Qs=
X-Received: by 2002:a05:600c:8483:b0:4bb:605d:8e92 with SMTP id
 5b1f17b1804b1-4bb605d90f1mr175634525e9.32.1794850885759; 
 Mon, 16 Nov 2026 09:41:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78418853sm5112045e9.8.2026.11.16.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:41:25 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:41:25 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: a64c40032ade56ed7d6b1f650db7dd04f53ac2f1
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0db5a35b2ecc3cf19195c1fd63224e67ba709fe8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0hw-000000002J6-3lXl
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4103336164587820428=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4103336164587820428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qwrrdlYSGwU="; charset=UTF-8

--qwrrdlYSGwU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2177?usp=3Demail )

Change subject: networking_sitnl: Reduce bo=
ilerplate code for parameter checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

networking_sitnl: Reduce boilerplate code for parame=
ter checks

Also removes some inconsistencies and some
sign conversion warn=
ings=2E

Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Signed-off-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2177
Message-Id: <20261116120513=2E24130-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
41423=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sr=
c/openvpn/networking_sitnl=2Ec
1 file changed, 74 insertions(+), 169 deleti=
ons(-)




diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/netw=
orking_sitnl=2Ec
index d5ec6bb=2E=2Eb7c0f58 100644
--- a/src/openvpn/networ=
king_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -677,25 +677,37 @@=

 
 #ifdef ENABLE_SITNL
 
+static int
+get_ifindex(const char *func, const =
char *iface, uint32_t *ifindex)
+{
+    if (!iface)
+    {
+        msg(M_W=
ARN, "%s: passed NULL interface", func);
+        return -EINVAL;
+    }
+
=
+    *ifindex =3D if_nametoindex(iface);
+    if (*ifindex =3D=3D 0)
+    {=

+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", func=
, iface);
+        return -ENOENT;
+    }
+    return 0;
+}
+
+
 int
 net_i=
face_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     s=
truct sitnl_link_req req;
-    int ifindex;
+    uint32_t ifindex;
 
     C=
LEAR(req);
 
-    if (!iface)
+    const int ret =3D get_ifindex(__func__, =
iface, &ifindex);
+    if (ret < 0)
     {
-        msg(M_WARN, "%s: passed=
 NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifindex=
 =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-        msg(=
M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface, strerro=
r(errno));
-        return -ENOENT;
+        return ret;
     }
 
     req=
=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
@@ -703,7 +715,7 @@
   =
  req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=2Eifi_family =3D AF_=
PACKET;
-    req=2Ei=2Eifi_index =3D ifindex;
+    req=2Ei=2Eifi_index =3D =
(int)ifindex;
     req=2Ei=2Eifi_change |=3D IFF_UP;
     if (up)
     {
@@=
 -711,7 +723,7 @@
     }
     else
     {
-        req=2Ei=2Eifi_flags &=3D=
 ~IFF_UP;
+        req=2Ei=2Eifi_flags &=3D ~(unsigned int)IFF_UP;
     }
 =

     msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");
@@=
 -723,14 +735,13 @@
 net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const =
char *iface, uint32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifin=
dex, ret =3D -1;
+    int ret =3D -1;
+    uint32_t ifindex;
 
     CLEAR(r=
eq);
 
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
+=
    if (get_ifindex(__func__, iface, &ifindex) < 0)
     {
-        msg(M_W=
ARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
   =
      return -1;
     }
 
@@ -739,7 +750,7 @@
     req=2En=2Enlmsg_type =3D=
 RTM_SETLINK;
 
     req=2Ei=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi=
_index =3D ifindex;
+    req=2Ei=2Eifi_index =3D (int)ifindex;
 
     SITNL=
_ADDATTR(&req=2En, sizeof(req), IFLA_MTU, &mtu, 4);
 
@@ -754,14 +765,13 @@=

 net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *=
iface, uint8_t *addr)
 {
     struct sitnl_link_req req;
-    int ifindex, =
ret =3D -1;
+    int ret =3D -1;
+    uint32_t ifindex;
 
     CLEAR(req);
=
 
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
+    i=
f (get_ifindex(__func__, iface, &ifindex) < 0)
     {
-        msg(M_WARN |=
 M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
        =
 return -1;
     }
 
@@ -770,7 +780,7 @@
     req=2En=2Enlmsg_type =3D RTM_=
SETLINK;
 
     req=2Ei=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi_inde=
x =3D ifindex;
+    req=2Ei=2Eifi_index =3D (int)ifindex;
 
     SITNL_ADDA=
TTR(&req=2En, sizeof(req), IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);
 
@@ -782=
,22 +792,19 @@
 }
 
 static int
-sitnl_addr_set(uint16_t cmd, uint16_t flag=
s, int ifindex, sa_family_t af_family,
+sitnl_addr_set(uint16_t cmd, uint16=
_t flags, const char *iface, sa_family_t af_family,
                const i=
net_address_t *local, const inet_address_t *remote, int prefixlen)
 {
     =
struct sitnl_addr_req req;
-    uint32_t size;
-    int ret =3D -EINVAL;
+ =
   size_t size;
+    uint32_t ifindex;
 
-    CLEAR(req);
-
-    req=2En=2E=
nlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
-    req=2En=2Enlmsg_type =3D =
cmd;
-    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;
-
-    req=2Ei=
=2Eifa_index =3D ifindex;
-    ASSERT(af_family <=3D UINT8_MAX);
-    req=
=2Ei=2Eifa_family =3D (uint8_t)af_family;
+    int ret =3D get_ifindex(__fu=
nc__, iface, &ifindex);
+    if (ret < 0)
+    {
+        return ret;
+    =
}
+    ret =3D -EINVAL; /* for SITNL_ADDATTR */
 
     switch (af_family)
 =
    {
@@ -814,10 +821,20 @@
             return -EINVAL;
     }
 
+    CLEA=
R(req);
+
+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
+    =
req=2En=2Enlmsg_type =3D cmd;
+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST =
| flags;
+
+    req=2Ei=2Eifa_index =3D ifindex;
+    ASSERT(af_family <=3D=
 UINT8_MAX);
+    req=2Ei=2Eifa_family =3D (uint8_t)af_family;
+
     /* if=
 no prefixlen has been specified, assume host address */
     if (prefixlen=
 =3D=3D 0)
     {
-        prefixlen =3D size * 8;
+        prefixlen =3D (=
int)size * 8;
     }
     ASSERT(prefixlen <=3D UINT8_MAX);
     req=2Ei=2E=
ifa_prefixlen =3D (uint8_t)prefixlen;
@@ -852,76 +869,37 @@
 sitnl_addr_ptp=
_add(sa_family_t af_family, const char *iface, const inet_address_t *local,=

                    const inet_address_t *remote)
 {
-    int ifindex;
-
-=
    switch (af_family)
-    {
-        case AF_INET:
-        case AF_INET6=
:
-            break;
-
-        default:
-            return -EINVAL;
-   =
 }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interfac=
e", __func__);
-        return -EINVAL;
-    }
-
-    ifindex =3D if_nameto=
index(iface);
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN, "%s: c=
annot get ifindex for %s: %s", __func__, np(iface), strerror(errno));
-    =
    return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_=
CREATE | NLM_F_REPLACE, ifindex, af_family, local,
+    return sitnl_addr_s=
et(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, local,
    =
                       remote, 0);
 }
 
 static int
 sitnl_addr_ptp_del(sa_=
family_t af_family, const char *iface, const inet_address_t *local)
 {
-   =
 int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:
-    =
    case AF_INET6:
-            break;
-
-        default:
-            ret=
urn -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: pas=
sed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifin=
dex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-        m=
sg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, iface);
-  =
      return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_DELADDR, 0, i=
findex, af_family, local, NULL, 0);
+    return sitnl_addr_set(RTM_DELADDR,=
 0, iface, af_family, local, NULL, 0);
 }
 
 static int
-sitnl_route_set(ui=
nt16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void =
*dst,
+sitnl_route_set(uint16_t cmd, uint16_t flags, const char *iface, sa_=
family_t af_family, const void *dst,
                 int prefixlen, const =
void *gw, enum rt_class_t table, int metric,
                 enum rt_scope=
_t scope, unsigned char protocol, unsigned char type)
 {
     struct sitnl_=
route_req req;
-    int ret =3D -1, size;
+    int ret =3D -1; /* for SITNL=
_ADDATTR */
+    size_t size;
+    uint32_t ifindex =3D 0;
 
     CLEAR(req=
);
 
+    if (iface)
+    {
+        const int ifi_ret =3D get_ifindex(__fu=
nc__, iface, &ifindex);
+        if (ifi_ret < 0)
+        {
+            r=
eturn ifi_ret;
+        }
+    }
+
     switch (af_family)
     {
         =
case AF_INET:
@@ -986,64 +964,14 @@
 static int
 sitnl_addr_add(sa_family_t=
 af_family, const char *iface, const inet_address_t *addr, int prefixlen)
 =
{
-    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:=

-        case AF_INET6:
-            break;
-
-        default:
-         =
   return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%=
s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-  =
  ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-   =
     msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,=
 iface);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_N=
EWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
+    =
return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_=
family, addr, NULL,
                           prefixlen);
 }
 
 static int=

 sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_addre=
ss_t *addr, int prefixlen)
 {
-    int ifindex;
-
-    switch (af_family)
-=
    {
-        case AF_INET:
-        case AF_INET6:
-            break;
-
=
-        default:
-            return -EINVAL;
-    }
-
-    if (!iface)
- =
   {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        =
return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (i=
findex =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot ge=
t ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-   =
 return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, pref=
ixlen);
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, addr, =
NULL, prefixlen);
 }
 
 int
@@ -1190,17 +1118,6 @@
                 const v=
oid *gw, uint32_t table, int metric)
 {
     enum rt_scope_t scope =3D RT_S=
COPE_UNIVERSE;
-    int ifindex =3D 0;
-
-    if (iface)
-    {
-        if=
index =3D if_nametoindex(iface);
-        if (ifindex =3D=3D 0)
-        {
=
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __=
func__, iface);
-            return -ENOENT;
-        }
-    }
 
     if (t=
able =3D=3D 0)
     {
@@ -1212,7 +1129,7 @@
         scope =3D RT_SCOPE_LIN=
K;
     }
 
-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex=
, af_family, dst, prefixlen, gw,
+    return sitnl_route_set(RTM_NEWROUTE, =
NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,
                       =
     table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
@@ -1277,24 +119=
4,12 @@
 sitnl_route_del(const char *iface, sa_family_t af_family, const in=
et_address_t *dst, int prefixlen,
                 const inet_address_t *gw=
, uint32_t table, int metric)
 {
-    int ifindex =3D 0;
-
-    if (iface)
=
-    {
-        ifindex =3D if_nametoindex(iface);
-        if (ifindex =3D=
=3D 0)
-        {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get i=
findex for %s", __func__, iface);
-            return -ENOENT;
-        }
-=
    }
-
     if (table =3D=3D 0)
     {
         table =3D RT_TABLE_MAIN;
 =
    }
 
-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, ds=
t, prefixlen, gw, table, metric,
+    return sitnl_route_set(RTM_DELROUTE, =
0, iface, af_family, dst, prefixlen, gw, table, metric,
                   =
         RT_SCOPE_NOWHERE, 0, 0);
 }
 
@@ -1464,7 +1369,7 @@
 net_iface_typ=
e(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN=
_MAX])
 {
     struct sitnl_link_req req =3D {};
-    int ifindex =3D if_na=
metoindex(iface);
+    int ifindex =3D (int)if_nametoindex(iface);
 
     i=
f (!ifindex)
     {
@@ -1496,7 +1401,7 @@
 net_iface_del(const openvpn_net_=
ctx_t *ctx, const char *iface)
 {
     struct sitnl_link_req req =3D {};
- =
   int ifindex =3D if_nametoindex(iface);
+    int ifindex =3D (int)if_name=
toindex(iface);
 
     if (!ifindex)
     {

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-=
Change-Number: 2177
Gerrit-PatchSet: 5
Gerrit-Owner: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--qwrrdlYSGwU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2177?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">networking_sitnl: Reduce boilerpla=
te code for parameter checks<br><br>Also removes some inconsistencies and s=
ome<br>sign conversion warnings=2E<br><br>Change-Id: I6f5ca53d4288b0921610f=
7a3f84ad55d2ab49118<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177<br>Message-Id: =
&lt;20261116120513=2E24130-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41423=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 74 insertions(+), 1=
69 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index d5ec6bb=2E=2E=
b7c0f58 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span=
><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -677,2=
5 +677,37 @@</span><br><span> </span><br><span> #ifdef ENABLE_SITNL</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ifindex(const =
char *func, const char *iface, uint32_t *ifindex)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!iface)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN, &quot;%s: passed NULL interface&quot;, func);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    *ifindex =3D if_nametoindex(iface);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (*ifindex =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: canno=
t get ifindex for %s&quot;, func, iface);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return -ENOENT;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br=
><span> net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool =
up)</span><br><span> {</span><br><span>     struct sitnl_link_req req;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><=
br><span> </span><br><span>     CLEAR(req);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const int ret =3D get_ifindex(__fun=
c__, iface, &amp;ifindex);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (ret &lt; 0)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL inter=
face&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(ifa=
ce);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =
=3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s=
: rtnl: cannot get ifindex for %s: %s&quot;, __func__, iface, strerror(errn=
o));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -E=
NOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n ret;</span><br><span>     }</span><br><span> </span><br><span>     req=2E=
n=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>@@ -703,7 =
+715,7 @@</span><br><span>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span>=
<br><span> </span><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D =
ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=
=2Eifi_index =3D (int)ifindex;</span><br><span>     req=2Ei=2Eifi_change |=
=3D IFF_UP;</span><br><span>     if (up)</span><br><span>     {</span><br><=
span>@@ -711,7 +723,7 @@</span><br><span>     }</span><br><span>     else</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        req=2Ei=2Eifi_flags &amp;=3D ~IFF_UP;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        req=2Ei=2Eifi_flags &amp;=3D ~(unsigned i=
nt)IFF_UP;</span><br><span>     }</span><br><span> </span><br><span>     ms=
g(M_INFO, &quot;%s: set %s %s&quot;, __func__, iface, up ? &quot;up&quot; :=
 &quot;down&quot;);</span><br><span>@@ -723,14 +735,13 @@</span><br><span> =
net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t=
 mtu)</span><br><span> {</span><br><span>     struct sitnl_link_req req;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t if=
index;</span><br><span> </span><br><span>     CLEAR(req);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_na=
metoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (get_ifindex(__func__, iface, &amp;ifindex) &lt; 0)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__,=
 iface);</span><br><span>         return -1;</span><br><span>     }</span><=
br><span> </span><br><span>@@ -739,7 +750,7 @@</span><br><span>     req=2En=
=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> </span><br><span>     req=
=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    req=2Ei=2Eifi_index =3D ifindex;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_index =3D (int)ifindex;</span=
><br><span> </span><br><span>     SITNL_ADDATTR(&amp;req=2En, sizeof(req), =
IFLA_MTU, &amp;mtu, 4);</span><br><span> </span><br><span>@@ -754,14 +765,1=
3 @@</span><br><span> net_addr_ll_set(const openvpn_net_ctx_t *ctx, const o=
penvpn_net_iface_t *iface, uint8_t *addr)</span><br><span> {</span><br><spa=
n>     struct sitnl_link_req req;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int ifindex, ret =3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int ret =3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span> </span><br><spa=
n>     CLEAR(req);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (get_ifindex(__func__, iface, =
&amp;ifindex) &lt; 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot=
 get ifindex for %s&quot;, __func__, iface);</span><br><span>         retur=
n -1;</span><br><span>     }</span><br><span> </span><br><span>@@ -770,7 +7=
80,7 @@</span><br><span>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><b=
r><span> </span><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D if=
index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=
=2Eifi_index =3D (int)ifindex;</span><br><span> </span><br><span>     SITNL=
_ADDATTR(&amp;req=2En, sizeof(req), IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);<=
/span><br><span> </span><br><span>@@ -782,22 +792,19 @@</span><br><span> }<=
/span><br><span> </span><br><span> static int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uint16_t flags, int if=
index, sa_family_t af_family,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+sitnl_addr_set(uint16_t cmd, uint16_t flags, const char *iface, s=
a_family_t af_family,</span><br><span>                const inet_address_t =
*local, const inet_address_t *remote, int prefixlen)</span><br><span> {</sp=
an><br><span>     struct sitnl_addr_req req;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint32_t size;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int ret =3D -EINVAL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(req);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_type =
=3D cmd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2En=
=2Enlmsg_flags =3D NLM_F_REQUEST | flags;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   req=2Ei=2Eifa_index =3D ifindex;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(af_family &lt;=3D UINT8_MAX);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifa_family =3D (uint8_t)af_f=
amily;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D get_ifindex(__func__, iface, &amp;ifindex);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return ret;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ret =3D -EINVAL; /* for SITNL_ADDATTR */</span><br><span> </span><br><s=
pan>     switch (af_family)</span><br><span>     {</span><br><span>@@ -814,=
10 +821,20 @@</span><br><span>             return -EINVAL;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlms=
g_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D cmd;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_flags =3D NLM_F_REQU=
EST | flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifa_index =
=3D ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(af_family &lt;=3D UINT8_MAX);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    req=2Ei=2Eifa_family =3D (uint8_t)af_family;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* if no p=
refixlen has been specified, assume host address */</span><br><span>     if=
 (prefixlen =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        prefixlen =3D size * 8;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        prefixlen =3D (int)size * 8;</sp=
an><br><span>     }</span><br><span>     ASSERT(prefixlen &lt;=3D UINT8_MAX=
);</span><br><span>     req=2Ei=2Eifa_prefixlen =3D (uint8_t)prefixlen;</sp=
an><br><span>@@ -852,76 +869,37 @@</span><br><span> sitnl_addr_ptp_add(sa_f=
amily_t af_family, const char *iface, const inet_address_t *local,</span><b=
r><span>                    const inet_address_t *remote)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    switch (af_family)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func=
__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -E=
INVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot get ifinde=
x for %s: %s&quot;, __func__, np(iface), strerror(errno));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifin=
dex, af_family, local,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifa=
ce, af_family, local,</span><br><span>                           remote, 0)=
;</span><br><span> }</span><br><span> </span><br><span> static int</span><b=
r><span> sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, const=
 inet_address_t *local)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
witch (af_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET=
6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            return -EINVAL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;=
%s: passed NULL interface&quot;, __func__);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifindex for %s&quot;, __func__,=
 iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifinde=
x, af_family, local, NULL, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, loca=
l, NULL, 0);</span><br><span> }</span><br><span> </span><br><span> static i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(uin=
t16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *=
dst,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set=
(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_family, co=
nst void *dst,</span><br><span>                 int prefixlen, const void *=
gw, enum rt_class_t table, int metric,</span><br><span>                 enu=
m rt_scope_t scope, unsigned char protocol, unsigned char type)</span><br><=
span> {</span><br><span>     struct sitnl_route_req req;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -1, size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1; /* for SITNL_A=
DDATTR */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t =
ifindex =3D 0;</span><br><span> </span><br><span>     CLEAR(req);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ifa=
ce)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const int ifi_ret =3D =
get_ifindex(__func__, iface, &amp;ifindex);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (ifi_ret &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return ifi_ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     switch (af_family)</span><br><span>     {</=
span><br><span>         case AF_INET:</span><br><span>@@ -986,64 +964,14 @@=
</span><br><span> static int</span><br><span> sitnl_addr_add(sa_family_t af=
_family, const char *iface, const inet_address_t *addr, int prefixlen)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    switch (af_family)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL interface&qu=
ot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;=
%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, if=
index, af_family, addr, NULL,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLA=
CE, iface, af_family, addr, NULL,</span><br><span>                         =
  prefixlen);</span><br><span> }</span><br><span> </span><br><span> static =
int</span><br><span> sitnl_addr_del(sa_family_t af_family, const char *ifac=
e, const inet_address_t *addr, int prefixlen)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    switch (af_family)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            return -EINVAL=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!iface)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func__);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return -EINVAL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get if=
index for %s&quot;, __func__, iface);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return -ENOENT;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_ad=
dr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_set(RT=
M_DELADDR, 0, iface, af_family, addr, NULL, prefixlen);</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span>@@ -1190,17 +1118,6 =
@@</span><br><span>                 const void *gw, uint32_t table, int met=
ric)</span><br><span> {</span><br><span>     enum rt_scope_t scope =3D RT_S=
COPE_UNIVERSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 ifindex =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (iface)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoindex(iface);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ifindex =3D=3D 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO,=
 &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__, iface);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            return -ENOENT=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><b=
r><span>     if (table =3D=3D 0)</span><br><span>     {</span><br><span>@@ =
-1212,7 +1129,7 @@</span><br><span>         scope =3D RT_SCOPE_LINK;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex=
, af_family, dst, prefixlen, gw,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, =
af_family, dst, prefixlen, gw,</span><br><span>                            =
table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span><br><span> }</span><=
br><span> </span><br><span>@@ -1277,24 +1194,12 @@</span><br><span> sitnl_r=
oute_del(const char *iface, sa_family_t af_family, const inet_address_t *ds=
t, int prefixlen,</span><br><span>                 const inet_address_t *gw=
, uint32_t table, int metric)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int ifindex =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex fo=
r %s&quot;, __func__, iface);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            return -ENOENT;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     if (table =3D=3D 0)</span><br><span>     {</span><br><span>        =
 table =3D RT_TABLE_MAIN;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM=
_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set=
(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, metric,</spa=
n><br><span>                            RT_SCOPE_NOWHERE, 0, 0);</span><br>=
<span> }</span><br><span> </span><br><span>@@ -1464,7 +1369,7 @@</span><br>=
<span> net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char=
 type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><br><span>     struct s=
itnl_link_req req =3D {};</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int ifindex =3D if_nametoindex(iface);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int ifindex =3D (int)if_nametoindex(iface);<=
/span><br><span> </span><br><span>     if (!ifindex)</span><br><span>     {=
</span><br><span>@@ -1496,7 +1401,7 @@</span><br><span> net_iface_del(const=
 openvpn_net_ctx_t *ctx, const char *iface)</span><br><span> {</span><br><s=
pan>     struct sitnl_link_req req =3D {};</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoindex(iface);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex =3D (int)if_nam=
etoindex(iface);</span><br><span> </span><br><span>     if (!ifindex)</span=
><br><span>     {</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">change 2177</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6f5ca53d4288b0921=
610f7a3f84ad55d2ab49118 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2177 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--qwrrdlYSGwU=--


--===============4103336164587820428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4103336164587820428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4103336164587820428==--

