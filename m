Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD21C79FB6
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ip8FlEkFQF4fQ/0rkstsQKLYCRW2BwbNpKhPiu8+PjQ=; b=UuOtvK8X6zoKmXq03fR+F6zS0w
	Sr+4R8c+ACd3Uppc75GJavCk3Y4dgjRycWjsoWupeXc8hI1qalDKJOVEihYbhs66e6aaOglWY1OO+
	VQSfoKJn7a9bRkSyLxoTO3G7Pf733OZX8DZBpsNmmo3H9eVwd9SPFOqx2f3PMoK6lKfw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4IJO-0007OM-KI;
	Wed, 09 Sep 2026 13:26:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4IJN-0007OF-6d
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YXNUqw6R0aApnkjyO/jCnKtBQA5rdxWcxyfXIYtwxps=; b=VBP7QhoPtq8NneyjzUvBByo2xv
 DpHD5f1kjn83Vhu3kbLwPKA51xhhRObWJfJv3JMm1KaVEazgVlaiEy+4A9LmKNRMrp1DLe7BY8NIe
 tU+OFtSERIQZy1Cg6PGd5IuXWimYQJY9uDSaBLSo0togN04m3mz0j0nb+9+SRQ+f6ix8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YXNUqw6R0aApnkjyO/jCnKtBQA5rdxWcxyfXIYtwxps=; b=H
 Fj0Ln7B1s+OdU2fzdWvW8Cwsl0xUhQjsyfGpD2QNjfPWaunEisubxYTkluqe4cTmnvmfIioWUqvUB
 IgBhwaoAr4Lft0iqAihpAGe8XDmBQRP8+PQ6AkhJuU9jCyqK4FoqZoOkcRPIoZODU/fRQPMyA7Kpm
 u0zP6o4HG6NOv7DQ=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4IJJ-0002Ag-3v for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:58 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49d0b98d6d0so38434755e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788960350; x=1789565150; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YXNUqw6R0aApnkjyO/jCnKtBQA5rdxWcxyfXIYtwxps=;
 b=MSc+IhlL78Il3lvIkwacU+8ikcoE671u+WFtswcQ15Tpr6bSLhMMEMkCt6MUKppadN
 nT0Y2rLj4OvV/ghfQZtrd3hxDaAcaf5etRSQWQGXrHIXdBd0RmKq4WhEtwhs484RUUkL
 w5PdlCtb3rl0f/ZBjDPcoOR8XMIxAGiXS3/JtSv2FgHDzJRcDAAV8FeXQTQS5v/GVfZT
 vu1UWjrU1tb/JPJ91pbXPLwU02RpI5sEaxqOzE35tp5nUHsZ7ZlbIKiQhw3LU+Pwv5rO
 gNea5XQZdlbanLf8+6FOXVZ72JtAghjS39EkKQGLQWWPDL5Le5mVsx70y7nc6N9gz/us
 H4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788960350; x=1789565150;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YXNUqw6R0aApnkjyO/jCnKtBQA5rdxWcxyfXIYtwxps=;
 b=KlR34ytY9rXKxYJKKLMbiNUZOFA1NYImUWYatPEmx/hyVw97F6LaNHYfRMg/5YDCmJ
 nc+rCDXBB/yXa/e/w3GOxxOdYhO14+pcSTLunUvJMlFMG8HQXW5TySxeAzrllBxEPobI
 zOUKabOzx5n0CIgDQz8oHVwfxpew8muJ76LsgtB5m91RjcDCQhEEjM8kWAS86quP/93d
 TBdcE9LfJhYxUenyWxgFHZ1sDkLSHEJW5OPMTWRUOVwN2dnyXzdupyBwhcY0DKmZUSnA
 6UkygvEuQPJbxe2TH4/oAi9DNbaoc8wPdNp9ayAVM3PSYbxmKj2+AukH4yWmb0KY00B4
 A+ww==
