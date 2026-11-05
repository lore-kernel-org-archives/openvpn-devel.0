Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D93606D805
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OaG4lpul;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DJwpuyjL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DBiz5WCH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hWX/whz9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sH0vWRDcy+W+vT4SZVWsnNyNBMbL/ox6098y2R1o9I8=; b=OaG4lpulBS/1pSE+U1DKgiER0B
	SiNoz5Dn76tBiUp0PHiFKNNFSFdt1IcMYRY+TbGIefx+kkyGQaHmRdUmyDyfXknNa3ciZcTuLfENt
	+pgtaG3oeZ7GFzSV8OvfAIiXoR4ZOouLDIjVScBbhyr8Y57r0JS3ViU7TTEToFTo/z7M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0H9-000000004fd-3pt7;
	Thu, 05 Nov 2026 16:25:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP0H8-000000004fW-397E
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:25:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KR45O5ESlhJ06i15aIbPd2XLpCL9izmr0MuWcULSdGo=; b=DJwpuyjL2/6GTZLcDtV9P5DC7Y
 cCLj0odaMjAuAMGMkFIPo3l18VVUg+ctdcIMwm6pSvg9w6ivBANHvdyMeH7vKM3rVQ//i898zPfcI
 HVNEjISoLNRXZsWQSOdEeM6IIQvhZMgKHLYdDhMxD4i2Z8a+GFB8FDlHPOsHmOe6F42Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KR45O5ESlhJ06i15aIbPd2XLpCL9izmr0MuWcULSdGo=; b=DBiz5WCHaTK6W4Bw9bj5TElKx8
 x/B7UNLJINXzrwsxR5EA/eoPJwwXoHlQOyzZgn/JaYy7P4mEk4t3lXd5q4n2fUP28VfdnxATacK08
 99iSwBzZlZF11jTkDznAew4xfaL0k0VTIIddnSMvPpbGriAjJ2gT1uqDlw8XucAW783U=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP0H5-000000006Ok-2UL9 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:25:18 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so18812175e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793895909; x=1794500709; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KR45O5ESlhJ06i15aIbPd2XLpCL9izmr0MuWcULSdGo=;
 b=hWX/whz95wvXpJshIeQUhPugRykDNz/hR+lzk+gxg+c5YGvnhGnI1U0GybUc/8Lhgn
 xANIGh+BBVFZSzLnsnwrnlH/2aYZp4WWtIFmTprYvs1XMPDmHLvWNzR470ovGyYeJ9CC
 9nJ7DNoj5DlEYO12/AQiI8cm0C0u02OJyPNW3B+F9YGunp04iQUFLQKZEZGD/qV+0woS
 o8Xe1fW//PRhoBVcwNH6qQHGgjgHtB3sW7gu6744Gpfwz8bL+Bi8qohQa+lE5pyzvBlw
 JUaQBjAnWtt7nk548Y2zSlNNLZoj60kFmJlPwIE43Ji7IoNVd5YWkmC9Nb2JRvwXDJ/G
 96rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793895909; x=1794500709;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KR45O5ESlhJ06i15aIbPd2XLpCL9izmr0MuWcULSdGo=;
 b=Vb0c6NxNQeQ2loX3LOLsY6ivRi0RbPggGnIBBlboSUQNTCEj1wDJVepwAwXq1iHPeD
 aJm1lUt6o8A5V2auEbnXWMzW+6WDUBXEqK6KejCES87LCR9r9xAYfsWPvUNWaqYg0mbL
 v64fvkqpsIViaKpWr1xheQpFbj32PTUcYosEIV4aAFWCy2/HFGF3LTPp3rNKldO4DRh8
 68e+2cAr/ofdkjsmrGgRJUNP7H++FPuXCgsaPika9eDr7slr2H5P+jAhs9L08BvrFpyr
 iZoLhQtXVhXOC2vKZJFX9g8LgKa9Xid1OpiHMjzx+HH3SQ1w84WvxAjtjDQS2MM9vQbN
 J7hA==
X-Gm-Message-State: APuU4Z/eIdeLi3kSUGOOXyiZK6VjlA+hwvvegFGnFik9Jtm4kMHt253j
 5UmvEAixDKK7E1QzOGMUDlzHY6AqEHceXRvzRxsOhYT/GiqsOn+QT1nWa+DOKkk4uaBOA3pcHYR
 CaYoYzneOZopyvwk5l4EDqXteq0CvqC5xb8huT6C5m0hoCk0VpwGUppdZijkT4Jw2f0fl
