Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9493FC5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJ2nQSv9UIBcd/cVocwWVz7K/zZzMvt52yxMflDK1To=; b=K3ptGLLe1/MI8tc1VgxAwwd1/k
	BWUumFit4AzJOX35muEn6S2TdaduvbOV6RKXwj+xrrqiC+RtHhw9dgQFZYF/nA8sEilEl3GePd28X
	CDqf/T/gxl0pBkpBB9M3bgbjJwU6vJS+NjW8H3kgX5hNqoPOabUoCBV/BM104v/D2/TA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYFd-0001SN-CB;
	Thu, 13 Aug 2026 16:25:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYFc-0001SC-C8
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=06nnQzKYHssGBzT5yf8fHyxD7CbfJga5VzMLnOj34/w=; b=bP/aGkrOAZDgoyEA+/0BjwiePE
 y2ZkgomKY+HP/zw1424y8voc7vrRLp/JtURIJhhp8qrncOH5goYPOnzTnJCmHtB3bnAnLJyvwaAj8
 N3c5sDAqETECGN5Lj9NKWoc/VrwAW0QOfn3D21bmQqrisnjBLM3vi4XITnAmfRO2vvXU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=06nnQzKYHssGBzT5yf8fHyxD7CbfJga5VzMLnOj34/w=; b=f
 LvMrsniKHbXSz5lBQOYuEAb1W7+jO6Ueo1LB26YwT+HUtR8OI9dE4Z2fzM3LN5IElJmfVupojjuf9
 pd8xC44Moyr/8QuEP/JdGFOTxFCo9vtvR7cPRBOw5jSl3aPzrWimKLfwiqVF6FvSRIs+6khKKIQDL
 f6eN+2PGl0I0h3Zw=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYFf-0006RI-3H for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:25:53 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso1698705e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786638345; x=1787243145; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=06nnQzKYHssGBzT5yf8fHyxD7CbfJga5VzMLnOj34/w=;
 b=NOssyb1T1mZA2jPkRfz7dADsjqIHXZaaBzhpeBVSaX/z+k6M/j+47MjlS/tQGZ+LMP
 /R0jsucHhbEmBDVGqTpgXuIJXiovlnBg+fYfayAIID0ZzXK6HzH+f7gYdXIA1ukiTFZo
 7Hp8SNjz/J4C7bPAaneNlxWz35RyN25cwi9ekrM922WEw8WWq2YywmbpRFlGXSVkDVR3
 adDLUbZ//MLH0ai7OPUgW2Hza2QVU2i46jT19+AfiChDytAZOTwaG0DJWbrq6cRD+hET
 pOxLqcXsWzeIE0QGGSWjDuxMj/VipQbeziJnfzrTaVYzd9H73z/UcIj1RmZvCINL8Nud
 elXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638345; x=1787243145;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=06nnQzKYHssGBzT5yf8fHyxD7CbfJga5VzMLnOj34/w=;
 b=XqtMNmi/piD7D78CPbhefk+G4ggQYqUN4pxLkYXcpoXnvZrUX/xNoQPLVE9FHHSVY2
 QDkg1kwThekO4QTYFJP0JbfS+QkUw4psNyRcsFUnWkhQIj6ctojIle4eqPKGnnA+K2lA
 A0mwD79l8eAYgRZNJsRKQ9J7D0W8F1GOqXUiqMS1PtgjKYK8bPXvxSD1nW/9oe7EXCNw
 vA6XWq3k2uWhQLrtZP05IqJdw5Dl8zlT0on3BbN2W5fSBskewpok6nDXkXKW+hpr5lNo
 pGI1u1U/s4GVJxpprArTht5uE/um3VJVbAyXxpIUU0h+7z3p5MppApM6rn/hSkML7ZVN
 YI6Q==
X-Gm-Message-State: AOJu0YyJUGSKsiHrFGyBZAhrIhaaq5jaRtx9cxO1MrFLUrOCX2tAXVAi
 o/4NzEs6zJ8+krrc7AgmkNVOUr5TzjZ6lcoeUXdWcvKAyM9hFgzVdkc/DxvlYgwU993iK8HWtEN
 AkEhuE2d+rUqp8ljLEva5XhTCD7bWrwL+TvZC/At7VWOn/qgkjwS2mSerA18fFqH4mmj9
