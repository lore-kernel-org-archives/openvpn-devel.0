Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27640C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1vfLjgTS6dmQjM1g4Pg82Qu5GLK/tf/TvmU2oknWs8=; b=nJ51RW7pkTQuhNVeYmen3Dq0++
	ZGOorX9lbc4KKX+OQzW4oy+9DKM13h2mry90Nzhj9Y/o5AC9DxLndp5n94p8O6X+bN9UjyVa05dop
	YNH39izvINxrgYROpZZeHi+hpWICiqkbn4OYJllvPnyth3lziCtv+ZAZNqg8akX+OYRE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupt2-0004Ku-6Q;
	Fri, 14 Aug 2026 11:15:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupsk-0004Kc-7g
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Uyye3LPcTzVByNUQ5U7DGHkCaGpF+QvWuU5sadYJfCg=; b=Fpa5iZtSOPk1MDs6hLNwMBBttw
 zaUOGhiyej/NM2sfVCnIBaCNyGWVjrXubY3DGPaaHMfzdyyj9pIeTHmACeztHgtS496PJTXtbE79s
 8dYRQr3nyI0YFVkMYtBaUvaZNV0GVRY4zky4zPgbHLWs7gL55oS18b2QyO1ZfCC4yUJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Uyye3LPcTzVByNUQ5U7DGHkCaGpF+QvWuU5sadYJfCg=; b=i
 ZDbICrXwNu5uCuV48+yu9RWRtrvNCAs+nNdTWpVxrcycg8MTzhsJz6fcuyMQLXWdr/uTwPf4htljt
 uxULRwkyxYGq/6KZZxoM+HiolY0RJMp+68Dlh9PLGZKotubOSmtBNX3WsfPjb4fX7eB1ff06c2Wqs
 KCm+1kY1UyNCuKss=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupse-0003FL-I7 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:15:23 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so8514935e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786706114; x=1787310914; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Uyye3LPcTzVByNUQ5U7DGHkCaGpF+QvWuU5sadYJfCg=;
 b=aHq9vC/PMYU/70Dvyo6+Y9I2nf7CrJ40Ys+7BUG82FYTQIy4nhM0fbA7GyjkP3WXvz
 hZuQDyWoc+jmdDXJXR/B1lzursJVdb6w8P46a093d8YF2DBbx1KJlZWHm1UGV8DSV+Jl
 F7IF+xjOzixvCrGaI4EZBPowrNF96H1KSoNfS2Aej0WeQR1Evm0tFZ0R3HRl/2/QKtJ4
 xnZsL1CQMZ/6Pqq45Yf82DzzH/4tBXKM4ybai4JJjFY1yv0cnEHZMDUHy9bSV8oJT7Vp
 wRjpWs6IYNhxqwuukBTw/NqkHQDHt+yCyRZmsoFWzpJc8kJSjFV8cSN+qY946CkyfVnd
 jjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706114; x=1787310914;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Uyye3LPcTzVByNUQ5U7DGHkCaGpF+QvWuU5sadYJfCg=;
 b=TCuEkEgKSelQ6LoeJgNQhcXXW/6T3vY39SBfAp1RqmYh41ILqM/rWL2dmFP7P7iAXC
 jtnoRvtsPc5NzKTAmy2NHAcCo2B3noo+wVO9YnOmmSCRMvBMCO9hYe8xHX2wVCSPSOI8
 4RLxbSHYa1KmUGa6RY2uqfmsEFSUcvRCg/mPK0h6V7y3xmBThROCbKxNFOlNJ0eOQnj1
 3Aap9djtMD+dN4l/dvFY8F7ybtXnHvI8gg3FPtQVnUB3r8JSahzL0JQ8d7U8dx9OlWYS
 ZnG9u9KpzsXafZO+w2hYmZTxnaGr8LF4WaOfdRlRqlavUwTVUStjglOTDZqMfA3yvtW3
 p3yg==
X-Gm-Message-State: AOJu0YzXI+aUlxlcqJDDurukCWLHIhAyWfu9p8+P04uzoEGcox87B59O
 AP7v3FyRG6cGcAPccE43ZSde+4IvNDcOmf841gNS1hozvC1yQRNMgthy5XbecXVPTXsEH1Y94EO
 sbm/WAzdaUKwyyIzMtXQ7BCf+WgHfCS0VpPd+4BGTOYzvdcg48OdCJ6iFeJ79gfFHfWKlta1lcK
 YTzTfX6g==
