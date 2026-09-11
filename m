Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC36C88E58
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwccA+G3r7uGxwnL+z8xqnc5ft80g94BdkjA/rOlXbQ=; b=b4HljKUgtdgTvB7q1teJtbnOnL
	S9Zda/i67+rEoozvVM2xMILdbU4cbfMjFaJjgciEiVqBy22wzbqL/c7zbcbEvvYZaBgwdsC+F4pmp
	oJx07cM9lmqWPMFX9WSS4a/FatIMqlLIpG090Dl1Qn7e69rvTZTZ3x7/PJDjrEDZi7MU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x53LV-0008Qi-Ua;
	Fri, 11 Sep 2026 15:39:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x53LU-0008Pq-P5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yqeiTSRWRik97dk0V7l7iQJ20isrCFObHRK76E+pPx4=; b=iG6rrdjxRgKxN1sIG/qIskK3GO
 5Exl4kbDAoShm7Ena7XrKD7ZASwmq3VHb6p04pIolyp2sSN+duYFsnDDUX+TcHm5Pb6W2/VGI5z7y
 FrWDsT9pwWFfblnq+H7v5zzPg7nms2KvFqgkPfv4Tf8zI6VOgTIEO9Lsst5d+t63Z2T0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yqeiTSRWRik97dk0V7l7iQJ20isrCFObHRK76E+pPx4=; b=Q
 nuRNFvUbIpr+Yd5QuTX1Us9k2D+DXAW6A1riXxtMKKebf6iH4s5x74AU5oKHDBH4r4ldPY/uX3coy
 lOcGRFIpVy+b5Ge5ThGZf7223c/fMktY3pPO//5+M5KIl+L6HyLXevF/iRFsk4ZsADespcRK0spBw
 w6uxeSWb62p/Fcu8=;
