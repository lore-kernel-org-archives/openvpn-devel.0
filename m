Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB9FCA9ECE
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3BM8odIsoJYv6+l/qjVd7O60yJKbAiPSnNi7lWyQSK0=; b=eBDFk3EooqUtfO8vhN/ZgEIQO+
	Pb/Folb5UFwo3/0YH+NK9JUu4tjyuB25X7w5du1q8bPy7TnmBkzWyUp6f+gbdWlPNfyuytquI9WQG
	o568CLTzV2Fydmps2HmeduAAxxh2C/42TDrS96AwyLv6tdtoezAsmGYaIZPTq7t5iV88=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFw4y-0007rq-9M;
	Sun, 11 Oct 2026 16:07:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFw4x-0007rj-He
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:07:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5glTNDcACDbStwVvX+VCjl30jUs3B2GbL1emU0N2NUM=; b=UkzNb9CCoepfN3NWtnMF5HTeAb
 tUWJtx9CV+oZPtUGrhIT0WrJ5KP1ioBZlK7IrufqMnnyk9r/xUlKHmTFXbm41uTVi9JcOUuGUmy53
 527gOoNBu1dZIF+X+jFttfgqm9V+GEAE+EUZGYCDAAtzpLgTt5vj6veJexS705/CjIhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5glTNDcACDbStwVvX+VCjl30jUs3B2GbL1emU0N2NUM=; b=J
 qJdd0gAuZIh8T6DqMaj6VrvPqobWv6kJJMGlhiQTyzPCyEim27+RSCJSYrh2HS/ZYjRP8AHm8ohc6
 VqO/4+QIrCDCA4RlYQyziDcvYZ/AaswXrGK72l8DsRsx3SyLumIOCrkHCm5+uLz02LkQhdawtdUue
 kN4TBbkn9eIM9kds=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFw4v-00079C-JI for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:07:15 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so7051295e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791734827; x=1792339627; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5glTNDcACDbStwVvX+VCjl30jUs3B2GbL1emU0N2NUM=;
 b=IFt6RrJRcmrXcTU8jPIEuVCJJAFZxAPjzIADvSr3gS6b2K5XzjXI9fTEgioZT+RqRf
 PArNaI1l/mmywT1gBgTu9r2t6anQlYO8xS3lVegJZGrwCYGv9pA8nyWzzoOMjkd2ekTy
 6LhVaHQEpwCNXkOD5Bqv+lwrLYsN/Pzu8rF+kPgGTJ5zR2mmvmXvzbjHeGGQxoBltHdK
 XJu6pncagbacgsXj4v4OonD72xgxbUNKJJDQfDcTa+jxpkgdCT8pH5CuQoT7oa6+ujkz
 Grw8ribB7UBhi0Xk+7sh4CWrASkbGr33xDmue6YmVlefIlCVyrUdPALwkD+ikFVE/Ou+
 GRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791734827; x=1792339627;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5glTNDcACDbStwVvX+VCjl30jUs3B2GbL1emU0N2NUM=;
 b=vDk7XMP0dhcBmqLgu8pqZrWN+q85HHh0mqQ0o+GLQOmz7hafBlbqpWY1NZh1zpwe19
 Y1+n5klST5CyCVek0ThiWPBFH3kD3J5lumoYmFjYMw9yFbPnLipQszP4fB4oSJiqAeKw
 3fIj7NaqAf4sydjPdOUPo8BfSrIffddElJuxt85aimgpVs24Zk34JYFKgxfAXVC0MBpg
 wDD5SDSbxl0Y0xINWYgdHfIzK7epnDIDmhB4rI0uQ95+Peu7llMGUILJGU8Wt8k4E9bz
 vyQ8i4kFsV/HouWkR/+iy/kn49DhCxtdLQ1tZJdQjPeIgYArlDfqm/Np4TRcbd1PuaBg
 uZJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByJEVgTlXRAwXiSWxR5QMTuxHXy8PKyGc+CUKJAGxzcits4iGCvgoDb8v24toXshfk5mMikEIp6QTKAe8c6@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJnioPPNRJXgShgDJs5/Y6RW9dII3OHlQPOJtHnOkWMDswJh/zc
 i/B2FxwoPJPbQlKNtddsOJaTWLcQVQhUV1aouaGYdJxJ+E/p6xLfcWhiEtFBKR0Tbl1crR8Uyzr
 ePM/T4/WPDxi+jtg1PQOfLbOBKjsj6QsgxpFQomi2hJAYWXp4BhNEFBbRbCxKGqnXOGiZaWZ+H/
 5Aid6Lfw==
