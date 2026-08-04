Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997B5C55172
	for <openvpn-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DESlQfSqr3j6bkj5lS49y4qwUZdwEMcvNA5W83LVtfE=; b=kftvZnjitPvNF9K8JVtzfoChoi
	H5ItRa6v9l1OlN5F94R1YvAEMp3ZNhDa8+HewO7Sj3Z2W05WQ4OyB8spDNv54UC8XVirkNlAmln4S
	DwzA1Z4NqTWUls20YXw7XfacLKrBzXzs3zSX9FrqiYTYQwINalACc2OMMOTMYLLxANP0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrAF3-00029z-L2;
	Tue, 04 Aug 2026 08:11:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrAEf-0001yW-5G
 for openvpn-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 08:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Lhj7NmLEjBHARDpbTELBfeBVTmhndrgJVeM3grjzOgA=; b=mJBIymZO+b4+1Xm7VBwzpgl4so
 nVcNE4TVCK0fdndXYIPEO9itJPm+sSS+ZJqcAZoB180omHgv48Y1i5bu9oqtIK4KY9dggVExMSY2I
 c3qmxZic7JMlTsLIwaNhuB7eomQATdrp7hYGaMEhLem4tHV1qsroXEk7o6ZbrgAf3kaw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lhj7NmLEjBHARDpbTELBfeBVTmhndrgJVeM3grjzOgA=; b=S
 96bHh10Jcs2TDk1wgFwx72PZfDRl3o0SahOP1eW6EHJ/dolwZGB1DWgd9DmNn4p8OkqQSBBWVsRTs
 m0GqRWNLln+cMhRh49x57hxaZMUObUIgXIROkuxUtSvcp55OEna0V6CgXiooTvOrPi5rXMgxcBDPy
 bMHITXVKWh3zmwkY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrAEa-0006Dv-Cv for openvpn-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 08:10:50 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so14316535e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 04 Aug 2026 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785831042; x=1786435842; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lhj7NmLEjBHARDpbTELBfeBVTmhndrgJVeM3grjzOgA=;
 b=FAvYz+Dd9IstuBzDD/Drz32HSyh4NZCpAakmHNz0bsjJFG8GA6aUFfNZ3h1iDWqFdj
 pV/o0uQV6oZR+QATF5nM6L23FHQVvBp9DaEKBQe1Q9huTVd35dN+faZ8W2UPzt6WCIcT
 v9DBacgXw0tlHa1SonAEuxumAhRNmvUKJuZ0px1cYX8N6XMuwuKvwCMWUDpokVqg+n8v
 c0DQwTzNP5QeKAC9VjIv0T7ZbDEyrZXwK70zsLSXegkCmuWuq3DFnXwMdb+XEsKZLxVK
 9kRS9ucjEOApjAzI7m/QZgaRwdA7bAly+g+2R480h5yPN7FctUzhUKq5qfr9pn0V5M/g
 7x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785831042; x=1786435842;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lhj7NmLEjBHARDpbTELBfeBVTmhndrgJVeM3grjzOgA=;
 b=p9SotJf5okvK0S3466OA/W+QLQeC76wfJl6KNkipfLGTAQS9SBFyCnfa14EfiDMpjm
 LaQfq6K6T/yErr7Whs9xbAayclrOO0KAu3uQ0b01EWCEzfJgtNX6xVzZjjQRkgJdGOir
 ojzog1cvwCbtdNcIbDFvp+8mt4sdKqvqGcabFEnKUcvu1L5F1CCSnNwPDlxQp2e90Iv+
 H4h40dIZxTN8WdS2K4age0LgpQaX7P3wtvkiT/XhXB9Y5E4Kn//hRrO3YG3e4BIOwvn2
 QouZtp+lsEE331mKMZ9BsZ9P2uOd/GyzuZQCbNY8HMLU7J0fcfy1yjO82bjlu2sYG46a
 /McQ==
X-Gm-Message-State: AOJu0YwOWtQ35Gk/nTdTmhTfspM+GiG6pMtQr837XlAHrmU5qjCtzHwp
 tObz1Qo7l6TwLR7nWknhke/LX+UQVw+Vs3OYwDz0FJsGp4wzzwa93ojUlVvD9SCHLrCo9rwe3Lb
 FP9TdeI1GUCBOFSx4F4IMC9PXc67khrySs/AuyIR+EYTcCCMvmPYSapiN2cfE0qPxkz/0