X-Gm-Gg: AR+sD12DmTSJ6GJ8krV5IqM+nU+sTE6ZXV8KPg5mghcntjcQO/MgUpqPMWJQa53nuDj
 vk+ULGPUUEcRQc2SND9UcYvMsBS86g6Mt5+MexI8luxtGIVKLdDHdv2tisjQEaHtJzGMblpajXv
 vOCaZZ7pcSzbEh5PWrTQ2FbOg1VXY+kIHpi2gzPPmqka59z8ZkAa4GX75ksKK/71u2TrUfxw81v
 AR9PgN5loXT+3nA2AcVclweoRMD2aNytCb536AJYnhbLxwhApt7Yu2kNBykXH3ccdD9D/W0Q2ue
 T7gSWnDF3x7t97HuEFFMU37Cfi18HeWs7CNouvo396TsVWqPFvgkqPnh9ZsoNWJPiznanv+9yzk
 sZ+JfyjX3X3NTR8UAG4OXxKL+0XciudTXFzbhX55rqAJyvdUbPpqKsRi/3IORm2jiLlVJvJVoLz
 tc0a+09KX1bW0ne4Fxr+6TlYLViQVvnH8MKBnWI0f5kDRv2wewcuHp09FkXlI3skh902XJ5GsXN
 GrOYv3Q6zaHFiDYb9E+RMh9sTzFzYLLuIN1pqjB9VQ+3Uu9wFF/Twjade2/lkDN+QQdGGE6G47j
 Fa7YzsbV6si8mi86TYKXfSQDPqnS5f4mRNNOAU0Ttztb+RaHDS9V
X-Received: by 2002:a05:600c:3acf:b0:499:728c:4704 with SMTP id
 5b1f17b1804b1-49987979c41mr79154645e9.12.1786706113751; 
 Fri, 14 Aug 2026 04:15:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d8f4sm43364285e9.11.2026.08.14.04.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:15:13 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:15:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 8535abbeca3e048d7a90af0e14bd5d812649fe86
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <927e01d6c7eedd3e25fa5abff239c07af75b9a80-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupse-0003FL-I7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3133858247241017969=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3133858247241017969==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ml2rJyS+X8="; charset=UTF-8

--1ml2rJyS+X8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1407?usp=3Demail

to look at the new patch set (#8)=2E

=
The following approvals got outdated and were removed:
Code-Review-1 by pla=
isthos


Change subject: packet_id: Avoid conversion warnings
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

packet_id: Avoid conversi=
on warnings

Most of these already have checks that the
values are as expec=
ted, so we can just add
the required casts=2E

Only the circ list x_sizeof =
is changed to
size_t since that is its purpose (and it is
not actually used=
 anyway)=2E

Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/circ_li=
st=2Eh
M src/openvpn/packet_id=2Ec
M src/openvpn/packet_id=2Eh
3 files chan=
ged, 29 insertions(+), 47 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/07/1407/8

diff --git a/src/openvpn/circ_=
list=2Eh b/src/openvpn/circ_list=2Eh
index c29b0bb8=2E=2E76484ca 100644
---=
 a/src/openvpn/circ_list=2Eh
+++ b/src/openvpn/circ_list=2Eh
@@ -33,7 +33,7=
 @@
         int x_head;           \
         int x_size;           \
     =
    int x_cap;            \
-        int x_sizeof;         \
+        size_=
t x_sizeof;      \
         type x_list[];        \
     }
 
@@ -58,14 +58,=
14 @@
         (obj)->x_size =3D 0;   \
     }
 
-#define CIRC_LIST_ALLOC(d=
est, list_type, size)                                 \
-    {             =
                                                             \
-        con=
st int so =3D sizeof(list_type) + sizeof((dest)->x_list[0]) * (size); \
-  =
      (dest) =3D (list_type *)malloc(so);                                  =
    \
-        check_malloc_return(dest);                                  =
           \
-        memset((dest), 0, so);                               =
                  \
-        (dest)->x_cap =3D size;                       =
                           \
-        (dest)->x_sizeof =3D so;             =
                                    \
+#define CIRC_LIST_ALLOC(dest, list_t=
ype, size)                                    \
+    {                     =
                                                        \
+        const si=
ze_t so =3D sizeof(list_type) + sizeof((dest)->x_list[0]) * (size); \
+    =
    (dest) =3D (list_type *)malloc(so);                                    =
     \
+        check_malloc_return(dest);                                 =
               \
+        memset((dest), 0, so);                           =
                         \
+        (dest)->x_cap =3D size;                =
                                     \
+        (dest)->x_sizeof =3D so;   =
                                                 \
     }
 
 #define CIRC_L=
