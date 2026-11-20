Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88844606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cE5uyMWK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SlEUXF6d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m4/+QRQI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RDhvxWhX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9vbdPWs33Q+w0S/fp0XKIObCGdemy1mid/xK7k9XQ70=; b=cE5uyMWKeim6y3DUJOM9b1z6+9
	Cc1aDVPxF+701yUQlQNVsKy7Bw74+o9jQcrVkAYbUfxlkPfSzBbzPFgguGqyQyh3IGIIbLTllOISp
	xPX71eI7PVFsDFRhlIGS4GMDt8UYGdCDF2x6dqiroJPJsPlYpgaIVKOAk9l8kZ+7cLjA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUINy-000000004Gb-2WZO;
	Fri, 20 Nov 2026 06:46:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUINw-000000004GU-3vld
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gW0VhVRgY1i9FaqYpoNeyKaGUMkw54X6ET/jhn/LOBc=; b=SlEUXF6dIlABMqjW1zXUEgi4ri
 9rQLfqReA7aPA2iytjf4HNzl2FkngkKTAweC1ntzLXWaPONlC2IHGQuvLNZwZVXfxcc9eNhqVHdXc
 rAFW4qg2MOeWiDoHQhQHn9waBgq8xSLd4pDL+NP/b35O1Bt1OaUyKdB3bkFZcDRInZxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gW0VhVRgY1i9FaqYpoNeyKaGUMkw54X6ET/jhn/LOBc=; b=m4/+QRQIOEuHrA6U8SdNsltSFT
 6HyItfA8wyON6s2nSu+rcyuHqjmFbZ8gy1QATNfic/NxpURFHa6/EV240Xj9fpSvQDCqHHVb7QFPa
 l1PHjWgQ4Z8LKhbQMKuk/C2ftNrKXELfeQALqIZdhgXgG+bthS+PxOPWigb6IwY8p0mc=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUINs-000000004OW-3dEQ for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:46:12 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso2342835e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 22:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795157162; x=1795761962; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gW0VhVRgY1i9FaqYpoNeyKaGUMkw54X6ET/jhn/LOBc=;
 b=RDhvxWhXmWi4gSTjmhX6G0x2HIJT7x5rV514KqP/ujOod+7rGTpSbFNezKtQ/QOfop
 /7B818xbYH3Ayou0M5o+5ASGpkkdU3o++7jF3HPkzWL76C8JoiEWdb/gqrhw4nhBrz6P
 dHCWLsCx+8M6Mr2rCDJe3qH+zwuxI4ZJ55rBzOlOqej6mS+H+qpW3MvoDPgWrOAc3CIM
 poQZfBPnPDSF3BOXmZeSbLdB7nic/n+cjRpThuokDFmGTE25udeobXbugArFJjcWpilY
 bheVoHWHuGLC5k8cI2WgqIgFDOjH3J4ZWu6jwgRRya+xR+iqyVtAyZhIILYzfMSd7X+m
 V5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795157162; x=1795761962;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gW0VhVRgY1i9FaqYpoNeyKaGUMkw54X6ET/jhn/LOBc=;
 b=wyjxLSw1UKqeaX1mlPjQxxswEwhH5yuqWc72SL320QpNdJeprMNxSCMfIjoC3Z1YVV
 NLKyVKUuERowj9V6XmlOHe14ro+66kOp/UfaMBdjj6YMbtT1vPg7bytlx/+kWT1iYy7W
 AVkd8FPcpGSuN7rJVL1Kb57c9ja5sIZYCdP18sRJVV2oKOUorELDQ84bE3oJZ/NNGMDe
 Rf6tEwyxEmuVePnAQLd30pfYLy7XpcDHbKWqOUY8TpqC/w3y1RYpB0eurGfhAiA0MG3b
 NVseI8BReUgeoFxiuBAh9iVAWO5vz/fz4BP+DPsXE/RyTvn7I2s3eBSb6bSlGHjdWFrL
 hGEA==
X-Gm-Message-State: APuU4Z+C7s3ERFLRYIZip+tjUUMp/5BBY0zlsInGueFtFfzD2zEWxA5d
 xj+mKwMu3dGBQ0y909a6h6u2WVn6WmjJpx+kEPl090KRd+ZqFFJHIhctClAgmaT43jutRSXjPWu
 4I290mUCeUxGWRePp9cEOZb94jgZzochad2rMo57aGqJnsQjzj+BOzj6G4WfOplwqPh+9
X-Gm-Gg: AYBFou0XhCcn3iWRzEkDh0Bz/gNUExsXT7Mxbje5sd5VJaMWanQQXaKi7+5Gri6C741
 HLB51YJrk7KDhDdMA9iWF6xnK74kptB7Rnk+i8T1m1RAIqzGn9j2DtgNkwymn4q9hMj9pzKxJt9
 ClJG5Ggcn8dYF1yGuXxYLtdx+Kre8N0MteWFaqxshLPkKDH281EJpseVY110zH50NOyKHoK4iYq
 Ml2nT5D6/0S7z5zwqJ2pIBs5dEcTH+t/xHZoPHeVjlxjKowo2sjPnWDxeyW8vWcUSnCRdZOgGTk
 Ut1QqXj80Sur244vr9jQbL/IH6B44vQU00vPhMNjQPEkPtRHW1tIMUHN5KxaSF2UO0b4iKFHKVX
 5aLTPZ5L33ihGVcU/XOiBGEmPZcf7y0ZDHZQ2FvRetMc/a479KP16pn9TyYQgLNvE6TV7JsME9L
 aVTyqeSWHHE1DRdJFFuCiTk8uYyUCRnoxUm607ePc6sXNRAoKvljGhATR7EcY2QGXeVNi1nq6Hr
 3jhKtmH3LrEe6ZZX7ufOhFUr18/CmPRsMd87oHzh1q1hQ4JexFiCBwKdOMaxBl+kcT3K8hQ7RUm
 BwkfQQd6O9SOpV/vfPTJfqtfRJJUj35+/wmXrB3LueZwJaFHfnrMic4xcCfTssSNHt6+xt4QRuB
 t+qxmZh6YQ4HkIqH4kUH96ZMOsOag0XjifxE7bmvZPJUD6vuZZv5Kq9WhlqkHk0D+ujL/zP0uoL
 zfWTWmnK0uWvoFSSg=
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4bb88922c81mr42435595e9.32.1795157161932; 
 Thu, 19 Nov 2026 22:46:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm2768639f8f.18.2026.11.19.22.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:46:01 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 06:45:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: a6fa3565e5d5aab43dd9e074e57fafd25ac96d70
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <090e74ef727f45425771553416e07eea1335885b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUINs-000000004OW-3dEQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use -1
 for "no route table"
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2319465040799730995=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2319465040799730995==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l+eDFmhYD0I="; charset=UTF-8

