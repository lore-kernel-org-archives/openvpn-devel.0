Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12B606A322
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i6WODe5s;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k+thWux8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QCo5pzuU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ErzLofGW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Dgw4qYajjPU/l/hJExLyowassCX0YylGEPEh01NBUTY=; b=i6WODe5sFvY5Q8K3CxkLIcBfgL
	VfelMQhdIO8V05MaOW4uXgYb69i4IXxK0naYl1kGQ5EWJ0aeJCbfQMLvop494j85ETN84pYEDftMi
	J9wJCoLUehpNILGvnpJrdAzfPb3xAqkm/q3VnUhBfk4lFaPtS7MvBAh2uyyxF/ae2q3I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0hz-000000000xe-0FjK;
	Mon, 16 Nov 2026 17:41:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0hx-000000000xX-0dsy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:41:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ai1i0exZ3ZEJ5qkOoPz5aTz9pDPyz2L89rTzab2GDFQ=; b=k+thWux84Ux9CStIFtCLFHvOOX
 e41sRmyV5luAKmVcu1vClxS2G81AflzMDHtJRdl6XJpEigiMZCJI7C3zpO0mEpy+77WRE6qfbo7Qf
 /RYwacOpDLfV8+1G9NvVyBySRvn/I/GFnXaM9/zEkdhilueuD73tOSVJshs6nMg400PM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ai1i0exZ3ZEJ5qkOoPz5aTz9pDPyz2L89rTzab2GDFQ=; b=QCo5pzuUdlT5AyVGqRU3Cd6+1B
 nWsmgtfRIprMn3fCRRnGvKM9KEllLQpegwT74/rGk/1O3+9ehLFatW2Kt5RaNw/Qf8ji2h7Fy8ztA
 73aspAodjUgz/0RGaJeUmBMSSVLC4/Hgc8mlEIIadV3yc+xcX3WGkp11mCxeNoi6IAsM=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0hv-0000000059i-048e for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:41:33 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so72080f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794850884; x=1795455684; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ai1i0exZ3ZEJ5qkOoPz5aTz9pDPyz2L89rTzab2GDFQ=;
 b=ErzLofGW5glfQvSpKrzDrPqdXOuwnkj+Wgb7SveJtzmxLqyxSdkqI0k+FGinEEzTGi
 7SCr87s2x19TzKU3rFJ6dlV8wcGlhBhOWkv93bkzpIfeSBSKyTSJpU+0YFV1A5Nod7NI
 xIl/liFpyu3d5x2zACj6Fozx1KqKUe4aufvyvNJPX+DKIllDmUJatjnOo1XO2D1K/BqI
 nf9rR1tJ6w7elpLIlHIDUPCIW5UOEG8I+DVXheFaofg4YsL7Uj2jHiLuuBzXpiLJBPhs
 J4NS6vq8rztehku22voebXiBDWJa5od7pXfHKz8dFepadLAUpU85vpleiv8TQyAdVBDH
 ND1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850884; x=1795455684;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ai1i0exZ3ZEJ5qkOoPz5aTz9pDPyz2L89rTzab2GDFQ=;
 b=iyzJLyc5JIYelNbu3K0p8sZoTt1Hpx7MM+fewYxy7usdedJxMhR8hrwowgZoq2GFKc
 wq6kQcDITsIRnqHMcNtGASOALrZN78aygpygbciKiyPAHKDdjAgbo4O5u6e+jIDCGJtq
 1lbo9dNkDVj3g+MmwNJqGdBDKoe2gH+DAEYlELbzFhoCmVX1St9y8jIR7L0OpL3vXitm
 lV0sTF7s9OWsiLsZQI7/TxlMliIH/aK6eTFKVYmyv0S5zMHZ8g9Z6iliyDfVF1auGpa9
 m3jfETA6rUuko8NfU/x4MM7RAf57uQZZSHGFiiq9L95pyNJS9xag6XsG/rQe09Ya5AQ0
 qXUQ==
X-Gm-Message-State: APuU4Z/YL+qrSoWFRSJElRmSdhWKQF7MnUkcfD3ntX6mH/Fc63+UEEmd
 5nEFOo669Lu/V3uqKl64YjeF0KpOpt7j5/hLh5KTn3WX9TCUYWILxP55TNU0/upO9lo66GxNmBp
 6/HlfgYkwW3oIT3G8l9mcy3EiMk6kH2SNLWVGMJk23vZ2di/RdDK6RyInzzeYKUIA8ORJ
