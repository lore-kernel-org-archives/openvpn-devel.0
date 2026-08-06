Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B380C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHBsVBnW3lGaFcd60U7LTj8K6O/NWDN8Pf5tNpzcmYQ=; b=LSDq0v7rRqc4L6QpvRwZV7B9vD
	S3ewxfuMhCF1RwVtPu/bff0bg4hYW5RMQzVuUc4MtqvFPAj2U026jN7PPoD2ljfvKYxx6ceWvRZwR
	Qk4Y3ZDkAolyJcR6WF1zV+6w9Hj3hqkTXSzOIUFQzCTI4BtuEygZEZpI1FgWd9+5mcSQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wruiA-0001ca-45;
	Thu, 06 Aug 2026 09:48:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrui7-0001cG-SA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fB61hrBpIkLXltIhK9huinD3Y7Bt49AzczuTpejijAQ=; b=FfmcsEZ1Ohl78h4CrXArRCktk/
 /dd9gcBDtqOF5LpFEaswABwNYSytXGWoxZij+y8tRia+FBBdAGkhNQTrhUtBJU62VXS58CUxqS3SI
 LsKEFbgQTnCLZw1NheaCKBu6yNxo3qUydvlpUiJj490wkBWmqqnRUXXxaSArBkBVPzcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fB61hrBpIkLXltIhK9huinD3Y7Bt49AzczuTpejijAQ=; b=c
 Pk46E7adn2TS9oweU1ZwfnHxcCpt7XZGyRObTAx33V7OkauZXFj8C+o4OlxDwvgwTwKuSLLxipLf4
 Wkc5O189S5mc7Zxa05d/79gpAnQaGac+NNwPKQHV1FSc1/PeMAQgx3BVut4hQIHJsO/xil3VBzW3n
 P6b352YUdY+5ESjE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wruhu-00038Z-JI for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:48:12 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so7690555e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786009684; x=1786614484; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fB61hrBpIkLXltIhK9huinD3Y7Bt49AzczuTpejijAQ=;
 b=Si/J3oVZZiyr8Wr/6W4uBrIjulR0Jj7WVIPfDMrmvUOiiZZ+qmNl1Wq2LfI1Z9cYCo
 bz+I175bx//XNOwEHvRB1UhebTjfA2MrDT0rsuBIApaKcyUeAzsEC9mMhHxrHoTmX3en
 UURK6EaBfTZ1XJEjoBBaJdXYFOw2tJ27auBCEMQvL8L3Or0uQdXFK/vgkr63TBrwEGR8
 Ht1slpNPMnu69rQ+6RtoAu+8VB0KnzMGZO7NmRRzbs9DjbhqXJJQK03WDxDVPVR8Yjdf
 qGIQtXN63osfA0+mm4DEZY+16viylU0UXwB0L88HQrNW4s1pDnw0qv/atKunm3wfwLPu
 GOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786009684; x=1786614484;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fB61hrBpIkLXltIhK9huinD3Y7Bt49AzczuTpejijAQ=;
 b=QX2r6Pn5eW7e8oY/Ct4pD9JMB+pZxqShU9BBviQ9c6HrpFpZhEr2Z56YS+hLHPMQ+s
 +8q+k/6QDqHpReNykcaAxX6rAZeY1TLkkk2d6td7Clwp6y75z4izG+v5S/nZoUAVk1T0
 Ng97hyqlnq7GVHXVnBV9O0vTJgG8Mw2Q6mcWzBgn10t22/wVKr3FRpsNZSBhiadCfgRg
 iCe4v3NbmFgpuqRIABG/aP0/FiQR6kklQGt6jle6DMO1KdGPT82o1HdsOQmhcstvaXtc
 qRjwprBMh+Pu4G0MoD0VPMFKe1ikmF5x5ATIhphkqEPTCWTy2Rhbkg9QoNFsy2FLo/NA
 Kyhg==
