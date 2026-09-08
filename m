Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A781C79F99
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=OpVlSVOmGGnCCTqGLkh/Dm7Mmihi8yP5DyMu4mZFcK8=; b=dziVJqn8bi41Sv
	2P9uIXEcg3/B/ThRPdHWykJFz4UgSrqS4/EPLhpiXq7KTKMyXwEhrVhtSew0w8zipr2RiLabYlKU6
	QJAt8PEsE6jP4XX05dt69WjcynpdgOVAkNtUlJfIvyz9jVtLbBGhtU5ita2s4nrOfIp1qNMcu64QR
	2hg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3yn2-0003Vl-IZ;
	Tue, 08 Sep 2026 16:35:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3yn0-0003Vd-N8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EsgidL6z5PkGPih93h1D8pMaiJLKgwryEry6oC2s4lM=; b=Wh2FYvqRZNgKyLCAIDQwdJp9m9
 9UcRQAIOfqCtwAx5t642uhInxJbqtCgzmlZAlT0L39GpjWamHtBxbvGm5NOYh/pCSj7aIzXT1L9wu
 /FnqsqHy+atutYNawQbfEay9xayrelXv2qDsz2T27WiLsd3mGOZFU80StYjgxnlO5iL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EsgidL6z5PkGPih93h1D8pMaiJLKgwryEry6oC2s4lM=; b=c
 gCxaF4LrOWkqyLvjQc1UuTzM+yp7VbBDSd0YGWXkrr9/Pzojzotj3/YeE7E9Ah5ZI+lPRVN3C0Osa
 O6wYSkiCyUkMQAcJGOeWJhibY55xmn2/MrPOfNUsaOwweffsY53ZoAJl2a6FuZy09g4lS0Bdh2XNz
 0Ab7iUhd5o1tllWU=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ymy-0008WK-RW for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:35:18 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so3209696f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788885310; x=1789490110; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EsgidL6z5PkGPih93h1D8pMaiJLKgwryEry6oC2s4lM=;
 b=aeom1Ily7nHCtY0Z58XrmkSvZi7gDcywxFVMknecBwQfdy204uCZ/LMhkBRXFICEPv
 sRus500tT4WMpxNyzk51nrvg+SNNMriWeI43k9W9aPzzaFgbUYUXSnCGSPCGtKnpYI7s
 IDkfiBEkCDSfsnFUYDoGYD1pS6RKAMyeKuUYd0TKSGFYPR+7pf56GRQDHZY6RoGspQwp
 89TD3ThB1tFKW4TvKGGW44p6dLDy+H5PPcXLtJWkgqdR47SPsYzDT8jGuayiQ9eZzarh
 1ig5g5BRUcmLAlBKoUkWBOmWsKPM2AmUbL4gmlGt29TuiCV0CelgxSLrsFPjnWP/Y+Or
 Elww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885310; x=1789490110;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EsgidL6z5PkGPih93h1D8pMaiJLKgwryEry6oC2s4lM=;
 b=NC7RrxyGqSVRRakMMaZCSfyt5aNeFqvoVJbTgYyEwaHo33w+BhffDr/8hzJeGnex64
 FfDoWLiYYra/IM4eEGx2evmaJQeYvcl1KNFsC6cRTWWFr9M7gK0Zq02nkAnLjcmdZCjC
 hdqMexEWqnQ/AhkQv65DLY3Q1BPb5eAlPsu/rTK8PsFXLhnB2LYtVcXn28e06kCtrfAf
 QrpucbHUMWxj6nQZOUjqZ5oj6BsB+vl30iYOjjS6q88xJ9g5stmmhdYEJAOv9AbEtC6i
 Nw7vtQxOEVHQV16J/QsQYbUh9/eEh5jYOdMTyhYJiFd5+G5vQFYCJeFL532bJkDY1tMC
 gNcA==
