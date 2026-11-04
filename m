Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E90606A337
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=irIeHTaO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hK6N6alf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DKSNuelK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Th3X3Pua
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mqi+J2+APhW3FX+XK2q/uEud5xVuVXH3OQhDx3kh7u8=; b=irIeHTaOdyDtn7vB/zmYzOoSJl
	Fvej2y062K+TgYQx2/imJJcUxGMMUnuVcUcdlJgVwA0+Izbc/Tsz2fatyg+DTKCrgNwUXsHxhXK0a
	ECKMET0iriu3WnBdLb5tIWrQr9eUH7zbC6+Sg8jbdMzUUMVfHfoLzjPswbOe0esZm/PM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdqL-000000003yG-3E7N;
	Wed, 04 Nov 2026 16:28:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdqI-000000003xi-0uuE
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjSTmZGS/9vPUzu0BUDOrjQ0I2eopHoFI0x+V4ep5fM=; b=hK6N6alfr1btty4MSGw9HKrRDp
 OIhZ3zidStOCL9XK2KTXeOrSJVsvFJSbe6pah0JYA9XqaU9SqK+5El6TD+9VDF1JWYVwGA54wEF+d
 Qg/6YPyCFhIO/M1ITN8I5/pUxwdUPx9sZk3vyg9EHtB67iHvOP2OcPoibyYa6e6pT0/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjSTmZGS/9vPUzu0BUDOrjQ0I2eopHoFI0x+V4ep5fM=; b=DKSNuelKQBM9UGoyJycc1QcONv
 kMm2SkV4/Jrl8PzQqvLItxRy5Olkx3VkERrjkdcLbmkCm46PSR6W/WbOVp0RJSUHCJycuP8aGQa48
 cIxvGu6epVuwsC3u1H+o/+fcRF5d5uJgMDLGvka86zwLSgPBIx1AUu1UpKJ/faPFKbJw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdqF-000000000a6-16ex for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:06 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so5947025e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809677; x=1794414477; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wjSTmZGS/9vPUzu0BUDOrjQ0I2eopHoFI0x+V4ep5fM=;
 b=Th3X3PuaCQWygQOvYXB6CNZ2ZZOsBK9mhQAIxgcEFtv5XgW2IbOqlc6p2gnCNhZaIV
 015Wg+VPQ0aWwo7MlD6TAyKomUM8FS+WwA46BVK4+bzByhebV+pi0bJfz5t5h4Lb12cK
 y+4koDjYT7VZE5iif2PeCUoce7eG7yOIkroXc++kLj+ngWt/jwwYpgnoXjbJmbBXNrEb
 rPZxlbIuW+B0w2lCBlrwIyi28md5RryKM4lhpMQZXvWGOH0JI7kzDLo3iG1qdl6dAVRc
 wsCHKpTQ+4qQovnQ6AjDqX+3F6t5tvArMI9B7QbJrTxglu6hN9QV89000pW89z90NPWn
 drZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809677; x=1794414477;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wjSTmZGS/9vPUzu0BUDOrjQ0I2eopHoFI0x+V4ep5fM=;
 b=j5IOdWunvemzFjocplf0cPLnGZJa4pQ0P6Xd4Mtum5ihMtmrOLcI8O6k+TSx8g1RWz
 xG9TaW9hnjvdahlpvimw/DVjkiDhm0Xwc0o9LQ98kqYw3dqhY+5cBc6QyUFllYDsDf2M
 l8irL7KjEDVY4etu+xB+/2kHRvOivBgltB3vTrGXB/WlpGzYkLry7//MHpdhLYkhPvp+
 c7HZGmSYsr/DxxHEIq8catdDjASBUa4XtZEYlM/iIZkhjbiuov+HQA6/KbIkCo0e61lU
 rFN8jTIgmAtQ68liEAZO1ibPYw/ApYv8knOc30p49sif4nw4W1BpygStFjNM2GTy0jeF
 QTxg==
