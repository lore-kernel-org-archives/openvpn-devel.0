Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8320606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZOsTCY9W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aYQwPzYe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R4iUJk/0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HrfTnNQR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2IOdXjbDt36DHm3SGFzmni5I180J6fJRZFPIYsCGDBA=; b=ZOsTCY9WOEmRSxls04+Gc3NM/f
	2dP3wJxuC3Di5mXrrvFboZBcXXZywss6uKSMCjkMf7HX9NKuskH8XdSmxZALwBHGKgcZ8u1iqHe6a
	Tt+Sywqv1P2d5yn28TGXX0MPxisqYwAGUyLosJ+ncB8YUoWK8ll7nrUutOZ6DRUPqN4M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOALA-000000001bg-2TZk;
	Tue, 03 Nov 2026 08:58:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOAL8-000000001bH-30pQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LTXT09yGHuW0HS1CHXjBicVSX1el4TdwUoLPzH47SAY=; b=aYQwPzYeaxM2IaC9CQK9kPp++o
 ctfUaFZbq30bddZiJC0kKmTeXkGCwAz1lIDcKLu7I+VAvoR8oJVproA4eZ8J4peua0udrYr55gDEv
 Cugcql5+Pv57nX5oxtNMX+S8Rxjfj/QvDWW4vlWAa1Nd8vRv8xSUAvssnlfyGEa6an/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LTXT09yGHuW0HS1CHXjBicVSX1el4TdwUoLPzH47SAY=; b=R4iUJk/0c9+bhlcJSbiilfix2V
 e/VCT2PuNcTzTQQrTyqUWlyWUmLoyo64kuC3nJtQFDhN2zWA5ZqQPkW77DNGExyQOlIKPrscIEcJ5
 0YL1lH91ELjM400uKJXqdpAH0tw9vEiXdaZsQccBnb5FzwlKrDJlbgguobCnW8q+WDUg=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOAKq-0000000063g-1a6G for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:57:58 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso27197325e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793696254; x=1794301054; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LTXT09yGHuW0HS1CHXjBicVSX1el4TdwUoLPzH47SAY=;
 b=HrfTnNQR8Gus7RcrOvbucPPQqH2/kxtEvFTW9PEtWo3p2IjTWfEtaA0L9vNdoA3Wkp
 4D39a3KswOMMIR78eVpW4wigZrkqv0IdUblUSgatykhTTyIM3NbNMr2l4uq8AhcLK5GJ
 giPFM3mg3MKuF6nf/08u/XdKb2Ve0EARLH96aMkLFclewkH/BBVByrjyI0u47ZGEvLQB
 DRMfLn17Ib2NYy96+WSrEUDHU+rNHRV8FsXOsPOvjSOjPJt9YLxWSyxqYclDLomfQxKO
 cgHfeVkO0nIBhfQb54HeN/QKhGeed0aRaljkW6rJDAcZ/iQcRnMCzgZ+Txzw6a8Dd9gI
 eXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793696254; x=1794301054;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LTXT09yGHuW0HS1CHXjBicVSX1el4TdwUoLPzH47SAY=;
 b=DdmnhVFj3aeAUu3Y18gRytySb1kpR7boBnFT4Oqx+zp+WEoJXBdXgKK2ojpHbbNKf3
 RSys2KOu/tYV+7AAWi+xPOfZQMd0xZFeepaFXW3oJLfXXHeObKLJ3Ij/gL/q/jgAvQ/c
 j+nYER2pNGCiQ02e7N3INvV1svSdkhC5rdOex1fHnFs7k0b+J3O7F9UZNt8xLFI5NVcC
 HZDuR5uksd9GzpFSmiOPLs0Rmf644qShVzubhrFHaG9INFWZn1COR/VCquY/fRMRCpSh
 mKuAhgByKgyUZqImbh8n3pl+2cN8qezm9AsmYedKYjmZdROY38g6Y2NzRtOLEn3ZvLoa
 XWUw==
X-Gm-Message-State: APuU4Z9HYuCQYm5zMG38R2Z7F+vq0t5le56u5iggE1o/4WNXNuAW1Vta
 hf7PH/qSbRqn7oXSwKIWn6i8qiPoGbOzG/7LY/d8bK1RkvJbxjQ7VQmyU757KRN3mMBAGiQsDcd
 cIOTLLSXblwFKSB+QpxChnAolHGhH0TIXz1SWifJuhNN+Tc3KaN571EoPw1qt9N9OduoT1MahZ4
 NjXgTDGg==
