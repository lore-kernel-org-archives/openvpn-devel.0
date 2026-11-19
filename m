Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5655606A324
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CPwSOC7i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kIcYI7O1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YdEbHAe1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QAq/N61l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=t+wIpzZLlp2DPve8e4JgWmcqqvu7Q47eEaFydFk+V7M=; b=CPwSOC7iFhrdPRknyuuZ50m6FC
	+NdU7QZ4pMvEAMb18jkIuVec6rmSyFsyUDBXoA2AiRRZ0c6ru2g9EpD7y9c/SfmPH7mqLVqKHWPfB
	Y15ZlQp74Z/NbP4owftJMLt1AUs+GhElcy169uLjDATnBZTkY0anAL+D610FYC9l+B5A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzka-000000006Op-2qDn;
	Thu, 19 Nov 2026 10:52:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTzkY-000000006Oa-2yGX
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:52:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kGo/KKJRB8hOi7X2cn236zXyQk5SajESJfZGay4N3Gs=; b=kIcYI7O1vnAx/P7QvR/eK+Mbok
 VF+JZBDrSiPL2kBR3e9QZ6tvDeSJY4BcxQAr02G6kEQuQB3HBaJrqLFV4m6qYd2Q7fxWoXtCotUnk
 Xj8piioz4JLwEEXVbnl54RmVGutTKTXfFA9Ygs+dNXZ4gaRJec2jEgmOfoeXSOUCNxnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kGo/KKJRB8hOi7X2cn236zXyQk5SajESJfZGay4N3Gs=; b=YdEbHAe117inR0Hy1MgoJ7ThKj
 J2L/zwtMV3teAr1qOl0vw/Z9To9HBD+jIiwdfvfFc3x3eUmh8dNS1FA82mk0gR4ZaSjyVT3YoZjk+
 X6T/uRcCwkeC/lghQr8X4aFc2qzfusQGeGk1C1bCHOo0+aK/TdT6RONfVUVdSIoeV2RY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTzkP-000000005uM-2LiA for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:52:18 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so10120755e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 02:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795085523; x=1795690323; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kGo/KKJRB8hOi7X2cn236zXyQk5SajESJfZGay4N3Gs=;
 b=QAq/N61lNZmnKe9l440V6P6p3W+4NrPDWmebwcskVhgM1T7LDj9jFWywGMKKdqss/n
 4tq79mdl/aCQAu375JD7ch8a/DiALnF66/DLCsn9qvb/kr8i7wvcWCIeFSk5OK+watiC
 eZ2DS3xWB8JxLHVMnTdCHMOStVrJFzhrII8phF/3dsbTR9jlbV5UZ42GBhs1z0SP9uoM
 qujxUajexiVVZycztPs2hqUtsdj5zhXqtYQQIYHlnTx8eJm20uls+GZxhoF7L5O6zqO5
 Vfuw7+jMnCDmyl81WcfkbaVa6ruNssTEny9AK3s0oxR/6t+qwuguKt5VtuQ8+KeA63Jz
 nPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795085523; x=1795690323;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kGo/KKJRB8hOi7X2cn236zXyQk5SajESJfZGay4N3Gs=;
 b=nHv3Tkoz4kNs+iyMUAmfCnCbFvxSWoobJcGXSYCXw4E5yttUN85K8uOMgCxjs1yAih
 JFIwEAXpBoRN4mRSQJr6YEyE/P+dsfQvSCkMagUwkU6HF3okRT3H97OyoblG4sThDqem
 Ve4e2fwJNFcyDXmF4dnHolzrb1/e9RDWuVP5FQqoYS60+JDbZTEM3/FQoFH9rBwrKaLc
 YGTu255oTnMIpBrtfGYqh29XR6LSLnUXH+X4YiCfnmx8cEj35cOzzJoBc+tmG3KT+krV
 nmd37Vj1E2HBLQMV0YEMSzzv48bykcpOFGpkZoHO6WXMByKVGB5fat6+i6dchB7BMheo
 +gTA==
X-Gm-Message-State: APuU4Z/GwOnDk4bJJgE2c+CMztxqiEWCuIbVOGSGS9mjWyZPsFn7YE+k
 f4F0TQuZZ5TVZZSN+fSxulvSPzfFk+7zPNSVpjOc//2tToMIcxrAeUom3Hj7vZHUOxLJKdR4PC0
 AVaPNe6NBpZFbLXx/0+SnIZDTHMHjY8GSmdAzdOfGjpPYJ0PapzWSJFSz0O4OBbVISuC6