X-Gm-Message-State: AFuF++nWzuwrTstTsBDM7o9vEjnxoULfy2EkI9ugTvUc2tMgPexWbPSi
 GH3xfyODSIq6cRgTAeLLc67ywld3P0mfMGeYV0RkuADYBHgpT0kdQCCZ4JjNutE2JPXD9vjVJK8
 Wd0+ICGvtFoKQoJiEMYw0ha0zgscDwsqD8P0x7/XNJt2gJonBQGccWOZt0TubsCNxpmIFndkEOH
 T6ViE3+Q==
X-Gm-Gg: AYBFou3xX+yQmG/4UoEggoWTK9fZarQ/2cwfKe7QCRoF9Np9jml7Dm2qwymmVgmMaXI
 3uZIYB9eKpbVwItQZmgXsZkSoXt98yB5JWc0FgAjEc2F0zs4HXZlydMQj5e1/SnAEED/HDQ8/zs
 OBUr2gZWf61kd8O+boYqP2G/DJy7BPnYbVnElmqBpwa+kowT8YtNpETRVVYJR/ZUUgdCon40y0K
 mkvuiGabekYcs34NcciIMnUhqnOzqt2a7mCEtmS1TiphRpQHcJ47nTpMnGbvVQ9DDJdvyV9vbg/
 YEhLzrIN7KSgkwJhjXXN3wI2JT6PtrkHp1PTgRTlj9wG2CpnVPifhKTluOouAxA6R/d/Qo0jMly
 keUyCDHIpwGrSfYjZiQ308NEx3xRuaWvTlyo14OJHKP4CwhTtIUBEwh7zcX5HlHhoHULBOapo+0
 BqM3VZd2qgx7hn94FDmeUjagqs14z/gEifbamWul1KqhieOYs61VzvWgc9NFjLZxrh1e+m2fieb
 Fq3Q0kIJh9TBmYiAE/WMIY4X98dfpezrZvp6MYITSDRMpdT+QOL6UM2uUviNDaeKIh2lNF/DN4i
 3kBHGtnFVk1skmZ5+HYuAswLH3aI2BXzf92fPZabmMp6Z4eBrKM=
X-Received: by 2002:a05:6000:388:b0:485:8c75:48fb with SMTP id
 ffacd0b85a97d-4858c75598cmr24744969f8f.50.1788885309982; 
 Tue, 08 Sep 2026 09:35:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be01bsm36390719f8f.31.2026.09.08.09.35.09
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:35:09 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 16:35:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
X-Gerrit-Change-Number: 1909
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1909?usp=email>
X-Gerrit-Commit: 8aeaf0a6f684d2d46c43a9d8017289a5978d966f
References: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MzA3MDAwLkk5NDQ0Nzg3NjdiNTJhMWI5YmY2YTY1MzczY2UwNTQ0YzY5Y2IxMDEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <15746db12f435fcec29989afc3144d1e799c689b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ymy-0008WK-RW
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Ignore acks for
 packets that cannot be outstanding
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1965063548256212807=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1965063548256212807==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vmD4c1s0Uns="; charset=UTF-8

--vmD4c1s0Uns=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

MaxF has uploa=
ded this change for review=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
909?usp=3Demail )


Change subject: Ignore acks for packets that cannot be =
outstanding
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

I=
gnore acks for packets that cannot be outstanding

This ignores acks for pi=
ds outside the send window, i=2Ee=2E for packets
that have either not been =
sent out yet or already left the window=2E
Nothing outside that window can =
be outstanding, so such acks can only
be used to manipulate the state of th=
e send buffer=2E

Comparing the pid of an outstanding packet against the ac=
ked pid needs
to be wraparound aware as well=2E Otherwise a peer can ack a =
pid from the
lower half of the id space, which passes the window check abov=
e, and
still increment n_acks on every outstanding packet, forcing an early=

retransmit after N_ACK_RETRANSMIT such acks=2E