X-Gm-Gg: AYBFou3tFWxDJHCxLN+TtX/ISMaJt4acAiOUc8sMxSQGDFz00ALkTJBoXwekEQvvKxK
 2n8ButOmtoEiVJFrFCYgCf/2hS3//Zsd0VRiErGAP5c5JjXJ4tG8ENVkEqoq426c0XIk+NoEOJT
 UYGU/3T48COCpdJgdz9bC/hXI5RXhzTUbSaGXljFjIokCU/mGvU7VBg8aFqehAjKwRD0pUwg3Yp
 H3iPWRw8SfqknFv0AmjRS6h4tCPn0VGPk58s2rpFn3bRnpVhakKVvDJbGlC8qqV0ivl82yzIH+J
 m6zbZyxj7LqiDnWe/U7Nq62V+AvQCMSYar0aaBw0A38OKHlRDw7WjNTgF79iPDqwsFTXqkjiFaK
 NGV62cNwhUcAtouien1cAIRNW/WBd2OW4JOPMIKWjSS49PlEAF15C/wEwR6YKRDucvKAaQ+3LER
 mQb+LlgbBd7CHEIwIOKKAI6p8kYFyz2Pwvun1hxV+Ya1+xvnBIFBLHLT06KkUDBj64r1l70nc/M
 QRUMQtrqgc06xyBYqlbLhcLA9WG47ML9tcuqI5eTteDM9ti/PjxU+SpmgQWpRq47wQwvBw3spSs
 hmitu5DJrEEM6Au7ZGzsphQ4Aw95+xm9uaDq2YqlJYjVqGQkdVUsV0RWhkVQG2HY+CY+QLiydAI
 mkv6/EM8bgosRmyCcvt/sRtajp30+8uR1Ak9O6DnaKiT57M6c2qz1gntrd0CRWoEEwjcndVB+B5
 tg9W+EBn1ozSYaPQ==
X-Received: by 2002:a05:600c:8b6a:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4ac17e10acemr267094465e9.29.1793696253586; 
 Tue, 03 Nov 2026 00:57:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a5372d8bsm47607835e9.0.2026.11.03.00.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:57:33 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:57:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: be5e142bdaa1060f0fe42dc8f882a913d8a4e378
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5e35edb6970443653d253929c74120d477fb6288-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOAKq-0000000063g-1a6G
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6273891081364686208=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6273891081364686208==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yOYBld8huSc="; charset=UTF-8

--yOYBld8huSc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori, R=
=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd lik=
e you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2046?usp=3Demail

to look at the new patch set (#2)=2E

=
The following approvals got outdated and were removed:
Code-Review-1 by R=
=C4=83zvan Cojocaru


Change subject: multi_io: dispatch UDP events through=
 TA_SOCKET_READ/TA_SOCKET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

multi_io: dispatch UDP events through TA_SOCKET_READ/TA=
_SOCKET_WRITE

UDP socket events were handled by multi_process_io_udp() out=
side the
multi_io_action() state machine and re-entered it via TA_INITIAL,
=
running multi_process_post() twice=2E

Dispatch them as TA_SOCKET_READ, wit=
h mi =3D=3D NULL and the socket passed
explicitly, and TA_SOCKET_WRITE, so =
that pending output is flushed
within the same event=2E Drop multi_process_=
io_udp(); multi_io_send_link()
has no caller left outside multi_io=2Ec and =
becomes static=2E

TA_SOCKET_WRITE fell back to the bcast/c2c queue when th=
ere was no
pending instance, and only the queue drain at the end of
multi_i=
o_process_io() relied on that=2E A UDP EVENT_WRITE would now reach
the fall=
back too and write a queued packet, possibly for a TCP instance,
outside th=
e drain=2E Let the drain extract the packets itself with
multi_get_queue(),=
 and make TA_SOCKET_WRITE write only output that is
already prepared: the p=
ending instance's, or else that of mi=2E

Change-Id: Ia7a31ff1c3792104101cb=
2e828be3b7fd8f44156
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbi=
t=2Ecom>
---
M src/openvpn/mudp=2Ec
M src/openvpn/mudp=2Eh
M src/openvpn/mu=
lti=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
5 files chang=
ed, 58 insertions(+), 86 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/46/2046/2

diff --git a/src/openvpn/mudp=
=2Ec b/src/openvpn/mudp=2Ec
index 217b299=2E=2E70ce458 100644
--- a/src/ope=
nvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -29,7 +29,6 @@
 #include "multi=
=2Eh"
 #include <inttypes=2Eh>
 #include "forward=2Eh"
-#include "multi_io=
=2Eh"
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
@@ -462,39 +461,3 @@=

     ASSERT(!(mi && mi->halt));
     return mi;
 }
