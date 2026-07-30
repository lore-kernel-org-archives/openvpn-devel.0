Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B8C54FDF
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AID2Ijrmhcy2qG/Ap9RsYyW5lOJ4ILxRzpt795stigI=; b=PZfFWV5VoVsOTZ
	/QD5vMzXyJ7PkB9wom+f/7/Kzea6w4CAH+WPmCcmJDsLpmWgTTd4amUw1Upm5GWPGdiUxtQBWuxxl
	gmjEcOPcYhJZmq/uJqamrIfTFtMqnTtHLsCgcK01R+Bvqqgpq4oM8s2lM4QSH9MVt/n7in0VQXP7c
	7K8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpMgg-0002l6-OU;
	Thu, 30 Jul 2026 09:04:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpMgJ-0002jD-0q
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 09:03:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pzzwM1/8+RUZjMEXPexMqTgoY8RenXW70htCQzpuzDo=; b=hilVsBqarnu+AIJkoEvOquA9ei
 Nn4bH/Jg5J5300KjCqfM6tiJPNJ5kF5KbRWeLseVzJj1ZLaaeaL5ztwuCxyzcZ1fpYh2WC4ZZF6wr
 OKeIAad6/+GNIg//dqnBAtUzih5C0n4A7bZb9z+FLkBxyQs9xgTPaQfA2cHhvERZ0N9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pzzwM1/8+RUZjMEXPexMqTgoY8RenXW70htCQzpuzDo=; b=V
 3mOrcTyXhIcCMU1g8OrdQK6vvnjJtMQ1ojdiXfDc7sTZ+SP7doGdAvyTBU8vMjMDa3CSBDdJDLKoY
 HJg1kNmUqgiXeTrV2SrD7/BjkOM4E1jp+2gVRiO/YT/KtC8V5xNOODs8EGxXDOzxCxuoaUrlqH/4d
 BtRPJNpZx9Wa1qRE=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpMgF-0003wC-KI for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 09:03:56 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49557167508so15902855e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785402229; x=1786007029; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pzzwM1/8+RUZjMEXPexMqTgoY8RenXW70htCQzpuzDo=;
 b=Vv6T7BDkyyKE2f/q0fB/AFWlQkXGyyJXZ5xcxJRqOV81QDN+ZL4NP7R8U0oqh0kGMG
 0ujhllQvMOvUFl3Fbo1WLNg9kD+6Bbw+vQqKZeTF8kVlzwTpuQJcL2sErPa00ut0q9fV
 rotgcipjuBw2Ek+NqzqZScUYtpvpiZjHXY5RhdSLj6eCsZphMvb2G3ULljZYqoCV6foL
 rFmW2NGCpC4PoPSfW78CxcrCwf8ZC4uBYv5r3h42MtuWaSYAXu208WD6JXT9OiYZgDEQ
 57N2FyXTM80TZmFN9pcvRUGrdrngPFuNzgPAN49vwHVPPQ2ajljflbZYYceDAbEmJHDn
 XLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785402229; x=1786007029;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pzzwM1/8+RUZjMEXPexMqTgoY8RenXW70htCQzpuzDo=;
 b=agiF/tFFsPI6IhN3cn8ruU6RrwbnX18me5eQKVFe7efir0rTaGZohr/ddc3vGYoA36
 mQJ6vEToJkwoT9uf+GMxIlbIauH2hRHZw5HyA03yQSSUibk3jtViK6yYzmU7GQ/qQYbc
 j1lOV4T6AHBnBtDKJUrWXORZaM/KO0f6lkb6AqVYD/y7FBEOZjvzc0NNiVaSHYz3y4np
 cyytbrrjFy8Whi0XSjx2aGUVuI16DhK6B+xTsS1ES5kPWtJrOAnYeV3hptFBT/3hgZxS
 E39aH1iaYg6w9gqPIVUBp7KxVgFODg/M/5Fxnnbw6nAXtRhtM1CtDkKRiY0dSgi7lTW2
 hXjw==
