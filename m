Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FC606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CD8jSzAN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DvXNQqXQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B2J8V9s8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MIHifG74
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UI+wSuiA7+vR6WC3etfwji+moWQj1UO1/qhQwjR3Eq8=; b=CD8jSzANkt15QYAhg2a+hK/fv7
	3wy0gD+QX8MhPmBk8GipMVE7xWmi3ReTN1YLdaNtXbpn777rKbz4ajCrnx72zA6bFLPlrEC6AOD63
	Oc1JADxgy/GRe3gtGCMXHczgQk4zt8yUPyRIQTG8ixUpBijcCiD4/3ozIpdZ6VU8eA/0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSspj-000000003T1-0A6T;
	Mon, 16 Nov 2026 09:17:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSsph-000000003Sb-1YuX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:17:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=48n0EXvAVPkpfx4qUMLSOKpbl0uT4sWNbXIxc+uIZTs=; b=DvXNQqXQUJ40NQunb1SVC3LX8W
 rqCgVghITeUhBvt2wD1zBU3+lREUYpbPtuMPbHc/31sTbiQ/QLpOk9WZwiXoPL+TTYmLU6cbLn9Cu
 8Rj8zERo2NKLCJ49qQ2iDBfgINtItZR83kCYKTJHo8KSwYcnPGFLQAQbV72S74t3QQZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=48n0EXvAVPkpfx4qUMLSOKpbl0uT4sWNbXIxc+uIZTs=; b=B2J8V9s8/3I9+4vT+bdWs1aYv1
 Xq644z98PKdb6VOjGdeRXnYbaaKp80zHa8x52Yb/1cdbbQO1creb4dfPlHFI9e4jObiqLk3wTRBpf
 vyHOnestm20zsMd9GTRAkvGRC5iAuLPteXPIFfFRyC/riS/CLfaPRuAr5MXTTaXeLPjo=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSspf-000000007F6-3sWL for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:17:01 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso18625325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794820613; x=1795425413; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=48n0EXvAVPkpfx4qUMLSOKpbl0uT4sWNbXIxc+uIZTs=;
 b=MIHifG74oUQjECffVMogvtqgo4GH0/2DeBkJAWbLL9pyjqOdCaWlAB4uU+Qa21AlXR
 1P7n7wwMUwSWZFtbwjHvark+6hErQrVbUkH9IO8W+awnIlPUSxEP49F95S3BHzfT6TzZ
 Cw+C72bPb6ThX21m+wDTjTsIdfECQIXzT2h3SA9L/Bnh2VICH3wMREIbdeyAJobpijs4
 63FziOJ4fcVoD+mcKK7rjQaK0MT66o2SMoIkSjrnC6Y/geWh9wv59VhBGjMplxzkWHbx
 pt49odBK5jJKj2bd4FOid/pui/sxLLJp291D/g5lFlPgIYW5xHWSxWfpp8qhlXxwUWZM
 W7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794820613; x=1795425413;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=48n0EXvAVPkpfx4qUMLSOKpbl0uT4sWNbXIxc+uIZTs=;
 b=MmyasomabwHMqjqt8OT0/Rieuq4dSB7lZYH6Cd6f+Fq1JYchNiqevSPKvE/tI6X3AV
 4BYVS31axBBz3l9NmKBJKjulliFkWXHKUDsKUmWeu+KeKmMUuX9ZGBz0+YuAfDeNrsOX
 fhrOpyqMvJ5aEpqtNhk3TWRQagNJwz3AXFTghEH8GGkKOfZ/+70lfCcpiIcoyVTYrip+
 9RiVYNMsoEtQAWZUJKoAPVMHiRyZzgEVsZgJ8JR51I9GISdZ0ZyyKDsfM0WOSLKFCZZG
 mpC8ued5qSMBR2Y89cB7A0Y3uzx3xiY15psOhneLRMgXwxEBvaPOs84LexGbDHwaJwgY
 JG+g==