X-Gm-Message-State: AFuF++kzyd+aUlHbRL8JCxiLRz4LCHEq8kRwAwnflYIXsgbHOsOrNcjw
 eerFd1IQqUUGmLILZsuAnCx/QfPwCRiGLVWeRH0QXJLCazNTF3Ij4rkkDa0brg6SQPC3QyA4WpJ
 LQ9uXsAMP+XdibrdC1YYrQv1rGwyrfa/gUuHYeEvbJqC4Id7D4yk2TCmIeuxo72vctdn5
X-Gm-Gg: AYBFou1C9C2iTYVe0DfJjloBUENhiiFV5a2q36YxQ1uSjROWAbMzkEGiM2kb3FtpNZ7
 tqN1B6WUoRcUc2F3uB2wR6Uvzydk1xAJXRxnvjfBAx3KHzb6gs8q0q091ny71Nan4H4ak5KwRtO
 uecjkIrCdcMfUEYXJpqzo2LKU4/qpBq62PjYpWqa/MUqONVLD0rDwelkClTVQbmV6uNYCndRUji
 wIiE7IOdfGsk6iMIYE8ZU869La59x45/Fs2vS3Rz73dm9ZwAynOK8TBqSbSar34Y45U96lpMrNj
 YFvY715KHG6U3lwdNRIUiBX2kov5yEMQreI6DTPR1K3BKAAP0Wom7MfvleboqcP1vY/mdV/ovHh
 3dLOZ3tB1EPFlSXimwn6OnOOTR9MLfmDPIgEVyigv+jCyYRZhMZk2vEqyaWrqIE/Z/BPz4Peo9n
 PZnlSTCJYM3vFVCbS/V0waUKfR1SnPQSQvoQz0zO8nZbq4TQ7eNwBOAnOEsmGMliHUorYcoiKOG
 HneIRQlNBNLIuKKv4WOQPWHCoThXCs3ScvhcjCCFFt5xMXZP9wjh19xR0+yMMezlE6YGxtCaqTd
 wFvYQzSa6xAUvPUWYnljOmGclHr9cmy/ACkHYm/x2x2VEWn8MjsUI2kQkPwqapZ2GI9oOldJ
X-Received: by 2002:a05:600c:45d5:b0:49d:2562:d670 with SMTP id
 5b1f17b1804b1-49d2562d699mr14698935e9.14.1788960350224; 
 Wed, 09 Sep 2026 06:25:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d03543064sm380242765e9.13.2026.09.09.06.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:25:49 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 13:25:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
X-Gerrit-Change-Number: 1909
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1909?usp=email>
X-Gerrit-Commit: 229883de43903aeac1225a292bb9fe916c256c5f
In-Reply-To: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
References: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MzA3MDAwLkk5NDQ0Nzg3NjdiNTJhMWI5YmY2YTY1MzczY2UwNTQ0YzY5Y2IxMDEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <53062e04cd46974fcb33b8585b20cef8f79603f2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4IJJ-0002Ag-3v
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
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2615224540512387051=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2615224540512387051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zh2zER7/byU="; charset=UTF-8

--Zh2zER7/byU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

Hello plaisthos, razvanc,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1909?usp=3Demail

to look at the new patch set (#=
4)=2E


Change subject: Ignore acks for packets that cannot be outstanding
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Ignore acks f=
or packets that cannot be outstanding

This ignores acks for pids outside t=
he send window, i=2Ee=2E for packets
that have either not been sent out yet=
 or already left the window=2E
Nothing outside that window can be outstandi=
ng, so such acks can only
be used to manipulate the state of the send buffe=
r=2E

Comparing the pid of an outstanding packet against the acked pid need=
s
to be wraparound aware as well=2E Otherwise a peer can ack a pid from the=

lower half of the id space, which passes the window check above, and
still=
 increment n_acks on every outstanding packet, forcing an early
retransmit =
after N_ACK_RETRANSMIT such acks=2E