Received: from mail-ed2-f12.google.com ([74.125.228.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x53Kq-0001ng-J7 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:38:42 +0000
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so116883a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789141114; x=1789745914; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yqeiTSRWRik97dk0V7l7iQJ20isrCFObHRK76E+pPx4=;
 b=blAiIGQS7iHFQSmJM9E8PZpfPfGshQEr4pw9SZsls5+E9f10mt8ROkQ3SbgF4HB6hv
 RTXIen8bSlSma22BICWM8CRk5PgkwQac+/jWXY2CL9h7h54a1Zu5s0fsibT3Z4cAJzuN
 U/NgBcQH7c2q9nKCpw5CEg/t0fLg5Atg0EmHv0DuM+5HYvSl1ifPSmZal1mzGd6IL84f
 vsacXLgM/mAjSqWK9RmN0oGx62bogk3xTHdaOgSaehuD75Z1cVVfoe/c8vfCtwhy/wtf
 R9cVB3cnlSvcHRutC3WQentCwEdpG5XpiV/rLS0sfg9FSuuonUT9JSC6xvi9+T+f+nHk
 FoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141114; x=1789745914;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yqeiTSRWRik97dk0V7l7iQJ20isrCFObHRK76E+pPx4=;
 b=kWNQCrtPg+ODz4tY17knduJcjYycuOMnqUPgBwWnWvANU3qNGBIh6x0JVVkvByciiU
 guuzRt30m075gZf+n0dfnWEnjWPBo81i6xw4hrVScz0OIOb75xniuWo6Edab91tLOmN4
 v1KvR2S90J6qXAhUmRht/mOSEmWq/uGeBaX5pnCICFQTGPq3Esk+wZgBjMrqq9uFHWCQ
 d9jQjoIaxf5B1QhW5GWm8AHP+zhxpygRBCei56ZT61RNEq/kGEzMS8H1L5rGTwvdgZJK
 zrR9gDOWxrXsvsih/wSWzfaL5Xe1Fvsk1BRZTK91uKS5VZUWxGRAbBZyFSf+4yhrg3gG
 ly1w==
X-Gm-Message-State: AFuF++kftUTcAr1lx08FZ8v9VTMXsjOrit+73i0cw/oHx0zQm/jka3w4
 zKKGrzW5XLcq8PEb+2QFvg8QGjEUFuc2k64NTseYe8uLzOkxg732XzXIIRltRpuA4ddYdlMXwa9
 Eo448xoxviWQZ6JlOE5lcTKmflQ6vpjnoyQpTSOZeOX2IkAXqyqeV8GxU3rg1r19QMYA1P7VzAS
 WlOk5KyA==
X-Gm-Gg: AYBFou3VBIAql2txH2AHuI0+d7kyfGvbCbouQCpr2+g12AcSRf1k9ML+CFskog0L6z6
 675MDeM0v0MR6t9dW1JwA2/yg8qimhylgpcLi8CJxjygtyQiiNcA71CpkRaluTmmLyuQo0598WI
 WQ9flCox+OFqAL1WHj8Ziz4rVzUDZARdwokyWe7lBsOiL+AcHsqlbnzxbBSZTqzKPmkOR7Ncvvs
 hCrCEmJbNZuU+I8ZnscvrLFi7cgCEW2ZFPw9n329ODMreMIvSgXfkoFlOcVg/DdFCe7/orX7zvK
 fT3OfxJ5wG57MbB5vB2JROQAS+8hHNK3EImb6ODD+pFgQeJOWcVSbFXlmGJw4lw1ZSujSujFLVx
 i0AQm5pdIv6TJe6kn7B/fCa7UuqiL9AKf677e+4AKNqse9HXJ56xNeKTI1ZAJpo1qz5kR88+hvv
 qiDM0KYR9ektxd7js5cRDSCdansmBh0ntnpFf75O3QnnD09+1dQN33fXJgOys6ZIwribqQ+c4J1
 WxAJQBfk4M2IzXll6TwB9i5vng6NxI+qoqJcb/UpP6aeUTrdSu8pAoG4sQQ9mM0KZDnl/i3w1Rk
 DS1C/4TWFa+S9ZI9Gqb1SYbknrPUm6g0BJJ+q9RHpNxuhKCeGX8DItiKGRzafQ==
X-Received: by 2002:a17:907:d02:b0:c25:2a78:15ed with SMTP id
 a640c23a62f3a-c296659c61fmr381660366b.6.1789139750370; 
 Fri, 11 Sep 2026 08:15:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29660f9b23sm89194566b.50.2026.09.11.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:15:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:15:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
X-Gerrit-Change-Number: 1909
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1909?usp=email>
X-Gerrit-Commit: bd90ce85020a61828b01c77f6eb5f178279192db
In-Reply-To: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
References: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MzA3MDAwLkk5NDQ0Nzg3NjdiNTJhMWI5YmY2YTY1MzczY2UwNTQ0YzY5Y2IxMDEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <387a99bf734b22ce80742855d53710f5a278b8e1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x53Kq-0001ng-J7
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1625907433846599893=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1625907433846599893==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jZY3VuvosQE="; charset=UTF-8

--jZY3VuvosQE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by razva=
nc


Change subject: Ignore acks for packets that cannot be outstanding
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Ignore acks for =
packets that cannot be outstanding

This ignores acks for pids outside the =
send window, i=2Ee=2E for packets
that have either not been sent out yet or=
 already left the window=2E
Nothing outside that window can be outstanding,=
 so such acks can only
be used to manipulate the state of the send buffer=
=2E

Comparing the pid of an outstanding packet against the acked pid needs=

to be wraparound aware as well=2E Otherwise a peer can ack a pid from the
=
lower half of the id space, which passes the window check above, and
still =
increment n_acks on every outstanding packet, forcing an early
retransmit a=
fter N_ACK_RETRANSMIT such acks=2E

Github: OpenVPN/openvpn-private-issues#=
161
Reported-By: Mark Bregman (Fox-IT) <mark=2Ebregman@fox-it=2Ecom>
CVE: 2=
026-84732
Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
Signed-off-b=
y: Arne Schwabe <arne@rfc2549=2Eorg>
Signed-off-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909
Acked-by: MaxF <max@max=
-fillinger=2Enet>
(cherry picked from commit d988ef4508e63b28c8e3efcb9f62eb=
8c836907fe)
Message-Id: <20260910085046=2E30817-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg39048=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M tests/unit_tests/=
openvpn/test_packet_id=2Ec
3 files changed, 100 insertions(+), 9 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/=
1909/5

diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
in=
dex babe4c8=2E=2Ed0ae3cc 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/op=
envpn/reliable=2Ec
@@ -404,15 +404,36 @@
     return true;
 }
 
+int
+valid=
ate_packet_id_window(struct reliable *rel, packet_id_type pid)
+{
+    retu=
rn reliable_pid_min(pid, rel->packet_id)
+           && reliable_pid_min(su=
btract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+}
+
 /* del acknowled=
ged items from send buf */
 void
 reliable_send_purge(struct reliable *rel,=
 const struct reliable_ack *ack)
 {
-    int i, j;
-    for (i =3D 0; i < a=
ck->len; ++i)
+    unsigned int out_of_window =3D 0;
+    packet_id_type fi=
rst_out_of_window =3D 0;
+
+    for (int i =3D 0; i < ack->len; ++i)
     {=

         packet_id_type pid =3D ack->packet_id[i];
-        for (j =3D 0; =
j < rel->size; ++j)
+
+
+        if (!validate_packet_id_window(rel, pid))
=
+        {
+            if (out_of_window =3D=3D 0)
+            {
+       =
         first_out_of_window =3D pid;
+            }
+            out_of_wi=
ndow++;
+            continue;
+        }
+
+        for (int j =3D 0; j < =
rel->size; ++j)
         {
             struct reliable_entry *e =3D &rel->=
array[j];
             if (e->active && e->packet_id =3D=3D pid)
@@ -432,16=
 +453,27 @@
 #endif
                 e->active =3D false;
             }
- =
           else if (e->active && e->packet_id < pid)
+
+            if (e->=
active && reliable_pid_min(e->packet_id, pid))
             {
             =
    /* We have received an ACK for a packet with a higher PID=2E Either
   =
               * we have received ACKs out of or order or the packet has be=
en
                  * lost=2E We count the number of ACKs to determine if =
we should
-                 * resend it early=2E */
+                 * res=
end it early=2E The comparison needs to be wraparound aware,
+             =
    * otherwise a peer can inflate n_acks with an ACK for a pid from
+     =
            * the lower half of the id space and force a retransmit=2E */
 =
                e->n_acks++;
             }
         }
     }
+
+    if (ou=
t_of_window > 0)
+    {
+        (void)first_out_of_window; /* dmsg might n=
ot generate code */
+        dmsg(D_REL_LOW, "ACK contained %u ids outside =
the send window, "
+             "first was " packet_id_format,
+          =
   out_of_window, (packet_id_print_type)first_out_of_window);
+    }
 }
 
 =
#ifdef ENABLE_DEBUG
diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/rel=
iable=2Eh
index 5877f20=2E=2Ecdd33c8 100644
--- a/src/openvpn/reliable=2Eh
=
+++ b/src/openvpn/reliable=2Eh
@@ -106,9 +106,9 @@
 {
     int size;
     i=
nterval_t initial_timeout;
-    packet_id_type packet_id;
-    int offset; =
/**< Offset of the bufs in the reliable_entry array */
-    bool hold; /* d=
on't xmit until reliable_schedule_now is called */
+    packet_id_type pack=
et_id; /**< Packet ID for the next packet to be sent out=2E */
+    int off=
set;               /**< Offset of the bufs in the reliable_entry array */
+=
    bool hold;                /* don't xmit until reliable_schedule_now is =
called */
     struct reliable_entry array[RELIABLE_CAPACITY];
 };
 
@@ -19=
3,6 +193,17 @@
 }
 
 /**
+ * check that pid is inside the window of possibl=
e outstanding packets
+ * of size RELIABLE_CAPACITY, ie inside the range
+ =
* [rel->packet_id - RELIABLE_CAPACITY, rel->packet_id)=2E
+ *
+ * rel->pack=
et is the *next* packet id to be sent out, so it is not
+ * included in the=
 valid range=2E
+ */
+int
+validate_packet_id_window(struct reliable *rel, =
packet_id_type pid);
+
+/**
  * Returns the number of packets that need to =
be acked=2E
  *
  * @param ack The acknowledgment structure to check=2E
dif=
f --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/op=
envpn/test_packet_id=2Ec
index ff3f788=2E=2Ea27bd6d 100644
--- a/tests/unit=
_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_packe=
t_id=2Ec
@@ -271,6 +271,53 @@
     assert_memory_equal(mru_ack=2Epacket_id,=
 expected_ack=2Epacket_id, sizeof(expected_ack=2Epacket_id));
 }
 
+static =
void
+test_packet_id_window(void **state)
+{
+    struct reliable rel =3D {=
 0 };
+    rel=2Epacket_id =3D 1;
+
+    assert_true(validate_packet_id_win=
dow(&rel, 0));
+
+    /* packet id 1 is outside the window as it is the *ne=
xt* packet id */
+    assert_false(validate_packet_id_window(&rel, 1));
+
+=
    /* wrapped around packet id, "-2" */
