Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E793CA9EBD
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xcbksxlQLy29KEjdVbaWN2fByBvBRNEYxaXHVims0nM=; b=ks9lMcea2mOQQFue1y17OWPuf/
	plAVl32DfO0VCy9T2pu3FKFb/vYjsV0wOneugDEIEnx/aVbbGORzuF9AcK0j7EgwOz1J9F0MmJc2G
	5pGGO3xkMvaNxl1gB0AYCsDcnST1WcQWAX83Xhxr0P9GcitdOexBpMA4fyY0ixYsOzvs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFw4v-00056g-P7;
	Sun, 11 Oct 2026 16:07:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFw4v-00056X-2U
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:07:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZzaOU6+nQrEjzIK+AFQXCWpW+XOG1JdzRcFDLoIssRA=; b=KADYkU7qvIoYNy8nPxAHbuRvg7
 aD0CGAqEi5hx2sJlZTA+OTky2I++g4u5PmKN093n26kIDmIt235WqYRRElPwgVfRQJvTyZs6TKRwx
 xnPZQ+wbU7doXzYrvgbm6yQGsLmVlXMvdlYaP7NDn9FCLm7oq759yHF24vij+VcDe/ew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZzaOU6+nQrEjzIK+AFQXCWpW+XOG1JdzRcFDLoIssRA=; b=c
 269Ms36YHORFq3zrVyCBWEaLzGkv/OxM450TAp6jp7FLUdu+6EVBNFwJGmIuJj89zp19QYX8ICOfO
 vNP6+eQu3X0Jf/qawjQdo/7mKm5nClg3s2ph4ThktwIFq4c1UaMx+cgO9Q12Isk5rHaBJ6h3vOyQk
 kUEvfegnDxpe1gY0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFw4t-000796-O9 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:07:13 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so6937445e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791734825; x=1792339625; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZzaOU6+nQrEjzIK+AFQXCWpW+XOG1JdzRcFDLoIssRA=;
 b=a0+Ze2Ux/BbgzFXQ/IpOGVmjW9mOjSreGssZgDzaduLQ7wgo/FghcEOJDdas1vIaJG
 xeSx+bgxBJBM0qO13+VWEFfaDpwitQKTSYldVR3VW+YxXDNvpHtexbO8T8U15ZCcu4cp
 x7c+sibYY1Vz8hz+3eozmOXUlEHDZVllopsXgUmJRiZiqqmQUBdAB78kUPGWhY91BY+o
 wsRhvzjwUVS7zuqyg7xVZEv9Jo9DccfqTT+N5tiDEUnezNVQLfCbkIGA/z0QkaBIIfWB
 8aUd3VoAMNK755Ejk660LsyU6QVtinRKnMCxY0EpmA/WwMgP4BXH5nlBL8Tev9hAVhzG
 YFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791734825; x=1792339625;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZzaOU6+nQrEjzIK+AFQXCWpW+XOG1JdzRcFDLoIssRA=;
 b=bV1akbU1DzylVX7uJvo1/zu6N7mdQrMuStRv/LUtlaM4XK8XuZt41NfmhbmYb6Nejj
 X6RtbiYoC2ZCIHWNnpk346eDrdhwahXFo0BYyLUh7A5L1lsigS/FpTJJTThkuAyZmt/h
 QuY/dOeJsd3s+BUIFe+y8YRV9fODxkGEBE3jgPiqG4Y7xntUvFGdaOX7BF56SUYc90Dv
 qeeCgw1jN0OjTFUlCbI67PVgmKlBgYtKjJaYG80q+oXWSjpzZZtIKpT4FPW61DI814H0
 BSyKjIteg1CerCiG+Kqmhwury2Tg1/CQu9+wMKmV3lSewqi2kyg6KH4GgmN0TNP0x/fI
 fsBw==
X-Gm-Message-State: AFq9FYLka9C07ZzpnAqbH32xEs55RiBG3j6bQG0ljFPdbncCS5tDB5tn
 xAN0DtUBH3LktcbP1Yojr8kFYda7lBaxef6w47TyzIkxP/wx3Q8BXSr91Q6FuOQU+PhwQKyTCnA
 ohAzHn4RiA5rdvaFeE9VSs4pGA5kKKL8EZ9eFsVkIP4EzXb8IdEjKyq/d4z7+7ls3JvnB
