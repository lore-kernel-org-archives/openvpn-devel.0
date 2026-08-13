Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D6AC5DF67
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1nZ9wjlddyeJBDYgQftfNwHH7cE1SrswN2YCNmGxv0=; b=PrnLAynLPHyk8wVfYyQppnnRrD
	fBdDlA9sUVvAAHTW0mhwsS3UELQvrzHi00WI34Z+Oe97nIsP0/SDK9SZ0iSNQFI6YhTG0J4cdJhtF
	1//CGs54o43/Il25Z2B6EBIrC/JltX4VDc9YOONc3honCkY8yAq+V3vP1D7mXfNa3hJI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYFf-0006tZ-Pe;
	Thu, 13 Aug 2026 16:25:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYFe-0006tP-8o
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4UraKSb2lUZ+HZw/SQuBedSQr5L6i6cxnoar95JyvXg=; b=VIoe6Mf6dCxOYqhHZ6gTQXGsY1
 dXnMpX2QKFZW5xbZUInKJuBBjvY58FQNfUQ9fM/iZ5FMD84e5lBztU6YT5fBkZZt7oyihdhvXi+aG
 NVehiB7q0yZ7M7kKh1kj7SUFjRPmZEmnKSKSGpm9cQ5IvMTsYZ0GPKHY6QXgvuP33u/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4UraKSb2lUZ+HZw/SQuBedSQr5L6i6cxnoar95JyvXg=; b=B
 4ZIRpSEi18OA/Spub6kkhte+Yp23841HE023adQWLdtAKM8crIHoOTCJEHDO/ocvTLLQsLD8CJoZT
 zXYbhTQU4QvJ1HTLdB/i12LwQ3iYncZd1VDDVBf+nz2Jz+ejxBaG/CqxEIWUKVQ5s5Sez74LOSQjg
 BpcZgRDwWqApne0o=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYFc-0003oY-8U for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:25:54 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4956242332dso1034865e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786638346; x=1787243146; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4UraKSb2lUZ+HZw/SQuBedSQr5L6i6cxnoar95JyvXg=;
 b=dSBI+TJePj6TQlh4gxXCr3f8c8SCUf/2FogIvAFnFUMFAw5a7LL2NNwVSBIM65dwjE
 Jd6NqHdoSngvjN2Pr8FoLR1NeiLJVU+z2b+gczeBcl5xnfDfBvlgFsf4wpKW17T6WXai
 8McA8cE/t68LQo1lgwSZDgZXwFb1gnlQNSXnu7nxVhNhm3vN/j0fRnO38dzK+OLTcgNw
 tlJWw4GOVGO3rji6nzg51u43pKBvBCxX7CpK129zObtmpmKbJJH65KG/z5m3kekQXe7S
 MgA9YKn7SP+yKuK31kuGOy1b/gV2Z9A6xGlX7Tl4owqaeJVI7xKTC+JXAJiCOExj5bjv
 GHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638346; x=1787243146;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4UraKSb2lUZ+HZw/SQuBedSQr5L6i6cxnoar95JyvXg=;
 b=FhxDXNicmbr1v2PWtWRFykVmByAKKNl+2xryoQC7wvApPFB1kUUXQ0mj3bOGE2gkd5
 pGPSSh7j+JHB+no2di2Kw/+5YErzVRy1pJDR9SzcR6hlKSk61qYvNCgPjaMaYGPrvyJ0
 83focZOyHG+N/EgyW97+3NXa/3ID+s7fOQKevZEGm6NM6HxH5ZRg7vFPMuKnYgAcktI5
 bbPgvm2lsz9kQvNRG/fwZ4Dq9AMJYZZSbvtu/ZgUF6ihhoPR5Mp2I31dd2s29kkVeP71
 dShUH5VwSDZ9LdqGI2XPW03D3Ehz53aYlM54O4eDAhhcP531FqqiNBBrvjrEtFPLvemN
 nfPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpN1nWRcL9r3hfV14QI11jHTAci7mKNuZE+4p7lDzlQUfJmKCg8KrkRgIwgwSCq15zG1r3xtRgEKG0jdrgW@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx/7gX8oD6kFISq1iQxHiAWK/YcxqEjuy9PrWmCA+lt29Omlu/8
 Wp3ejaK5PmoWuVXHiBc9Fz7vKsCs2nXyNKxpNS5hVxLQNURHmR1vIkHOsR7MVd+r1B39G8N60iA
 meWlo/4j75rbKr8ZuyvZ7U5RTo4AwGQflHW8olxIeJRLqOEX1lk6okj3dtyQpYRoBogqK
