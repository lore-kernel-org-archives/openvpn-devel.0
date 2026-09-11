Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907A2C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V34eGAOel2A8GELbZEZ2MN+cjh+3uwDJvO5FPHT9nO4=; b=hSjQnPLtmfRFnK8XFsrVIWl6ot
	W8HwCuuh3umuWfuDrOM22o2DJ+H1DdTorjbc/czb5qBcD+JAjVjnxgrW3HA8bf1f7qnCq8FCYz0An
	WzltSuPxO8Rh1vU4EUysL+8lceq5YWsr8XT+0WfoYKFpSTzQhp0Jrth6baF/j/y6tBhQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52yv-00082P-PU;
	Fri, 11 Sep 2026 15:16:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x52yu-00082D-Pn
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eJvZVStuldnZjxFw+nikPoyXEUOo0ZEqz+ars1pLvLw=; b=OwjPeFAHcg6KQSB3slwEL7rJ0s
 a/fpwUqr9OKugkkrbiRksj9Znk1DG4ADhtOqLUoKaC04zjQvE68QD4IkY9+tUAywpz5TlR5WGqn9f
 uVkELvTwndsIWdx5Dck6rvQhIxbtWW9BSuyy28tSrlMjLaFDiJ6dTnMopu2sUl2SMnCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eJvZVStuldnZjxFw+nikPoyXEUOo0ZEqz+ars1pLvLw=; b=X
 fpsaK9ZByX08xZ48flc+aNju5bM3QbKLYtVTSg5Ekm+09+CvLmeV4KSALJK1eP3cw/0j0bssv8RYz
 Jo0cfH2+hNcqj0wkIAjVoB+MmjngJnqS/YrfAwp9/hIialapZCwv2g5EUBR8fJ/Xd8BTSvGrzmeyz
 Dw02WQ5wAH9eluX4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52ys-0000uX-Er for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:16:01 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49e651e83dfso5945815e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789139752; x=1789744552; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eJvZVStuldnZjxFw+nikPoyXEUOo0ZEqz+ars1pLvLw=;
 b=AkDvEWl2lLezRyYP9+WRXfPkR4g43eDfkvk/DcW883wmtGdYuQ/gHgEZjcXVYLzbn4
 mVYIQk2/aHM2cJ/lxEUwY8lJvw6V5u9VYp6Q0K6WLRZwYPNTViRU0FKquUllB8NwW4J8
 Zg620pFV7Lv6UbM2JMxsWdwZqy4cBCZ2OvSAdNl7iSq39G5VQdrqq/138eiqxQ++avs9
 IYi3R/cwC8cncqFg52yDVYEOxMM5RHYi/BXYlQBE4gkldZ6aVi0X0jfdE7vwnLsBzqvd
 aOsiBDScwgD6+IyoDtxQeflwno6vDOYCIuRB15giggOI4/Nb8DyfZ3Io3eO3SaeoSG0F
 Nq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139752; x=1789744552;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eJvZVStuldnZjxFw+nikPoyXEUOo0ZEqz+ars1pLvLw=;
 b=RPVgOwg0IArk9jN8pifs6b0ZHnXJMEMyk4nRO1n8k/+c7fbCMs0gyiqHMfxUdVVSTP
 XsCYRpY0Ef7tIWLhGnzC5EU+F9J+dBqn5RZLzTtJ0z4K3/nBLTEOyvuSzb5QTYKvGetA
 H5hQDWk80BG2NO8+NppESXve58YVIx3MqnWgj9GFA0Nq+0i8MeUmlase8QzeN3qZVPQ3
 sVINOKJi90J3WvNXBTcNunOiG5qWXXGXA/M6zpPtZm6sOV3nGi5ufAcLRrhcK6uJdCaj
 2DXK+CNdtiNh5wyC5d1lJ9KDGwEOUOMvAfCZQNxjYPjR3yRIAbJcgpNUTUO8+D3MztkY
 m9Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAjSgiqwzxidf2eG4fZz9Iol7ErFmkoDMGDXVzkfgq8obZ+Bg5mAyzKVfezse+cquCLqJwVj53rdCVfss2@lists.sourceforge.net
X-Gm-Message-State: AFuF++njdc1r6+PZRgEQOw36RUtt9zqkJ49uh66NTYtDth9WO0Ni6mUi
 3gwntRL1XouFihwANgAMNRGcEhKOjTV5sUCERu5BPsbos80FR4JOI/3oBLnwORsldALN/mSSjs1
 qzKEYEeZQ6Aqy24D5U54biEZCxdY59X9Gd2J+PlNv3qi3cdG0il88cRBzKvn4uSEFlsjBgamTbE
 yo6scKRQ==
