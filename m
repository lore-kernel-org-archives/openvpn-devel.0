Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C7C79FAD
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0UxqmErfPSGJhpfiaMjvBLXW3sXnvpcQQtxaWKquJk=; b=TdNF5/YkckE4BFgwJmgq8zCudT
	MAzX1/lz9YzA7OgcPbhCWDAPP+dFJWZZfL4zrUkVjpDGO7t1zqSgH5u4X4DQWdCPaly9ARxS8Gj37
	zgpSaxQMCFn8SASHBhpHBiHpFTpFp2FOjAKAiw9E/AlYltW/6HSyR4YcU6NWZjb0iBic=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Dul-00080c-8f;
	Wed, 09 Sep 2026 08:44:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Duj-00080V-Vv
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:44:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Dm23bloJaRoxcif9pk6a4zxbuUMYLaAmM1tUvAPQd8c=; b=VjRPMvQsELKUiOaarLv46VuD0+
 /0iaAc5/cBHIndJ8Sbhz3Egw1GVPlRU48imVNU7SNPP87ff8Q4WhenACukHf1HU2vGdm0rZG4EF18
 kWqkDoqMbanCfAsiFV/KKMfqjs59iZO7xF+/hlZ5IOvMe2arNxx+GSRn06eucI0E24LU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dm23bloJaRoxcif9pk6a4zxbuUMYLaAmM1tUvAPQd8c=; b=a
 RrW6WXtldfa+bGZxDhon/y8qSyaeUS/YHQyoHObhXA+3G0RFoanQc4nnajG45XkkkNo5AscYD2Y0L
 dcMjMGxwNwPwrPqVOtVYRlLkeYip1IotMr0MqakPW3EuWnxt2rRPiRysRxxhxFeeiJNDZ1WxtGSF0
 lx3c43YIppovR0vw=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Duj-0002pW-2s for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:44:18 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso46667435e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788943450; x=1789548250; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dm23bloJaRoxcif9pk6a4zxbuUMYLaAmM1tUvAPQd8c=;
 b=IrHYGJKHkcuk8ubsbE7XbnwGAROkWhgg5Xy+uT+Ntg7G0VmaRFzyYUya59y/bjOmto
 vu+7IR0SNfZRIg+BxCQb8FtfQb6ttK1SBOOCfmb6f2nznNk08z+VwtCec/TzjeCvQnXS
 axUrh0f28g/Pmdlm2+8NP770G2+Snd9fYIvNORlAI4Ady/5cjTqL0omHCJzSBymJDtyV
 ukxBvIUIX7cHS8Yl4qZQjS9MOQ0y6/yMRPvamZf8r4XeL29f6CwTdmj0oOE/BX2s5b9b
 DVSzinJzqT2Ku3xR22Qr3b4Drw7AoG2UqvLnJWZUeJ8lRIoD8WxJ60xaN39KOMF9DWPc
 R/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943450; x=1789548250;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dm23bloJaRoxcif9pk6a4zxbuUMYLaAmM1tUvAPQd8c=;
 b=Uu5cwIUtlmSjDL1Kjyx/GsiAhlW1u2pUYesx4oqE/83UNoGdykuom54fIBJe6ZUu3K
 UJ3s7B7NvqdCxlUFcJJJZZCDkZY4Ix78bZIijPE1BLKm9A9WbR28NdtibyBHXJRP5LoU
 OFsDyvi4PwEUVjluVUiZKjWWucxjO42wHNYNug+0VILwsbPDom1oNmu4EH3py+LYNCt+
 saiEdUvFlHripYrGNYzf7zXtvJ9lcVEGJbf1OuC8E4SnlEv96KOIvIlY4brF6aGwlcoI
 yDkHmU/EmUv/bSdX8v9/AP3dO7BOa2GprGHoGp/Pq7Bj/9l9+J9V0Y8/pjlak50AHdi9
 SPkA==
X-Gm-Message-State: AFuF++m3u8PxPMBLXH5IgUfxO2mZBpMOFbfQmCayC25Q2rbHq8EkB+Nv
 9wKl1DRPTvzNRa+1BfJAlarJgZ5KM/TZKJEs1yAyB7JWG/B9Tg+dIgc24/HiUky7xBTgZYyTLs/
 HdPXBag18FZ0hl9I4zjgZwbWyyn7ZyuBolyw7SkBNPOu7bvluieGJDgVCBU3OBqV9jP8UtIh5nw
 bOGsGhag==