X-Gm-Gg: AYBFou2yaYc2jV+8L3vtfZ/YVsOPAV41DGidFJ1sZN0vtbdY6/BQs/A6F5Ff4Sh7TIk
 2BpDzu8qHRZTMpiolZDf1qKU5edmHslKfbcLX3DNX4qCwCqihPqPr1W9JlovPm+bZMvux6NF975
 bU4biQ1v7KPiC5nALYYr9FGjoH8vtdni7D5q9UH0L+s93ma+z9jTBx49AGFbTZCKwKrqmqbRzAt
 JonyYC5vZUAEsiMMZF1l42Qh9L3ws5kxCXsebta75baPSVekS193biu7RXy5o0RKr0deANdMIKB
 EPo+7Ilv3lIZes77B6mhg4qoa7gzI3tsN7Anj7lRXeN93ZQltsFFOCLNUjLuSxqQtOrvAYB+Nok
 Sx0F0NiiZTIYfeVbOpl/g2pmiM+Ka37HHzycxQi6gJbym6kTVNi5kjFCiQsd0ka4EwzHrZfJUHq
 1/V/mp0kNF1MvSxfNMeKG1F4rnwiJyd0EQX9+kRvH+HO4Cfipw7DKB8YD+BrAYq4hRtFih9OzUk
 2JEJpsXDjlgUlyiMMDmXTNAbVU5XvrsbqwLgaw/Kz8Dazmz8zu57RodO89QYAZxusXpe41vQefB
 qwayDQgq87S1kAMml2ThIqjDipoWTmnC1617sbcN19DgwfbeID1XCW8jDHRqdYrP6PCXyZjePRu
 YbjQD70rzOovs60qzsTPgYwEXofu8agvyRwdw6zgL5I3+ZjOtZhRw8V3eaWvD954clK61MWk+6B
 cTz9NcB7AKpdpa4ZM=
X-Received: by 2002:a05:600c:6290:b0:4ba:495c:2f5d with SMTP id
 5b1f17b1804b1-4bb7d9fb3d4mr109398965e9.9.1795085522656; 
 Thu, 19 Nov 2026 02:52:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm9829265f8f.18.2026.11.19.02.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 02:52:02 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 10:51:58 +0000
To: Ralf Lici <ralf@mandelbit.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 23ccdfa593bb7c0810c842f8d4387c664a1fd49b
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e8f68a4a7f95043aa054c8e1b6ec4fb50e49c150-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTzkP-000000005uM-2LiA
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
Content-Type: multipart/mixed; boundary="===============7253220142836259003=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7253220142836259003==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="koe19d9Vd40="; charset=UTF-8

--koe19d9Vd40=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici=2E

Hello Arne Schwabe, Frank Lichtenheld, Ralf Lici, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1742?usp=3Demail