X-Gm-Gg: AZFdTZe8dSf1llfHlJ/mKeIPaOrKpu4Q85VNmfOU7SkF6SQzlu9HXIbpGXnvr/DW1Nf
 HwRsntnIXP87ByUmP8pLDNcLAc+LFOsmpsb/z2TmsRRJWN7Gq1xsrdBMUXABsJG2zJX1XXkPGFz
 CDGMnP4SoMK+ARjVfDYaNI1M+ln7EQYI41Q7GYHBRq84cRpvGvt2C5thB0GqD79jW4LyR2j0Ckr
 1MCuYKUtHWaSbH1e41S0d7jR5Ss5Z42p7A1be2JV57KZfIOb/M3lcjn8bnz/HVo3Sy/orxFElAC
 clU4QejolMKy35vJFU7eKt03OnARRz3X3PMesgpQ0Pn211+f+3H62ETzVyVNflpSLCxCOOniq4Y
 lyrdn41JI7Kl0v2n5OpdlbmvVFwB+Q6TCsYtZyLjmkkd6wmtTM4JaFsNLzbaQPwrY8O/AU7Skgk
 RC7lkhYP42+WnP0qL2Tra36fUgptdPANrZ5PAvasPiCJ7792Uw4OrG7Lo1Ck5kifHvZcAdikZOF
 CVPjSJhyIITCG0JXIfW1DLXp1v5CG9el6mPFM0vuraF/vWF4g1VAgcL6xDpfDbNVZZU3SQB9WyO
 f3HhFIaWAczwzSe9gmf3c2tuxERUzp92omCSJU61kgq6pN63CRXUQ5sWZoYGS1TEtHRc4RaYRnR
 egTC3lac1gRpDXSvtCT7v0kZl060ff4drySGi2QQITKEoelcXqeKZSYDFOIrgRoNI6w+kSNxWUW
 jVOTuF9p89JrqQxDzHtgzR+8V5Nz31xuPJ9tNd
X-Received: by 2002:a05:6000:27c1:b0:48e:76ab:78f3 with SMTP id
 ffacd0b85a97d-4a36e47bab6mr358779f8f.15.1794850884078; 
 Mon, 16 Nov 2026 09:41:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60116323sm22916579f8f.32.2026.11.16.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:41:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:41:21 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: a64c40032ade56ed7d6b1f650db7dd04f53ac2f1
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0db5a35b2ecc3cf19195c1fd63224e67ba709fe8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0hv-0000000059i-048e
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1528833171647549191=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1528833171647549191==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R1Bs5lIW7is="; charset=UTF-8

--R1Bs5lIW7is=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
177?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Antonio Quartulli, Code-Review+2 by R=C4=83zvan Cojocaru


=
Change subject: networking_sitnl: Reduce boilerplate code for parameter che=
cks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

network=
ing_sitnl: Reduce boilerplate code for parameter checks

Also removes some =
inconsistencies and some
sign conversion warnings=2E

Change-Id: I6f5ca53d4=
288b0921610f7a3f84ad55d2ab49118
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177
Message-Id: <20261116120=
513=2E24130-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg41423=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/networking_sitnl=2Ec=

1 file changed, 74 insertions(+), 169 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/2177/5

diff --git a/src/o=
penvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index d5ec6b=
b=2E=2Eb7c0f58 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/open=
vpn/networking_sitnl=2Ec
@@ -677,25 +677,37 @@
 
 #ifdef ENABLE_SITNL
 