X-Gm-Gg: AYBFou3ZRoSD2X3PHt8nr/aQqagUtb6ifeKk1gNY8extnkOfQ1ykRH4SgvdNUNk5dny
 1XWlr61wMRt/TS6gsz3jjGjMM5x9GfomgryVMl5siUX1H0+ySwVumN92kF1xPu+1D3/ILq52bMp
 T6DNH/2Mo7Yx52Ve1QrRnMXb2FJoC72uxB8cEi32IMCvUkgNjv0NXsnoKv3weBnyunB2BVE7hwA
 KgcBddq7p3Hwypu7U1JMdS7XOSdWllLsID8nOYqQtQEYGwp0EWO+RrpAiAh6FSpx/crDyYb7E0k
 9SsSUulZ+k4OQbWfABaHZGlx9Dh0QECdj1M+ZiwbQZZl01+1hCq4ugfD6LCSXB+G3WSlngh1GHo
 OBv9xjg2zllOIz50uoVW+oWBzaD+w8RkVe2rHO336ZCMZzUd4OzSiLctFXp6pHV7ogvojuLmVGX
 viK+gSC7HqEgEdfL3Zgkghvqdm4HpfXgxXOkbgq4zhf43qigD3p+qQgR1Ti0nQUNXq9vb1TKap6
 FjhfaBYX1UEuNt/fkwnCa4xc1iuMnY8x+oFVCFDE09PmDKFySRzHhYuY8qTuWA4c0nLaliTK41g
 3oy802cM3ItTk4Fq0KmS0D4H6yvio7GQN71314iW4cmz1481Ox6InQxAshYd
X-Received: by 2002:a05:600c:3b08:b0:4a0:da23:e06d with SMTP id
 5b1f17b1804b1-4a18e4a380bmr135907175e9.10.1791734824683; 
 Sun, 11 Oct 2026 09:07:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm348857115e9.8.2026.10.11.09.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:07:04 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 16:07:02 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
X-Gerrit-Change-Number: 1901
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1901?usp=email>
X-Gerrit-Commit: 01619660cc1c1c56c999c8ec8de1b23c63580a9b
In-Reply-To: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
References: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLkk2M2MxNDEwNzVkODlhZTZhMDc4NzJlNzg0ZmFmZjgxN2RkMzM1MGIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e6c1331c70ca0b8c8fc0d0d728ce48eab5c6c7f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFw4t-000796-O9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: fix the
 send window width
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1626516989742614838=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1626516989742614838==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GeUaJGUXzdI="; charset=UTF-8

--GeUaJGUXzdI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1901?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe


Change subject: reliable: fix the send wi=
ndow width
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

r=
eliable: fix the send window width

The check accepted the 11 ids below rel=
->packet_id where its documentation
said RELIABLE_CAPACITY=2E Twelve is rig=
ht: reliable_get_buf_output_sequenced()
issues an id while it is less than =
rel->size beyond the oldest
unacknowledged one, so an entry can sit a full =
rel->size below
rel->packet_id, and rel->size may be RELIABLE_CAPACITY=2E

=
No effect today, TLS_RELIABLE_N_SEND_BUFFERS being 6=2E Raising the send
bu=
ffer count to RELIABLE_CAPACITY, which reliable_init() permits, would
have =
discarded the ACK for the oldest outstanding packet=2E

The width is now th=
e extent passed to reliable_pid_in_range() rather
than a comparison operato=
r=2E

Also renames validate_packet_id_window() to reliable_pid_in_send_wind=
ow(),
returning bool and taking a const struct reliable * like its neighbou=
rs,
and the same const on reliable_get_num_output_sequenced_available()=2E
=

Three doc comments described what the code does not do: the window
bounds,=
 reliable_wont_break_sequentiality()'s reference id, subtract_pid()'s
argum=
ent order=2E reliable_mark_active_incoming() now states the
precondition it=
 asserts=2E

Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
Signed-of=
f-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1901
Message-Id: <20261008205045=2E28233-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg39795=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M tests/unit_tests/open=
vpn/test_packet_id=2Ec
3 files changed, 68 insertions(+), 54 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/1901=
/4

diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index =
645fbfd=2E=2Ec268cce 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvp=
n/reliable=2Ec
@@ -38,8 +38,9 @@
 
 #include "memdbg=2Eh"
 
-/* calculates =
test - base while allowing for base or test wraparound=2E test is
- * assum=
ed to be higher than base */
+/* calculates test - base while allowing for =
base or test wraparound=2E The
+ * result is only meaningful compared again=
st a bound: on its own it does not
+ * say which id came first=2E */
 stati=
c inline packet_id_type
 subtract_pid(const packet_id_type test, const pack=
et_id_type base)
 {
@@ -356,12 +357,11 @@
     return true;
 }
 
-int
-vali=
date_packet_id_window(struct reliable *rel, packet_id_type pid)
+bool
+reli=
able_pid_in_send_window(const struct reliable *rel, packet_id_type pid)
 {
=
-    const packet_id_type dist =3D subtract_pid(rel->packet_id, pid);
-
-  =
  return dist > 0 && dist < RELIABLE_CAPACITY;
+    return reliable_pid_in_=
range(pid, subtract_pid(rel->packet_id, RELIABLE_CAPACITY),
+              =
                   RELIABLE_CAPACITY);
 }
 
 /* del acknowledged items from=
 send buf */
@@ -376,7 +376,7 @@
         packet_id_type pid =3D ack->packe=
t_id[i];
 
 
-        if (!validate_packet_id_window(rel, pid))
+        if=
 (!reliable_pid_in_send_window(rel, pid))
         {
             if (out_o=
f_window =3D=3D 0)
             {
@@ -566,7 +566,7 @@
 }
 
 int
-reliable_g=
et_num_output_sequenced_available(struct reliable *rel)
+reliable_get_num_o=
utput_sequenced_available(const struct reliable *rel)
 {
     return rel->s=
ize - (int)reliable_oldest_active_distance(rel);
 }
diff --git a/src/openvp=
n/reliable=2Eh b/src/openvpn/reliable=2Eh
index 04f3372=2E=2E534feb3 100644=

--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -190,15 +=
190,20 @@
 }
 
 /**
- * check that pid is inside the window of possible out=
standing packets
- * of size RELIABLE_CAPACITY, ie inside the range
- * [re=
l->packet_id - RELIABLE_CAPACITY, rel->packet_id)=2E
+ * Check whether pid =
is one of the RELIABLE_CAPACITY ids below rel->packet_id,
+ * and so could =
still be outstanding=2E rel->packet_id is the *next* id to be
+ * sent, so =
it is not itself in the window=2E
  *
- * rel->packet is the *next* packet =
id to be sent out, so it is not
- * included in the valid range=2E
+ * pid =
comes off the wire; all 2^32 values are handled=2E
+ *
+ * @param rel The r=
eliable structure holding this tunnel's sent packets=2E
+ * @param pid A pa=
cket ID from a received acknowledgment=2E
+ *
+ * @return
+ * @li True, if =
pid is inside the window=2E
+ * @li False, otherwise=2E
  */
-int
-validate=
_packet_id_window(struct reliable *rel, packet_id_type pid);
+bool reliable=
_pid_in_send_window(const struct reliable *rel, packet_id_type pid);
 
 /**=

  * Returns the number of packets that need to be acked=2E
@@ -305,14 +310=
,15 @@
  * Check that a received packet's ID can safely be stored in
  *   =
  the reliable structure's processing window=2E
  *
- * This function check=
s the difference between the received packet's ID
- * and the lowest non-ac=
knowledged packet ID in the given reliable
- * structure=2E  If that differ=
ence is larger than the total number of
- * packets which can be stored, th=
en this packet cannot be stored safely,
- * because the reliable structure =
could possibly fill up without leaving
- * room for all intervening packets=
=2E  In that case, this received packet
- * could break the reliable struct=
ure's sequentiality, and must therefore
- * be discarded=2E
+ * Checks the =
received packet's ID against rel->packet_id, the next ID the
+ * reliabilit=
y layer expects to hand upwards=2E One too far ahead could fill the
+ * str=
ucture without leaving room for the intervening packets, so it is
+ * disca=
rded=2E
+ *
+ * IDs numerically below rel->packet_id are accepted here, an =
absolute
+ * comparison that an ID from before a wraparound does not pass=
=2E
+ * reliable_not_replay() rejects them, and they are still acknowledged=
 so a
+ * peer whose ACK was lost stops retransmitting=2E
  *
  * @param re=
l The reliable structure for handling this VPN tunnel's
  *     received pa=
ckets=2E
@@ -354,6 +360,10 @@
  * Mark the %reliable entry associated with =
the given buffer as active
  * incoming=2E
  *
+ * pid must be less than re=
l->size ahead of rel->packet_id=2E This is asserted,
+ * so run reliable_wo=
nt_break_sequentiality() and reliable_not_replay()
+ * first=2E
+ *
  * @pa=
ram rel The reliable structure associated with this packet=2E
  * @param bu=
f The buffer into which the packet has been copied=2E
  * @param pid The pa=
cket's packet ID=2E
@@ -446,7 +456,7 @@
  *  @return the number of buffer t=
hat are available for sending without
  *             breaking ack sequence=

  * */