X-Gm-Gg: AYBFou2BQEmL2sZXVFovj+oBhv8B6YcB8jbFESXmcAUnl53t9LuEkOOvgwNvqaCXKgN
 uGvN+O1LYKFK2r+Kc94GkZ4WDD+VJ5JlqkThgxSzb/F0PZpBNPWxdbIn0j40oQZOF4sVCNVYK6x
 ng367U/hG8xnZ8oPTdxLzUbkV7XwlKnvbzswdbcqSg9l6h9TP2g9R4uC5ttWVwi8e+RQp6vP4AX
 mNLpD0wpDY9YKb9qRgnOGDLRUyAZUK5Z2f36j3ZlBX2Qz4oGQmRp6yveG48EdxntA3X6VuuBGbP
 Fs1YR8IOxSzrCGqX4RrqNM2wTIzV6XbS20w6wjgHNwruJ4MQa8cZlxsTeOHK0O+RCj0QzVMnoCr
 X7QUjZKl2S3496d5OYbYU71j8awJS5TZcnKrsBuyfyLjdRB8xzVYNV6d3x6N6dRrcvNWMw8ZA/g
 FGchFZY25sCcBi3ZjdKWXYiCD8/A1CAHaNvoDDqwgOe+I6fuycqo84PqG67sGp7gOv/P2gnc9D/
 06hgbSJlLhzi8wKrWXYKswyRO9kyI8F0Cn+VLo1CjocsBHwQOL0D2zEpX+7Hy2PJ5r5Yr7JqVzh
 j0WVlm4I6ybJ660BNNiF2/JG2YIJDCN6hz8w5frtuOK6BYWEUaT2OiIP6uVk
X-Received: by 2002:a05:600c:4e55:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a18e49c008mr125582405e9.12.1791734825684; 
 Sun, 11 Oct 2026 09:07:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18beacd2csm239863835e9.14.2026.10.11.09.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:07:05 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 16:07:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
X-Gerrit-Change-Number: 1901
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1901?usp=email>
X-Gerrit-Commit: 01619660cc1c1c56c999c8ec8de1b23c63580a9b
In-Reply-To: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
References: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLkk2M2MxNDEwNzVkODlhZTZhMDc4NzJlNzg0ZmFmZjgxN2RkMzM1MGIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e6c1331c70ca0b8c8fc0d0d728ce48eab5c6c7f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFw4v-00079C-JI
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5192519712963378756=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5192519712963378756==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RRB6A3TRTZk="; charset=UTF-8

--RRB6A3TRTZk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1901?usp=3Demail )

Change subject: reliable: fix the send wind=
ow width
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reli=
able: fix the send window width

The check accepted the 11 ids below rel->p=
acket_id where its documentation
said RELIABLE_CAPACITY=2E Twelve is right:=
 reliable_get_buf_output_sequenced()
issues an id while it is less than rel=
->size beyond the oldest
unacknowledged one, so an entry can sit a full rel=
->size below
rel->packet_id, and rel->size may be RELIABLE_CAPACITY=2E

No =
effect today, TLS_RELIABLE_N_SEND_BUFFERS being 6=2E Raising the send
buffe=
r count to RELIABLE_CAPACITY, which reliable_init() permits, would
have dis=
carded the ACK for the oldest outstanding packet=2E

The width is now the e=
xtent passed to reliable_pid_in_range() rather
than a comparison operator=
=2E

Also renames validate_packet_id_window() to reliable_pid_in_send_windo=
w(),
returning bool and taking a const struct reliable * like its neighbour=
s,
and the same const on reliable_get_num_output_sequenced_available()=2E

=
Three doc comments described what the code does not do: the window
bounds, =
reliable_wont_break_sequentiality()'s reference id, subtract_pid()'s
argume=
nt order=2E reliable_mark_active_incoming() now states the
precondition it =
asserts=2E

Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
Signed-off=
-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1901
Message-Id: <20261008205045=2E28233-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39795=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M s=
rc/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M tests/unit_tests/openv=
pn/test_packet_id=2Ec
3 files changed, 68 insertions(+), 54 deletions(-)