Github: OpenVPN/openvpn-pr=
ivate-issues#161
Reported-By: Mark Bregman (Fox-IT) <mark=2Ebregman@fox-it=
=2Ecom>
CVE: 2026-84732
Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb101=
2
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Signed-off-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Acked-by: MaxF <max@max-fillinger=2Enet>
(ch=
erry picked from commit d988ef4508e63b28c8e3efcb9f62eb8c836907fe)
---
M src=
/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M tests/unit_tests/openvpn=
/test_packet_id=2Ec
3 files changed, 100 insertions(+), 9 deletions(-)



 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/1909/1=


diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index ba=
be4c8=2E=2Ed0ae3cc 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/=
reliable=2Ec
@@ -404,15 +404,36 @@
     return true;
 }
 
+int
+validate_pa=
cket_id_window(struct reliable *rel, packet_id_type pid)
+{
+    return rel=
iable_pid_min(pid, rel->packet_id)
+           && reliable_pid_min(subtract=
_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+}
+
 /* del acknowledged it=
ems from send buf */
 void
 reliable_send_purge(struct reliable *rel, const=
 struct reliable_ack *ack)
 {
-    int i, j;
-    for (i =3D 0; i < ack->le=
n; ++i)
+    unsigned int out_of_window =3D 0;
+    packet_id_type first_ou=
t_of_window =3D 0;
+
+    for (int i =3D 0; i < ack->len; ++i)
     {
     =
    packet_id_type pid =3D ack->packet_id[i];
-        for (j =3D 0; j < re=
l->size; ++j)
+
+
+        if (!validate_packet_id_window(rel, pid))
+     =
   {
+            if (out_of_window =3D=3D 0)
+            {
+             =
   first_out_of_window =3D pid;
+            }
+            out_of_window++=
;
+            continue;
+        }
+
+        for (int j =3D 0; j < rel->s=
ize; ++j)
         {
             struct reliable_entry *e =3D &rel->array[=
j];
             if (e->active && e->packet_id =3D=3D pid)
@@ -432,16 +453,=
27 @@
 #endif
                 e->active =3D false;
             }
-       =
     else if (e->active && e->packet_id < pid)
+
+            if (e->active=
 && reliable_pid_min(e->packet_id, pid))
             {
                 /*=
 We have received an ACK for a packet with a higher PID=2E Either
         =
         * we have received ACKs out of or order or the packet has been
   =
               * lost=2E We count the number of ACKs to determine if we sho=
uld
-                 * resend it early=2E */
+                 * resend it=
 early=2E The comparison needs to be wraparound aware,
+                 * =
otherwise a peer can inflate n_acks with an ACK for a pid from
+           =
      * the lower half of the id space and force a retransmit=2E */
       =
          e->n_acks++;
             }
         }
     }
+
+    if (out_of_w=
indow > 0)
+    {
+        (void)first_out_of_window; /* dmsg might not gen=
erate code */
+        dmsg(D_REL_LOW, "ACK contained %u ids outside the se=
nd window, "
+             "first was " packet_id_format,
+             out=
_of_window, (packet_id_print_type)first_out_of_window);
+    }
 }
 
 #ifdef=
 ENABLE_DEBUG
diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=
=2Eh
index 5877f20=2E=2Ecdd33c8 100644
--- a/src/openvpn/reliable=2Eh
+++ b=
/src/openvpn/reliable=2Eh
@@ -106,9 +106,9 @@
 {
     int size;
     interv=
al_t initial_timeout;
-    packet_id_type packet_id;
-    int offset; /**< =
Offset of the bufs in the reliable_entry array */
-    bool hold; /* don't =
xmit until reliable_schedule_now is called */
+    packet_id_type packet_id=
; /**< Packet ID for the next packet to be sent out=2E */
+    int offset; =
              /**< Offset of the bufs in the reliable_entry array */
+    b=
ool hold;                /* don't xmit until reliable_schedule_now is calle=
d */
     struct reliable_entry array[RELIABLE_CAPACITY];
 };
 