--l+eDFmhYD0I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2224?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: networking: use -1 for "no route table"
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking: use -1 for=
 "no route table"

Table 0 meant "default table" in the net_route_*() API=
=2E That is fine on
Linux, where table 0 is RT_TABLE_UNSPEC, but on FreeBSD=
 FIB 0 is a real
FIB, which could then not be selected from a process runni=
ng in another
FIB=2E

Make the table argument an int, with -1 for the defau=
lt table, and
default --route-table to -1=2E An invalid --route-table value=
 is now
an error, instead of table 0=2E sitnl maps -1 and 0 to the main tab=
le, as
before=2E On FreeBSD, -fib is now passed only for a set table; DCO
i=
routes no longer force FIB 0 but use the FIB of the process=2E

Routes that=
 route=2Ec creates internally get -1 too; block-local routes
passed an unin=
itialized table before=2E

Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad8625=
97b9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openv=
pn/dco=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/networking_freebsd=2E=
c
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
=
M src/openvpn/options=2Ec
M src/openvpn/route=2Ec
M tests/unit_tests/openvp=
n/test_networking=2Ec
8 files changed, 71 insertions(+), 63 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24/2224/=
2

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 236be93=2E=
=2E8d376fb 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -7=
21,7 +721,7 @@
         }
 
         net_route_v6_add(&m->top=2Enet_ctx, &a=
ddr->v6=2Eaddr, addr->netbits,
-                         gateway, c->c1=2Et=
untap->actual_name, 0,
+                         gateway, c->c1=2Etuntap->a=
ctual_name, -1,
                          DCO_IROUTE_METRIC);
 #endif
     =
}
@@ -739,7 +739,7 @@
         }
 
         net_route_v4_add(&m->top=2Enet_=
ctx, &dest, addr->netbits, gateway,
-                         c->c1=2Etunta=
p->actual_name, 0, DCO_IROUTE_METRIC);
+                         c->c1=2Etu=
ntap->actual_name, -1, DCO_IROUTE_METRIC);
 #endif
     }
 #endif /* if def=
ined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
@@ -765=
,7 +765,7 @@
             dco_win_del_iroute_ipv4(&c->c1=2Etuntap->dco, hto=
nl(ir->network), ir->netbits);
 #else
             net_route_v4_del(net_ctx=
, &ir->network, ir->netbits,
-                             &c->c2=2Epush_if=
config_local, c->c1=2Etuntap->actual_name, 0,
+                            =
 &c->c2=2Epush_ifconfig_local, c->c1=2Etuntap->actual_name, -1,
           =
                   DCO_IROUTE_METRIC);
 #endif
         }
@@ -779,7 +779,7 =
@@
         {
             /* On windows we do not install these routes, so=
 we also do not need to delete them */
             net_route_v4_del(net_ct=
x, &ifconfig_local, 32, NULL,
-                             c->c1=2Etuntap-=
>actual_name, 0, DCO_IROUTE_METRIC);
+                             c->c1=2E=
tuntap->actual_name, -1, DCO_IROUTE_METRIC);
         }
 #endif
     }
@@ -=
792,7 +792,7 @@
             dco_win_del_iroute_ipv6(&c->c1=2Etuntap->dco, =
ir6->network, ir6->netbits);
 #else
             net_route_v6_del(net_ctx, =
&ir6->network, ir6->netbits,
-                             &c->c2=2Epush_if=
config_ipv6_local, c->c1=2Etuntap->actual_name, 0,
+                       =
      &c->c2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->actual_name, -1,
 =
                             DCO_IROUTE_METRIC);
 #endif
         }
@@ -805=
,7 +805,7 @@
         {
             /* On windows we do not install these =
routes, so we also do not need to delete them */
             net_route_v6_=
del(net_ctx, dest, 128, NULL,
-                             c->c1=2Etuntap-=
>actual_name, 0, DCO_IROUTE_METRIC);
+                             c->c1=2E=
tuntap->actual_name, -1, DCO_IROUTE_METRIC);
         }
 #endif
     }
diff=
 --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index 7ad6=
e2e=2E=2E1763e64 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/=
networking=2Eh
@@ -245,14 +245,13 @@
  * @param prefixlen the length of the=
 prefix of the destination
  * @param gw        the gateway for this route
=
  * @param iface     the interface for this route (can be NULL)
- * @param =
table     the table to add this route to (if 0, will be added to the
- *   =
               main table)
+ * @param table     the table to add this route=
 to, or -1 for the default one
  * @param metric    the metric associated w=
ith the route
  *
  * @return          0 on success, a negative error code =
otherwise
  */
 int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in=
_addr_t *dst, int prefixlen,
-                     const in_addr_t *gw, con=
st openvpn_net_iface_t *iface, uint32_t table,
+                     const =
in_addr_t *gw, const openvpn_net_iface_t *iface, int table,
               =
       int metric);
 
 /**
@@ -263,14 +262,13 @@
  * @param prefixlen the l=
ength of the prefix of the destination
  * @param gw        the gateway for=
 this route
  * @param iface     the interface for this route (can be NULL)=

- * @param table     the table to add this route to (if 0, will be added t=
o the
- *                  main table)
+ * @param table     the table to ad=
d this route to, or -1 for the default one
  * @param metric    the metric =
associated with the route
  *
  * @return          0 on success, a negative=
 error code otherwise
  */
 int net_route_v6_add(const openvpn_net_ctx_t *c=
tx, const struct in6_addr *dst, int prefixlen,
-                     const =
struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
+   =
                  const struct in6_addr *gw, const openvpn_net_iface_t *ifa=
ce, int table,
                      int metric);
 
 /**
@@ -281,14 +279,13=
 @@
  * @param prefixlen the length of the prefix of the destination
  * @p=
aram gw        the gateway for this route
  * @param iface     the interfac=
e for this route (can be NULL)
- * @param table     the table to add this r=
oute to (if 0, will be added to the
- *                  main table)
+ * @p=
aram table     the table to add this route to, or -1 for the default one
  =
* @param metric    the metric associated with the route
  *
  * @return    =
      0 on success, a negative error code otherwise
  */
 int net_route_v4_=