=


diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index 64=
5fbfd=2E=2Ec268cce 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/=
reliable=2Ec
@@ -38,8 +38,9 @@
 
 #include "memdbg=2Eh"
 
-/* calculates te=
st - base while allowing for base or test wraparound=2E test is
- * assumed=
 to be higher than base */
+/* calculates test - base while allowing for ba=
se or test wraparound=2E The
+ * result is only meaningful compared against=
 a bound: on its own it does not
+ * say which id came first=2E */
 static =
inline packet_id_type
 subtract_pid(const packet_id_type test, const packet=
_id_type base)
 {
@@ -356,12 +357,11 @@
     return true;
 }
 
-int
-valida=
te_packet_id_window(struct reliable *rel, packet_id_type pid)
+bool
+reliab=
le_pid_in_send_window(const struct reliable *rel, packet_id_type pid)
 {
- =
   const packet_id_type dist =3D subtract_pid(rel->packet_id, pid);
-
-    =
return dist > 0 && dist < RELIABLE_CAPACITY;
+    return reliable_pid_in_ra=
nge(pid, subtract_pid(rel->packet_id, RELIABLE_CAPACITY),
+                =
                 RELIABLE_CAPACITY);
 }
 
 /* del acknowledged items from s=
end buf */
@@ -376,7 +376,7 @@
         packet_id_type pid =3D ack->packet_=
id[i];
 
 
-        if (!validate_packet_id_window(rel, pid))
+        if (=
!reliable_pid_in_send_window(rel, pid))
         {
             if (out_of_=
window =3D=3D 0)
             {
@@ -566,7 +566,7 @@
 }
 
 int
-reliable_get=
_num_output_sequenced_available(struct reliable *rel)
+reliable_get_num_out=
put_sequenced_available(const struct reliable *rel)
 {
     return rel->siz=
e - (int)reliable_oldest_active_distance(rel);
 }
diff --git a/src/openvpn/=
reliable=2Eh b/src/openvpn/reliable=2Eh
index 04f3372=2E=2E534feb3 100644
-=
-- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -190,15 +19=
0,20 @@
 }
 
 /**
- * check that pid is inside the window of possible outst=
anding packets
- * of size RELIABLE_CAPACITY, ie inside the range
- * [rel-=
>packet_id - RELIABLE_CAPACITY, rel->packet_id)=2E
+ * Check whether pid is=
 one of the RELIABLE_CAPACITY ids below rel->packet_id,
+ * and so could st=
ill be outstanding=2E rel->packet_id is the *next* id to be
+ * sent, so it=
 is not itself in the window=2E
  *
- * rel->packet is the *next* packet id=
 to be sent out, so it is not
- * included in the valid range=2E
+ * pid co=
mes off the wire; all 2^32 values are handled=2E
+ *
+ * @param rel The rel=
iable structure holding this tunnel's sent packets=2E
+ * @param pid A pack=
et ID from a received acknowledgment=2E
+ *
+ * @return
+ * @li True, if pi=
d is inside the window=2E
+ * @li False, otherwise=2E
  */