-int reliable_get_num_output_sequenced_available(struct reliable *r=
el);
+int reliable_get_num_output_sequenced_available(const struct reliable=
 *rel);
 
 /**
  * Mark the reliable entry associated with the given buffer=
 as
diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_t=
ests/openvpn/test_packet_id=2Ec
index ac6c710=2E=2E245c357 100644
--- a/tes=
ts/unit_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/tes=
t_packet_id=2Ec
@@ -331,44 +331,50 @@
     struct reliable rel =3D { 0 };
 =
    rel=2Epacket_id =3D 1;
 
-    assert_true(validate_packet_id_window(&re=
l, 0));
+    assert_true(reliable_pid_in_send_window(&rel, 0));
 
     /* p=
acket id 1 is outside the window as it is the *next* packet id */
-    asse=
rt_false(validate_packet_id_window(&rel, 1));
+    assert_false(reliable_pi=
d_in_send_window(&rel, 1));
 
     /* wrapped around packet id, "-2" */
-  =
  assert_true(validate_packet_id_window(&rel, 0xFFFFFFFD));
+    assert_tru=
e(reliable_pid_in_send_window(&rel, 0xFFFFFFFD));
 
     /* wrapped around =
packet id, "-10" */
-    assert_true(validate_packet_id_window(&rel, 0xFFFF=
FFF6));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF6));
 
=
-    /* wrapped around packet id, "-11" */
-    assert_false(validate_packe=
t_id_window(&rel, 0xFFFFFFF5));
-    assert_false(validate_packet_id_window=
(&rel, 0x80000000));
+    /* wrapped around packet id, "-11": the oldest id=
 still in the window */
+    assert_true(reliable_pid_in_send_window(&rel, =
0xFFFFFFF5));
+
+    /* one further back is outside it */
+    assert_false=
(reliable_pid_in_send_window(&rel, 0xFFFFFFF4));
+    assert_false(reliable=
_pid_in_send_window(&rel, 0x80000000));
 
     rel=2Epacket_id =3D 0x800000=
00;
 
     /* near the signed/usigned integer area */
-    assert_false(val=
idate_packet_id_window(&rel, 0x80000001));
-    assert_true(validate_packet=
_id_window(&rel, 0x7fffffff));
-    assert_true(validate_packet_id_window(&=
rel, 0x7ffffff5));
-    assert_false(validate_packet_id_window(&rel, 0x7fff=
fff4));
+    assert_false(reliable_pid_in_send_window(&rel, 0x80000001));
+=
    assert_true(reliable_pid_in_send_window(&rel, 0x7fffffff));
+    assert=
_true(reliable_pid_in_send_window(&rel, 0x7ffffff5));
+    assert_true(reli=
able_pid_in_send_window(&rel, 0x7ffffff4));
+    assert_false(reliable_pid_=
in_send_window(&rel, 0x7ffffff3));
 
     rel=2Epacket_id =3D 0xFFFFFFFD;
-=
    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFD));
-    assert_=
false(validate_packet_id_window(&rel, 0));
-    assert_false(validate_packe=
t_id_window(&rel, 1));
-    assert_false(validate_packet_id_window(&rel, 0x=
FFFFFFFE));
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFF));=