del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
-   =
                  const in_addr_t *gw, const openvpn_net_iface_t *iface, ui=
nt32_t table,
+                     const in_addr_t *gw, const openvpn_net_=
iface_t *iface, int table,
                      int metric);
 
 /**
@@ -29=
9,14 +296,13 @@
  * @param prefixlen the length of the prefix of the destin=
ation
  * @param gw        the gateway for this route
  * @param iface     =
the interface for this route (can be NULL)
- * @param table     the table t=
o add this route to (if 0, will be added to the
- *                  main t=
able)
+ * @param table     the table to add this route to, or -1 for the de=
fault one
  * @param metric    the metric associated with the route
  *
  *=
 @return          0 on success, a negative error code otherwise
  */
 int n=
et_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, i=
nt prefixlen,
-                     const struct in6_addr *gw, const openvp=
n_net_iface_t *iface, uint32_t table,
+                     const struct in=
6_addr *gw, const openvpn_net_iface_t *iface, int table,
                  =
    int metric);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREE=
BSD */
diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networ=
king_freebsd=2Ec
index 88fd5c0=2E=2E8ba6326 100644
--- a/src/openvpn/networ=
king_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -10,7 +10,7 @@=

 
 static int
 net_route_v4(const char *op, const in_addr_t *dst, int pref=
ixlen, const in_addr_t *gw,
-             const char *iface, uint32_t table=
, int metric)
+             const char *iface, int table, int metric)
 {
  =
   char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
     in_addr_t _dst, =
_gw;
@@ -27,15 +27,20 @@
     if (gw)
     {
         _gw =3D ntohl(*gw);
-=
        argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+=
        argv_printf(&argv, "%s %s -net %s/%d %s", ROUTE_PATH, op,
         =
            inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-    =
                inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+    =
                inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)));
     }
     =
else
     {
-        argv_printf(&argv, "%s %s -net %s/%d -iface %s -fib %d=
", ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s -net %s/%d -iface %s"=
, ROUTE_PATH, op,
                     inet_ntop(AF_INET, &_dst, buf1, size=
of(buf1)), prefixlen,
-                    iface, table);
+                =
    iface);
+    }
+    /* without -fib, route(8) uses the FIB of the proce=
ss */
+    if (table >=3D 0)
+    {
+        argv_printf_cat(&argv, "-fib %=
d", table);
     }
 
     argv_msg(M_INFO, &argv);
@@ -48,7 +53,7 @@
 
 sta=
tic int
 net_route_v6(const char *op, const struct in6_addr *dst, int prefi=
xlen, const struct in6_addr *gw,
-             const char *iface, uint32_t =
table, int metric)
+             const char *iface, int table, int metric)
=
 {
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct ar=
gv argv =3D argv_new();
@@ -61,15 +66,19 @@
      */
     if (gw)
     {
- =
       argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, op,=

+        argv_printf(&argv, "%s -6 %s -net %s/%d %s", ROUTE_PATH, op,
    =
                 inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-=
                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+ =
                   inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));
     }
   =
  else
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s -f=
ib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s -6 %s -net %s/%d -i=
face %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET6, dst, buf=
1, sizeof(buf1)), prefixlen,
-                    iface, table);
+         =
           iface);
+    }
+    if (table >=3D 0)
+    {
+        argv_print=
f_cat(&argv, "-fib %d", table);
     }
 
 
@@ -83,28 +92,28 @@
 
 int
 net_=
route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefix=
len, const in_addr_t *gw,
-                 const char *iface, uint32_t tab=
le, int metric)
+                 const char *iface, int table, int metric)=

 {
     return net_route_v4("add", dst, prefixlen, gw, iface, table, metri=
c);
 }
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct =
in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, =
const char *iface, uint32_t table, int metric)
+                 const stru=
ct in6_addr *gw, const char *iface, int table, int metric)
 {
     return n=
et_route_v6("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 ne=
t_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pref=
ixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t t=
able, int metric)
+                 const char *iface, int table, int metri=
c)
 {
     return net_route_v4("del", dst, prefixlen, gw, iface, table, met=
ric);
 }
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struc=
t in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw=
, const char *iface, uint32_t table, int metric)
+                 const st=
ruct in6_addr *gw, const char *iface, int table, int metric)
 {
     return=
 net_route_v6("del", dst, prefixlen, gw, iface, table, metric);
 }
diff --g=
it a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=
=2Ec
index d987478=2E=2E6c4c8f4 100644
--- a/src/openvpn/networking_iproute=
2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -243,7 +243,7 @@
 
 int