-int
-validate_p=
acket_id_window(struct reliable *rel, packet_id_type pid);
+bool reliable_p=
id_in_send_window(const struct reliable *rel, packet_id_type pid);
 
 /**
 =
 * Returns the number of packets that need to be acked=2E
@@ -305,14 +310,1=
5 @@
  * Check that a received packet's ID can safely be stored in
  *     =
the reliable structure's processing window=2E
  *
- * This function checks =
the difference between the received packet's ID
- * and the lowest non-ackn=
owledged packet ID in the given reliable
- * structure=2E  If that differen=
ce is larger than the total number of
- * packets which can be stored, then=
 this packet cannot be stored safely,
- * because the reliable structure co=
uld possibly fill up without leaving
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd=
3350b1
Gerrit-Change-Number: 1901
Gerrit-PatchSet: 4
Gerrit-Owner: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--RRB6A3TRTZk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1901?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">reliable: fix the send window widt=
h<br><br>The check accepted the 11 ids below rel-&gt;packet_id where its do=
cumentation<br>said RELIABLE_CAPACITY=2E Twelve is right: reliable_get_buf_=
output_sequenced()<br>issues an id while it is less than rel-&gt;size beyon=
d the oldest<br>unacknowledged one, so an entry can sit a full rel-&gt;size=
 below<br>rel-&gt;packet_id, and rel-&gt;size may be RELIABLE_CAPACITY=2E<b=
r><br>No effect today, TLS_RELIABLE_N_SEND_BUFFERS being 6=2E Raising the s=
end<br>buffer count to RELIABLE_CAPACITY, which reliable_init() permits, wo=
uld<br>have discarded the ACK for the oldest outstanding packet=2E<br><br>T=
he width is now the extent passed to reliable_pid_in_range() rather<br>than=
 a comparison operator=2E<br><br>Also renames validate_packet_id_window() t=
o reliable_pid_in_send_window(),<br>returning bool and taking a const struc=
t reliable * like its neighbours,<br>and the same const on reliable_get_num=
_output_sequenced_available()=2E<br><br>Three doc comments described what t=
he code does not do: the window<br>bounds, reliable_wont_break_sequentialit=
y()&#39;s reference id, subtract_pid()&#39;s<br>argument order=2E reliable_=
mark_active_incoming() now states the<br>precondition it asserts=2E<br><br>=
Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1<br>Signed-off-by: Razv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1901<br>Message-Id: &lt;20261008205045=2E28233-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39795=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/reliable=2Ec<br>M src/open=
vpn/reliable=2Eh<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>3 file=
s changed, 68 insertions(+), 54 deletions(-)<br><br></pre>
<pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index 6=
45fbfd=2E=2Ec268cce 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</=
span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -38,8 +38,=
9 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* calc=
ulates test - base while allowing for base or test wraparound=2E test is</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * assumed to be higher =
than base */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* calc=
ulates test - base while allowing for base or test wraparound=2E The</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * result is only meaningf=
ul compared against a bound: on its own it does not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * say which id came first=2E */</span><b=
r><span> static inline packet_id_type</span><br><span> subtract_pid(const p=
acket_id_type test, const packet_id_type base)</span><br><span> {</span><br=
><span>@@ -356,12 +357,11 @@</span><br><span>     return true;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-validate_packet=
_id_window(struct reliable *rel, packet_id_type pid)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+reliable_pid_in_send_window(const struct reliable *rel, =
packet_id_type pid)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const packet_id_type dist =3D subtract_pid(rel-&gt;pac=
ket_id, pid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return dist &gt; 0 &amp;&=
amp; dist &lt; RELIABLE_CAPACITY;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return reliable_pid_in_range(pid, subtract_pid(rel-&gt;pa=
cket_id, RELIABLE_CAPACITY),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                 RELIABLE_CAPACITY);</span><br><sp=
an> }</span><br><span> </span><br><span> /* del acknowledged items from sen=
d buf */</span><br><span>@@ -376,7 +376,7 @@</span><br><span>         packe=
t_id_type pid =3D ack-&gt;packet_id[i];</span><br><span> </span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!validate=
_packet_id_window(rel, pid))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!reliable_pid_in_send_window(rel, pid))</span><br><spa=
n>         {</span><br><span>             if (out_of_window =3D=3D 0)</span=
><br><span>             {</span><br><span>@@ -566,7 +566,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-reliable_get_num_output_sequenced_available(struct r=
eliable *rel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliab=
le_get_num_output_sequenced_available(const struct reliable *rel)</span><br=
><span> {</span><br><span>     return rel-&gt;size - (int)reliable_oldest_a=
ctive_distance(rel);</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index 04f3372=
=2E=2E534feb3 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><=
br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -190,15 +190,20 =
@@</span><br><span> }</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * check that pid is inside the wind=
ow of possible outstanding packets</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * of size RELIABLE_CAPACITY, ie inside the range</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * [rel-&gt;packet_id - RELIABLE_C=
APACITY, rel-&gt;packet_id)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Check whether pid is one of the RELIABLE_CAPACITY ids below r=
el-&gt;packet_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 and so could still be outstanding=2E rel-&gt;packet_id is the *next* id to=
 be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sent, so it i=
s not itself in the window=2E</span><br><span>  *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * rel-&gt;packet is the *next* packet id to be=
 sent out, so it is not</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * included in the valid range=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * pid comes off the wire; all 2^32 values are handled=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param rel The reliable structure h=
olding this tunnel&#39;s sent packets=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param pid A packet ID from a received acknowledgme=
nt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @li True, if pid is inside the window=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @li False, ot=
herwise=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-validate=
_packet_id_window(struct reliable *rel, packet_id_type pid);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool reliable_pid_in_send_window(c=
onst struct reliable *rel, packet_id_type pid);</span><br><span> </span><br=
><span> /**</span><br><span>  * Returns the number of packets that need to =
be acked=2E</span><br><span>@@ -305,14 +310,15 @@</span><br><span>  * Check=
 that a received packet&#39;s ID can safely be stored in</span><br><span>  =
*     the reliable structure&#39;s processing window=2E</span><br><span>  *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function chec=
ks the difference between the received packet&#39;s ID</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * and the lowest non-acknowledged packet =
ID in the given reliable</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * structure=2E  If that difference is larger than the total number of</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * packets which can be=
 stored, then this packet cannot be stored safely,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * because the reliable structure could possib=
ly fill up without leaving</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * room for all intervening packets=2E  In that case, this received pa=
cket</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * could break th=
e reliable structure&#39;s sequentiality, and must therefore</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * be discarded=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Checks the received packet&#39;s I=
D against rel-&gt;packet_id, the next ID the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * reliability layer expects to hand upwards=2E On=
e too far ahead could fill the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * structure without leaving room for the intervening packets, s=
o it is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * discarded=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * IDs numerically below rel-&gt;=
packet_id are accepted here, an absolute</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * comparison that an ID from before a wraparound does=
 not pass=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reli=
able_not_replay() rejects them, and they are still acknowledged so a</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * peer whose ACK was lost=
 stops retransmitting=2E</span><br><span>  *</span><br><span>  * @param rel=
 The reliable structure for handling this VPN tunnel&#39;s</span><br><span>=
  *     received packets=2E</span><br><span>@@ -354,6 +360,10 @@</span><br>=
<span>  * Mark the %reliable entry associated with the given buffer as acti=
ve</span><br><span>  * incoming=2E</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * pid must be less than rel-&gt;size ah=
ead of rel-&gt;packet_id=2E This is asserted,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * so run reliable_wont_break_sequentiality() and=
 reliable_not_replay()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span>  * @param rel The reliable structure associated with this pa=
cket=2E</span><br><span>  * @param buf The buffer into which the packet has=
 been copied=2E</span><br><span>  * @param pid The packet&#39;s packet ID=
=2E</span><br><span>@@ -446,7 +456,7 @@</span><br><span>  *  @return the nu=
mber of buffer that are available for sending without</span><br><span>  *  =
           breaking ack sequence</span><br><span>  * */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int reliable_get_num_output_sequenced_ava=
ilable(struct reliable *rel);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int reliable_get_num_output_sequenced_available(const struct reli=
able *rel);</span><br><span> </span><br><span> /**</span><br><span>  * Mark=
 the reliable entry associated with the given buffer as</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/op=
envpn/test_packet_id=2Ec</span><br><span>index ac6c710=2E=2E245c357 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@=
 -331,44 +331,50 @@</span><br><span>     struct reliable rel =3D { 0 };</sp=
an><br><span>     rel=2Epacket_id =3D 1;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_win=
dow(&amp;rel, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(reliable_pid_in_send_window(&amp;rel, 0));</span><br><span> =
</span><br><span>     /* packet id 1 is outside the window as it is the *ne=
xt* packet id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert_false(validate_packet_id_window(&amp;rel, 1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_win=
dow(&amp;rel, 1));</span><br><span> </span><br><span>     /* wrapped around=
 packet id, &quot;-2&quot; */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFFD));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(relia=
ble_pid_in_send_window(&amp;rel, 0xFFFFFFFD));</span><br><span> </span><br>=
<span>     /* wrapped around packet id, &quot;-10&quot; */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_win=
dow(&amp;rel, 0xFFFFFFF6));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF6));=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* wrapped around packet id, &quot;-11&quot; */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;=
rel, 0xFFFFFFF5));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_false(validate_packet_id_window(&amp;rel, 0x80000000));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* wrapped around packet id=
, &quot;-11&quot;: the oldest id still in the window */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_wi=
ndow(&amp;rel, 0xFFFFFFF5));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* one=
 further back is outside it */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF=