to look at the new patch set (#27)=2E


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
8/openvpn refs/changes/42/1742/27

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
index 6001774=2E=2Ef836416 100644
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
+ * consumed as it is read=2E
+ *
+ * @param payload=
  the message payload, positioned at the first TLV
+ * @param req      fill=
ed with the probe request on success
+ * @return true if the payload holds =
exactly one well-formed probe request
+ */
+bool probe_request_find(struct =
buffer *payload, struct probe_request *req);
+
+/**
+ * Is the timestamp of=
 a probe request close enough to our own clock?
+ *
+ * This is how a serve=
r bounds the age of the requests it answers, and with it
+ * for how long a=
 captured request can be replayed against it=2E The window is
+ * the calle=
r's to choose: it has to be wide enough for a client that has no
+ * proper=
 clock synchronisation, so it cannot be tight=2E
+ *
+ * @param probe_ts   =
  the timestamp from the probe request, UNIX seconds
+ * @param now        =
  the current time, UNIX seconds
+ * @param window_secs  the largest differ=
ence allowed, in either direction
+ * @return true if probe_ts and now are =
no more than window_secs apart
+ */
+bool probe_timestamp_in_window(uint64_=
t probe_ts, uint64_t now, uint64_t window_secs);
+
+/** what probe_request_=
check() made of a received message */
+enum probe_verdict
+{
+    PROBE_INV=
ALID, /**< it holds no probe request, so there is nothing to answer */
+   =
 PROBE_STALE,   /**< a probe request, but its timestamp is outside the wind=
ow */
+    PROBE_OK,      /**< a probe request whose timestamp is inside th=
e window */
+};
+
+/**
+ * Classify the payload of a received P_CONTROL_V2 =
message: probe_request_find()
+ * followed by probe_timestamp_in_window()=
=2E
+ *
+ * A stale request is reported apart from an invalid one rather th=
an folded
+ * into it, because the two deserve different treatment=2E A rep=
layed request and
+ * one from a client with an unsynchronised clock are in=
distinguishable here, so
+ * a server that dropped every stale request woul=
d lock that client out=2E What to
+ * do instead is left to the caller, whi=
ch also builds the reply=2E
+ *
+ * @param payload      the message payload=
, consumed as it is read
+ * @param now          the current time, UNIX sec=
onds
+ * @param window_secs  the largest difference allowed, in either dire=
ction
+ * @param req          filled with the probe request unless the verd=
ict is
+ *                     PROBE_INVALID, so that a reply can echo its =
request_id
+ * @return what the payload turned out to be
+ */
+enum probe_v=
erdict probe_request_check(struct buffer *payload, uint64_t now, uint64_t w=
indow_secs,
+                                       struct probe_request *r=
eq);
+
 #endif /* ifndef PROBE_H */
diff --git a/tests/unit_tests/openvpn/t=
est_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 5609c67=2E=2E8aa3=
e1f 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tes=
ts/openvpn/test_pkt=2Ec
@@ -856,7 +856,16 @@
         cmocka_unit_test(test=
_find_tlv_skips_optional_after_wanted),
         cmocka_unit_test(test_find=
_tlv_rejects_unknown_mandatory),
         cmocka_unit_test(test_find_tlv_re=
jects_duplicate),
-        cmocka_unit_test(test_find_tlv_empty_payload)
+ =
       cmocka_unit_test(test_find_tlv_empty_payload),
+        cmocka_unit_=
test(test_probe_request_find),
+        cmocka_unit_test(test_probe_request=
_find_skips_unknown),
+        cmocka_unit_test(test_probe_request_find_rej=
ects_unknown_mandatory),
+        cmocka_unit_test(test_probe_request_find_=
missing),
+        cmocka_unit_test(test_probe_request_find_reply_tlv),
+  =
      cmocka_unit_test(test_probe_timestamp_in_window),
+        cmocka_uni=
t_test(test_probe_request_check_valid),
+        cmocka_unit_test(test_prob=
e_request_check_stale),
+        cmocka_unit_test(test_probe_request_check_=
no_request)
     };
 
     return cmocka_run_group_tests_name("pkt tests", =
tests, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_probe=2Ec b/=
tests/unit_tests/openvpn/test_probe=2Ec
index 967252c=2E=2E1c6d2c1 100644
-=
-- a/tests/unit_tests/openvpn/test_probe=2Ec
+++ b/tests/unit_tests/openvpn=
/test_probe=2Ec
@@ -423,3 +423,179 @@
 
     gc_free(&gc);
 }