X-Gm-Message-State: APuU4Z+a1ZXQRVBKhMno9Nnb8NXiAkyz/3huvE+UktsaTcfthrUgvLfk
 KwjUlvv+TixQKhgrcQPLcEHUK/dkMYNMSPkdUUQgtMrZfQ4ywmJ9OQmoH523sKt3Xpq5Vf1RgLT
 oMAvjI3YVGB14tt5+FEoPDBwh2Mh9QPbgPdWSqD5XSSS9DzpSsuLBKf22Ovm1LIc+bzj8+fuHph
 CRG2NyFA==
X-Gm-Gg: AYBFou355IV29IvHq/JmN41uBKNDh7K4tli/4zXELa71u3lFKo0FWpWC+7sTkCW5TRF
 g3w9XzwdcPsKrxKPowazkbQFS93vtgm8hq0A3opxuH6Z8zHKlrEQhKtiDYYYLxxMjHSJez1mVmz
 aO4oUFF3rEupZ+AL3bXLG1gtVtEWC82lp4nZ7iMTFpaOVsYk3HGoQih5QvUGtSBDylKr6vQ0+Ka
 /LnJdIFc+nFosGqDnm2bHczqFua07LiMryMqO2vKHmnA8rmUcOHxLEFmC/sb9gJ3b9RoyY2NihE
 yn7TAOi4mtPn5bAxOWGR0m6ZqxyTjS0HDoUhgp5moj5EUYcLGaZhaXjnRFJFO7ypenhjx8cl+gn
 kbMY5WH8LJj8y+6/Wmdy0phfKIIb0AOjerkXesDj7NA2ixDFS8aHADLt2xxcNlZDHr2L568WcY2
 PLIHIExkKWufHCC0jCCTASr3dCC1Yoet1v/mylW9blk+67k4bpzcM9Xm0xiRZw59tDwLYYEzfmy
 wTSr8QlI+p1GImOY7+aVZ7x3DPEgb+ls+P1WFo38nTb4/g4FtPsynGG/pG3a3oYRAKG2I4dq1Ea
 4lRNoqFxv+dgfodCuR66XAkJzuTfdzwczkuPAGPd0WIRmBAjKdMLjRCQqfu+Jc5xpSjlPZyg4/U
 s3h1vD0SI/1BM8L7WmrVAAhF6YDKp0JXwlckAAQIqKjwkps9gKyXgC55MLAjXS9KNZZ+1lgfzaE
 51C2YHWUBLGAvyxQ==
X-Received: by 2002:a05:600c:e548:20b0:4ac:86c9:b09c with SMTP id
 5b1f17b1804b1-4ac86c9b146mr241219205e9.13.1793809676340; 
 Wed, 04 Nov 2026 08:27:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecb4sm72238325e9.3.2026.11.04.08.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:27:55 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:27:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 1c9cff61c5ac47362028c3c131156704ced18a05
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85cc04357abd763ca6542aa9f7c74f66fb56bec0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdqF-000000000a6-16ex
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
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
Content-Type: multipart/mixed; boundary="===============3926419486532250131=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3926419486532250131==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2V6vtG3Gf3U="; charset=UTF-8

--2V6vtG3Gf3U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?=
usp=3Demail

to look at the new patch set (#2)=2E

The following approvals =
got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Chan=
ge subject: dco: track installed iroutes separately for IPv4 and IPv6
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: track insta=
lled iroutes separately for IPv4 and IPv6

Track successful route installat=
ion per address family and split route
deletion into IPv4 and IPv6 helpers=
=2E Keep the combined deletion API for
existing callers and update delayed-=
exit cleanup=2E Return installation status
from the Windows helpers and kee=
p the non-DCO declarations compatible=2E

Change-Id: Ic0b8b0a3249eb41e1de10=
f381932c1161cd75270
Signed-off-by: Marco Baffo <marco@mandelbit=2Ecom>
---
=
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_win=2Ec
M src=
/openvpn/dco_win=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/multi=2Ec
M sr=
c/openvpn/openvpn=2Eh
7 files changed, 94 insertions(+), 35 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/2061/=
2

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f3b5d44=2E=
=2Ef807002 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -7=
06,8 +706,8 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_=
WIN32)
-        dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v6=2Ead=
dr, addr->netbits,
-                                c->c2=2Etls_multi->rx_p=
eer_id);
+        bool installed =3D dco_win_add_iroute_ipv6(&c->c1=2Etunta=
p->dco, addr->v6=2Eaddr, addr->netbits,
+                                  =
               c->c2=2Etls_multi->rx_peer_id);
 #else
         const struct=
 in6_addr *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
      =
   if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -715,16 +715,18 @@
             =