X-Gm-Message-State: AOJu0Yx87RNw1eQBfoAnb/rfy3M8enq0Z4qp6YiJS3HuIFMEX/2nY/Tn
 ksSct/CZsKpubiJIaVGQnBzCyKUSB3g0PflyVKcJb8VDmz4FMAP6Rxpi6E7M+F0XpRQp3ayu29s
 jW2yut4Qik0IuJbOdd6XEt7xM8ghRx6Pdl1Oxm3ISPISeuw9EQEhyE9QBflkpOv/zKXpxlr4aHJ
 KrfSCp2g==
X-Gm-Gg: AR+sD11gwy3nVyKAbygcGE29Z05mxRnTtgnt1zQ1NcIJ2gL6DiaAbA/UNvlNyyeqNIY
 KeTt0kiWHVQuV1EPyCu+z+vmeLi8zPq2NnyjSGn4+shHBxtQSpgYSdaxBquAcc72ouBEFzN3BAm
 u/w6i+Qa9iZbLLypusGT1ZZSJu0Dd/Dl//HxPs6fzGdKHOxxeGsjMdvn12hjeKNbo+/J2Pqt/eg
 6yRbC9K133VlKfHAKqMdLzwOlK4rtWpSe3+PFy9J9KHuvk3pTdlf7bmHgYVKWXGRbZDE5RCGd3c
 8ivwyYqYw0tfCxwsIAiv0pYH6VQrV6vYvczG6eIbkojehkKbKZsKoGnPS7c8h7O9Vgv0Vpl9OGi
 nRaE35blmko4e3hrF5tgN6bGpowLT2YFHJSVQLRfzj8Ug12Y2Q5RY7CX9OfAwkGItYbkB95pZpL
 Z/ZAK+GXiOqtoPEQj0hqyzGaPbWQ72h/NesSYRm7UyIMkr3+kWjZMR8hIrk/OWZzf8GGAFasj1L
 JBjJq4gmkqTDwcwc+So/R5whAbE4ds6NyygRn8MrKy08CuwfpNrFt+4NegP9t6t7SINTMBVM3ux
 AtY05U67It7dLtXpFFN6QyWt+NZ98LmuD/3Etzs6euyeC4neYIc=
X-Received: by 2002:a05:600c:a3a2:b0:495:6396:8b67 with SMTP id
 5b1f17b1804b1-49800e89181mr15368615e9.4.1785402228942; 
 Thu, 30 Jul 2026 02:03:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc8941e7asm3964954f8f.36.2026.07.30.02.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:03:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 09:03:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
X-Gerrit-Change-Number: 1832
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1832?usp=email>
X-Gerrit-Commit: 2962c4e1c61699905dba0ce2d6efc6799f984b13
References: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkkzYzdkMWY5ZTViMmE0YzZkOGUxZjNhNWI3YzlkMmU0ZjZhOGIxYzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a39fd2fcf759bbbdb9242187aca92a32b3109753-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpMgF-0003wC-KI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Ignore hard
 reset packets with a non-zero packet id
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6620241564073878995=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6620241564073878995==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="usCEnIUwvig="; charset=UTF-8

--usCEnIUwvig=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1832?usp=3Demail

to review the following change=2E


Chang=
e subject: ssl: Ignore hard reset packets with a non-zero packet id
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: Ignore hard re=
set packets with a non-zero packet id

A hard reset is always the first pac=
ket of a session, so it always
carries reliable packet id 0=2E tls_process_=
state() relies on that when it
treats a received reset as the early negotia=
tion packet only for packet
id 0, and the stateless three-way handshake rel=
ies on it as well (see
the comment in session_skip_to_pre_start())=2E

A re=
set claiming a different id is therefore bogus=2E

We had a bug that could =
cause hard reset replays with packet id 1 in
specific scenarios (P2P TCP)=
=2E In that case we accepted the packet id
at face value and then ignored t=
he control packet that actually had
id 1 as an replay=2E This caused a diff=
icult to diagnose dead connection
that was stuck just before TLS negotiatio=
n=2E The check added handles
this specific scenario well in that we just ig=
nore the bogus reset
but do not abort the connection attempt=2E Starting fr=
esh might retrigger
the bug=2E If there would be a separate bug where the c=
lient only sends
hard resets with packet id 1 we will still get logging on =
the server
side now=2E

Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3=
d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/open=
vpn/ssl=2Ec
1 file changed, 15 insertions(+), 1 deletion(-)



  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/1832/1

