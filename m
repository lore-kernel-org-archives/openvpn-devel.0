Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F3606C566
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VkkymDVY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z4gKP7Td;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FHpfCnAT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EJzUsfj8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y+jro0Q9CTRDPkEM1ek4VhhGP8P7p0GmV257wLdvJus=; b=VkkymDVYQUNE6pM2QfWWZHvzgX
	7IBD1ZShATWbK10lCeE6cL3bHdjuoxiEC1Vp+KikY/nI2nahPWN0PsZ3RxMY7ggeABR5k6l7DtTux
	ghI6QIXQa/cIdAuwdpPttbEYXi5C4SlgezQj/zOsrK9GlQqgfPGC9WlRs5kX0mMkbINU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCK0-000000002mz-31f9;
	Tue, 03 Nov 2026 11:04:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCJy-000000002mi-2CML
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v9BzhUHcrCVjpNV9sC/1MIGcem1BdjRFztbUWrH1ELI=; b=Z4gKP7TdNvqZj+8nKBL8NuHgHB
 6fGDfeQBRKqOe5AXqtx7dEznhBTal/tcJ/+axotE8ylK4gfoaqk82KfbcORWVEcxtVKbqN9Bahr8F
 /Rxg1x33CIrA9IfhapoUBUyY3itH5A6l42yH4gQzyKL9pjSk3mtLuNQ2EA48NwDliXY4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v9BzhUHcrCVjpNV9sC/1MIGcem1BdjRFztbUWrH1ELI=; b=FHpfCnATI/EH6F6UBWvk+VDZf3
 fmCE6d36FVOGc4sOnd3j47TeJG4qBYLaqifUkslYODOAUsA/+a5rYY76auakYQd1J8PFvevYPPr8d
 95Z7saeM9Uh0KP1/b2lgl/PPwE3Aam57S8haPOb1LAcT9T9nKY7WxRO19kRJKZ4kVkAY=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCJu-000000001gX-22sQ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:04:54 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so27004575e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793703884; x=1794308684; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v9BzhUHcrCVjpNV9sC/1MIGcem1BdjRFztbUWrH1ELI=;
 b=EJzUsfj8ekNvhdg6cGvGcHyRGYXyQUeSenUx8Ma3vja9B8hGUuU5T+P1Vc6PRTrnbm
 v7k6oJ/coiqSLkPdIx0pxoPWzIbE1EWfld5WOPkLBoEMk9Anu+/eM1aNzBEN2FZTbGji
 5VjppDntqwBCmivZbVSJs3bsidhOvWXsGr239aevVl7KieTGD4c9X3qEsBkqHkgM3O70
 FZPb9sapmsGh6tegKwXqmybzCdcP0MzJ7QWqLjlltsW4jdg236Er15+3z25VxRvplHuA
 sEBkgH6qgTXbENIvjpX+lmNf+XzAt0yio8YmXw0HvGT1BtnuLDwoLdM5ILc8NJz8+Ier
 fiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703884; x=1794308684;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v9BzhUHcrCVjpNV9sC/1MIGcem1BdjRFztbUWrH1ELI=;
 b=TSP9u0aZ/GLOaEIjKKYHjjh8Afb2xtqHmU6xcWZ/8gywgdkJfB4GfQYj8ZhDRIq74D
 iqEt1KLIIb68mChmlmt5orCqufF020ExbMRehX8Zc8Y9KdxMf8YINinNgGKUOBumV9tq
 7sHDeoGG2m/JKiN2khdW+CvE26NwDVN6LZzQypk56wMHr7zFH6Tc1PXA2o0OusU+cty9
 /sQOmwBgWdsBfyfXUOGsvdsT3WMdRYsyvE8zsMmUsAPKgnbChsCvOtujc/j3wdNLxGqA
 pKXKPEtexDJ0ZmzpyNaFnYu2v7cYn5uDIRn/Mz9aPbObISCsyrzbIL/FYSC/cMzsbSJV
 ICqQ==