=
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int p=
refixlen, const in_addr_t *gw,
-                 const char *iface, uint32_=
t table, int metric)
+                 const char *iface, int table, int me=
tric)
 {
     struct argv argv =3D argv_new();
     const char *dst_str =3D=
 print_in_addr_t(*dst, 0, &argv=2Egc);
@@ -281,7 +281,7 @@
 
 int
 net_rout=
e_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pref=
ixlen,
-                 const struct in6_addr *gw, const char *iface, uint=
32_t table, int metric)
+                 const struct in6_addr *gw, const =
char *iface, int table, int metric)
 {
     struct argv argv =3D argv_new()=
;
     char *dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
@@ -3=
14,7 +314,7 @@
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const=
 in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 cons=
t char *iface, uint32_t table, int metric)
+                 const char *if=
ace, int table, int metric)
 {
     struct argv argv =3D argv_new();
     c=
onst char *dst_str =3D print_in_addr_t(*dst, 0, &argv=2Egc);
@@ -340,7 +340=
,7 @@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct i=
n6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, c=
onst char *iface, uint32_t table, int metric)
+                 const struc=
t in6_addr *gw, const char *iface, int table, int metric)
 {
     struct ar=
gv argv =3D argv_new();
     char *dst_str =3D (char *)print_in6_addr(*dst,=
 0, &argv=2Egc);
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvp=
n/networking_sitnl=2Ec
index b7c0f58=2E=2Eaf4ed27 100644
--- a/src/openvpn/=
networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1115,14 +11=
15,11 @@
 
 static int
 sitnl_route_add(const char *iface, sa_family_t af_f=
amily, const void *dst, int prefixlen,
-                const void *gw, uin=
t32_t table, int metric)
+                const void *gw, int table, int me=
tric)
 {
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;
-
-    if (table=
 =3D=3D 0)
-    {
-        table =3D RT_TABLE_MAIN;
-    }
+    /* table 0 =
is RT_TABLE_UNSPEC */
+    const uint32_t rt_table =3D table > 0 ? (uint32_=
t)table : RT_TABLE_MAIN;
 
     if (!gw && iface)
     {
@@ -1130,12 +1127,=
12 @@
     }
 
     return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifac=
e, af_family, dst, prefixlen, gw,
-                           table, metric=
, scope, RTPROT_BOOT, RTN_UNICAST);
+                           rt_table, m=
etric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
 int
 net_route_v4_add(const =
openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_=
t *gw,
-                 const char *iface, uint32_t table, int metric)
+  =
               const char *iface, int table, int metric)
 {
     const in_a=
ddr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
     in_addr_t dst_be =3D 0, gw_=
be =3D 0;
@@ -1154,7 +1151,7 @@
         gw_ptr =3D &gw_be;
     }
 
-    m=
sg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    ms=
g(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
        =
 inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
        =
 inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table, metr=
ic);
 
@@ -1163,7 +1160,7 @@
 
 int
 net_route_v6_add(const openvpn_net_ctx=
_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const=
 struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+     =
            const struct in6_addr *gw, const char *iface, int table, int me=
tric)
 {
     inet_address_t dst_v6;
     inet_address_t gw_v6;
@@ -1183,7 =
+1180,7 @@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %=
s/%d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s=
/%d via %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET=
6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop=
(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric=
);
 
@@ -1192,20 +1189,18 @@
 
 static int
 sitnl_route_del(const char *ifa=
ce, sa_family_t af_family, const inet_address_t *dst, int prefixlen,
-     =
           const inet_address_t *gw, uint32_t table, int metric)
+         =
       const inet_address_t *gw, int table, int metric)
 {
-    if (table =
=3D=3D 0)
-    {
-        table =3D RT_TABLE_MAIN;
-    }
+    /* table 0 i=
s RT_TABLE_UNSPEC */
+    const uint32_t rt_table =3D table > 0 ? (uint32_t=
)table : RT_TABLE_MAIN;
 
-    return sitnl_route_set(RTM_DELROUTE, 0, ifac=
e, af_family, dst, prefixlen, gw, table, metric,
+    return sitnl_route_se=
t(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, rt_table, metric,
=
                            RT_SCOPE_NOWHERE, 0, 0);
 }
 
 int
 net_route_v=
4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, co=
nst in_addr_t *gw,
-                 const char *iface, uint32_t table, int=
 metric)
+                 const char *iface, int table, int metric)
 {
   =
  inet_address_t dst_v4;
     inet_address_t gw_v4;
@@ -1225,7 +1220,7 @@
 =
        gw_v4=2Eipv4 =3D htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d =
via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d v=
ia %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET, &ds=
t_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_IN=
ET, &gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@=
 -1234,7 +1229,7 @@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, =
const struct in6_addr *dst, int prefixlen,
-                 const struct i=
n6_addr *gw, const char *iface, uint32_t table, int metric)
+              =
   const struct in6_addr *gw, const char *iface, int table, int metric)
 {
=
     inet_address_t dst_v6;
     inet_address_t gw_v6;
@@ -1254,7 +1249,7 @=
@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via =
%s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %=
s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v=
6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6=
, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 947439d=2E=
=2E35fbe39 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -831,7 +831,7 @@
     o->ce=2Emssfix =3D 0;
     o->ce=2Emssfix_def=
ault =3D true;
     o->ce=2Emssfix_encap =3D true;
-    o->route_default_ta=
ble_id =3D 0;
+    o->route_default_table_id =3D -1;
     o->route_delay_wi=
ndow =3D 30;
     o->resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;
     =
o->resolve_in_advance =3D false;
@@ -5297,7 +5297,11 @@
         msg(M_WARN=
, "NOTE: --route-table is supported only on Linux when SITNL is built-in");=

 #endif
         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
-        options->r=
oute_default_table_id =3D positive_atoi(p[1], msglevel);
+        if (!atoi=
_constrained(p[1], &options->route_default_table_id, p[0], 0, INT_MAX,
+   =
                           msglevel))
+        {
+            goto err;
+  =
      }
     }
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
=
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 9086529=2E=
=2E8c493ee 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@=
@ -545,6 +545,7 @@
         /* split a route into two smaller blocking rout=
es, and direct them to target */
         l2 =3D ((~gateway->netmask) + 1) =
>> 1;
         r1->flags =3D RT_DEFINED;
+        r1->table_id =3D -1;
    =
     r1->gateway =3D target;
         r1->network =3D gateway->addr & gatew=
ay->netmask;
         r1->netmask =3D ~(l2 - 1);
@@ -854,6 +855,7 @@
      =
           r6->gateway =3D rl6->rgi6=2Egateway=2Eaddr_ipv6;
             }
=
             r6->metric =3D 1;
+            r6->table_id =3D -1;
 #ifdef _W=
IN32
             r6->adapter_index =3D rl6->rgi6=2Eadapter_index;
 #else
@=
@ -883,6 +885,7 @@
     struct route_ipv4 r;
     CLEAR(r);
     r=2Eflags =
=3D RT_DEFINED;
+    r=2Etable_id =3D -1;
     r=2Enetwork =3D network;
   =
  r=2Enetmask =3D netmask;
     r=2Egateway =3D gateway;
@@ -897,6 +900,7 @=
@
     struct route_ipv4 r;
     CLEAR(r);
     r=2Eflags =3D RT_DEFINED | =
RT_ADDED;
+    r=2Etable_id =3D -1;
     r=2Enetwork =3D network;
     r=2E=