X-Forwarded-Encrypted: i=1;
 AL+hErH30j5tOpPWXHK7m09dUq0oJjUIN0E/U2FjVTu5SfDavyOMAxNFGZnI7RdHAASjrS6o3jtHYZSlwtqYnYWg@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9SbWNs8jJWyN8UI+AtjjvImlnRW+dsfSicjVVTwVxk3YMgdwEI
 3AX4i51Kc5ZZr/HsJKKGnsVTPIcqXkkydAP+UjVy93GghMNnjZznsHv0FFpMIZkhJ3B830tBLxA
 saVyVy4BEPq2nPY6GfAxkJYyIoyjDJYLmYKVebwcQayvFntS3t/FfZ+87yh5oqw6RuAa4
X-Gm-Gg: AYBFou2XSQjds3Hf7lNFDYfII+aFJKkkjaRa2Y5rmRe0Gwv8yOtKW3wWuyEK+8rhk2/
 4WQ1w6RpmPaOcXgbHT3kJChP91iWhKRLw260zpgJcanygLmUAUUtvNIeo3MP1fdbgSYSJdKiBua
 1peZK0mZ2i1qubXYS4IfVwwe24yz4tdTAhTK0Se1f34sPT1TxRhEDNwKmbq8gVGrX/I5EmngOQ0
 skv9thtMai7BE5pt7sV2s8Sc/b3M9+J4Sm1AC16Iszr3FUbjq1J8OxICevtLCimxjwAL19hdz3/
 JQH2S1OkjyhnC+HwgawUS3bRyCkjnhZw+Rm9MzmWUYjatmuc6bbbvNbrGNGcbpv6eg/biQj9+FI
 mrMamNFKdZ8FO0bbAwyKPYKPEXJ8+15mmSqUXu0Ve12No0GM0P9RtiVt4qG22RKgPclfr1X002G
 hlU0zslVl4arazqyMxueJIhmKCvANcCW/8BxLqn7bObzQc3IIe6RVylbutUCGvqcf0+ltYvIr+E
 Y219VfcjkIqrKpLP1S2SzdcxsN97DPt3Z7gmvGu8UTHESiT3JaQNeYhgNGWnv+gThCaLZmPlHg6
 3Lzx4eke6XNF5sXQEFw3H0XXNKMhxt+Ktxhj8Kn0PC7cobuWx7RCUPE8Hg+yljaWqmZtcqd27EF
 39x5avcxehACWPultszLUvRWXmvlyuVgMjfkfukS55Hk3r0WjHmHkkdZOyzBNJz9kg+TYV6AGsi
 3o5Fad1BgCy3voNxo=
X-Received: by 2002:a05:600c:3e0d:b0:4bb:6f41:39be with SMTP id
 5b1f17b1804b1-4bb6f413bfbmr66995025e9.15.1794820613216; 
 Mon, 16 Nov 2026 01:16:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608d10b2sm35387698f8f.44.2026.11.16.01.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:16:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:16:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
X-Gerrit-Change-Number: 2133
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2133?usp=email>
X-Gerrit-Commit: ec96c65a5d2a9770533dde0d740a66bf282ac1eb
In-Reply-To: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
References: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAyMjczMDAwLkliYTFkYjMyY2QxMzBkMDkyZTM0YTMxMTU5ZjE0ZDNhYTM3ZGI5NmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f7ab188ff9756e047cdfa8d1eec7c03c12ee374-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSspf-000000007F6-3sWL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: use
 multi_io_delete_event() and drop multi_tcp_delete_event()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2510971004319243716=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2510971004319243716==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P4xLkGVZ0P8="; charset=UTF-8

--P4xLkGVZ0P8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2133?usp=3Demail )

Change subject: multi: use multi_io_delete_=
event() and drop multi_tcp_delete_event()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: use multi_io_delete_event() and drop mu=
lti_tcp_delete_event()

cbb0440e ("multiproto: move generic event handling =
code in dedicated
files") added multi_io_delete_event() as a copy of
multi_=
tcp_delete_event() but kept the old function and its only
caller=2E Switch =
management_delete_event() to the new one and remove the
old copy=2E

Change=
-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Acked-by: Gianmarco De Gregori <gianmarco@mandel=
bit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133
Mess=
age-Id: <20261104174306=2E15159-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40713=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/multi=2Ec
3 files changed, 1 =
insertion(+), 12 deletions(-)




diff --git a/src/openvpn/mtcp=2Ec b/src/o=
penvpn/mtcp=2Ec
index fc5b657=2E=2Ed15fc22 100644
--- a/src/openvpn/mtcp=2E=
c
+++ b/src/openvpn/mtcp=2Ec
@@ -104,15 +104,6 @@
 }
 
 void
