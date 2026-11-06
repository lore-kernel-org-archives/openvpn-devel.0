Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF55606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JNfrdj+4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eXP22KE7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RKbkKiji;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FNp+BNMC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0G5NECxqU+9UgjUiNSxwXY8AlOEai+06sHnTNbBy6Hk=; b=JNfrdj+4JbRLQzXR0vWb13RhAt
	DTt7yTDSzZb0MKj1ARSkLBM8IG2BGJ4Kz30/U2auCI77ICcI5HCUx5fyc27NbhqrXDz5+RNQ1zqwV
	KGWs5k9/C5nVdb4+d9TeKOfp44bMwixmHYsleNKGqW2gK4cbfhN74YzJGwY88tBfvsAs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPK0I-000000000cT-49Sa;
	Fri, 06 Nov 2026 13:29:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPK0I-000000000cI-0mXh
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=maMjkjlkwNHO08gjVBcO8cYRm/hB2J8P76q5r22CKRk=; b=eXP22KE7TOVt2ba1JjOQQzIyxX
 FtgQIJHobXkpPcvaR1h4Ut96kR4enMH4+Tibxcq3Q1zgAo4l7/FaRL/6Svh7aeQKJkpm6mXfgGbk+
 3vtNz0J3tXH2TJ6kTGJQhCAx66zsUgn3yfFD7VINWfWXfEEOYlqZwq7Q0ircHqWREcOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=maMjkjlkwNHO08gjVBcO8cYRm/hB2J8P76q5r22CKRk=; b=RKbkKijiMX5XuNBH+FmYgfMozb
 Vs5Qoyias5rJ61GUVjuwNTRTlAL38Fy0fV2kjW7CvGFqmrNuNGdx9Ux8Z0p+w76L9slMyEOkQWK1V
 rxCwnmcnhtB+EMY5PKf38UqfmL3gy3bgvogHUvFM7tdypw/TUtZdWY48mKwgyvccmwKQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPK0E-000000003Sg-3tjh for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:29:14 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso6962245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 05:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793971744; x=1794576544; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=maMjkjlkwNHO08gjVBcO8cYRm/hB2J8P76q5r22CKRk=;
 b=FNp+BNMC2npQd+HSVss+2JwLHR4qL6XcPYL+JGw4YwE01DPIUYtvmU+saxwFufhAcj
 h4TO2mB6GjEYmRikfgsbCaaSMrYp6Ut5mDL0B936pCsQw6q4zcGGAb2M4wvrF1szA4lJ
 mOtBk5f+PyRg0LdcEeh0cc7P26c1Z1g1shYUK2qYe9UxSyShRPRM1hdJoe7l8lb6dn5v
 FOt4TAu+jqbQGMB3crvebrtV0HpLEPdmKlv46nFCm0Ls9hoULv8Sr9yUK8K50IfEpLAy
 s/8BtVwEigKromXIz5+IFhOJFM59ZYDEPb6+nUuTb77G7gg0RHlwpMjeGlveZWlvlCAU
 YrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793971744; x=1794576544;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=maMjkjlkwNHO08gjVBcO8cYRm/hB2J8P76q5r22CKRk=;
 b=tj7D8t9QN52+SIav+GKX3Fu1W6oYEuAQVr4otyibZPHEdHIsokqF+7EmiqX5GElE6r
 9ik6Ny2pbytaowqLrJxNtcGYKni+8JRNHpcPCmpJ0YU9wC6OXG8T5qNRN12w/Z2w4kdo
 Av5Wsec7lEAw4LDnZVhxzs1yryE5J5zh5OgMM/hbDANtoLqJ3LFm2cXarB60QcsI6VCF
 OsTaReYkc6mQSfX7+J2BKPYvFTyJJvfSeUc9+P7rRNt4A/2U4z21sr7YgIiFmg0KXEKF
 VU13aTF8+VOTBCVrtwTxspggzccPzhR5V2zX4CTE+J1B6bvmVWaM1fAZM3tJCRG2ZIND
 5qjg==
X-Gm-Message-State: APuU4Z88Gxf8775NOCuFZmMif66FXMs4JP3AibHRZ4x9GZ/gL6rewR8T
 Fs6+5QUobOBUi/kHsy/BV0iB4pC8jYwRC9rAa2w9SGfMzc/mQkmGYqRXa2AtkVWdNYeBaZyFusP
 msV+7z57IjbNuxniffUtPTkoTPi7ptTTVx8zRWMVPqdRrSSu5gXhn3TbGqEPkSUntcVhC