+
+/* A paylo=
ad of nothing but a probe request is found, fields and all=2E */
+void
+tes=
t_probe_request_find(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct pro=
be_request in =3D {
+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+    =
    =2Etimestamp =3D 0x1122334455667788ULL,
+        =2Eflags =3D PROBE_REQ=
UEST_FLAG_PROBE_ONLY,
+    };
+    assert_true(probe_request_write(&buf, &i=
n));
+
+    struct probe_request out =3D { 0 };
+    assert_true(probe_requ=
est_find(&buf, &out));
+    assert_true(out=2Erequest_id =3D=3D in=2Ereques=
t_id);
+    assert_true(out=2Etimestamp =3D=3D in=2Etimestamp);
+    assert=
_int_equal(out=2Eflags, in=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* A TLV of=
 another type that is marked optional is skipped, so the request is
+ * sti=
ll found behind one=2E */
+void
+test_probe_request_find_skips_unknown(void=
 **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&b=
uf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0xcafef00d));
+ =
   const struct probe_request in =3D { =2Etimestamp =3D 42 };
+    assert_t=
rue(probe_request_write(&buf, &in));
+
+    struct probe_request out =3D { =
0 };
+    assert_true(probe_request_find(&buf, &out));
+    assert_true(out=
=2Etimestamp =3D=3D 42);
+
+    gc_free(&gc);
+}
+
+/* A TLV we do not know=
 that is not marked optional carries something its
+ * sender requires us t=
o act on, so the message is rejected whether that TLV
+ * comes before or a=
fter the request=2E */
+void
+test_probe_request_find_rejects_unknown_manda=
tory(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    const stru=
ct probe_request in =3D { =2Etimestamp =3D 42 };
+
+    struct buffer befor=
e =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&b=
efore, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&before, 0xcafef00=
d));
+    assert_true(probe_request_write(&before, &in));
+
+    struct buf=
fer after =3D alloc_buf_gc(128, &gc);
+    assert_true(probe_request_write(=
&after, &in));
+    assert_true(ctrl_msg_tlv_write_header(&after, 0x7ff, fa=
lse, 4));
+    assert_true(buf_write_u32(&after, 0xcafef00d));
+
+    struc=
t probe_request out =3D { 0 };
+    assert_false(probe_request_find(&before=
, &out));
+    assert_false(probe_request_find(&after, &out));
+
+    gc_fr=
ee(&gc);
+}
+
+/* A payload that holds no probe request at all=2E */
+void
=
+test_probe_request_find_missing(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    ass=
ert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true=
(buf_write_u32(&buf, 0));
+
+    struct probe_request out =3D { 0 };
+    a=
ssert_false(probe_request_find(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* =
A probe reply is not a probe request: a server handed one must not answer
+=
 * it=2E The reply TLV is mandatory, so it rejects the message rather than
=
+ * being skipped=2E */
+void
+test_probe_request_find_reply_tlv(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D all=
oc_buf_gc(128, &gc);
+
+    const struct probe_reply in =3D { =2Erequest_id=
 =3D 42 };
+    assert_true(probe_reply_write(&buf, &in));
+
+    struct pr=
obe_request out =3D { 0 };
+    assert_false(probe_request_find(&buf, &out)=
);
+
+    gc_free(&gc);
+}
+
+/* The window is inclusive and symmetric: a c=
lient clock that is behind is
+ * treated like one that is ahead=2E */
+voi=
d
+test_probe_timestamp_in_window(void **state)
+{
+    const uint64_t now =
=3D 1000000;
+    const uint64_t window =3D 30;
+
+    assert_true(probe_ti=
mestamp_in_window(now, now, window));
+    assert_true(probe_timestamp_in_w=
indow(now - window, now, window));
+    assert_true(probe_timestamp_in_wind=
ow(now + window, now, window));
+    assert_false(probe_timestamp_in_window=
(now - window - 1, now, window));
+    assert_false(probe_timestamp_in_wind=
ow(now + window + 1, now, window));
+
+    /* a timestamp of 0, and one nea=
r the end of the range, must not wrap into
+     * the window */
+    asser=
t_false(probe_timestamp_in_window(0, now, window));
+    assert_false(probe=
_timestamp_in_window(UINT64_MAX, now, window));
+}
+
+/* A well-formed requ=
est with a timestamp inside the window=2E */
+void
+test_probe_request_chec=
k_valid(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_t now =3D 100000=
0;
+    const struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimesta=
mp =3D now };
+    assert_true(probe_request_write(&buf, &in));
+
+    stru=
ct probe_request req =3D { 0 };
+    assert_int_equal(probe_request_check(&=
buf, now, 30, &req), PROBE_OK);
+    assert_true(req=2Erequest_id =3D=3D 1)=
;
+
+    gc_free(&gc);
+}
+
+/* One whose timestamp is outside it is stale =
rather than invalid, and is
+ * still handed back so that the caller can an=
swer it if it decides to=2E */
+void
+test_probe_request_check_stale(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    const uint64_t now =3D 1000000;
+    const =
struct probe_request in =3D { =2Erequest_id =3D 7, =2Etimestamp =3D now - 1=
000 };
+    assert_true(probe_request_write(&buf, &in));
+
+    struct prob=
e_request req =3D { 0 };
+    assert_int_equal(probe_request_check(&buf, no=
w, 30, &req), PROBE_STALE);
+    assert_true(req=2Erequest_id =3D=3D 7);
+
=
+    gc_free(&gc);
+}
+
+/* A payload with no request in it has nothing to =
answer=2E */
+void
+test_probe_request_check_no_request(void **state)
+{
+ =
   struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc=
(128, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true,=
 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct probe_request=
 req;
+    assert_int_equal(probe_request_check(&buf, 1000000, 30, &req), P=
ROBE_INVALID);
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvp=
n/test_probe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh
index 9c4137d=2E=
=2E941bf99 100644
--- a/tests/unit_tests/openvpn/test_probe=2Eh
+++ b/tests=
/unit_tests/openvpn/test_probe=2Eh
@@ -51,4 +51,22 @@
 
 void test_find_tlv=
_empty_payload(void **state);
 
+void test_probe_request_find(void **state)=
;
+
+void test_probe_request_find_skips_unknown(void **state);
+
+void test=
_probe_request_find_rejects_unknown_mandatory(void **state);
+
+void test_p=
robe_request_find_missing(void **state);
+
+void test_probe_request_find_re=
ply_tlv(void **state);
+
+void test_probe_timestamp_in_window(void **state)=
;
+
+void test_probe_request_check_valid(void **state);
+
+void test_probe_=
request_check_stale(void **state);
+
+void test_probe_request_check_no_requ=
est(void **state);
+
 #endif

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change-Num=
ber: 1742
Gerrit-PatchSet: 27
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf =
Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>

--koe19d9Vd40=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici=2E </p>
<p=
>Lev Stipakov <strong>uploaded patch set #27</strong> to this change=2E</p>=
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
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/27</pre><pre=
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
h</span><br><span>index 6001774=2E=2Ef836416 100644</span><br><span>--- a/s=
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
pan style=3D"color: hsl(120, 100%, 40%);">+ * consumed as it is read=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param payload  the message payload, =
positioned at the first TLV</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param req      filled with the probe request on success</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the payl=
oad holds exactly one well-formed probe request</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool probe_request_find(struct buffer *payload, struct probe_re=
quest *req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Is the timestamp of a probe request cl=
ose enough to our own clock?</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This =
is how a server bounds the age of the requests it answers, and with it</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for how long a captur=
ed request can be replayed against it=2E The window is</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * the caller&#39;s to choose: it has to=
 be wide enough for a client that has no</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * proper clock synchronisation, so it cannot be tight=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts     the timest=
amp from the probe request, UNIX seconds</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param now          the current time, UNIX seconds<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_sec=
s  the largest difference allowed, in either direction</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return true if probe_ts and now are =
no more than window_secs apart</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool =
probe_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_=
secs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/** what probe_request_check() m=
ade of a received message */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+enum probe_verdict</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROBE_=
INVALID, /**&lt; it holds no probe request, so there is nothing to answer *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROBE_STALE,  =
 /**&lt; a probe request, but its timestamp is outside the window */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    PROBE_OK,      /**&lt;=
 a probe request whose timestamp is inside the window */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Classify the=
 payload of a received P_CONTROL_V2 message: probe_request_find()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * followed by probe_timestam=
p_in_window()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A stale request i=
s reported apart from an invalid one rather than folded</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * into it, because the two deserve dif=
ferent treatment=2E A replayed request and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * one from a client with an unsynchronised clock ar=
e indistinguishable here, so</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * a server that dropped every stale request would lock that clien=
t out=2E What to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
do instead is left to the caller, which also builds the reply=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param payload      the message payload, con=
sumed as it is read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param now          the current time, UNIX seconds</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs  the largest differ=
ence allowed, in either direction</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param req          filled with the probe request unless t=
he verdict is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
                 PROBE_INVALID, so that a reply can echo its request_id</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return what the pay=
load turned out to be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum probe_ver=
dict probe_request_check(struct buffer *payload, uint64_t now, uint64_t win=
dow_secs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                             struct probe_request *req);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef PRO=
BE_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec =
b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index 5609c67=2E=2E=
8aa3e1f 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span=
>@@ -856,7 +856,16 @@</span><br><span>         cmocka_unit_test(test_find_t=
lv_skips_optional_after_wanted),</span><br><span>         cmocka_unit_test(=
test_find_tlv_rejects_unknown_mandatory),</span><br><span>         cmocka_u=
nit_test(test_find_tlv_rejects_duplicate),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        cmocka_unit_test(test_find_tlv_empty_payload)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_find_tlv_empty_payload),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_probe_request_find),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_probe_request_find_skips_unknown),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_probe_request_find_rejects_un=
known_mandatory),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_probe_request_find_missing),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_re=
quest_find_reply_tlv),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_probe_timestamp_in_window),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_request_check_valid),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_probe_request_check_stale),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_pro=
be_request_check_no_request)</span><br><span>     };</span><br><span> </spa=
n><br><span>     return cmocka_run_group_tests_name(&quot;pkt tests&quot;, =
tests, NULL, NULL);</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_probe=2Ec b/tests/unit_tests/openvpn/test_probe=2Ec</span><br><span>ind=
ex 967252c=2E=2E1c6d2c1 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_probe=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=
=2Ec</span><br><span>@@ -423,3 +423,179 @@</span><br><span> </span><br><spa=
n>     gc_free(&amp;gc);</span><br><span> }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* A payload of nothing but a probe request is found, fields and all=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_find(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct probe_request in =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =
=3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(probe_request_write(&amp;buf, &am=
p;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_request out =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(probe_request_find(&amp;buf, &amp;out));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(out=2Erequest_id =3D=3D in=2Ere=
quest_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(out=2Etimestamp =3D=3D in=2Etimestamp);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* A TLV of another type that is marked optional is skipped, so the request=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * still found b=
ehind one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_=
find_skips_unknown(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;b=
uf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct probe_request in =3D {=
 =2Etimestamp =3D 42 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct probe_request out =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_fin=
d(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(out=2Etimestamp =3D=3D 42);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV we do not know th=
at is not marked optional carries something its</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * sender requires us to act on, so the message=
 is rejected whether that TLV</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * comes before or after the request=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_probe_request_find_rejects_unknown_mandatory(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct probe_request in =3D { =2Etimestamp =3D 42 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer before =3D alloc_buf_gc(128, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_header(&amp;before, 0x7ff, false, 4));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;before, 0xcaf=
ef00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(probe_request_write(&amp;before, &amp;in));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer after =3D alloc_buf_gc(128, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request=
_write(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, fals=
e, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(buf_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct probe_request out =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(probe_request_find(&amp;before, &=
amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(probe_request_find(&amp;after, &amp;out));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload that holds=
 no probe request at all=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_probe_request_find_missing(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_head=
er(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct probe_request out =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(probe_request_find(&a=
mp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* A probe reply is not a probe request: a server hand=
ed one must not answer</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * it=2E The reply TLV is mandatory, so it rejects the message rather th=
an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * being skipped=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_find_repl=
y_tlv(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct probe_reply in =3D { =2Erequest_id =3D 42 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pr=
obe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(probe_request_find(&amp;buf, &amp;out));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* The window is inclusive and symmetric: a client clock that is behind i=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * treated like on=
e that is ahead=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_ti=
mestamp_in_window(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint64_t window =3D 30;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(probe_timestamp_in_window(now, now, window));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_timest=
amp_in_window(now - window, now, window));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(probe_timestamp_in_window(now + wind=
ow, now, window));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_false(probe_timestamp_in_window(now - window - 1, now, window));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(pro=
be_timestamp_in_window(now + window + 1, now, window));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* a timestamp of 0, and one near the end of the range=
, must not wrap into</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * the window */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(probe_timestamp_in_window(0, now, window));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(probe_timestamp=
_in_window(UINT64_MAX, now, window));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A well-formed re=
quest with a timestamp inside the window=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_probe_request_check_valid(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =
=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D now =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(p=
robe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct probe_request req =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(probe_request_check(&amp;buf, now=
, 30, &amp;req), PROBE_OK);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(req=2Erequest_id =3D=3D 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* One whose timesta=
mp is outside it is stale rather than invalid, and is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * still handed back so that the caller c=
an answer it if it decides to=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_probe_request_check_stale(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct pr=
obe_request in =3D { =2Erequest_id =3D 7, =2Etimestamp =3D now - 1000 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_=
request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct probe_request req =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(probe_request_check(&amp;buf, now, 30,=
 &amp;req), PROBE_STALE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(req=2Erequest_id =3D=3D 7);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload with no req=
uest in it has nothing to answer=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_probe_request_check_no_request(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_t=
lv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct probe_request req;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(probe_request_=
check(&amp;buf, 1000000, 30, &amp;req), PROBE_INVALID);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_probe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh</span><br><span>in=
dex 9c4137d=2E=2E941bf99 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_probe=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_prob=
e=2Eh</span><br><span>@@ -51,4 +51,22 @@</span><br><span> </span><br><span>=
 void test_find_tlv_empty_payload(void **state);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_request_find=
(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_request=
_find_skips_unknown(void **state);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 test_probe_request_find_rejects_unknown_mandatory(void **state);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void test_probe_request_find_missing(void **stat=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void test_probe_request_find_reply_=
tlv(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_time=
stamp_in_window(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_probe_request_check_valid(void **state);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void test_probe_request_check_stale(void **state);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void test_probe_request_check_no_request(void **state);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endi=
f</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de81=
0a8c2f68c30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1742 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--koe19d9Vd40=--


--===============7253220142836259003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7253220142836259003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7253220142836259003==--