-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF3));
-    assert=
_true(validate_packet_id_window(&rel, 0xFFFFFFF2));
-    assert_false(valid=
ate_packet_id_window(&rel, 0xFFFFFFF1));
+    assert_false(reliable_pid_in_=
send_window(&rel, 0xFFFFFFFD));
+    assert_false(reliable_pid_in_send_wind=
ow(&rel, 0));
+    assert_false(reliable_pid_in_send_window(&rel, 1));
+   =
 assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFFE));
+    assert_f=
alse(reliable_pid_in_send_window(&rel, 0xFFFFFFFF));
+    assert_true(relia=
ble_pid_in_send_window(&rel, 0xFFFFFFF3));
+    assert_true(reliable_pid_in=
_send_window(&rel, 0xFFFFFFF2));
+    assert_true(reliable_pid_in_send_wind=
ow(&rel, 0xFFFFFFF1));
+    assert_false(reliable_pid_in_send_window(&rel, =
0xFFFFFFF0));
 
     rel=2Epacket_id =3D 500;
-    assert_false(validate_pa=
cket_id_window(&rel, 501));
-    assert_true(validate_packet_id_window(&rel=
, 497));
-    assert_true(validate_packet_id_window(&rel, 500 - (RELIABLE_C=
APACITY - 1)));
-    assert_false(validate_packet_id_window(&rel, 500 - REL=
IABLE_CAPACITY));
+    assert_false(reliable_pid_in_send_window(&rel, 501))=
;
+    assert_true(reliable_pid_in_send_window(&rel, 497));
+    assert_tru=
e(reliable_pid_in_send_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
+    a=
ssert_true(reliable_pid_in_send_window(&rel, 500 - RELIABLE_CAPACITY));
+  =
  assert_false(reliable_pid_in_send_window(&rel, 500 - (RELIABLE_CAPACITY +=
 1)));
 }
 
 
@@ -533,21 +539,19 @@
     return (packet_id_type)(p1 - p2) >=
=3D 0x80000000u;
 }
 
-/* one short of RELIABLE_CAPACITY, which is what the=
 code accepts today */
-#define CHARACTERIZED_SEND_WINDOW 11
-
 /* TLS_RELI=
ABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, which this
  * test=
 binary does not pull in */
 #define CHAR_N_SEND_BUFFERS    6
 #define CHAR=
_OPCODE_CONTROL_V1 4
 
-/* preserved: the ids validate_packet_id_window() a=
ccepts */
+/* introduced: the RELIABLE_CAPACITY ids below rel->packet_id=2E=

+ * validate_packet_id_window() stopped one short of that=2E */
 static bo=
ol
 ref_pid_in_send_window(const struct reliable *rel, packet_id_type pid)
=
 {
     const packet_id_type dist =3D (packet_id_type)(rel->packet_id - pid=
);
 
-    return dist >=3D 1 && dist <=3D CHARACTERIZED_SEND_WINDOW;
+    r=
eturn dist >=3D 1 && dist <=3D RELIABLE_CAPACITY;
 }
 
 /* preserved: relia=
ble_pid_in_range2() */
@@ -798,7 +802,7 @@
                 rel=2Epacket_id=
 =3D anchors[a];
 
                 assert_int_equal(ref_pid_in_send_window=
(&rel, ids[i]),
-                                 validate_packet_id_window=
(&rel, ids[i]) !=3D 0);
+                                 reliable_pid_in_s=
end_window(&rel, ids[i]));
             }
         }
     }

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I63c141075d89ae6a07872e784faff=
817dd3350b1
Gerrit-Change-Number: 1901
Gerrit-PatchSet: 4
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--GeUaJGUXzdI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1901?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">rel=
iable: fix the send window width<br><br>The check accepted the 11 ids below=
 rel-&gt;packet_id where its documentation<br>said RELIABLE_CAPACITY=2E Twe=
lve is right: reliable_get_buf_output_sequenced()<br>issues an id while it =
is less than rel-&gt;size beyond the oldest<br>unacknowledged one, so an en=
try can sit a full rel-&gt;size below<br>rel-&gt;packet_id, and rel-&gt;siz=
e may be RELIABLE_CAPACITY=2E<br><br>No effect today, TLS_RELIABLE_N_SEND_B=
UFFERS being 6=2E Raising the send<br>buffer count to RELIABLE_CAPACITY, wh=
ich reliable_init() permits, would<br>have discarded the ACK for the oldest=
 outstanding packet=2E<br><br>The width is now the extent passed to reliabl=