X-Gm-Gg: AYBFou29EpZ5sG8hdD8ls+vWP/ppU9eVkOp/ymVgC1R+niDK9w0AZkdRc/hpdSY6Lv0
 1/s+CGXhYNZc2P80dOdpELc/OmpFpX4658yudEkkH46a+Ej51DT2zi1cbBmmyBqSjxNmrNZ3Tg5
 0hzipdNZgsEBufyAdmYp+/1nznVbIZ9u9LuXcGc0AV99+NH+V56slBwbA+lbh/UQqYL2Sui8jCC
 vO9Poa2q0XfUOa3cMHHAjfDLSrwOj2X1MHQoxEbG+7QMI5q+i3Gbgj50Hjcf3fOUqw0gVcOGzx3
 PAywDVZ9CoWb8DNzvNtR9zu6kw5nDWA9pcCCFU5Cvv9iIVHkwjuR4vZIf1F/gMgiETjXBcIaTg5
 bIxnFXLx7qGT0msb2PbghLQnxFzmpE/ygoDkNVuasA2NhIaMa2OHSq9TpbWSDweit2Papcrg4rQ
 /jVons+byNTz1gjCAi29Qa/jpP50Dt+Bi6qeW15M4Cz8Ank/Lcq+k9g2Qjg2qnsmjgTuoA0PxmH
 bP2Or3zfQAiuv+f4ZzOcEhDd1/aAXK23RABGhjck3HokPZLmXWHa+ZhT6hNWOUlDAPQKPX2pxvn
 2Z7cEVQKi1vayj1XCxZt79rES9EPM251pgaL30WLVU/OruJSvPJFErEz216cIQ5Mo9yh+Q++gM3
 vfplqOVOeEik2vApIsdgoZataiCBHEM+71nyT7MUd3xBUUHcbcjd1JjqGZdIte7bfXEZeDqb5zB
 JqEVcnm5atxGsJHHR9vdGGW1hUD2eioe9cCEI=
X-Received: by 2002:a05:600c:6814:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4b6df4f2554mr49563225e9.31.1793971743507; 
 Fri, 06 Nov 2026 05:29:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b573366ea6sm144978645e9.14.2026.11.06.05.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:29:03 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 13:29:01 +0000
To: Ralf Lici <ralf@mandelbit.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 39832e2360940141814eef076d0f0259d6450ec7
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <11730b192d339a6294b2182383d5901f6d61dfe1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPK0E-000000003Sg-3tjh
Subject: [Openvpn-devel] [L] Change in openvpn[master]: probe: Add probe
 request lookup and the probe-reply decision
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6920266323279439145=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6920266323279439145==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s8f3HkeMI2Y="; charset=UTF-8

--s8f3HkeMI2Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici=2E

Hello Arne Schwabe, Frank Lichtenheld, Ralf Lici, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1742?usp=3Demail

to look at the new patch set (#21)=2E


Change=
 subject: probe: Add probe request lookup and the probe-reply decision
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

probe: Add probe=
 request lookup and the probe-reply decision

Add the message-level helpers=
 a server needs before it can answer a
probe: probe_request_find() picks th=
e probe request TLV out of the
payload of a received P_CONTROL_V2 message, =
probe_timestamp_in_window()
checks its timestamp against the window the wir=
e protocol describes,
and probe_request_check() combines the two and classi=
fies the message
as invalid, stale or OK=2E

The request itself is handed b=
ack, because the reply has to echo its
request_id, which is how a client te=
lls which of its probes a reply
answers=2E

A stale request, one whose time=
stamp is outside the window, is reported
apart from an invalid one rather t=
han dropped here=2E The timestamp is
what bounds how long a captured reques=
t can be replayed against the
server, but a client with an unsynchronised c=
lock sends something that
looks just like a replay, so what to do about it =
is the caller's
decision: a follow-up answers a few of them per period=2E T=
he width of
the window is the caller's too; the server path passes --hand-w=
indow=2E

These are pure functions, covered by unit tests=2E The server pac=
ket path
uses them in a follow-up, which also builds and sends the reply=2E=


Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Signed-off-by: Lev S=
tipakov <lev@openvpn=2Enet>
---
M src/openvpn/probe=2Ec
M src/openvpn/probe=
=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
M tests/unit_tests/openvpn/tes=
t_probe=2Ec
M tests/unit_tests/openvpn/test_probe=2Eh
5 files changed, 289 =
insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/42/1742/21

diff --git a/src/openvpn/probe=2Ec b/src=
/openvpn/probe=2Ec
index 2497b07=2E=2Eb59c654 100644
--- a/src/openvpn/prob=
e=2Ec
+++ b/src/openvpn/probe=2Ec
@@ -92,3 +92,31 @@
     }
     return tru=