Github: OpenVPN/openvpn-private-issues=
#161
Reported-By: Mark Bregman (Fox-IT) <mark=2Ebregman@fox-it=2Ecom>
CVE: =
2026-84732
Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
Signed-off-=
by: Arne Schwabe <arne@rfc2549=2Eorg>
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Acked-by: MaxF <max@max-fillinger=2Enet>
(cherry picked f=
rom commit d988ef4508e63b28c8e3efcb9f62eb8c836907fe)
---
M src/openvpn/reli=
able=2Ec
M src/openvpn/reliable=2Eh
M tests/unit_tests/openvpn/test_packet_=
id=2Ec
3 files changed, 100 insertions(+), 9 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/1909/4

diff --git a=
/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index babe4c8=2E=2Ed0a=
e3cc 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@=
@ -404,15 +404,36 @@
     return true;
 }
 
+int
+validate_packet_id_window=
(struct reliable *rel, packet_id_type pid)
+{
+    return reliable_pid_min(=
pid, rel->packet_id)
+           && reliable_pid_min(subtract_pid(rel->pack=
et_id, RELIABLE_CAPACITY), pid);
+}
+
 /* del acknowledged items from send =
buf */
 void
 reliable_send_purge(struct reliable *rel, const struct reliab=
le_ack *ack)
 {
-    int i, j;
-    for (i =3D 0; i < ack->len; ++i)
+    u=
nsigned int out_of_window =3D 0;
+    packet_id_type first_out_of_window =
=3D 0;
+
+    for (int i =3D 0; i < ack->len; ++i)
     {
         packet_i=
d_type pid =3D ack->packet_id[i];
-        for (j =3D 0; j < rel->size; ++j=
)
+
+
+        if (!validate_packet_id_window(rel, pid))
+        {
+      =
      if (out_of_window =3D=3D 0)
+            {
+                first_out=
_of_window =3D pid;
+            }
+            out_of_window++;
+         =
   continue;
+        }
+
+        for (int j =3D 0; j < rel->size; ++j)
  =
       {
             struct reliable_entry *e =3D &rel->array[j];
        =
     if (e->active && e->packet_id =3D=3D pid)
@@ -432,16 +453,27 @@
 #endi=
f
                 e->active =3D false;
             }
-            else if=
 (e->active && e->packet_id < pid)
+
+            if (e->active && reliable=
_pid_min(e->packet_id, pid))
             {
                 /* We have rec=
eived an ACK for a packet with a higher PID=2E Either
                  * w=
e have received ACKs out of or order or the packet has been
               =
   * lost=2E We count the number of ACKs to determine if we should
-       =
          * resend it early=2E */
+                 * resend it early=2E Th=
e comparison needs to be wraparound aware,
+                 * otherwise a =
peer can inflate n_acks with an ACK for a pid from
+                 * the =
lower half of the id space and force a retransmit=2E */
                 e-=
>n_acks++;
             }
         }
     }
+
+    if (out_of_window > 0)
+=
    {
+        (void)first_out_of_window; /* dmsg might not generate code *=
/
+        dmsg(D_REL_LOW, "ACK contained %u ids outside the send window, "=

+             "first was " packet_id_format,
+             out_of_window, =
(packet_id_print_type)first_out_of_window);
+    }
 }
 
 #ifdef ENABLE_DEBU=
G
diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index 58=
77f20=2E=2Ecdd33c8 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/=
reliable=2Eh
@@ -106,9 +106,9 @@
 {
     int size;
     interval_t initial_=
timeout;
-    packet_id_type packet_id;
-    int offset; /**< Offset of the=
 bufs in the reliable_entry array */
-    bool hold; /* don't xmit until re=
liable_schedule_now is called */
+    packet_id_type packet_id; /**< Packet=
 ID for the next packet to be sent out=2E */
+    int offset;              =
 /**< Offset of the bufs in the reliable_entry array */
+    bool hold;    =
            /* don't xmit until reliable_schedule_now is called */
     str=
uct reliable_entry array[RELIABLE_CAPACITY];
 };
 
@@ -193,6 +193,17 @@
 }