+st=
atic int
+get_ifindex(const char *func, const char *iface, uint32_t *ifinde=
x)
+{
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interfa=
ce", func);
+        return -EINVAL;
+    }
+
+    *ifindex =3D if_nametoin=
dex(iface);
+    if (*ifindex =3D=3D 0)
+    {
+        msg(M_WARN | M_ERRN=
O, "%s: rtnl: cannot get ifindex for %s", func, iface);
+        return -EN=
OENT;
+    }
+    return 0;
+}
+
+
 int
 net_iface_up(const openvpn_net_ctx=
_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;
-  =
  int ifindex;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    if (!iface)=

+    const int ret =3D get_ifindex(__func__, iface, &ifindex);
+    if (re=
t < 0)
     {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
=
-        return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-=
    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN, "%s: rtnl: cannot get=
 ifindex for %s: %s", __func__, iface, strerror(errno));
-        return -E=
NOENT;
+        return ret;
     }
 
     req=2En=2Enlmsg_len =3D NLMSG_LEN=
GTH(sizeof(req=2Ei));
@@ -703,7 +715,7 @@
     req=2En=2Enlmsg_type =3D RTM=
_SETLINK;
 
     req=2Ei=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi_ind=
ex =3D ifindex;
+    req=2Ei=2Eifi_index =3D (int)ifindex;
     req=2Ei=2Ei=
fi_change |=3D IFF_UP;
     if (up)
     {
@@ -711,7 +723,7 @@
     }
     =
else
     {
-        req=2Ei=2Eifi_flags &=3D ~IFF_UP;
+        req=2Ei=2Ei=
fi_flags &=3D ~(unsigned int)IFF_UP;
     }
 
     msg(M_INFO, "%s: set %s =
%s", __func__, iface, up ? "up" : "down");
@@ -723,14 +735,13 @@
 net_iface=
_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
=
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ret =
=3D -1;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifindex =3D if_nam=
etoindex(iface);
-    if (ifindex =3D=3D 0)
+    if (get_ifindex(__func__, =
iface, &ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cann=
ot get ifindex for %s", __func__, iface);
         return -1;
     }
 
@@ -=
739,7 +750,7 @@
     req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=
=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi_index =3D ifindex;
+    req=
=2Ei=2Eifi_index =3D (int)ifindex;
 
     SITNL_ADDATTR(&req=2En, sizeof(re=
q), IFLA_MTU, &mtu, 4);
 
@@ -754,14 +765,13 @@
 net_addr_ll_set(const open=
vpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
   =
  struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ret =3D=
 -1;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifindex =3D if_nameto=
index(iface);
-    if (ifindex =3D=3D 0)
+    if (get_ifindex(__func__, ifa=
ce, &ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot =
get ifindex for %s", __func__, iface);
         return -1;
     }
 
@@ -770=
,7 +780,7 @@
     req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=2Eif=
i_family =3D AF_PACKET;
-    req=2Ei=2Eifi_index =3D ifindex;
+    req=2Ei=
=2Eifi_index =3D (int)ifindex;
 
     SITNL_ADDATTR(&req=2En, sizeof(req), =
IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);
 
@@ -782,22 +792,19 @@
 }
 
 static=
 int
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t=
 af_family,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, const char *iface=
, sa_family_t af_family,
                const inet_address_t *local, const=
 inet_address_t *remote, int prefixlen)
 {
     struct sitnl_addr_req req;
=
-    uint32_t size;
-    int ret =3D -EINVAL;
+    size_t size;
+    uint32=
_t ifindex;
 
-    CLEAR(req);
-
-    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(=
sizeof(req=2Ei));
-    req=2En=2Enlmsg_type =3D cmd;
-    req=2En=2Enlmsg_f=
lags =3D NLM_F_REQUEST | flags;
-
-    req=2Ei=2Eifa_index =3D ifindex;
-  =
  ASSERT(af_family <=3D UINT8_MAX);
-    req=2Ei=2Eifa_family =3D (uint8_t)=
af_family;
+    int ret =3D get_ifindex(__func__, iface, &ifindex);
+    if=
 (ret < 0)
+    {
+        return ret;
+    }
+    ret =3D -EINVAL; /* for =
SITNL_ADDATTR */
 
     switch (af_family)
     {
@@ -814,10 +821,20 @@
   =
          return -EINVAL;
     }
 
+    CLEAR(req);
+
+    req=2En=2Enlmsg_=
len =3D NLMSG_LENGTH(sizeof(req=2Ei));
+    req=2En=2Enlmsg_type =3D cmd;
+=
    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;
+
+    req=2Ei=2Eifa_i=
ndex =3D ifindex;
+    ASSERT(af_family <=3D UINT8_MAX);
+    req=2Ei=2Eifa=
_family =3D (uint8_t)af_family;
+
     /* if no prefixlen has been specifie=
d, assume host address */
     if (prefixlen =3D=3D 0)
     {
-        pref=
ixlen =3D size * 8;
+        prefixlen =3D (int)size * 8;
     }
     ASSER=
T(prefixlen <=3D UINT8_MAX);
     req=2Ei=2Eifa_prefixlen =3D (uint8_t)pref=
ixlen;
@@ -852,76 +869,37 @@
 sitnl_addr_ptp_add(sa_family_t af_family, con=
st char *iface, const inet_address_t *local,
                    const inet=
_address_t *remote)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-=
        case AF_INET:
-        case AF_INET6:
-            break;
-
-      =
  default:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
- =
       msg(M_WARN, "%s: passed NULL interface", __func__);
-        return =
-EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =
=3D=3D 0)
-    {
-        msg(M_WARN, "%s: cannot get ifindex for %s: %s", =
__func__, np(iface), strerror(errno));
-        return -ENOENT;
-    }
-
- =
   return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex=
, af_family, local,
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | =
NLM_F_REPLACE, iface, af_family, local,
                           remote, =
0);
 }
 
 static int
 sitnl_addr_ptp_del(sa_family_t af_family, const char =
*iface, const inet_address_t *local)
 {
-    int ifindex;
-
-    switch (af=
_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-           =
 break;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (=
!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);=

-        return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
=
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: canno=
t get ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
=
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL,=
 0);
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, local, NU=
LL, 0);
 }
 
 static int
