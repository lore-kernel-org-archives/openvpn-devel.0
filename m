Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3CAC54F52
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aGxWx2VTBRxzlTxXD3603oguWesMJKmpxPPh+Oh3jSA=; b=a3D2Y4l3XZtqBUpL5gHk2UjhAQ
	dSqUHJcRcQEdL2KeLHAF1JquZodQqRnRvXjhEr1NBepCHZ5PRPvOB4ORJCZ1A//HHfBOFau0bFEGj
	36M0GudfgaFuC9RGakgPrf6mifgyuTfXx5mHV/GHMRZIBPmf+u2X594l9ODLAEL7coIg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3KW-0002Cm-W1;
	Wed, 29 Jul 2026 12:24:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jw-00028b-Bi
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f7OMT9woDHpOkSBeOG4EMnkmKFyu8vw6W0iQtyNS4q0=; b=i/6dh0/lG3Kf/dc7Y3PYyr9nLa
 8WNxAjA2ePHekvO5m9VVZ1teketA4KSqaMg4yP1XOZ6F7GblnVwNZnVWgeBYNS7cRYFldMFSDr1Ws
 J/+mSjrRfrXq3oLGPXw4sDwon8lsl/j3uEzta6tZlfDoXmze4lNASn5NZUrLBLtwt7p4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f7OMT9woDHpOkSBeOG4EMnkmKFyu8vw6W0iQtyNS4q0=; b=O
 T5Qg0wGytsJI0Lm8/asiYkVA2021nvLHluLmnVBKrmmu1qlzyubU2VwkB9b95cCkN4pKtSuixOImC
 Zvm9/vDZzbrrrFO/+B+fYpahv9dXaUFnUuHVVh4Vj+yHLeIFlpbT3ndvhL18Z0Z9krbLaHP3XH0Hb
 wtrqpOoPpi8S35Ao=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Ju-0006On-3r for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:37 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f84023916so874385f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327807; x=1785932607; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f7OMT9woDHpOkSBeOG4EMnkmKFyu8vw6W0iQtyNS4q0=;
 b=VKugWNYt2TPJcvbhYzycGF5b/rA0K0cLfOiNh2p7TUWdOjMpROFPZjWHfeEUCaQnWJ
 Ub/6NyneD4bqydj8Ab+eBWru6JhS6qxAXVce4y7OvEGNoMtyFtbfkrdEj2CsqTBGBqAX
 BVaXBZwML5cuSkJxCGNekBresJFDF9hJ7/WENV5X2ZusId87QQn5pgbJ980yBTjwzEpC
 sEy7FwobYsC0aCPxCnjzt9xERPOKA0802vIhed1bu1T+swS2G28eBAM/mkJImyVp/70V
 C10/B3q4vBKV5wKvW5VJooxK0va6Jq9k5zcFa9UyMgyKScHMnZxF0mO0iKTnklmXDMif
 P4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327807; x=1785932607;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f7OMT9woDHpOkSBeOG4EMnkmKFyu8vw6W0iQtyNS4q0=;
 b=T9wEpSS3ZwgOdZEc2FVepn/XRX4PG774RVq/Bi7GquXhWcHX2/hQ/prmG6n4w4XfnZ
 eoqGz/Yti5ZJiWjfjG0dpK9uqBdbaF+T5gXmLsyVfBYiqvtgPLIln+NXsEE5NhlxOddW
 J8cZsn93IZd2+0MBsXMhMyADZX3XwjWw0R/8SWHtEK/0eoEZl7WBa2jv5nhYA6SlDYqJ
 Uy8u8Sdci/gU5bxHJwAoikraXm6JHsQe2tMNPMqrw0vkWjaNnCDUhfo7RvYsnzYoV4DO
 RkAPpUjmxZ8Ck6FxsBmgtu6bxuDWFD601jlPMDM7mnL9DO9L/2VdgWLaFyWBTDHw1LIR
 sGfA==
X-Gm-Message-State: AOJu0Yzq7/2avbh/Za1OncsxP3ywe7adiPejKwcGkSc9LMcHlwH+PIBQ
 1tNZcRCt2KcqWEScrytym0wIe2DTM18ByiA384o3h5hv30dPmBT18nxxoTBCu1TPbWJzwcomOXZ
 4HlUf69fcTz3KWZyX63HBaGNlXbn1zBeX6R8ciDYZJzmEWDcU/6B0tUdl+RhjUFkDeWEb