e_pid_in_range() rather<br>than a comparison operator=2E<br><br>Also rename=
s validate_packet_id_window() to reliable_pid_in_send_window(),<br>returnin=
g bool and taking a const struct reliable * like its neighbours,<br>and the=
 same const on reliable_get_num_output_sequenced_available()=2E<br><br>Thre=
e doc comments described what the code does not do: the window<br>bounds, r=
eliable_wont_break_sequentiality()&#39;s reference id, subtract_pid()&#39;s=
<br>argument order=2E reliable_mark_active_incoming() now states the<br>pre=
condition it asserts=2E<br><br>Change-Id: I63c141075d89ae6a07872e784faff817=
dd3350b1<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901<br>Message-Id: &lt;202610082=
05045=2E28233-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39795=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M tests/unit_tests/openvpn=
/test_packet_id=2Ec<br>3 files changed, 68 insertions(+), 54 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/01/1901/4</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/reliable=2Ec b/s=
rc/openvpn/reliable=2Ec</span><br><span>index 645fbfd=2E=2Ec268cce 100644</=
span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/ope=
nvpn/reliable=2Ec</span><br><span>@@ -38,8 +38,9 @@</span><br><span> </span=
><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* calculates test - base while all=
owing for base or test wraparound=2E test is</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * assumed to be higher than base */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* calculates test - base while all=
owing for base or test wraparound=2E The</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * result is only meaningful compared against a bound:=
 on its own it does not</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * say which id came first=2E */</span><br><span> static inline packet_=
id_type</span><br><span> subtract_pid(const packet_id_type test, const pack=
et_id_type base)</span><br><span> {</span><br><span>@@ -356,12 +357,11 @@</=
span><br><span>     return true;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-validate_packet_id_window(struct reliable *=
rel, packet_id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_p=
id_in_send_window(const struct reliable *rel, packet_id_type pid)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const pa=
cket_id_type dist =3D subtract_pid(rel-&gt;packet_id, pid);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return dist &gt; 0 &amp;&amp; dist &lt; RELIABLE_CAPAC=
ITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return reli=
able_pid_in_range(pid, subtract_pid(rel-&gt;packet_id, RELIABLE_CAPACITY),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
             RELIABLE_CAPACITY);</span><br><span> }</span><br><span> </span=
><br><span> /* del acknowledged items from send buf */</span><br><span>@@ -=
376,7 +376,7 @@</span><br><span>         packet_id_type pid =3D ack-&gt;pac=
ket_id[i];</span><br><span> </span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (!validate_packet_id_window(rel, pid))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!reliabl=
e_pid_in_send_window(rel, pid))</span><br><span>         {</span><br><span>=
             if (out_of_window =3D=3D 0)</span><br><span>             {</sp=
an><br><span>@@ -566,7 +566,7 @@</span><br><span> }</span><br><span> </span=
><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliab=
le_get_num_output_sequenced_available(struct reliable *rel)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+reliable_get_num_output_sequenced_a=
vailable(const struct reliable *rel)</span><br><span> {</span><br><span>   =
  return rel-&gt;size - (int)reliable_oldest_active_distance(rel);</span><b=
r><span> }</span><br><span>diff --git a/src/openvpn/reliable=2Eh b/src/open=
vpn/reliable=2Eh</span><br><span>index 04f3372=2E=2E534feb3 100644</span><b=
r><span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/re=
liable=2Eh</span><br><span>@@ -190,15 +190,20 @@</span><br><span> }</span><=
br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * check that pid is inside the window of possible outstanding pa=
ckets</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of size RELIA=
BLE_CAPACITY, ie inside the range</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * [rel-&gt;packet_id - RELIABLE_CAPACITY, rel-&gt;packet_id)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whether=
 pid is one of the RELIABLE_CAPACITY ids below rel-&gt;packet_id,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * and so could still be outs=