=
 
 /**
+ * check that pid is inside the window of possible outstanding pack=
ets
+ * of size RELIABLE_CAPACITY, ie inside the range
+ * [rel->packet_id =
- RELIABLE_CAPACITY, rel->packet_id)=2E
+ *
+ * rel->packet is the *next* p=
acket id to be sent out, so it is not
+ * included in the valid range=2E
+ =
*/
+int
+validate_packet_id_window(struct reliable *rel, packet_id_type pid=
);
+
+/**
  * Returns the number of packets that need to be acked=2E
  *
  =
* @param ack The acknowledgment structure to check=2E
diff --git a/tests/un=
it_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_=
id=2Ec
index ff3f788=2E=2Ea27bd6d 100644
--- a/tests/unit_tests/openvpn/tes=
t_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec
@@ -271,6=
 +271,53 @@
     assert_memory_equal(mru_ack=2Epacket_id, expected_ack=2Epa=
cket_id, sizeof(expected_ack=2Epacket_id));
 }
 
+static void
+test_packet_=
id_window(void **state)
+{
+    struct reliable rel =3D { 0 };
+    rel=2Ep=
acket_id =3D 1;
+
+    assert_true(validate_packet_id_window(&rel, 0));
+
+=
    /* packet id 1 is outside the window as it is the *next* packet id */
+=
    assert_false(validate_packet_id_window(&rel, 1));
+
+    /* wrapped aro=
und packet id, "-2" */
+    assert_true(validate_packet_id_window(&rel, 0xF=
FFFFFFD));
+
+    /* wrapped around packet id, "-10" */
+    assert_true(va=
lidate_packet_id_window(&rel, 0xFFFFFFF6));
+
+    /* wrapped around packet=
 id, "-11" */
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFF5)=
);
+    assert_false(validate_packet_id_window(&rel, 0x80000000));
+
+    r=
el=2Epacket_id =3D 0x80000000;
+
+    /* near the signed/usigned integer ar=
ea */
+    assert_false(validate_packet_id_window(&rel, 0x80000001));
+    =
assert_true(validate_packet_id_window(&rel, 0x7fffffff));
+    assert_true(=
validate_packet_id_window(&rel, 0x7ffffff5));
+    assert_false(validate_pa=
cket_id_window(&rel, 0x7ffffff4));
+
+    rel=2Epacket_id =3D 0xFFFFFFFD;
+=
    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFD));
+    assert_=
false(validate_packet_id_window(&rel, 0));
+    assert_false(validate_packe=
t_id_window(&rel, 1));
+    assert_false(validate_packet_id_window(&rel, 0x=
FFFFFFFE));
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFF));=

+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF3));
+    assert=
_true(validate_packet_id_window(&rel, 0xFFFFFFF2));
+    assert_false(valid=
ate_packet_id_window(&rel, 0xFFFFFFF1));
+
+    rel=2Epacket_id =3D 500;
+ =
   assert_false(validate_packet_id_window(&rel, 501));
+    assert_true(val=
idate_packet_id_window(&rel, 497));
+    assert_true(validate_packet_id_win=
dow(&rel, 500 - (RELIABLE_CAPACITY - 1)));
+    assert_false(validate_packe=
t_id_window(&rel, 500 - RELIABLE_CAPACITY));
+}
+
+
 int
 main(void)
 {
@@ =
-295,7 +342,8 @@
                                         test_packet_id_wr=
ite_setup,
                                         test_packet_id_write_te=
ardown),
         cmocka_unit_test(test_get_num_output_sequenced_available)=
,
-        cmocka_unit_test(test_copy_acks_to_lru)
+        cmocka_unit_tes=
t(test_copy_acks_to_lru),
+        cmocka_unit_test(test_packet_id_window)
=
 
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
909?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id=
: I944478767b52a1b9bf6a65373ce0544c69cb1012
Gerrit-Change-Number: 1909
Gerr=
it-PatchSet: 4
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer=
: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-CC: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--Zh2zER7/byU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>MaxF <strong>uploaded patch set #4=
</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1909?usp=3Demail">View Change</a></p><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ignore acks =
for packets that cannot be outstanding<br><br>This ignores acks for pids ou=
tside the send window, i=2Ee=2E for packets<br>that have either not been se=
nt out yet or already left the window=2E<br>Nothing outside that window can=
 be outstanding, so such acks can only<br>be used to manipulate the state o=