e;
 }
+
+bool
+probe_request_find(struct buffer *payload, struct probe_requ=
est *req)
+{
+    struct buffer value;
+    return ctrl_msg_find_tlv(payloa=
d, TLV_TYPE_PROBE_REQUEST, &value)
+           && probe_request_read(&value=
, req);
+}
+
+bool
+probe_timestamp_in_window(uint64_t probe_ts, uint64_t n=
ow, uint64_t window_secs)
+{
+    /* both clocks are unsigned and either ma=
y be ahead, so subtract the
+     * smaller from the larger rather than let=
ting the difference wrap */
+    uint64_t diff =3D (now > probe_ts) ? (now =
- probe_ts) : (probe_ts - now);
+    return diff <=3D window_secs;
+}
+
+en=
um probe_verdict
+probe_request_check(struct buffer *payload, uint64_t now,=
 uint64_t window_secs,
+                    struct probe_request *req)
+{
+=
    if (!probe_request_find(payload, req))
+    {
+        return PROBE_INV=
ALID;
+    }
+    return probe_timestamp_in_window(req->timestamp, now, win=
dow_secs) ? PROBE_OK : PROBE_STALE;
+}
diff --git a/src/openvpn/probe=2Eh b=
/src/openvpn/probe=2Eh
index e8b0299=2E=2Ea15bd2e 100644
--- a/src/openvpn/=
probe=2Eh
+++ b/src/openvpn/probe=2Eh
@@ -138,4 +138,61 @@
  */
 bool probe=
_reply_read(struct buffer *buf, struct probe_reply *r);
 
+/**
+ * Find the=
 probe request TLV in the payload of a received P_CONTROL_V2
+ * message an=
d parse it=2E
+ *
+ * A TLV of another type is skipped if it is marked opti=
onal and rejects the
+ * whole message if it is not, as ctrl_msg_find_tlv()=
 defines=2E payload is
+ * consumed as it is scanned=2E
+ *
+ * @param payl=
oad  the message payload, positioned at the first TLV
+ * @param req      f=
illed with the probe request on success
+ * @return true if the payload hol=
ds exactly one well-formed probe request
+ */
+bool probe_request_find(stru=
ct buffer *payload, struct probe_request *req);
+
+/**
+ * Is the timestamp=
 of a probe request close enough to our own clock?
+ *
+ * This is how a se=
rver bounds the age of the requests it answers, and with it
+ * for how lon=
g a captured request can be replayed against it=2E The window is
+ * the ca=
ller's to choose: it has to be wide enough for a client that has no
+ * pro=
per clock synchronisation, so it cannot be tight=2E
+ *
+ * @param probe_ts=
     the timestamp from the probe request, UNIX seconds
+ * @param now     =
     the current time, UNIX seconds
+ * @param window_secs  the largest dif=
ference allowed, in either direction
+ * @return true if probe_ts and now a=
re no more than window_secs apart
+ */
+bool probe_timestamp_in_window(uint=
64_t probe_ts, uint64_t now, uint64_t window_secs);
+
+/** what probe_reque=
st_check() made of a received message */
+enum probe_verdict
+{
+    PROBE_=
INVALID, /**< it holds no probe request, so there is nothing to answer */
+=
    PROBE_STALE,   /**< a probe request, but its timestamp is outside the w=
indow */
+    PROBE_OK,      /**< a probe request whose timestamp is inside=
 the window */
+};
+
+/**
+ * Classify the payload of a received P_CONTROL_=
V2 message: probe_request_find()
+ * followed by probe_timestamp_in_window(=
)=2E
+ *
+ * A stale request is reported apart from an invalid one rather t=
han folded
+ * into it, because the two deserve different treatment=2E A re=
played request and
+ * one from a client with an unsynchronised clock are i=
ndistinguishable here, so
+ * a server that dropped every stale request wou=
ld lock that client out=2E What to
+ * do instead is left to the caller, wh=
ich also builds the reply=2E
+ *
+ * @param payload      the message payloa=
d, consumed as it is read
+ * @param now          the current time, UNIX se=
conds
+ * @param window_secs  the largest difference allowed, in either dir=
ection
+ * @param req          filled with the probe request unless the ver=
dict is
+ *                     PROBE_INVALID, so that a reply can echo its=
 request_id
+ * @return what the payload turned out to be
+ */
+enum probe_=
verdict probe_request_check(struct buffer *payload, uint64_t now, uint64_t =
window_secs,
+                                       struct probe_request *=
req);
+
 #endif /* ifndef PROBE_H */