X-Gm-Gg: AR+sD10LQN/J4R1VO5Nmhpgz13gwC6CBI5yVfIh54EtRiDixDuqA8DCOjVhpvsg3/RF
 l2ZZZYZDRKfJC48yG1bQNyJvRDChU3qYUGh5kgDn4yv+Rv4ihrnOMuLA1pmXRqHJFsLIyso/RQk
 8CGbCpAN1NWASVHfG5ImBvvL7kShWRi8iVnkoqMvhF7KofaB2r3+Aq5IbdzTSnhZ2ut0fDyqB+o
 ZXJAo5i3Wp/C6wJUgwmII7sYUzSIP72M7nJUO+5Q5GM2L+bHKQ06nbtgEvxm9IqQM+5YuekrLFU
 nqWhNdKyLTQHRPstOS2y3ySX+sCCuvuX013AgYiCIgDmWAVkVSzTjucqeW7LFURtGQnj6nRpouN
 TYjGXllhXbNa5Xyhhs28d0MWbiA1OmYGAdwvGvXzKlMDCE8T2OcqZ6Tuo9e33fb4yMZrnwNhTtF
 XeHtoT9oGyN0FrsGaqjSYx/+mDVwab841eU2qzyBAoKcPI4G+50fmjx1avepEC6Z+xoQK/pkHnu
 0zFAd9979TghBvXCmyPOlwC8gtGSlZSQFIY7YGy+ALb8cKkgKUFtyhBKg5qnSrJQN11qj2unpCO
 13XU8FPnBPaSsi6cxnVc7ZaJy0EKUJj4QxgEX38RQ+Z0FKf1A0SWpnqu
X-Received: by 2002:a05:600c:8b2f:b0:496:c378:6420 with SMTP id
 5b1f17b1804b1-499821a2051mr100556855e9.8.1786638345612; 
 Thu, 13 Aug 2026 09:25:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f200752sm548040f8f.1.2026.08.13.09.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:25:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:25:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
X-Gerrit-Change-Number: 1831
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1831?usp=email>
X-Gerrit-Commit: f264f6274b1696d28b277f5dd0fa93d889eb6f80
In-Reply-To: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
References: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkliMGU3YzlkM2EyZjRlNmI4YzFkNWE5ZjdlM2IyYzRkNmE4ZjFlNWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ff34c39fd439873674aee5bea2bb113c6fae677-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYFc-0003oY-8U
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8087802654325084457=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8087802654325084457==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9h01ueqBLOc="; charset=UTF-8

--9h01ueqBLOc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1831?usp=3Demail )

Change subject: ssl: Do not queue control ciphertex=
t while a packet is still queued
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

ssl: Do not queue control ciphertext while a packet is =
still queued

An outgoing control channel packet is handed to the link laye=
r as a
buffer descriptor pointing into the reliable send buffer it was buil=
t
from, and the packet id sits in that buffer's headroom, right in front
of=
 the payload=2E  If the entry is reused before the packet has been
written =
out, buf_copy_n() writes the new payload and
reliable_mark_active_outgoing(=
) prepends the new packet id exactly over
the packet id of the queued packe=
t, while its opcode, ACK array and
length stay untouched=2E  The queued pac=
ket then goes out with somebody
else's packet id=2E

Observed in a TCP p2p =
handshake: both peers reset simultaneously, the
peer's two HARD_RESET packe=
ts arrive back to back, so io_wait_dowork()
takes the residual data shortcu=
t (event_set_status =3D SOCKET_READ) and
does not write out our already que=
ued HARD_RESET retransmit=2E  The ACK
in the second peer reset then purges =
our reset from the send window,
tls_process_state() moves to S_START and qu=
eues the ClientHello into
the very same (now inactive) entry=2E  Result on =
the wire: a HARD_RESET
with the ClientHello's packet id 1, followed by the =
ClientHello with
the same id 1=2E  The receiver consumes the reset, advance=
s its receive
window, and drops the real ClientHello as a replay - the hand=
shake
deadlocks until it times out=2E

The send path in tls_process_state()=
 and the dedicated ACK path in
