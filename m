Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636C606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FLoAveEk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h5vkvX22;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ihE5oacK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OoStorBg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y+55JQz7KIb//OetEQsaNpeXj5XeFj4ymaFTgXoks+4=; b=FLoAveEkF6otC8YSRrsdHofIgg
	GFE3RyUoG4i6NEx3yPCtMx5T4hVAszaiTIJdWESrEGDu+qKLtp/8Jlli3TX4MLvqD1k7AfuyFjQUs
	XYWgeuZ76a2J4VYGwG4uzWgWsDt+Y1Q4OL41x0MQOK4k9+RqZyaX7KU7frGsN2QFkp7s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPI6x-000000005j4-0R7u;
	Fri, 06 Nov 2026 11:27:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPI6p-000000005ig-31xq
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SidFiOHQYFJCp1yGNa73jmlzhzTdBWeIQHS0lwzKVEg=; b=h5vkvX22UswvZgWrGJ/Kx/cbQs
 Y/gM5Y9weDxxvu+P7GM7NqPE0Nc6qpBbf+JWS8/BlZpYurqsCAhOwJNVeiu3JEcHEcQ2eJNx/KAZh
 +4mjgOfhPM33tXE9ctuwRdfU9Xzua2APTNbZu5P/SdxMIbwlPQaqpm9kEl1ZbnR83hyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SidFiOHQYFJCp1yGNa73jmlzhzTdBWeIQHS0lwzKVEg=; b=ihE5oacKfxoysn4+LAteb0W4dv
 leA1imtvxIEbpuYNbE8Oh8gRZ2BW6zyG/sxslqoCj9irF+CmIxXIkvhJieZm7ciBn0CKZJ4adEybQ
 97oRpBYvnTZhWCAn4xdgQ/D9lNLQQxF2sQ1kmqlCSvN2vpuDz3KpjK0TuP5OCR7W5ub8=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPI6V-000000003v5-1KQ7 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:27:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so4710895e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793964445; x=1794569245; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SidFiOHQYFJCp1yGNa73jmlzhzTdBWeIQHS0lwzKVEg=;
 b=OoStorBg3iAAG+4uUmtFcffhRr3XCXd+iUl3qAfNIuvbWpEc1dhLy5ZAG19w1aK1tL
 ZbOnKeEPJ7DI1whBfyIIfRYbzovLFE18H2CYXWMv9Mx+27io73AbtOHPwqEWUgBsbISX
 YiFrTJpvLiv94+puYVMnT/gLIrb41kivSupVmuX9FbJPv20ZTdCuDOcmHNEuS8QQYNGK
 ud0NtA7SttHR+vZXopj+BW0qFh2+OjXge4y3p5VJPe8X/22VVSBB+Cf11nn8JEXSk9Xt
 8O4D15NyrUDXwwpF21PSyBFH/7zB+5tIBzZl7p4ZX2bsUc1xYO/ZvpW3FDaAtLMvyY+p
 xImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964445; x=1794569245;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SidFiOHQYFJCp1yGNa73jmlzhzTdBWeIQHS0lwzKVEg=;
 b=zta1pa3EpgBAnrODlYK5KitRdGb4OeBO4NNR4iCC2CrziiaR97i7gBVbi7apmI3cMP
 rQtSrrH3JcNObn+o1eVLKjMUAabZQCFlExrplvhHaYbTWebMrdpCZz4ZIid7IXdJDdVk
 fkBvT46cJ1HLe2L+oJ3o1xyz83DjGNc2nrqQGMsmJRQWmJcDDpksLWgrXqA+pqYY370X
 WYJ7fNEUKqKCNS8Ta6mgd1djgLdpoirKfyA49qyy6mf4XrCAz3vQohjrxGuCr+p1Io6u
 SJlueniPQmJdGMgJsi+waPCrrzY4QhFmtKLDOYFwYIZhSE61FKOGy84N8blUp/5H5IF8
 RXXg==