-
-/*
- * Send a packet=
 to UDP socket=2E
- */
-static inline void
-multi_process_outgoing_link(str=
uct multi_context *m, const unsigned int mpp_flags)
-{
-    if (m->pending)=

-    {
-        multi_io_send_link(m, m->pending, mpp_flags);
-    }
-}
-
=
-/*
- * Process a UDP socket event=2E
- */
-void
-multi_process_io_udp(stru=
ct multi_context *m, struct link_socket *sock, unsigned int rwflags)
-{
-  =
  const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
=
-
-    /* UDP port ready to accept write */
-    if (rwflags & SOCKET_WRITE=
)
-    {
-        multi_process_outgoing_link(m, mpp_flags);
-    }
-    /*=
 Incoming data on UDP port */
-    else if (rwflags & SOCKET_READ)
-    {
-=
        read_incoming_link(&m->top, sock);
-        if (!IS_SIG(&m->top))
-=
        {
-            multi_process_incoming_link(m, NULL, mpp_flags, sock=
);
-        }
-    }
-}
diff --git a/src/openvpn/mudp=2Eh b/src/openvpn/mud=
p=2Eh
index 6567539=2E=2Ec38d9e5 100644
--- a/src/openvpn/mudp=2Eh
+++ b/sr=
c/openvpn/mudp=2Eh
@@ -30,7 +30,6 @@
 struct context;
 struct multi_context=
;
 
-void multi_process_io_udp(struct multi_context *m, struct link_socket =
*sock, unsigned int rwflags);
 /*******************************************=
*******************************/
 /**
  * Get, and if necessary create, the=
 multi_instance associated with a
diff --git a/src/openvpn/multi=2Ec b/src/=
openvpn/multi=2Ec
index 3f82052=2E=2E9cba82e 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4266,7 +4266,7 @@
         }
         =
else if (status =3D=3D 0)
         {
-            multi_io_action(multi, NU=
LL, TA_TIMEOUT, false);
+            multi_io_action(multi, NULL, NULL, TA_=
TIMEOUT, false);
         }
 
         MULTI_CHECK_SIG(multi);
diff --git a=
/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index fb4810b=2E=2E20f=
a56c 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@=
@ -325,27 +325,24 @@
 }
 
 /*
- * Determine which instance has pending outp=
ut
- * and prepare the output for sending in
- * the to_link buffer=2E
+ * =
Determine which instance has output for the
+ * link: the pending instance,=
 or else mi itself=2E
  */
 static struct multi_instance *
-multi_io_write_=
link_pre(struct multi_context *m)
+multi_io_write_link_pre(struct multi_con=
text *m, struct multi_instance *mi)
 {
-    struct multi_instance *mi =3D N=
ULL;
-
     if (m->pending)
     {
-        mi =3D m->pending;
+        ret=
urn m->pending;
     }
-    else if (mbuf_defined(m->mbuf))
+    if (mi && =
LINK_OUT(&mi->context))
     {
-        mi =3D multi_get_queue(m->mbuf);
+ =
       return mi;
     }
-    return mi;
+    return NULL;
 }
 
-bool
+stat=
ic bool
 multi_io_send_link(struct multi_context *m, struct multi_instance =
*mi, const unsigned int mpp_flags)
 {
     bool ret =3D true;
@@ -378,11 +3=
75,12 @@
 }
 
 static bool