gateway =3D NULL;
         }
 
-        net_route_v6_add(&m->top=2Enet_ctx,=
 &addr->v6=2Eaddr, addr->netbits,
-                         gateway, c->c1=
=2Etuntap->actual_name, 0,
-                         DCO_IROUTE_METRIC);
+ =
       bool installed =3D net_route_v6_add(&m->top=2Enet_ctx, &addr->v6=2Ea=
ddr, addr->netbits,
+                                          gateway, c->=
c1=2Etuntap->actual_name, 0,
+                                          DCO=
_IROUTE_METRIC)
+                         =3D=3D 0;
 #endif
+        mi->co=
ntext=2Edid_dco_iroutes_v6 |=3D installed;
     }
     else if (addrtype =
=3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_irout=
e_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-             =
                   c->c2=2Etls_multi->rx_peer_id);
+        bool installed =
=3D dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->ne=
tbits,
+                                                 c->c2=2Etls_multi-=
>rx_peer_id);
 #else
         in_addr_t dest =3D htonl(addr->v4=2Eaddr);
  =
       const in_addr_t *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_local=
;
@@ -733,15 +735,17 @@
             gateway =3D NULL;
         }
 
-      =
  net_route_v4_add(&m->top=2Enet_ctx, &dest, addr->netbits, gateway,
-     =
                    c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
+  =
      bool installed =3D net_route_v4_add(&m->top=2Enet_ctx, &dest, addr->n=
etbits, gateway,
+                                          c->c1=2Etuntap-=
>actual_name, 0, DCO_IROUTE_METRIC)
+                         =3D=3D 0;
 #e=
ndif
+        mi->context=2Edid_dco_iroutes_v4 |=3D installed;
     }
 #end=
if /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32=
) */
 }
 
 void
-dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struc=
t context *c)
+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const stru=
ct context *c)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || =
defined(_WIN32)
     if (!dco_enabled(&c->options))
@@ -750,7 +754,7 @@
   =
  }
     ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
-    ms=
g(D_DCO, "DCO: attempt removing iroutes from system table");
+    msg(D_DCO=
, "DCO: attempt removing IPv4 iroutes from system table");
 
     if (c->c2=
=2Epush_ifconfig_defined)
     {
@@ -778,6 +782,20 @@
         }
 #endif
  =
   }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defi=
ned(_WIN32) */
+}
+
+void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx=
, const struct context *c)
+{
+#if defined(TARGET_LINUX) || defined(TARGET_=
FREEBSD) || defined(_WIN32)
+    if (!dco_enabled(&c->options))
+    {
+   =
     return;
+    }
+    ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE=
_TUN);
+
+    msg(D_DCO, "DCO: attempt removing IPv6 iroutes from system ta=
ble");
 
     if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
diff --git a/s=
rc/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index c435f8c=2E=2Ece44331 100644
=
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -218,12 +218,20 @@
 =
                        const struct mroute_addr *addr);
 
 /**
- * Remove =
all routes added through the specified client
+ * Remove all IPv4 routes ad=
ded through the specified client
  *
  * @param net_ctx   the iface network=
ing context
  * @param c         the client context for which routes have t=
o be removed
  */