netmask =3D netmask;
     r=2Egateway =3D gateway;
diff --git a/tests/unit_=
tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networkin=
g=2Ec
index b580d32=2E=2E95019e5 100644
--- a/tests/unit_tests/openvpn/test=
_networking=2Ec
+++ b/tests/unit_tests/openvpn/test_networking=2Ec
@@ -112,=
7 +112,7 @@
     }
     printf("\n");
 
-    return net_route_v4_add(NULL, =
&dst, prefixlen, NULL, iface, 0, metric);
+    return net_route_v4_add(NULL=
, &dst, prefixlen, NULL, iface, -1, metric);
 }
 
 static int
@@ -148,7 +14=
8,7 @@
     }
     printf("\n");
 
-    return net_route_v4_add(NULL, &dst,=
 prefixlen, &gw, iface, 0, metric);
+    return net_route_v4_add(NULL, &dst=
, prefixlen, &gw, iface, -1, metric);
 }
 
 static int
@@ -175,7 +175,7 @@
=
     }
     printf("\n");
 
-    return net_route_v6_add(NULL, &dst, prefix=
len, NULL, iface, 0, metric);
+    return net_route_v6_add(NULL, &dst, pref=
ixlen, NULL, iface, -1, metric);
 }
 
 static int
@@ -208,7 +208,7 @@
     =
}
     printf("\n");
 
-    return net_route_v6_add(NULL, &dst, prefixlen, =
&gw, iface, 0, metric);
+    return net_route_v6_add(NULL, &dst, prefixlen,=
 &gw, iface, -1, metric);
 }
 
 static void

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
Ge=
rrit-Change-Number: 2224
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--l+eDFmhYD0I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">networking: use -1 for &quot;no route table&quot;<br><br>Table 0 =
meant &quot;default table&quot; in the net_route_*() API=2E That is fine on=
<br>Linux, where table 0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0 is a real=
<br>FIB, which could then not be selected from a process running in another=
<br>FIB=2E<br><br>Make the table argument an int, with -1 for the default t=
able, and<br>default --route-table to -1=2E An invalid --route-table value =
is now<br>an error, instead of table 0=2E sitnl maps -1 and 0 to the main t=
able, as<br>before=2E On FreeBSD, -fib is now passed only for a set table; =
DCO<br>iroutes no longer force FIB 0 but use the FIB of the process=2E<br><=
br>Routes that route=2Ec creates internally get -1 too; block-local routes<=
br>passed an uninitialized table before=2E<br><br>Change-Id: Icbfc6b64beea5=
e70f32449c5a63a08ad862597b9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/networkin=
g=2Eh<br>M src/openvpn/networking_freebsd=2Ec<br>M src/openvpn/networking_i=
proute2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/route=2Ec<br>M tests/unit_tests/openvpn/test_networki=
ng=2Ec<br>8 files changed, 71 insertions(+), 63 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/24/2224/2</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec=
</span><br><span>index 236be93=2E=2E8d376fb 100644</span><br><span>--- a/sr=
c/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span=
>@@ -721,7 +721,7 @@</span><br><span>         }</span><br><span> </span><br=
><span>         net_route_v6_add(&amp;m-&gt;top=2Enet_ctx, &amp;addr-&gt;v6=
=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                         gateway, c-&gt;c1=2Etuntap-&gt;actual_name, 0=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
       gateway, c-&gt;c1=2Etuntap-&gt;actual_name, -1,</span><br><span>    =
                      DCO_IROUTE_METRIC);</span><br><span> #endif</span><br=
><span>     }</span><br><span>@@ -739,7 +739,7 @@</span><br><span>         =
}</span><br><span> </span><br><span>         net_route_v4_add(&amp;m-&gt;to=
p=2Enet_ctx, &amp;dest, addr-&gt;netbits, gateway,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                         c-&gt;c1=2Etuntap-&gt=
;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                         c-&gt;c1=2Etuntap-&gt;actual_name=
, -1, DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>     }</s=
pan><br><span> #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
) || defined(_WIN32) */</span><br><span>@@ -765,7 +765,7 @@</span><br><span=
>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, htonl=
(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else</span><br><span> =
            net_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-&gt;netbits,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
       &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actual_na=
me, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;=
actual_name, -1,</span><br><span>                              DCO_IROUTE_M=
ETRIC);</span><br><span> #endif</span><br><span>         }</span><br><span>=
@@ -779,7 +779,7 @@</span><br><span>         {</span><br><span>            =
 /* On windows we do not install these routes, so we also do not need to de=
lete them */</span><br><span>             net_route_v4_del(net_ctx, &amp;if=
config_local, 32, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                             c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IR=
OUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                       c-&gt;c1=2Etuntap-&gt;actual_name, -1, DCO_IROUTE_ME=
TRIC);</span><br><span>         }</span><br><span> #endif</span><br><span> =
    }</span><br><span>@@ -792,7 +792,7 @@</span><br><span>             dco_=
win_del_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&g=
t;netbits);</span><br><span> #else</span><br><span>             net_route_v=
6_del(net_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             &amp;c-&gt;c2=
=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
 &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_nam=
e, -1,</span><br><span>                              DCO_IROUTE_METRIC);</s=
pan><br><span> #endif</span><br><span>         }</span><br><span>@@ -805,7 =
+805,7 @@</span><br><span>         {</span><br><span>             /* On win=
dows we do not install these routes, so we also do not need to delete them =
*/</span><br><span>             net_route_v6_del(net_ctx, dest, 128, NULL,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
       c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                             c=
-&gt;c1=2Etuntap-&gt;actual_name, -1, DCO_IROUTE_METRIC);</span><br><span> =
        }</span><br><span> #endif</span><br><span>     }</span><br><span>di=
ff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span><b=
r><span>index 7ad6e2e=2E=2E1763e64 100644</span><br><span>--- a/src/openvpn=
/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><br>=
<span>@@ -245,14 +245,13 @@</span><br><span>  * @param prefixlen the length=
 of the prefix of the destination</span><br><span>  * @param gw        the =
gateway for this route</span><br><span>  * @param iface     the interface f=
or this route (can be NULL)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param table     the table to add this route to (if 0, will be add=
ed to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *          =
        main table)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param table     the table to add this route to, or -1 for the default o=
