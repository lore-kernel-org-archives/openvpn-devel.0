Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5E8CCF2D1
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eMbHSMbsE72nkzi/T7n22F0yP2i0pYR4EdOb6YtSkEI=; b=gSnCSWCAf4dIFkO1Y9MqE6fW81
	/MnTMWOnSRWtxqxM1NFRIF2wIOEUyoXjgjbNVqJpIuLQBh/Tix2WElIAa8xnucsQW6piPr4ItCmRV
	ysAYynKOFY7KbcBPRasU0Xry+WcMGl/FTE43CxL2h2WUnLbql0xOwfv9xa6peB+oxopw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7Z6-0001Uo-8Y;
	Sat, 17 Oct 2026 16:47:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7Yw-0001UW-Fz
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gZw72Ur+h+h2vjFmufnNIAvchg/tp0AraeRe8Oaiu4o=; b=N/jCOFkICEB60KVNZ6R0PXZKIE
 1ap8TcRwmLIDw3UFQ27Wb6B0UZ2Nt6q43nOcrFqciBEsp0kXm51lqT9NgwJAnp2Zcu2T6aHGNuX5A
 WP3QSh1/AxrbJ4dGhrz+H95hpM1GACKSP9KffQMR8pBEL5oaLoaEc0/vhi8xsewLpwSU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gZw72Ur+h+h2vjFmufnNIAvchg/tp0AraeRe8Oaiu4o=; b=a
 ytZDb2OGGRf3CJ+XJpAZPd6XCgvGHqiQNcHIB0jG6Rn3+kxDEz7n6zzkOO68/l1SXPjodpXmXQhsP
 H94MGWgi+fjsM4DeVs8VkWvs5AAjlXqsbtGG4/7lTFAP5bRGJ2kY/L1Ka0C/3O0O5/e7kZmW8iw+9
 mMfUyPgxZP7Tpbpc=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7Yv-00068h-Mf for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:15 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso4836095e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792255627; x=1792860427; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gZw72Ur+h+h2vjFmufnNIAvchg/tp0AraeRe8Oaiu4o=;
 b=Y7ToQOC+QfPS0pDs1hhdeqYbp3UT1cICa597dH0EQFwPpP8BerMPcO+5fZG5ZB1xax
 4XxLWVv5EUCK0heRXimeFIlXdmieHYwjY6A9sfr1IRBlCfxXYqxMA9FriTwXX1RtrvD6
 xDNUMZBU59oDd7ziqJs32SJPvLzCoxA5qsmfsyMZmc0AahsBWjeERwyEiuiKcm47Lmrv
 lMjgW31KNCkVhdgrZX8EVE2fCyF+OlWLEGpTus2ZGuyxQus6DKk2cGz4uFeLgp0lPCmo
 pWIRtl8HW2BBhXrVjGNddd1j71gQ/p0C4YV8JSy/agiETZdYWKC4GH0inBmZvd/sD1YV
 QQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792255627; x=1792860427;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gZw72Ur+h+h2vjFmufnNIAvchg/tp0AraeRe8Oaiu4o=;
 b=QHw+ieNOJZbrLwVLUZYquZXgf93hUIihvxoc0FqRzUy/KydGWRUL8JuPEFLRXsp5Gk
 PnprvlPu4oNO9dvJgLAcl6XtuaDg1ba+cmNxxO0FjPNCB6WBeP/ALhYOqdjKUtOhta2n
 VF7tSruUDLgdM509dFzgvPmjrjmV3vZWNNCYs2euNJHUw62Lm33uSRyHiWAMvwnWAaOr
 0InhjK9gxX7nPXu6n3sxjMSE/iOkGt0pe9K6jLNFbg6d+sUqBD074zNXAViflWCRJeKy
 b+fVPeQgPR1UyPjZabdTr8dP2ER2mRT4Vrsme7hoSFtTfdBdzElDWgrWkMLgETRX+Spo
 NRiw==