IST_FREE(dest) free(dest)
diff --git a/src/openvpn/packet_id=2Ec b/src/open=
vpn/packet_id=2Ec
index a4b627c=2E=2Eb0211d7 100644
--- a/src/openvpn/packe=
t_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -71,11 +71,6 @@
 #endif
 }
 
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#p=
ragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 packet_=
id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time_backtra=
ck,
                     const char *name, int unit)
@@ -119,7 +114,7 @@
 
=
     /* Reinitalise the source */
     CLEAR(*src);
-    packet_id_init_rec=
v(src, dest->seq_backtrack, dest->time_backtrack, dest->name, dest->unit);
=
+    packet_id_init_recv(src, (int)dest->seq_backtrack, dest->time_backtrac=
k, dest->name, dest->unit);
 }
 
 void
@@ -170,7 +165,7 @@
         diff =
=3D p->id - pin->id;
         if (diff < CIRC_LIST_SIZE(p->seq_list) && loc=
al_now > SEQ_EXPIRED)
         {
-            CIRC_LIST_ITEM(p->seq_list, d=
iff) =3D local_now;
+            CIRC_LIST_ITEM(p->seq_list, (int)diff) =3D=
 local_now;
         }
     }
     else
@@ -263,18 +258,16 @@
             =
    return false;
             }
 
+            const time_t v =3D CIRC_LIS=
T_ITEM(p->seq_list, (int)diff);
+            if (v =3D=3D 0)
             {=

-                const time_t v =3D CIRC_LIST_ITEM(p->seq_list, diff);
-  =
              if (v =3D=3D 0)
-                {
-                    retur=
n true;
-                }
-                else
-                {
-      =
              /* raised from D_PID_DEBUG_LOW to reduce verbosity */
-      =
              packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, "PID_ERR replay",=
 diff);
-                    return false;
-                }
+            =
    return true;
+            }
+            else
+            {
+         =
       /* raised from D_PID_DEBUG_LOW to reduce verbosity */
+             =
   packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, "PID_ERR replay", diff);
+  =
              return false;
             }
         }
         else if (pin=
->time < p->time) /* if time goes back, reject */
@@ -386,7 +379,7 @@
     =
    return false;
     }
 
-    const packet_id_type net_id =3D htonpid(p->=
id);
+    const packet_id_type net_id =3D htonpid((packet_id_type)p->id);
 =
    const net_time_t net_time =3D htontime(p->time);
     if (prepend)
    =
 {
@@ -640,7 +633,7 @@
                p->seq_backtrack, p->time_backtrack,=
 p->max_backtrack_stat, (int)p->initialized);
     if (sl !=3D NULL)
     {=

-        buf_printf(&out, " sl=3D[%d,%d,%d,%d]", sl->x_head, sl->x_size, s=
l->x_cap, sl->x_sizeof);
+        buf_printf(&out, " sl=3D[%d,%d,%d,%zu]", =
sl->x_head, sl->x_size, sl->x_cap, sl->x_sizeof);
     }
 
 
@@ -655,7 +648=
,6 @@
 {
     uint64_t packet_id;
 
-
     if (!buf_read(buf, &packet_id, s=
izeof(packet_id)))
     {
         return 0;
@@ -663,16 +655,12 @@
 
     u=
int64_t id =3D ntohll(packet_id);
     /* top most 16 bits */
-    uint16_t=
 epoch =3D id >> 48;
+    uint16_t epoch =3D (uint16_t)(id >> 48);
 
     p=
in->id =3D id & PACKET_ID_MASK;
     return epoch;
 }
 
-#if defined(__GNUC=
__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 pack=
et_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buffer *=
buf)
 {
diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh
=
index ba59067=2E=2E48752d3 100644
--- a/src/openvpn/packet_id=2Eh
+++ b/src=
/openvpn/packet_id=2Eh
@@ -280,26 +280,20 @@
     return p->fd >=3D 0;
 }
 =

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
=
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/* transfer packe=
t_id -> packet_id_persist */
+/* transfer packet_id -> packet_id_persist
+ =
  Note: Only supported for non-epoch format (i=2Ee=2E 32bit ID, not 64bit f=
ormat),
+   must be enforced at the caller=2E
+ */
 static inline void
 pac=