tanding=2E rel-&gt;packet_id is the *next* id to be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * sent, so it is not itself in the windo=
w=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * rel-&gt;packet is the *next* packet id to be sent out, so it is not</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * included in the vali=
d range=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pid co=
mes off the wire; all 2^32 values are handled=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param rel The reliable structure holding this tunnel&#39;s =
sent packets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param pid A packet ID from a received acknowledgment=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @li True, if pid is inside the window=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @li False, otherwise=2E</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-validate_packet_id_window(struct =
reliable *rel, packet_id_type pid);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool reliable_pid_in_send_window(const struct reliable *rel=
, packet_id_type pid);</span><br><span> </span><br><span> /**</span><br><sp=
an>  * Returns the number of packets that need to be acked=2E</span><br><sp=
an>@@ -305,14 +310,15 @@</span><br><span>  * Check that a received packet&#=
39;s ID can safely be stored in</span><br><span>  *     the reliable struct=
ure&#39;s processing window=2E</span><br><span>  *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * This function checks the difference between=
 the received packet&#39;s ID</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * and the lowest non-acknowledged packet ID in the given reliable<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * structure=2E  If th=
at difference is larger than the total number of</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * packets which can be stored, then this packet=
 cannot be stored safely,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * because the reliable structure could possibly fill up without leavin=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * room for all inte=
rvening packets=2E  In that case, this received packet</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * could break the reliable structure&#39;=
s sequentiality, and must therefore</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * be discarded=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Checks the received packet&#39;s ID against rel-&gt;packet_=
id, the next ID the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * reliability layer expects to hand upwards=2E One too far ahead could fil=
l the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * structure w=
ithout leaving room for the intervening packets, so it is</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * discarded=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * IDs numerically below rel-&gt;packet_id are accepted he=
re, an absolute</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c=
omparison that an ID from before a wraparound does not pass=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * reliable_not_replay() rejects=
 them, and they are still acknowledged so a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * peer whose ACK was lost stops retransmitting=2E<=
/span><br><span>  *</span><br><span>  * @param rel The reliable structure f=
or handling this VPN tunnel&#39;s</span><br><span>  *     received packets=
=2E</span><br><span>@@ -354,6 +360,10 @@</span><br><span>  * Mark the %reli=
able entry associated with the given buffer as active</span><br><span>  * i=
ncoming=2E</span><br><span>  *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * pid must be less than rel-&gt;size ahead of rel-&gt;packet_id=
=2E This is asserted,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * so run reliable_wont_break_sequentiality() and reliable_not_replay()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * first=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span>  * @param=
 rel The reliable structure associated with this packet=2E</span><br><span>=
  * @param buf The buffer into which the packet has been copied=2E</span><b=
r><span>  * @param pid The packet&#39;s packet ID=2E</span><br><span>@@ -44=
6,7 +456,7 @@</span><br><span>  *  @return the number of buffer that are av=
ailable for sending without</span><br><span>  *             breaking ack se=
quence</span><br><span>  * */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int reliable_get_num_output_sequenced_available(struct reliable *re=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int reliable_get=
_num_output_sequenced_available(const struct reliable *rel);</span><br><spa=
n> </span><br><span> /**</span><br><span>  * Mark the reliable entry associ=
ated with the given buffer as</span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2Ec</=
span><br><span>index ac6c710=2E=2E245c357 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_packet_id=2Ec</span><br><span>@@ -331,44 +331,50 @@</span>=
<br><span>     struct reliable rel =3D { 0 };</span><br><span>     rel=2Epa=
cket_id =3D 1;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, 0));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pi=
d_in_send_window(&amp;rel, 0));</span><br><span> </span><br><span>     /* p=
acket id 1 is outside the window as it is the *next* packet id */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_packe=
t_id_window(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 1));</span><b=
r><span> </span><br><span>     /* wrapped around packet id, &quot;-2&quot; =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(val=
idate_packet_id_window(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp=
;rel, 0xFFFFFFFD));</span><br><span> </span><br><span>     /* wrapped aroun=
d packet id, &quot;-10&quot; */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF6));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(rel=
iable_pid_in_send_window(&amp;rel, 0xFFFFFFF6));</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* wrapped around packet i=
d, &quot;-11&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFF5));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_pack=
et_id_window(&amp;rel, 0x80000000));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* wrapped around packet id, &quot;-11&quot;: the olde=
st id still in the window */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF5))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* one further back is outside it=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF4));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_win=
dow(&amp;rel, 0x80000000));</span><br><span> </span><br><span>     rel=2Epa=
cket_id =3D 0x80000000;</span><br><span> </span><br><span>     /* near the =
signed/usigned integer area */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0x80000001));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(valid=
ate_packet_id_window(&amp;rel, 0x7fffffff));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, =
0x7ffffff5));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asse=
rt_false(validate_packet_id_window(&amp;rel, 0x7ffffff4));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_sen=
d_window(&amp;rel, 0x80000001));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0x7fffff=
ff));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(reliable_pid_in_send_window(&amp;rel, 0x7ffffff5));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_wind=
ow(&amp;rel, 0x7ffffff4));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0x7ffffff3));=
</span><br><span> </span><br><span>     rel=2Epacket_id =3D 0xFFFFFFFD;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate=
_packet_id_window(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(va=
lidate_packet_id_window(&amp;rel, 1));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0xFFF=
FFFFE));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_fa=
lse(validate_packet_id_window(&amp;rel, 0xFFFFFFFF));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&=
amp;rel, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF2));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_pack=
et_id_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0xF=
FFFFFFD));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(reliable_pid_in_send_window(&amp;rel, 0));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window=
(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFFE));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_=
in_send_window(&amp;rel, 0xFFFFFFFF));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0x=
FFFFFFF3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF2));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_sen=
d_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFF=
FF0));</span><br><span> </span><br><span>     rel=2Epacket_id =3D 500;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_=
packet_id_window(&amp;rel, 501));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, 497));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_p=
acket_id_window(&amp;rel, 500 - (RELIABLE_CAPACITY - 1)));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_wi=
ndow(&amp;rel, 500 - RELIABLE_CAPACITY));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel=
, 501));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(reliable_pid_in_send_window(&amp;rel, 497));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&=
amp;rel, 500 - (RELIABLE_CAPACITY - 1)));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel,=
 500 - RELIABLE_CAPACITY));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 500 - (RELIA=
BLE_CAPACITY + 1)));</span><br><span> }</span><br><span> </span><br><span> =
</span><br><span>@@ -533,21 +539,19 @@</span><br><span>     return (packet_=
id_type)(p1 - p2) &gt;=3D 0x80000000u;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* one short of RELIA=
BLE_CAPACITY, which is what the code accepts today */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CHARACTERIZED_SEND_WINDOW 11</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* TLS_REL=
IABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, which this</span><=
br><span>  * test binary does not pull in */</span><br><span> #define CHAR_=
N_SEND_BUFFERS    6</span><br><span> #define CHAR_OPCODE_CONTROL_V1 4</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* preser=
ved: the ids validate_packet_id_window() accepts */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* introduced: the RELIABLE_CAPACITY ids =
below rel-&gt;packet_id=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * validate_packet_id_window() stopped one short of that=2E */</span=
><br><span> static bool</span><br><span> ref_pid_in_send_window(const struc=
t reliable *rel, packet_id_type pid)</span><br><span> {</span><br><span>   =
  const packet_id_type dist =3D (packet_id_type)(rel-&gt;packet_id - pid);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARACTERIZED_SEND_WINDOW;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dist &gt;=
=3D 1 &amp;&amp; dist &lt;=3D RELIABLE_CAPACITY;</span><br><span> }</span><=
br><span> </span><br><span> /* preserved: reliable_pid_in_range2() */</span=
><br><span>@@ -798,7 +802,7 @@</span><br><span>                 rel=2Epacke=
t_id =3D anchors[a];</span><br><span> </span><br><span>                 ass=
ert_int_equal(ref_pid_in_send_window(&amp;rel, ids[i]),</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                 validate=
_packet_id_window(&amp;rel, ids[i]) !=3D 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 reliable_pid_in_s=
end_window(&amp;rel, ids[i]));</span><br><span>             }</span><br><sp=
an>         }</span><br><span>     }</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail">change =
1901</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I63c141075d89ae6a07872e784faff817dd3350b1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1901 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--GeUaJGUXzdI=--


--===============1626516989742614838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1626516989742614838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1626516989742614838==--

