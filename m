Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C187C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4QQ7HV4fCInCnUF9uGn0Ly3Y5oKTXCyKWRHFmmMrTs=; b=k2ijyG2GaZlm5sqzmGzPgywA5w
	JBIRSwRKAPiRRbJ+XW7QBOwcbbBgziwevC63WSdAX8eTCirZnW5fkGdH2AIqZS2bkzLxiJ3hcWX41
	veTJOGOUfWz/Ef/UmD4Z9hA59ibpRJPtRC6yK9B0uxSEjpwgO0mwlu2e9/CSIra/qLTU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wruiA-0000wi-Ch;
	Thu, 06 Aug 2026 09:48:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrui0-0000vy-Aa
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:48:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZfMoTsKFBb2C38K61inD3p99YZJ1PUEBthF4oaGk2Tw=; b=JuJ2F+Q+HiEBpSGG5fBX3UZig1
 x0GDbT7R6ZLRtYEIaJ8ncFw7gpSVduEE0Xh7DPuVZnO/d0DWg0Qr9jTXrptweQzakyw/1oAmW8ewi
 Rc/1NqUFR/DO2Cy3rLyoCkSh7p2CayrH22mhjtI50jhMXXAbSfy5dTHkh0HN5qNk5OzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZfMoTsKFBb2C38K61inD3p99YZJ1PUEBthF4oaGk2Tw=; b=R
 V6UinFVF+sm+66FljQAetkIdDoMAaJCEiVhFRiZCxj9Bdwq7SepVt9PI9yacUUXG+PQ1oeal3fASE
 wfuTS4UVdaOX6HaOx6HgaM8hhtVEKM4ecSjbsGpzk2g3DHKlGu87KziqbTaoMi6+EmewaJpmwZpkr
 jUKR59bDsbzTzyQw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wruhw-00038f-39 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:48:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so1477860f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786009685; x=1786614485; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZfMoTsKFBb2C38K61inD3p99YZJ1PUEBthF4oaGk2Tw=;
 b=GIwE3qIB/uyEuexjqPghkIsRcE9+e87aqHalmHsphYjA4SvjrIBeWbclUS1/CmeUNF
 CX9o+IhAYedAW+HToMdDcLlM1q/NfCYjeMxKcSH9PbReTTOmgncuiQHTLJ89bSpagW1H
 HlsZjhl9iqzZKkyEFJLJlT2/wCQ0O5FOEgaDO2zWzL4OB2PqUY37p4RPJzz8UwgNUez/
 K0RZ5QOv9Jkt7pTTY+MPfBaLhs35fSMSlRpJZh03xp8uadej7Fz8wz1LxQaqIrPu8UII
 nyVbyhY+ueFIwMmu/ivFq9gwzGNDHxQrSfCs1kZpvKUqUGBzie60iG7LwWfWvsa2iTjF
 8F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786009685; x=1786614485;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZfMoTsKFBb2C38K61inD3p99YZJ1PUEBthF4oaGk2Tw=;
 b=TYupZwFHVmnFLbJUfZWgl4Pt30uLHlPVl6fCe2ap5fwWYZODm1yly2KbNvnh33eifC
 JiJ0+m/HlQzVhR2aRWVCXeSHvyilqAtpiwvYgHZhS9o6XtGqh+GPqPlR37ztCDR6JU1H
 NPksuNkKRyYvuDwHisNKjSuPGNwycrOnWUIjDZ84hNVufJQumm6YtmIvTzGnm62o0N8f
 dR6Snh3DuS7yYpkv90Ae7q7WoI/HfDITRvSkyqAyvUljkj5DQJOt4si4SNOCVnQn0xo5
 UB5/4NokDvur2nqy7z4iaMyTQf2Egqn2Qccdgi2z+iwsVx0Gopc6qcZH8hJsAD7HqpNc
 vGgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5JHSpGSdP3lr2wlQq3aFdg3UDjOJN0GWSHcS1t1hdZkjYVrjmM0CrpFexqUX9v1Ps+5Tdeb9liecbd6nA@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx9xGlDEO6eFNSEe8u33N2lTbYhSfwtBqZaBfyPeoVMOAQ7yqPN
 2Rv0pwUrZhvvWWgVxio2ergVAb/jYpLwcTTbgJiBbOPsunEDfbPUA/4Dabi0//t1NR2iFc7Ea8c
 zS3lMpqDuAkhY8afjrKOZICeo+Ux2CTVsqsKBvLyiZWlxUnrPA3ytLxk9okBhkWzWkCxQ