diff --git a/tests/unit_tests/openvpn/=
test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 75a1b31=2E=2E0cb=
2ea5 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_te=
sts/openvpn/test_pkt=2Ec
@@ -856,7 +856,16 @@
         cmocka_unit_test(tes=
t_find_tlv_trailing_bytes),
         cmocka_unit_test(test_find_tlv_skips_o=
ptional_after_wanted),
         cmocka_unit_test(test_find_tlv_rejects_dupl=
icate),
-        cmocka_unit_test(test_find_tlv_empty_payload)
+        cmo=
cka_unit_test(test_find_tlv_empty_payload),
+        cmocka_unit_test(test_=
probe_request_find),
+        cmocka_unit_test(test_probe_request_find_skip=
s_unknown),
+        cmocka_unit_test(test_probe_request_find_rejects_unkno=
wn_mandatory),
+        cmocka_unit_test(test_probe_request_find_missing),
=
+        cmocka_unit_test(test_probe_request_find_reply_tlv),
+        cmoc=
ka_unit_test(test_probe_timestamp_in_window),
+        cmocka_unit_test(tes=
t_probe_request_check_valid),
+        cmocka_unit_test(test_probe_request_=
check_stale),
+        cmocka_unit_test(test_probe_request_check_no_request=
)
     };
 
     return cmocka_run_group_tests_name("pkt tests", tests, NUL=
L, NULL);
diff --git a/tests/unit_tests/openvpn/test_probe=2Ec b/tests/unit=
_tests/openvpn/test_probe=2Ec
index 7cfb63d=2E=2Ea3a9d3a 100644
--- a/tests=
/unit_tests/openvpn/test_probe=2Ec
+++ b/tests/unit_tests/openvpn/test_prob=
e=2Ec
@@ -400,3 +400,179 @@
 
     gc_free(&gc);
 }