-void dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, cons=
t struct context *c);
+void dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ct=
x, const struct context *c);
+
+/**
+ * Remove all IPv6 routes added throug=
h the specified client
+ *
+ * @param net_ctx   the iface networking contex=
t
+ * @param c         the client context for which routes have to be remov=
ed
+ */
+void dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struc=
t context *c);
 
 /**
  * Update traffic statistics for all peers
@@ -356,1=
2 +364,17 @@
 }
 
 static inline void
-dco_install_iroute(struct multi_cont=
ext *m, struct multi_instance *mi, struct mroute_addr *addr)
+dco_install_i=
route(struct multi_context *m, struct multi_instance *mi, const struct mrou=
te_addr *addr)
 {
 }
 
 static inline void
-dco_delete_iroutes(openvpn_net_=
ctx_t *net_ctx, const struct context *c)
+dco_delete_iroutes_v4(openvpn_net=
_ctx_t *net_ctx, const struct context *c)
+{
+}
+
+static inline void
+dco_=
delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 =
}
 
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 12=
b0666=2E=2E68ae7c5 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/d=
co_win=2Ec
@@ -1007,7 +1007,7 @@
     return dco_get_version(&ver) && ver=
=2EMajor >=3D 2;
 }
 
-void
+bool
 dco_win_add_iroute_ipv4(dco_context_t *d=
co, in_addr_t dst, unsigned int netbits,
                         unsigned =
int peer_id)
 {
@@ -1021,16 +1021,18 @@
         netbits, peer_id);
 
     =
DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_I=
OCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-                      =
   &bytes_returned, NULL))
+    bool installed =3D DeviceIoControl(dco->tt-=
>hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
+         =
                            &bytes_returned, NULL);
+    if (!installed)
  =
   {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROU=
TE) failed");
     }
 
     gc_free(&gc);
+    return installed;
 }
 
-void=

+bool
 dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, un=
signed int netbits,
                         unsigned int peer_id)
 {
@@ -1=
042,13 +1044,15 @@
         netbits, peer_id);
 
     DWORD bytes_returned =
=3D 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &=
route, sizeof(route), NULL, 0,
-                         &bytes_returned, N=
ULL))
+    bool installed =3D DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_=
ADD_IROUTE, &route, sizeof(route), NULL, 0,
+                              =
       &bytes_returned, NULL);
+    if (!installed)
     {
         msg(M_W=
ARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed");
     }
=
 
     gc_free(&gc);
+    return installed;
 }
 
 void
diff --git a/src/ope=
nvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index a92e5ad=2E=2E28795b7 10064=
4
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco_win=2Eh
@@ -67,10 +67=
,10 @@
 
 bool dco_win_supports_multipeer(void);
 
-void dco_win_add_iroute=
_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
+bool dco_wi=
n_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
=
                              unsigned int peer_id);
 
-void dco_win_add_ir=
oute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,
+b=
ool dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsign=
ed int netbits,
                              unsigned int peer_id);
 
 voi=
d dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int n=
etbits);
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
ind=
ex eb41d03=2E=2E6ef480e 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/open=
vpn/forward=2Ec
@@ -555,10 +555,17 @@
      * last connecting client claimi=
ng the iroutes takes ownership=2E Therefore
      * they are not removed du=
ring delayed cleanup=2E
      */
-    if (c->did_dco_iroutes)
+
+    if (c-=
>did_dco_iroutes_v4)
     {
-        c->did_dco_iroutes =3D false;
-       =
 dco_delete_iroutes(&c->net_ctx, c);
+        c->did_dco_iroutes_v4 =3D fal=
se;
+        dco_delete_iroutes_v4(&c->net_ctx, c);
+    }
+
+    if (c->di=
d_dco_iroutes_v6)
+    {
+        c->did_dco_iroutes_v6 =3D false;
+       =
 dco_delete_iroutes_v6(&c->net_ctx, c);
     }
 
     tls_set_single_sessio=
n(c->c2=2Etls_multi);
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mult=
i=2Ec
index 0027550=2E=2Ea850e72 100644
--- a/src/openvpn/multi=2Ec
+++ b/s=
rc/openvpn/multi=2Ec
@@ -479,6 +479,28 @@
     set_prefix(mi);
 }
 