-multi_io_write_link(struct multi_context *m, bo=
ol defer, const unsigned int mpp_flags)
+multi_io_write_link(struct multi_c=
ontext *m, struct multi_instance *mi, bool defer,
+                    cons=
t unsigned int mpp_flags)
 {
-    struct multi_instance *mi =3D multi_io_wr=
ite_link_pre(m);
     bool ret =3D true;
 
+    mi =3D multi_io_write_link_=
pre(m, mi);
     if (mi)
     {
         if ((defer && !proto_is_dgram(mi->=
context=2Ec2=2Elink_sockets[0]->info=2Eproto))
@@ -423,7 +421,8 @@
 }
 
 st=
atic struct multi_instance *
-multi_io_dispatch(struct multi_context *m, st=
ruct multi_instance *mi, const int action)
+multi_io_dispatch(struct multi_=
context *m, struct multi_instance *mi, struct link_socket *sock,
+         =
         const int action)
 {
     const unsigned int mpp_flags =3D MPP_PRE=
_SELECT | MPP_RECORD_TOUCH;
     struct multi_instance *touched =3D mi;
@@ =
-445,21 +444,28 @@
 
         case TA_SOCKET_READ:
         case TA_SOCKET_=
READ_RESIDUAL:
-            ASSERT(mi);
-            ASSERT(mi->context=2Ec=
2=2Elink_sockets);
-            ASSERT(mi->context=2Ec2=2Elink_sockets[0]);=

-            set_prefix(mi);
-            read_incoming_link(&mi->context,=
 mi->context=2Ec2=2Elink_sockets[0]);
-            clear_prefix();
-       =
     if (!IS_SIG(&mi->context))
+        {
+            struct context *c =
=3D multi_get_context(m, mi);
+
+            if (mi)
             {
-      =
          multi_process_incoming_link(m, mi, mpp_flags, mi->context=2Ec2=2E=
link_sockets[0]);
-                if (!IS_SIG(&mi->context))
+            =
    ASSERT(mi->context=2Ec2=2Elink_sockets);
+                sock =3D mi->=
context=2Ec2=2Elink_sockets[0];
+                set_prefix(mi);
+         =
   }
+            ASSERT(sock);
+            read_incoming_link(c, sock);
+=
            clear_prefix();
+            if (!IS_SIG(c))
+            {
+  =
              multi_process_incoming_link(m, mi, mpp_flags, sock);
+       =
         if (!IS_SIG(c))
                 {
-                    stream_buf=
_read_setup(mi->context=2Ec2=2Elink_sockets[0]);
+                    strea=
m_buf_read_setup(sock);
                 }
             }
             brea=
k;
+        }
 
         case TA_TIMEOUT:
             multi_process_timeou=
t(m, mpp_flags);
@@ -479,11 +485,11 @@
             break;
 
         case =
TA_SOCKET_WRITE:
-            multi_io_write_link(m, false, mpp_flags);
+  =
          multi_io_write_link(m, mi, false, mpp_flags);
             break;=

 
         case TA_SOCKET_WRITE_DEFERRED:
-            multi_io_write_link=
(m, true, mpp_flags);
+            multi_io_write_link(m, mi, true, mpp_fla=
gs);
             break;
 
         case TA_INITIAL:
@@ -586,11 +592,11 @@
=
                     mi =3D ev_arg->u=2Emi;
                     if (e->rwf=
lags & EVENT_WRITE)
                     {
-                        multi_i=
o_action(m, mi, TA_SOCKET_WRITE_READY, false);
+                        mul=
ti_io_action(m, mi, NULL, TA_SOCKET_WRITE_READY, false);
                  =
   }
                     else if (e->rwflags & EVENT_READ)
               =
      {
-                        multi_io_action(m, mi, TA_SOCKET_READ, fal=
se);
+                        multi_io_action(m, mi, NULL, TA_SOCKET_READ, =
false);
                     }
                     break;
 
@@ -605,18 +61=
1,21 @@
                     {
                         socket_reset_listen=
_persistent(ev_arg->u=2Esock);
                         mi =3D multi_create=
_instance_tcp(m, ev_arg->u=2Esock);
+                        /* monitor and=
/or handle events that are
+                         * triggered in success=
ion by the first one
+                         * before returning to the ma=
in loop=2E */
+                        if (mi)
+                        {
+=
                            multi_io_action(m, mi, NULL, TA_INITIAL, false)=
;
+                        }
                     }
-                    el=
se
+                    else if (e->rwflags & EVENT_WRITE)
                =
     {
-                        multi_process_io_udp(m, ev_arg->u=2Esock, e=
->rwflags);
-                        mi =3D m->pending;
+                  =
      multi_io_action(m, NULL, NULL, TA_SOCKET_WRITE, false);
             =
        }
-                    /* monitor and/or handle events that are
-  =
                   * triggered in succession by the first one
-            =
         * before returning to the main loop=2E */
-                    if =
(mi)
+                    else if (e->rwflags & EVENT_READ)
               =
      {
-                        multi_io_action(m, mi, TA_INITIAL, false);=

+                        multi_io_action(m, NULL, ev_arg->u=2Esock, TA_SOC=
KET_READ, false);
                     }
                     break;
      =
       }
@@ -636,11 +645,11 @@
                 {
                     if (=
e->rwflags & EVENT_WRITE)
                     {
-                        m=
ulti_io_action(m, NULL, TA_TUN_WRITE, false);
+                        mult=
i_io_action(m, NULL, NULL, TA_TUN_WRITE, false);
                     }
   =
                  else if (e->rwflags & EVENT_READ)
                     {
=
-                        multi_io_action(m, NULL, TA_TUN_READ, false);
+   =
                     multi_io_action(m, NULL, NULL, TA_TUN_READ, false);
  =
                   }
                 }
 
@@ -671,19 +680,22 @@
     multi_=
io->n_esr =3D 0;
 
     /*
-     * Drain the queued mbuf packets, datagram =
and TCP instances alike
+     * Drain the queued mbuf packets, datagram and=
 TCP instances alike:
+     * multi_get_queue() prepares each one in the to=
_link buffer of its
+     * instance=2E
      */
     {
         struct mul=
ti_instance *mi;
-        while (!IS_SIG(&m->top) && (mi =3D mbuf_peek(m->m=
buf)) !=3D NULL)
+        while (!IS_SIG(&m->top) && (mi =3D multi_get_queu=
e(m->mbuf)) !=3D NULL)
         {
-            multi_io_action(m, mi, TA_SO=
CKET_WRITE, true);
+            multi_io_action(m, mi, NULL, TA_SOCKET_WRIT=
E, true);
         }
     }
 }
 
 void
-multi_io_action(struct multi_contex=
t *m, struct multi_instance *mi, int action, bool poll)
+multi_io_action(st=
ruct multi_context *m, struct multi_instance *mi, struct link_socket *sock,=

+                int action, bool poll)
 {
     bool tun_input_pending =3D=
 false;
 
@@ -716,7 +728,7 @@
         /*
          * Dispatch the action
 =
         */
-        struct multi_instance *touched =3D multi_io_dispatch(m=
, mi, action);
+        struct multi_instance *touched =3D multi_io_dispatc=
h(m, mi, sock, action);
 
         /*
          * Signal received or connec=
tion
diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index=
 c7f8f89=2E=2E7ae25c6 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openv=
pn/multi_io=2Eh
@@ -68,11 +68,9 @@
 
 void multi_io_process_io(struct multi=
_context *m);
 
-void multi_io_action(struct multi_context *m, struct multi=
_instance *mi, int action, bool poll);
+void multi_io_action(struct multi_c=
ontext *m, struct multi_instance *mi, struct link_socket *sock,
+          =
           int action, bool poll);
 
 void multi_io_delete_event(struct mul=
ti_io *multi_io, event_t event);
 
-bool multi_io_send_link(struct multi_co=
ntext *m, struct multi_instance *mi,
-                        const unsigne=
d int mpp_flags);
-
 #endif /* ifndef MULTI_IO_H */

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44=
156
Gerrit-Change-Number: 2046
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco D=
e Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarc=
o De Gregori <gianmarco@mandelbit=2Ecom>

--yOYBld8huSc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori, R=C4=83zvan Cojoc=
aru=2E </p>
<p>Gianmarco De Gregori <strong>uploaded patch set #2</strong> =
to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2046?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE<br=
><br>UDP socket events were handled by multi_process_io_udp() outside the<b=
r>multi_io_action() state machine and re-entered it via TA_INITIAL,<br>runn=
ing multi_process_post() twice=2E<br><br>Dispatch them as TA_SOCKET_READ, w=
ith mi =3D=3D NULL and the socket passed<br>explicitly, and TA_SOCKET_WRITE=
, so that pending output is flushed<br>within the same event=2E Drop multi_=
process_io_udp(); multi_io_send_link()<br>has no caller left outside multi_=
io=2Ec and becomes static=2E<br><br>TA_SOCKET_WRITE fell back to the bcast/=
c2c queue when there was no<br>pending instance, and only the queue drain a=
t the end of<br>multi_io_process_io() relied on that=2E A UDP EVENT_WRITE w=
ould now reach<br>the fallback too and write a queued packet, possibly for =
a TCP instance,<br>outside the drain=2E Let the drain extract the packets i=
tself with<br>multi_get_queue(), and make TA_SOCKET_WRITE write only output=
 that is<br>already prepared: the pending instance&#39;s, or else that of m=
i=2E<br><br>Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156<br>Signed-=
off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M =
src/openvpn/mudp=2Ec<br>M src/openvpn/mudp=2Eh<br>M src/openvpn/multi=2Ec<b=
r>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>5 files chang=
ed, 58 insertions(+), 86 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/2046/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>inde=
x 217b299=2E=2E70ce458 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</s=
pan><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -29,7 +29,6 @@<=
/span><br><span> #include &quot;multi=2Eh&quot;</span><br><span> #include &=
lt;inttypes=2Eh&gt;</span><br><span> #include &quot;forward=2Eh&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;multi_io=2Eh=
&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</=
span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span>@@ -462,39=
 +461,3 @@</span><br><span>     ASSERT(!(mi &amp;&amp; mi-&gt;halt));</span=
><br><span>     return mi;</span><br><span> }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Send a packet=
 to UDP socket=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_outgoing_li=
nk(struct multi_context *m, const unsigned int mpp_flags)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (m-&gt;pending)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        multi_io_send_link(m, m-&gt;pending, mpp_flags);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Process a UDP socket event=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-multi_process_io_udp(struct multi_context *m, struct link_socket=
 *sock, unsigned int rwflags)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const un=
signed int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* UDP port ready to accept write */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (rwflags &amp; SOCKET_WRITE=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        multi_process_outgoing_link(=
m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Incoming data on=
 UDP port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else =
if (rwflags &amp; SOCKET_READ)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 read_incoming_link(&amp;m-&gt;top, sock);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            multi_process_incoming_link(m, NULL, mp=
p_flags, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src=
/openvpn/mudp=2Eh b/src/openvpn/mudp=2Eh</span><br><span>index 6567539=2E=
=2Ec38d9e5 100644</span><br><span>--- a/src/openvpn/mudp=2Eh</span><br><spa=
n>+++ b/src/openvpn/mudp=2Eh</span><br><span>@@ -30,7 +30,6 @@</span><br><s=
pan> struct context;</span><br><span> struct multi_context;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_process_=
io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwfl=
ags);</span><br><span> /***************************************************=
***********************/</span><br><span> /**</span><br><span>  * Get, and =
if necessary create, the multi_instance associated with a</span><br><span>d=
iff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>i=
ndex 3f82052=2E=2E9cba82e 100644</span><br><span>--- a/src/openvpn/multi=2E=
c</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4266,7 +4=
266,7 @@</span><br><span>         }</span><br><span>         else if (statu=
s =3D=3D 0)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            multi_io_action(multi, NULL, TA_TIMEOUT, false=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi=
_io_action(multi, NULL, NULL, TA_TIMEOUT, false);</span><br><span>         =
}</span><br><span> </span><br><span>         MULTI_CHECK_SIG(multi);</span>=
<br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec<=
/span><br><span>index fb4810b=2E=2E20fa56c 100644</span><br><span>--- a/src=
/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span>=
<br><span>@@ -325,27 +325,24 @@</span><br><span> }</span><br><span> </span>=
<br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Deter=
mine which instance has pending output</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * and prepare the output for sending in</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * the to_link buffer=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Determine which instance has ou=
tput for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * link=
: the pending instance, or else mi itself=2E</span><br><span>  */</span><br=
><span> static struct multi_instance *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_io_write_link_pre(struct multi_context *m)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_write_link_pre(struc=
t multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>     if (m-&gt;pending)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        mi =3D m-&gt;pending;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return m-&gt;pending;</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  else if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (mi &amp;&amp; LINK_OUT(&amp;mi-&gt;context))</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    mi =3D multi_get_queue(m-&gt;mbuf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return mi;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return mi;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><=
span> multi_io_send_link(struct multi_context *m, struct multi_instance *mi=
, const unsigned int mpp_flags)</span><br><span> {</span><br><span>     boo=
l ret =3D true;</span><br><span>@@ -378,11 +375,12 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-multi_io_write_link(struct multi_context *m, bool de=
fer, const unsigned int mpp_flags)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_io_write_link(struct multi_context *m, struct multi_in=
stance *mi, bool defer,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    const unsigned int mpp_flags)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instanc=
e *mi =3D multi_io_write_link_pre(m);</span><br><span>     bool ret =3D tru=
e;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mi =3D multi_io_write_link_pre(m, mi);</span><br><span>     if (mi)</s=
pan><br><span>     {</span><br><span>         if ((defer &amp;&amp; !proto_=
is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br=
><span>@@ -423,7 +421,8 @@</span><br><span> }</span><br><span> </span><br><=
span> static struct multi_instance *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_io_dispatch(struct multi_context *m, struct multi_inst=
ance *mi, const int action)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_io_dispatch(struct multi_context *m, struct multi_instance *m=
i, struct link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                  const int action)</span><br><span> {</span><br><=
span>     const unsigned int mpp_flags =3D MPP_PRE_SELECT | MPP_RECORD_TOUC=
H;</span><br><span>     struct multi_instance *touched =3D mi;</span><br><s=
pan>@@ -445,21 +444,28 @@</span><br><span> </span><br><span>         case T=
A_SOCKET_READ:</span><br><span>         case TA_SOCKET_READ_RESIDUAL:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt=
;context=2Ec2=2Elink_sockets);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            ASSERT(mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            set_prefix(mi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            read_incomi=
ng_link(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            clear_prefix();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!IS_SI=
G(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      struct context *c =3D multi_get_context(m, mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (mi)</span><br><span>             {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                multi_process_i=
ncoming_link(m, mi, mpp_flags, mi-&gt;context=2Ec2=2Elink_sockets[0]);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!IS_SI=
G(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                ASSERT(mi-&gt;context=2Ec2=2Elink_sockets);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                sock =3D mi-&gt=
;context=2Ec2=2Elink_sockets[0];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                set_prefix(mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            ASSERT(sock);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            read_incoming_link(c, sock);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            clear_prefix();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!IS_S=
IG(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mul=
ti_process_incoming_link(m, mi, mpp_flags, sock);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                if (!IS_SIG(c))</span><br><sp=
an>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    stream_buf_read_setup(mi-&gt;context=2Ec2=2Elink_socket=
s[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       stream_buf_read_setup(sock);</span><br><span>                 }</spa=
n><br><span>             }</span><br><span>             break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </spa=
n><br><span>         case TA_TIMEOUT:</span><br><span>             multi_pr=
ocess_timeout(m, mpp_flags);</span><br><span>@@ -479,11 +485,11 @@</span><b=
r><span>             break;</span><br><span> </span><br><span>         case=
 TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        multi_io_write_link(m, false, mpp_flags);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            multi_io_write_link(m, mi, false,=
 mpp_flags);</span><br><span>             break;</span><br><span> </span><b=
r><span>         case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            multi_io_write_link(m, true, mpp_flag=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mult=
i_io_write_link(m, mi, true, mpp_flags);</span><br><span>             break=
;</span><br><span> </span><br><span>         case TA_INITIAL:</span><br><sp=
an>@@ -586,11 +592,11 @@</span><br><span>                     mi =3D ev_arg=
-&gt;u=2Emi;</span><br><span>                     if (e-&gt;rwflags &amp; E=
VENT_WRITE)</span><br><span>                     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        multi_io_action(m, mi,=
 TA_SOCKET_WRITE_READY, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        multi_io_action(m, mi, NULL, TA_SOCKET_=
WRITE_READY, false);</span><br><span>                     }</span><br><span=
>                     else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><s=
pan>                     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        multi_io_action(m, mi, TA_SOCKET_READ, false);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     multi_io_action(m, mi, NULL, TA_SOCKET_READ, false);</span><br><span> =
                    }</span><br><span>                     break;</span><br=
><span> </span><br><span>@@ -605,18 +611,21 @@</span><br><span>            =
         {</span><br><span>                         socket_reset_listen_per=
sistent(ev_arg-&gt;u=2Esock);</span><br><span>                         mi =
=3D multi_create_instance_tcp(m, ev_arg-&gt;u=2Esock);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        /* monitor and/o=
r handle events that are</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                         * triggered in succession by the first one</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
   * before returning to the main loop=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        if (mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            mult=
i_io_action(m, mi, NULL, TA_INITIAL, false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        }</span><br><span>        =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  else if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span=
>                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        multi_process_io_udp(m, ev_arg-&gt;u=2Esock, e-&g=
t;rwflags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        multi_io_action(m, NULL, NULL, TA_S=
OCKET_WRITE, false);</span><br><span>                     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    /* monitor and/or=
 handle events that are</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                     * triggered in succession by the first one</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                     * before r=
eturning to the main loop=2E */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    if (mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    else if (e-&gt;rwflags &amp; EVENT_RE=
AD)</span><br><span>                     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        multi_io_action(m, mi, TA_INIT=
IAL, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 multi_io_action(m, NULL, ev_arg-&gt;u=2Esock, TA_SOCKET_RE=
AD, false);</span><br><span>                     }</span><br><span>        =
             break;</span><br><span>             }</span><br><span>@@ -636,=
11 +645,11 @@</span><br><span>                 {</span><br><span>          =
           if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span>           =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              multi_io_action(m, NULL, TA_TUN_WRITE, false);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        multi_io_a=
ction(m, NULL, NULL, TA_TUN_WRITE, false);</span><br><span>                =
     }</span><br><span>                     else if (e-&gt;rwflags &amp; EV=
ENT_READ)</span><br><span>                     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        multi_io_action(m, NULL,=
 TA_TUN_READ, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        multi_io_action(m, NULL, NULL, TA_TUN_READ, false=
);</span><br><span>                     }</span><br><span>                 =
}</span><br><span> </span><br><span>@@ -671,19 +680,22 @@</span><br><span> =
    multi_io-&gt;n_esr =3D 0;</span><br><span> </span><br><span>     /*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Drain the queued m=
buf packets, datagram and TCP instances alike</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * Drain the queued mbuf packets, datagram an=
d TCP instances alike:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * multi_get_queue() prepares each one in the to_link buffer of its<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * instance=2E</=
span><br><span>      */</span><br><span>     {</span><br><span>         str=
uct multi_instance *mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D mbuf_peek(m-&gt=
;mbuf)) !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D multi_get_queue(m-=
&gt;mbuf)) !=3D NULL)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            multi_io_action(m, mi, TA_SOCKET_WRI=
TE, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   multi_io_action(m, mi, NULL, TA_SOCKET_WRITE, true);</span><br><span>   =
      }</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_i=
o_action(struct multi_context *m, struct multi_instance *mi, int action, bo=
ol poll)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_ac=
tion(struct multi_context *m, struct multi_instance *mi, struct link_socket=
 *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    int action, bool poll)</span><br><span> {</span><br><span>     bool tun=
_input_pending =3D false;</span><br><span> </span><br><span>@@ -716,7 +728,=
7 @@</span><br><span>         /*</span><br><span>          * Dispatch the a=
ction</span><br><span>          */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct multi_instance *touched =3D multi_io_dispatch(m=
, mi, action);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   struct multi_instance *touched =3D multi_io_dispatch(m, mi, sock, action=
);</span><br><span> </span><br><span>         /*</span><br><span>          =
* Signal received or connection</span><br><span>diff --git a/src/openvpn/mu=
lti_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index c7f8f89=2E=2E7a=
e25c6 100644</span><br><span>--- a/src/openvpn/multi_io=2Eh</span><br><span=
>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -68,11 +68,9 @@</span><b=
r><span> </span><br><span> void multi_io_process_io(struct multi_context *m=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid multi_io_action(struct multi_context *m, struct multi_instance *mi, int=
 action, bool poll);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void multi_io_action(struct multi_context *m, struct multi_instance *mi, s=
truct link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                     int action, bool poll);</span><br><span> </span><=
br><span> void multi_io_delete_event(struct multi_io *multi_io, event_t eve=
nt);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-bool multi_io_send_link(struct multi_context *m, struct multi_instance *mi=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    const unsigned int mpp_flags);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> #endif /* ifndef MULTI_IO_H */</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2046?usp=3Demail">change 2046</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2046?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newp=
atchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2046 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt; </div>

</body></html>
--yOYBld8huSc=--


--===============6273891081364686208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6273891081364686208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6273891081364686208==--