X-Gm-Gg: AYBFou1RGfq8a/TjkpNrNRDHxRS9QhNaIaXbvYCiknqqbTFQgWk64COuN5oXbefIMD6
 R54hsKESH3shdtM6b72qZvQguJ6PV2BADmQYjFKScYdRi8f5OOBpnm18y3Vvbt+arfH/B8gh4SQ
 TFcXAg4A2aOZAacsdlClYeK58UibEh5fspUP0kdbWEyHuPD01tAMyt8ZyJQM9lBoJL082itI0xv
 5KvJkIL2rqFF+nIdNccZciF3G7467FPm+O70qMFRVhFq3x1u6VGyca1MavtPtksmZDwxsAMbXOb
 y7cySZ7ZJ4YXIN2EjkB+3pTnRMr0TcjE05bZoQiPjmSbtybM32oTPbyC6NLcoHVdy8mQOu00X/9
 kOU9zJEnoL790t7EAIbWN8Q4StTGcYPpIpQJHDMEgQp9Mh1aMN0/IIBWpR3tSxSwmpK8e1f9Ovk
 OObsGHj3w8Tu8TtJ69riDz55zfQZOWU0bo6XYPvyCXuXGo6pvusL4Bza7mM/ArLGDuKTLYc5j2j
 k9Yr7+rxqnEhU1bD/RAOWJUkolkC8wgSWON6YRxerPyKVFvsBS7SAjvl3D3+JJ2rDT13ptH8F/i
 E7WGmGDQT+jzYJUoGsMIYhei8npmZlyU4ENJ1Hf9pkWRz5QMaNvyriyFN6o2PYUas32svUdetVi
 Vj1/THt1JmE95/S3MzeZIx9EX4lENO6x+RqEcK6BNGk93jcq0Wb/sNoiSZzv3CU+b78oTpuEx27
 U4p5YYklUx3Osn2Q==
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ac14ec7947mr445952595e9.2.1793895908525; 
 Thu, 05 Nov 2026 08:25:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f02386bsm71872885e9.7.2026.11.05.08.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:25:08 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 16:25:06 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 3d760aa23b004c8e6b95875d7d76209bcf129a19
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c8759883abfb67506d494dbf9dd1b347b57a44b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP0H5-000000006Ok-2UL9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
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
Content-Type: multipart/mixed; boundary="===============3044947647874106174=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3044947647874106174==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WERDbyMxSW8="; charset=UTF-8

--WERDbyMxSW8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail

to look at the new patch set (#4)=2E

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
M src/openvpn/ssl=2Ec
M tests/unit_tests/openvp=
n/test_acc=2Ec
5 files changed, 31 insertions(+), 13 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/2130/4

diff=
 --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 6c79=
8c0=2E=2Ea98b45f 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/manageme=
nt-notes=2Etxt
@@ -1398,11 +1398,17 @@
     next message should be concaten=
ated to this message to form a complete
     message=2E
 
-    Note that th=
e OpenVPN implementation operates here with the robustness
-    principle (=
"be conservative in what you send, be liberal in what you
-    accept" - RF=
C 793 and others) and allows receiving messages longer than
-    maximum al=
lowed message length=2E Implementations should be prepared to
-    handle m=
essages that are longer than the maximum allowed message length=2E
+    Not=
e that fragment is basically a flag for allowing peers communicating
+    o=
ver ACC to indicate if multiple ACC messages should be considered to
+    b=
e a single message=2E If the ACC protocol is a stream based protocol
+    t=
hen all messages can be sent without fragment flag=2E
+
+    Note that the =
OpenVPN implementation allows receiving messages longer than
+    announced=
 maximum allowed message length=2E Implementations must be prepared
+    to=
 handle messages that are longer than the maximum allowed message length=2E=

+    Overlong messages are considered invalid and indicate that the peer i=
s
+    misbehaving=2E Disconnecting/dropping the peer is considered a valid=

+    response to such messages=2E
 
     OpenVPN does not verify that the =
message is valid base64=2E A peer that
     sends invalid base64 payload wi=
ll be passed to the management interface=2E
diff --git a/src/openvpn/acc=2E=
c b/src/openvpn/acc=2Ec
index 455f56d=2E=2E7b04821 100644
--- a/src/openvpn=
/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -190,10 +190,10 @@
     }
 
     /* W=
e do not check the length here=2E We make no promises to support
-     * an=
ything larger than our announced message length but according to
-     * th=
e robustness principle
-     * ("be conservative in what you send, be liber=
al in what you accept" - RFC 793 and others)
-     * we accept also longer =
messages */
+     * anything larger than our announced message length but w=
e accept also
+     * longer messages if they manage to get through all the=
 other layers