+static=
 void
+multi_del_dco_iroutes_v4(struct multi_context *m, struct multi_insta=
nce *mi)
+{
+    /* Only remove DCO IPv4 iroutes this instance installed=2E=
 */
+    if (mi->context=2Edid_dco_iroutes_v4)
+    {
+        mi->context=
=2Edid_dco_iroutes_v4 =3D false;
+        dco_delete_iroutes_v4(&m->top=2En=
et_ctx, &mi->context);
+    }
+}
+
+static void
+multi_del_dco_iroutes_v6(s=
truct multi_context *m, struct multi_instance *mi)
+{
+    /* Only remove D=
CO IPv6 iroutes this instance installed=2E */
+    if (mi->context=2Edid_dc=
o_iroutes_v6)
+    {
+        mi->context=2Edid_dco_iroutes_v6 =3D false;
+=
        dco_delete_iroutes_v6(&m->top=2Enet_ctx, &mi->context);
+    }
+}
+=

 /*
  * Tell the route helper about deleted iroutes so
  * that it can upd=
ate its mask of currently used
@@ -490,12 +512,8 @@
     const struct irout=
e *ir;
     const struct iroute_ipv6 *ir6;
 
-    /* check if DCO iroutes w=
ere already removed when scheduling a delayed exit */
-    if (mi->context=
=2Edid_dco_iroutes)
-    {
-        mi->context=2Edid_dco_iroutes =3D false=
;
-        dco_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
-    }
+   =
 multi_del_dco_iroutes_v4(m, mi);
+    multi_del_dco_iroutes_v6(m, mi);
 
 =
    if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
