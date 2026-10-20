Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD0606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MSnoOcC7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GjcP5CCJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fmm565PH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GftZ2dpU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQYmO5jSk+e5WT9wQ7QvAmfl5D8/CyWK0efK7eS6Fmo=; b=MSnoOcC7w2L0RppI/yZuaDgu3a
	azEezz0MsE5nYbV2Vtat5PnrLh9RysGiNfuIupbj3v606TV7Mr+yZYs/vJgtBpFX4FGYXI6Jnu+ez
	g7udOHO15eK8ebeiw8fuvpBzzpltE2Eadk8QEjDOF/tg5bieHDZVMRJkV/9lbmWojNOI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ8zn-0007Ds-9o;
	Tue, 20 Oct 2026 12:31:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ8zl-0007DM-Nf
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cpN+4oFqs0Dl6uspwm4NOh2ydMCZ2pUgnORD4wJiuOs=; b=GjcP5CCJwe8xghiqRZdm0qpkgo
 WC8L47mF48mTmdlOZ/4LA5MqLCqqdVSdfNbAapz7rL2MYxHzVV8EGxYz/j8/UHM3x/TjGj/Ghro4c
 waXvsLCYF9Z9Zwus/5uDC3+f7Zua/AiWpgVxpas+9i6Ah3Vuu3r7P50e8oiVeYXt4Amw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cpN+4oFqs0Dl6uspwm4NOh2ydMCZ2pUgnORD4wJiuOs=; b=f
 mm565PHqs8CquiHPuoZXuF27fk8Zfk15y37AMtbcUyL7fKQc0KuFKCa47dS1dKlNoGIVbENMMIdfy
 yeLAPr+gLT/paYwcbFl1pUAxJCZNMy2gi5FdqYaA5qhgavQbCAnknYxyzdj3x83npTUzl9ub0kj6M
 GuQ3fsUQhNSUehAU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ8zQ-0000Gv-FN for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:30:52 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4956869750eso25204245e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792499442; x=1793104242; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cpN+4oFqs0Dl6uspwm4NOh2ydMCZ2pUgnORD4wJiuOs=;
 b=GftZ2dpUii6cpma+DRJ/8jcjDEVIhBI8pE+1O+TqeWBkHvyK15QEGbov4i/vJL+/FC
 Wgs5OEXFIpLDBnTLIyZt0c6VGOjkhl8dGc/4xmnkfqvCHPx2qp1+NzoJwU324+m2wV9u
 rEmHfwh6E/mjvSlsCVwsplecoza/iMO+TyycoYG6LkqWg7dSREmAXZXOTMfYD6a6O+bP
 hDnzDYy1daGy0YDePwWKy/LTA1ppuqalv5cloxgON/aGFNBHJGJSwPs3WgNoBerAkSum
 q93K36TZXLBPrhDyAh5dhNHRVf0oHOf2tqcaTk/X9lqGaG+YGtrwVfbunfLfDVhEGilY
 h/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499442; x=1793104242;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cpN+4oFqs0Dl6uspwm4NOh2ydMCZ2pUgnORD4wJiuOs=;
 b=eMHLhepsdB5MnxVmJ+tYh1Qk6XlFGNXZxm5heizg6F+bPZHxZdQcroIQ7YM6w2vA7D
 t3pfbb2KvmSRJpPEqG2aFfVOUmGp/WSBWM38tsIIvEDEcnL3/vqCBU5LMGqNuOZArW8u
 6Np6HzPN3fXOp3vRBRWuQtoJs2ZVVZW0y37/NYpjgMhgom/lAcmG9N6quYYhol2Ht5uJ
 o2UhIePxwwxjd5+JgzMdIRTQpyZ2DkzqJWcrrmoQusXayjURpoLReuC2jvXaVK0hGlg/
 PB3JXRcBL8JGGt6U+KUVFyF1a54U6j4vQqppthDtgQnC/C3pzAdS/tmOSE4Tw5zk9XSp
 7Y4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzm/m4bHYW3Y7fXLtxmTwb/+lvkIB7qtNvcJ20ithTi/OLB7eGOOeq+4OSA+1rF0P2rbym1qdSDWgmBIn7q@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKEATZofcKr9t9TD5amAdEW3OOUq/oly43DiIDmnnREbjbo7RSU
 OAidcNgEFuuY3j3sTns6Xg203ZSSExzSmdQK1oGyOisj70v6n7ip87LOJOsfwTJhtZlwfrfRsi0
 mVAuDX0Nv8AKMIinYOjid0tN+39NeEji/dQIp/1Apc7gMS4K/CirpYhkx4H16z4ylEJ/w