ket_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id=
 *pid)
 {
-    if (packet_id_persist_enabled(p) && pid->rec=2Etime)
+    if=
 (packet_id_persist_enabled(p) && pid->rec=2Etime && pid->rec=2Eid <=3D PAC=
KET_ID_MAX)
     {
         p->time =3D pid->rec=2Etime;
-        p->id =3D=
 pid->rec=2Eid;
+        p->id =3D (packet_id_type)pid->rec=2Eid;
     }
 }=

 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop=

-#endif
-
 /**
  * Reset the current send packet id to its initial state=
=2E
  * Use very carefully (e=2Eg=2E in the standalone reset packet context=
) to

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0584e87287=
01cca10ac5675c9cb0e6f5eb901ac
Gerrit-Change-Number: 1407
Gerrit-PatchSet: 8=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>

--1ml2rJyS+X8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">packet_id: Avoid conversion warnings<br><br>Most of these alread=
y have checks that the<br>values are as expected, so we can just add<br>the=
 required casts=2E<br><br>Only the circ list x_sizeof is changed to<br>size=
_t since that is its purpose (and it is<br>not actually used anyway)=2E<br>=
<br>Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/c=
irc_list=2Eh<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/packet_id=2Eh<=
br>3 files changed, 29 insertions(+), 47 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/1=
407/8</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/circ_list=2Eh b/src/openvpn/circ_lis=
t=2Eh</span><br><span>index c29b0bb8=2E=2E76484ca 100644</span><br><span>--=
- a/src/openvpn/circ_list=2Eh</span><br><span>+++ b/src/openvpn/circ_list=
=2Eh</span><br><span>@@ -33,7 +33,7 @@</span><br><span>         int x_head;=
           \</span><br><span>         int x_size;           \</span><br><sp=
an>         int x_cap;            \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int x_sizeof;         \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        size_t x_sizeof;      \</span><br><span> =
        type x_list[];        \</span><br><span>     }</span><br><span> </s=
pan><br><span>@@ -58,14 +58,14 @@</span><br><span>         (obj)-&gt;x_size=
 =3D 0;   \</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CIRC_LIST_ALLOC(dest, list_type, si=
ze)                                 \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {                                                      =
                    \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        const int so =3D sizeof(list_type) + sizeof((dest)-&gt;x_list[0]) *=
 (size); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (de=
st) =3D (list_type *)malloc(so);                                      \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_malloc_retu=
rn(dest);                                             \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        memset((dest), 0, so);           =
                                      \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        (dest)-&gt;x_cap =3D size;                       =
                           \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        (dest)-&gt;x_sizeof =3D so;                                 =
                \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine CIRC_LIST_ALLOC(dest, list_type, size)                               =
     \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {        =
                                                                     \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const size_t so =
=3D sizeof(list_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        (dest) =3D (list_type =
*)malloc(so);                                         \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        check_malloc_return(dest);     =
                                           \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        memset((dest), 0, so);                    =
                                \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        (dest)-&gt;x_cap =3D size;                           =
                          \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        (dest)-&gt;x_sizeof =3D so;                                =
                    \</span><br><span>     }</span><br><span> </span><br><s=
pan> #define CIRC_LIST_FREE(dest) free(dest)</span><br><span>diff --git a/s=
rc/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index =
a4b627c=2E=2Eb0211d7 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec=
</span><br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -71,11 =
+71,6 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> packet_i=
d_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time_backtrac=
k,</span><br><span>                     const char *name, int unit)</span><=
br><span>@@ -119,7 +114,7 @@</span><br><span> </span><br><span>     /* Rein=
italise the source */</span><br><span>     CLEAR(*src);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    packet_id_init_recv(src, dest-&gt;seq=
_backtrack, dest-&gt;time_backtrack, dest-&gt;name, dest-&gt;unit);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init_recv(src=
, (int)dest-&gt;seq_backtrack, dest-&gt;time_backtrack, dest-&gt;name, dest=
-&gt;unit);</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span>@@ -170,7 +165,7 @@</span><br><span>         diff =3D p-&gt;id =
- pin-&gt;id;</span><br><span>         if (diff &lt; CIRC_LIST_SIZE(p-&gt;s=
eq_list) &amp;&amp; local_now &gt; SEQ_EXPIRED)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            CIRC_LIST_=
ITEM(p-&gt;seq_list, diff) =3D local_now;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff)=
 =3D local_now;</span><br><span>         }</span><br><span>     }</span><br=
><span>     else</span><br><span>@@ -263,18 +258,16 @@</span><br><span>    =
             return false;</span><br><span>             }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const t=