X-Gm-Message-State: AOJu0YxHWYnAf46eSO4h2xeH746Z+XDtDHjvKVce+jEL/l+jlWQ3WRF5
 VFlTTL5OiJvfvrjo/zEWtLVihvp+0VyX2rCSM8xQTxmZS5/S8vapLc6sNtl2XZ3OHU+epPiZ1fU
 2igD5Vk1V3EtrjGFsxJw16DXRBIKazjuPx11Md4XNK4k5ID0zBz0SY5ov49mMypUhcKX9
X-Gm-Gg: AR+sD11LopItkIM02M71Hb0zsIIrM5OqR+bLMLMZt/MF9jWErIGp4394szSOoZBjtT2
 Hy/+3X4BwQ0iR56K5lNFa41+qGkhqosz9MPBVe+06v/JRHQ8dd+oaGuIRb2jvSfgBiqtLnvDafY
 vPytCLfhiUfqvVc4NgUl/j8p73DSxpVZ/E6S6vqLGMIzzVGastfu/Rbee/JSjPBG0FXBzMBAQkC
 al1LlgyfhPpnyQERA4Q1ZQQ4ZphVIcAvG5/Hz0T2Yef639jF/2oBOtIJ5njORcCXnaqQ4tj8oH+
 g79ago0ABWX9dY3XF5Zpsr8+gnXPY16flcC112G1dzKPPNtTQXnArztsbwP439+9SNfEitLCXTo
 HK9Rh1W8aLbM/b8MGlukcvlnsnj3omkRlH+W0Vr8VW6ENf3/q9Ex982nycdxvP1BGa/4wZuJlzG
 MT4Vh2XID89ku1aZmsGH9p20ZikQpE8JyWaeJ1Hl7HYDH5LKO85y61I46nokcJ/KK+lDS18z+LD
 zUjZFmqqCB/jlZgXGn5mO8cFn1Q+JVAmfAQeQ8uNm/x5rWVErpUIsulwL1AApNpkWFvQc8Z8Ap/
 IMUEr/u1QRPWZ6oEIk7qA8/wMaaqNohWfUkxO6Rovcn42zLDKZ8=
X-Received: by 2002:a05:600c:811b:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-499553e60d8mr25038345e9.7.1786009683441; 
 Thu, 06 Aug 2026 02:48:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542183b2sm56088565e9.4.2026.08.06.02.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:48:02 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 09:48:00 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: d169af7f831ea2c20e2c633fe426e51b91b397b3
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <577be4f0d89b969a672b9f80989f43d5dcb7ae91-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wruhu-00038Z-JI
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7649584538278691891=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7649584538278691891==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RjRJbGbAqAo="; charset=UTF-8

--RjRJbGbAqAo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#12) to the change originally created b=
y stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail )

=
The following approvals got outdated and were removed:
Code-Review+2 by fli=
chtenheld, Code-Review+2 by ordex


Change subject: mudp: extract send_stan=
dalone_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

mudp: extract send_standalone_reply() helper

Factor the synchro=
nous, stateless "send a standalone control
packet back to the peer that jus=
t contacted us" sequence out of
send_hmac_reset_packet() into a reusable he=
lper=2E No behavioural change=2E

This lets a following commit reuse it for=
 the out-of-band probe reply
instead of duplicating the aux_buf / to_link /=
 process_outgoing_link
sequence=2E

Change-Id: Ic75ca2ee9b59a4e11f37cd9653d=
f268bba33889c
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Antonio Quartulli <anton=
io@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1743
Message-Id: <20260805134614=2E163847-1-frank@lichtenheld=2Ecom>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
38134=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sr=
c/openvpn/mudp=2Ec
1 file changed, 37 insertions(+), 23 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/12

=
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=
=2E2be085f 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ =
-37,6 +37,41 @@
 #include <sys/inotify=2Eh>
 #endif
 