+
+/* A payload of noth=
ing but a probe request is found, fields and all=2E */
+void
+test_probe_re=
quest_find(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    stru=
ct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct probe_request=
 in =3D {
+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+        =2Etim=
estamp =3D 0x1122334455667788ULL,
+        =2Eflags =3D PROBE_REQUEST_FLAG_=
PROBE_ONLY,
+    };
+    assert_true(probe_request_write(&buf, &in));
+
+  =
  struct probe_request out =3D { 0 };
+    assert_true(probe_request_find(&=
buf, &out));
+    assert_true(out=2Erequest_id =3D=3D in=2Erequest_id);
+  =
  assert_true(out=2Etimestamp =3D=3D in=2Etimestamp);
+    assert_int_equal=
(out=2Eflags, in=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* A TLV of another t=
ype that is marked optional is skipped, so the request is
+ * still found b=
ehind one=2E */
+void
+test_probe_request_find_skips_unknown(void **state)
=
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_b=
uf_gc(128, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, =
true, 4));
+    assert_true(buf_write_u32(&buf, 0xcafef00d));
+    const st=
ruct probe_request in =3D { =2Etimestamp =3D 42 };
+    assert_true(probe_r=
equest_write(&buf, &in));
+
+    struct probe_request out =3D { 0 };
+    a=
ssert_true(probe_request_find(&buf, &out));
+    assert_true(out=2Etimestam=
p =3D=3D 42);
+
+    gc_free(&gc);
+}
+
+/* A TLV we do not know that is no=
t marked optional carries something its
+ * sender requires us to act on, s=
o the message is rejected whether that TLV
+ * comes before or after the re=
quest=2E */
+void
+test_probe_request_find_rejects_unknown_mandatory(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    const struct probe_re=
quest in =3D { =2Etimestamp =3D 42 };
+
+    struct buffer before =3D alloc=
_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&before, 0x7f=
f, false, 4));
+    assert_true(buf_write_u32(&before, 0xcafef00d));
+    a=
ssert_true(probe_request_write(&before, &in));
+
+    struct buffer after =
=3D alloc_buf_gc(128, &gc);
+    assert_true(probe_request_write(&after, &i=
n));
+    assert_true(ctrl_msg_tlv_write_header(&after, 0x7ff, false, 4));
=
+    assert_true(buf_write_u32(&after, 0xcafef00d));
+
+    struct probe_re=
quest out =3D { 0 };
+    assert_false(probe_request_find(&before, &out));
=
+    assert_false(probe_request_find(&after, &out));
+
+    gc_free(&gc);
+=
}
+
+/* A payload that holds no probe request at all=2E */
+void
+test_prob=
e_request_find_missing(void **state)
+{
+    struct gc_arena gc =3D gc_new(=
);
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(ct=
rl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_=
u32(&buf, 0));
+
+    struct probe_request out =3D { 0 };
+    assert_false=
(probe_request_find(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A probe rep=
ly is not a probe request: a server handed one must not answer
+ * it=2E Th=
e reply TLV is mandatory, so it rejects the message rather than
+ * being s=
kipped=2E */
+void
+test_probe_request_find_reply_tlv(void **state)
+{
+   =
 struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(1=
28, &gc);
+
+    const struct probe_reply in =3D { =2Erequest_id =3D 42 };
=
+    assert_true(probe_reply_write(&buf, &in));
+
+    struct probe_request=
 out =3D { 0 };
+    assert_false(probe_request_find(&buf, &out));
+
+    g=
c_free(&gc);
+}
+
+/* The window is inclusive and symmetric: a client clock=
 that is behind is
+ * treated like one that is ahead=2E */
+void
+test_pro=
be_timestamp_in_window(void **state)
+{
+    const uint64_t now =3D 1000000=
;
+    const uint64_t window =3D 30;
+
+    assert_true(probe_timestamp_in_=
window(now, now, window));
+    assert_true(probe_timestamp_in_window(now -=
 window, now, window));
+    assert_true(probe_timestamp_in_window(now + wi=
ndow, now, window));
+    assert_false(probe_timestamp_in_window(now - wind=
ow - 1, now, window));
+    assert_false(probe_timestamp_in_window(now + wi=
ndow + 1, now, window));
+
+    /* a timestamp of 0, and one near the end o=
f the range, must not wrap into
+     * the window */
+    assert_false(pro=
be_timestamp_in_window(0, now, window));
+    assert_false(probe_timestamp_=
in_window(UINT64_MAX, now, window));
+}
+
+/* A well-formed request with a =
timestamp inside the window=2E */
+void
+test_probe_request_check_valid(voi=
d **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    const uint64_t now =3D 1000000;
+    con=
st struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D now =
};
+    assert_true(probe_request_write(&buf, &in));
+
+    struct probe_re=
quest req =3D { 0 };
+    assert_int_equal(probe_request_check(&buf, now, 3=
0, &req), PROBE_OK);
+    assert_true(req=2Erequest_id =3D=3D 1);
+
+    gc=
_free(&gc);
+}
+
+/* One whose timestamp is outside it is stale rather than=
 invalid, and is
+ * still handed back so that the caller can answer it if =
it decides to=2E */
+void
+test_probe_request_check_stale(void **state)
+{
=
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_=
gc(128, &gc);
+
+    const uint64_t now =3D 1000000;
+    const struct prob=
e_request in =3D { =2Erequest_id =3D 7, =2Etimestamp =3D now - 1000 };
+   =
 assert_true(probe_request_write(&buf, &in));
+
+    struct probe_request r=
eq =3D { 0 };
+    assert_int_equal(probe_request_check(&buf, now, 30, &req=
), PROBE_STALE);
+    assert_true(req=2Erequest_id =3D=3D 7);
+
+    gc_fre=
e(&gc);
+}
+
+/* A payload with no request in it has nothing to answer=2E *=
/
+void
+test_probe_request_check_no_request(void **state)
+{
+    struct g=
c_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);=

+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    =
assert_true(buf_write_u32(&buf, 0));
+
+    struct probe_request req;
+    =
assert_int_equal(probe_request_check(&buf, 1000000, 30, &req), PROBE_INVALI=
D);
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_prob=
e=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh
index bc51721=2E=2Ed9d8f31 =
100644
--- a/tests/unit_tests/openvpn/test_probe=2Eh
+++ b/tests/unit_tests=
/openvpn/test_probe=2Eh
@@ -48,4 +48,22 @@
 void test_find_tlv_rejects_dupl=
icate(void **state);
 
 void test_find_tlv_empty_payload(void **state);
+
+=
void test_probe_request_find(void **state);
+
+void test_probe_request_find=
_skips_unknown(void **state);
+
+void test_probe_request_find_rejects_unkno=
wn_mandatory(void **state);
+
+void test_probe_request_find_missing(void **=
state);
+
+void test_probe_request_find_reply_tlv(void **state);
+
+void te=
st_probe_timestamp_in_window(void **state);
+
+void test_probe_request_chec=
k_valid(void **state);
+
+void test_probe_request_check_stale(void **state)=
;
+
+void test_probe_request_check_no_request(void **state);
 #endif

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5=
752e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 21
Gerrit-=
Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
alf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>

--s8f3HkeMI2Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici=2E </p>
<p=
>Lev Stipakov <strong>uploaded patch set #21</strong> to this change=2E</p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">=
View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">probe: Add probe request lookup and the pr=
obe-reply decision<br><br>Add the message-level helpers a server needs befo=
re it can answer a<br>probe: probe_request_find() picks the probe request T=
LV out of the<br>payload of a received P_CONTROL_V2 message, probe_timestam=
p_in_window()<br>checks its timestamp against the window the wire protocol =
describes,<br>and probe_request_check() combines the two and classifies the=
 message<br>as invalid, stale or OK=2E<br><br>The request itself is handed =
back, because the reply has to echo its<br>request_id, which is how a clien=
t tells which of its probes a reply<br>answers=2E<br><br>A stale request, o=
ne whose timestamp is outside the window, is reported<br>apart from an inva=
lid one rather than dropped here=2E The timestamp is<br>what bounds how lon=
g a captured request can be replayed against the<br>server, but a client wi=
th an unsynchronised clock sends something that<br>looks just like a replay=
, so what to do about it is the caller&#39;s<br>decision: a follow-up answe=
rs a few of them per period=2E The width of<br>the window is the caller&#39=
;s too; the server path passes --hand-window=2E<br><br>These are pure funct=
ions, covered by unit tests=2E The server packet path<br>uses them in a fol=
low-up, which also builds and sends the reply=2E<br><br>Change-Id: Iafa9efc=
1c156974ad9f5752e9de810a8c2f68c30<br>Signed-off-by: Lev Stipakov &lt;lev@op=
envpn=2Enet&gt;<br>---<br>M src/openvpn/probe=2Ec<br>M src/openvpn/probe=2E=
h<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>M tests/unit_tests/openvpn/=
test_probe=2Ec<br>M tests/unit_tests/openvpn/test_probe=2Eh<br>5 files chan=
ged, 289 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/21</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/probe=2Ec b/src/openvpn/probe=2Ec</span><br><span>i=
ndex 2497b07=2E=2Eb59c654 100644</span><br><span>--- a/src/openvpn/probe=2E=
c</span><br><span>+++ b/src/openvpn/probe=2Ec</span><br><span>@@ -92,3 +92,=
31 @@</span><br><span>     }</span><br><span>     return true;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+probe_request_find(struct buffer *payload, stru=
ct probe_request *req)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ctrl_msg_find_tlv(payload, TLV_TYPE_PROBE_REQUEST, &amp;value)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; probe_req=
uest_read(&amp;value, req);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+probe_timestamp_in_window(uint64_t probe_ts,=
 uint64_t now, uint64_t window_secs)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* both clocks are unsigned and either may be ahead, so subtract the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * smaller from the=
 larger rather than letting the difference wrap */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    uint64_t diff =3D (now &gt; probe_ts) ? =
(now - probe_ts) : (probe_ts - now);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return diff &lt;=3D window_secs;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enu=
m probe_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prob=
e_request_check(struct buffer *payload, uint64_t now, uint64_t window_secs,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 struct probe_request *req)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!p=
robe_request_find(payload, req))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return PROBE_INVALID;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn probe_timestamp_in_window(req-&gt;timestamp, now, window_secs) ? PROB=
E_OK : PROBE_STALE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span>diff --git a/src/openvpn/probe=2Eh b/src/openvpn/probe=2E=
h</span><br><span>index e8b0299=2E=2Ea15bd2e 100644</span><br><span>--- a/s=
rc/openvpn/probe=2Eh</span><br><span>+++ b/src/openvpn/probe=2Eh</span><br>=
<span>@@ -138,4 +138,61 @@</span><br><span>  */</span><br><span> bool probe=
_reply_read(struct buffer *buf, struct probe_reply *r);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Find the probe request TLV in the =
payload of a received P_CONTROL_V2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * message and parse it=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * A TLV of another type is skipped if it is marked optional and rejec=
ts the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whole mess=
age if it is not, as ctrl_msg_find_tlv() defines=2E payload is</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * consumed as it is scanned=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param payload  the message payloa=
d, positioned at the first TLV</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param req      filled with the probe request on success</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the p=
ayload holds exactly one well-formed probe request</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool probe_request_find(struct buffer *payload, struct probe=
_request *req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Is the timestamp of a probe request =
close enough to our own clock?</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Thi=
s is how a server bounds the age of the requests it answers, and with it</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for how long a capt=
ured request can be replayed against it=2E The window is</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * the caller&#39;s to choose: it has =
to be wide enough for a client that has no</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * proper clock synchronisation, so it cannot be tig=
ht=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts     the time=
stamp from the probe request, UNIX seconds</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param now          the current time, UNIX second=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_s=
ecs  the largest difference allowed, in either direction</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return true if probe_ts and now ar=
e no more than window_secs apart</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l probe_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t windo=
w_secs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/** what probe_request_check()=
 made of a received message */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+enum probe_verdict</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROB=
E_INVALID, /**&lt; it holds no probe request, so there is nothing to answer=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROBE_STALE,=
   /**&lt; a probe request, but its timestamp is outside the window */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROBE_OK,      /**&l=
t; a probe request whose timestamp is inside the window */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Classify t=
he payload of a received P_CONTROL_V2 message: probe_request_find()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * followed by probe_timest=
amp_in_window()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A stale request=
 is reported apart from an invalid one rather than folded</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * into it, because the two deserve d=
ifferent treatment=2E A replayed request and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * one from a client with an unsynchronised clock =
are indistinguishable here, so</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * a server that dropped every stale request would lock that cli=
ent out=2E What to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* do instead is left to the caller, which also builds the reply=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param payload      the message payload, c=
onsumed as it is read</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param now          the current time, UNIX seconds</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs  the largest diff=
erence allowed, in either direction</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param req          filled with the probe request unless=
 the verdict is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
                   PROBE_INVALID, so that a reply can echo its request_id</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return what the p=
ayload turned out to be</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum probe_v=
erdict probe_request_check(struct buffer *payload, uint64_t now, uint64_t w=
indow_secs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                               struct probe_request *req);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef P=
ROBE_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2E=
c b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index 75a1b31=2E=
=2E0cb2ea5 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br>=
<span>@@ -856,7 +856,16 @@</span><br><span>         cmocka_unit_test(test_f=
ind_tlv_trailing_bytes),</span><br><span>         cmocka_unit_test(test_fin=
d_tlv_skips_optional_after_wanted),</span><br><span>         cmocka_unit_te=
st(test_find_tlv_rejects_duplicate),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        cmocka_unit_test(test_find_tlv_empty_payload)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_find_tlv_empty_payload),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_probe_request_find),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe=
_request_find_skips_unknown),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_probe_request_find_rejects_unknown_=
mandatory),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_probe_request_find_missing),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_=
find_reply_tlv),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_probe_timestamp_in_window),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_requ=
est_check_valid),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_probe_request_check_stale),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_req=
uest_check_no_request)</span><br><span>     };</span><br><span> </span><br>=
<span>     return cmocka_run_group_tests_name(&quot;pkt tests&quot;, tests,=
 NULL, NULL);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pr=