X-Gm-Gg: AR+sD11KAw3qgDuT3/g2dFLvEgBz5geKj2+DUxk+ggcYWJ5MxHyV4cs6f5op4trt3Ty
 4QZqJgR6RX84TZjnpqi7Fj0huHMEtLS6+6O4fToJf0LGBN/JEyUlnFBld7HVHLN/pJP3p7VpGKW
 B/804dTTGIdd8p4zD495rZJg3mmBNjKE1XWXTthAolbRvIRaRKuY5lMBqcJKP5QmBMkb7+k3h7J
 SCU18ilxm11NDv0y6LuU4eREvSpAid+oNMHetqJUuhw9ueunL9I8yfFXC7ls4MNh5UUeHt7DLoA
 jxmIWkpaOHE34e8S5ipJMysQsCfGsKT6E8yGiw/oPXU1gNgr/8NYnkAISbFfM9jsS4729FOclcO
 5UUgqIkfUkq02CM2ySeZKnveVmM40fcSA85BnkY5OLz9it5ks9QWeN3Jcfa93jrbow3E3F6Hywr
 0Pp+Rv6gfm7eoqj9dnG4zSuCpVK5xNLy4+6DsGAXubscx6gQpZFqF/E4fe/yh9N6mADWjBw3/JA
 cLDv74dMHD22UvRlGngBpgvNmRQoWobd3rpdIru5xeTGRPppfOLL4nH5e0f3PPTV1QZE2IkPy8l
 P9OQsBmwd+bsKMOGd1GA3HEicspdLdEE0B2nkUgAnMZZEUugRIA=
X-Received: by 2002:a05:600c:3e15:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-499821e8021mr89223335e9.9.1786638344735; 
 Thu, 13 Aug 2026 09:25:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49982165351sm71525315e9.10.2026.08.13.09.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:25:44 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:25:42 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
X-Gerrit-Change-Number: 1831
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1831?usp=email>
X-Gerrit-Commit: f264f6274b1696d28b277f5dd0fa93d889eb6f80
In-Reply-To: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
References: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkliMGU3YzlkM2EyZjRlNmI4YzFkNWE5ZjdlM2IyYzRkNmE4ZjFlNWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ff34c39fd439873674aee5bea2bb113c6fae677-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYFf-0006RI-3H
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Do not queue
 control ciphertext while a packet is still queued
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2413258268635421591=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2413258268635421591==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tJhNkwQt2cw="; charset=UTF-8

--tJhNkwQt2cw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: ssl: Do not queue control ciphertext while a=
 packet is still queued
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl: Do not queue control ciphertext while a packet is still que=
ued

An outgoing control channel packet is handed to the link layer as a
bu=
ffer descriptor pointing into the reliable send buffer it was built
from, a=
nd the packet id sits in that buffer's headroom, right in front
of the payl=
oad=2E  If the entry is reused before the packet has been
written out, buf_=
copy_n() writes the new payload and
reliable_mark_active_outgoing() prepend=
s the new packet id exactly over
the packet id of the queued packet, while =
its opcode, ACK array and
length stay untouched=2E  The queued packet then =
goes out with somebody
else's packet id=2E

Observed in a TCP p2p handshake=
: both peers reset simultaneously, the
peer's two HARD_RESET packets arrive=
 back to back, so io_wait_dowork()
takes the residual data shortcut (event_=
set_status =3D SOCKET_READ) and
does not write out our already queued HARD_=
RESET retransmit=2E  The ACK
in the second peer reset then purges our reset=
 from the send window,
tls_process_state() moves to S_START and queues the =
ClientHello into
the very same (now inactive) entry=2E  Result on the wire:=
 a HARD_RESET
with the ClientHello's packet id 1, followed by the ClientHel=
lo with
the same id 1=2E  The receiver consumes the reset, advances its rec=
eive
window, and drops the real ClientHello as a replay - the handshake
dea=
dlocks until it times out=2E

The send path in tls_process_state() and the =
dedicated ACK path in
tls_process() are already guarded by to_link->len, on=
ly the ciphertext
queueing was not=2E  Guard it as well=2E  A pending to_li=
nk makes
tls_process() report itself as active, so we are called again as s=
oon
as the packet has been written out=2E  In the error path this can drop =
a
TLS alert that we would have queued, which is in line with that path
not =
ensuring delivery anyway=2E

Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8=
f1e5b3
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1831
Message-Id: <20260805134336=2E163392-1-frank@li=
chtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38133=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 10 insertions(+),=
 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/31/1831/2

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec=

index d5100af=2E=2Ed539018 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/open=
vpn/ssl=2Ec
@@ -2769,8 +2769,15 @@
 
 static bool
 check_outgoing_ciphertex=
t(struct key_state *ks, struct tls_session *session,
-                     =
     bool *continue_tls_process)
