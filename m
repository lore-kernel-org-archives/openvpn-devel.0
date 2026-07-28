Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E8BC54F4D
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oE2BUHYi4V+5a4ooaVV83iJIWilGXr8Ohm+pmPwo0Kw=; b=aGKbkgAtCFx5Euczn8jtOTeVe/
	duCwf0ebyoPmB6EnjMc76BPf8g9CItXD6YPdaFcXgUxadVqKlI01wLGIjylX/YKqJshXBRsu0cotM
	c0hUCEIuV0B4PDV6xHNXslGLfRVBYFuHPx5yeoLhNOj2XfhFF+lLmkX/JZSR3z8XVhT4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLX-0001aL-Vg;
	Tue, 28 Jul 2026 15:03:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLW-0001aF-PH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CWj0bTu4KjhLhzSmkClBAYzT5XFooYZuw27djHOz4k4=; b=V41BS2oL6qI5CsWM/kQau8RaKw
 gug2cqTqqRxeY81FJnuwWu8wN0SCzBcve9W/U7nXOYLJiWIlvv2mQfatDqdU6VWTM1JHTXcXdqNKo
 Q4HrSkZvo+4lxUBfbxWeEloO1OueaLBZ0Zcx4jEZvwIpJtEsT0NDVCYOjBC63EC/mu2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CWj0bTu4KjhLhzSmkClBAYzT5XFooYZuw27djHOz4k4=; b=S
 7Vz+ipMSnMbX7MixcVTXJCx5/cVS8orMoZmLNOfkYrLjmUxNJtj5pwCMTIEcA0fu/Bc2rkia9XlvM
 2Cjanfg74p0U4msbTnW35r+zfF1SsF038yPFc7rajsAuiH2iXXqp1wvVhnEhGMmwTtv45+KGSbvvy
 AIWd0+AVLA71goHI=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLQ-0000Nr-Kx for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:52 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so3106854f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251020; x=1785855820; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CWj0bTu4KjhLhzSmkClBAYzT5XFooYZuw27djHOz4k4=;
 b=KafuNEsnjXFZAMWo5xIxmWPWz5aG6C4vj/WorOqui4vaUNpFcK0QFUIudS2OuiifOe
 WcyGhKDZacTnwanvDFXP/R1Vu4Ji91Ri0ngIj2jOCXt7k+a/t3s25VDIEqDVgGpzdZ+u
 r1e5pZOsdMhzb+xfEPUWRQGFoPA/g+4Ws+bii/FLpGyf6R397+FmceWuSJdDQkBUi4o5
 iMklxCrKRcW9V9kfgK4WmWYM/XjqOSdM0g9P9daLHfq99eHSA16vurfXefdmEp/PdFhO
 ZSd3FUjFvenINKwdo0xVVf0Fs2BTwODghqGEc+eflHmKGkqc9xtdfnJhcCqydBO/qtd4
 p9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251020; x=1785855820;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CWj0bTu4KjhLhzSmkClBAYzT5XFooYZuw27djHOz4k4=;
 b=Di+/mR97UOIZxtUVErY26Dg9exzBsHQgLEz5eiUjFgZ+toblAusTyjqL+6/8RMwYwr
 z2/MwFG0xza6sbavQ9gn8t7YAp3K4jf5Pdv3en32wi/lHnXbGh8oNfi8qsp5uQJqGitm
 dPhOCX1WyazgbrsWF/ZqF2yULE+GVfpZPt0NU310Sf7wRVnXWNBPv4vRRFL6O60QBS7w
 +Yjz/kuaeFoBYeYZuM9dzlaFDvjcxcoeAAB5R+wqlW1yPE4xEnCVpz8INlCJtNTN7gqO
 zv6kXhftfLTjevnEtoHs2peMVj/rh69pl9akKZ0kHkSsgQYAygnPtqWjvjs56NX9QtLV
 25dg==
X-Gm-Message-State: AOJu0YyX2Iq/WoY43so1DBbmf0Ms21H0ryzj/k2jJKE+UpJZOPsXDbMc
 xGFNT2jlqUBXXE9NIgAddLDhW0YwBHM7mvTGiYseufJa1liErnY0SnCUHRyZvDRtvu8S+NG1VmI
 Tx8VLPAp42jKwcUmdL9AjxLMEI/1b1ohZSxoZjGS6Px8ckN/mGbU8RI/ZAUR8sCvF11/hZDPeMs
 88zEI80w==
X-Gm-Gg: AR+sD10rcfA+lH5WKdO2xwrhmY5AKQO5PFp+H4QU3gqrz4QU2RZo4EBpaj9reR43GZK
 p7jjAojumeiPD8rFLJwGoSVxi7O/3GdWx1Z3o5W7XVa4NjOzSgeEiw6KkEM7du9HmAQotMs5VsC
 fXUONz+8FU76I8jCjUTPtwUv0xv2gw6Y9cfNXizTI0mzAeh2Y0vVnG9h7GhwrBMQnfbfx9BaATJ
 9ect/X/u3JvMI4a9H7uow7r9V1HyqHasocLO2b7HqeAazhg7y0drDvBD2y1s4az0IDO6S6j+BgJ
 PLfeEXbj630VoiB0Jfi0r6LcmwTLGmoEGYyV1cy0nbYlGEl57aht7WD8KC0PRShnDZ2VA1qaQcl
 X4yEgxuvPj6OXC8Lx9uEdgB7fWaHsPZaMPqqppf9kwC/gjtC/Ysx7zAB7ZWmoPqcwKiFB9w0SEx
 rDbodTiB19xFx5R3pElhvCOrqzbXQnIP5gM3/MvdOdcj/nLU5zPEv8JOJ71zntP7xXO1FDkqC+u
 uOlyOcgrUJlUFtJnn25cGfqbRexy464mO4PtCIdZtlB6VZ8DAjvbNYhN3QLNtayJWDe