X-Gm-Gg: AYBFou3FNDyjbGP1p6qoyN7FGYSP9qtD+wEAp+AYj1sbBevVfCeaqF9iZxR7AZ/qJOP
 PZBGbo2doATkJtBfJ2br0mYkU0KzuUfUcwSHnk+Nf8zDlUzC5dxPNmTpmAaMPJ6o6WtT7QKXnhf
 EWhMhKNAahr4rdQAtMxsqtNJ3hdfxyNp3zYM0RK8J/jhgdk/TglDU7kmbdbWX4JDQq7BHoMzQKS
 GQYvgZ+EbhrvETxb18bkh7IAeb2BAJDOch6k6xeOxarU6hdHZATjSiiAOAgT0Sj7mWc6haWvyx6
 Y/giW089NOK9UmcxNxUFcd97KVxenkPAD+j/VsbgnCfkm//siDY493EUyqcxHhtR+j/GXshliDA
 iiElNkTjqY7E59bvYcm7FoWAnePvnmsRDCRQ7rCNRBZwaZFLSGhRumZcUFbiDrJz8CPOtC95hO8
 u1JMII8GerVJmycnlzLiQxxxp0q271QzlB2RoA0RnmkTWrhxfFjuTqndeYt6QKtU/lmMKNURS01
 eze+ax865pdkRjfVjQKJLcCsfmk6w0CJ/qifpf4fiMWWosDgcA3433wZfwtw+PxQU/Lgq+1rMtK
 AjPARA2dgCmEb4/bDo1hg/EyQ/hvcbnK6zFkQfTimgfSmULKaT68z0sO2rDMAicMVeJLuKv/
X-Received: by 2002:a05:600c:c490:b0:49c:fc6c:bdfa with SMTP id
 5b1f17b1804b1-49e619e1cf0mr51305075e9.17.1789139751520; 
 Fri, 11 Sep 2026 08:15:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb359f38sm6112050f8f.30.2026.09.11.08.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:15:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:15:50 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
X-Gerrit-Change-Number: 1909
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1909?usp=email>
X-Gerrit-Commit: bd90ce85020a61828b01c77f6eb5f178279192db
In-Reply-To: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
References: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MzA3MDAwLkk5NDQ0Nzg3NjdiNTJhMWI5YmY2YTY1MzczY2UwNTQ0YzY5Y2IxMDEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <387a99bf734b22ce80742855d53710f5a278b8e1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x52ys-0000uX-Er
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
Content-Type: multipart/mixed; boundary="===============2244170168884084122=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2244170168884084122==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wrPnmRBzmew="; charset=UTF-8

--wrPnmRBzmew=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1909?usp=3Demail )

Change subject: Ignore acks for packets that cannot=
 be outstanding
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Ignore acks for packets that cannot be outstanding

This ignores acks =
for pids outside the send window, i=2Ee=2E for packets
that have either not=
 been sent out yet or already left the window=2E
Nothing outside that windo=
w can be outstanding, so such acks can only
be used to manipulate the state=
 of the send buffer=2E

Comparing the pid of an outstanding packet against =
the acked pid needs
to be wraparound aware as well=2E Otherwise a peer can =
ack a pid from the
lower half of the id space, which passes the window chec=
k above, and
still increment n_acks on every outstanding packet, forcing an=
 early
retransmit after N_ACK_RETRANSMIT such acks=2E

Github: OpenVPN/open=
vpn-private-issues#161
Reported-By: Mark Bregman (Fox-IT) <mark=2Ebregman@f=
ox-it=2Ecom>
CVE: 2026-84732
Change-Id: I944478767b52a1b9bf6a65373ce0544c69=
cb1012
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Signed-off-by: Razv=
an Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909
Acke=
d-by: MaxF <max@max-fillinger=2Enet>
(cherry picked from commit d988ef4508e=
63b28c8e3efcb9f62eb8c836907fe)
Message-Id: <20260910085046=2E30817-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg39048=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
=
M tests/unit_tests/openvpn/test_packet_id=2Ec
3 files changed, 100 insertio=
ns(+), 9 deletions(-)




diff --git a/src/openvpn/reliable=2Ec b/src/openv=
pn/reliable=2Ec
index babe4c8=2E=2Ed0ae3cc 100644
--- a/src/openvpn/reliabl=
e=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -404,15 +404,36 @@
     return true=
;
 }
 
+int
+validate_packet_id_window(struct reliable *rel, packet_id_type=
 pid)