tls_process() are already guarded by to_link=
->len, only the ciphertext
queueing was not=2E  Guard it as well=2E  A pend=
ing to_link makes
tls_process() report itself as active, so we are called a=
gain as soon
as the packet has been written out=2E  In the error path this =
can drop a
TLS alert that we would have queued, which is in line with that =
path
not ensuring delivery anyway=2E

Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e=
3b2c4d6a8f1e5b3
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1831
Message-Id: <20260805134336=2E163392-1=
-frank@lichtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg38133=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 10 insert=
ions(+), 3 deletions(-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/=
ssl=2Ec
index d5100af=2E=2Ed539018 100644
--- a/src/openvpn/ssl=2Ec
+++ b/s=
rc/openvpn/ssl=2Ec
@@ -2769,8 +2769,15 @@
 
 static bool
 check_outgoing_ci=
phertext(struct key_state *ks, struct tls_session *session,
-              =
            bool *continue_tls_process)
+                          struct b=
uffer *to_link, bool *continue_tls_process)
 {
+    if (to_link->len)
+    =
{
+        dmsg(D_TLS_DEBUG,
+             "Deferring outgoing ciphertext, =
previous packet not written out yet");
+        return true;
+    }
+
     =
/* Outgoing Ciphertext to reliable buffer */
     if (ks->state >=3D S_STAR=
T)
     {
@@ -2950,7 +2957,7 @@
             dmsg(D_TLS_DEBUG, "Outgoing Pl=
aintext -> TLS");
         }
     }
-    if (!check_outgoing_ciphertext(ks,=
 session, &continue_tls_process))
+    if (!check_outgoing_ciphertext(ks, s=
ession, to_link, &continue_tls_process))
     {
         goto error;
     }=

@@ -2962,7 +2969,7 @@
     /* Shut down the TLS session but do a last read=
 from the TLS
      * object to be able to read potential TLS alerts */
   =
  key_state_ssl_shutdown(&ks->ks_ssl);
-    check_outgoing_ciphertext(ks, s=
ession, &continue_tls_process);
+    check_outgoing_ciphertext(ks, session,=
 to_link, &continue_tls_process);
 
     /* Put ourselves in the pre error =
state that will only send out the
      * control channel packets but nothi=
ng else */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
31?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0e7c9d3a2=
f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
Gerrit-Change-Number: 1831
Gerrit-PatchSet: =
2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--9h01ueqBLOc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1831?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">ssl: Do not queue control ciphertext while=
 a packet is still queued<br><br>An outgoing control channel packet is hand=
ed to the link layer as a<br>buffer descriptor pointing into the reliable s=
end buffer it was built<br>from, and the packet id sits in that buffer&#39;=
s headroom, right in front<br>of the payload=2E  If the entry is reused bef=
ore the packet has been<br>written out, buf_copy_n() writes the new payload=
 and<br>reliable_mark_active_outgoing() prepends the new packet id exactly =
over<br>the packet id of the queued packet, while its opcode, ACK array and=
<br>length stay untouched=2E  The queued packet then goes out with somebody=
<br>else&#39;s packet id=2E<br><br>Observed in a TCP p2p handshake: both pe=
ers reset simultaneously, the<br>peer&#39;s two HARD_RESET packets arrive b=
ack to back, so io_wait_dowork()<br>takes the residual data shortcut (event=
_set_status =3D SOCKET_READ) and<br>does not write out our already queued H=
ARD_RESET retransmit=2E  The ACK<br>in the second peer reset then purges ou=
r reset from the send window,<br>tls_process_state() moves to S_START and q=
ueues the ClientHello into<br>the very same (now inactive) entry=2E  Result=
 on the wire: a HARD_RESET<br>with the ClientHello&#39;s packet id 1, follo=
wed by the ClientHello with<br>the same id 1=2E  The receiver consumes the =
reset, advances its receive<br>window, and drops the real ClientHello as a =
replay - the handshake<br>deadlocks until it times out=2E<br><br>The send p=
ath in tls_process_state() and the dedicated ACK path in<br>tls_process() a=
re already guarded by to_link-&gt;len, only the ciphertext<br>queueing was =
not=2E  Guard it as well=2E  A pending to_link makes<br>tls_process() repor=
t itself as active, so we are called again as soon<br>as the packet has bee=
n written out=2E  In the error path this can drop a<br>TLS alert that we wo=
uld have queued, which is in line with that path<br>not ensuring delivery a=
nyway=2E<br><br>Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1831<br>Message-Id: &lt;20260805134336=2E163=
392-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg38133=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec=
<br>1 file changed, 10 insertions(+), 3 deletions(-)<br><br></pre>
<pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index d51=
00af=2E=2Ed539018 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2769,8 +2769,15 @@</s=
pan><br><span> </span><br><span> static bool</span><br><span> check_outgoin=
g_ciphertext(struct key_state *ks, struct tls_session *session,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                          bool *c=
ontinue_tls_process)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          struct buffer *to_link, bool *continue_tls_proce=
ss)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (to_link-&gt;len)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  dmsg(D_TLS_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             &quot;Deferring outgoing ciphertext, previous packet not writt=
en out yet&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     /* Outgoing Ciphertext to reliable buffer */</span><br><span>     i=
f (ks-&gt;state &gt;=3D S_START)</span><br><span>     {</span><br><span>@@ =
-2950,7 +2957,7 @@</span><br><span>             dmsg(D_TLS_DEBUG, &quot;Out=
going Plaintext -&gt; TLS&quot;);</span><br><span>         }</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!chec=
k_outgoing_ciphertext(ks, session, &amp;continue_tls_process))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!check_outgoing_cipherte=
xt(ks, session, to_link, &amp;continue_tls_process))</span><br><span>     {=
</span><br><span>         goto error;</span><br><span>     }</span><br><spa=
n>@@ -2962,7 +2969,7 @@</span><br><span>     /* Shut down the TLS session b=
ut do a last read from the TLS</span><br><span>      * object to be able to=
 read potential TLS alerts */</span><br><span>     key_state_ssl_shutdown(&=
amp;ks-&gt;ks_ssl);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  check_outgoing_ciphertext(ks, session, &amp;continue_tls_process);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    check_outgoing_ciphert=
ext(ks, session, to_link, &amp;continue_tls_process);</span><br><span> </sp=
an><br><span>     /* Put ourselves in the pre error state that will only se=
nd out the</span><br><span>      * control channel packets but nothing else=
 */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Demail">change 1831</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0e7c9d3a2f4e6b8c1=
d5a9f7e3b2c4d6a8f1e5b3 </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1831 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--9h01ueqBLOc=--


--===============8087802654325084457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8087802654325084457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8087802654325084457==--