+     * that restrict the message size like TLS_CHANNEL_BUF_S=
IZE=2E
+     */
 
     int payload_len;
     const char *payload_len_str =
=3D buf_extract_field(&buf, ',', &gc);
diff --git a/src/openvpn/acc=2Eh b/s=
rc/openvpn/acc=2Eh
index 9c99b11=2E=2Ed640898 100644
--- a/src/openvpn/acc=
=2Eh
+++ b/src/openvpn/acc=2Eh
@@ -29,7 +29,9 @@
 #include "openvpn=2Eh"
 
=
 #define ACC_MIN_MSG_LEN 64
-#define ACC_MAX_MSG_LEN 1280
+/* This is a con=
servative limit=2E The theoretical maximum
+ * is much closer to the TLS_CH=
ANNEL_BUF_SIZE */
+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)
 
 =
/**
  * This method parses an app custom control message and delivers it to=
 the
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index b701c0a=
=2E=2E4976646 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -2396,6 +2396,12 @@
     }
 
     determine_common_acc_protocols(multi, se=
ssion);
+    if (multi->opt=2Emode !=3D MODE_SERVER)
+    {
+        /* Thi=
s is required to support ACC in p2p mode or when the server
+         * sen=
ds peer-info */
+        notify_client_acc_protocols(multi);
+    }
 
     =