ime_t v =3D CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (v =3D=3D 0)</span><br><s=
pan>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             const time_t v =3D CIRC_LIST_ITEM(p-&gt;seq_list, diff);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (v =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   /* raised from D_PID_DEBUG_LOW to reduce verbosity */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    packet_id_debug(D_PI=
D_DEBUG_MEDIUM, p, pin, &quot;PID_ERR replay&quot;, diff);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    return false;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* raised from D_P=
ID_DEBUG_LOW to reduce verbosity */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin,=
 &quot;PID_ERR replay&quot;, diff);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                return false;</span><br><span>             =
}</span><br><span>         }</span><br><span>         else if (pin-&gt;time=
 &lt; p-&gt;time) /* if time goes back, reject */</span><br><span>@@ -386,7=
 +379,7 @@</span><br><span>         return false;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst packet_id_type net_id =3D htonpid(p-&gt;id);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const packet_id_type net_id =3D htonpid((p=
acket_id_type)p-&gt;id);</span><br><span>     const net_time_t net_time =3D=
 htontime(p-&gt;time);</span><br><span>     if (prepend)</span><br><span>  =
   {</span><br><span>@@ -640,7 +633,7 @@</span><br><span>                p-=
&gt;seq_backtrack, p-&gt;time_backtrack, p-&gt;max_backtrack_stat, (int)p-&=
gt;initialized);</span><br><span>     if (sl !=3D NULL)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf=
(&amp;out, &quot; sl=3D[%d,%d,%d,%d]&quot;, sl-&gt;x_head, sl-&gt;x_size, s=
l-&gt;x_cap, sl-&gt;x_sizeof);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_printf(&amp;out, &quot; sl=3D[%d,%d,%d,%zu]&quot;, s=
l-&gt;x_head, sl-&gt;x_size, sl-&gt;x_cap, sl-&gt;x_sizeof);</span><br><spa=
n>     }</span><br><span> </span><br><span> </span><br><span>@@ -655,7 +648=
,6 @@</span><br><span> {</span><br><span>     uint64_t packet_id;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>     if (!buf_read(buf, &amp;packet_id, sizeof(packet_id)))</span><br><=
span>     {</span><br><span>         return 0;</span><br><span>@@ -663,16 +=
655,12 @@</span><br><span> </span><br><span>     uint64_t id =3D ntohll(pac=
ket_id);</span><br><span>     /* top most 16 bits */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint16_t epoch =3D id &gt;&gt; 48;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch =3D (=
uint16_t)(id &gt;&gt; 48);</span><br><span> </span><br><span>     pin-&gt;i=
d =3D id &amp; PACKET_ID_MASK;</span><br><span>     return epoch;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> bool</span><br><span> packet_id_write_e=
poch(struct packet_id_send *p, uint16_t epoch, struct buffer *buf)</span><b=
r><span> {</span><br><span>diff --git a/src/openvpn/packet_id=2Eh b/src/ope=
nvpn/packet_id=2Eh</span><br><span>index ba59067=2E=2E48752d3 100644</span>=
<br><span>--- a/src/openvpn/packet_id=2Eh</span><br><span>+++ b/src/openvpn=
/packet_id=2Eh</span><br><span>@@ -280,26 +280,20 @@</span><br><span>     r=
eturn p-&gt;fd &gt;=3D 0;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* trans=
fer packet_id -&gt; packet_id_persist */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* transfer packet_id -&gt; packet_id_persist</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+   Note: Only supported for =
non-epoch format (i=2Ee=2E 32bit ID, not 64bit format),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+   must be enforced at the caller=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> s=
tatic inline void</span><br><span> packet_id_persist_save_obj(struct packet=
_id_persist *p, const struct packet_id *pid)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled=
(p) &amp;&amp; pid-&gt;rec=2Etime)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (packet_id_persist_enabled(p) &amp;&amp; pid-&gt;rec=
=2Etime &amp;&amp; pid-&gt;rec=2Eid &lt;=3D PACKET_ID_MAX)</span><br><span>=
     {</span><br><span>         p-&gt;time =3D pid-&gt;rec=2Etime;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;id =3D pid-&gt;r=
ec=2Eid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p-&=
gt;id =3D (packet_id_type)pid-&gt;rec=2Eid;</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Reset the curr=
ent send packet id to its initial state=2E</span><br><span>  * Use very car=
efully (e=2Eg=2E in the standalone reset packet context) to</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1407?usp=3Demail">change 1407</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e=
6f5eb901ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1407 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"=
display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--1ml2rJyS+X8=--


--===============3133858247241017969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3133858247241017969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3133858247241017969==--