-sitnl_route_set(uint16_t cmd, uint16_t flags, int=
 ifindex, sa_family_t af_family, const void *dst,
+sitnl_route_set(uint16_t=
 cmd, uint16_t flags, const char *iface, sa_family_t af_family, const void =
*dst,
                 int prefixlen, const void *gw, enum rt_class_t table=
, int metric,
                 enum rt_scope_t scope, unsigned char protoco=
l, unsigned char type)
 {
     struct sitnl_route_req req;
-    int ret =3D=
 -1, size;
+    int ret =3D -1; /* for SITNL_ADDATTR */
+    size_t size;
+=
    uint32_t ifindex =3D 0;
 
     CLEAR(req);
 
+    if (iface)
+    {
+  =
      const int ifi_ret =3D get_ifindex(__func__, iface, &ifindex);
+      =
  if (ifi_ret < 0)
+        {
+            return ifi_ret;
+        }
+    =
}
+
     switch (af_family)
     {
         case AF_INET:
@@ -986,64 +964,1=
4 @@
 static int
 sitnl_addr_add(sa_family_t af_family, const char *iface, =
const inet_address_t *addr, int prefixlen)
 {
-    int ifindex;
-
-    swit=
ch (af_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-     =
       break;
-
-        default:
-            return -EINVAL;
-    }
-
-  =
  if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __fu=
nc__);
-        return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(if=
ace);
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s:=
 rtnl: cannot get ifindex for %s", __func__, iface);
-        return -ENOEN=
T;
-    }
-
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_RE=
PLACE, ifindex, af_family, addr, NULL,
+    return sitnl_addr_set(RTM_NEWAD=
DR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, addr, NULL,
           =
                prefixlen);
 }
 
 static int
 sitnl_addr_del(sa_family_t af=
_family, const char *iface, const inet_address_t *addr, int prefixlen)
 {
-=
    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:
- =
       case AF_INET6:
-            break;
-
-        default:
-            =
return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: =
passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    i=
findex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-      =
  msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, if=
ace);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_DELA=
DDR, 0, ifindex, af_family, addr, NULL, prefixlen);
+    return sitnl_addr_=
set(RTM_DELADDR, 0, iface, af_family, addr, NULL, prefixlen);
 }
 
 int
@@ =
-1190,17 +1118,6 @@
                 const void *gw, uint32_t table, int me=
tric)
 {
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;
-    int ifindex=
 =3D 0;
-
-    if (iface)
-    {
-        ifindex =3D if_nametoindex(iface)=
;
-        if (ifindex =3D=3D 0)
-        {
-            msg(M_WARN | M_ERR=
NO, "%s: rtnl: can't get ifindex for %s", __func__, iface);
-            re=
turn -ENOENT;
-        }
-    }
 
     if (table =3D=3D 0)
     {
@@ -1212,=
7 +1129,7 @@
         scope =3D RT_SCOPE_LINK;
     }
 
-    return sitnl_r=
oute_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw=
,
+    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_family,=
 dst, prefixlen, gw,
                            table, metric, scope, RTPR=
OT_BOOT, RTN_UNICAST);
 }
 