ne</span><br><span>  * @param metric    the metric associated with the rout=
e</span><br><span>  *</span><br><span>  * @return          0 on success, a =
negative error code otherwise</span><br><span>  */</span><br><span> int net=
_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefi=
xlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
     const in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  const in_addr_t *gw, const openvpn_net_iface_t *iface, int table,</span><=
br><span>                      int metric);</span><br><span> </span><br><sp=
an> /**</span><br><span>@@ -263,14 +262,13 @@</span><br><span>  * @param pr=
efixlen the length of the prefix of the destination</span><br><span>  * @pa=
ram gw        the gateway for this route</span><br><span>  * @param iface  =
   the interface for this route (can be NULL)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param table     the table to add this route to =
(if 0, will be added to the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *                  main table)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param table     the table to add this route to, or -1=
 for the default one</span><br><span>  * @param metric    the metric associ=
ated with the route</span><br><span>  *</span><br><span>  * @return        =
  0 on success, a negative error code otherwise</span><br><span>  */</span>=
<br><span> int net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct =
in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                     const struct in6_addr *gw, const openvpn_net_i=
face_t *iface, uint32_t table,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     const struct in6_addr *gw, const openvpn_ne=
t_iface_t *iface, int table,</span><br><span>                      int metr=
ic);</span><br><span> </span><br><span> /**</span><br><span>@@ -281,14 +279=
,13 @@</span><br><span>  * @param prefixlen the length of the prefix of the=
 destination</span><br><span>  * @param gw        the gateway for this rout=
e</span><br><span>  * @param iface     the interface for this route (can be=
 NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param table=
     the table to add this route to (if 0, will be added to the</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *                  main table)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param table     t=
he table to add this route to, or -1 for the default one</span><br><span>  =
* @param metric    the metric associated with the route</span><br><span>  *=
</span><br><span>  * @return          0 on success, a negative error code o=
therwise</span><br><span>  */</span><br><span> int net_route_v4_del(const o=
penvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                     const in_addr_t =
*gw, const openvpn_net_iface_t *iface, uint32_t table,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     const in_addr_t *gw=
, const openvpn_net_iface_t *iface, int table,</span><br><span>            =
          int metric);</span><br><span> </span><br><span> /**</span><br><sp=
an>@@ -299,14 +296,13 @@</span><br><span>  * @param prefixlen the length of=
 the prefix of the destination</span><br><span>  * @param gw        the gat=
eway for this route</span><br><span>  * @param iface     the interface for =
this route (can be NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param table     the table to add this route to (if 0, will be added =
to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             =
     main table)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param table     the table to add this route to, or -1 for the default one<=
/span><br><span>  * @param metric    the metric associated with the route</=
span><br><span>  *</span><br><span>  * @return          0 on success, a neg=
ative error code otherwise</span><br><span>  */</span><br><span> int net_ro=
ute_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pr=
efixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
        const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32=
_t table,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           const struct in6_addr *gw, const openvpn_net_iface_t *iface, int=
 table,</span><br><span>                      int metric);</span><br><span>=
 </span><br><span> #endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEB=
SD */</span><br><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src=
/openvpn/networking_freebsd=2Ec</span><br><span>index 88fd5c0=2E=2E8ba6326 =
100644</span><br><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><=
span>+++ b/src/openvpn/networking_freebsd=2Ec</span><br><span>@@ -10,7 +10,=
7 @@</span><br><span> </span><br><span> static int</span><br><span> net_rou=
te_v4(const char *op, const in_addr_t *dst, int prefixlen, const in_addr_t =
*gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             cons=
t char *iface, uint32_t table, int metric)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             const char *iface, int table, int metri=
c)</span><br><span> {</span><br><span>     char buf1[INET_ADDRSTRLEN], buf2=
[INET_ADDRSTRLEN];</span><br><span>     in_addr_t _dst, _gw;</span><br><spa=
n>@@ -27,15 +27,20 @@</span><br><span>     if (gw)</span><br><span>     {</=
span><br><span>         _gw =3D ntohl(*gw);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s %s -net %s/%d=
 %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s&quo=
t;, ROUTE_PATH, op,</span><br><span>                     inet_ntop(AF_INET,=
 &amp;_dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    inet_ntop(AF_INET, &amp;_gw, buf2=
, sizeof(buf2)), table);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)));=
</span><br><span>     }</span><br><span>     else</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp=
;argv, &quot;%s %s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp=
;argv, &quot;%s %s -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</span><br><s=
pan>                     inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)),=
 prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          iface, table);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    iface);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* without -fib, route(8) uses the FIB of the process */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (table &gt;=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-fi=
b %d&quot;, table);</span><br><span>     }</span><br><span> </span><br><spa=
n>     argv_msg(M_INFO, &amp;argv);</span><br><span>@@ -48,7 +53,7 @@</span=
><br><span> </span><br><span> static int</span><br><span> net_route_v6(cons=
t char *op, const struct in6_addr *dst, int prefixlen, const struct in6_add=
r *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             co=
nst char *iface, uint32_t table, int metric)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             const char *iface, int table, int met=
ric)</span><br><span> {</span><br><span>     char buf1[INET6_ADDRSTRLEN], b=
uf2[INET6_ADDRSTRLEN];</span><br><span>     struct argv argv =3D argv_new()=
;</span><br><span>@@ -61,15 +66,19 @@</span><br><span>      */</span><br><s=
pan>     if (gw)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d =
%s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s&q=
uot;, ROUTE_PATH, op,</span><br><span>                     inet_ntop(AF_INE=
T6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    inet_ntop(AF_INET6, gw, buf2, sizeof=
(buf2)), table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;=
%s -6 %s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &qu=
ot;%s -6 %s -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</span><br><span>   =
                  inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if=
ace, table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (table=
 &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_ca=
t(&amp;argv, &quot;-fib %d&quot;, table);</span><br><span>     }</span><br>=
<span> </span><br><span> </span><br><span>@@ -83,28 +92,28 @@</span><br><sp=
an> </span><br><span> int</span><br><span> net_route_v4_add(const openvpn_n=
et_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                 const c=
har *iface, uint32_t table, int metric)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 const char *iface, int table, int metr=
ic)</span><br><span> {</span><br><span>     return net_route_v4(&quot;add&q=
uot;, dst, prefixlen, gw, iface, table, metric);</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span> net_route_v6_add(const ope=
nvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                 const struct in6=
_addr *gw, const char *iface, uint32_t table, int metric)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 const struct in6_add=
r *gw, const char *iface, int table, int metric)</span><br><span> {</span><=
br><span>     return net_route_v6(&quot;add&quot;, dst, prefixlen, gw, ifac=
e, table, metric);</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_=
addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                 const char *iface, uint32_t tab=
le, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
             const char *iface, int table, int metric)</span><br><span> {</=
span><br><span>     return net_route_v4(&quot;del&quot;, dst, prefixlen, gw=
, iface, table, metric);</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span> net_route_v6_del(const openvpn_net_ctx_t *ctx, con=
st struct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                 const struct in6_addr *gw, const char *i=
face, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 const struct in6_addr *gw, const char *iface=
, int table, int metric)</span><br><span> {</span><br><span>     return net=
_route_v6(&quot;del&quot;, dst, prefixlen, gw, iface, table, metric);</span=
><br><span> }</span><br><span>diff --git a/src/openvpn/networking_iproute2=
=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>index d987478=2E=
=2E6c4c8f4 100644</span><br><span>--- a/src/openvpn/networking_iproute2=2Ec=
</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br><span>=
@@ -243,7 +243,7 @@</span><br><span> </span><br><span> int</span><br><span>=
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int p=
refixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                 const char *iface, uint32_t table, int metric)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const=
 char *iface, int table, int metric)</span><br><span> {</span><br><span>   =
  struct argv argv =3D argv_new();</span><br><span>     const char *dst_str=
 =3D print_in_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><span>@@ -281,7 +2=
81,7 @@</span><br><span> </span><br><span> int</span><br><span> net_route_v=
6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixl=
en,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 c=
onst struct in6_addr *gw, const char *iface, uint32_t table, int metric)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const=
 struct in6_addr *gw, const char *iface, int table, int metric)</span><br><=