=
@@ -1309,8 +1327,6 @@
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN)
     {
         mi->did_iroutes =3D true;
-        /* mul=
ti_learn_in{6}_addr_t takes care of installing the DCO iroute */
-        m=
i->context=2Edid_dco_iroutes =3D true;
         for (ir =3D mi->context=2Eo=
ptions=2Eiroutes; ir !=3D NULL; ir =3D ir->next)
         {
             if=
 (ir->netbits >=3D 0)
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/op=
envpn=2Eh
index cdd02b6=2E=2E72436fe 100644
--- a/src/openvpn/openvpn=2Eh
+=
++ b/src/openvpn/openvpn=2Eh
@@ -507,7 +507,8 @@
     bool did_we_daemonize=
;       /**< Whether demonization has already
                             =
      *   taken place=2E */
 
-    bool did_dco_iroutes;        /**< Whethe=
r DCO iroutes have been installed */
+    bool did_dco_iroutes_v4;     /**<=
 Whether DCO IPv4 iroutes have been installed */
+    bool did_dco_iroutes_=
v6;     /**< Whether DCO IPv6 iroutes have been installed */
 
     struct =
context_persist persist;
     /**< Persistent %context=2E */

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932=
c1161cd75270
Gerrit-Change-Number: 2061
Gerrit-PatchSet: 2
Gerrit-Owner: Ma=
rco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--2V6vtG3Gf3U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">dco: track installed iroutes=
 separately for IPv4 and IPv6<br><br>Track successful route installation pe=
r address family and split route<br>deletion into IPv4 and IPv6 helpers=2E =
Keep the combined deletion API for<br>existing callers and update delayed-e=
xit cleanup=2E Return installation status<br>from the Windows helpers and k=
eep the non-DCO declarations compatible=2E<br><br>Change-Id: Ic0b8b0a3249eb=
41e1de10f381932c1161cd75270<br>Signed-off-by: Marco Baffo &lt;marco@mandelb=
it=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M =
src/openvpn/dco_win=2Ec<br>M src/openvpn/dco_win=2Eh<br>M src/openvpn/forwa=
rd=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/openvpn=2Eh<br>7 files c=
hanged, 94 insertions(+), 35 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/2061/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>in=
dex f3b5d44=2E=2Ef807002 100644</span><br><span>--- a/src/openvpn/dco=2Ec</=
span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -706,8 +706,8 @=
@</span><br><span>     if (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>  =
   {</span><br><span> #if defined(_WIN32)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-=
&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_mul=
ti-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        bool installed =3D dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&=
gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                                 =
c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><spa=
n>         const struct in6_addr *gateway =3D &amp;mi-&gt;context=2Ec2=2Epu=
sh_ifconfig_ipv6_local;</span><br><span>         if (addr-&gt;type &amp; MR=
_ONLINK_DCO_ADDR)</span><br><span>@@ -715,16 +715,18 @@</span><br><span>   =
          gateway =3D NULL;</span><br><span>         }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        net_route_v6_add=
(&amp;m-&gt;top=2Enet_ctx, &amp;addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                         ga=
teway, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                         DCO_IROUTE_METRIC);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        bool installed =3D =
net_route_v6_add(&amp;m-&gt;top=2Enet_ctx, &amp;addr-&gt;v6=2Eaddr, addr-&g=
t;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                 gateway, c-&gt;c1=2Etuntap-&gt;actual_name=
, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                           DCO_IROUTE_METRIC)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                         =3D=3D 0;</span><br><spa=
n> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi=
-&gt;context=2Edid_dco_iroutes_v6 |=3D installed;</span><br><span>     }</s=
pan><br><span>     else if (addrtype =3D=3D MR_ADDR_IPV4)</span><br><span> =
    {</span><br><span> #if defined(_WIN32)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap=
-&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_mu=
lti-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        bool installed =3D dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-=
&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                                =
 c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><sp=
an>         in_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);</span><br><span> =
        const in_addr_t *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconf=
ig_local;</span><br><span>@@ -733,15 +735,17 @@</span><br><span>           =
  gateway =3D NULL;</span><br><span>         }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        net_route_v4_add(&amp;m-=
&gt;top=2Enet_ctx, &amp;dest, addr-&gt;netbits, gateway,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                         c-&gt;c1=2Etunt=
ap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        bool installed =3D net_route_v4_add(&amp;m-&=
gt;top=2Enet_ctx, &amp;dest, addr-&gt;netbits, gateway,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
   c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                         =3D=3D 0;<=
/span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        mi-&gt;context=2Edid_dco_iroutes_v4 |=3D installed;</span><br><=
span>     }</span><br><span> #endif /* if defined(TARGET_LINUX) || defined(=
TARGET_FREEBSD) || defined(_WIN32) */</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes_v4(o=
penvpn_net_ctx_t *net_ctx, const struct context *c)</span><br><span> {</spa=
n><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || define=
d(_WIN32)</span><br><span>     if (!dco_enabled(&amp;c-&gt;options))</span>=
<br><span>@@ -750,7 +754,7 @@</span><br><span>     }</span><br><span>     A=
SSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO, &quot=
;DCO: attempt removing iroutes from system table&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;DCO: attempt remo=
ving IPv4 iroutes from system table&quot;);</span><br><span> </span><br><sp=
an>     if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span>=
<br><span>@@ -778,6 +782,20 @@</span><br><span>         }</span><br><span> =
#endif</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || =
defined(_WIN32) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, con=
st struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARG=
ET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!dco_enabled(&amp;c-&gt;options=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D =
DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;DCO=
: attempt removing IPv6 iroutes from system table&quot;);</span><br><span> =
</span><br><span>     if (c-&gt;c2=2Epush_ifconfig_ipv6_defined)</span><br>=
<span>     {</span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn=
/dco=2Eh</span><br><span>index c435f8c=2E=2Ece44331 100644</span><br><span>=
--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><=
br><span>@@ -218,12 +218,20 @@</span><br><span>                         con=
st struct mroute_addr *addr);</span><br><span> </span><br><span> /**</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Remove all routes added t=
hrough the specified client</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Remove all IPv4 routes added through the specified client</span>=
<br><span>  *</span><br><span>  * @param net_ctx   the iface networking con=
text</span><br><span>  * @param c         the client context for which rout=
es have to be removed</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, co=
nst struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct con=
text *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Remove all IPv6 routes added through the s=
pecified client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param net_ctx   t=
he iface networking context</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param c         the client context for which routes have to be =
removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void dco_delete_iroutes_v6(o=
penvpn_net_ctx_t *net_ctx, const struct context *c);</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Update traffic statistics for all peer=
s</span><br><span>@@ -356,12 +364,17 @@</span><br><span> }</span><br><span>=
 </span><br><span> static inline void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dco_install_iroute(struct multi_context *m, struct multi_in=
stance *mi, struct mroute_addr *addr)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_install_iroute(struct multi_context *m, struct multi_=
instance *mi, const struct mroute_addr *addr)</span><br><span> {</span><br>=
<span> }</span><br><span> </span><br><span> static inline void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-dco_delete_iroutes(openvpn_net_ctx=
_t *net_ctx, const struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const s=
truct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const st=
ruct context *c)</span><br><span> {</span><br><span> }</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2E=
c</span><br><span>index 12b0666=2E=2E68ae7c5 100644</span><br><span>--- a/s=
rc/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span>=
<br><span>@@ -1007,7 +1007,7 @@</span><br><span>     return dco_get_version=
(&amp;ver) &amp;&amp; ver=2EMajor &gt;=3D 2;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> dco_win_=
add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,</s=
pan><br><span>                         unsigned int peer_id)</span><br><spa=
n> {</span><br><span>@@ -1021,16 +1021,18 @@</span><br><span>         netbi=
ts, peer_id);</span><br><span> </span><br><span>     DWORD bytes_returned =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!Device=
IoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof=
(route), NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                     &amp;bytes_returned, NULL))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool installed =3D DeviceIoControl(dco-&gt=
;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                  &amp;bytes_returned, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!installed)</span><br><span>     {</span>=
<br><span>         msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_M=
P_ADD_IROUTE) failed&quot;);</span><br><span>     }</span><br><span> </span=
><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return installed;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> dco_win_add_irout=
e_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,</span=
><br><span>                         unsigned int peer_id)</span><br><span> =
{</span><br><span>@@ -1042,13 +1044,15 @@</span><br><span>         netbits,=
 peer_id);</span><br><span> </span><br><span>     DWORD bytes_returned =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoCo=
ntrol(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(rou=
te), NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                 &amp;bytes_returned, NULL))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool installed =3D DeviceIoControl(dco-&gt;tt-=
&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
              &amp;bytes_returned, NULL);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!installed)</span><br><span>     {</span><br>=
<span>         msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_AD=
D_IROUTE) failed&quot;);</span><br><span>     }</span><br><span> </span><br=
><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return installed;</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span>diff --git a/src/openvpn/dco_win=2Eh b/src/=
openvpn/dco_win=2Eh</span><br><span>index a92e5ad=2E=2E28795b7 100644</span=
><br><span>--- a/src/openvpn/dco_win=2Eh</span><br><span>+++ b/src/openvpn/=
dco_win=2Eh</span><br><span>@@ -67,10 +67,10 @@</span><br><span> </span><br=
><span> bool dco_win_supports_multipeer(void);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void dco_win_add_iroute_ipv4(dco=
_context_t *dco, in_addr_t dst, unsigned int netbits,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool dco_win_add_iroute_ipv4(dco_context_=
t *dco, in_addr_t dst, unsigned int netbits,</span><br><span>              =
                unsigned int peer_id);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void dco_win_add_iroute_ipv6(dco_context=
_t *dco, struct in6_addr dst, unsigned int netbits,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool dco_win_add_iroute_ipv6(dco_context_=
t *dco, struct in6_addr dst, unsigned int netbits,</span><br><span>        =
                      unsigned int peer_id);</span><br><span> </span><br><s=
pan> void dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsign=
ed int netbits);</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src=
/openvpn/forward=2Ec</span><br><span>index eb41d03=2E=2E6ef480e 100644</spa=
n><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn=
/forward=2Ec</span><br><span>@@ -555,10 +555,17 @@</span><br><span>      * =
last connecting client claiming the iroutes takes ownership=2E Therefore</s=
pan><br><span>      * they are not removed during delayed cleanup=2E</span>=
<br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (c-&gt;did_dco_iroutes)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&=
gt;did_dco_iroutes_v4)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        c-&gt;did_dco_iroutes =3D false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        dco_delete_iroutes(&amp;=
c-&gt;net_ctx, c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       c-&gt;did_dco_iroutes_v4 =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        dco_delete_iroutes_v4(&amp;c-&gt;net_ctx, c)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (c-&gt;did_dco_iroutes_v6)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        c-&gt;did_dco_iroutes_v6 =3D false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_delete_iroutes_=
v6(&amp;c-&gt;net_ctx, c);</span><br><span>     }</span><br><span> </span><=
br><span>     tls_set_single_session(c-&gt;c2=2Etls_multi);</span><br><span=
>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span=
>index 0027550=2E=2Ea850e72 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -479,6 =
+479,28 @@</span><br><span>     set_prefix(mi);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_del_dco_irou=
tes_v4(struct multi_context *m, struct multi_instance *mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Only remove DCO IPv4 iroutes this instance inst=
alled=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
mi-&gt;context=2Edid_dco_iroutes_v4)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        mi-&gt;context=2Edid_dco_iroutes_v4 =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        dco_delete_iroutes_v4(&amp;m-=
&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_del_dco_iroutes_v6(struct multi_=
context *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Only remove DCO IPv6 iroutes this instance installed=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Edid=
_dco_iroutes_v6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;co=
ntext=2Edid_dco_iroutes_v6 =3D false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        dco_delete_iroutes_v6(&amp;m-&gt;top=2Enet_ctx, &=
amp;mi-&gt;context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br>=
<span>  * Tell the route helper about deleted iroutes so</span><br><span>  =
* that it can update its mask of currently used</span><br><span>@@ -490,12 =
+512,8 @@</span><br><span>     const struct iroute *ir;</span><br><span>   =
  const struct iroute_ipv6 *ir6;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* check if DCO iroutes were already remov=
ed when scheduling a delayed exit */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (mi-&gt;context=2Edid_dco_iroutes)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        mi-&gt;context=2Edid_dco_iroutes =3D false;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_delete_iroutes=
(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    multi_del_dco_iroutes_v4(m, mi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    multi_del_dco_iroutes_v6(m, mi);</span><b=
r><span> </span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap=
) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1309,8 +1=
327,6 @@</span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap)=
 =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         mi-&g=