X-Gm-Message-State: APuU4Z9WB4GvT/ucAlVCwp9mD3MZ9a8lQZpR/o6qdSfjVDO3AUYfA3RL
 vWPl4YJUweDInSbW3ASzbOIrvKPwzr/HDUEqO+i6acmutkPRUuWxw1/15TScvk0bLppW9/rCTN1
 YTR2nmdbDT9QsN4P4stN/sPVfi0RRbNo9+Gj5XCZi4ixYbo7X0vp7M9i7xVm8de+Mmv0E
X-Gm-Gg: AYBFou3LwqbdIIMIwA2dRDJM/O31NfYgkiqLLUGbBv3RBYSi4r9Ho4glS/bIYfcVCYn
 m8hTqQ02llqNymlifS6RHbPIna6QYPKogGtv90x6u6Fl51zDmHW/rs2ZkxehZ9CU3UOW+UsVLpt
 LfGNiqnpksNKOiFm0gXOtLx5WSJnq870eiHYVdN13Pv9VrwQl2wsM1eH4fMBAU0F8HI0OMAC8S9
 nzDhIos2w8M9gTQa2Zrr7ouY8qs4b0TyQu6JMGZOM+PFV4pp01rMwZRQ4F6QLYvSD7jqTGdCQw3
 wp6k02+hJcgQqLsYBqDjhHPAhRTLaWfsPc/dWhOs+scUx4ODlpg3NGQHtTuB1XSe+m3Uug5CgfS
 K+aWqGicAaHChOq/6oD4FrDQzj0X2KheEeVojd565LtrjGfm6ppBjhUDlbgBAT7bwHlAXYe7fP7
 NPi5koOJHffmAWptsJuspnnOymU8czzFiXBGc2NOSdPMqFVwPBplT8mSZQ3KCVvufiYYDs9bJeV
 p79FHrCqq49tdCpCevfsBmv6vHyRIz3S1USizvIkFAveiZ98PbaXjAv0GSRUZlQB0/V2+yg3Wse
 MH/R5SlTOUSaV16AsLlt/8OlIxhLMLHBjddJTjnYsM39jop+dqo8L4M1I6oKbPOC5nPtNH9cpWx
 BjiX4WHJEfGb2eMpxAzk1NZE1qMbCcFDk25sRYOlHr4N4Ah0RGqze2bRkaJdLBS67Bkrkv+Zw0t
 Lp9bTn2AyCGreWhqSJVejiXYel9Aq02Hn18Mc=
X-Received: by 2002:a05:600c:c4b8:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4ac150b38dbmr299524235e9.1.1793703883645; 
 Tue, 03 Nov 2026 03:04:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm24082322f8f.57.2026.11.03.03.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:04:43 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:04:40 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: 2c83d9e5d30c38ea1aa872ddb2a7d78de2920b95
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8fa5696b81086dc39bd3710181d6934ec2c4a8c4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCJu-000000001gX-22sQ
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
Content-Type: multipart/mixed; boundary="===============1962447426120890061=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1962447426120890061==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kaE+Q5tdKR4="; charset=UTF-8

--kaE+Q5tdKR4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori, R=
=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd lik=
e you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2046?usp=3Demail

to look at the new patch set (#3)=2E

=
The following approvals got outdated and were removed:
Code-Review+2 by R=
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
ed, 59 insertions(+), 87 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/46/2046/3

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
index b1a648b=2E=2Ec41905b 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -2869,7 +2869,7 @@
             if (mi)=

             {
                 /* continue authentication, perform NCP ne=
gotiation and send push_reply */
-                multi_io_action(m, mi, TA=
_INSTANCE_POST, false);
+                multi_io_action(m, mi, NULL, TA_IN=
STANCE_POST, false);
             }
             else
             {
@@ -42=
66,7 +4266,7 @@
         }
         else if (status =3D=3D 0)
         {
- =
           multi_io_action(multi, NULL, TA_TIMEOUT, false);
+            mu=
lti_io_action(multi, NULL, NULL, TA_TIMEOUT, false);
         }
 
         =
MULTI_CHECK_SIG(multi);
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn=
/multi_io=2Ec
index a6e97af=2E=2E83233d2 100644
--- a/src/openvpn/multi_io=
=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -328,27 +328,24 @@
 }
 
 /*
- * Dete=
rmine which instance has pending output
- * and prepare the output for send=
ing in
- * the to_link buffer=2E
+ * Determine which instance has output fo=
r the
+ * link: the pending instance, or else mi itself=2E
  */
 static str=