X-Gm-Gg: AR+sD10VatCyWSkrrTOcDidISeA8ESslu7QqnnSrIObqgR6xi6kvXJE+qyrm5u78cEg
 0GKvCD4p99FZJieulvpffhqNpuGLO0lHnuJFW9uPKbp6Yahr0FmLgF2HVfkylLwn0hRDe/Lb+tx
 HoIrR2w0DABZGD7yXAfHVS4O+DwPSdmzc/jFFFRsiBoxdD9hb+xPG0pP0HwvfWWaO7JXdZS+Asd
 qPPh3XYTwkD8ZkO1ZISgv/VxP238w79I4n2Mjp5IxdjP8QsDzCevi4pv7Z2idRBi+snQV+XMTCN
 q6u6/heTd2CLrSFrlDPhAy8ELtWbKE/II0soD/zGDWi20JD4EuTebnhMcw9Ko9LAr4aKgXFByUB
 dQGdpNZ3SuaGjN5/5gw9iDdNu/Fgt7E27qLB0azmE9tzjwYpF5EQDSQK29XHW2LWmpOh7Mavgsv
 51ZfY8Nexh7EocsMxyGdlEmprQrvFmtY8qCXIbLLd6s0tTaztt7hdn+p6bzIho2cO7W7F0OJJ1I
 XisS6fgCMf8uWCJUea4VyWHIXspFYVcy6mXxstNa+3SMHXkf+DKFBUFGQhCEAmNP1Sn9BlCNz06
 KGF6HNq61jwACngOu9abe035Lbi2mggZEDO6r+YMVzI0VZpEBtQ=
X-Received: by 2002:a05:6000:4283:b0:47d:f445:9490 with SMTP id
 ffacd0b85a97d-47fb1f282b9mr7642174f8f.60.1785327807283; 
 Wed, 29 Jul 2026 05:23:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0ef1asm7803940f8f.19.2026.07.29.05.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:26 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 52eb41d32656a1dbef8042a70463131500f6a77c
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8361c43f4ca4d4516ae921cde6f7d869bdf41a14-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Ju-0006On-3r
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: advertise a
 connect_lifetime in the probe reply
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
Content-Type: multipart/mixed; boundary="===============2256299606525791415=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2256299606525791415==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nkxeMzl1q+A="; charset=UTF-8

--nkxeMzl1q+A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1768?usp=3Demail