@@ -1277,24 +1194,12 @@
 sitnl_route_del(const =
char *iface, sa_family_t af_family, const inet_address_t *dst, int prefixle=
n,
                 const inet_address_t *gw, uint32_t table, int metric)
 =
{
-    int ifindex =3D 0;
-
-    if (iface)
-    {
-        ifindex =3D if_=
nametoindex(iface);
-        if (ifindex =3D=3D 0)
-        {
-            =
msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __func__, iface=
);
-            return -ENOENT;
-        }
-    }
-
     if (table =3D=3D 0=
)
     {
         table =3D RT_TABLE_MAIN;
     }
 
-    return sitnl_route=
_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric=
,
+    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefi=
xlen, gw, table, metric,
                            RT_SCOPE_NOWHERE, 0, 0=
);
 }
 
@@ -1464,7 +1369,7 @@
 net_iface_type(const openvpn_net_ctx_t *ctx,=
 const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_lin=
k_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    int ifin=
dex =3D (int)if_nametoindex(iface);
 
     if (!ifindex)
     {
@@ -1496,7 =
+1401,7 @@
 net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
=
 {
     struct sitnl_link_req req =3D {};
-    int ifindex =3D if_nametoind=
ex(iface);
+    int ifindex =3D (int)if_nametoindex(iface);
 
     if (!ifi=
ndex)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2177?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6=
f5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-P=
atchSet: 5
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@=
greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--R1Bs5lIW7is=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2177?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by =
R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">networking_sitnl: Reduce boilerplate =
code for parameter checks<br><br>Also removes some inconsistencies and some=
<br>sign conversion warnings=2E<br><br>Change-Id: I6f5ca53d4288b0921610f7a3=
f84ad55d2ab49118<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177<br>Message-Id: &l=
t;20261116120513=2E24130-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41423=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 74 insertions(+), 16=
9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/77/2177/5</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>i=
ndex d5ec6bb=2E=2Eb7c0f58 100644</span><br><span>--- a/src/openvpn/networki=
ng_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><=
br><span>@@ -677,25 +677,37 @@</span><br><span> </span><br><span> #ifdef EN=
ABLE_SITNL</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
get_ifindex(const char *func, const char *iface, uint32_t *ifindex)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!iface)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN, &quot;%s: passed NULL interface&quot;, func=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -E=
INVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    *ifindex =3D if_nametoindex(iface);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*ifindex =3D=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &qu=
ot;%s: rtnl: cannot get ifindex for %s&quot;, func, iface);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> int</span><br><span> net_iface_up(const openvpn_net_ctx_t *ctx, const =
char *iface, bool up)</span><br><span> {</span><br><span>     struct sitnl_=
link_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_=
t ifindex;</span><br><span> </span><br><span>     CLEAR(req);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ret =3D=
 get_ifindex(__func__, iface, &amp;ifindex);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s:=
 passed NULL interface&quot;, __func__);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return -EINVAL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D =
if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(M_WARN, &quot;%s: rtnl: cannot get ifindex for %s: %s&quot;, __func__, ifa=
ce, strerror(errno));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return ret;</span><br><span>     }</span><br><span> </span><br>=
<span>     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br=
><span>@@ -703,7 +715,7 @@</span><br><span>     req=2En=2Enlmsg_type =3D RT=
M_SETLINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi_family =3D =
AF_PACKET;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=
=2Eifi_index =3D ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    req=2Ei=2Eifi_index =3D (int)ifindex;</span><br><span>     req=2E=
i=2Eifi_change |=3D IFF_UP;</span><br><span>     if (up)</span><br><span>  =
   {</span><br><span>@@ -711,7 +723,7 @@</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        req=2Ei=2Eifi_flags &amp;=3D ~IFF_UP;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        req=2Ei=2Eifi_flags &amp;=
=3D ~(unsigned int)IFF_UP;</span><br><span>     }</span><br><span> </span><=
br><span>     msg(M_INFO, &quot;%s: set %s %s&quot;, __func__, iface, up ? =
&quot;up&quot; : &quot;down&quot;);</span><br><span>@@ -723,14 +735,13 @@</=
span><br><span> net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char =
*iface, uint32_t mtu)</span><br><span> {</span><br><span>     struct sitnl_=
link_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
ifindex, ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint32_t ifindex;</span><br><span> </span><br><span>     CLEAR(req);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
findex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (get_ifindex(__func__, iface, &amp;ifindex) &lt; 0=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&=
quot;, __func__, iface);</span><br><span>         return -1;</span><br><spa=
n>     }</span><br><span> </span><br><span>@@ -739,7 +750,7 @@</span><br><s=
pan>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> </span><br>=
<span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D ifindex;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_index =3D (int)=
ifindex;</span><br><span> </span><br><span>     SITNL_ADDATTR(&amp;req=2En,=
 sizeof(req), IFLA_MTU, &amp;mtu, 4);</span><br><span> </span><br><span>@@ =