uct multi_instance *
-multi_io_write_link_pre(struct multi_context *m)
+mul=
ti_io_write_link_pre(struct multi_context *m, struct multi_instance *mi)
 {=

-    struct multi_instance *mi =3D NULL;
-
     if (m->pending)
     {
-  =
      mi =3D m->pending;
+        return m->pending;
     }
-    else if (m=
buf_defined(m->mbuf))
+    if (mi && LINK_OUT(&mi->context))
     {
-      =
  mi =3D multi_get_queue(m->mbuf);
+        return mi;
     }
-    return m=
i;
+    return NULL;
 }
 
-bool
+static bool
 multi_io_send_link(struct mul=
ti_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
=
     bool ret =3D true;
@@ -381,11 +378,12 @@
 }
 
 static bool
-multi_io_w=
rite_link(struct multi_context *m, bool defer, const unsigned int mpp_flags=
)
+multi_io_write_link(struct multi_context *m, struct multi_instance *mi, =
bool defer,
+                    const unsigned int mpp_flags)
 {
-    stru=
ct multi_instance *mi =3D multi_io_write_link_pre(m);
     bool ret =3D tru=
e;
 
+    mi =3D multi_io_write_link_pre(m, mi);
     if (mi)
     {
      =
   if ((defer && !proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->info=
=2Eproto))
@@ -426,7 +424,8 @@
 }
 
 static struct multi_instance *
-multi_=
io_dispatch(struct multi_context *m, struct multi_instance *mi, const int a=
ction)
+multi_io_dispatch(struct multi_context *m, struct multi_instance *m=
i, struct link_socket *sock,
+                  const int action)
 {
     c=
onst unsigned int mpp_flags =3D MPP_PRE_SELECT | MPP_RECORD_TOUCH;
     str=
uct multi_instance *touched =3D mi;
@@ -448,21 +447,28 @@
 
         case T=
A_SOCKET_READ:
         case TA_SOCKET_READ_RESIDUAL:
-            ASSERT(m=
i);
-            ASSERT(mi->context=2Ec2=2Elink_sockets);
-            ASSE=
RT(mi->context=2Ec2=2Elink_sockets[0]);
-            set_prefix(mi);
-     =
       read_incoming_link(&mi->context, mi->context=2Ec2=2Elink_sockets[0])=
;
-            clear_prefix();
-            if (!IS_SIG(&mi->context))
+   =
     {
+            struct context *c =3D multi_get_context(m, mi);
+
+    =
        if (mi)
             {
-                multi_process_incoming_link=
(m, mi, mpp_flags, mi->context=2Ec2=2Elink_sockets[0]);
-                if=
 (!IS_SIG(&mi->context))
+                ASSERT(mi->context=2Ec2=2Elink_so=
ckets);
+                sock =3D mi->context=2Ec2=2Elink_sockets[0];
+    =
            set_prefix(mi);
+            }
+            ASSERT(sock);
+    =
        read_incoming_link(c, sock);
+            clear_prefix();
+        =
    if (!IS_SIG(c))
+            {
+                multi_process_incoming_=
link(m, mi, mpp_flags, sock);
+                if (!IS_SIG(c))
            =
     {
-                    stream_buf_read_setup(mi->context=2Ec2=2Elink_s=
ockets[0]);
+                    stream_buf_read_setup(sock);
             =
    }
             }
             break;
+        }
 
         case TA_TIME=
OUT:
             multi_process_timeout(m, mpp_flags);
@@ -482,11 +488,11 @=
@
             break;
 
         case TA_SOCKET_WRITE:
-            multi_i=
o_write_link(m, false, mpp_flags);
+            multi_io_write_link(m, mi, =
false, mpp_flags);
             break;
 
         case TA_SOCKET_WRITE_DEFE=
RRED:
-            multi_io_write_link(m, true, mpp_flags);
+            mu=
lti_io_write_link(m, mi, true, mpp_flags);
             break;
 
         c=
ase TA_INITIAL:
@@ -594,11 +600,11 @@
                     mi =3D ev_arg->u=
=2Emi;
                     if (e->rwflags & EVENT_WRITE)
                 =
    {
-                        multi_io_action(m, mi, TA_SOCKET_WRITE_READY=
, false);
+                        multi_io_action(m, mi, NULL, TA_SOCKET_W=
RITE_READY, false);
                     }
                     else if (e-=
>rwflags & EVENT_READ)
                     {
-                        mult=
i_io_action(m, mi, TA_SOCKET_READ, false);
+                        multi_i=
o_action(m, mi, NULL, TA_SOCKET_READ, false);
                     }
      =
               break;
 
@@ -613,18 +619,21 @@
                     {
      =
                   socket_reset_listen_persistent(ev_arg->u=2Esock);
      =
                   mi =3D multi_create_instance_tcp(m, ev_arg->u=2Esock);
+=
                        /* monitor and/or handle events that are
+         =
                * triggered in succession by the first one
+               =
          * before returning to the main loop=2E */
+                      =
  if (mi)
+                        {
+                            multi_io_=
action(m, mi, NULL, TA_INITIAL, false);
+                        }
        =
             }
-                    else
+                    else if (e->r=
wflags & EVENT_WRITE)
                     {
-                        multi=
_process_io_udp(m, ev_arg->u=2Esock, e->rwflags);
-                        =
mi =3D m->pending;
+                        multi_io_action(m, NULL, NULL, =
TA_SOCKET_WRITE, false);
                     }
-                    /* mon=
itor and/or handle events that are
-                     * triggered in suc=
cession by the first one
-                     * before returning to the ma=
in loop=2E */
-                    if (mi)
+                    else if (e-=
>rwflags & EVENT_READ)
                     {
-                        mult=
i_io_action(m, mi, TA_INITIAL, false);
+                        multi_io_ac=
tion(m, NULL, ev_arg->u=2Esock, TA_SOCKET_READ, false);
                   =
  }
                     break;
             }
@@ -644,11 +653,11 @@
      =
           {
                     if (e->rwflags & EVENT_WRITE)
           =
          {
-                        multi_io_action(m, NULL, TA_TUN_WRITE,=
 false);
+                        multi_io_action(m, NULL, NULL, TA_TUN_WRI=
TE, false);
                     }
                     else if (e->rwflags=
 & EVENT_READ)
                     {
-                        multi_io_act=
ion(m, NULL, TA_TUN_READ, false);
+                        multi_io_action(=
m, NULL, NULL, TA_TUN_READ, false);
                     }
                =
 }
 
@@ -679,19 +688,22 @@
     multi_io->n_esr =3D 0;
 
     /*
-     * Dr=
ain the queued mbuf packets, datagram and TCP instances alike
+     * Drain=
 the queued mbuf packets, datagram and TCP instances alike:
+     * multi_g=
et_queue() prepares each one in the to_link buffer of its
+     * instance=
=2E
      */
     {
         struct multi_instance *mi;
-        while (!IS=
_SIG(&m->top) && (mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
+        while (!IS=
_SIG(&m->top) && (mi =3D multi_get_queue(m->mbuf)) !=3D NULL)
         {
- =
           multi_io_action(m, mi, TA_SOCKET_WRITE, true);
+            mult=
i_io_action(m, mi, NULL, TA_SOCKET_WRITE, true);
         }
     }
 }
 
 vo=
id
-multi_io_action(struct multi_context *m, struct multi_instance *mi, int=
 action, bool poll)
+multi_io_action(struct multi_context *m, struct multi_=
instance *mi, struct link_socket *sock,
+                int action, bool p=
oll)
 {
     bool tun_input_pending =3D false;
 
@@ -724,7 +736,7 @@
      =
   /*
          * Dispatch the action
          */
-        struct multi_in=
stance *touched =3D multi_io_dispatch(m, mi, action);
+        struct multi=
_instance *touched =3D multi_io_dispatch(m, mi, sock, action);
 
         /=
*
          * Signal received or connection
diff --git a/src/openvpn/multi_=
io=2Eh b/src/openvpn/multi_io=2Eh
index 4d56e25=2E=2E591225c 100644
--- a/s=
rc/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=2Eh
@@ -69,11 +69,9 @@
 =

 void multi_io_process_io(struct multi_context *m);
 
-void multi_io_actio=
n(struct multi_context *m, struct multi_instance *mi, int action, bool poll=
);
+void multi_io_action(struct multi_context *m, struct multi_instance *mi=
, struct link_socket *sock,
+                     int action, bool poll);
 =

 void multi_io_delete_event(struct multi_io *multi_io, event_t event);
 
-=
bool multi_io_send_link(struct multi_context *m, struct multi_instance *mi,=

-                        const unsigned int mpp_flags);
-
 #endif /* ifnde=
f MULTI_IO_H */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2046?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
Gerrit-Change-Number: 2046
Gerri=
t-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2E=
com>

--kaE+Q5tdKR4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori, R=C4=83zvan Cojoc=
aru=2E </p>
<p>Gianmarco De Gregori <strong>uploaded patch set #3</strong> =
to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2046?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
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
ed, 59 insertions(+), 87 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/2046/3</pre><pre =
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
ndex b1a648b=2E=2Ec41905b 100644</span><br><span>--- a/src/openvpn/multi=2E=
c</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -2869,7 +2=
869,7 @@</span><br><span>             if (mi)</span><br><span>             =
{</span><br><span>                 /* continue authentication, perform NCP =
negotiation and send push_reply */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                multi_io_action(m, mi, TA_INSTANCE_POST, false=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
ulti_io_action(m, mi, NULL, TA_INSTANCE_POST, false);</span><br><span>     =
        }</span><br><span>             else</span><br><span>             {<=
/span><br><span>@@ -4266,7 +4266,7 @@</span><br><span>         }</span><br>=
<span>         else if (status =3D=3D 0)</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_io_action(m=
ulti, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            multi_io_action(multi, NULL, NULL, TA_TIMEOUT, fals=
e);</span><br><span>         }</span><br><span> </span><br><span>         M=
ULTI_CHECK_SIG(multi);</span><br><span>diff --git a/src/openvpn/multi_io=2E=
c b/src/openvpn/multi_io=2Ec</span><br><span>index a6e97af=2E=2E83233d2 100=
644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/sr=
c/openvpn/multi_io=2Ec</span><br><span>@@ -328,27 +328,24 @@</span><br><spa=
n> }</span><br><span> </span><br><span> /*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Determine which instance has pending output</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * and prepare the output for=
 sending in</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the to_=
link buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * De=
termine which instance has output for the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * link: the pending instance, or else mi itself=2E</=
span><br><span>  */</span><br><span> static struct multi_instance *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_write_link_pre(struc=
t multi_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_io_write_link_pre(struct multi_context *m, struct multi_instance *mi)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct multi_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     if (m-&gt;pending)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi =3D m-=
&gt;pending;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return m-&gt;pending;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; LINK_OUT(&=
amp;mi-&gt;context))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        mi =3D multi_get_queue(m-&gt;mbuf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return mi;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NUL=
L;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static bool</span><br><span> multi_io_send_link(struct multi_context *m,=
 struct multi_instance *mi, const unsigned int mpp_flags)</span><br><span> =
{</span><br><span>     bool ret =3D true;</span><br><span>@@ -381,11 +378,1=
2 @@</span><br><span> }</span><br><span> </span><br><span> static bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_write_link(struct=
 multi_context *m, bool defer, const unsigned int mpp_flags)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_io_write_link(struct multi_c=
ontext *m, struct multi_instance *mi, bool defer,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    const unsigned int mpp_fl=
ags)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct multi_instance *mi =3D multi_io_write_link_pre(m);</span><br><=
span>     bool ret =3D true;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    mi =3D multi_io_write_link_pre(m, mi);</span=
><br><span>     if (mi)</span><br><span>     {</span><br><span>         if =
((defer &amp;&amp; !proto_is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&g=
t;info=2Eproto))</span><br><span>@@ -426,7 +424,8 @@</span><br><span> }</sp=
an><br><span> </span><br><span> static struct multi_instance *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-multi_io_dispatch(struct multi_con=
text *m, struct multi_instance *mi, const int action)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_io_dispatch(struct multi_context *m=
, struct multi_instance *mi, struct link_socket *sock,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                  const int action)</spa=
n><br><span> {</span><br><span>     const unsigned int mpp_flags =3D MPP_PR=
E_SELECT | MPP_RECORD_TOUCH;</span><br><span>     struct multi_instance *to=
uched =3D mi;</span><br><span>@@ -448,21 +447,28 @@</span><br><span> </span=
><br><span>         case TA_SOCKET_READ:</span><br><span>         case TA_S=
OCKET_READ_RESIDUAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            ASSERT(mi-&gt;context=2Ec2=2Elink_sockets);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt;context=2Ec2=
=2Elink_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            read_incoming_link(&amp;mi-&gt;context, mi-&gt;context=2Ec=
2=2Elink_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (!IS_SIG(&amp;mi-&gt;context))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            struct context *c =3D multi_get_context=
(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (mi)</span><br>=
<span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               multi_process_incoming_link(m, mi, mpp_flags, mi-&gt;context=
=2Ec2=2Elink_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                if (!IS_SIG(&amp;mi-&gt;context))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ASSERT(mi-&gt;context=2Ec=
2=2Elink_sockets);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               sock =3D mi-&gt;context=2Ec2=2Elink_sockets[0];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                set_prefix(mi);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(sock);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            read_inc=
oming_link(c, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            clear_prefix();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (!IS_SIG(c))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                multi_process_incoming_link(m, mi, mpp_flags, so=
ck);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 if (!IS_SIG(c))</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    stream_buf_read_setup(m=
i-&gt;context=2Ec2=2Elink_sockets[0]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    stream_buf_read_setup(sock);</span><=
br><span>                 }</span><br><span>             }</span><br><span>=
             break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span> </span><br><span>         case TA_TIMEOUT:</span=
><br><span>             multi_process_timeout(m, mpp_flags);</span><br><spa=
n>@@ -482,11 +488,11 @@</span><br><span>             break;</span><br><span=
> </span><br><span>         case TA_SOCKET_WRITE:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            multi_io_write_link(m, false, mpp_f=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
ulti_io_write_link(m, mi, false, mpp_flags);</span><br><span>             b=
reak;</span><br><span> </span><br><span>         case TA_SOCKET_WRITE_DEFER=
RED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi=
_io_write_link(m, true, mpp_flags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            multi_io_write_link(m, mi, true, mpp_flags);</s=
pan><br><span>             break;</span><br><span> </span><br><span>       =
  case TA_INITIAL:</span><br><span>@@ -594,11 +600,11 @@</span><br><span>  =
                   mi =3D ev_arg-&gt;u=2Emi;</span><br><span>              =
       if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span>               =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          multi_io_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        multi_i=
o_action(m, mi, NULL, TA_SOCKET_WRITE_READY, false);</span><br><span>      =
               }</span><br><span>                     else if (e-&gt;rwflag=
s &amp; EVENT_READ)</span><br><span>                     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                        multi_io_actio=
n(m, mi, TA_SOCKET_READ, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        multi_io_action(m, mi, NULL, TA_SOCKET=
_READ, false);</span><br><span>                     }</span><br><span>     =
                break;</span><br><span> </span><br><span>@@ -613,18 +619,21=
 @@</span><br><span>                     {</span><br><span>                =
         socket_reset_listen_persistent(ev_arg-&gt;u=2Esock);</span><br><sp=
an>                         mi =3D multi_create_instance_tcp(m, ev_arg-&gt;=
u=2Esock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               /* monitor and/or handle events that are</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                         * triggered in=
 succession by the first one</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                         * before returning to the main loop=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                           multi_io_action(m, mi, NULL, TA_INITIAL, false);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     }</span><br><span>                     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    else if (e-&gt;rwflags &am=
p; EVENT_WRITE)</span><br><span>                     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        multi_process_io_u=
dp(m, ev_arg-&gt;u=2Esock, e-&gt;rwflags);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        mi =3D m-&gt;pending;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        mult=
i_io_action(m, NULL, NULL, TA_SOCKET_WRITE, false);</span><br><span>       =
              }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              /* monitor and/or handle events that are</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                     * triggered in succes=
sion by the first one</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                     * before returning to the main loop=2E */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    if (mi)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    else i=
f (e-&gt;rwflags &amp; EVENT_READ)</span><br><span>                     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 multi_io_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        multi_io_action(m, NULL, ev=
_arg-&gt;u=2Esock, TA_SOCKET_READ, false);</span><br><span>                =
     }</span><br><span>                     break;</span><br><span>        =
     }</span><br><span>@@ -644,11 +653,11 @@</span><br><span>              =
   {</span><br><span>                     if (e-&gt;rwflags &amp; EVENT_WRI=
TE)</span><br><span>                     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        multi_io_action(m, NULL, TA_TU=
N_WRITE, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     multi_io_action(m, NULL, NULL, TA_TUN_WRITE, false);</=
span><br><span>                     }</span><br><span>                     =
else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span>                  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       multi_io_action(m, NULL, TA_TUN_READ, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        multi_io_action(m=
, NULL, NULL, TA_TUN_READ, false);</span><br><span>                     }</=
span><br><span>                 }</span><br><span> </span><br><span>@@ -679=
,19 +688,22 @@</span><br><span>     multi_io-&gt;n_esr =3D 0;</span><br><sp=
an> </span><br><span>     /*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     * Drain the queued mbuf packets, datagram and TCP instances ali=
ke</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Drain the =
queued mbuf packets, datagram and TCP instances alike:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * multi_get_queue() prepares each o=
ne in the to_link buffer of its</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * instance=2E</span><br><span>      */</span><br><span>   =
  {</span><br><span>         struct multi_instance *mi;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        while (!IS_SIG(&amp;m-&gt;top) &a=
mp;&amp; (mi =3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        while (!IS_SIG(&amp;m-&gt;top) &amp;=
&amp; (mi =3D multi_get_queue(m-&gt;mbuf)) !=3D NULL)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mult=
i_io_action(m, mi, TA_SOCKET_WRITE, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            multi_io_action(m, mi, NULL, TA_SOCKET_W=
RITE, true);</span><br><span>         }</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-multi_io_action(struct multi_context *m, struct mu=
lti_instance *mi, int action, bool poll)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_io_action(struct multi_context *m, struct multi_=
instance *mi, struct link_socket *sock,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                int action, bool poll)</span><br><span>=
 {</span><br><span>     bool tun_input_pending =3D false;</span><br><span> =
</span><br><span>@@ -724,7 +736,7 @@</span><br><span>         /*</span><br>=
<span>          * Dispatch the action</span><br><span>          */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct multi_instance =
*touched =3D multi_io_dispatch(m, mi, action);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct multi_instance *touched =3D multi=
_io_dispatch(m, mi, sock, action);</span><br><span> </span><br><span>      =
   /*</span><br><span>          * Signal received or connection</span><br><=
span>diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span=
><br><span>index 4d56e25=2E=2E591225c 100644</span><br><span>--- a/src/open=
vpn/multi_io=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><=
span>@@ -69,11 +69,9 @@</span><br><span> </span><br><span> void multi_io_pr=
ocess_io(struct multi_context *m);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void multi_io_action(struct multi_context *=
m, struct multi_instance *mi, int action, bool poll);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void multi_io_action(struct multi_context=
 *m, struct multi_instance *mi, struct link_socket *sock,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     int action, bool=
 poll);</span><br><span> </span><br><span> void multi_io_delete_event(struc=
t multi_io *multi_io, event_t event);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-bool multi_io_send_link(struct multi_cont=
ext *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        const unsigned int mpp_flags);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* i=
fndef MULTI_IO_H */</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail">change 2046</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7a31ff1c37=
92104101cb2e828be3b7fd8f44156 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>

</body></=
html>
--kaE+Q5tdKR4=--


--===============1962447426120890061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1962447426120890061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1962447426120890061==--