+/**
+ * Send an alre=
ady-built standalone control packet back to the peer that just
+ * contacte=
d us (c2=2Efrom), synchronously and without keeping any state=2E
+ *
+ * We=
 do not want to keep state for a reply to an initial/out-of-band packet, so=

+ * we send it without queueing=2E If we hit EAGAIN on a busy socket the p=
acket is
+ * lost and the client simply retries -- an acceptable compromise=
 that avoids
+ * consuming server resources under attack=2E
+ *
+ * @param =
m       the server's multi_context
+ * @param buf     the packet to send (b=
uilt by a tls_*_standalone() helper)
+ * @param prefix  msg() prefix to set=
 for the duration of the send
+ * @param detail  D_MULTI_DEBUG message desc=
ribing the reply
+ * @param sock    the socket to send the reply on
+ */
+s=
tatic void
+send_standalone_reply(struct multi_context *m, struct buffer *b=
uf, const char *prefix,
+                      const char *detail, struct l=
ink_socket *sock)
+{
+    struct context *c =3D &m->top;
+
+    /* dco-win =
server requires prepend with sockaddr, so preserve offset */
+    ASSERT(bu=
f_init(&c->c2=2Ebuffers->aux_buf, buf->offset));
+    buf_copy(&c->c2=2Ebuf=
fers->aux_buf, buf);
+
+    msg_set_prefix(prefix);
+    c->c2=2Eto_link =
=3D c->c2=2Ebuffers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
=
+    msg(D_MULTI_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock);=

+    c->c2=2Eto_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D NULL;
+   =
 msg_set_prefix(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct mul=
ti_context *m, struct tls_pre_decrypt_state *state,
                       =
 struct tls_auth_standalone *tas, struct session_id *sid,
@@ -48,29 +83,8 @=
@
     struct buffer buf =3D tls_reset_standalone(&state->tls_wrap_tmp, tas=
, sid,
                                              &state->peer_session_i=
d, header, request_resend_wkc);
 
-    struct context *c =3D &m->top;
-
-  =
  /* dco-win server requires prepend with sockaddr, so preserve offset */
-=
    ASSERT(buf_init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
-
-    buf_c=
opy(&c->c2=2Ebuffers->aux_buf, &buf);
-
-    /*
-     * We do not want to k=
eep any state here, so we send the reply to the
-     * initial packet sync=
hronously without queueing anything=2E
-     *
-     * If we hit EAGAIN on =
a busy socket, the packet will be lost and the
-     * client will have to =
retransmit its HARD_RESET=2E This is considered an
-     * acceptable compr=
omise to avoid consuming server resources under attack=2E
-     */
-    msg=
_set_prefix("Connection Attempt");
-    c->c2=2Eto_link =3D c->c2=2Ebuffers=
->aux_buf;
-    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
-    msg(D_MULTI_DE=
BUG, "Reset packet from client, sending HMAC based reset challenge");
-    =
process_outgoing_link(c, sock);
-    c->c2=2Eto_link=2Elen =3D 0;
-    c->c=
2=2Eto_link_addr =3D NULL;
-    msg_set_prefix(NULL);
+    send_standalone_=
reply(m, &buf, "Connection Attempt",
+                          "Reset pack=
et from client, sending HMAC based reset challenge", sock);
 }
 
 

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd96=
53df268bba33889c
Gerrit-Change-Number: 1743
Gerrit-PatchSet: 12
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--RjRJbGbAqAo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #12</strong> to the change originally created by stipa=2E</=
p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by flichtenheld, Code-Review+2 by ordex</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">m=
udp: extract send_standalone_reply() helper<br><br>Factor the synchronous, =
stateless &quot;send a standalone control<br>packet back to the peer that j=
ust contacted us&quot; sequence out of<br>send_hmac_reset_packet() into a r=
eusable helper=2E No behavioural change=2E<br><br>This lets a following com=
mit reuse it for the out-of-band probe reply<br>instead of duplicating the =
aux_buf / to_link / process_outgoing_link<br>sequence=2E<br><br>Change-Id: =
Ic75ca2ee9b59a4e11f37cd9653df268bba33889c<br>Signed-off-by: Lev Stipakov &l=
t;lev@openvpn=2Enet&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743<br>Message-I=
d: &lt;20260805134614=2E163847-1-frank@lichtenheld=2Ecom&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38134=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/mudp=2Ec<br>1 file changed, 37 insertions(+), 23 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/43/1743/12</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2E=
c b/src/openvpn/mudp=2Ec</span><br><span>index 9acf297=2E=2E2be085f 100644<=
/span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvp=
n/mudp=2Ec</span><br><span>@@ -37,6 +37,41 @@</span><br><span> #include &lt=
;sys/inotify=2Eh&gt;</span><br><span> #endif</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Send an already-built standalone control pack=
et back to the peer that just</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * contacted us (c2=2Efrom), synchronously and without keeping an=
y state=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * We do not want to keep =
state for a reply to an initial/out-of-band packet, so</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * we send it without queueing=2E If we =
hit EAGAIN on a busy socket the packet is</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * lost and the client simply retries -- an acceptabl=
e compromise that avoids</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * consuming server resources under attack=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param m       the server&#39;s multi_context</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param buf     the packet to =
send (built by a tls_*_standalone() helper)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param prefix  msg() prefix to set for the durat=
ion of the send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param detail  D_MULTI_DEBUG message describing the reply</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param sock    the socket to send t=
he reply on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+send_standalone_reply(struct mul=
ti_context *m, struct buffer *buf, const char *prefix,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                      const char *detail=
, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 context *c =3D &amp;m-&gt;top;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
dco-win server requires prepend with sockaddr, so preserve offset */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;c=
-&gt;c2=2Ebuffers-&gt;aux_buf, buf-&gt;offset));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_b=
uf, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg_set_prefix(prefix);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_lin=
k =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_DEBUG, =
&quot;%s&quot;, detail);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    process_outgoing_link(c, sock);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    c-&gt;c2=2Eto_link=2Elen =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link_addr =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_set_prefix(N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</s=
pan><br><span> send_hmac_reset_packet(struct multi_context *m, struct tls_p=
re_decrypt_state *state,</span><br><span>                        struct tls=
_auth_standalone *tas, struct session_id *sid,</span><br><span>@@ -48,29 +8=
3,8 @@</span><br><span>     struct buffer buf =3D tls_reset_standalone(&amp=
;state-&gt;tls_wrap_tmp, tas, sid,</span><br><span>                        =
                      &amp;state-&gt;peer_session_id, header, request_resen=
d_wkc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct context *c =3D &amp;m-&gt;top;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* dco-win server requires prepend with sockaddr, so preserve offset=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_ini=
t(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf=2Eoffset));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, &amp;buf);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * We do not want to keep any state here, so we send t=
he reply to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 initial packet synchronously without queueing anything=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * If we hit EAGAIN on a busy socket, the packet =
will be lost and the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * client will have to retransmit its HARD_RESET=2E This is considered a=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * acceptable co=
mpromise to avoid consuming server resources under attack=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg_set_prefix(&quot;Connection Attempt&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_li=
nk =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_DEBUG, &qu=
ot;Reset packet from client, sending HMAC based reset challenge&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_link=
(c, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c=
2=2Eto_link=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    c-&gt;c2=2Eto_link_addr =3D NULL;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    msg_set_prefix(NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    send_standalone_reply(m, &amp;buf, &quot;Conne=
ction Attempt&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          &quot;Reset packet from client, sending HMAC bas=
ed reset challenge&quot;, sock);</span><br><span> }</span><br><span> </span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">change 1743</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic75c=
a2ee9b59a4e11f37cd9653df268bba33889c </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1743 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RjRJbGbAqAo=--


--===============7649584538278691891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7649584538278691891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7649584538278691891==--