-754,14 +765,13 @@</span><br><span> net_addr_ll_set(const openvpn_net_ctx_t=
 *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)</span><br><span> {<=
/span><br><span>     struct sitnl_link_req req;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int ifindex, ret =3D -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span> <=
/span><br><span>     CLEAR(req);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (get_ifindex(__f=
unc__, iface, &amp;ifindex) &lt; 0)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s=
: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</span><br><span>=
         return -1;</span><br><span>     }</span><br><span> </span><br><spa=
n>@@ -770,7 +780,7 @@</span><br><span>     req=2En=2Enlmsg_type =3D RTM_SET=
LINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi_family =3D AF_PA=
CKET;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eif=
i_index =3D ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    req=2Ei=2Eifi_index =3D (int)ifindex;</span><br><span> </span><br><spa=
n>     SITNL_ADDATTR(&amp;req=2En, sizeof(req), IFLA_ADDRESS, addr, OPENVPN=
_ETH_ALEN);</span><br><span> </span><br><span>@@ -782,22 +792,19 @@</span><=
br><span> }</span><br><span> </span><br><span> static int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uint16_t f=
lags, int ifindex, sa_family_t af_family,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+sitnl_addr_set(uint16_t cmd, uint16_t flags, const ch=
ar *iface, sa_family_t af_family,</span><br><span>                const ine=
t_address_t *local, const inet_address_t *remote, int prefixlen)</span><br>=
<span> {</span><br><span>     struct sitnl_addr_req req;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    uint32_t size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -EINVAL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(req);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(re=
q=2Ei));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2En=
=2Enlmsg_type =3D cmd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    req=2Ei=2Eifa_index =3D ifindex;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(af_family &lt;=3D UINT8_MAX);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifa_family =3D (=
uint8_t)af_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int ret =3D get_ifindex(__func__, iface, &amp;ifindex);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return ret;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ret =3D -EINVAL; /* for SITNL_ADDATTR */</span><br><span> </=
span><br><span>     switch (af_family)</span><br><span>     {</span><br><sp=
an>@@ -814,10 +821,20 @@</span><br><span>             return -EINVAL;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=
=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D cmd;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_flags =
=3D NLM_F_REQUEST | flags;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=
=2Eifa_index =3D ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(af_family &lt;=3D UINT8_MAX);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    req=2Ei=2Eifa_family =3D (uint8_t)af_family;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   /* if no prefixlen has been specified, assume host address */</span><br>=
<span>     if (prefixlen =3D=3D 0)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        prefixlen =3D size * 8;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        prefixlen =3D (int)=
size * 8;</span><br><span>     }</span><br><span>     ASSERT(prefixlen &lt;=
=3D UINT8_MAX);</span><br><span>     req=2Ei=2Eifa_prefixlen =3D (uint8_t)p=
refixlen;</span><br><span>@@ -852,76 +869,37 @@</span><br><span> sitnl_addr=
_ptp_add(sa_family_t af_family, const char *iface, const inet_address_t *lo=
cal,</span><br><span>                    const inet_address_t *remote)</spa=
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
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot=
 get ifindex for %s: %s&quot;, __func__, np(iface), strerror(errno));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_RE=
PLACE, ifindex, af_family, local,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_R=
EPLACE, iface, af_family, local,</span><br><span>                          =
 remote, 0);</span><br><span> }</span><br><span> </span><br><span> static i=
nt</span><br><span> sitnl_addr_ptp_del(sa_family_t af_family, const char *i=
face, const inet_address_t *local)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    switch (af_family)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ase AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ase AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return -EINVAL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_W=
ARN, &quot;%s: passed NULL interface&quot;, __func__);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifindex for %s&quot;,=
 __func__, iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR,=
 0, ifindex, af_family, local, NULL, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_fa=
mily, local, NULL, 0);</span><br><span> }</span><br><span> </span><br><span=
> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_rou=
te_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, co=
nst void *dst,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl=
_route_set(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_=
family, const void *dst,</span><br><span>                 int prefixlen, co=
nst void *gw, enum rt_class_t table, int metric,</span><br><span>          =
       enum rt_scope_t scope, unsigned char protocol, unsigned char type)</=