@@ -193,6 +=
193,17 @@
 }
 
 /**
+ * check that pid is inside the window of possible out=
standing packets
+ * of size RELIABLE_CAPACITY, ie inside the range
+ * [re=
l->packet_id - RELIABLE_CAPACITY, rel->packet_id)=2E
+ *
+ * rel->packet is=
 the *next* packet id to be sent out, so it is not
+ * included in the vali=
d range=2E
+ */
+int
+validate_packet_id_window(struct reliable *rel, packe=
t_id_type pid);
+
+/**
  * Returns the number of packets that need to be ac=
ked=2E
  *
  * @param ack The acknowledgment structure to check=2E
diff --g=
it a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn=
/test_packet_id=2Ec
index ff3f788=2E=2Ea27bd6d 100644
--- a/tests/unit_test=
s/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_packet_id=
=2Ec
@@ -271,6 +271,53 @@
     assert_memory_equal(mru_ack=2Epacket_id, exp=
ected_ack=2Epacket_id, sizeof(expected_ack=2Epacket_id));
 }
 
+static void=

+test_packet_id_window(void **state)
+{
+    struct reliable rel =3D { 0 }=
;
+    rel=2Epacket_id =3D 1;
+
+    assert_true(validate_packet_id_window(=
&rel, 0));
+
+    /* packet id 1 is outside the window as it is the *next* =
packet id */
+    assert_false(validate_packet_id_window(&rel, 1));
+
+    =
/* wrapped around packet id, "-2" */
+    assert_true(validate_packet_id_wi=
ndow(&rel, 0xFFFFFFFD));
+
+    /* wrapped around packet id, "-10" */
+    =
assert_true(validate_packet_id_window(&rel, 0xFFFFFFF6));
+
+    /* wrapped=
 around packet id, "-11" */
+    assert_false(validate_packet_id_window(&re=
l, 0xFFFFFFF5));
+    assert_false(validate_packet_id_window(&rel, 0x800000=
00));
+
+    rel=2Epacket_id =3D 0x80000000;
+
+    /* near the signed/usig=
ned integer area */
+    assert_false(validate_packet_id_window(&rel, 0x800=
00001));
+    assert_true(validate_packet_id_window(&rel, 0x7fffffff));
+  =
  assert_true(validate_packet_id_window(&rel, 0x7ffffff5));
+    assert_fal=
se(validate_packet_id_window(&rel, 0x7ffffff4));
+
+    rel=2Epacket_id =3D=
 0xFFFFFFFD;
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFD))=
;
+    assert_false(validate_packet_id_window(&rel, 0));
+    assert_false(=
validate_packet_id_window(&rel, 1));
+    assert_false(validate_packet_id_w=
indow(&rel, 0xFFFFFFFE));
+    assert_false(validate_packet_id_window(&rel,=
 0xFFFFFFFF));
+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF3)=
);
+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF2));
+    asse=
rt_false(validate_packet_id_window(&rel, 0xFFFFFFF1));
+
+    rel=2Epacket_=
id =3D 500;
+    assert_false(validate_packet_id_window(&rel, 501));
+    a=
ssert_true(validate_packet_id_window(&rel, 497));
+    assert_true(validate=
_packet_id_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
+    assert_false(=
validate_packet_id_window(&rel, 500 - RELIABLE_CAPACITY));
+}
+
+
 int
 mai=
n(void)
 {
@@ -295,7 +342,8 @@
                                         tes=
t_packet_id_write_setup,
                                         test_pack=
et_id_write_teardown),
         cmocka_unit_test(test_get_num_output_sequen=
ced_available),
-        cmocka_unit_test(test_copy_acks_to_lru)
+        c=
mocka_unit_test(test_copy_acks_to_lru),
+        cmocka_unit_test(test_pack=
et_id_window)
 
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1909?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerr=
it-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
Gerrit-Change-Numbe=
r: 1909
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--vmD4c1s0Uns=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>MaxF has uploaded this =
change for <strong>review</strong>=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1909?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ig=
nore acks for packets that cannot be outstanding<br><br>This ignores acks f=
or pids outside the send window, i=2Ee=2E for packets<br>that have either n=
ot been sent out yet or already left the window=2E<br>Nothing outside that =
window can be outstanding, so such acks can only<br>be used to manipulate t=
he state of the send buffer=2E<br><br>Comparing the pid of an outstanding p=
acket against the acked pid needs<br>to be wraparound aware as well=2E Othe=
rwise a peer can ack a pid from the<br>lower half of the id space, which pa=
sses the window check above, and<br>still increment n_acks on every outstan=
ding packet, forcing an early<br>retransmit after N_ACK_RETRANSMIT such ack=
s=2E<br><br>Github: OpenVPN/openvpn-private-issues#161<br>Reported-By: Mark=
 Bregman (Fox-IT) &lt;mark=2Ebregman@fox-it=2Ecom&gt;<br>CVE: 2026-84732<br=
>Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012<br>Signed-off-by: Arn=
e Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;=
<br>(cherry picked from commit d988ef4508e63b28c8e3efcb9f62eb8c836907fe)<br=
>---<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M tests=
/unit_tests/openvpn/test_packet_id=2Ec<br>3 files changed, 100 insertions(+=
), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/09/1909/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index babe4c8=2E=
=2Ed0ae3cc 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br>=
<span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -404,15 +404,36 @@<=
/span><br><span>     return true;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+validate_packet_id_window(struct reliabl=
e *rel, packet_id_type pid)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 reliable_pid_min(pid, rel-&gt;packet_id)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+           &amp;&amp; reliable_pid_min(subtract_pid(r=
el-&gt;packet_id, RELIABLE_CAPACITY), pid);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /* del acknowledged items from send buf */</span><b=
r><span> void</span><br><span> reliable_send_purge(struct reliable *rel, co=
nst struct reliable_ack *ack)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    for (i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    unsigned int out_of_window =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id=
_type first_out_of_window =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><span>     {</span><br><=
span>         packet_id_type pid =3D ack-&gt;packet_id[i];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        for (j =3D 0; j &lt; rel-&gt;s=
ize; ++j)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!validate_packet_id_window(rel, pid)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (out_of_windo=
w =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  first_out_of_window =3D pid;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            out_of_window++;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            continue;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (=
int j =3D 0; j &lt; rel-&gt;size; ++j)</span><br><span>         {</span><br=
><span>             struct reliable_entry *e =3D &amp;rel-&gt;array[j];</sp=
an><br><span>             if (e-&gt;active &amp;&amp; e-&gt;packet_id =3D=
=3D pid)</span><br><span>@@ -432,16 +453,27 @@</span><br><span> #endif</spa=
n><br><span>                 e-&gt;active =3D false;</span><br><span>      =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e=
lse if (e-&gt;active &amp;&amp; e-&gt;packet_id &lt; pid)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (e-&gt;active &amp;&amp; reliable_pid_min=
(e-&gt;packet_id, pid))</span><br><span>             {</span><br><span>    =
             /* We have received an ACK for a packet with a higher PID=2E E=
ither</span><br><span>                  * we have received ACKs out of or o=
rder or the packet has been</span><br><span>                  * lost=2E We =
count the number of ACKs to determine if we should</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                 * resend it early=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 * resend=
 it early=2E The comparison needs to be wraparound aware,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 * otherwise a peer c=
an inflate n_acks with an ACK for a pid from</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 * the lower half of the id space =
and force a retransmit=2E */</span><br><span>                 e-&gt;n_acks+=
+;</span><br><span>             }</span><br><span>         }</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (out_of_window &gt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        (void)first_out_of_window;=
 /* dmsg might not generate code */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        dmsg(D_REL_LOW, &quot;ACK contained %u ids outside =
the send window, &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             &quot;first was &quot; packet_id_format,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             out_of_window, (packet_i=
d_print_type)first_out_of_window);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> =
#ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/reliable=2Eh b=
/src/openvpn/reliable=2Eh</span><br><span>index 5877f20=2E=2Ecdd33c8 100644=
</span><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/o=
penvpn/reliable=2Eh</span><br><span>@@ -106,9 +106,9 @@</span><br><span> {<=
/span><br><span>     int size;</span><br><span>     interval_t initial_time=
out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_typ=
e packet_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int o=
ffset; /**&lt; Offset of the bufs in the reliable_entry array */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    bool hold; /* don&#39;t xmit=
 until reliable_schedule_now is called */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    packet_id_type packet_id; /**&lt; Packet ID for t=
he next packet to be sent out=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int offset;               /**&lt; Offset of the bufs in=
 the reliable_entry array */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool hold;                /* don&#39;t xmit until reliable_sch=
edule_now is called */</span><br><span>     struct reliable_entry array[REL=
IABLE_CAPACITY];</span><br><span> };</span><br><span> </span><br><span>@@ -=
193,6 +193,17 @@</span><br><span> }</span><br><span> </span><br><span> /**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * check that pid is=
 inside the window of possible outstanding packets</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * of size RELIABLE_CAPACITY, ie inside the =
range</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * [rel-&gt;pa=
cket_id - RELIABLE_CAPACITY, rel-&gt;packet_id)=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * rel-&gt;packet is the *next* packet id to be sent out, so =
it is not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * include=
d in the valid range=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+validate_packet_id_window(st=
ruct reliable *rel, packet_id_type pid);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span>  * Returns the number of packets that need to be ack=
ed=2E</span><br><span>  *</span><br><span>  * @param ack The acknowledgment=
 structure to check=2E</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><b=
r><span>index ff3f788=2E=2Ea27bd6d 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_packet_id=2Ec</span><br><span>@@ -271,6 +271,53 @@</span><br><spa=
n>     assert_memory_equal(mru_ack=2Epacket_id, expected_ack=2Epacket_id, s=
izeof(expected_ack=2Epacket_id));</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_packet_id_window(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id=
 =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_packet=
_id_window(&amp;rel, 0));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* packet=
 id 1 is outside the window as it is the *next* packet id */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_i=
d_window(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* wrapped =
around packet id, &quot;-2&quot; */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFF=
FFD));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* wrapped around packet id,=
 &quot;-10&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF6));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* wrapped around packet id, &quot;-11&quot;=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(validate_packet_id_window(&amp;rel, 0xFFFFFFF5));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_id_window(&=
amp;rel, 0x80000000));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket=
_id =3D 0x80000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* near the sig=
ned/usigned integer area */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(validate_packet_id_window(&amp;rel, 0x80000001));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(vali=
date_packet_id_window(&amp;rel, 0x7fffffff));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(validate_packet_id_window(&amp;re=
l, 0x7ffffff5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(validate_packet_id_window(&amp;rel, 0x7ffffff4));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 0xFFFFFFFD;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_i=
d_window(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(validate_packet_id_window(&amp;rel, 0));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validat=
e_packet_id_window(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFF=
FE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(validate_packet_id_window(&amp;rel, 0xFFFFFFFF));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_packet_id_window=
(&amp;rel, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF2));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validat=
e_packet_id_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    rel=2Epacket_id =3D 500;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(validate_packet_id_window(&amp;rel, 501));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(valida=
te_packet_id_window(&amp;rel, 497));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(validate_packet_id_window(&amp;rel, 500 - =
(RELIABLE_CAPACITY - 1)));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(validate_packet_id_window(&amp;rel, 500 - RELIABLE_=
CAPACITY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(v=
oid)</span><br><span> {</span><br><span>@@ -295,7 +342,8 @@</span><br><span=
>                                         test_packet_id_write_setup,</span=
><br><span>                                         test_packet_id_write_te=
ardown),</span><br><span>         cmocka_unit_test(test_get_num_output_sequ=
enced_available),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    cmocka_unit_test(test_copy_acks_to_lru)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_copy_acks_to_lru),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_packet_id_window)</span><br><span> </span><br><span>     };</span><=
br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail">change 1909</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I944478767b52a1b9bf6a65373ce0544c69cb1012 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1909 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@ma=
x-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body=
></html>
--vmD4c1s0Uns=--


--===============1965063548256212807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1965063548256212807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1965063548256212807==--