4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(reliable_pid_in_send_window(&amp;rel, 0x80000000));</span><br><span> </sp=
an><br><span>     rel=2Epacket_id =3D 0x80000000;</span><br><span> </span><=
br><span>     /* near the signed/usigned integer area */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_wind=
ow(&amp;rel, 0x80000001));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    assert_true(validate_packet_id_window(&amp;rel, 0x7fffffff));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_p=
acket_id_window(&amp;rel, 0x7ffffff5));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0x7f=
fffff4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(reliable_pid_in_send_window(&amp;rel, 0x80000001));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send=
_window(&amp;rel, 0x7fffffff));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0x7ffffff=
5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(reliable_pid_in_send_window(&amp;rel, 0x7ffffff4));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_win=
dow(&amp;rel, 0x7ffffff3));</span><br><span> </span><br><span>     rel=2Epa=
cket_id =3D 0xFFFFFFFD;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFFD));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_pa=
cket_id_window(&amp;rel, 0));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_false(validate_packet_id_window(&amp;rel, 1));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_packe=
t_id_window(&amp;rel, 0xFFFFFFFE));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFF=
FF));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(=
validate_packet_id_window(&amp;rel, 0xFFFFFFF3));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;=
rel, 0xFFFFFFF2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFF1));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_i=
n_send_window(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
reliable_pid_in_send_window(&amp;rel, 1));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;re=
l, 0xFFFFFFFE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFFF));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_=
in_send_window(&amp;rel, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0x=
FFFFFFF2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF1));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_se=
nd_window(&amp;rel, 0xFFFFFFF0));</span><br><span> </span><br><span>     re=
l=2Epacket_id =3D 500;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_false(validate_packet_id_window(&amp;rel, 501));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_w=
indow(&amp;rel, 497));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_true(validate_packet_id_window(&amp;rel, 500 - (RELIABLE_CAPACI=
TY - 1)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_=
false(validate_packet_id_window(&amp;rel, 500 - RELIABLE_CAPACITY));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_=
pid_in_send_window(&amp;rel, 501));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 497))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(re=
liable_pid_in_send_window(&amp;rel, 500 - (RELIABLE_CAPACITY - 1)));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_p=
id_in_send_window(&amp;rel, 500 - RELIABLE_CAPACITY));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_wi=
ndow(&amp;rel, 500 - (RELIABLE_CAPACITY + 1)));</span><br><span> }</span><b=
r><span> </span><br><span> </span><br><span>@@ -533,21 +539,19 @@</span><br=
><span>     return (packet_id_type)(p1 - p2) &gt;=3D 0x80000000u;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/* one short of RELIABLE_CAPACITY, which is what the code accepts tod=
ay */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHARACTE=
RIZED_SEND_WINDOW 11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> /* TLS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_=
pkt=2Eh, which this</span><br><span>  * test binary does not pull in */</sp=
an><br><span> #define CHAR_N_SEND_BUFFERS    6</span><br><span> #define CHA=
R_OPCODE_CONTROL_V1 4</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* preserved: the ids validate_packet_id_window() accepts=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* introduced: t=
he RELIABLE_CAPACITY ids below rel-&gt;packet_id=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * validate_packet_id_window() stopped on=
e short of that=2E */</span><br><span> static bool</span><br><span> ref_pid=
_in_send_window(const struct reliable *rel, packet_id_type pid)</span><br><=
span> {</span><br><span>     const packet_id_type dist =3D (packet_id_type)=
(rel-&gt;packet_id - pid);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D CH=
ARACTERIZED_SEND_WINDOW;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D RELIABLE_CAPACITY;</=
span><br><span> }</span><br><span> </span><br><span> /* preserved: reliable=
_pid_in_range2() */</span><br><span>@@ -798,7 +802,7 @@</span><br><span>   =
              rel=2Epacket_id =3D anchors[a];</span><br><span> </span><br><=
span>                 assert_int_equal(ref_pid_in_send_window(&amp;rel, ids=
[i]),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                 validate_packet_id_window(&amp;rel, ids[i]) !=3D 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
        reliable_pid_in_send_window(&amp;rel, ids[i]));</span><br><span>   =
          }</span><br><span>         }</span><br><span>     }</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1901?usp=3Demail">change 1901</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1901?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merg=
ed </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1901 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RRB6A3TRTZk=--


--===============5192519712963378756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5192519712963378756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5192519712963378756==--