+{
+    return reliable_pid_min(pid, rel->packet_id)
+           && r=
eliable_pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+}
+=

 /* del acknowledged items from send buf */
 void
 reliable_send_purge(str=
uct reliable *rel, const struct reliable_ack *ack)
 {
-    int i, j;
-    f=
or (i =3D 0; i < ack->len; ++i)
+    unsigned int out_of_window =3D 0;
+   =
 packet_id_type first_out_of_window =3D 0;
+
+    for (int i =3D 0; i < ack=
->len; ++i)
     {
         packet_id_type pid =3D ack->packet_id[i];
-    =
    for (j =3D 0; j < rel->size; ++j)
+
+
+        if (!validate_packet_id_=
window(rel, pid))
+        {
+            if (out_of_window =3D=3D 0)
+    =
        {
+                first_out_of_window =3D pid;
+            }
+   =
         out_of_window++;
+            continue;
+        }
+
+        for =
(int j =3D 0; j < rel->size; ++j)
         {
             struct reliable_e=
ntry *e =3D &rel->array[j];
             if (e->active && e->packet_id =3D=
=3D pid)
@@ -432,16 +453,27 @@
 #endif
                 e->active =3D false=
;
             }
-            else if (e->active && e->packet_id < pid)
+
+=
            if (e->active && reliable_pid_min(e->packet_id, pid))
         =
    {
                 /* We have received an ACK for a packet with a highe=
r PID=2E Either
                  * we have received ACKs out of or order o=
r the packet has been
                  * lost=2E We count the number of AC=
Ks to determine if we should
-                 * resend it early=2E */
+   =
              * resend it early=2E The comparison needs to be wraparound aw=
are,
+                 * otherwise a peer can inflate n_acks with an ACK fo=
r a pid from
+                 * the lower half of the id space and force a=
 retransmit=2E */
                 e->n_acks++;
             }
         }
 =
    }
+
+    if (out_of_window > 0)
+    {
+        (void)first_out_of_wind=
ow; /* dmsg might not generate code */
+        dmsg(D_REL_LOW, "ACK contai=
ned %u ids outside the send window, "
+             "first was " packet_id_=
format,
+             out_of_window, (packet_id_print_type)first_out_of_win=
dow);
+    }
 }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openvpn/reliable=2E=
h b/src/openvpn/reliable=2Eh
index 5877f20=2E=2Ecdd33c8 100644
--- a/src/op=
envpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -106,9 +106,9 @@
 {
  =
   int size;
     interval_t initial_timeout;
-    packet_id_type packet_id=
;
-    int offset; /**< Offset of the bufs in the reliable_entry array */
-=
    bool hold; /* don't xmit until reliable_schedule_now is called */
+    =
packet_id_type packet_id; /**< Packet ID for the next packet to be sent out=
=2E */
+    int offset;               /**< Offset of the bufs in the reliab=
le_entry array */
+    bool hold;                /* don't xmit until reliab=
le_schedule_now is called */
     struct reliable_entry array[RELIABLE_CAPA=
CITY];
 };
 
@@ -193,6 +193,17 @@
 }
 
 /**
+ * check that pid is inside th=
e window of possible outstanding packets
+ * of size RELIABLE_CAPACITY, ie =
inside the range
+ * [rel->packet_id - RELIABLE_CAPACITY, rel->packet_id)=
=2E
+ *
+ * rel->packet is the *next* packet id to be sent out, so it is no=
t
+ * included in the valid range=2E
+ */
+int
+validate_packet_id_window(s=
truct reliable *rel, packet_id_type pid);
+
+/**
  * Returns the number of =
packets that need to be acked=2E
  *
  * @param ack The acknowledgment stru=
cture to check=2E
diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec =
b/tests/unit_tests/openvpn/test_packet_id=2Ec
index ff3f788=2E=2Ea27bd6d 10=
0644
--- a/tests/unit_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tes=
ts/openvpn/test_packet_id=2Ec
@@ -271,6 +271,53 @@
     assert_memory_equal=
(mru_ack=2Epacket_id, expected_ack=2Epacket_id, sizeof(expected_ack=2Epacke=
t_id));
 }
 
+static void
+test_packet_id_window(void **state)
+{
+    stru=
ct reliable rel =3D { 0 };
+    rel=2Epacket_id =3D 1;
+
+    assert_true(v=
alidate_packet_id_window(&rel, 0));
+
+    /* packet id 1 is outside the wi=
ndow as it is the *next* packet id */
+    assert_false(validate_packet_id_=
window(&rel, 1));
+
+    /* wrapped around packet id, "-2" */
+    assert_t=
rue(validate_packet_id_window(&rel, 0xFFFFFFFD));
+
+    /* wrapped around =
packet id, "-10" */
+    assert_true(validate_packet_id_window(&rel, 0xFFFF=
FFF6));
+
+    /* wrapped around packet id, "-11" */
+    assert_false(vali=
date_packet_id_window(&rel, 0xFFFFFFF5));
+    assert_false(validate_packet=
_id_window(&rel, 0x80000000));
+
+    rel=2Epacket_id =3D 0x80000000;
+
+  =
  /* near the signed/usigned integer area */