+    assert_true(validate_packet_i=
d_window(&rel, 0xFFFFFFFD));
+
+    /* wrapped around packet id, "-10" */
+=
    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF6));
+
+    /* wra=
pped around packet id, "-11" */
+    assert_false(validate_packet_id_window=
(&rel, 0xFFFFFFF5));
+    assert_false(validate_packet_id_window(&rel, 0x80=
000000));
+
+    rel=2Epacket_id =3D 0x80000000;
+
+    /* near the signed/=
usigned integer area */
+    assert_false(validate_packet_id_window(&rel, 0=
x80000001));
+    assert_true(validate_packet_id_window(&rel, 0x7fffffff));=

+    assert_true(validate_packet_id_window(&rel, 0x7ffffff5));
+    assert=
_false(validate_packet_id_window(&rel, 0x7ffffff4));
+
+    rel=2Epacket_id=
 =3D 0xFFFFFFFD;
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFF=
FD));
+    assert_false(validate_packet_id_window(&rel, 0));
+    assert_fa=
lse(validate_packet_id_window(&rel, 1));
+    assert_false(validate_packet_=
id_window(&rel, 0xFFFFFFFE));
+    assert_false(validate_packet_id_window(&=
rel, 0xFFFFFFFF));
+    assert_true(validate_packet_id_window(&rel, 0xFFFFF=
FF3));
+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF2));
+    =
assert_false(validate_packet_id_window(&rel, 0xFFFFFFF1));
+
+    rel=2Epac=
ket_id =3D 500;
+    assert_false(validate_packet_id_window(&rel, 501));
+ =
   assert_true(validate_packet_id_window(&rel, 497));