diff --gi=
t a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 7f2e850=2E=2E46ccc12 10=
0644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3903,8 +3903,2=
2 @@
         /* Extract the packet ID from the packet */
         if (reli=
able_ack_read_packet_id(buf, &id))
         {
+            /* A hard reset =
always is the first packet of a session, so it
+             * always must =
use packet id 0=2E Ignore it if it claims another id=2E
+             * In =
a specific existing bug these packets were replays of an
+             * al=
ready handled reset, so ignoring it is better than aborting
+             *=
 the connection attempt=2E
+             */
+            if (is_hard_reset_=
method2(op) && id !=3D 0)
+            {
+                msg(D_TLS_ERRORS,=

+                    "TLS Error: received %s with packet id " packet_id_fo=
rmat
+                    " from %s -- 0 was expected, ignoring packet",
+ =
                   packet_opcode_name(op), (packet_id_print_type)id,
+     =
               print_link_socket_actual(from, &gc));
+            }
       =
      /* Avoid deadlock by rejecting packet that would de-sequentialize rec=
eive buffer */
-            if (reliable_wont_break_sequentiality(ks->rec_r=
eliable, id))
+            else if (reliable_wont_break_sequentiality(ks->r=
ec_reliable, id))
             {
                 if (reliable_not_replay(k=
s->rec_reliable, id))
                 {

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
Gerrit-Cha=
nge-Number: 1832
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--usCEnIUwvig=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">ssl: Ignore hard reset packets with a non-zero packet id<br><br>A hard=
 reset is always the first packet of a session, so it always<br>carries rel=
iable packet id 0=2E tls_process_state() relies on that when it<br>treats a=
 received reset as the early negotiation packet only for packet<br>id 0, an=
d the stateless three-way handshake relies on it as well (see<br>the commen=
t in session_skip_to_pre_start())=2E<br><br>A reset claiming a different id=
 is therefore bogus=2E<br><br>We had a bug that could cause hard reset repl=
ays with packet id 1 in<br>specific scenarios (P2P TCP)=2E In that case we =
accepted the packet id<br>at face value and then ignored the control packet=
 that actually had<br>id 1 as an replay=2E This caused a difficult to diagn=
ose dead connection<br>that was stuck just before TLS negotiation=2E The ch=
eck added handles<br>this specific scenario well in that we just ignore the=
 bogus reset<br>but do not abort the connection attempt=2E Starting fresh m=
ight retrigger<br>the bug=2E If there would be a separate bug where the cli=
ent only sends<br>hard resets with packet id 1 we will still get logging on=
 the server<br>side now=2E<br><br>Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2=
e4f6a8b1c3d<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 15 insertions(+), 1=
 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/32/1832/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ss=
l=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 7f2e850=2E=2E46ccc12 1006=
44</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/open=
vpn/ssl=2Ec</span><br><span>@@ -3903,8 +3903,22 @@</span><br><span>        =
 /* Extract the packet ID from the packet */</span><br><span>         if (r=
eliable_ack_read_packet_id(buf, &amp;id))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* A hard rese=
t always is the first packet of a session, so it</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * always must use packet id 0=2E =
Ignore it if it claims another id=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             * In a specific existing bug these packets we=
re replays of an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * already handled reset, so ignoring it is better than aborting</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * the co=
nnection attempt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (is_hard_reset_method2(op) &amp;&amp; id !=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(D_TLS_ERRORS,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;T=
LS Error: received %s with packet id &quot; packet_id_format</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    &quot; from %s=
 -- 0 was expected, ignoring packet&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    packet_opcode_name(op), (packet_=
id_print_type)id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  print_link_socket_actual(from, &amp;gc));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>     =
        /* Avoid deadlock by rejecting packet that would de-sequentialize r=
eceive buffer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (reliable_wont_break_sequentiality(ks-&gt;rec_reliable, id))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (rel=
iable_wont_break_sequentiality(ks-&gt;rec_reliable, id))</span><br><span>  =
           {</span><br><span>                 if (reliable_not_replay(ks-&g=
t;rec_reliable, id))</span><br><span>                 {</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1832?usp=3Demail">change 1832</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1832?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b=
1c3d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1832 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--usCEnIUwvig=--


--===============6620241564073878995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6620241564073878995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6620241564073878995==--

