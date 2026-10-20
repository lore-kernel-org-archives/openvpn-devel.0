Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C054606A320
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AUzMa+gG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kxSONxU+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kxT62LB2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KH96ka/U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=voJUAqiIFWG14VBKHFCoQw6mNct8//pKcy/13kDPUwo=; b=AUzMa+gGeUTFY1nfKQ/vl2MAFY
	idA8N98uwrEFUZjOi1jrUSSlcL492ymyxn4fli+aIhRzIyrMrRrWOTTx0VyJ/q3C3/+5JGQEJsdli
	VlKS4plaSWmi00ZlbjJ/Z0tMRu4nl/wkoOkPAClCu8dNNjOO8V7GNDi5hXQEcoOf4K+8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ8zS-0003bZ-US;
	Tue, 20 Oct 2026 12:30:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ8zR-0003bS-EJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Vc5eQ7xwWxNUWKmbJtoJS07Hb8sYr75CPt/ednDGPvU=; b=kxSONxU+FmGL8XoEirwBOdq56y
 Fu2YM2V9f4xOx+RqGqpfd/HCgqFsgjebcbzx1UOiBz/A1egYSIn31F8/anDh35EG+Lyyk9kp6w8Eb
 kWnUj6D8M8QF8G77Hn5xL+WVXy9p604JKQb0Io/CQ/RdxmguKr5/9h5y/ejIthKbaXdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vc5eQ7xwWxNUWKmbJtoJS07Hb8sYr75CPt/ednDGPvU=; b=k
 xT62LB2cEGCJ/6EDT08obl4w5P7M5boAxWD4mInGOSvLtAMQcBtMkZbfUcGj3PrEnZx29DzHPgmUU
 ThlU8NZzlwKFJO0p3/I3M4T0hi++Ah1Rbp+UeUuwRS1c1O7OR2s+OWgyqtthv9rDhqIxcPf1O+DRz
 ZgZcESQQPVcpv06w=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ8zL-0003aO-KL for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:30:46 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1856184f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792499437; x=1793104237; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vc5eQ7xwWxNUWKmbJtoJS07Hb8sYr75CPt/ednDGPvU=;
 b=KH96ka/U+wn0I8P9SFDmy7iJRfhTiJivcxtmjsk/HWba6URSVK3RROMSQ7KjyOtwW7
 F/vx8/l21JCgVAqi0FwbgWC8RmBcbcbqBmFzM/pRWkPzLqL/P9ITLJNRDGPUgI1CpYn6
 U+OcCt2Qxa3KUA4T66Z30Gc/663EWhT+vNROhAR8Q3I4pmu3bswU+RYZH70yEp68kJ0g
 gFdpR0X9vXrFv4zn60m2U4hAcmpwLBrOZgQlJUu8qix2iLlWdLRw2TShof3jVcaaA0w/
 xmmu0oDx0BZJYyHGPVt4zWQHTtPqPDBkvK8MGk1m2lFhLBmWHp4N9+IsFFjJ0CR3tCBO
 VztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499437; x=1793104237;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vc5eQ7xwWxNUWKmbJtoJS07Hb8sYr75CPt/ednDGPvU=;
 b=DAf0+oVdlfkeG4i0g9G4ZbzMkodAMs5JF8WdT6ZXl3Sfu6wMGlm8GmpvmKoo688DnM
 op5hKiIMcNHLpjhn5dCRTzjoTh/1huB7Bdt5Bfz/fjZft6Vg6UKm55maP9DEsO5WB+L+
 4mT3lMRNh0Kqt4oarz4+4Fvq/bozfk0hKE2S6nNQ9pzeCrQU1ujpJMQuqfGdQBLLpqFh
 ttSGkrTTJP+77zhre2ZwKvPViyXS49+RNCH/wNeoF1jj3o2JzHkbKM1Z95Usn3sXCn5Z
 Y5xT3GtHpm+MlGdI0VnwsaRd7TMX6LwgSvXbBrtit5o5CRYCW4rNEzEmWDtDafYeWt3k
 ZJFw==