t;did_iroutes =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        /* multi_learn_in{6}_addr_t takes care of installing the DCO irou=
te */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;c=
ontext=2Edid_dco_iroutes =3D true;</span><br><span>         for (ir =3D mi-=
&gt;context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir-&gt;next)</span><b=
r><span>         {</span><br><span>             if (ir-&gt;netbits &gt;=3D =
0)</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openv=
pn=2Eh</span><br><span>index cdd02b6=2E=2E72436fe 100644</span><br><span>--=
- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</=
span><br><span>@@ -507,7 +507,8 @@</span><br><span>     bool did_we_daemoni=
ze;       /**&lt; Whether demonization has already</span><br><span>        =
                           *   taken place=2E */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    bool did_dco_iroutes;     =
   /**&lt; Whether DCO iroutes have been installed */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool did_dco_iroutes_v4;     /**&lt; =
Whether DCO IPv4 iroutes have been installed */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool did_dco_iroutes_v6;     /**&lt; Whethe=
r DCO IPv6 iroutes have been installed */</span><br><span> </span><br><span=
>     struct context_persist persist;</span><br><span>     /**&lt; Persiste=
nt %context=2E */</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">change 2061</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0b8b0a3249e=
b41e1de10f381932c1161cd75270 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2061 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--2V6vtG3Gf3U=--


--===============3926419486532250131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3926419486532250131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3926419486532250131==--