span><br><span> {</span><br><span>     struct sitnl_route_req req;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -1, size;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1; /* f=
or SITNL_ADDATTR */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    size_t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint32_t ifindex =3D 0;</span><br><span> </span><br><span>     CLEAR(req);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int if=
i_ret =3D get_ifindex(__func__, iface, &amp;ifindex);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (ifi_ret &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return ifi_ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     switch (af_family)</span><br><spa=
n>     {</span><br><span>         case AF_INET:</span><br><span>@@ -986,64 =
+964,14 @@</span><br><span> static int</span><br><span> sitnl_addr_add(sa_f=
amily_t af_family, const char *iface, const inet_address_t *addr, int prefi=
xlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af_family)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            return -EINVAL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL i=
nterface&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex=
(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifind=
ex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ER=
RNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_=
REPLACE, ifindex, af_family, addr, NULL,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | =
NLM_F_REPLACE, iface, af_family, addr, NULL,</span><br><span>              =
             prefixlen);</span><br><span> }</span><br><span> </span><br><sp=
an> static int</span><br><span> sitnl_addr_del(sa_family_t af_family, const=
 char *iface, const inet_address_t *addr, int prefixlen)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    switch (af_family)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        case AF_INET:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        case AF_INET6:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        de=
fault:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func__)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -EINV=
AL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cann=
ot get ifindex for %s&quot;, __func__, iface);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_ad=
dr_set(RTM_DELADDR, 0, iface, af_family, addr, NULL, prefixlen);</span><br>=
<span> }</span><br><span> </span><br><span> int</span><br><span>@@ -1190,17=
 +1118,6 @@</span><br><span>                 const void *gw, uint32_t table=
, int metric)</span><br><span> {</span><br><span>     enum rt_scope_t scope=
 =3D RT_SCOPE_UNIVERSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int ifindex =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (iface)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoindex(iface)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ifindex =
=3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN |=
 M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__, ifa=
ce);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retur=
n -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> =
</span><br><span>     if (table =3D=3D 0)</span><br><span>     {</span><br>=
<span>@@ -1212,7 +1129,7 @@</span><br><span>         scope =3D RT_SCOPE_LIN=
K;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE=
, ifindex, af_family, dst, prefixlen, gw,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE=
, iface, af_family, dst, prefixlen, gw,</span><br><span>                   =
         table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span><br><span> =
}</span><br><span> </span><br><span>@@ -1277,24 +1194,12 @@</span><br><span=
> sitnl_route_del(const char *iface, sa_family_t af_family, const inet_addr=
ess_t *dst, int prefixlen,</span><br><span>                 const inet_addr=
ess_t *gw, uint32_t table, int metric)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (iface)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (ifindex =3D=3D 0)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get i=
findex for %s&quot;, __func__, iface);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            return -ENOENT;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     if (table =3D=3D 0)</span><br><span>     {</span><br><span=
>         table =3D RT_TABLE_MAIN;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_rout=
e_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metri=
c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_=
route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, met=
ric,</span><br><span>                            RT_SCOPE_NOWHERE, 0, 0);</=
span><br><span> }</span><br><span> </span><br><span>@@ -1464,7 +1369,7 @@</=
span><br><span> net_iface_type(const openvpn_net_ctx_t *ctx, const char *if=
ace, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><br><span>    =
 struct sitnl_link_req req =3D {};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int ifindex =3D if_nametoindex(iface);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int ifindex =3D (int)if_nametoindex=
(iface);</span><br><span> </span><br><span>     if (!ifindex)</span><br><sp=
an>     {</span><br><span>@@ -1496,7 +1401,7 @@</span><br><span> net_iface_=
del(const openvpn_net_ctx_t *ctx, const char *iface)</span><br><span> {</sp=
an><br><span>     struct sitnl_link_req req =3D {};</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoindex(iface);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex =3D =
(int)if_nametoindex(iface);</span><br><span> </span><br><span>     if (!ifi=
ndex)</span><br><span>     {</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">change 2177</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
f5ca53d4288b0921610f7a3f84ad55d2ab49118 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2177 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--R1Bs5lIW7is=--


--===============1528833171647549191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1528833171647549191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1528833171647549191==--