X-Gm-Gg: AR+sD12mzglZRNTHPRd/j2ZPHARNMWwSMlaD+EQCo58fyi8p4HQzmGc/RpQKM6RDPDQ
 IILzZNQUgp6GfYMwSXxDe04sdcZZmJoZG3nz88sZJeaLnn4TXkTADB+1z6MGmk0CpQF1T1qBVm6
 IEgNE0sDPNTYdJdCUNHvywPBmm6wwDH5Qm7O2zBFw8L9Ym3/KdOYAyAHBxDVtFQcWvLin2xmvTj
 0LluSzNRl5FkiaQXN+z7D0IGqIIunC7iEHD9ugSxK210U20Cveab84b7Aq8OffsWo+kdOWd6/PC
 78DZ2AwwubzuzHqKptU88zIKKxHMh4qh7lJtm03RmLOJv73qmZEr3I39iMzmqa5TW2LOhBvRxvY
 FR16YM6BmU38oeSkaQdRX5kXHJHlXi99tHBwg1oPkLaP79L4F1kuVzM8QxeRIePrReucY9Z7DOC
 hbDtK7PJZNt4JApyosVcQdnNg6mSj/ylcqpPSJJU4MfyGTws/8saEUV2WCA+7ammv7jtN5rZ71N
 SFRVNRq+z1HU3HcBF08W9hexhhc/vB9HZ61pxtKvjNKJZZL0O44isVtOZveW4WlJjpXiVVC2nbB
 6YxU1ERceoTutIoc82jGmfcQW9dvGkSdHI0qhQdERNO5f8OlUGg=
X-Received: by 2002:adf:e010:0:10b0:47f:8b24:ef01 with SMTP id
 ffacd0b85a97d-47fec4e7851mr18011568f8f.1.1786009685371; 
 Thu, 06 Aug 2026 02:48:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b18091sm4625479f8f.21.2026.08.06.02.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:48:04 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 09:48:04 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: d169af7f831ea2c20e2c633fe426e51b91b397b3
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <577be4f0d89b969a672b9f80989f43d5dcb7ae91-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wruhw-00038f-39
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0921185147833039306=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0921185147833039306==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="No2Q0YKZwM4="; charset=UTF-8

--No2Q0YKZwM4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1743?usp=3Demail )

Change subject: mudp: extract send_standalone_reply=
() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m=
udp: extract send_standalone_reply() helper

Factor the synchronous, statel=
ess "send a standalone control
packet back to the peer that just contacted =
us" sequence out of
send_hmac_reset_packet() into a reusable helper=2E No b=
ehavioural change=2E

This lets a following commit reuse it for the out-of-=
band probe reply
instead of duplicating the aux_buf / to_link / process_out=
going_link
sequence=2E

Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889=
c
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Acked-by: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743
Message=
-Id: <20260805134614=2E163847-1-frank@lichtenheld=2Ecom>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38134=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
mudp=2Ec
1 file changed, 37 insertions(+), 23 deletions(-)




diff --git a=
/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2E2be085f 100=
644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -37,6 +37,41 @=
@
 #include <sys/inotify=2Eh>
 #endif
 