X-Gm-Gg: AYBFou0tlNEm09uWRnFB3/sU+dMt35O3/u5JFmHRzdRDqWlozvPyexgTGG6/kCGm1Ur
 cLCOXaKQF51u8fUaWzFe0wsBsixsrhDTSqA/CBSdOQ0QS5SyRa7utzq1W/ou46IwjM6xcs9Doft
 oFoyxKV7yXgJT/KKLUprzj7RMDnw64el1iUI6uw1ro8gagh5AK8p6P9RwEr0oYfY29i+cXYKoep
 Q6qGY+nehRkdiOY4dl1BCDlW5q1jJcVz9ZqmPPVs0wqG/talVEKmMUxHT79dhIqUuLAuK7j7Hyy
 QovcThhvqjQsPwFCtO+027ZrYK9N+/GjcRZogzkObdkprz/pZlYdqu35opLoz2/RnCKPPukkeqL
 baCsQXNp4Shpb1pL1rkWTCA/0nQdczB2IUXXxY07ALbE7VQ7uNE9hOhNhCpC+WL6l9+/hWbyfr2
 wEETO9mjR0lodFp7czrWJpinqWRF5UGjsU6sfFJe4iKN7qb23JmjWW6mllBXRQ4QJOHHAvTcCZa
 zEwzezqPI4kHTORRrRARsKKM04RPTZcTjUtX5LBAUo4cy/DDbnBdaU6U5UZSeflKFz2WTxjqjeq
 e+qwA3nPA6Bp+quTdNG6TFo4EGhS872YrkdFeMXe8yqq4GGmR24du1MWcnjv
X-Received: by 2002:a05:600c:5248:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4a1e57b67e1mr147547835e9.26.1792499440610; 
 Tue, 20 Oct 2026 05:30:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm68690005e9.2.2026.10.20.05.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:30:36 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 12:30:36 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 2f1f9d72cbf41127ee5e2a7c75971b9a4ee2d670
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73471764ffa756debf2153cb5bcc4c5d8ddbe1d8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ8zQ-0000Gv-FN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8289682309170884746=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8289682309170884746==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dXvv7MNM4ps="; charset=UTF-8

--dXvv7MNM4ps=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid conversion=
 warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

p=
acket_id: Avoid conversion warnings

Most of these already have checks that=
 the
values are as expected, so we can just add
the required casts=2E

Only=
 the circ list x_sizeof is changed to
size_t since that is its purpose (and=
 it is
not actually used anyway)=2E

Change-Id: Ib0584e8728701cca10ac5675c9=
cb0e6f5eb901ac
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
A=
cked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1407
Message-Id: <20260818142226=2E27172-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg38486=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/circ_list=2Eh
M src/openvpn/packet_id=
=2Ec
M src/openvpn/packet_id=2Eh
3 files changed, 29 insertions(+), 47 dele=
tions(-)




diff --git a/src/openvpn/circ_list=2Eh b/src/openvpn/circ_list=
=2Eh
index c29b0bb8=2E=2E76484ca 100644
--- a/src/openvpn/circ_list=2Eh
+++=
 b/src/openvpn/circ_list=2Eh