-multi_tcp_del=
ete_event(struct multi_io *multi_io, event_t event)
-{
-    if (multi_io &&=
 multi_io->es)
-    {
-        event_del(multi_io->es, event);
-    }
-}
-
=
-void
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct mul=
ti_instance *mi)
 {
     const struct link_socket *sock =3D mi->context=2Ec=
2=2Elink_sockets[0];
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=
=2Eh
index 47c6308=2E=2Eb4ec1f9 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src=
/openvpn/mtcp=2Eh
@@ -43,6 +43,4 @@
 
 struct multi_instance *multi_create_=
instance_tcp(struct multi_context *m, struct link_socket *sock);
 
-void mu=
lti_tcp_delete_event(struct multi_io *multi_io, event_t event);
-
 #endif /=
* ifndef MTCP_H */
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index ca650ec=2E=2Ead9f9f4 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -3996,7 +3996,7 @@
     struct multi_context *m =3D =
(struct multi_context *)arg;
     if (m->multi_io)
     {
-        multi_tc=
p_delete_event(m->multi_io, event);
+        multi_io_delete_event(m->multi=
_io, event);
     }
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2133?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
Gerrit-Change-Number: 2133
G=
errit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--P4xLkGVZ0P8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2133?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi: use multi_io_delete_event()=
 and drop multi_tcp_delete_event()<br><br>cbb0440e (&quot;multiproto: move =
generic event handling code in dedicated<br>files&quot;) added multi_io_del=
ete_event() as a copy of<br>multi_tcp_delete_event() but kept the old funct=
ion and its only<br>caller=2E Switch management_delete_event() to the new o=
ne and remove the<br>old copy=2E<br><br>Change-Id: Iba1db32cd130d092e34a311=
59f14d3aa37db96f2<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt;<br>Acked-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133<br>Message-I=
d: &lt;20261104174306=2E15159-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40713=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/mul=
ti=2Ec<br>3 files changed, 1 insertion(+), 12 deletions(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>i=
ndex fc5b657=2E=2Ed15fc22 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec=
</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -104,15 +104=
,6 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_delete_event(struct mu=
lti_io *multi_io, event_t event)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m=
ulti_io &amp;&amp; multi_io-&gt;es)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      event_del(multi_io-&gt;es, event);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span> multi_tcp_derefe=
rence_instance(struct multi_io *multi_io, struct multi_instance *mi)</span>=
<br><span> {</span><br><span>     const struct link_socket *sock =3D mi-&gt=
;context=2Ec2=2Elink_sockets[0];</span><br><span>diff --git a/src/openvpn/m=
tcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index 47c6308=2E=2Eb4ec1f9 1=
00644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/=
openvpn/mtcp=2Eh</span><br><span>@@ -43,6 +43,4 @@</span><br><span> </span>=
<br><span> struct multi_instance *multi_create_instance_tcp(struct multi_co=
ntext *m, struct link_socket *sock);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void multi_tcp_delete_event(struct multi_i=
o *multi_io, event_t event);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> #endif /* ifndef MTCP_H */</span><br><span>diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index c=
a650ec=2E=2Ead9f9f4 100644</span><br><span>--- a/src/openvpn/multi=2Ec</spa=
n><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3996,7 +3996,7 =
@@</span><br><span>     struct multi_context *m =3D (struct multi_context *=
)arg;</span><br><span>     if (m-&gt;multi_io)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_tcp_delete_ev=
ent(m-&gt;multi_io, event);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        multi_io_delete_event(m-&gt;multi_io, event);</span><br><sp=
an>     }</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=3Demail">change 2133</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba1db3=
2cd130d092e34a31159f14d3aa37db96f2 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2133 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--P4xLkGVZ0P8=--


--===============2510971004319243716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2510971004319243716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2510971004319243716==--