X-Gm-Message-State: AFq9FYI6mhaXV/hFY2EoCKvQCt9a1CVyJZ19ajds598ZKhO7ze7dVCW7
 bjkZ6/nMxAWTpxYwglRkUx5KF+ilkbRL7PZfRe1eAHnbE+1gZT4FtevMWrdZ1IXTIVI/tvBvBe4
 9KSVxewTBMDI90x7gNPJKOIxZT+dfxiZnVasHAGI9nCvtLIWHfLRviVRGX5U4sad3HFhX
X-Gm-Gg: AYBFou3sTttUUdQFNHlWnJPFf7OUEWY2+72iRYBhegdnRWtnmhhdMHWQqVnkxWLv0sS
 mtP3AzHCTu5ge6vTTAD1EHsQvm+NXR2eUEl2otJlTsVhAy5fsCfJ1iZVf5r62vSg8HuA0N9GqcD
 VN6H6+kpLsMb2xVQWhSzfvFRDfEqFPdG/rM30s3CxBoHm/z0T6JeZChwJ88CqsGUBf1yC8Fk2a8
 +QLO98cMzCsGLvIYP+VReDUKUVR4YZubKCVcBXzVwNvUmbCa4GK8U91U1RlLqMlakjaMy2WSFhD
 bflGIFP4aierBTqPDpkrt5imyx9NWqeJJcMtkXwD9JgUQsq8e1jtsZ4Gq2nsHMHFn6U7R+HeJSD
 T0zelEiQqN6/CNwM3CpRhWMVzB1k/+XrYstyK0c1MGicldhZoKRWvOjbF/2il1k2aTUxrA2FQyB
 UZ6+wKo+juQXU22JZiNgsJxDizm6j3qzhq4cIJtMxnxBVGUQ0iV16GUbPGRYBaVgDpDh+FdOKLC
 +aahgDD6TJ7HcSJWTAJ7U4qehyEqDxGu4rkpHPyXMUBDaiUXw0YNz1nlMNPY6Sx8ovjwrsf8bjf
 htDTgxn2J8z6xjfi16pBpKItRmAp6uoR2sPpd75dB6O6hZ7EKDuQsqjdPSRlL0xlqNC+KVA=
X-Received: by 2002:a5d:584f:0:b0:48a:fba3:d5b1 with SMTP id
 ffacd0b85a97d-48e07fbf20emr19929985f8f.55.1792499435902; 
 Tue, 20 Oct 2026 05:30:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8214e1sm5771769f8f.37.2026.10.20.05.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:30:34 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 12:30:31 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 2f1f9d72cbf41127ee5e2a7c75971b9a4ee2d670
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73471764ffa756debf2153cb5bcc4c5d8ddbe1d8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ8zL-0003aO-KL
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3518197413729054015=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3518197413729054015==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NSqljYHuoq8="; charset=UTF-8

--NSqljYHuoq8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#10) to the change originally cr=
eated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1407?usp=3Demail )

The following approvals got outdated and were removed:
=
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: packet_id: Avoid co=
nversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

packet_id: Avoid conversion warnings

Most of these already have check=
s that the
values are as expected, so we can just add
the required casts=2E=


Only the circ list x_sizeof is changed to
size_t since that is its purpos=
e (and it is
not actually used anyway)=2E

Change-Id: Ib0584e8728701cca10ac=
5675c9cb0e6f5eb901ac
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407
Message-Id: <20260818142226=2E27172=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg38486=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/circ_list=2Eh
M src/openvpn/pac=
ket_id=2Ec
M src/openvpn/packet_id=2Eh
3 files changed, 29 insertions(+), 4=
7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/07/1407/10

diff --git a/src/openvpn/circ_list=2Eh b/src/openvpn/c=
irc_list=2Eh
index c29b0bb8=2E=2E76484ca 100644
--- a/src/openvpn/circ_list=
=2Eh
+++ b/src/openvpn/circ_list=2Eh
@@ -33,7 +33,7 @@
         int x_head;=
           \
         int x_size;           \
         int x_cap;          =
  \
