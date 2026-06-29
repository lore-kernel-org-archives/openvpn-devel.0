Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C64BC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ozhpMOkMFVoxcWKyfE80mxOPiBbH1G5EJG7omt6KzWo=; b=BDjSq/F0cLW8b+
	XN91Jo8P8KNlRHE57eQqotTQ9sMa5CCjPfrJHBIeSPvSWAO4nqW3n4sLSv5DjyzKkdbYzfdz9TmDj
	F5X3RnOQEKGPSiYBmpBgk5fJkbyBfar4pmUjBApAaYu/hfSiQqihXDnGj61k23PVyIpPC72CoRib+
	e40=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6te-0006Wl-PY;
	Mon, 29 Jun 2026 07:59:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tc-0006WZ-Kd
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MHWWz+jxLKITZ9U+g7RkAY6sWIrZ2YGPyTiekRUzM7g=; b=MO1i7C+JEKwvTJONq6w2SAquMO
 vbSrOZwoZpLK9AtGlZNcIt6FCDdl90KMa7+owtjt49ONFeQ2se9IOrzyp45XxDIzYJqaiIsz2PE1q
 Twxcrj8K75w5uHK26AAUDUHzpxwPVBMfal1BxvwQNGp19CWXXZol7pWmoib4K7tmLzUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MHWWz+jxLKITZ9U+g7RkAY6sWIrZ2YGPyTiekRUzM7g=; b=R
 5T2eT9MGap373S8Rh4gQDhK3aQwYc7fdpzXBSgj5fsG2yh3cBg4+nrti/NYg4V+ehOwxJ/83HfBny
 wNBdFp8F0l+EcBz+Xy0c8wNAEP1RVT3YSU7JiKGUtL6RF9snwlzfwKodqUECA4Mt5sa2C8k3FbJft
 CkaFrX5c4/qpC8S8=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tY-0008NS-C9 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:10 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso38870585e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719937; x=1783324737; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHWWz+jxLKITZ9U+g7RkAY6sWIrZ2YGPyTiekRUzM7g=;
 b=BcaD/k72PIzwnsU2kCos0EahVBUv7ZxHhsMUqyIxfm/CGXo6gL+clrGJcCVExj52zN
 SZYRLYbDBpIAB3RQwhlEyofFxO03ahDoxt1N+3LOgAObOQwSizLvYVF63GLuDBji0jXa
 Wjld60IzF2USjF124GCh5fowLCVgErV/w1C1ft+KaBO1Cir3l47UAerrXdGkYyp0Echa
 Zj00aISBj1WPbA8biR2/d4wSEFlNl0umFPxA9izgVZbwB5o9jdt3+FyXbetZCNbDNNe9
 DdvaZ60pDdtqTsncEVrsSpKcDLOyzOq+Ydt5wNDd+mlhxxQYZS22mQoNrG1zsO0OOrBF
 7ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719937; x=1783324737;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHWWz+jxLKITZ9U+g7RkAY6sWIrZ2YGPyTiekRUzM7g=;
 b=nUiysS/Ek/3b3TU94tbDdfdXUVmngo9DNYrax5hgS7Yn+Ct9vJf/o6PKl3datxXPbp
 BjMGYZtqwGu3GOSOOya5qqa/Hqde6s4Dcf6vl9yWyYI4cB9zi7oKO0IlQ+KeSFo6NvQt
 6O35VWpc6ViBjkV1mVd54MIxTq0QAe+Cp4fqQsjgNZd3oO4Qha3q5gaYLoLyY3Fh8i/X
 1lKHYHCZwrtd9drgj7fMavdh8cnq3+eagzg8nbDfwPeiU7D3QRxwQXOLZsjUZ9PuhJSx
 mhHvP3DTy9Qu3rGAizV1YA9gT/JvMQohEDjxwuyzkj2xx1WzZe3ihCp1HBWEoV6aKgTM
 n0JA==
X-Gm-Message-State: AOJu0YyhhrBd/n+2hM43HFB3RZ/tVeGdwCqkBiE4NY2gN9fF6ipFV1kn
 FUie1aiERGBcE3ohRej0qYrsj9vYHdWV4nyod8M8bq0OGU0Rhj0LH3CCzp4WxyTa+TNPKA3pq5n
 o8Yaue9DuoBDwmnSb2/dDdAqiha/Kb15FFnDXQyf7iMGRnoL61KqcTaWN7tlNN9r+TCGrtvJvja
 JGkJ1UrQ==