@@ -33,7 +33,7 @@
         int x_head;        =
   \
         int x_size;           \
         int x_cap;            \
-   =
     int x_sizeof;         \
+        size_t x_sizeof;      \
         type=
 x_list[];        \
     }
 
@@ -58,14 +58,14 @@
         (obj)->x_size =3D=
 0;   \
     }
 
-#define CIRC_LIST_ALLOC(dest, list_type, size)           =
                      \
-    {                                             =
                             \
-        const int so =3D sizeof(list_type) =
+ sizeof((dest)->x_list[0]) * (size); \
-        (dest) =3D (list_type *)ma=
lloc(so);                                      \
-        check_malloc_retu=
rn(dest);                                             \
-        memset((de=
st), 0, so);                                                 \
-        (de=
st)->x_cap =3D size;                                                  \
-  =
      (dest)->x_sizeof =3D so;                                             =
    \
+#define CIRC_LIST_ALLOC(dest, list_type, size)                      =
              \
+    {                                                     =
                        \
+        const size_t so =3D sizeof(list_type) + =
sizeof((dest)->x_list[0]) * (size); \
+        (dest) =3D (list_type *)mall=
oc(so);                                         \
+        check_malloc_ret=
urn(dest);                                                \
+        memset=
((dest), 0, so);                                                    \
+    =
    (dest)->x_cap =3D size;                                                =
     \
+        (dest)->x_sizeof =3D so;                                   =
                 \
     }
 
 #define CIRC_LIST_FREE(dest) free(dest)
diff -=
-git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index 50d7c76=
=2E=2E9dd6ce3 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/pack=
et_id=2Ec
@@ -71,11 +71,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || defined=
(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-=
Wconversion"
-#endif
-
 static void
 packet_id_init_recv(struct packet_id_r=
ec *rec, int seq_backtrack, int time_backtrack,
                     const =
char *name, int unit)
@@ -119,7 +114,7 @@
 
     /* Reinitalise the source =
*/
     CLEAR(*src);
-    packet_id_init_recv(src, dest->seq_backtrack, des=
t->time_backtrack, dest->name, dest->unit);
+    packet_id_init_recv(src, (=
int)dest->seq_backtrack, dest->time_backtrack, dest->name, dest->unit);
 }
=
 
 void
@@ -170,7 +165,7 @@
         diff =3D p->id - pin->id;
         if =
(diff < CIRC_LIST_SIZE(p->seq_list) && local_now > SEQ_EXPIRED)
         {
=
-            CIRC_LIST_ITEM(p->seq_list, diff) =3D local_now;
+            =
CIRC_LIST_ITEM(p->seq_list, (int)diff) =3D local_now;
         }
     }
   =
  else
@@ -261,18 +256,16 @@
                 return false;
             }
=
 
+            const time_t v =3D CIRC_LIST_ITEM(p->seq_list, (int)diff);
+=
            if (v =3D=3D 0)
             {
-                const time_t v =
=3D CIRC_LIST_ITEM(p->seq_list, diff);
-                if (v =3D=3D 0)
-  =
              {
-                    return true;
-                }
-     =
           else
-                {
-                    /* raised from D_PI=
D_DEBUG_LOW to reduce verbosity */
-                    packet_id_debug(D_P=
ID_DEBUG_MEDIUM, p, pin, "PID_ERR replay", diff);
-                    retu=
rn false;
-                }
+                return true;
+            }
+=
            else
+            {
+                /* raised from D_PID_DEBUG=
_LOW to reduce verbosity */
+                packet_id_debug(D_PID_DEBUG_ME=
DIUM, p, pin, "PID_ERR replay", diff);
+                return false;
     =
        }
         }
         else if (pin->time < p->time) /* if time goes=
 back, reject */
@@ -384,7 +377,7 @@
         return false;
     }
 