+    assert_false(validate_pac=
ket_id_window(&rel, 0x80000001));
+    assert_true(validate_packet_id_windo=
w(&rel, 0x7fffffff));
+    assert_true(validate_packet_id_window(&rel, 0x7f=
fffff5));
+    assert_false(validate_packet_id_window(&rel, 0x7ffffff4));
+=

+    rel=2Epacket_id =3D 0xFFFFFFFD;
+    assert_false(validate_packet_id_=
window(&rel, 0xFFFFFFFD));
+    assert_false(validate_packet_id_window(&rel=
, 0));
+    assert_false(validate_packet_id_window(&rel, 1));
+    assert_f=
alse(validate_packet_id_window(&rel, 0xFFFFFFFE));
+    assert_false(valida=
te_packet_id_window(&rel, 0xFFFFFFFF));
+    assert_true(validate_packet_id=
_window(&rel, 0xFFFFFFF3));
+    assert_true(validate_packet_id_window(&rel=
, 0xFFFFFFF2));
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFF=
1));
+
+    rel=2Epacket_id =3D 500;
+    assert_false(validate_packet_id_w=
indow(&rel, 501));
+    assert_true(validate_packet_id_window(&rel, 497));
=
+    assert_true(validate_packet_id_window(&rel, 500 - (RELIABLE_CAPACITY -=
 1)));
+    assert_false(validate_packet_id_window(&rel, 500 - RELIABLE_CAP=
ACITY));
+}
+
+
 int
 main(void)
 {
@@ -295,7 +342,8 @@
                   =
                      test_packet_id_write_setup,
                         =
                test_packet_id_write_teardown),
         cmocka_unit_test(t=
est_get_num_output_sequenced_available),
-        cmocka_unit_test(test_cop=
y_acks_to_lru)
+        cmocka_unit_test(test_copy_acks_to_lru),
+        c=
mocka_unit_test(test_packet_id_window)
 
     };
 

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: release/2=2E6
Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb10=
12
Gerrit-Change-Number: 1909
Gerrit-PatchSet: 5
Gerrit-Owner: MaxF <max@ma=
x-fillinger=2Enet>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: plai=
sthos <arne-openvpn@rfc2549=2Eorg>

--wrPnmRBzmew=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1909?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Ignore acks for packets that cannot be out=
standing<br><br>This ignores acks for pids outside the send window, i=2Ee=
=2E for packets<br>that have either not been sent out yet or already left t=
he window=2E<br>Nothing outside that window can be outstanding, so such ack=
s can only<br>be used to manipulate the state of the send buffer=2E<br><br>=
Comparing the pid of an outstanding packet against the acked pid needs<br>t=
o be wraparound aware as well=2E Otherwise a peer can ack a pid from the<br=
>lower half of the id space, which passes the window check above, and<br>st=
ill increment n_acks on every outstanding packet, forcing an early<br>retra=
nsmit after N_ACK_RETRANSMIT such acks=2E<br><br>Github: OpenVPN/openvpn-pr=
ivate-issues#161<br>Reported-By: Mark Bregman (Fox-IT) &lt;mark=2Ebregman@f=
ox-it=2Ecom&gt;<br>CVE: 2026-84732<br>Change-Id: I944478767b52a1b9bf6a65373=
ce0544c69cb1012<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<b=
r>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1909<br>Acked-by: MaxF &lt;max@max-fillinger=
=2Enet&gt;<br>(cherry picked from commit d988ef4508e63b28c8e3efcb9f62eb8c83=
6907fe)<br>Message-Id: &lt;20260910085046=2E30817-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg39048=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/relia=
ble=2Eh<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>3 files changed=
, 100 insertions(+), 9 deletions(-)<br><br></pre>
<pre style=3D"font-family=
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
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I94=
4478767b52a1b9bf6a65373ce0544c69cb1012 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1909 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-f=
illinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--wrPnmRBzmew=--


--===============2244170168884084122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2244170168884084122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2244170168884084122==--