+                          struct buffer *=
to_link, bool *continue_tls_process)
 {
+    if (to_link->len)
+    {
+    =
    dmsg(D_TLS_DEBUG,
+             "Deferring outgoing ciphertext, previou=
s packet not written out yet");
+        return true;
+    }
+
     /* Outg=
oing Ciphertext to reliable buffer */
     if (ks->state >=3D S_START)
    =
 {
@@ -2950,7 +2957,7 @@
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext=
 -> TLS");
         }
     }
-    if (!check_outgoing_ciphertext(ks, sessio=
n, &continue_tls_process))
+    if (!check_outgoing_ciphertext(ks, session,=
 to_link, &continue_tls_process))
     {
         goto error;
     }
@@ -29=
62,7 +2969,7 @@
     /* Shut down the TLS session but do a last read from t=
he TLS
      * object to be able to read potential TLS alerts */
     key_s=
tate_ssl_shutdown(&ks->ks_ssl);
-    check_outgoing_ciphertext(ks, session,=
 &continue_tls_process);
+    check_outgoing_ciphertext(ks, session, to_lin=
k, &continue_tls_process);
 
     /* Put ourselves in the pre error state t=
hat will only send out the
      * control channel packets but nothing else=
 */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0e7c9d3a2f=
4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
Gerrit-Change-Number: 1831
Gerrit-PatchSet: 2=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--tJhNkwQt2cw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">ssl: Do not queue cont=
rol ciphertext while a packet is still queued<br><br>An outgoing control ch=
annel packet is handed to the link layer as a<br>buffer descriptor pointing=
 into the reliable send buffer it was built<br>from, and the packet id sits=
 in that buffer&#39;s headroom, right in front<br>of the payload=2E  If the=
 entry is reused before the packet has been<br>written out, buf_copy_n() wr=
ites the new payload and<br>reliable_mark_active_outgoing() prepends the ne=
w packet id exactly over<br>the packet id of the queued packet, while its o=
pcode, ACK array and<br>length stay untouched=2E  The queued packet then go=
es out with somebody<br>else&#39;s packet id=2E<br><br>Observed in a TCP p2=
p handshake: both peers reset simultaneously, the<br>peer&#39;s two HARD_RE=
SET packets arrive back to back, so io_wait_dowork()<br>takes the residual =
data shortcut (event_set_status =3D SOCKET_READ) and<br>does not write out =
our already queued HARD_RESET retransmit=2E  The ACK<br>in the second peer =
reset then purges our reset from the send window,<br>tls_process_state() mo=
ves to S_START and queues the ClientHello into<br>the very same (now inacti=
ve) entry=2E  Result on the wire: a HARD_RESET<br>with the ClientHello&#39;=
s packet id 1, followed by the ClientHello with<br>the same id 1=2E  The re=
ceiver consumes the reset, advances its receive<br>window, and drops the re=
al ClientHello as a replay - the handshake<br>deadlocks until it times out=
=2E<br><br>The send path in tls_process_state() and the dedicated ACK path =
in<br>tls_process() are already guarded by to_link-&gt;len, only the cipher=
text<br>queueing was not=2E  Guard it as well=2E  A pending to_link makes<b=
r>tls_process() report itself as active, so we are called again as soon<br>=
as the packet has been written out=2E  In the error path this can drop a<br=
>TLS alert that we would have queued, which is in line with that path<br>no=
t ensuring delivery anyway=2E<br><br>Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3=
b2c4d6a8f1e5b3<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831<br>Message-Id: &lt=
;20260805134336=2E163392-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38133=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/ssl=2Ec<br>1 file changed, 10 insertions(+), 3 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/31/1831/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec</span><br><span>index d5100af=2E=2Ed539018 100644</span><br>=
<span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</=
span><br><span>@@ -2769,8 +2769,15 @@</span><br><span> </span><br><span> st=
atic bool</span><br><span> check_outgoing_ciphertext(struct key_state *ks, =
struct tls_session *session,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                          bool *continue_tls_process)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                          struct b=
uffer *to_link, bool *continue_tls_process)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (to_link-&gt;len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_TLS_DEBUG,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             &quot;Deferring outgoi=
ng ciphertext, previous packet not written out yet&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     /* Outgoing Ciphertext to r=
eliable buffer */</span><br><span>     if (ks-&gt;state &gt;=3D S_START)</s=
pan><br><span>     {</span><br><span>@@ -2950,7 +2957,7 @@</span><br><span>=
             dmsg(D_TLS_DEBUG, &quot;Outgoing Plaintext -&gt; TLS&quot;);</=
span><br><span>         }</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!check_outgoing_ciphertext(ks, session, =
&amp;continue_tls_process))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!check_outgoing_ciphertext(ks, session, to_link, &amp;conti=
nue_tls_process))</span><br><span>     {</span><br><span>         goto erro=
r;</span><br><span>     }</span><br><span>@@ -2962,7 +2969,7 @@</span><br><=
span>     /* Shut down the TLS session but do a last read from the TLS</spa=
n><br><span>      * object to be able to read potential TLS alerts */</span=
><br><span>     key_state_ssl_shutdown(&amp;ks-&gt;ks_ssl);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    check_outgoing_ciphertext(ks, ses=
sion, &amp;continue_tls_process);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    check_outgoing_ciphertext(ks, session, to_link, &amp;cont=
inue_tls_process);</span><br><span> </span><br><span>     /* Put ourselves =
in the pre error state that will only send out the</span><br><span>      * =
control channel packets but nothing else */</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
31?usp=3Demail">change 1831</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1831?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1831 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--tJhNkwQt2cw=--


--===============2413258268635421591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2413258268635421591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2413258268635421591==--