X-Gm-Gg: AYBFou1vfQB+Dgd4tZj/PM8cCORtyDMV/Bo32Ge18mbcSkZTtRjo5QOmNCD5Ajv6Nj1
 Ws06e6srb/bVCIhdB5GOk6D/FXIyR2fcNZww4EZFBUhNHsD7CnMcL2cAp/pah3KEC60LNNWTQQR
 KYbKHJa2sSLTBRl1vx9ugG0CrMxTUZgPSu4UgZJk4JE1UMWdRppEWomP7OutAi7ORnnybXkkKRh
 /FDNpyuUab6huSiOoet12voxhM6sZ5yQEXDV8vu+VUK1/Koq2c3VugoSzAiM0Ej3p1kbhsuuGA7
 gCfwoIOc4LewgtWjRmJ9rHjxG/bYrkfd0SrobiaP0AjJlZLNIJjbd0M1MTN8V3+xj9R+LnQtqWm
 6bxyA/BuoUdpqmj4s1W439FYhN9NXECNn4RXjt/sW6fxeLisAFTgBpf4Nt1PIPEitoAUYoTNwH0
 AtyiXd1OsAQhHuoqqy/+QHlJwar59IoIXPATBbkRwl57+w7UEbGo4QuIvUXpX4bME7/o3lJQCna
 /b5eDjcQJW/nNQWHPirtC4Zhe7AMuKFQHHlXfUX3nGihD+EEmlXGqT7WnCD7wHGAIm2g3d1zwJ8
 gtvL0geLmFCISurHy6Kx7GLe7EKDsxHmrKWQdbLRm8GFhYK9JzCah28rt1wxU5YyfJmIQk1q
X-Received: by 2002:a05:600d:3:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-49d1eee73c8mr37054105e9.15.1788943450246; 
 Wed, 09 Sep 2026 01:44:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm593211705e9.1.2026.09.09.01.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:44:09 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 08:44:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
X-Gerrit-Change-Number: 1909
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1909?usp=email>
X-Gerrit-Commit: 3672d5104768fe3aa6ece4b22f0590c7f7ddcab7
In-Reply-To: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
References: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MzA3MDAwLkk5NDQ0Nzg3NjdiNTJhMWI5YmY2YTY1MzczY2UwNTQ0YzY5Y2IxMDEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <643b290cd27931c1e7b05e3140a8499595c2de14-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Duj-0002pW-2s
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
Content-Type: multipart/mixed; boundary="===============0367684305079220127=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0367684305079220127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aWeYZNYvhkI="; charset=UTF-8

--aWeYZNYvhkI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

Hello plaisthos, razvanc,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1909?usp=3Demail

to look at the new patch set (#=
2)=2E


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
M dev-tools/uncrus=
tify=2Econf
M src/openvpn/options=2Ec
M src/openvpn/reliable=2Ec
M src/open=
vpn/reliable=2Eh
M tests/unit_tests/openvpn/test_packet_id=2Ec
5 files chan=
ged, 102 insertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/09/1909/2

diff --git a/dev-tools/uncrust=
ify=2Econf b/dev-tools/uncrustify=2Econf
index 325f310=2E=2E727ba86 100644
=
--- a/dev-tools/uncrustify=2Econf
+++ b/dev-tools/uncrustify=2Econf
@@ -51,=
7 +51,7 @@
 
 # Always use scoping braces for conditionals
 mod_full_brace_=
if=3Dadd
-mod_full_brace_if_chain=3Dfalse
+mod_full_brace_if_chain=3D0
 mod=
_full_brace_while=3Dadd
 mod_full_brace_for=3Dadd
 mod_full_brace_do=3Dadd
=
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 873efa=
f=2E=2E56041bb 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/optio=
ns=2Ec
@@ -9185,7 +9185,7 @@
          * timeout is already way too much an=
yway */
         if (options->tls_timeout < 1 || options->tls_timeout > REL=
IABLE_MAX_INITIAL_TIMEOUT)
         {
-            msg(msglevel, "tls_timeo=
ut: Must be an integer between %d and %d, not %lld",
+            msg(msgle=
vel, "tls_timeout: Must be an integer between %d and %d, not %d",
         =
        1, RELIABLE_MAX_INITIAL_TIMEOUT, options->tls_timeout);
           =
  goto err;
         }
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/=
reliable=2Ec
index babe4c8=2E=2Ed0ae3cc 100644
--- a/src/openvpn/reliable=
=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -404,15 +404,36 @@
     return true;=

 }
 