+    assert_true(vali=
date_packet_id_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
+    assert_fa=
lse(validate_packet_id_window(&rel, 500 - RELIABLE_CAPACITY));
+}
+
+
 int
=
 main(void)
 {
@@ -295,7 +342,8 @@
                                        =
 test_packet_id_write_setup,
                                         test_=
packet_id_write_teardown),
         cmocka_unit_test(test_get_num_output_se=
quenced_available),
-        cmocka_unit_test(test_copy_acks_to_lru)
+     =
   cmocka_unit_test(test_copy_acks_to_lru),
+        cmocka_unit_test(test_=
packet_id_window)
 
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1909?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=
=2E6
Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
Gerrit-Cha=
nge-Number: 1909
Gerrit-PatchSet: 5
Gerrit-Owner: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: plaisthos <arne=
-openvpn@rfc2549=2Eorg>

--jZY3VuvosQE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">Ignore acks for packets that can=
not be outstanding<br><br>This ignores acks for pids outside the send windo=
w, i=2Ee=2E for packets<br>that have either not been sent out yet or alread=
y left the window=2E<br>Nothing outside that window can be outstanding, so =
such acks can only<br>be used to manipulate the state of the send buffer=2E=
<br><br>Comparing the pid of an outstanding packet against the acked pid ne=
eds<br>to be wraparound aware as well=2E Otherwise a peer can ack a pid fro=
m the<br>lower half of the id space, which passes the window check above, a=
nd<br>still increment n_acks on every outstanding packet, forcing an early<=
br>retransmit after N_ACK_RETRANSMIT such acks=2E<br><br>Github: OpenVPN/op=
envpn-private-issues#161<br>Reported-By: Mark Bregman (Fox-IT) &lt;mark=2Eb=
regman@fox-it=2Ecom&gt;<br>CVE: 2026-84732<br>Change-Id: I944478767b52a1b9b=
f6a65373ce0544c69cb1012<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>A=
cked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909<br>Acked-by: MaxF &lt;max@max-fi=
llinger=2Enet&gt;<br>(cherry picked from commit d988ef4508e63b28c8e3efcb9f6=
2eb8c836907fe)<br>Message-Id: &lt;20260910085046=2E30817-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg39048=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/reliable=2Ec<br>M src/openvpn=
/reliable=2Eh<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>3 files c=
hanged, 100 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/1909/5</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><b=
r><span>index babe4c8=2E=2Ed0ae3cc 100644</span><br><span>--- a/src/openvpn=
/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><spa=
n>@@ -404,15 +404,36 @@</span><br><span>     return true;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_packet_=
id_window(struct reliable *rel, packet_id_type pid)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return reliable_pid_min(pid, rel-&gt;packet_id)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; relia=
ble_pid_min(subtract_pid(rel-&gt;packet_id, RELIABLE_CAPACITY), pid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* del acknowledged ite=
ms from send buf */</span><br><span> void</span><br><span> reliable_send_pu=
rge(struct reliable *rel, const struct reliable_ack *ack)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; ack=
-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
nsigned int out_of_window =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    packet_id_type first_out_of_window =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><b=
r><span>     {</span><br><span>         packet_id_type pid =3D ack-&gt;pack=
et_id[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for =
(j =3D 0; j &lt; rel-&gt;size; ++j)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!validate_=
packet_id_window(rel, pid))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (out_of_window =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                first_out_of_window =3D pid;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            out_of_window++;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        for (int j =3D 0; j &lt; rel-&gt;size; ++j)</span><b=
r><span>         {</span><br><span>             struct reliable_entry *e =
=3D &amp;rel-&gt;array[j];</span><br><span>             if (e-&gt;active &a=
mp;&amp; e-&gt;packet_id =3D=3D pid)</span><br><span>@@ -432,16 +453,27 @@<=
/span><br><span> #endif</span><br><span>                 e-&gt;active =3D f=
alse;</span><br><span>             }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            else if (e-&gt;active &amp;&amp; e-&gt;packet_id=
 &lt; pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (e-&gt;active=
 &amp;&amp; reliable_pid_min(e-&gt;packet_id, pid))</span><br><span>       =
      {</span><br><span>                 /* We have received an ACK for a p=
acket with a higher PID=2E Either</span><br><span>                  * we ha=
ve received ACKs out of or order or the packet has been</span><br><span>   =
               * lost=2E We count the number of ACKs to determine if we sho=
uld</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 *=
 resend it early=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 * resend it early=2E The comparison needs to be wraparo=
und aware,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
        * otherwise a peer can inflate n_acks with an ACK for a pid from</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 * the=
 lower half of the id space and force a retransmit=2E */</span><br><span>  =
               e-&gt;n_acks++;</span><br><span>             }</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (out_of_window &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  (void)first_out_of_window; /* dmsg might not generate code */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_REL_LOW, &quot;A=
CK contained %u ids outside the send window, &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             &quot;first was &quot; packe=
t_id_format,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      out_of_window, (packet_id_print_type)first_out_of_window);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span=
><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff --gi=
t a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>ind=
ex 5877f20=2E=2Ecdd33c8 100644</span><br><span>--- a/src/openvpn/reliable=
=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -106=
,9 +106,9 @@</span><br><span> {</span><br><span>     int size;</span><br><s=
pan>     interval_t initial_timeout;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    packet_id_type packet_id;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int offset; /**&lt; Offset of the bufs in the re=
liable_entry array */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    bool hold; /* don&#39;t xmit until reliable_schedule_now is called */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_type pa=
cket_id; /**&lt; Packet ID for the next packet to be sent out=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int offset;            =
   /**&lt; Offset of the bufs in the reliable_entry array */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool hold;                /* d=
on&#39;t xmit until reliable_schedule_now is called */</span><br><span>    =
 struct reliable_entry array[RELIABLE_CAPACITY];</span><br><span> };</span>=
<br><span> </span><br><span>@@ -193,6 +193,17 @@</span><br><span> }</span><=
br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * check that pid is inside the window of possible outstanding =
packets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of size R=
ELIABLE_CAPACITY, ie inside the range</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * [rel-&gt;packet_id - RELIABLE_CAPACITY, rel-&gt;packet=
_id)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt;packet is the *nex=
t* packet id to be sent out, so it is not</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * included in the valid range=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+validate_packet_id_window(struct reliable *rel, packet_id_type pid);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Returns the numbe=
r of packets that need to be acked=2E</span><br><span>  *</span><br><span> =
 * @param ack The acknowledgment structure to check=2E</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/ope=
nvpn/test_packet_id=2Ec</span><br><span>index ff3f788=2E=2Ea27bd6d 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ =
-271,6 +271,53 @@</span><br><span>     assert_memory_equal(mru_ack=2Epacket=
_id, expected_ack=2Epacket_id, sizeof(expected_ack=2Epacket_id));</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_packet_id_window(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct reliable rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    rel=2Epacket_id =3D 1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(validate_packet_id_window(&amp;rel, 0));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* packet id 1 is outside the window as it is the *n=
ext* packet id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(validate_packet_id_window(&amp;rel, 1));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* wrapped around packet id, &quot;-2&quot; */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_pa=
cket_id_window(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* wrapped around packet id, &quot;-10&quot; */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_packet_id_window=
(&amp;rel, 0xFFFFFFF6));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* wrapped=
 around packet id, &quot;-11&quot; */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(validate_packet_id_window(&amp;rel, 0xFF=
FFFFF5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(validate_packet_id_window(&amp;rel, 0x80000000));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    rel=2Epacket_id =3D 0x80000000;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* near the signed/usigned integer area */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_=
id_window(&amp;rel, 0x80000001));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(validate_packet_id_window(&amp;rel, 0x7ffffff=
f));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(validate_packet_id_window(&amp;rel, 0x7ffffff5));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_id_window(&=
amp;rel, 0x7ffffff4));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket=
_id =3D 0xFFFFFFFD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFFD));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_pa=
cket_id_window(&amp;rel, 0));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(validate_packet_id_window(&amp;rel, 1));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_p=
acket_id_window(&amp;rel, 0xFFFFFFFE));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(validate_packet_id_window(&amp;rel, 0x=
FFFFFFFF));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF3));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_packet_id_wi=
ndow(&amp;rel, 0xFFFFFFF2));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFF1));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 500;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_pac=
ket_id_window(&amp;rel, 501));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(validate_packet_id_window(&amp;rel, 497));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_=
packet_id_window(&amp;rel, 500 - (RELIABLE_CAPACITY - 1)));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_id=
_window(&amp;rel, 500 - RELIABLE_CAPACITY));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> int</span><br><span> main(void)</span><br><span> {</span><br><span>@@=
 -295,7 +342,8 @@</span><br><span>                                         =
test_packet_id_write_setup,</span><br><span>                               =
          test_packet_id_write_teardown),</span><br><span>         cmocka_u=
nit_test(test_get_num_output_sequenced_available),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_copy_acks_to_lru=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_copy_acks_to_lru),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_packet_id_window)</span><br><span>=
 </span><br><span>     };</span><br><span> </span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
09?usp=3Demail">change 1909</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1909?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012 =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 1909 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jZY3VuvosQE=--


--===============1625907433846599893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1625907433846599893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1625907433846599893==--