X-Gm-Gg: AfdE7clQ3fimZgklXtWKKiCaZybZsI9/rRYfWyxIrC1z44cG+y8BYl8ijBXPBVBuzXu
 yy4YFifgCi3NVF4hw3YL/BGGdTManHVSwBCVI2OOzxapP1RfZoZGu2/KUSIAvr4fUv28HgimZ7J
 ZBcAbMdGzYbuIeZHfZtED6/fhZPP5MhnI8T8pNoA2HbbJPn3eUboyb2cNCj4/AHRI3n0CJIURw9
 W8coaOYDmJCFKvJ28g8mnF6SXIhiSZN5I+JTdOW019SXyKDeNfj2OoMf1DjWJ5kIsB4/R2LYMXy
 3X/05KPg1i1coU99pj36myYff83gWlgG2rWiQlSWKZmueV7/we9H7n9fKq/dBJuzyBSzk1YenwP
 kZXk6nMKRkcIb5gpJI4ATCkutvTA1Oo/ziac+EXvx3QZwoCluJAafYt86aMrsNE/u+iGkKSMgwR
 1hfMjlD5riO5YpqxSsS2lEzlQVF7Tegn63wp6poMQKA3OstX/SedkeVgdNkErroaTF8p4GQL2Ce
 R+/hpl9UBBonTChBo26BjqoNH8oSChWpMRwy2Aerrkv8/UJW+MTONUZ5WmJha9/3/yqlaFRvPwu
 DbM=
X-Received: by 2002:a05:600c:3b28:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-4926687e77emr225133605e9.20.1782719936992; 
 Mon, 29 Jun 2026 00:58:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-470f55acda0sm19571845f8f.23.2026.06.29.00.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:58:56 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: 4affc7258b2f3dffdf52640e3ba3705f405fae9e
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e27d339cb8dc014349e94c04c4f084e4f2d84b04-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tY-0008NS-C9
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6793406308113681459=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6793406308113681459==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kz1U2Wcw4II="; charset=UTF-8

--kz1U2Wcw4II=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1743?usp=3Demail

to review the following change=2E


Chang=
e subject: mudp: extract send_standalone_reply() helper
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mudp: extract send_standalone_r=
eply() helper

Factor the synchronous, stateless "send a standalone control=
 packet back to the
peer that just contacted us" sequence out of send_hmac_=
reset_packet() into a
reusable helper=2E No behavioural change=2E

This let=
s a following commit reuse it for the out-of-band probe reply instead of
du=
plicating the aux_buf / to_link / process_outgoing_link sequence=2E

Change=
-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
Signed-off-by: Lev Stipakov =
<lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
1 file changed, 34 insertion=
s(+), 23 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/43/1743/1

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec
index 9acf297=2E=2Ed3b529f 100644
--- a/src/openvpn/mudp=2Ec
+++ =
b/src/openvpn/mudp=2Ec
@@ -37,6 +37,38 @@
 #include <sys/inotify=2Eh>
 #end=
if
 