f the send buffer=2E<br><br>Comparing the pid of an outstanding packet agai=
nst the acked pid needs<br>to be wraparound aware as well=2E Otherwise a pe=
er can ack a pid from the<br>lower half of the id space, which passes the w=
indow check above, and<br>still increment n_acks on every outstanding packe=
t, forcing an early<br>retransmit after N_ACK_RETRANSMIT such acks=2E<br><b=
r>Github: OpenVPN/openvpn-private-issues#161<br>Reported-By: Mark Bregman (=
Fox-IT) &lt;mark=2Ebregman@fox-it=2Ecom&gt;<br>CVE: 2026-84732<br>Change-Id=
: I944478767b52a1b9bf6a65373ce0544c69cb1012<br>Signed-off-by: Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>(cherr=
y picked from commit d988ef4508e63b28c8e3efcb9f62eb8c836907fe)<br>---<br>M =
src/openvpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M tests/unit_test=
s/openvpn/test_packet_id=2Ec<br>3 files changed, 100 insertions(+), 9 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/09/1909/4</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/reliabl=
e=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index babe4c8=2E=2Ed0ae3cc=
 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ =
b/src/openvpn/reliable=2Ec</span><br><span>@@ -404,15 +404,36 @@</span><br>=
<span>     return true;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+validate_packet_id_window(struct reliable *rel, pa=
cket_id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return reliable_=
pid_min(pid, rel-&gt;packet_id)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+           &amp;&amp; reliable_pid_min(subtract_pid(rel-&gt;pac=
ket_id, RELIABLE_CAPACITY), pid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /* del acknowledged items from send buf */</span><br><span> v=
oid</span><br><span> reliable_send_purge(struct reliable *rel, const struct=
 reliable_ack *ack)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int i, j;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    for (i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int out_of_window =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_type firs=
t_out_of_window =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; ack-&gt;len; ++i)</span><br><span>     {</span><br><span>    =
     packet_id_type pid =3D ack-&gt;packet_id[i];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        for (j =3D 0; j &lt; rel-&gt;size; ++j)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!validate_packet_id_window(rel, pid))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (out_of_window =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                first_o=
ut_of_window =3D pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        out_of_window++;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            continue;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D=
 0; j &lt; rel-&gt;size; ++j)</span><br><span>         {</span><br><span>  =
           struct reliable_entry *e =3D &amp;rel-&gt;array[j];</span><br><s=
pan>             if (e-&gt;active &amp;&amp; e-&gt;packet_id =3D=3D pid)</s=
pan><br><span>@@ -432,16 +453,27 @@</span><br><span> #endif</span><br><span=
>                 e-&gt;active =3D false;</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (e-&=
gt;active &amp;&amp; e-&gt;packet_id &lt; pid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (e-&gt;active &amp;&amp; reliable_pid_min(e-&gt;pack=
et_id, pid))</span><br><span>             {</span><br><span>               =
  /* We have received an ACK for a packet with a higher PID=2E Either</span=
><br><span>                  * we have received ACKs out of or order or the=
 packet has been</span><br><span>                  * lost=2E We count the n=
umber of ACKs to determine if we should</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                 * resend it early=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 * resend it early=
=2E The comparison needs to be wraparound aware,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                 * otherwise a peer can inflat=
e n_acks with an ACK for a pid from</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 * the lower half of the id space and force=
 a retransmit=2E */</span><br><span>                 e-&gt;n_acks++;</span>=
<br><span>             }</span><br><span>         }</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (out_of_window &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        (void)first_out_of_window; /* dms=
g might not generate code */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        dmsg(D_REL_LOW, &quot;ACK contained %u ids outside the sen=
d window, &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          &quot;first was &quot; packet_id_format,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+             out_of_window, (packet_id_print=
_type)first_out_of_window);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span> }</span><br><span> </span><br><span> #ifdef =
ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/reliable=2Eh b/src/op=
envpn/reliable=2Eh</span><br><span>index 5877f20=2E=2Ecdd33c8 100644</span>=
<br><span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/=
reliable=2Eh</span><br><span>@@ -106,9 +106,9 @@</span><br><span> {</span><=
br><span>     int size;</span><br><span>     interval_t initial_timeout;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_type packe=
t_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int offset; =
/**&lt; Offset of the bufs in the reliable_entry array */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    bool hold; /* don&#39;t xmit until =
reliable_schedule_now is called */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    packet_id_type packet_id; /**&lt; Packet ID for the next=
 packet to be sent out=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int offset;               /**&lt; Offset of the bufs in the re=
liable_entry array */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool hold;                /* don&#39;t xmit until reliable_schedule_n=
ow is called */</span><br><span>     struct reliable_entry array[RELIABLE_C=
APACITY];</span><br><span> };</span><br><span> </span><br><span>@@ -193,6 +=
193,17 @@</span><br><span> }</span><br><span> </span><br><span> /**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * check that pid is inside=
 the window of possible outstanding packets</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * of size RELIABLE_CAPACITY, ie inside the range</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * [rel-&gt;packet_id=
 - RELIABLE_CAPACITY, rel-&gt;packet_id)=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * rel-&gt;packet is the *next* packet id to be sent out, so it is n=
ot</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * included in th=
e valid range=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+validate_packet_id_window(struct re=
liable *rel, packet_id_type pid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span>  * Returns the number of packets that need to be acked=2E</=
span><br><span>  *</span><br><span>  * @param ack The acknowledgment struct=
ure to check=2E</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span=
>index ff3f788=2E=2Ea27bd6d 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_packet_id=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_packet_id=2Ec</span><br><span>@@ -271,6 +271,53 @@</span><br><span>     =
assert_memory_equal(mru_ack=2Epacket_id, expected_ack=2Epacket_id, sizeof(e=
xpected_ack=2Epacket_id));</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_packet_id_window(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_packet_id_win=
dow(&amp;rel, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* packet id 1 i=
s outside the window as it is the *next* packet id */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_id_windo=
w(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* wrapped around =
packet id, &quot;-2&quot; */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFFD));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* wrapped around packet id, &quot;=
-10&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF6));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* wrapped around packet id, &quot;-11&quot; */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(valida=
te_packet_id_window(&amp;rel, 0xFFFFFFF5));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(validate_packet_id_window(&amp;rel=
, 0x80000000));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D=
 0x80000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* near the signed/usi=