-        int x_sizeof;         \
+        size_t x_sizeof;      \
     =
    type x_list[];        \
     }
 
@@ -58,14 +58,14 @@
         (obj)->x_=
size =3D 0;   \
     }
 
-#define CIRC_LIST_ALLOC(dest, list_type, size)   =
                              \
-    {                                     =
                                     \
-        const int so =3D sizeof(lis=
t_type) + sizeof((dest)->x_list[0]) * (size); \
-        (dest) =3D (list_t=
ype *)malloc(so);                                      \
-        check_mal=
loc_return(dest);                                             \
-        me=
mset((dest), 0, so);                                                 \
-   =
     (dest)->x_cap =3D size;                                               =
   \
-        (dest)->x_sizeof =3D so;                                     =
            \
+#define CIRC_LIST_ALLOC(dest, list_type, size)              =
                      \
+    {                                             =
                                \
+        const size_t so =3D sizeof(list_=
type) + sizeof((dest)->x_list[0]) * (size); \
+        (dest) =3D (list_typ=
e *)malloc(so);                                         \
+        check_ma=
lloc_return(dest);                                                \
+      =
  memset((dest), 0, so);                                                   =
 \
+        (dest)->x_cap =3D size;                                        =
             \
+        (dest)->x_sizeof =3D so;                           =
                         \
     }
 
 #define CIRC_LIST_FREE(dest) free(dest=
)
diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index =
50d7c76=2E=2E9dd6ce3 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openv=
pn/packet_id=2Ec
@@ -71,11 +71,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || =
defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ign=
ored "-Wconversion"
-#endif
-
 static void
 packet_id_init_recv(struct pack=
et_id_rec *rec, int seq_backtrack, int time_backtrack,
                    =
 const char *name, int unit)
@@ -119,7 +114,7 @@
 
     /* Reinitalise the =
source */
     CLEAR(*src);
-    packet_id_init_recv(src, dest->seq_backtra=
ck, dest->time_backtrack, dest->name, dest->unit);
+    packet_id_init_recv=
(src, (int)dest->seq_backtrack, dest->time_backtrack, dest->name, dest->uni=
t);
 }
 
 void
@@ -170,7 +165,7 @@
         diff =3D p->id - pin->id;
     =
    if (diff < CIRC_LIST_SIZE(p->seq_list) && local_now > SEQ_EXPIRED)
    =
     {
-            CIRC_LIST_ITEM(p->seq_list, diff) =3D local_now;
+     =
       CIRC_LIST_ITEM(p->seq_list, (int)diff) =3D local_now;
         }
   =
  }
     else
@@ -261,18 +256,16 @@
                 return false;
        =
     }
 
+            const time_t v =3D CIRC_LIST_ITEM(p->seq_list, (int)d=
iff);
+            if (v =3D=3D 0)
             {
-                const ti=
me_t v =3D CIRC_LIST_ITEM(p->seq_list, diff);
-                if (v =3D=3D=
 0)
-                {
-                    return true;
-                }=

-                else
-                {
-                    /* raised fr=
om D_PID_DEBUG_LOW to reduce verbosity */
-                    packet_id_de=
bug(D_PID_DEBUG_MEDIUM, p, pin, "PID_ERR replay", diff);
-                 =
   return false;
-                }
+                return true;
+        =
    }
+            else
+            {
+                /* raised from D_PI=
D_DEBUG_LOW to reduce verbosity */
+                packet_id_debug(D_PID_D=
EBUG_MEDIUM, p, pin, "PID_ERR replay", diff);
+                return false=
;
             }
         }
         else if (pin->time < p->time) /* if ti=
me goes back, reject */
@@ -384,7 +377,7 @@
         return false;
     }
 =