X-Gm-Message-State: AFq9FYJdLEuYVfJ937qgPnZFRYLVio642rI0Ngco/54bTYvwuLweoBxq
 3Xqs8ZK9w8bX+12mDQqVzAVIOKllz2u1d48rb55Z8m49lyq0ywfsUSkiRokpOCEHxdXuo+9/4h8
 Mi+N2HQdavjwRtgXjDsO2/IFFXBD6Zb+0vZaaSffPs4kxaab/dV0ZVFVmTa0/wfGLtIHjNJtsqw
 scpT3B7w==
X-Gm-Gg: AYBFou2T933Prc6n6aty7bD9JUa+EglNVmNUQo2Z99NEoQY9mU8J4JqChBeLymcZeEB
 7Vlsm1qh340J4jUqryTjxWJwgtdoBjwTUzHy6AqDBGRaoze4N3p4ydi/EtlRz5gvu8uAVXp72Kh
 ZLaTppxr1mxCbPixIRMkciv3PMVKKEUivA7L1a7pAP37LkitZpOtm3i8vxwmpIOc04wnTG2Mk7P
 RgTn3vqgvts1nTo/+HN5U5kkBblSo+Cvd1XNO8uMC3FDX64ahnzTkdk7HkodSf/Disum+Vw/yyA
 wQEZ6psB9HR1fsT8zEQ8aTTBlELfeZQMRgz032uaQ8IOXfGlq7eCYFqKkVydtRMmzmLqHhzD/x7
 1bvVtvF4TXwu+lvsp6Rhw9F2Jc2oiwSD8OS/o85rLFaYEW2l7b16m4apuYpol7/pxnUSOFkMWkv
 wSwdlYaYUvCb+v5KilXJdJiw6toZMqgV30epWihmmVRJdXfcM+c1D0Z7oT9wzvRZjLXoLPak32p
 uEckquIjLMuYlzH0SqS9haKGx9QzMxQLdC59q2MIC0+PU2OjSBO2IS1VvmDsNh1mPBBjoz3Ev8H
 oqOJyqn1vv7IGIZTvI962McQymEqj9gqa6VjsKweAu0UKcmpwXGFn52qPvQZM5QsvK6ko8c=
X-Received: by 2002:a05:600c:4e94:b0:4a1:93fd:8f2 with SMTP id
 5b1f17b1804b1-4a1d75e3c4dmr64649655e9.6.1792255626910; 
 Sat, 17 Oct 2026 09:47:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b303csm229322915e9.8.2026.10.17.09.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:47:06 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:47:02 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 624e4a91a9e49f25001ae2f0b037264ade1f3a98
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8820d6f05e5ec9aae051699e171c1a55e1980125-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7Yv-00068h-Mf
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0246332340638794594=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0246332340638794594==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iOaKasfpY6c="; charset=UTF-8

--iOaKasfpY6c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Hello Arne Schw=
abe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please v=
isit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail

to l=
ook at the new patch set (#9)=2E

The change is no longer submittable: chec=
ks~ChecksSubmitRule is unsatisfied now=2E


Change subject: packet_id: Avoi=
d conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

packet_id: Avoid conversion warnings

Most of these already have=
 checks that the
values are as expected, so we can just add
the required ca=
sts=2E

Only the circ list x_sizeof is changed to
size_t since that is its =
purpose (and it is
not actually used anyway)=2E

Change-Id: Ib0584e8728701c=
ca10ac5675c9cb0e6f5eb901ac
Signed-off-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
---
M src/openvpn/circ_list=2Eh
M src/openvpn/packet_id=2Ec
M sr=
c/openvpn/packet_id=2Eh
3 files changed, 29 insertions(+), 47 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/140=
7/9

diff --git a/src/openvpn/circ_list=2Eh b/src/openvpn/circ_list=2Eh
ind=
ex c29b0bb8=2E=2E76484ca 100644
--- a/src/openvpn/circ_list=2Eh
+++ b/src/o=
penvpn/circ_list=2Eh
@@ -33,7 +33,7 @@
         int x_head;           \
   =
      int x_size;           \
         int x_cap;            \
-        int=
 x_sizeof;         \
+        size_t x_sizeof;      \
         type x_list[=
];        \
     }
 
