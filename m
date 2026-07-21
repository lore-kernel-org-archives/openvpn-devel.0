Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7498BC44533
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xAY1sp6QOhJGKMkf7OL39I3EZX4GVELxWIjaAdWqSPo=; b=OqkVEAQkd8kdZY9D9jQnQlg+nu
	ScFuw3a1EHSP+X4QGdlotHCAEbZVhlyD5YHBKZiZH//alZ/1TR/J1iQmvQLW7+GqzRQmOP3pDTXHJ
	lRSSIkLvS+1fkkb/KU9lC0VwwGocsWfreNc9o88vHI5APNW/1vwX3Qz5ocWn3hvXqoAw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm9hW-00031I-Gj;
	Tue, 21 Jul 2026 12:35:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm9hV-00031B-5g
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cbof22gsIiXX1at3obl4lqqVxJIdx1p7kW11ZICYtvI=; b=eQDjo8KhT7taHaC745dZskIZ8x
 M87S+zZEncxES8fW87cxWqxJn6nIPXeKSHpT5/HVvdilX2iJRnw02vZWYuWBtjHd1aey6aAHwzANm
 maPXMR9QSuvEUogu//xHW8ia8BIiIHv/JqFoM/Xe8zHrcfOkceOTG0+zVvrz86FwZVDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cbof22gsIiXX1at3obl4lqqVxJIdx1p7kW11ZICYtvI=; b=J
 NLESkbwda6KmfbhuvLBV5MkmklDJZsqmSetyYqdu58fdqfcv7Z9eyp3v/Qp0sRMmDa7iKZcMn3LRS
 SnyGg0sMoPNkES5BcABR6qxkWR/Duibj3JnhqhD5UBX+Lo+YpmYfwLGGG7HPFOAYmhdxkUHbkH+I7
 y3lXczeUBZg4xkl4=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm9hR-0001kI-2h for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:54 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-475417f010dso6375128f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784637341; x=1785242141; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cbof22gsIiXX1at3obl4lqqVxJIdx1p7kW11ZICYtvI=;
 b=Hl0WfGdwJTJW+pJnESSo96IR32FLP74fK7xeDgoas066QegtlmjXvL/4+GaAItCj43
 aCH8QeDo1+fiTxlxunJZfT/OP8OlmEyUtsvNgw0xbg4y2EpzPgLdW6djp3wi25N2I9qb
 ocQbYiGrhALTzakLqmGdN1jUj5kHIiyWIJtrfZBoKjRaSoCe/IHeWorowLPFNGiiJAXF
 3UZzsgkne+D41iqT2RDv6SpZytnvo5E/JFqQ8kmHFe2R2jSif4aUkN4sx0+VJdNYTAbA
 lnqpuMlZgVZNZCS68vBIrg2i1Ucd0o/GULIgDhj6QBrT03OXludkv2Y1ySCDrYgiqBAI
 yTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637341; x=1785242141;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cbof22gsIiXX1at3obl4lqqVxJIdx1p7kW11ZICYtvI=;
 b=qxCRwVxJo4y07zke6/Q45PuJ3p4STwnisZOb5reeV01kfF7t1o+V7nviepaaeXXJWr
 p6hEwb+EB0spaftLS9PaUJQVM1R71TKEWU/8JMdiEyn4xej4PMj5n9NwFk47OWsDLLzA
 mU5jbVxdOYg4xW63QaNj3GgTSonBKsIMITH1cdZKawgeDF2d8v7q+iPyKLXTv+ePxMV5
 jxOehVBAnW8G/ZXp0Kwc+19ra5dQxgaW0erxWbufbd7gKlw9W716wXhgwuAmlyzKXVcR
 Wrc+43848V0y2CNCR0ate+5S824QQwk64IgZy22WsossfZCApvNPmVlCarZ6zeZC7vgB
 bOFw==
X-Gm-Message-State: AOJu0Yy8S4pnV0lIQSB7HfPZNydBtZg666IPoHswAlsHaxo0PyOjqDTx
 mE80MnTSzs5OF/pa6pYP3Snms5XhEyr+3aiXxL8/83mghRKLv3/EPAObRY1yXods20WDKyfVI29
 hdaJhfXmVARE7YTfN87Y566XybnIwkfu99uBDPnY7ITcRIPXkX0MjLqL3zjQ+vfz9KVzy