if (username_len < 0 || password_len < 0)
     {
diff --git a/tests/unit_te=
sts/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
index 9364=
d12=2E=2Eb9b1041 100644
--- a/tests/unit_tests/openvpn/test_acc=2Ec
+++ b/t=
ests/unit_tests/openvpn/test_acc=2Ec
@@ -181,7 +181,11 @@
     int max_len =
=3D 0;
     const char *protocols =3D parse_acc_parameters(info_acc_msg, " =
", &max_len, true, &gc);
     assert_string_equal(protocols, "flower:happy"=
);
-    assert_int_equal(max_len, 1280);
+
+    /* Check that the ACC_MAX_M=
SG_LEN is 1920 to ensure that the tests get
+     * adjusted if it changes =
*/
+    assert_int_equal(ACC_MAX_MSG_LEN, 1920);
+    assert_int_equal(max_=
len, ACC_MAX_MSG_LEN);
 
     /* a client does not accept a length longer t=
han it supports */
     protocols =3D parse_acc_parameters(info_acc_msg, " =
", &max_len, false, &gc);
@@ -250,11 +254,11 @@
 
     determine_common_acc=
_protocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
 
-    assert_in=
t_equal(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_int_eq=
ual(multi->acc_max_message_length, 1400);
     assert_string_equal(multi->a=
cc_negotiated_protocols, "power:flower");
 
     assert_string_equal(env_se=
t_get(multi->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");
-=
    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "a=
cc_message_len=3D1280");
+    assert_string_equal(env_set_get(multi->opt=2E=
es, "acc_message_len"), "acc_message_len=3D1400");
 
     free(multi->acc_n=
egotiated_protocols);
     gc_free(&c->options=2Egc);

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d=
7f835
Gerrit-Change-Number: 2130
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>

--WERDbyMxSW8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #4</strong> to this cha=
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
src/openvpn/acc=2Ec<br>M src/openvpn/acc=2Eh<br>M src/openvpn/ssl=2Ec<br>M =
tests/unit_tests/openvpn/test_acc=2Ec<br>5 files changed, 31 insertions(+),=
 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/30/2130/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/manage=
ment-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 6c798c0=
=2E=2Ea98b45f 100644</span><br><span>--- a/doc/management-notes=2Etxt</span=
><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -1398,11 +13=
98,17 @@</span><br><span>     next message should be concatenated to this m=
essage to form a complete</span><br><span>     message=2E</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Note that the Ope=
nVPN implementation operates here with the robustness</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    principle (&quot;be conservative in wha=
t you send, be liberal in what you</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    accept&quot; - RFC 793 and others) and allows receiving me=
ssages longer than</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 maximum allowed message length=2E Implementations should be prepared to</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    handle messages that=
 are longer than the maximum allowed message length=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    Note that fragment is basically a fl=
ag for allowing peers communicating</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    over ACC to indicate if multiple ACC messages should be=
 considered to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
e a single message=2E If the ACC protocol is a stream based protocol</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    then all messages can =
be sent without fragment flag=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    No=
te that the OpenVPN implementation allows receiving messages longer than</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    announced maximum =
allowed message length=2E Implementations must be prepared</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    to handle messages that are long=
er than the maximum allowed message length=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    Overlong messages are considered invalid and =
indicate that the peer is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    misbehaving=2E Disconnecting/dropping the peer is considered a va=
lid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    response to =
such messages=2E</span><br><span> </span><br><span>     OpenVPN does not ve=
rify that the message is valid base64=2E A peer that</span><br><span>     s=
ends invalid base64 payload will be passed to the management interface=2E</=
span><br><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span=
><br><span>index 455f56d=2E=2E7b04821 100644</span><br><span>--- a/src/open=
vpn/acc=2Ec</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -1=
90,10 +190,10 @@</span><br><span>     }</span><br><span> </span><br><span> =
    /* We do not check the length here=2E We make no promises to support</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * anything larger t=
han our announced message length but according to</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * the robustness principle</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * (&quot;be conservative in what=
 you send, be liberal in what you accept&quot; - RFC 793 and others)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * we accept also longer=
 messages */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
anything larger than our announced message length but we accept also</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * longer messages if =
they manage to get through all the other layers</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * that restrict the message size like TLS_=
CHANNEL_BUF_SIZE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     */</span><br><span> </span><br><span>     int payload_len;</span><br><=
span>     const char *payload_len_str =3D buf_extract_field(&amp;buf, &#39;=
,&#39;, &amp;gc);</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/op=
envpn/acc=2Eh</span><br><span>index 9c99b11=2E=2Ed640898 100644</span><br><=
span>--- a/src/openvpn/acc=2Eh</span><br><span>+++ b/src/openvpn/acc=2Eh</s=
pan><br><span>@@ -29,7 +29,9 @@</span><br><span> #include &quot;openvpn=2Eh=
&quot;</span><br><span> </span><br><span> #define ACC_MIN_MSG_LEN 64</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define ACC_MAX_MSG_LEN 1280=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* This is a conser=
vative limit=2E The theoretical maximum</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * is much closer to the TLS_CHANNEL_BUF_SIZE */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN (T=
LS_CHANNEL_BUF_SIZE - 128)</span><br><span> </span><br><span> /**</span><br=
><span>  * This method parses an app custom control message and delivers it=
 to the</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec</span><br><span>index b701c0a=2E=2E4976646 100644</span><br><span>--- =
a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><=
span>@@ -2396,6 +2396,12 @@</span><br><span>     }</span><br><span> </span>=
<br><span>     determine_common_acc_protocols(multi, session);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;opt=2Emode !=
=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* This i=
s required to support ACC in p2p mode or when the server</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * sends peer-info */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        notify_client_acc_pr=
otocols(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span> </span><br><span>     if (username_len &lt; 0 || passwor=
d_len &lt; 0)</span><br><span>     {</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span>=
<br><span>index 9364d12=2E=2Eb9b1041 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_acc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_acc=2Ec</span><br><span>@@ -181,7 +181,11 @@</span><br><span>     int=
 max_len =3D 0;</span><br><span>     const char *protocols =3D parse_acc_pa=
rameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><=
br><span>     assert_string_equal(protocols, &quot;flower:happy&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(max_=
len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check that the ACC_M=
AX_MSG_LEN is 1920 to ensure that the tests get</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * adjusted if it changes */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ACC_MAX_MSG_L=
EN, 1920);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(max_len, ACC_MAX_MSG_LEN);</span><br><span> </span><br><span>  =
   /* a client does not accept a length longer than it supports */</span><b=
r><span>     protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;=
, &amp;max_len, false, &amp;gc);</span><br><span>@@ -250,11 +254,11 @@</spa=
n><br><span> </span><br><span>     determine_common_acc_protocols(multi, &a=
mp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(multi-&gt=
;acc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(multi-&gt;acc_max_message_lengt=
h, 1400);</span><br><span>     assert_string_equal(multi-&gt;acc_negotiated=
_protocols, &quot;power:flower&quot;);</span><br><span> </span><br><span>  =
   assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_protocols&=
quot;), &quot;acc_protocols=3Dpower:flower&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_string_equal(env_set_get(multi-&gt;=
opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_message_len=3D1280&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;a=
cc_message_len=3D1400&quot;);</span><br><span> </span><br><span>     free(m=
ulti-&gt;acc_negotiated_protocols);</span><br><span>     gc_free(&amp;c-&gt=
;options=2Egc);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">change 2130</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a268fc602e916b=
f54853c950761977cf3d7f835 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2130 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--WERDbyMxSW8=--


--===============3044947647874106174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3044947647874106174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3044947647874106174==--