@@ -58,14 +58,14 @@
         (obj)->x_size =3D 0;   \
=
     }
 
-#define CIRC_LIST_ALLOC(dest, list_type, size)                   =
              \
-    {                                                     =
                     \
-        const int so =3D sizeof(list_type) + sizeof=
((dest)->x_list[0]) * (size); \
-        (dest) =3D (list_type *)malloc(so)=
;                                      \
-        check_malloc_return(dest)=
;                                             \
-        memset((dest), 0, =
so);                                                 \
-        (dest)->x_c=
ap =3D size;                                                  \
-        (d=
est)->x_sizeof =3D so;                                                 \
+#=
define CIRC_LIST_ALLOC(dest, list_type, size)                              =
      \
+    {                                                             =
                \
+        const size_t so =3D sizeof(list_type) + sizeof((=
dest)->x_list[0]) * (size); \
+        (dest) =3D (list_type *)malloc(so); =
                                        \
+        check_malloc_return(dest=
);                                                \
+        memset((dest),=
 0, so);                                                    \
+        (des=
t)->x_cap =3D size;                                                     \
+=
        (dest)->x_sizeof =3D so;                                           =
         \
     }
 
 #define CIRC_LIST_FREE(dest) free(dest)
diff --git a/s=
rc/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index 50d7c76=2E=2E9dd=
6ce3 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec=

@@ -71,11 +71,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || defined(__clang_=
_)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversi=
on"
-#endif
-
 static void
 packet_id_init_recv(struct packet_id_rec *rec, =
int seq_backtrack, int time_backtrack,
                     const char *nam=
e, int unit)
@@ -119,7 +114,7 @@
 
     /* Reinitalise the source */
     C=
LEAR(*src);
-    packet_id_init_recv(src, dest->seq_backtrack, dest->time_b=
acktrack, dest->name, dest->unit);
+    packet_id_init_recv(src, (int)dest-=
>seq_backtrack, dest->time_backtrack, dest->name, dest->unit);
 }
 
 void
@=
@ -170,7 +165,7 @@
         diff =3D p->id - pin->id;
         if (diff < C=
IRC_LIST_SIZE(p->seq_list) && local_now > SEQ_EXPIRED)
         {
-        =
    CIRC_LIST_ITEM(p->seq_list, diff) =3D local_now;
+            CIRC_LIST=
_ITEM(p->seq_list, (int)diff) =3D local_now;
         }
     }
     else
@@=
 -261,18 +256,16 @@
                 return false;
             }
 
+      =
      const time_t v =3D CIRC_LIST_ITEM(p->seq_list, (int)diff);
+         =
   if (v =3D=3D 0)
             {
-                const time_t v =3D CIRC_=
LIST_ITEM(p->seq_list, diff);
-                if (v =3D=3D 0)
-           =
     {
-                    return true;
-                }
-              =
  else
-                {
-                    /* raised from D_PID_DEBUG_L=
OW to reduce verbosity */
-                    packet_id_debug(D_PID_DEBUG_=
MEDIUM, p, pin, "PID_ERR replay", diff);
-                    return false;=

-                }
+                return true;
+            }
+         =
   else
+            {
+                /* raised from D_PID_DEBUG_LOW to r=
educe verbosity */
+                packet_id_debug(D_PID_DEBUG_MEDIUM, p, =
pin, "PID_ERR replay", diff);
+                return false;
             }=

         }
         else if (pin->time < p->time) /* if time goes back, re=
ject */
@@ -384,7 +377,7 @@
         return false;
     }
 
-    const pack=
et_id_type net_id =3D htonpid(p->id);
+    const packet_id_type net_id =3D =
htonpid((packet_id_type)p->id);
     const net_time_t net_time =3D htontime=