obe=2Ec b/tests/unit_tests/openvpn/test_probe=2Ec</span><br><span>index 7cf=
b63d=2E=2Ea3a9d3a 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_probe=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=2Ec</=
span><br><span>@@ -400,3 +400,179 @@</span><br><span> </span><br><span>    =
 gc_free(&amp;gc);</span><br><span> }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* A payload of nothing but a probe request is found, fields and all=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_find(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct probe_request in =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x112=
2334455667788ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(probe_request_write(&amp;buf, &amp;in));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct probe_request out =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(prob=
e_request_find(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(out=2Erequest_id =3D=3D in=2Erequest_id);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=
=2Etimestamp =3D=3D in=2Etimestamp);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV o=
f another type that is marked optional is skipped, so the request is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * still found behind one=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_find_skip=
s_unknown(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff=
, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct probe_request in =3D { =2Etimes=
tamp =3D 42 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(probe_request_write(&amp;buf, &amp;in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct probe_request out =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_find(&amp;=
buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(out=2Etimestamp =3D=3D 42);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* A TLV we do not know that is n=
ot marked optional carries something its</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * sender requires us to act on, so the message is rej=
ected whether that TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * comes before or after the request=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_probe_request_find_rejects_unknown_mandatory(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct prob=
e_request in =3D { =2Etimestamp =3D 42 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer before =3D alloc_buf_gc(128, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_=
header(&amp;before, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;before, 0xcafef00d));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pro=
be_request_write(&amp;before, &amp;in));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer after =3D alloc_buf_gc(128, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_write(&=
amp;after, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, false, 4));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_=
write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(probe_request_find(&amp;before, &amp;out)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
probe_request_find(&amp;after, &amp;out));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* A payload that holds no prob=
e request at all=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_r=
equest_find_missing(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;=
buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct probe_request out =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(probe_request_find(&amp;buf, =
&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A probe reply is not a probe request: a server handed one=
 must not answer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
it=2E The reply TLV is mandatory, so it rejects the message rather than</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * being skipped=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_find_reply_tlv(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct probe_reply in =3D { =2Erequest_id =3D 42 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_re=
ply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(probe_request_find(&amp;buf, &amp;out));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
The window is inclusive and symmetric: a client clock that is behind is</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * treated like one tha=
t is ahead=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_timesta=
mp_in_window(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const uint64_t window =3D 30;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(probe_timestamp_in_window(now, now, window));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_timestamp_i=
n_window(now - window, now, window));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(probe_timestamp_in_window(now + window, n=
ow, window));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(probe_timestamp_in_window(now - window - 1, now, window));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(probe_ti=
mestamp_in_window(now + window + 1, now, window));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* a timestamp of 0, and one near the end of the range, mus=
t not wrap into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * the window */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(probe_timestamp_in_window(0, now, window));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(probe_timestamp_in_w=
indow(UINT64_MAX, now, window));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A well-formed request=
 with a timestamp inside the window=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_probe_request_check_valid(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D=
 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D now };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(prob=
e_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct probe_request req =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(probe_request_check(&amp;buf, now, 3=
0, &amp;req), PROBE_OK);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(req=2Erequest_id =3D=3D 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* One whose timestamp is=
 outside it is stale rather than invalid, and is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * still handed back so that the caller can an=
swer it if it decides to=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_probe_request_check_stale(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_r=
equest in =3D { =2Erequest_id =3D 7, =2Etimestamp =3D now - 1000 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_reque=
st_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t probe_request req =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(probe_request_check(&amp;buf, now, 30, &amp=
;req), PROBE_STALE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(req=2Erequest_id =3D=3D 7);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload with no request =
in it has nothing to answer=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_probe_request_check_no_request(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_wri=
te_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct probe_request req;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(probe_request_check(=
&amp;buf, 1000000, 30, &amp;req), PROBE_INVALID);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_p=
robe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh</span><br><span>index bc=
51721=2E=2Ed9d8f31 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_probe=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=2Eh<=
/span><br><span>@@ -48,4 +48,22 @@</span><br><span> void test_find_tlv_reje=
cts_duplicate(void **state);</span><br><span> </span><br><span> void test_f=
ind_tlv_empty_payload(void **state);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id test_probe_request_find(void **state);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void test_probe_request_find_skips_unknown(void **state);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void test_probe_request_find_rejects_unknown_mandator=
y(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_reques=
t_find_missing(void **state);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test=
_probe_request_find_reply_tlv(void **state);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void test_probe_timestamp_in_window(void **state);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void test_probe_request_check_valid(void **state);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void test_probe_request_check_stale(void **st=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void test_probe_request_check_no_=
request(void **state);</span><br><span> #endif</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demai=
l">change 1742</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>

</body></html>
--s8f3HkeMI2Y=--


--===============6920266323279439145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6920266323279439145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6920266323279439145==--