gned integer area */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(validate_packet_id_window(&amp;rel, 0x80000001));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_pa=
cket_id_window(&amp;rel, 0x7fffffff));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(validate_packet_id_window(&amp;rel, 0x7f=
fffff5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(validate_packet_id_window(&amp;rel, 0x7ffffff4));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    rel=2Epacket_id =3D 0xFFFFFFFD;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet_id_windo=
w(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(validate_packet_id_window(&amp;rel, 0));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packe=
t_id_window(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFFE));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(vali=
date_packet_id_window(&amp;rel, 0xFFFFFFFF));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(validate_packet_id_window(&amp;re=
l, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF2));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(validate_packet=
_id_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
rel=2Epacket_id =3D 500;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(validate_packet_id_window(&amp;rel, 501));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(validate_packe=
t_id_window(&amp;rel, 497));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(validate_packet_id_window(&amp;rel, 500 - (RELIABL=
E_CAPACITY - 1)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_false(validate_packet_id_window(&amp;rel, 500 - RELIABLE_CAPACITY=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</sp=
an><br><span> {</span><br><span>@@ -295,7 +342,8 @@</span><br><span>       =
                                  test_packet_id_write_setup,</span><br><sp=
an>                                         test_packet_id_write_teardown),=
</span><br><span>         cmocka_unit_test(test_get_num_output_sequenced_av=
ailable),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmoc=
ka_unit_test(test_copy_acks_to_lru)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_copy_acks_to_lru),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
packet_id_window)</span><br><span> </span><br><span>     };</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail">change 1909</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1909?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I944478=
767b52a1b9bf6a65373ce0544c69cb1012 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1909 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 4 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-filli=
nger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Zh2zER7/byU=--


--===============2615224540512387051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2615224540512387051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2615224540512387051==--