(p->time);
     if (prepend)
     {
@@ -636,7 +629,7 @@
                p->=
seq_backtrack, p->time_backtrack, p->max_backtrack_stat, (int)p->initialize=
d);
     if (sl !=3D NULL)
     {
-        buf_printf(&out, " sl=3D[%d,%d,%=
d,%d]", sl->x_head, sl->x_size, sl->x_cap, sl->x_sizeof);
+        buf_prin=
tf(&out, " sl=3D[%d,%d,%d,%zu]", sl->x_head, sl->x_size, sl->x_cap, sl->x_s=
izeof);
     }
 
 
@@ -651,7 +644,6 @@
 {
     uint64_t packet_id;
 
-
    =
 if (!buf_read(buf, &packet_id, sizeof(packet_id)))
     {
         return =
0;
@@ -659,16 +651,12 @@
 
     uint64_t id =3D ntohll(packet_id);
     /* =
top most 16 bits */
-    uint16_t epoch =3D id >> 48;
+    uint16_t epoch =
=3D (uint16_t)(id >> 48);
 
     pin->id =3D id & PACKET_ID_MASK;
     retu=
rn epoch;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC di=
agnostic pop
-#endif
-
 bool
 packet_id_write_epoch(struct packet_id_send *=
p, uint16_t epoch, struct buffer *buf)
 {
diff --git a/src/openvpn/packet_i=
d=2Eh b/src/openvpn/packet_id=2Eh
index ba59067=2E=2E48752d3 100644
--- a/s=
rc/openvpn/packet_id=2Eh
+++ b/src/openvpn/packet_id=2Eh
@@ -280,26 +280,20=
 @@
     return p->fd >=3D 0;
 }
 
-#if defined(__GNUC__) || defined(__clan=
g__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconver=
sion"
-#endif
-
-/* transfer packet_id -> packet_id_persist */
+/* transfer=
 packet_id -> packet_id_persist
+   Note: Only supported for non-epoch form=
at (i=2Ee=2E 32bit ID, not 64bit format),
+   must be enforced at the calle=
r=2E
+ */
 static inline void
 packet_id_persist_save_obj(struct packet_id_=
persist *p, const struct packet_id *pid)
 {
-    if (packet_id_persist_enab=
led(p) && pid->rec=2Etime)
+    if (packet_id_persist_enabled(p) && pid->re=
c=2Etime && pid->rec=2Eid <=3D PACKET_ID_MAX)
     {
         p->time =3D p=
id->rec=2Etime;
-        p->id =3D pid->rec=2Eid;
+        p->id =3D (packe=
t_id_type)pid->rec=2Eid;
     }
 }
 
-#if defined(__GNUC__) || defined(__cl=
ang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Reset the current sen=
d packet id to its initial state=2E
  * Use very carefully (e=2Eg=2E in the=
 standalone reset packet context) to

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Gerrit-Chan=
ge-Number: 1407
Gerrit-PatchSet: 9
Gerrit-Owner: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>

--iOaKasfpY6c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Frank Lichtenheld <stron=
g>uploaded patch set #9</strong> to this change=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">packet_id: Avoid conversion warnings<br><br>Most =
of these already have checks that the<br>values are as expected, so we can =
just add<br>the required casts=2E<br><br>Only the circ list x_sizeof is cha=
nged to<br>size_t since that is its purpose (and it is<br>not actually used=
 anyway)=2E<br><br>Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>=
M src/openvpn/circ_list=2Eh<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn=
/packet_id=2Eh<br>3 files changed, 29 insertions(+), 47 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/07/1407/9</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/circ_list=2Eh b/src/o=
penvpn/circ_list=2Eh</span><br><span>index c29b0bb8=2E=2E76484ca 100644</sp=
an><br><span>--- a/src/openvpn/circ_list=2Eh</span><br><span>+++ b/src/open=
vpn/circ_list=2Eh</span><br><span>@@ -33,7 +33,7 @@</span><br><span>       =
  int x_head;           \</span><br><span>         int x_size;           \<=
/span><br><span>         int x_cap;            \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int x_sizeof;         \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        size_t x_sizeof;      \</spa=
n><br><span>         type x_list[];        \</span><br><span>     }</span><=
br><span> </span><br><span>@@ -58,14 +58,14 @@</span><br><span>         (ob=
j)-&gt;x_size =3D 0;   \</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define CIRC_LIST_ALLOC(dest, l=
ist_type, size)                                 \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {                                          =
                                \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        const int so =3D sizeof(list_type) + sizeof((dest)-&gt;=
x_list[0]) * (size); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        (dest) =3D (list_type *)malloc(so);                               =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check=
_malloc_return(dest);                                             \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        memset((dest), 0, so)=
;                                                 \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        (dest)-&gt;x_cap =3D size;         =
                                         \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        (dest)-&gt;x_sizeof =3D so;                   =
                              \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CIRC_LIST_ALLOC(dest, list_type, size)                 =
                   \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {                                                                     =
        \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst size_t so =3D sizeof(list_type) + sizeof((dest)-&gt;x_list[0]) * (size)=
; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (dest) =
=3D (list_type *)malloc(so);                                         \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        check_malloc_ret=
urn(dest);                                                \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        memset((dest), 0, so);     =
                                               \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        (dest)-&gt;x_cap =3D size;            =
                                         \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        (dest)-&gt;x_sizeof =3D so;                 =
                                   \</span><br><span>     }</span><br><span=
> </span><br><span> #define CIRC_LIST_FREE(dest) free(dest)</span><br><span=
>diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><=
br><span>index 50d7c76=2E=2E9dd6ce3 100644</span><br><span>--- a/src/openvp=
n/packet_id=2Ec</span><br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><=
span>@@ -71,11 +71,6 @@</span><br><span> #endif</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br>=
<span> packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, in=
t time_backtrack,</span><br><span>                     const char *name, in=
t unit)</span><br><span>@@ -119,7 +114,7 @@</span><br><span> </span><br><sp=
an>     /* Reinitalise the source */</span><br><span>     CLEAR(*src);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_init_recv(sr=
c, dest-&gt;seq_backtrack, dest-&gt;time_backtrack, dest-&gt;name, dest-&gt=
;unit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_i=
d_init_recv(src, (int)dest-&gt;seq_backtrack, dest-&gt;time_backtrack, dest=
-&gt;name, dest-&gt;unit);</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span>@@ -170,7 +165,7 @@</span><br><span>         dif=
f =3D p-&gt;id - pin-&gt;id;</span><br><span>         if (diff &lt; CIRC_LI=
ST_SIZE(p-&gt;seq_list) &amp;&amp; local_now &gt; SEQ_EXPIRED)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     CIRC_LIST_ITEM(p-&gt;seq_list, diff) =3D local_now;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            CIRC_LIST_ITEM(p-&gt;seq_l=
ist, (int)diff) =3D local_now;</span><br><span>         }</span><br><span> =
    }</span><br><span>     else</span><br><span>@@ -261,18 +256,16 @@</span=