span> {</span><br><span>     struct argv argv =3D argv_new();</span><br><sp=
an>     char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);<=
/span><br><span>@@ -314,7 +314,7 @@</span><br><span> </span><br><span> int<=
/span><br><span> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_ad=
dr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                 const char *iface, uint32_t table=
, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           const char *iface, int table, int metric)</span><br><span> {</sp=
an><br><span>     struct argv argv =3D argv_new();</span><br><span>     con=
st char *dst_str =3D print_in_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><s=
pan>@@ -340,7 +340,7 @@</span><br><span> </span><br><span> int</span><br><s=
pan> net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *=
dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               const struct in6_addr *gw, const char *iface, uint32_t table=
, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           const struct in6_addr *gw, const char *iface, int table, int met=
ric)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new(=
);</span><br><span>     char *dst_str =3D (char *)print_in6_addr(*dst, 0, &=
amp;argv=2Egc);</span><br><span>diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index b7c0f58=2E=2E=
af4ed27 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span=
><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -1115,=
14 +1115,11 @@</span><br><span> </span><br><span> static int</span><br><spa=
n> sitnl_route_add(const char *iface, sa_family_t af_family, const void *ds=
t, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            const void *gw, uint32_t table, int metric)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                const void *gw, int tab=
le, int metric)</span><br><span> {</span><br><span>     enum rt_scope_t sco=
pe =3D RT_SCOPE_UNIVERSE;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (table =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        table =3D RT_TABLE_MAIN=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* table 0 is RT_TABLE_UNSPEC =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint32_=
t rt_table =3D table &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</span><br><s=
pan> </span><br><span>     if (!gw &amp;&amp; iface)</span><br><span>     {=
</span><br><span>@@ -1130,12 +1127,12 @@</span><br><span>     }</span><br><=
span> </span><br><span>     return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREA=
TE, iface, af_family, dst, prefixlen, gw,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                           table, metric, scope, RTPROT=
_BOOT, RTN_UNICAST);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           rt_table, metric, scope, RTPROT_BOOT, RTN_UNICA=
ST);</span><br><span> }</span><br><span> </span><br><span> int</span><br><s=
pan> net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, i=
nt prefixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                 const char *iface, uint32_t table, int metric=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 c=
onst char *iface, int table, int metric)</span><br><span> {</span><br><span=
>     const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span>=
     in_addr_t dst_be =3D 0, gw_be =3D 0;</span><br><span>@@ -1154,7 +1151,=
7 @@</span><br><span>         gw_ptr =3D &amp;gw_be;</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __fun=
c__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE=
, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, __func__,</span><=
br><span>         inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(dst_str))=
, prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_be, gw_str=
, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </span><br><=
span>@@ -1163,7 +1160,7 @@</span><br><span> </span><br><span> int</span><br=
><span> net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_add=
r *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                 const struct in6_addr *gw, const char *iface, uint32_t ta=
ble, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              const struct in6_addr *gw, const char *iface, int table, int =
metric)</span><br><span> {</span><br><span>     inet_address_t dst_v6;</spa=
n><br><span>     inet_address_t gw_v6;</span><br><span>@@ -1183,7 +1180,7 @=
@</span><br><span>         gw_v6=2Eipv6 =3D *gw;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &q=
uot;%s: %s/%d via %s dev %s table %d metric %d&quot;, __func__,</span><br><=
span>         inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_s=
tr)), prefixlen,</span><br><span>         inet_ntop(AF_INET6, &amp;gw_v6=2E=
ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> =
</span><br><span>@@ -1192,20 +1189,18 @@</span><br><span> </span><br><span>=
 static int</span><br><span> sitnl_route_del(const char *iface, sa_family_t=
 af_family, const inet_address_t *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                const inet_address_t *gw, u=
int32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                const inet_address_t *gw, int table, int metric)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (table =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        table =3D RT=
_TABLE_MAIN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* table 0 is RT_TA=
BLE_UNSPEC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst uint32_t rt_table =3D table &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw=
, table, metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, =
gw, rt_table, metric,</span><br><span>                            RT_SCOPE_=
NOWHERE, 0, 0);</span><br><span> }</span><br><span> </span><br><span> int</=
span><br><span> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_add=
r_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                 const char *iface, uint32_t table,=
 int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
          const char *iface, int table, int metric)</span><br><span> {</spa=
n><br><span>     inet_address_t dst_v4;</span><br><span>     inet_address_t=
 gw_v4;</span><br><span>@@ -1225,7 +1220,7 @@</span><br><span>         gw_v=
4=2Eipv4 =3D htonl(*gw);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%=
d via %s dev %s table %u metric %d&quot;, __func__,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s d=
ev %s table %d metric %d&quot;, __func__,</span><br><span>         inet_nto=
p(AF_INET, &amp;dst_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,</span>=
<br><span>         inet_ntop(AF_INET, &amp;gw_v4=2Eipv4, gw_str, sizeof(gw_=
str)), np(iface), table, metric);</span><br><span> </span><br><span>@@ -123=
4,7 +1229,7 @@</span><br><span> </span><br><span> int</span><br><span> net_=
route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int =
prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      const struct in6_addr *gw, const char *iface, uint32_t table, int met=
ric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const struct in6_addr *gw, const char *iface, int table, int metric)</spa=
n><br><span> {</span><br><span>     inet_address_t dst_v6;</span><br><span>=
     inet_address_t gw_v6;</span><br><span>@@ -1254,7 +1249,7 @@</span><br>=
<span>         gw_v6=2Eipv6 =3D *gw;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &q=
uot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%=
d via %s dev %s table %d metric %d&quot;, __func__,</span><br><span>       =
  inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefix=
len,</span><br><span>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str=
, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </span><br><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index 947439d=2E=2E35fbe39 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -831,7 +831,7 @@</span><br><span>     o-&gt;ce=2Emssfix =3D 0;</span><b=
r><span>     o-&gt;ce=2Emssfix_default =3D true;</span><br><span>     o-&gt=
;ce=2Emssfix_encap =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    o-&gt;route_default_table_id =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    o-&gt;route_default_table_id =3D -1;</span><=
br><span>     o-&gt;route_delay_window =3D 30;</span><br><span>     o-&gt;r=
esolve_retry_seconds =3D RESOLV_RETRY_INFINITE;</span><br><span>     o-&gt;=
resolve_in_advance =3D false;</span><br><span>@@ -5297,7 +5297,11 @@</span>=
<br><span>         msg(M_WARN, &quot;NOTE: --route-table is supported only =
on Linux when SITNL is built-in&quot;);</span><br><span> #endif</span><br><=
span>         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;route_default_table_id =
=3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;route_d=
efault_table_id, p[0], 0, INT_MAX,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                              msglevel))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[5])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/route=
=2Ec b/src/openvpn/route=2Ec</span><br><span>index 9086529=2E=2E8c493ee 100=
644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/o=
penvpn/route=2Ec</span><br><span>@@ -545,6 +545,7 @@</span><br><span>      =
   /* split a route into two smaller blocking routes, and direct them to ta=
rget */</span><br><span>         l2 =3D ((~gateway-&gt;netmask) + 1) &gt;&g=
t; 1;</span><br><span>         r1-&gt;flags =3D RT_DEFINED;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        r1-&gt;table_id =3D -1;</sp=
an><br><span>         r1-&gt;gateway =3D target;</span><br><span>         r=
1-&gt;network =3D gateway-&gt;addr &amp; gateway-&gt;netmask;</span><br><sp=
an>         r1-&gt;netmask =3D ~(l2 - 1);</span><br><span>@@ -854,6 +855,7 =
@@</span><br><span>                 r6-&gt;gateway =3D rl6-&gt;rgi6=2Egatew=
ay=2Eaddr_ipv6;</span><br><span>             }</span><br><span>            =
 r6-&gt;metric =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            r6-&gt;table_id =3D -1;</span><br><span> #ifdef _WIN32</span>=