+/* Send an already-built standalone control packet back to the peer t=
hat just
+ * contacted us (c2=2Efrom), synchronously and without keeping an=
y state=2E
+ *
+ * We do not want to keep state for a reply to an initial/o=
ut-of-band packet, so
+ * we send it without queueing=2E If we hit EAGAIN o=
n a busy socket the packet is
+ * lost and the client simply retries -- an =
acceptable compromise that avoids
+ * consuming server resources under atta=
ck=2E
+ *
+ * @param buf     the packet to send (built by a tls_*_standalon=
e() helper)
+ * @param prefix  msg() prefix to set for the duration of the =
send
+ * @param detail  D_MULTI_DEBUG message describing the reply
+ */
+st=
atic void
+send_standalone_reply(struct multi_context *m, struct buffer *bu=
f, const char *prefix,
+                      const char *detail, struct li=
nk_socket *sock)
+{
+    struct context *c =3D &m->top;
+
+    /* dco-win s=
erver requires prepend with sockaddr, so preserve offset */
+    ASSERT(buf=
_init(&c->c2=2Ebuffers->aux_buf, buf->offset));
+    buf_copy(&c->c2=2Ebuff=
ers->aux_buf, buf);
+
+    msg_set_prefix(prefix);
+    c->c2=2Eto_link =3D=
 c->c2=2Ebuffers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
+  =
  msg(D_MULTI_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock);
+ =
   c->c2=2Eto_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D NULL;
+    ms=
g_set_prefix(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct multi_=
context *m, struct tls_pre_decrypt_state *state,
                        st=
ruct tls_auth_standalone *tas, struct session_id *sid,
@@ -48,29 +80,8 @@
 =
    struct buffer buf =3D tls_reset_standalone(&state->tls_wrap_tmp, tas, s=
id,
                                              &state->peer_session_id, =
header, request_resend_wkc);
 
-    struct context *c =3D &m->top;
-
-    /=
* dco-win server requires prepend with sockaddr, so preserve offset */
-   =
 ASSERT(buf_init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
-
-    buf_copy=
(&c->c2=2Ebuffers->aux_buf, &buf);
-
-    /*
-     * We do not want to keep=
 any state here, so we send the reply to the
-     * initial packet synchro=
nously without queueing anything=2E
-     *
-     * If we hit EAGAIN on a b=
usy socket, the packet will be lost and the
-     * client will have to ret=
ransmit its HARD_RESET=2E This is considered an
-     * acceptable compromi=
se to avoid consuming server resources under attack=2E
-     */
-    msg_se=
t_prefix("Connection Attempt");
-    c->c2=2Eto_link =3D c->c2=2Ebuffers->a=
ux_buf;
-    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
-    msg(D_MULTI_DEBUG=
, "Reset packet from client, sending HMAC based reset challenge");
-    pro=
cess_outgoing_link(c, sock);
-    c->c2=2Eto_link=2Elen =3D 0;
-    c->c2=
=2Eto_link_addr =3D NULL;
-    msg_set_prefix(NULL);
+    send_standalone_r=
eply(m, &buf, "Connection Attempt",
+                          "Reset packe=
t from client, sending HMAC based reset challenge", sock);
 }
 
 

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653=
df268bba33889c
Gerrit-Change-Number: 1743
Gerrit-PatchSet: 1
Gerrit-Owner: =
stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--kz1U2Wcw4II=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mu=
dp: extract send_standalone_reply() helper<br><br>Factor the synchronous, s=
tateless &quot;send a standalone control packet back to the<br>peer that ju=
st contacted us&quot; sequence out of send_hmac_reset_packet() into a<br>re=
usable helper=2E No behavioural change=2E<br><br>This lets a following comm=
it reuse it for the out-of-band probe reply instead of<br>duplicating the a=
ux_buf / to_link / process_outgoing_link sequence=2E<br><br>Change-Id: Ic75=
ca2ee9b59a4e11f37cd9653df268bba33889c<br>Signed-off-by: Lev Stipakov &lt;le=
v@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 file changed, 34 =
insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 9ac=
f297=2E=2Ed3b529f 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><=
br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -37,6 +37,38 @@</spa=
n><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span> #endif</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Send=
 an already-built standalone control packet back to the peer that just</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * contacted us (c2=2Efr=
om), synchronously and without keeping any state=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * We do not want to keep state for a reply to an initial/=
out-of-band packet, so</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * we send it without queueing=2E If we hit EAGAIN on a busy socket the =
packet is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * lost an=
d the client simply retries -- an acceptable compromise that avoids</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * consuming server resourc=
es under attack=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf     =
the packet to send (built by a tls_*_standalone() helper)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param prefix  msg() prefix to set=
 for the duration of the send</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param detail  D_MULTI_DEBUG message describing the reply</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+send_standalone_reply(struct multi_context *m, s=
truct buffer *buf, const char *prefix,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                      const char *detail, struct link_so=
cket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D =
&amp;m-&gt;top;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* dco-win server r=
equires prepend with sockaddr, so preserve offset */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffe=
rs-&gt;aux_buf, buf-&gt;offset));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg_set_prefix(prefix);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link =3D c-&gt;c2=
=2Ebuffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_DEBUG, &quot;%s&quot;=
, detail);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proce=
ss_outgoing_link(c, sock);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    c-&gt;c2=2Eto_link=2Elen =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link_addr =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg_set_prefix(NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span>=
 send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_sta=
te *state,</span><br><span>                        struct tls_auth_standalo=
ne *tas, struct session_id *sid,</span><br><span>@@ -48,29 +80,8 @@</span><=
br><span>     struct buffer buf =3D tls_reset_standalone(&amp;state-&gt;tls=
_wrap_tmp, tas, sid,</span><br><span>                                      =
        &amp;state-&gt;peer_session_id, header, request_resend_wkc);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 context *c =3D &amp;m-&gt;top;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* dco-=
win server requires prepend with sockaddr, so preserve offset */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_init(&amp;c-&gt;c=
2=2Ebuffers-&gt;aux_buf, buf=2Eoffset));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, &amp;buf);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * We do not want to keep any state here, so we send the reply to the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * initial packet =
synchronously without queueing anything=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * If we hit EAGAIN on a busy socket, the packet will be lost and=
 the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * client wil=
l have to retransmit its HARD_RESET=2E This is considered an</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     * acceptable compromise to avoi=
d consuming server resources under attack=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg_set_prefix(&quot;Connection Attempt&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link =3D c-&gt;c2=
=2Ebuffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_DEBUG, &quot;Reset packet=
 from client, sending HMAC based reset challenge&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_link(c, sock);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link=2El=
en =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=
=2Eto_link_addr =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    msg_set_prefix(NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    send_standalone_reply(m, &amp;buf, &quot;Connection Attempt&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
            &quot;Reset packet from client, sending HMAC based reset challe=
nge&quot;, sock);</span><br><span> }</span><br><span> </span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">change 1743</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic75ca2ee9b59a4e11f3=
7cd9653df268bba33889c </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1743 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--kz1U2Wcw4II=--


--===============6793406308113681459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6793406308113681459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6793406308113681459==--