-    c=
onst packet_id_type net_id =3D htonpid(p->id);
+    const packet_id_type ne=
t_id =3D htonpid((packet_id_type)p->id);
     const net_time_t net_time =3D=
 htontime(p->time);
     if (prepend)
     {
@@ -636,7 +629,7 @@
          =
      p->seq_backtrack, p->time_backtrack, p->max_backtrack_stat, (int)p->i=
nitialized);
     if (sl !=3D NULL)
     {
-        buf_printf(&out, " sl=
=3D[%d,%d,%d,%d]", sl->x_head, sl->x_size, sl->x_cap, sl->x_sizeof);
+     =
   buf_printf(&out, " sl=3D[%d,%d,%d,%zu]", sl->x_head, sl->x_size, sl->x_c=
ap, sl->x_sizeof);
     }
 
 
@@ -651,7 +644,6 @@
 {
     uint64_t packet_i=
d;
 
-
     if (!buf_read(buf, &packet_id, sizeof(packet_id)))
     {
     =
    return 0;
@@ -659,16 +651,12 @@
 
     uint64_t id =3D ntohll(packet_id=
);
     /* top most 16 bits */
-    uint16_t epoch =3D id >> 48;
+    uint1=
6_t epoch =3D (uint16_t)(id >> 48);
 
     pin->id =3D id & PACKET_ID_MASK;=

     return epoch;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pra=
gma GCC diagnostic pop
-#endif
-
 bool
 packet_id_write_epoch(struct packet=
_id_send *p, uint16_t epoch, struct buffer *buf)
 {
diff --git a/src/openvp=
n/packet_id=2Eh b/src/openvpn/packet_id=2Eh
index ba59067=2E=2E48752d3 1006=
44
--- a/src/openvpn/packet_id=2Eh
+++ b/src/openvpn/packet_id=2Eh
@@ -280,=
26 +280,20 @@
     return p->fd >=3D 0;
 }
 
-#if defined(__GNUC__) || defi=
ned(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored=
 "-Wconversion"
-#endif
-
-/* transfer packet_id -> packet_id_persist */
+/=
* transfer packet_id -> packet_id_persist
+   Note: Only supported for non-=
epoch format (i=2Ee=2E 32bit ID, not 64bit format),
+   must be enforced at=
 the caller=2E
+ */
 static inline void
 packet_id_persist_save_obj(struct =
packet_id_persist *p, const struct packet_id *pid)
 {
-    if (packet_id_pe=
rsist_enabled(p) && pid->rec=2Etime)
+    if (packet_id_persist_enabled(p) =
&& pid->rec=2Etime && pid->rec=2Eid <=3D PACKET_ID_MAX)
     {
         p->=
time =3D pid->rec=2Etime;
-        p->id =3D pid->rec=2Eid;
+        p->id =
=3D (packet_id_type)pid->rec=2Eid;
     }
 }
 
-#if defined(__GNUC__) || de=
fined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Reset the c=
urrent send packet id to its initial state=2E
  * Use very carefully (e=2Eg=
=2E in the standalone reset packet context) to

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Gerrit=
-Change-Number: 1407
Gerrit-PatchSet: 10
Gerrit-Owner: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--dXvv7MNM4ps=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">packet_id: Avoid conversion warnin=
gs<br><br>Most of these already have checks that the<br>values are as expec=
ted, so we can just add<br>the required casts=2E<br><br>Only the circ list =
x_sizeof is changed to<br>size_t since that is its purpose (and it is<br>no=
t actually used anyway)=2E<br><br>Change-Id: Ib0584e8728701cca10ac5675c9cb0=
e6f5eb901ac<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407<br>Message-Id: &lt;2026=
0818142226=2E27172-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38486=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/circ_list=2Eh<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/packe=
t_id=2Eh<br>3 files changed, 29 insertions(+), 47 deletions(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/circ_list=2Eh b/src/openvpn/circ_list=2Eh</sp=
an><br><span>index c29b0bb8=2E=2E76484ca 100644</span><br><span>--- a/src/o=
penvpn/circ_list=2Eh</span><br><span>+++ b/src/openvpn/circ_list=2Eh</span>=
<br><span>@@ -33,7 +33,7 @@</span><br><span>         int x_head;           =
\</span><br><span>         int x_size;           \</span><br><span>        =
 int x_cap;            \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int x_sizeof;         \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        size_t x_sizeof;      \</span><br><span>         typ=
e x_list[];        \</span><br><span>     }</span><br><span> </span><br><sp=
an>@@ -58,14 +58,14 @@</span><br><span>         (obj)-&gt;x_size =3D 0;   \=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define CIRC_LIST_ALLOC(dest, list_type, size)         =
                        \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {                                                                  =
        \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cons=
t int so =3D sizeof(list_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (dest) =3D (lis=
t_type *)malloc(so);                                      \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        check_malloc_return(dest);   =
                                          \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        memset((dest), 0, so);                       =
                          \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        (dest)-&gt;x_cap =3D size;                                   =
               \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   (dest)-&gt;x_sizeof =3D so;                                             =
    \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CIRC_L=
IST_ALLOC(dest, list_type, size)                                    \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {                    =
                                                         \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const size_t so =3D sizeof(l=
ist_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        (dest) =3D (list_type *)malloc(so=
);                                         \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        check_malloc_return(dest);                =
                                \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        memset((dest), 0, so);                               =
                     \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        (dest)-&gt;x_cap =3D size;                                      =
               \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     (dest)-&gt;x_sizeof =3D so;                                           =
         \</span><br><span>     }</span><br><span> </span><br><span> #defin=
e CIRC_LIST_FREE(dest) free(dest)</span><br><span>diff --git a/src/openvpn/=
packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index 50d7c76=2E=
=2E9dd6ce3 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br=
><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -71,11 +71,6 @@</=
span><br><span> #endif</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> static void</span><br><span> packet_id_init_rec=
v(struct packet_id_rec *rec, int seq_backtrack, int time_backtrack,</span><=
br><span>                     const char *name, int unit)</span><br><span>@=
@ -119,7 +114,7 @@</span><br><span> </span><br><span>     /* Reinitalise th=
e source */</span><br><span>     CLEAR(*src);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    packet_id_init_recv(src, dest-&gt;seq_backtrack=
, dest-&gt;time_backtrack, dest-&gt;name, dest-&gt;unit);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    packet_id_init_recv(src, (int)des=
t-&gt;seq_backtrack, dest-&gt;time_backtrack, dest-&gt;name, dest-&gt;unit)=
;</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n>@@ -170,7 +165,7 @@</span><br><span>         diff =3D p-&gt;id - pin-&gt;=
id;</span><br><span>         if (diff &lt; CIRC_LIST_SIZE(p-&gt;seq_list) &=
amp;&amp; local_now &gt; SEQ_EXPIRED)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            CIRC_LIST_ITEM(p-&gt=
;seq_list, diff) =3D local_now;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff) =3D local=
_now;</span><br><span>         }</span><br><span>     }</span><br><span>   =
  else</span><br><span>@@ -261,18 +256,16 @@</span><br><span>              =
   return false;</span><br><span>             }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            const time_t v =
=3D CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (v =3D=3D 0)</span><br><span>    =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     const time_t v =3D CIRC_LIST_ITEM(p-&gt;seq_list, diff);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (v =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    return tr=
ue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* rais=
ed from D_PID_DEBUG_LOW to reduce verbosity */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    packet_id_debug(D_PID_DEBUG_ME=
DIUM, p, pin, &quot;PID_ERR replay&quot;, diff);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    return false;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                return true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                /* raised from D_PID_DEBUG_L=
OW to reduce verbosity */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, &quot;PID=
_ERR replay&quot;, diff);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                return false;</span><br><span>             }</span><b=
r><span>         }</span><br><span>         else if (pin-&gt;time &lt; p-&g=
t;time) /* if time goes back, reject */</span><br><span>@@ -384,7 +377,7 @@=
</span><br><span>         return false;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const packet=
_id_type net_id =3D htonpid(p-&gt;id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const packet_id_type net_id =3D htonpid((packet_id_t=
ype)p-&gt;id);</span><br><span>     const net_time_t net_time =3D htontime(=
p-&gt;time);</span><br><span>     if (prepend)</span><br><span>     {</span=
><br><span>@@ -636,7 +629,7 @@</span><br><span>                p-&gt;seq_ba=
cktrack, p-&gt;time_backtrack, p-&gt;max_backtrack_stat, (int)p-&gt;initial=
ized);</span><br><span>     if (sl !=3D NULL)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out,=
 &quot; sl=3D[%d,%d,%d,%d]&quot;, sl-&gt;x_head, sl-&gt;x_size, sl-&gt;x_ca=
p, sl-&gt;x_sizeof);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        buf_printf(&amp;out, &quot; sl=3D[%d,%d,%d,%zu]&quot;, sl-&gt;x_he=
ad, sl-&gt;x_size, sl-&gt;x_cap, sl-&gt;x_sizeof);</span><br><span>     }</=
span><br><span> </span><br><span> </span><br><span>@@ -651,7 +644,6 @@</spa=
n><br><span> {</span><br><span>     uint64_t packet_id;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     i=
f (!buf_read(buf, &amp;packet_id, sizeof(packet_id)))</span><br><span>     =
{</span><br><span>         return 0;</span><br><span>@@ -659,16 +651,12 @@<=
/span><br><span> </span><br><span>     uint64_t id =3D ntohll(packet_id);</=
span><br><span>     /* top most 16 bits */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint16_t epoch =3D id &gt;&gt; 48;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch =3D (uint16_t)(i=
d &gt;&gt; 48);</span><br><span> </span><br><span>     pin-&gt;id =3D id &a=
mp; PACKET_ID_MASK;</span><br><span>     return epoch;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> bool</span><br><span> packet_id_write_epoch(struct=
 packet_id_send *p, uint16_t epoch, struct buffer *buf)</span><br><span> {<=
/span><br><span>diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet=
_id=2Eh</span><br><span>index ba59067=2E=2E48752d3 100644</span><br><span>-=
-- a/src/openvpn/packet_id=2Eh</span><br><span>+++ b/src/openvpn/packet_id=
=2Eh</span><br><span>@@ -280,26 +280,20 @@</span><br><span>     return p-&g=
t;fd &gt;=3D 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* transfer packe=
t_id -&gt; packet_id_persist */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* transfer packet_id -&gt; packet_id_persist</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   Note: Only supported for non-epoch=
 format (i=2Ee=2E 32bit ID, not 64bit format),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   must be enforced at the caller=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inl=
ine void</span><br><span> packet_id_persist_save_obj(struct packet_id_persi=
st *p, const struct packet_id *pid)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(p) &amp;=
&amp; pid-&gt;rec=2Etime)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (packet_id_persist_enabled(p) &amp;&amp; pid-&gt;rec=2Etime &a=
mp;&amp; pid-&gt;rec=2Eid &lt;=3D PACKET_ID_MAX)</span><br><span>     {</sp=
an><br><span>         p-&gt;time =3D pid-&gt;rec=2Etime;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        p-&gt;id =3D pid-&gt;rec=2Eid;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p-&gt;id =3D =
(packet_id_type)pid-&gt;rec=2Eid;</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /**</span><br><span>  * Reset the current send p=
acket id to its initial state=2E</span><br><span>  * Use very carefully (e=
=2Eg=2E in the standalone reset packet context) to</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3D=
email">change 1407</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1407?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1407 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--dXvv7MNM4ps=--


--===============8289682309170884746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8289682309170884746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8289682309170884746==--