X-Gm-Message-State: APuU4Z/qjHxutzZD56KsFDu9im3HkMcyYu1VrFizSegWL4XkvSawUTR2
 Bf+cVe1rOtq6b0yhrTNR+YzsD5Lav+p4UL0ugHM9FemeGdxOiMxn6n2hFd6yzk4T9zYHNPEyLZh
 v7nF+YGgTyeDAlHfj3SOf/E2X9hHA9enZO1iidewq2tfUUBXxHSwgyQCMLEgQv7zQn3P4
X-Gm-Gg: AYBFou2GX+mAvOzGQ4OcxaekEpjvuo81iUdL14Mmzqp4zhKxGv8sgyVtfO6bWNS2fRo
 /FjZ6A71si9qOfG8uLMHatmgam2JwosKwhhYT1nPldMGjYa7BlMhBK854y4IgCxtTCjOUjDXTaV
 /cV2WPXG4V4zSBgUImecIgZYc9PF2nY/ZwMtf1ZUbG7B7aUXelOeEWYX4yErhnycywXqCP5qIFw
 5/5hA5q7v4736o8w4W5nll2NGl/1EZWMGgnhpJMWs/nL0VOsjfiZcLX/BVnz38FpNwawsy6JfVU
 bKWNEt8yD1/8oxiVEdW162QQS6QnwmBtZe9Fu6kgmZG6R2y4ZW/CF0iZo0j1sdKYsAUY+tT3FSW
 T1Bpv8mzIb3nPHWMTYkjGBkTCva2jVBAu/JjqKbx8WwVC3/7uMa2/3qHdNEp5eRheyfajDN8Oto
 Z7Vem4ALQcB8BwRoASd23PAt+pjWs12ygMXi5tYyedw0dXJEc0bIwHzwyabvPt/MdsBKLLUi3L1
 6dwMIKQsMOnh7lV6fCvOnI1BpHp+IeUd1SQITQ+hEDtFx+XvxjgU9X8Fo4UShx1c1dF3GJ+QXlY
 zgaZe6xXg8+x27sg+QfUTeA6PKxYSHKY9r+ytsai5gqI8oS/PN5cKxxBUHqpkUtZoSUt2nkiX5C
 g271fHeQa2UmYpzcorBUYF+pEVA04JOXiUM/fT+GAHv8wveVFg/HvfNw1YBWgNAzy0rBO2t4PTx
 edfVjBFlKiUNcKJg==
X-Received: by 2002:a05:600c:5296:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4b6dea68fb8mr36480975e9.4.1793964444473; 
 Fri, 06 Nov 2026 03:27:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcb8sm128619175e9.1.2026.11.06.03.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:27:23 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:27:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 960b56641b7814262f6a811e7f4338d4224bb741
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <211c17654bb45b22e9c35e4991bb6614c96d7e99-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPI6V-000000003v5-1KQ7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6403910644413147169=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6403910644413147169==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p2xIqvTIedo="; charset=UTF-8

--p2xIqvTIedo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail

to look at the new patch set (#5)=2E

=
The following approvals got outdated and were removed:
Code-Review-1 by R=
=C4=83zvan Cojocaru


Change subject: Adjust ACC_MAX_MSG_LEN, fix ACC in p2=
p mode and improve documentation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve=
 documentation

We do not need to limit the maximum ACC message length to j=
ust 1280=2E Also
improve the comments and documentation to be clearer=2E

F=
ix that the management notification about negotiated protocol is not sent
w=
hen in p2p mode (or if a server has push-peer-info in its configuration)

C=
hange-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Signed-off-by: Arne Sch=
wabe <arne@rfc2549=2Eorg>
---
M doc/management-notes=2Etxt
M src/openvpn/ac=
c=2Ec
M src/openvpn/acc=2Eh
M tests/unit_tests/openvpn/test_acc=2Ec
4 files=
 changed, 39 insertions(+), 15 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/30/2130/5

diff --git a/doc/managemen=
t-notes=2Etxt b/doc/management-notes=2Etxt
index 6c798c0=2E=2Ea98b45f 10064=
4
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -139=
8,11 +1398,17 @@
     next message should be concatenated to this message t=
o form a complete
     message=2E
 
-    Note that the OpenVPN implementati=
on operates here with the robustness
-    principle ("be conservative in wh=
at you send, be liberal in what you
-    accept" - RFC 793 and others) and =
allows receiving messages longer than
-    maximum allowed message length=
=2E Implementations should be prepared to
-    handle messages that are lon=
ger than the maximum allowed message length=2E
+    Note that fragment is b=
asically a flag for allowing peers communicating
+    over ACC to indicate =
if multiple ACC messages should be considered to
+    be a single message=
=2E If the ACC protocol is a stream based protocol
+    then all messages c=
an be sent without fragment flag=2E
+
+    Note that the OpenVPN implementa=
tion allows receiving messages longer than
+    announced maximum allowed m=
essage length=2E Implementations must be prepared
+    to handle messages t=
hat are longer than the maximum allowed message length=2E
+    Overlong mes=
sages are considered invalid and indicate that the peer is
+    misbehaving=
=2E Disconnecting/dropping the peer is considered a valid
+    response to =
such messages=2E
 
     OpenVPN does not verify that the message is valid b=
ase64=2E A peer that
     sends invalid base64 payload will be passed to th=
e management interface=2E
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/ac=
c=2Ec
index 455f56d=2E=2Ee9656a6 100644
--- a/src/openvpn/acc=2Ec
+++ b/src=
/openvpn/acc=2Ec
@@ -190,10 +190,10 @@
     }
 
     /* We do not check the=
 length here=2E We make no promises to support
-     * anything larger than=
 our announced message length but according to
-     * the robustness princ=
iple
-     * ("be conservative in what you send, be liberal in what you acc=
ept" - RFC 793 and others)
-     * we accept also longer messages */
+     =
* anything larger than our announced message length but we accept also
+   =
  * longer messages if they manage to get through all the other layers
+   =
  * that restrict the message size like TLS_CHANNEL_BUF_SIZE=2E
+     */
 
=
     int payload_len;
     const char *payload_len_str =3D buf_extract_fiel=
d(&buf, ',', &gc);
@@ -426,8 +426,20 @@
     multi->acc_negotiated_protocol=
s =3D string_alloc(buf_str(&common_protocols), NULL);
     multi->acc_max_m=
essage_length =3D max_acc_len;
 
-    setenv_str(session->opt->es, "acc_pro=
tocols", multi->acc_negotiated_protocols);
-    setenv_int(session->opt->es=
, "acc_message_len", multi->acc_max_message_length);
+    /* The normal cas=
e is that this is a server where we notify the client
+     * capabilities =
via environment variables */
+    if (multi->opt=2Emode =3D=3D MODE_SERVER)=

+    {
+        setenv_str(session->opt->es, "acc_protocols", multi->acc_n=
egotiated_protocols);
+        setenv_int(session->opt->es, "acc_message_le=
n", multi->acc_max_message_length);
+    }
+    else
+    {
+        /* We =
can also end up here in p2p or if the server has --push-peer-info
+        =
 * We do not set variables in that case to keep behavior consistent with
+ =
        * the other paths on the client that also do not set variables */
+=
        notify_client_acc_protocols(multi);
+    }
 
     gc_free(&gc);
 }
=
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
index 9c99b11=2E=2Ed=
640898 100644
--- a/src/openvpn/acc=2Eh
+++ b/src/openvpn/acc=2Eh
@@ -29,7 =
+29,9 @@
 #include "openvpn=2Eh"
 
 #define ACC_MIN_MSG_LEN 64
-#define ACC=
_MAX_MSG_LEN 1280
+/* This is a conservative limit=2E The theoretical maxim=
um
+ * is much closer to the TLS_CHANNEL_BUF_SIZE */
+#define ACC_MAX_MSG_L=
EN (TLS_CHANNEL_BUF_SIZE - 128)
 
 /**
  * This method parses an app custom=
 control message and delivers it to the
diff --git a/tests/unit_tests/openv=
pn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
index 9364d12=2E=2E=
b9b1041 100644
--- a/tests/unit_tests/openvpn/test_acc=2Ec
+++ b/tests/unit=
_tests/openvpn/test_acc=2Ec
@@ -181,7 +181,11 @@
     int max_len =3D 0;
  =
   const char *protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_l=
en, true, &gc);
     assert_string_equal(protocols, "flower:happy");
-    a=
ssert_int_equal(max_len, 1280);
+
+    /* Check that the ACC_MAX_MSG_LEN is=
 1920 to ensure that the tests get
+     * adjusted if it changes */
+    a=
ssert_int_equal(ACC_MAX_MSG_LEN, 1920);
+    assert_int_equal(max_len, ACC_=
MAX_MSG_LEN);
 
     /* a client does not accept a length longer than it su=
pports */
     protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_l=
en, false, &gc);
@@ -250,11 +254,11 @@
 
     determine_common_acc_protocol=
s(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
 
-    assert_int_equal(m=
ulti->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_int_equal(multi=
->acc_max_message_length, 1400);
     assert_string_equal(multi->acc_negoti=
ated_protocols, "power:flower");
 
     assert_string_equal(env_set_get(mul=
ti->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");
-    asser=
t_string_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "acc_messag=
e_len=3D1280");
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_=
message_len"), "acc_message_len=3D1400");
 
     free(multi->acc_negotiated=
_protocols);
     gc_free(&c->options=2Egc);

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Ge=
rrit-Change-Number: 2130
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>

--p2xIqvTIedo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #5</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Adjust A=
CC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation<br><br>We do =
not need to limit the maximum ACC message length to just 1280=2E Also<br>im=
prove the comments and documentation to be clearer=2E<br><br>Fix that the m=
anagement notification about negotiated protocol is not sent<br>when in p2p=
 mode (or if a server has push-peer-info in its configuration)<br><br>Chang=
e-Id: I3a268fc602e916bf54853c950761977cf3d7f835<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M doc/management-notes=2Etxt<br>M =
src/openvpn/acc=2Ec<br>M src/openvpn/acc=2Eh<br>M tests/unit_tests/openvpn/=
test_acc=2Ec<br>4 files changed, 39 insertions(+), 15 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/30/2130/5</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/ma=
nagement-notes=2Etxt</span><br><span>index 6c798c0=2E=2Ea98b45f 100644</spa=
n><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/mana=
gement-notes=2Etxt</span><br><span>@@ -1398,11 +1398,17 @@</span><br><span>=
     next message should be concatenated to this message to form a complete=
</span><br><span>     message=2E</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    Note that the OpenVPN implementation opera=
tes here with the robustness</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    principle (&quot;be conservative in what you send, be liberal in=
 what you</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    accept&q=
uot; - RFC 793 and others) and allows receiving messages longer than</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    maximum allowed message =
length=2E Implementations should be prepared to</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    handle messages that are longer than the maxi=
mum allowed message length=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    Note that fragment is basically a flag for allowing peers com=
municating</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    over =
ACC to indicate if multiple ACC messages should be considered to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    be a single message=2E If =
the ACC protocol is a stream based protocol</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    then all messages can be sent without fragment =
flag=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    Note that the OpenVPN imple=
mentation allows receiving messages longer than</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    announced maximum allowed message length=2E=
 Implementations must be prepared</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    to handle messages that are longer than the maximum allow=
ed message length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    Overlong messages are considered invalid and indicate that the peer is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    misbehaving=2E =
Disconnecting/dropping the peer is considered a valid</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    response to such messages=2E</span><b=
r><span> </span><br><span>     OpenVPN does not verify that the message is =
valid base64=2E A peer that</span><br><span>     sends invalid base64 paylo=
ad will be passed to the management interface=2E</span><br><span>diff --git=
 a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index 455f56d=
=2E=2Ee9656a6 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br><s=
pan>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -190,10 +190,10 @@</span><=
br><span>     }</span><br><span> </span><br><span>     /* We do not check t=
he length here=2E We make no promises to support</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * anything larger than our announced messag=
e length but according to</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * the robustness principle</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * (&quot;be conservative in what you send, be liberal in=
 what you accept&quot; - RFC 793 and others)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * we accept also longer messages */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * anything larger than our=
 announced message length but we accept also</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * longer messages if they manage to get throu=
gh all the other layers</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * that restrict the message size like TLS_CHANNEL_BUF_SIZE=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span>=
 </span><br><span>     int payload_len;</span><br><span>     const char *pa=
yload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span>=
<br><span>@@ -426,8 +426,20 @@</span><br><span>     multi-&gt;acc_negotiate=
d_protocols =3D string_alloc(buf_str(&amp;common_protocols), NULL);</span><=
br><span>     multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(=
session-&gt;opt-&gt;es, &quot;acc_protocols&quot;, multi-&gt;acc_negotiated=
_protocols);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    seten=
v_int(session-&gt;opt-&gt;es, &quot;acc_message_len&quot;, multi-&gt;acc_ma=
x_message_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* The normal case is that this is a server where we notify the client</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * capabilities v=
ia environment variables */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (multi-&gt;opt=2Emode =3D=3D MODE_SERVER)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        setenv_str(session-&gt;opt-&gt;es, &quot;acc=
_protocols&quot;, multi-&gt;acc_negotiated_protocols);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        setenv_int(session-&gt;opt-&gt;e=
s, &quot;acc_message_len&quot;, multi-&gt;acc_max_message_length);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* We can also end up here in p2p or if the server has --p=
ush-peer-info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * We do not set variables in that case to keep behavior consistent with<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the other=
 paths on the client that also do not set variables */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        notify_client_acc_protocols(mult=
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br=
><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><sp=
an>index 9c99b11=2E=2Ed640898 100644</span><br><span>--- a/src/openvpn/acc=
=2Eh</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -29,7 +29=
,9 @@</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><span> </=
span><br><span> #define ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* This is a conservative limit=2E The theore=
tical maximum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is =
much closer to the TLS_CHANNEL_BUF_SIZE */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)=
</span><br><span> </span><br><span> /**</span><br><span>  * This method par=
ses an app custom control message and delivers it to the</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn=
/test_acc=2Ec</span><br><span>index 9364d12=2E=2Eb9b1041 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -181,7 +181,11 @@</spa=
n><br><span>     int max_len =3D 0;</span><br><span>     const char *protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span>     assert_string_equal(protocols, &quot;flow=
er:happy&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert_int_equal(max_len, 1280);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Check that the ACC_MAX_MSG_LEN is 1920 to ensure that the tests get</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * adjusted if it chang=
es */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(ACC_MAX_MSG_LEN, 1920);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(max_len, ACC_MAX_MSG_LEN);</span><br><span>=
 </span><br><span>     /* a client does not accept a length longer than it =
supports */</span><br><span>     protocols =3D parse_acc_parameters(info_ac=
c_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span>@@ -25=
0,11 +254,11 @@</span><br><span> </span><br><span>     determine_common_acc=
_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert=
_int_equal(multi-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(multi-&gt;a=
cc_max_message_length, 1400);</span><br><span>     assert_string_equal(mult=
i-&gt;acc_negotiated_protocols, &quot;power:flower&quot;);</span><br><span>=
 </span><br><span>     assert_string_equal(env_set_get(multi-&gt;opt=2Ees, =
&quot;acc_protocols&quot;), &quot;acc_protocols=3Dpower:flower&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(en=
v_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_messa=
ge_len=3D1280&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message=
_len&quot;), &quot;acc_message_len=3D1400&quot;);</span><br><span> </span><=
br><span>     free(multi-&gt;acc_negotiated_protocols);</span><br><span>   =
  gc_free(&amp;c-&gt;options=2Egc);</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">change 2=
130</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2130 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=


</body></html>
--p2xIqvTIedo=--


--===============6403910644413147169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6403910644413147169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6403910644413147169==--