X-Gm-Gg: AR+sD131QxJJnZu3IqkMMSoWwbzMU3seH/NjnqpRcqoe9BypK7TC6FymB+qiXFt6IgW
 LkUG8FLcu3Hm6P145AeZ4ozQt+tfeBRe0VSst9Tf4ol5Nao8YI9ZIaPGCFiQ6etJ3FwJa+gwX5t
 MSnJINhL9sEtipHKrDQdttnjLxjsUvKD3PXUJeQm+byvTfhW7beTeXoSsZ11vXPSbscc1IvU9pz
 6ypF3al3tjW3c9oODHgM3qKNkYmdWm7St5Wif8L0xEvwrOYvqM67ZihxZsfZYslhVO0BojIGNdz
 nFyrVfjPEWGxn1aWQ1D0sIJY/ZYZJX26te1Hfxxg2qdqn16CVHpm+cy48z2TrvPu59HRLlNFOPz
 U57O72V6WkeUhA1j1+hE3pknDKwBmXzNkgx1fkcCnZMCk91SiWeXzsBHrSId1t3R6y2w8N0BArS
 bJrghGd3rdsqhJSZopnUDRVjMQJx0UXq6qxZSvxd+nIhZXNTb0wTaKJ7i37LPbqKaum1tldxO0V
 RSdjSLn/5uqpbIoau7CQBhphEgfEyZ3xjN4BKvAF4QE0j5Caslz7gCNROZ8+GtXKGI+B2wLZD7r
 6JvXchZjInW1WTsYGYotDPZyFJjwuiUIdXeYFUhYm61Qn7EQta4=
X-Received: by 2002:a05:600c:214d:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-4980c653c0cmr223001395e9.9.1785831041468; 
 Tue, 04 Aug 2026 01:10:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b6093fsm181940135e9.1.2026.08.04.01.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 01:10:40 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 4 Aug 2026 08:10:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: 154bfeb0b78d920dc16e5f426bd04e969894531c
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5281e41ef6ca8dbd2e2e086fc504efb77583e1ac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrAEa-0006Dv-Cv
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
Content-Type: multipart/mixed; boundary="===============3240509916361867710=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3240509916361867710==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MBId4mj5SxM="; charset=UTF-8

--MBId4mj5SxM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello flichtenhe=
ld, ordex, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail

to look at=
 the new patch set (#11)=2E

The change is no longer submittable: checks~Ch=
ecksSubmitRule is unsatisfied now=2E


Change subject: mudp: extract send_s=
tandalone_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

mudp: extract send_standalone_reply() helper

Factor the sync=
hronous, stateless "send a standalone control packet back to the
peer that =
just contacted us" sequence out of send_hmac_reset_packet() into a
reusable=
 helper=2E No behavioural change=2E

This lets a following commit reuse it =
for the out-of-band probe reply instead of
duplicating the aux_buf / to_lin=
k / process_outgoing_link sequence=2E

Change-Id: Ic75ca2ee9b59a4e11f37cd96=
53df268bba33889c
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/=
openvpn/mudp=2Ec
1 file changed, 37 insertions(+), 23 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/11

di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2E2=
be085f 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -37,=
6 +37,41 @@
 #include <sys/inotify=2Eh>
 #endif
 
+/**
+ * Send an already-=
built standalone control packet back to the peer that just
+ * contacted us=
 (c2=2Efrom), synchronously and without keeping any state=2E
+ *
+ * We do =
not want to keep state for a reply to an initial/out-of-band packet, so
+ *=
 we send it without queueing=2E If we hit EAGAIN on a busy socket the packe=
t is
+ * lost and the client simply retries -- an acceptable compromise tha=
t avoids
+ * consuming server resources under attack=2E
+ *
+ * @param m   =
    the server's multi_context
+ * @param buf     the packet to send (built=
 by a tls_*_standalone() helper)
+ * @param prefix  msg() prefix to set for=
 the duration of the send
+ * @param detail  D_MULTI_DEBUG message describi=
ng the reply
+ * @param sock    the socket to send the reply on
+ */
+stati=
c void
+send_standalone_reply(struct multi_context *m, struct buffer *buf, =
const char *prefix,
+                      const char *detail, struct link_=
socket *sock)
+{
+    struct context *c =3D &m->top;
+
+    /* dco-win serv=
er requires prepend with sockaddr, so preserve offset */
+    ASSERT(buf_in=
it(&c->c2=2Ebuffers->aux_buf, buf->offset));
+    buf_copy(&c->c2=2Ebuffers=
->aux_buf, buf);
+
+    msg_set_prefix(prefix);
+    c->c2=2Eto_link =3D c-=
>c2=2Ebuffers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
+    m=
sg(D_MULTI_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock);
+    =
c->c2=2Eto_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D NULL;
+    msg_s=
et_prefix(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct multi_con=
text *m, struct tls_pre_decrypt_state *state,
                        struc=
t tls_auth_standalone *tas, struct session_id *sid,
@@ -48,29 +83,8 @@
    =
 struct buffer buf =3D tls_reset_standalone(&state->tls_wrap_tmp, tas, sid,=

                                              &state->peer_session_id, hea=
der, request_resend_wkc);
 
-    struct context *c =3D &m->top;
-
-    /* d=
co-win server requires prepend with sockaddr, so preserve offset */
-    AS=
SERT(buf_init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
-
-    buf_copy(&c=
->c2=2Ebuffers->aux_buf, &buf);
-
-    /*
-     * We do not want to keep an=
y state here, so we send the reply to the
-     * initial packet synchronou=
sly without queueing anything=2E
-     *
-     * If we hit EAGAIN on a busy=
 socket, the packet will be lost and the
-     * client will have to retran=
smit its HARD_RESET=2E This is considered an
-     * acceptable compromise =
to avoid consuming server resources under attack=2E
-     */
-    msg_set_p=
refix("Connection Attempt");
-    c->c2=2Eto_link =3D c->c2=2Ebuffers->aux_=
buf;
-    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
-    msg(D_MULTI_DEBUG, "=
Reset packet from client, sending HMAC based reset challenge");
-    proces=
s_outgoing_link(c, sock);
-    c->c2=2Eto_link=2Elen =3D 0;
-    c->c2=2Eto=
_link_addr =3D NULL;
-    msg_set_prefix(NULL);
+    send_standalone_reply(=
m, &buf, "Connection Attempt",
+                          "Reset packet fro=
m client, sending HMAC based reset challenge", sock);
 }
 
 

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df26=
8bba33889c
Gerrit-Change-Number: 1743
Gerrit-PatchSet: 11
Gerrit-Owner: sti=
pa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--MBId4mj5SxM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #11</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><p>The change i=
s no longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">mudp: extract send_standalone_reply() helper<br><br>Factor the=
 synchronous, stateless &quot;send a standalone control packet back to the<=
br>peer that just contacted us&quot; sequence out of send_hmac_reset_packet=
() into a<br>reusable helper=2E No behavioural change=2E<br><br>This lets a=
 following commit reuse it for the out-of-band probe reply instead of<br>du=
plicating the aux_buf / to_link / process_outgoing_link sequence=2E<br><br>=
Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c<br>Signed-off-by: Lev =
Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 fi=
le changed, 37 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/11</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><=
span>index 9acf297=2E=2E2be085f 100644</span><br><span>--- a/src/openvpn/mu=
dp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -37,6 =
+37,41 @@</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Send a=
n already-built standalone control packet back to the peer that just</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * contacted us (c2=2Efrom=
), synchronously and without keeping any state=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * We do not want to keep state for a reply to an initial/out-=
of-band packet, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* we send it without queueing=2E If we hit EAGAIN on a busy socket the pack=
et is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * lost and th=
e client simply retries -- an acceptable compromise that avoids</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * consuming server resources u=
nder attack=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m       the =
server&#39;s multi_context</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param buf     the packet to send (built by a tls_*_standalone() =
helper)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pr=
efix  msg() prefix to set for the duration of the send</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param detail  D_MULTI_DEBUG message =
describing the reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param sock    the socket to send the reply on</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+send_standalone_reply(struct multi_context *m, struct buffer *buf, c=
onst char *prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                     const char *detail, struct link_socket *sock)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;m-&gt;top;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* dco-win server requires prepend wi=
th sockaddr, so preserve offset */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf=
-&gt;offset));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    msg_set_prefix(prefix);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuffers-&gt;aux_b=
uf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Et=
o_link_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    msg(D_MULTI_DEBUG, &quot;%s&quot;, detail);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link(c, =
sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=
=2Eto_link=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    c-&gt;c2=2Eto_link_addr =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg_set_prefix(NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> static void</span><br><span> send_hmac_reset_pa=
cket(struct multi_context *m, struct tls_pre_decrypt_state *state,</span><b=
r><span>                        struct tls_auth_standalone *tas, struct ses=
sion_id *sid,</span><br><span>@@ -48,29 +83,8 @@</span><br><span>     struc=
t buffer buf =3D tls_reset_standalone(&amp;state-&gt;tls_wrap_tmp, tas, sid=
,</span><br><span>                                              &amp;state-=
&gt;peer_session_id, header, request_resend_wkc);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &am=
p;m-&gt;top;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* dco-win server requires=
 prepend with sockaddr, so preserve offset */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&gt;aux=
_buf, buf=2Eoffset));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_copy(&amp;c-&=
gt;c2=2Ebuffers-&gt;aux_buf, &amp;buf);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * We do not w=
ant to keep any state here, so we send the reply to the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * initial packet synchronously witho=
ut queueing anything=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * If we =
hit EAGAIN on a busy socket, the packet will be lost and the</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     * client will have to retransmi=
t its HARD_RESET=2E This is considered an</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * acceptable compromise to avoid consuming server =
resources under attack=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_se=
t_prefix(&quot;Connection Attempt&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuffers-&gt;aux_b=
uf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_=
link_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    msg(D_MULTI_DEBUG, &quot;Reset packet from client, sendin=
g HMAC based reset challenge&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    process_outgoing_link(c, sock);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link=2Elen =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link_addr =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_set_pref=
ix(NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    send_s=
tandalone_reply(m, &amp;buf, &quot;Connection Attempt&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                          &quot;Re=
set packet from client, sending HMAC based reset challenge&quot;, sock);</s=
pan><br><span> }</span><br><span> </span><br><span> </span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1743?usp=3Demail">change 1743</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1743?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba338=
89c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1743 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--MBId4mj5SxM=--


--===============3240509916361867710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3240509916361867710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3240509916361867710==--