+/**
+ * Send an already-built stan=
dalone control packet back to the peer that just
+ * contacted us (c2=2Efro=
m), synchronously and without keeping any state=2E
+ *
+ * We do not want t=
o keep state for a reply to an initial/out-of-band packet, so
+ * we send i=
t without queueing=2E If we hit EAGAIN on a busy socket the packet is
+ * l=
ost and the client simply retries -- an acceptable compromise that avoids
+=
 * consuming server resources under attack=2E
+ *
+ * @param m       the se=
rver's multi_context
+ * @param buf     the packet to send (built by a tls_=
*_standalone() helper)
+ * @param prefix  msg() prefix to set for the durat=
ion of the send
+ * @param detail  D_MULTI_DEBUG message describing the rep=
ly
+ * @param sock    the socket to send the reply on
+ */
+static void
+se=
nd_standalone_reply(struct multi_context *m, struct buffer *buf, const char=
 *prefix,
+                      const char *detail, struct link_socket *so=
ck)
+{
+    struct context *c =3D &m->top;
+
+    /* dco-win server require=
s prepend with sockaddr, so preserve offset */
+    ASSERT(buf_init(&c->c2=
=2Ebuffers->aux_buf, buf->offset));
+    buf_copy(&c->c2=2Ebuffers->aux_buf=
, buf);
+
+    msg_set_prefix(prefix);
+    c->c2=2Eto_link =3D c->c2=2Ebuf=
fers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
+    msg(D_MULT=
I_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock);
+    c->c2=2Et=
o_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D NULL;
+    msg_set_prefix=
(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct multi_context *m, =
struct tls_pre_decrypt_state *state,
                        struct tls_aut=
h_standalone *tas, struct session_id *sid,
@@ -48,29 +83,8 @@
     struct b=
uffer buf =3D tls_reset_standalone(&state->tls_wrap_tmp, tas, sid,
        =
                                      &state->peer_session_id, header, requ=
est_resend_wkc);
 
-    struct context *c =3D &m->top;
-
-    /* dco-win se=
rver requires prepend with sockaddr, so preserve offset */
-    ASSERT(buf_=
init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
-
-    buf_copy(&c->c2=2Ebu=
ffers->aux_buf, &buf);
-
-    /*
-     * We do not want to keep any state h=
ere, so we send the reply to the
-     * initial packet synchronously witho=
ut queueing anything=2E
-     *
-     * If we hit EAGAIN on a busy socket, =
the packet will be lost and the
-     * client will have to retransmit its =
HARD_RESET=2E This is considered an
-     * acceptable compromise to avoid =
consuming server resources under attack=2E
-     */
-    msg_set_prefix("Co=
nnection Attempt");
-    c->c2=2Eto_link =3D c->c2=2Ebuffers->aux_buf;
-   =
 c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
-    msg(D_MULTI_DEBUG, "Reset pac=
ket from client, sending HMAC based reset challenge");
-    process_outgoin=
g_link(c, sock);
-    c->c2=2Eto_link=2Elen =3D 0;
-    c->c2=2Eto_link_add=
r =3D NULL;
-    msg_set_prefix(NULL);
+    send_standalone_reply(m, &buf, =
"Connection Attempt",
+                          "Reset packet from client,=
 sending HMAC based reset challenge", sock);
 }
 
 

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
Ger=
rit-Change-Number: 1743
Gerrit-PatchSet: 12
Gerrit-Owner: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>

--No2Q0YKZwM4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1743?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">mudp: extract send_standalone_reply() help=
er<br><br>Factor the synchronous, stateless &quot;send a standalone control=
<br>packet back to the peer that just contacted us&quot; sequence out of<br=
>send_hmac_reset_packet() into a reusable helper=2E No behavioural change=
=2E<br><br>This lets a following commit reuse it for the out-of-band probe =
reply<br>instead of duplicating the aux_buf / to_link / process_outgoing_li=
nk<br>sequence=2E<br><br>Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba3388=
9c<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Antonio Quartu=
lli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1743<br>Message-Id: &lt;20260805134614=2E163847-1-frank@=
lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg38134=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 file =
changed, 37 insertions(+), 23 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 9acf297=2E=
=2E2be085f 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><spa=
n>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -37,6 +37,41 @@</span><br><=
span> #include &lt;sys/inotify=2Eh&gt;</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Send an already-built stand=
alone control packet back to the peer that just</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * contacted us (c2=2Efrom), synchronously and =
without keeping any state=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * We do=
 not want to keep state for a reply to an initial/out-of-band packet, so</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we send it without =
queueing=2E If we hit EAGAIN on a busy socket the packet is</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * lost and the client simply retri=
es -- an acceptable compromise that avoids</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * consuming server resources under attack=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param m       the server&#39;s multi_=
context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param bu=
f     the packet to send (built by a tls_*_standalone() helper)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param prefix  msg() prefix =
to set for the duration of the send</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param detail  D_MULTI_DEBUG message describing the repl=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sock    =
the socket to send the reply on</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_standal=
one_reply(struct multi_context *m, struct buffer *buf, const char *prefix,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
  const char *detail, struct link_socket *sock)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct context *c =3D &amp;m-&gt;top;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* dco-win server requires prepend with sockaddr, so pre=
serve offset */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf-&gt;offset));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_copy(&amp;c-&gt;=
c2=2Ebuffers-&gt;aux_buf, buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
_set_prefix(prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link_addr =3D &am=
p;c-&gt;c2=2Efrom;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_MULTI_DEBUG, &quot;%s&quot;, detail);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    process_outgoing_link(c, sock);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link=2Elen =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Et=
o_link_addr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg_set_prefix(NULL);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static void</span><br><span> send_hmac_reset_packet(struct multi_co=
ntext *m, struct tls_pre_decrypt_state *state,</span><br><span>            =
            struct tls_auth_standalone *tas, struct session_id *sid,</span>=
<br><span>@@ -48,29 +83,8 @@</span><br><span>     struct buffer buf =3D tls=
_reset_standalone(&amp;state-&gt;tls_wrap_tmp, tas, sid,</span><br><span>  =
                                            &amp;state-&gt;peer_session_id,=
 header, request_resend_wkc);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct context *c =3D &amp;m-&gt;top;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* dco-win server requires prepend with sockad=
dr, so preserve offset */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf=2Eoffset))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;=
aux_buf, &amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * We do not want to keep any stat=
e here, so we send the reply to the</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * initial packet synchronously without queueing anything=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * If we hit EAGAIN on a busy=
 socket, the packet will be lost and the</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * client will have to retransmit its HARD_RESET=2E =
This is considered an</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * acceptable compromise to avoid consuming server resources under atta=
ck=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg_set_prefix(&quot;Conne=
ction Attempt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link_addr =3D &amp;c=
-&gt;c2=2Efrom;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_MULTI_DEBUG, &quot;Reset packet from client, sending HMAC based reset c=
hallenge&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
rocess_outgoing_link(c, sock);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    c-&gt;c2=2Eto_link=2Elen =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link_addr =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg_set_prefix(NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    send_standalone_reply(m, &=
amp;buf, &quot;Connection Attempt&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                          &quot;Reset packet from clie=
nt, sending HMAC based reset challenge&quot;, sock);</span><br><span> }</sp=
an><br><span> </span><br><span> </span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Dem=
ail">change 1743</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1743?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1743 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--No2Q0YKZwM4=--


--===============0921185147833039306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0921185147833039306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0921185147833039306==--