+int
+validate_packet_id_window(struct reliable *rel, packet_id_type =
pid)
+{
+    return reliable_pid_min(pid, rel->packet_id)
+           && re=
liable_pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+}
+
=
 /* del acknowledged items from send buf */
 void
 reliable_send_purge(stru=
ct reliable *rel, const struct reliable_ack *ack)
 {
-    int i, j;
-    fo=
r (i =3D 0; i < ack->len; ++i)
+    unsigned int out_of_window =3D 0;
+    =
packet_id_type first_out_of_window =3D 0;
+
+    for (int i =3D 0; i < ack-=
>len; ++i)
     {
         packet_id_type pid =3D ack->packet_id[i];
-     =
   for (j =3D 0; j < rel->size; ++j)
+
+
+        if (!validate_packet_id_w=
indow(rel, pid))
+        {
+            if (out_of_window =3D=3D 0)
+     =
       {
+                first_out_of_window =3D pid;
+            }
+    =
        out_of_window++;
+            continue;
+        }
+
+        for (=
int j =3D 0; j < rel->size; ++j)
         {
             struct reliable_en=
try *e =3D &rel->array[j];
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: release/2=2E6
Gerrit-Change-Id: I944478767b52a1b9bf6a65373ce0544c6=
9cb1012
Gerrit-Change-Number: 1909
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <m=
ax@max-fillinger=2Enet>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@=
mailbox=2Eorg>

--aWeYZNYvhkI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>MaxF <strong>uploaded patch set #2=
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
dev-tools/uncrustify=2Econf<br>M src/openvpn/options=2Ec<br>M src/openvpn/r=
eliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M tests/unit_tests/openvpn/tes=
t_packet_id=2Ec<br>5 files changed, 102 insertions(+), 11 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/09/1909/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/dev-tools/uncrustify=2Econf b/d=
ev-tools/uncrustify=2Econf</span><br><span>index 325f310=2E=2E727ba86 10064=
4</span><br><span>--- a/dev-tools/uncrustify=2Econf</span><br><span>+++ b/d=
ev-tools/uncrustify=2Econf</span><br><span>@@ -51,7 +51,7 @@</span><br><spa=
n> </span><br><span> # Always use scoping braces for conditionals</span><br=
><span> mod_full_brace_if=3Dadd</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-mod_full_brace_if_chain=3Dfalse</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+mod_full_brace_if_chain=3D0</span><br><span> mod_full=
_brace_while=3Dadd</span><br><span> mod_full_brace_for=3Dadd</span><br><spa=
n> mod_full_brace_do=3Dadd</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 873efaf=2E=2E56041bb 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -9185,7 +9185,7 @@</span><br><spa=
n>          * timeout is already way too much anyway */</span><br><span>   =
      if (options-&gt;tls_timeout &lt; 1 || options-&gt;tls_timeout &gt; RE=
LIABLE_MAX_INITIAL_TIMEOUT)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;tls_timeou=
t: Must be an integer between %d and %d, not %lld&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;tls_ti=
meout: Must be an integer between %d and %d, not %d&quot;,</span><br><span>=
                 1, RELIABLE_MAX_INITIAL_TIMEOUT, options-&gt;tls_timeout);=
</span><br><span>             goto err;</span><br><span>         }</span><b=
r><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</s=
pan><br><span>index babe4c8=2E=2Ed0ae3cc 100644</span><br><span>--- a/src/o=
penvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><b=
r><span>@@ -404,15 +404,36 @@</span><br><span>     return true;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_p=
acket_id_window(struct reliable *rel, packet_id_type pid)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return reliable_pid_min(pid, rel-&gt;packet_id)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; r=
eliable_pid_min(subtract_pid(rel-&gt;packet_id, RELIABLE_CAPACITY), pid);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* del acknowledged i=
tems from send buf */</span><br><span> void</span><br><span> reliable_send_=
purge(struct reliable *rel, const struct reliable_ack *ack)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i, j;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; a=
ck-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 unsigned int out_of_window =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    packet_id_type first_out_of_window =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span>=
<br><span>     {</span><br><span>         packet_id_type pid =3D ack-&gt;pa=
cket_id[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fo=
r (j =3D 0; j &lt; rel-&gt;size; ++j)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!validat=
e_packet_id_window(rel, pid))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (out_of_window =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                first_out_of_window =3D pid;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            out_of_window++;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (int j =3D 0; j &lt; rel-&gt;size; ++j)</span><=
br><span>         {</span><br><span>             struct reliable_entry *e =
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
style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</b=
ody></html>
--aWeYZNYvhkI=--


--===============0367684305079220127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0367684305079220127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0367684305079220127==--