-    const packet_id_type net_id =3D htonpid(p->id);
+    const packet_id_=
type net_id =3D htonpid((packet_id_type)p->id);
     const net_time_t net_t=
ime =3D htontime(p->time);
     if (prepend)
     {
@@ -636,7 +629,7 @@
   =
             p->seq_backtrack, p->time_backtrack, p->max_backtrack_stat, (i=
nt)p->initialized);
     if (sl !=3D NULL)
     {
-        buf_printf(&out,=
 " sl=3D[%d,%d,%d,%d]", sl->x_head, sl->x_size, sl->x_cap, sl->x_sizeof);
+=
        buf_printf(&out, " sl=3D[%d,%d,%d,%zu]", sl->x_head, sl->x_size, sl=
->x_cap, sl->x_sizeof);
     }
 
 
@@ -651,7 +644,6 @@
 {
     uint64_t pac=
ket_id;
 
-
     if (!buf_read(buf, &packet_id, sizeof(packet_id)))
     {
=
         return 0;
@@ -659,16 +651,12 @@
 
     uint64_t id =3D ntohll(pack=
et_id);
     /* top most 16 bits */
-    uint16_t epoch =3D id >> 48;
+    =
uint16_t epoch =3D (uint16_t)(id >> 48);
 
     pin->id =3D id & PACKET_ID_=
MASK;
     return epoch;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
=
-#pragma GCC diagnostic pop
-#endif
-
 bool
 packet_id_write_epoch(struct p=
acket_id_send *p, uint16_t epoch, struct buffer *buf)
 {
diff --git a/src/o=
penvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh
index ba59067=2E=2E48752d3=
 100644
--- a/src/openvpn/packet_id=2Eh
+++ b/src/openvpn/packet_id=2Eh
@@ =
-280,26 +280,20 @@
     return p->fd >=3D 0;
 }
 
-#if defined(__GNUC__) ||=
 defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ig=
nored "-Wconversion"
-#endif
-
-/* transfer packet_id -> packet_id_persist =
*/
+/* transfer packet_id -> packet_id_persist
+   Note: Only supported for=
 non-epoch format (i=2Ee=2E 32bit ID, not 64bit format),
+   must be enforc=
ed at the caller=2E
+ */
 static inline void
 packet_id_persist_save_obj(st=
ruct packet_id_persist *p, const struct packet_id *pid)
 {
-    if (packet_=
id_persist_enabled(p) && pid->rec=2Etime)
+    if (packet_id_persist_enable=
d(p) && pid->rec=2Etime && pid->rec=2Eid <=3D PACKET_ID_MAX)
     {
       =
  p->time =3D pid->rec=2Etime;
-        p->id =3D pid->rec=2Eid;
+        p=
->id =3D (packet_id_type)pid->rec=2Eid;
     }
 }
 
-#if defined(__GNUC__) =
|| defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Reset =
the current send packet id to its initial state=2E
  * Use very carefully (=
e=2Eg=2E in the standalone reset packet context) to

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb90=
1ac
Gerrit-Change-Number: 1407
Gerrit-PatchSet: 10
Gerrit-Owner: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--NSqljYHuoq8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #10</strong> to the change originally created by Fra=
nk Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1407?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">packet_id: Avoid conversion warnings<br><br>Most of these already have =
checks that the<br>values are as expected, so we can just add<br>the requir=
ed casts=2E<br><br>Only the circ list x_sizeof is changed to<br>size_t sinc=
e that is its purpose (and it is<br>not actually used anyway)=2E<br><br>Cha=
nge-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1407<br>Message-Id: &lt;20260818142226=2E27172-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38486=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/circ_list=2Eh<br>M src/openvp=
n/packet_id=2Ec<br>M src/openvpn/packet_id=2Eh<br>3 files changed, 29 inser=
tions(+), 47 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/1407/10</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/circ_list=2Eh b/src/openvpn/circ_list=2Eh</span><br><span>inde=
x c29b0bb8=2E=2E76484ca 100644</span><br><span>--- a/src/openvpn/circ_list=
=2Eh</span><br><span>+++ b/src/openvpn/circ_list=2Eh</span><br><span>@@ -33=
,7 +33,7 @@</span><br><span>         int x_head;           \</span><br><spa=
n>         int x_size;           \</span><br><span>         int x_cap;     =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int x=
_sizeof;         \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       size_t x_sizeof;      \</span><br><span>         type x_list[];     =
   \</span><br><span>     }</span><br><span> </span><br><span>@@ -58,14 +58=
,14 @@</span><br><span>         (obj)-&gt;x_size =3D 0;   \</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define CIRC_LIST_ALLOC(dest, list_type, size)                         =
        \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {       =
                                                                   \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        const int so =3D siz=
eof(list_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        (dest) =3D (list_type *)malloc(=
so);                                      \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        check_malloc_return(dest);                   =
                          \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        memset((dest), 0, so);                                       =
          \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (d=
est)-&gt;x_cap =3D size;                                                  \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (dest)-&gt;x_=
sizeof =3D so;                                                 \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define CIRC_LIST_ALLOC(dest, =
list_type, size)                                    \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {                                    =
                                         \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const size_t so =3D sizeof(list_type) + size=
of((dest)-&gt;x_list[0]) * (size); \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        (dest) =3D (list_type *)malloc(so);               =
                          \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        check_malloc_return(dest);                                 =
               \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     memset((dest), 0, so);                                                =
    \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (dest)=
-&gt;x_cap =3D size;                                                     \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (dest)-&gt;x=
_sizeof =3D so;                                                    \</span>=
<br><span>     }</span><br><span> </span><br><span> #define CIRC_LIST_FREE(=
dest) free(dest)</span><br><span>diff --git a/src/openvpn/packet_id=2Ec b/s=
rc/openvpn/packet_id=2Ec</span><br><span>index 50d7c76=2E=2E9dd6ce3 100644<=
/span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/src/o=
penvpn/packet_id=2Ec</span><br><span>@@ -71,11 +71,6 @@</span><br><span> #e=
ndif</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static void</span><br><span> packet_id_init_recv(struct packet_id=
_rec *rec, int seq_backtrack, int time_backtrack,</span><br><span>         =
            const char *name, int unit)</span><br><span>@@ -119,7 +114,7 @@=
</span><br><span> </span><br><span>     /* Reinitalise the source */</span>=
<br><span>     CLEAR(*src);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    packet_id_init_recv(src, dest-&gt;seq_backtrack, dest-&gt;time_ba=
cktrack, dest-&gt;name, dest-&gt;unit);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    packet_id_init_recv(src, (int)dest-&gt;seq_backtrac=
k, dest-&gt;time_backtrack, dest-&gt;name, dest-&gt;unit);</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span>@@ -170,7 +165,7=
 @@</span><br><span>         diff =3D p-&gt;id - pin-&gt;id;</span><br><spa=
n>         if (diff &lt; CIRC_LIST_SIZE(p-&gt;seq_list) &amp;&amp; local_no=
w &gt; SEQ_EXPIRED)</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            CIRC_LIST_ITEM(p-&gt;seq_list, diff) =
=3D local_now;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff) =3D local_now;</span><br><=
span>         }</span><br><span>     }</span><br><span>     else</span><br>=
<span>@@ -261,18 +256,16 @@</span><br><span>                 return false;<=
/span><br><span>             }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            const time_t v =3D CIRC_LIST_ITEM(=
p-&gt;seq_list, (int)diff);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (v =3D=3D 0)</span><br><span>             {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                const time_t v=
 =3D CIRC_LIST_ITEM(p-&gt;seq_list, diff);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (v =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    return true;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    /* raised from D_PID_DE=
BUG_LOW to reduce verbosity */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, &q=
uot;PID_ERR replay&quot;, diff);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    return false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                return true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                /* raised from D_PID_DEBUG_LOW to reduce ver=
bosity */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, &quot;PID_ERR replay&quot=
;, diff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      return false;</span><br><span>             }</span><br><span>        =
 }</span><br><span>         else if (pin-&gt;time &lt; p-&gt;time) /* if ti=
me goes back, reject */</span><br><span>@@ -384,7 +377,7 @@</span><br><span=
>         return false;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const packet_id_type net_id =
=3D htonpid(p-&gt;id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const packet_id_type net_id =3D htonpid((packet_id_type)p-&gt;id);</=
span><br><span>     const net_time_t net_time =3D htontime(p-&gt;time);</sp=
an><br><span>     if (prepend)</span><br><span>     {</span><br><span>@@ -6=
36,7 +629,7 @@</span><br><span>                p-&gt;seq_backtrack, p-&gt;t=
ime_backtrack, p-&gt;max_backtrack_stat, (int)p-&gt;initialized);</span><br=
><span>     if (sl !=3D NULL)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot; sl=3D[%=
d,%d,%d,%d]&quot;, sl-&gt;x_head, sl-&gt;x_size, sl-&gt;x_cap, sl-&gt;x_siz=
eof);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_pr=
intf(&amp;out, &quot; sl=3D[%d,%d,%d,%zu]&quot;, sl-&gt;x_head, sl-&gt;x_si=
ze, sl-&gt;x_cap, sl-&gt;x_sizeof);</span><br><span>     }</span><br><span>=
 </span><br><span> </span><br><span>@@ -651,7 +644,6 @@</span><br><span> {<=
/span><br><span>     uint64_t packet_id;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!buf_read(bu=
f, &amp;packet_id, sizeof(packet_id)))</span><br><span>     {</span><br><sp=
an>         return 0;</span><br><span>@@ -659,16 +651,12 @@</span><br><span=
> </span><br><span>     uint64_t id =3D ntohll(packet_id);</span><br><span>=
     /* top most 16 bits */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    uint16_t epoch =3D id &gt;&gt; 48;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint16_t epoch =3D (uint16_t)(id &gt;&gt; 48);=
</span><br><span> </span><br><span>     pin-&gt;id =3D id &amp; PACKET_ID_M=
ASK;</span><br><span>     return epoch;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> bool</span><br><span> packet_id_write_epoch(struct packet_id_send=
 *p, uint16_t epoch, struct buffer *buf)</span><br><span> {</span><br><span=
>diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh</span><=
br><span>index ba59067=2E=2E48752d3 100644</span><br><span>--- a/src/openvp=
n/packet_id=2Eh</span><br><span>+++ b/src/openvpn/packet_id=2Eh</span><br><=
span>@@ -280,26 +280,20 @@</span><br><span>     return p-&gt;fd &gt;=3D 0;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/* transfer packet_id -&gt; packet=
_id_persist */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* tr=
ansfer packet_id -&gt; packet_id_persist</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+   Note: Only supported for non-epoch format (i=2Ee=2E=
 32bit ID, not 64bit format),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   must be enforced at the caller=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><b=
r><span> packet_id_persist_save_obj(struct packet_id_persist *p, const stru=
ct packet_id *pid)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (packet_id_persist_enabled(p) &amp;&amp; pid-&gt;rec=
=2Etime)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pac=
ket_id_persist_enabled(p) &amp;&amp; pid-&gt;rec=2Etime &amp;&amp; pid-&gt;=
rec=2Eid &lt;=3D PACKET_ID_MAX)</span><br><span>     {</span><br><span>    =
     p-&gt;time =3D pid-&gt;rec=2Etime;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        p-&gt;id =3D pid-&gt;rec=2Eid;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        p-&gt;id =3D (packet_id_type)p=
id-&gt;rec=2Eid;</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /**</span><br><span>  * Reset the current send packet id to its i=
nitial state=2E</span><br><span>  * Use very carefully (e=2Eg=2E in the sta=
ndalone reset packet context) to</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">change 140=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1407 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--NSqljYHuoq8=--


--===============3518197413729054015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3518197413729054015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3518197413729054015==--