to look at the new patch set (#10)=2E


Ch=
ange subject: oob: advertise a connect_lifetime in the probe reply
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: advertise a co=
nnect_lifetime in the probe reply

A server answering an out-of-band SERVER=
_PROBE now also advertises a
connect_lifetime in the PROBE_REPLY: how long,=
 in seconds, a probing client may
use the reply as the server's HARD_RESET =
when it starts a handshake=2E

The value is inferred, not configurable: the=
 reply is only usable as that reset
while its stateless SYN-cookie is valid=
, i=2Ee=2E the guaranteed cookie window of
~handshake_window (2 quantised b=
uckets; see check_session_hmac_and_pkt_id), so
the server advertises exactl=
y that=2E A probe that arrived as
P_CONTROL_OOB_WKC_V1 also gets OOB_PROBE_=
REPLY_FLAG_RESEND_WKC, telling the
client to resend the WKc when completing=
 the handshake, since the server keeps
no state=2E

Only the wire advertise=
ment is added here -- the server fills both values into
the probe_reply it =
hands to oob_build_probe_reply()=2E The client side that acts
on them follo=
ws=2E

Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Signed-off-by: =
Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/o=
ob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 26 insertio=
ns(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/68/1768/10

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec
index 2f48fff=2E=2E9a3acb5 100644
--- a/src/openvpn/mudp=2Ec
+++ =
b/src/openvpn/mudp=2Ec
@@ -243,11 +243,27 @@
         /* Out-of-band server=
 probe=2E state->newbuf points at the TLV payload
          * (read_control=
_auth has stripped the opcode, session id and any
          * tls-auth/tls-=
crypt wrapping)=2E Answer it without creating a session=2E */
+
+        /*=
 A tls-crypt-v2 client must resend the WKc if it later uses this reply
+   =
      * to start a handshake, since we keep no state=2E */
+        uint32_=
t reply_flags =3D
+            (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? =
OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;
+
+        /* The client's third packe=
t validates only while its SYN-cookie does, so
+         * the advertised c=
onnect_lifetime is inferred (not configurable): the
+         * guaranteed =
cookie window of ~handshake_window (2 quantised buckets; see
+         * ch=
eck_session_hmac_and_pkt_id)=2E Advertising more would make the client
+   =
      * trust an already-expired cookie=2E (RFC: connect_lifetime is how lo=
ng the
+         * server considers the reply valid=2E) */
+        int con=
nect_lifetime =3D 2 * ((handwindow + 1) / 2);
+
         /* what we adverti=
se; oob_build_probe_reply() adds the peer's session id */
         struct o=
ob_probe_reply reply =3D {
             =2Epriority =3D (uint16_t)m->top=2E=
options=2Eserver_probe_reply_priority,
             =2Eweight =3D (uint16_t=
)m->top=2Eoptions=2Eserver_probe_reply_weight,
             =2Emax_latency_=
diff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
=
+            =2Econnect_lifetime =3D (uint16_t)connect_lifetime,
+         =
   =2Eflags =3D reply_flags,
         };
         if (!oob_build_probe_repl=
y(&state->newbuf, (uint64_t)now, (uint64_t)handwindow,
                    =
                &state->peer_session_id, &reply))
diff --git a/src/openvpn/=
oob=2Eh b/src/openvpn/oob=2Eh
index 4eec498=2E=2E3ff7b53 100644
--- a/src/o=
penvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -157,6 +157,12 @@
  */
 bool oo=
b_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs=
);
 
+/* probe_reply flags (the reply TLV's 32-bit flags field) */
+/* bit =
0: the client must resend the wrapped client key (via P_CONTROL_WKC_V1)
+ *=
 when it completes the handshake started from this reply=2E Set
+ * by a tl=
s-crypt-v2 server, which is stateless and discarded the WKc=2E */
+#define =
OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1
+
 /**
  * Process the TLV payload of a=
 received SERVER_PROBE and decide whether to
  * answer it=2E Combines oob_=
server_probe_read() and oob_timestamp_in_window():
diff --git a/tests/unit_=
tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index f6=
e25b4=2E=2Ee6eb6db 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b=
/tests/unit_tests/openvpn/test_oob=2Ec
@@ -390,13 +390,15 @@
         =2Epr=
iority =3D 5,
         =2Eweight =3D 50,
         =2Emax_latency_diff =3D 2=
5,
+        =2Econnect_lifetime =3D 120,
+        =2Eflags =3D OOB_PROBE_RE=
PLY_FLAG_RESEND_WKC,
     };
     assert_true(oob_build_probe_reply(&buf, n=
ow, 30, &peer, &reply));
     assert_memory_equal(reply=2Epeer_session_id=
=2Eid, peer=2Eid, SID_SIZE);
     assert_int_equal(reply=2Epriority, 5);
  =
   assert_int_equal(reply=2Eweight, 50);
-    assert_int_equal(reply=2Econn=
ect_lifetime, 0);
-    assert_int_equal(reply=2Eflags, 0);
+    assert_int_=
equal(reply=2Econnect_lifetime, 120);
+    assert_int_equal(reply=2Eflags, =
OOB_PROBE_REPLY_FLAG_RESEND_WKC);
     assert_int_equal(reply=2Emax_latency=
_diff, 25);
 
     gc_free(&gc);

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerrit-Change-Num=
ber: 1768
Gerrit-PatchSet: 10
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lst=
ipakov@gmail=2Ecom>

--nkxeMzl1q+A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>stipa <strong>uploaded patch set #10=
</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1768?usp=3Demail">View Change</a></p><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: adverti=
se a connect_lifetime in the probe reply<br><br>A server answering an out-o=
f-band SERVER_PROBE now also advertises a<br>connect_lifetime in the PROBE_=
REPLY: how long, in seconds, a probing client may<br>use the reply as the s=
erver&#39;s HARD_RESET when it starts a handshake=2E<br><br>The value is in=
ferred, not configurable: the reply is only usable as that reset<br>while i=
ts stateless SYN-cookie is valid, i=2Ee=2E the guaranteed cookie window of<=
br>~handshake_window (2 quantised buckets; see check_session_hmac_and_pkt_i=
d), so<br>the server advertises exactly that=2E A probe that arrived as<br>=
P_CONTROL_OOB_WKC_V1 also gets OOB_PROBE_REPLY_FLAG_RESEND_WKC, telling the=
<br>client to resend the WKc when completing the handshake, since the serve=
r keeps<br>no state=2E<br><br>Only the wire advertisement is added here -- =
the server fills both values into<br>the probe_reply it hands to oob_build_=
probe_reply()=2E The client side that acts<br>on them follows=2E<br><br>Cha=
nge-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae<br>Signed-off-by: Lev Sti=
pakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/o=
penvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 files change=
d, 26 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/10</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index=
 2f48fff=2E=2E9a3acb5 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</sp=
an><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -243,11 +243,27 =
@@</span><br><span>         /* Out-of-band server probe=2E state-&gt;newbuf=
 points at the TLV payload</span><br><span>          * (read_control_auth h=
as stripped the opcode, session id and any</span><br><span>          * tls-=
auth/tls-crypt wrapping)=2E Answer it without creating a session=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* A tls-crypt-v2 client must res=
end the WKc if it later uses this reply</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * to start a handshake, since we keep no state=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint3=
2_t reply_flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLA=
G_RESEND_WKC : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The client=
&#39;s third packet validates only while its SYN-cookie does, so</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * the advertised conn=
ect_lifetime is inferred (not configurable): the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * guaranteed cookie window of ~handsh=
ake_window (2 quantised buckets; see</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * check_session_hmac_and_pkt_id)=2E Advertising m=
ore would make the client</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * trust an already-expired cookie=2E (RFC: connect_lifetime =
is how long the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * server considers the reply valid=2E) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        int connect_lifetime =3D 2 * ((handwindo=
w + 1) / 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         /* what we advertise; oob_build_probe_reply() adds the p=
eer&#39;s session id */</span><br><span>         struct oob_probe_reply rep=
ly =3D {</span><br><span>             =2Epriority =3D (uint16_t)m-&gt;top=
=2Eoptions=2Eserver_probe_reply_priority,</span><br><span>             =2Ew=
eight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span>=
<br><span>             =2Emax_latency_diff =3D (uint16_t)m-&gt;top=2Eoption=
s=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            =2Econnect_lifetime =3D (uint16_t)connect_=
lifetime,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  =2Eflags =3D reply_flags,</span><br><span>         };</span><br><span>   =
      if (!oob_build_probe_reply(&amp;state-&gt;newbuf, (uint64_t)now, (uin=
t64_t)handwindow,</span><br><span>                                    &amp;=
state-&gt;peer_session_id, &amp;reply))</span><br><span>diff --git a/src/op=
envpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 4eec498=2E=2E3ff7=
b53 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/=
src/openvpn/oob=2Eh</span><br><span>@@ -157,6 +157,12 @@</span><br><span>  =
*/</span><br><span> bool oob_timestamp_in_window(uint64_t probe_ts, uint64_=
t now, uint64_t window_secs);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* probe_reply flags (the reply TLV&#39;s 32-bi=
t flags field) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 bit 0: the client must resend the wrapped client key (via P_CONTROL_WKC_V1=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when it complet=
es the handshake started from this reply=2E Set</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * by a tls-crypt-v2 server, which is stateless=
 and discarded the WKc=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Process the TLV payload of a received SERVER_PROBE and decide whether to</=
span><br><span>  * answer it=2E Combines oob_server_probe_read() and oob_ti=
mestamp_in_window():</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index =
f6e25b4=2E=2Ee6eb6db 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</s=
pan><br><span>@@ -390,13 +390,15 @@</span><br><span>         =2Epriority =
=3D 5,</span><br><span>         =2Eweight =3D 50,</span><br><span>         =
=2Emax_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        =2Econnect_lifetime =3D 120,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        =2Eflags =3D OOB_PROBE_REPLY_FLAG_RESEND_W=
KC,</span><br><span>     };</span><br><span>     assert_true(oob_build_prob=
e_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));</span><br><span>     as=
sert_memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);</span=
><br><span>     assert_int_equal(reply=2Epriority, 5);</span><br><span>    =
 assert_int_equal(reply=2Eweight, 50);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_int_equal(reply=2Econnect_lifetime, 0);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(reply=2E=
flags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(reply=2Econnect_lifetime, 120);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Eflags, OOB_PROBE_REPLY=
_FLAG_RESEND_WKC);</span><br><span>     assert_int_equal(reply=2Emax_latenc=
y_diff, 25);</span><br><span> </span><br><span>     gc_free(&amp;gc);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292=
ee8d879f714901ffae </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>

</body></html>
--nkxeMzl1q+A=--


--===============2256299606525791415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2256299606525791415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2256299606525791415==--