X-Gm-Gg: AR+sD11KmYC3LaFRM8NS2CiHmycnXwALRN5q8bTy8TpPRfU3ofiAx3IE7GMceNQJdit
 jW/HRTf3ZN53QSzszIYsBvJrg/YUzVmJckBBMDRLk3y3DN/D8Lx+LahCrb+eJBEAvKeiGDXJRew
 ahC7/trTdlfF99l3qCl7UVouvu1+Y/ublxSSXfXylyZ+JONudBhfoAtubXajH5E9nM3rEl0W0eV
 G6DOAJeBScR+Haekorc/xJZVxe+bPBOtk6avUkRFO4wUcy5Jzpx3ByMTBjuY72dRzjGDnCIV3xK
 TDw92IzPORM+d6i7/EPZlHjo3kTlwDT82GUxg+ozWHXZ42OM8GAi0RgRUsWVXUuFfJtyZrEY+uS
 5O4vdzsseyuWOLvKmIqecP76gGtTVbbdgAorVfYqSvFzWjj8fHYyqr8qLPH+KFsQjpqa6le4obC
 bYb7yzdGHeAlc0s1lvgL0/1+VRXl6CrGxTtVJ5B0z8Cv1C8TCH4W/gmejobgIQwDbk1VOj7qdwm
 4aBuM3C9VsMpyfJN43ua2c1/jbUpHEPFKGJ9ges2kaDjDpeEtlOIgHn2fI8pHFhxETrUOpe71PE
 ZaM=
X-Received: by 2002:a05:6000:2c02:b0:47f:7635:e663 with SMTP id
 ffacd0b85a97d-47f7635e737mr11585524f8f.38.1784637341258; 
 Tue, 21 Jul 2026 05:35:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6b85970esm32243666f8f.15.2026.07.21.05.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:35:40 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 12:35:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: 5999125a3c2d172cc9356b7bd76f4218c226d7b3
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e04f03a26fa727f070d35d59ac67e61c45c37ca5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm9hR-0001kI-2h
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mudp: extract
 send_standalone_reply() helper
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3210610440613172241=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3210610440613172241==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sxjSjuewoH8="; charset=UTF-8

--sxjSjuewoH8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello flichtenhe=
ld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail

to look at the ne=
w patch set (#8)=2E

The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E


Change subject: mudp: extract send_standalon=
e_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

mudp: extract send_standalone_reply() helper

Factor the synchronous, =
stateless "send a standalone control packet back to the
peer that just cont=
acted us" sequence out of send_hmac_reset_packet() into a
reusable helper=
=2E No behavioural change=2E

This lets a following commit reuse it for the=
 out-of-band probe reply instead of
duplicating the aux_buf / to_link / pro=
cess_outgoing_link sequence=2E

Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268=
bba33889c
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn=
/mudp=2Ec
1 file changed, 37 insertions(+), 23 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/8

diff --git=
 a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2E2be085f 1=
00644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -37,6 +37,41=
 @@
 #include <sys/inotify=2Eh>
 #endif
 
+/**
+ * Send an already-built st=
andalone control packet back to the peer that just
+ * contacted us (c2=2Ef=
rom), synchronously and without keeping any state=2E
+ *
+ * We do not want=
 to keep state for a reply to an initial/out-of-band packet, so
+ * we send=
 it without queueing=2E If we hit EAGAIN on a busy socket the packet is
+ *=
 lost and the client simply retries -- an acceptable compromise that avoids=

+ * consuming server resources under attack=2E
+ *
+ * @param m       the =
server's multi_context
+ * @param buf     the packet to send (built by a tl=
s_*_standalone() helper)
+ * @param prefix  msg() prefix to set for the dur=
ation of the send
+ * @param detail  D_MULTI_DEBUG message describing the r=
eply
+ * @param sock    the socket to send the reply on
+ */
+static void
+=
send_standalone_reply(struct multi_context *m, struct buffer *buf, const ch=
ar *prefix,
+                      const char *detail, struct link_socket *=
sock)
+{
+    struct context *c =3D &m->top;
+
+    /* dco-win server requi=
res prepend with sockaddr, so preserve offset */
+    ASSERT(buf_init(&c->c=
2=2Ebuffers->aux_buf, buf->offset));
+    buf_copy(&c->c2=2Ebuffers->aux_bu=
f, buf);
+
+    msg_set_prefix(prefix);
+    c->c2=2Eto_link =3D c->c2=2Ebu=
ffers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
+    msg(D_MUL=
TI_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock);
+    c->c2=2E=
to_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D NULL;
+    msg_set_prefi=
x(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct multi_context *m,=
 struct tls_pre_decrypt_state *state,
                        struct tls_au=
th_standalone *tas, struct session_id *sid,
@@ -48,29 +83,8 @@
     struct =
buffer buf =3D tls_reset_standalone(&state->tls_wrap_tmp, tas, sid,
       =
                                       &state->peer_session_id, header, req=
uest_resend_wkc);
 
-    struct context *c =3D &m->top;
-
-    /* dco-win s=
erver requires prepend with sockaddr, so preserve offset */
-    ASSERT(buf=
_init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
-
-    buf_copy(&c->c2=2Eb=
uffers->aux_buf, &buf);
-
-    /*
-     * We do not want to keep any state =
here, so we send the reply to the
-     * initial packet synchronously with=
out queueing anything=2E
-     *
-     * If we hit EAGAIN on a busy socket,=
 the packet will be lost and the
-     * client will have to retransmit its=
 HARD_RESET=2E This is considered an
-     * acceptable compromise to avoid=
 consuming server resources under attack=2E
-     */
-    msg_set_prefix("C=
onnection Attempt");
-    c->c2=2Eto_link =3D c->c2=2Ebuffers->aux_buf;
-  =
  c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
-    msg(D_MULTI_DEBUG, "Reset pa=
cket from client, sending HMAC based reset challenge");
-    process_outgoi=
ng_link(c, sock);
-    c->c2=2Eto_link=2Elen =3D 0;
-    c->c2=2Eto_link_ad=
dr =3D NULL;
-    msg_set_prefix(NULL);
+    send_standalone_reply(m, &buf,=
 "Connection Attempt",
+                          "Reset packet from client=
, sending HMAC based reset challenge", sock);
 }
 
 

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba3388=
9c
Gerrit-Change-Number: 1743
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstip=
akov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom=
>

--sxjSjuewoH8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><p>The change is=
 no longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">mudp: extract send_standalone_reply() helper<br><br>Factor the =
synchronous, stateless &quot;send a standalone control packet back to the<b=
r>peer that just contacted us&quot; sequence out of send_hmac_reset_packet(=
) into a<br>reusable helper=2E No behavioural change=2E<br><br>This lets a =
following commit reuse it for the out-of-band probe reply instead of<br>dup=
licating the aux_buf / to_link / process_outgoing_link sequence=2E<br><br>C=
hange-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c<br>Signed-off-by: Lev S=
tipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 fil=
e changed, 37 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/8</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><sp=
an>index 9acf297=2E=2E2be085f 100644</span><br><span>--- a/src/openvpn/mudp=
=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -37,6 +3=
7,41 @@</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span> =
#endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Send an =
already-built standalone control packet back to the peer that just</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * contacted us (c2=2Efrom),=
 synchronously and without keeping any state=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * We do not want to keep state for a reply to an initial/out-of=
-band packet, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
we send it without queueing=2E If we hit EAGAIN on a busy socket the packet=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * lost and the =
client simply retries -- an acceptable compromise that avoids</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * consuming server resources und=
er attack=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m       the se=
rver&#39;s multi_context</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param buf     the packet to send (built by a tls_*_standalone() he=
lper)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pref=
ix  msg() prefix to set for the duration of the send</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param detail  D_MULTI_DEBUG message d=
escribing the reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param sock    the socket to send the reply on</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+send_standalone_reply(struct multi_context *m, struct buffer *buf, co=
nst char *prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                    const char *detail, struct link_socket *sock)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;m-&gt;top;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* dco-win server requires prepend with =
sockaddr, so preserve offset */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf-&g=
t;offset));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_=
copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg_set_prefix(prefix);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_l=
ink_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_MULTI_DEBUG, &quot;%s&quot;, detail);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link(c, soc=
k);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Et=
o_link=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    c-&gt;c2=2Eto_link_addr =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    msg_set_prefix(NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> static void</span><br><span> send_hmac_reset_packet=
(struct multi_context *m, struct tls_pre_decrypt_state *state,</span><br><s=
pan>                        struct tls_auth_standalone *tas, struct session=
_id *sid,</span><br><span>@@ -48,29 +83,8 @@</span><br><span>     struct bu=
ffer buf =3D tls_reset_standalone(&amp;state-&gt;tls_wrap_tmp, tas, sid,</s=
pan><br><span>                                              &amp;state-&gt;=
peer_session_id, header, request_resend_wkc);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &amp;m-=
&gt;top;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* dco-win server requires pre=
pend with sockaddr, so preserve offset */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf=
, buf=2Eoffset));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_copy(&amp;c-&gt;c=
2=2Ebuffers-&gt;aux_buf, &amp;buf);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * We do not want =
to keep any state here, so we send the reply to the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * initial packet synchronously without=
 queueing anything=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * If we hi=
t EAGAIN on a busy socket, the packet will be lost and the</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * client will have to retransmit =
its HARD_RESET=2E This is considered an</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * acceptable compromise to avoid consuming server re=
sources under attack=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_set_=
prefix(&quot;Connection Attempt&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuffers-&gt;aux_buf=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_li=
nk_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(D_MULTI_DEBUG, &quot;Reset packet from client, sending =
HMAC based reset challenge&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    process_outgoing_link(c, sock);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link=2Elen =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link_addr =3D NU=
LL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_set_prefix=
(NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    send_sta=
ndalone_reply(m, &amp;buf, &quot;Connection Attempt&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                          &quot;Rese=
t packet from client, sending HMAC based reset challenge&quot;, sock);</spa=
n><br><span> }</span><br><span> </span><br><span> </span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1743?usp=3Demail">change 1743</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1743?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1743 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--sxjSjuewoH8=--


--===============3210610440613172241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3210610440613172241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3210610440613172241==--