><br><span>                 return false;</span><br><span>             }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const time_t v =3D CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (v =3D=3D =
0)</span><br><span>             {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                const time_t v =3D CIRC_LIST_ITEM(p-&gt;seq_lis=
t, diff);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    if (v =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              return true;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                /* raised from D_PID_DEBUG_LOW to reduce verbosity */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    packet_=
id_debug(D_PID_DEBUG_MEDIUM, p, pin, &quot;PID_ERR replay&quot;, diff);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    retur=
n false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* ra=
ised from D_PID_DEBUG_LOW to reduce verbosity */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                packet_id_debug(D_PID_DEBUG_ME=
DIUM, p, pin, &quot;PID_ERR replay&quot;, diff);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                return false;</span><br><span>=
             }</span><br><span>         }</span><br><span>         else if =
(pin-&gt;time &lt; p-&gt;time) /* if time goes back, reject */</span><br><s=
pan>@@ -384,7 +377,7 @@</span><br><span>         return false;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const packet_id_type net_id =3D htonpid(p-&gt;id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type net_id =
=3D htonpid((packet_id_type)p-&gt;id);</span><br><span>     const net_time_=
t net_time =3D htontime(p-&gt;time);</span><br><span>     if (prepend)</spa=
n><br><span>     {</span><br><span>@@ -636,7 +629,7 @@</span><br><span>    =
            p-&gt;seq_backtrack, p-&gt;time_backtrack, p-&gt;max_backtrack_=
stat, (int)p-&gt;initialized);</span><br><span>     if (sl !=3D NULL)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    buf_printf(&amp;out, &quot; sl=3D[%d,%d,%d,%d]&quot;, sl-&gt;x_head, sl=
-&gt;x_size, sl-&gt;x_cap, sl-&gt;x_sizeof);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot; sl=3D[%d,%d,%d=
,%zu]&quot;, sl-&gt;x_head, sl-&gt;x_size, sl-&gt;x_cap, sl-&gt;x_sizeof);<=
/span><br><span>     }</span><br><span> </span><br><span> </span><br><span>=
@@ -651,7 +644,6 @@</span><br><span> {</span><br><span>     uint64_t packet=
_id;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     if (!buf_read(buf, &amp;packet_id, sizeof(packet_id)=
))</span><br><span>     {</span><br><span>         return 0;</span><br><spa=
n>@@ -659,16 +651,12 @@</span><br><span> </span><br><span>     uint64_t id =
=3D ntohll(packet_id);</span><br><span>     /* top most 16 bits */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    uint16_t epoch =3D id &gt;=
&gt; 48;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_=
t epoch =3D (uint16_t)(id &gt;&gt; 48);</span><br><span> </span><br><span> =
    pin-&gt;id =3D id &amp; PACKET_ID_MASK;</span><br><span>     return epo=
ch;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> pac=
ket_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buffer =
*buf)</span><br><span> {</span><br><span>diff --git a/src/openvpn/packet_id=
=2Eh b/src/openvpn/packet_id=2Eh</span><br><span>index ba59067=2E=2E48752d3=
 100644</span><br><span>--- a/src/openvpn/packet_id=2Eh</span><br><span>+++=
 b/src/openvpn/packet_id=2Eh</span><br><span>@@ -280,26 +280,20 @@</span><b=
r><span>     return p-&gt;fd &gt;=3D 0;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/* transfer packet_id -&gt; packet_id_persist */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* transfer packet_id -&gt; packet_id_pe=
rsist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Note: Only =
supported for non-epoch format (i=2Ee=2E 32bit ID, not 64bit format),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+   must be enforced at th=
e caller=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span> static inline void</span><br><span> packet_id_persist_save_obj=
(struct packet_id_persist *p, const struct packet_id *pid)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_p=
ersist_enabled(p) &amp;&amp; pid-&gt;rec=2Etime)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (packet_id_persist_enabled(p) &amp;&amp=
; pid-&gt;rec=2Etime &amp;&amp; pid-&gt;rec=2Eid &lt;=3D PACKET_ID_MAX)</sp=
an><br><span>     {</span><br><span>         p-&gt;time =3D pid-&gt;rec=2Et=
ime;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;id =
=3D pid-&gt;rec=2Eid;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        p-&gt;id =3D (packet_id_type)pid-&gt;rec=2Eid;</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * R=
eset the current send packet id to its initial state=2E</span><br><span>  *=
 Use very carefully (e=2Eg=2E in the standalone reset packet context) to</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1407?usp=3Demail">change 1407</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1407?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5=
eb901ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1407 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--iOaKasfpY6c=--


--===============0246332340638794594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0246332340638794594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0246332340638794594==--