<br><span>             r6-&gt;adapter_index =3D rl6-&gt;rgi6=2Eadapter_inde=
x;</span><br><span> #else</span><br><span>@@ -883,6 +885,7 @@</span><br><sp=
an>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><span=
>     r=2Eflags =3D RT_DEFINED;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    r=2Etable_id =3D -1;</span><br><span>     r=2Enetwork =3D n=
etwork;</span><br><span>     r=2Enetmask =3D netmask;</span><br><span>     =
r=2Egateway =3D gateway;</span><br><span>@@ -897,6 +900,7 @@</span><br><spa=
n>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><span>=
     r=2Eflags =3D RT_DEFINED | RT_ADDED;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    r=2Etable_id =3D -1;</span><br><span>     r=2Enet=
work =3D network;</span><br><span>     r=2Enetmask =3D netmask;</span><br><=
span>     r=2Egateway =3D gateway;</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networkin=
g=2Ec</span><br><span>index b580d32=2E=2E95019e5 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_networking=2Ec</span><br><span>@@ -112,7 +112,7 @@=
</span><br><span>     }</span><br><span>     printf(&quot;\n&quot;);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 net_route_v4_add(NULL, &amp;dst, prefixlen, NULL, iface, 0, metric);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_route_v4_a=
dd(NULL, &amp;dst, prefixlen, NULL, iface, -1, metric);</span><br><span> }<=
/span><br><span> </span><br><span> static int</span><br><span>@@ -148,7 +14=
8,7 @@</span><br><span>     }</span><br><span>     printf(&quot;\n&quot;);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return net_route_v4_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, 0, metri=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_r=
oute_v4_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, -1, metric);</span><=
br><span> }</span><br><span> </span><br><span> static int</span><br><span>@=
@ -175,7 +175,7 @@</span><br><span>     }</span><br><span>     printf(&quot=
;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen, NULL, iface,=
 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn net_route_v6_add(NULL, &amp;dst, prefixlen, NULL, iface, -1, metric);</=
span><br><span> }</span><br><span> </span><br><span> static int</span><br><=
span>@@ -208,7 +208,7 @@</span><br><span>     }</span><br><span>     printf=
(&quot;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;g=
w, iface, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, -1=
, metric);</span><br><span> }</span><br><span> </span><br><span> static voi=
d</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2224?usp=3Demail">change 2224</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a0=
8ad862597b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2224 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>

</body></html>
--l+eDFmhYD0I=--


--===============2319465040799730995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2319465040799730995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2319465040799730995==--