X-Received: by 2002:a05:6000:430d:b0:478:4de8:9b91 with SMTP id
 ffacd0b85a97d-47fb1eaae53mr3211691f8f.41.1785251019758; 
 Tue, 28 Jul 2026 08:03:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96d4656bsm42276135f8f.21.2026.07.28.08.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:39 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: d66ee893ec450b110a39d65e67190f452065b9eb
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <560158e38326169227bc06aba2e1f3969e1258bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLQ-0000Nr-Kx
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4665381192132199355=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4665381192132199355==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ln1BZggFSX8="; charset=UTF-8

--ln1BZggFSX8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello flichtenhe=
ld, ordex, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail

to look at=
 the new patch set (#9)=2E

The change is no longer submittable: checks~Che=
cksSubmitRule is unsatisfied now=2E


Change subject: mudp: extract send_st=
andalone_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

mudp: extract send_standalone_reply() helper

Factor the synchro=
nous, stateless "send a standalone control packet back to the
peer that jus=
t contacted us" sequence out of send_hmac_reset_packet() into a
reusable he=
lper=2E No behavioural change=2E

This lets a following commit reuse it for=
 the out-of-band probe reply instead of
duplicating the aux_buf / to_link /=
 process_outgoing_link sequence=2E

Change-Id: Ic75ca2ee9b59a4e11f37cd9653d=
f268bba33889c
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/ope=
nvpn/mudp=2Ec
1 file changed, 37 insertions(+), 23 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/9

diff -=
-git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2E2be08=
5f 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -37,6 +3=
7,41 @@
 #include <sys/inotify=2Eh>
 #endif
 
+/**
+ * Send an already-buil=
t standalone control packet back to the peer that just
+ * contacted us (c2=
=2Efrom), synchronously and without keeping any state=2E
+ *
+ * We do not =
want to keep state for a reply to an initial/out-of-band packet, so
+ * we =
send it without queueing=2E If we hit EAGAIN on a busy socket the packet is=

+ * lost and the client simply retries -- an acceptable compromise that av=
oids
+ * consuming server resources under attack=2E
+ *
+ * @param m       =
the server's multi_context
+ * @param buf     the packet to send (built by =
a tls_*_standalone() helper)
+ * @param prefix  msg() prefix to set for the=
 duration of the send
+ * @param detail  D_MULTI_DEBUG message describing t=
he reply
+ * @param sock    the socket to send the reply on
+ */
+static vo=
id
+send_standalone_reply(struct multi_context *m, struct buffer *buf, cons=
t char *prefix,
+                      const char *detail, struct link_sock=
et *sock)
+{
+    struct context *c =3D &m->top;
+
+    /* dco-win server r=
equires prepend with sockaddr, so preserve offset */
+    ASSERT(buf_init(&=
c->c2=2Ebuffers->aux_buf, buf->offset));
+    buf_copy(&c->c2=2Ebuffers->au=
x_buf, buf);
+
+    msg_set_prefix(prefix);
+    c->c2=2Eto_link =3D c->c2=
=2Ebuffers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
+    msg(=
D_MULTI_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock);
+    c->=
c2=2Eto_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D NULL;
+    msg_set_=
prefix(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct multi_contex=
t *m, struct tls_pre_decrypt_state *state,
                        struct t=
ls_auth_standalone *tas, struct session_id *sid,
@@ -48,29 +83,8 @@
     st=
ruct buffer buf =3D tls_reset_standalone(&state->tls_wrap_tmp, tas, sid,
  =
                                            &state->peer_session_id, header=
, request_resend_wkc);
 
-    struct context *c =3D &m->top;
-
-    /* dco-=
win server requires prepend with sockaddr, so preserve offset */
-    ASSER=
T(buf_init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
-
-    buf_copy(&c->c=
2=2Ebuffers->aux_buf, &buf);
-
-    /*
-     * We do not want to keep any s=
tate here, so we send the reply to the
-     * initial packet synchronously=
 without queueing anything=2E
-     *
-     * If we hit EAGAIN on a busy so=
cket, the packet will be lost and the
-     * client will have to retransmi=
t its HARD_RESET=2E This is considered an
-     * acceptable compromise to =
avoid consuming server resources under attack=2E
-     */
-    msg_set_pref=
ix("Connection Attempt");
-    c->c2=2Eto_link =3D c->c2=2Ebuffers->aux_buf=
;
-    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
-    msg(D_MULTI_DEBUG, "Res=
et packet from client, sending HMAC based reset challenge");
-    process_o=
utgoing_link(c, sock);
-    c->c2=2Eto_link=2Elen =3D 0;
-    c->c2=2Eto_li=
nk_addr =3D NULL;
-    msg_set_prefix(NULL);
+    send_standalone_reply(m, =
&buf, "Connection Attempt",
+                          "Reset packet from c=
lient, sending HMAC based reset challenge", sock);
 }
 
 

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bb=
a33889c
Gerrit-Change-Number: 1743
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--ln1BZggFSX8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
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
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/9</pr=
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
 style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--ln1BZggFSX8=--


--===============4665381192132199355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4665381192132199355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4665381192132199355==--

