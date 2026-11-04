Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C7606EEA0
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aW8RSJ9q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UVEhk7CR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hH3BM9VW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JPOkJCiy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y8DVuaEW4eVeVRSPayf7jxxBIQigmV96BJMVR+fRUTQ=; b=aW8RSJ9qdH9yEO2/xPS/JpIkIM
	99XANSc9EM6/uGIIPmPPb2BBjt9TBtADPT0yGnzgHHkUQrnMAIa+QPiOvEvxuNk1bCgGzKIg1sLWS
	Mb/++mtryYuYwj4pEOeOtz97eXYSuxDSjPkqsjg8DtXu6zCahsH37TsHj9FAEBJvcXXo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOjB8-000000005C3-1J0j;
	Wed, 04 Nov 2026 22:09:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOjB6-000000005Bt-49m8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:09:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xN1Iwl+3ovyiCtNg6pd2niGlKGN51alKqBQEBdwtKvE=; b=UVEhk7CRpio0XPAIwtMVD5nR9O
 uFG0NYbKdE2Ye8Mc75xnaRSybdDoWQcECIg1Odkywqd+ifjRNgbBe2jD53Jde33f5rjnT8PMEkzDk
 g0Xz4WAYfPjKfca7k2FMHTipid8upK87FRKiKFFrbTjcZ3Q0F8pAEXNFlziGO9JhZZ1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xN1Iwl+3ovyiCtNg6pd2niGlKGN51alKqBQEBdwtKvE=; b=hH3BM9VWeBsiT8ye/rEwQvIasS
 jSsdpi1OjUnxhR0FaaH9P/iCI4gF39wcQICxvdq0YcJh8Z4GEc+cjYwpIZU3iOWYHdYTzPQEPO5yf
 9xjU8l6ZDiDXOCILZvjoW11MX8ucmN9KK+idU47+W85sHmqxiFNBNL9t402sEwZS6AwM=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOjB4-000000002Es-1GtG for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:09:55 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso128724f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793830188; x=1794434988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xN1Iwl+3ovyiCtNg6pd2niGlKGN51alKqBQEBdwtKvE=;
 b=JPOkJCiyXhONJyuOdP5cyK882arjKh+qq8T+vhF+mXXw8F0XoBpwtDrhGw5ulNLdUH
 dyxIUR+rnY5e7C+PqLKAeLh/o6vd3zqsdVzHqz0Nx7qCS9LuK/WIEflCpLOzgMcPi1A8
 lFOle5W/oQQFAQrMb3EzigwaVCgglj10ovxB6TNFcMvy+zUcwaE3poBbyag9/XT20+qb
 NeVZDSYiUhyP8QdSldoEDnquiHL6+noK3a8NgGqA9uUiMvlZqOKO25Lp04WlS7OdcM0h
 gXfpY/htXarznbbuofV5ioyvsF9k5gaUwPK+UWO2jSoLDK/L3MI9qCgKtArB0vn4U4rV
 5u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830188; x=1794434988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xN1Iwl+3ovyiCtNg6pd2niGlKGN51alKqBQEBdwtKvE=;
 b=RJFszi2kXMcnC4pxFd55jl2TEhTUL6l0zK++E87EIvriH+LvEeFL1BNIKhvx1TQnry
 lqjD7+mtz4SOmdGwQvh+700deZVvUpgtHLBniM3/DuJndpIU7fZzo81Nc1gGd1M3D9ll
 UsQGBfxd6GxQtdHxVf2kMPtms7pgiqRJ+RCp0bmTE/u7ql1eJdoNhGE/KNBXdNJeup+d
 WP1V8VPvoCCyS7nxUXu6ltYO6g6ETzIzgnH2IwvHq6qx4kFG8z+nm5bOdjtluk0sevKn
 4QHRrWFONA7MD3lHGVRwOdCFTLUsbyA7ySUuknMRZ0K41FjPxK9PNhvoL1knacG4O4iu
 OXEw==
X-Gm-Message-State: APuU4Z/Twa8gGOSnwlOAT+0Oqyv2A9CD970zK2hxh8qbFbjpS0CFawbw
 +XX2ucmmKy9y8kmi/WDqnD2UQtI0Cai+SPhK/K71IeP2JAr73eX8oIrjgyYsiWEsEJLPA/zSPL4
 DZTIoQLDT9xixK/PJuGFW+/F6XyomSNQKwOMBPpc+alfOIIw0+WTqajio4rJZShc18yzYpoIMPc
 4ZWzQhxA==
X-Gm-Gg: AYBFou2iX6rB6GIrtwQJb4XY+1NL3Vspdy42G2cQew3aOe8Dq9srZvfXre/c6YOsIB4
 yO/H3zpvVXxR9UkeOD2u6oLkWi5JBUI71ZwVQV4v3rJbJ/5Njc1+UZvdtVmXtXVhHetGjaOkBWE
 XF8EEx7Xt6MwUwQpMrTLaAh7LOXL3fcGGfKNJD7ldU8KoRmZ2uubrTtFj1jvr+SJ3K6po6OQXsH
 R3BfMnHu1xLRC7tqLn1qhRBKaSJJI9g2uUJJ1uIJX5u+vfN+X9pYLWBQ6XXJsrHu5ypPKlIhpkT
 /6slGvjYnfx6VzrC35GZLFeX06lkNRlVgC/Zv7HjjXKehMwF+ndA8GZIkTcT4HEfKoLHiQCzn74
 ZCbd7ERBXGfw9tkrVytXOe/07wE/LIZe3lTz6twqW8NELoZAM8uz5QfYMz8BG8UHyeheduPuMrf
 ithtBcIHPk3REaieUFiPQChiNVoZtY2QAN/mhaPtfpEYkz3I9PGbmIIPkvmv76Bzj4l0hfJaZRz
 m6U0xsqIeQzwbZr83MoI6BNdIWNgy9OYv92lZBnnsAhS2OCP6O9CNlqx+0Ef3PXbPLg5N22l8d8
 bsOsw99mmO0VwewrbDeD4CYF92JgzcHTb3+D015jSG+c+Z/1HyoMqZAM3KX6A8t8TG8nfstULwt
 L1yqkntQZol2FuFaK5SUfJg9gV9noo/u1uwrncqvLy0t3tQhkVwQNW0pcoShiMAXgYyTyDwCsRT
 8zu248XZbYUk+kEQ==
X-Received: by 2002:a05:6000:288e:b0:491:45bc:d69a with SMTP id
 ffacd0b85a97d-49145bcd7a0mr583049f8f.44.1793830187510; 
 Wed, 04 Nov 2026 14:09:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d7f7sm6372420f8f.38.2026.11.04.14.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:09:47 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:09:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 518c4cc724d42f1164cf644fb683549e6347fba4
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4fc7fd9ca691b50a146a9d20dc78b3b9d724a625-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOjB4-000000002Es-1GtG
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
Content-Type: multipart/mixed; boundary="===============0242563331859316244=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0242563331859316244==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dIT5yB1qsE8="; charset=UTF-8

--dIT5yB1qsE8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail

to look at the new patch set (#2)=2E

=
The following approvals got outdated and were removed:
Code-Review-1 by Fra=
nk Lichtenheld, Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: Adj=
ust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Adjust ACC_MAX_MSG_=
LEN, fix ACC in p2p mode and improve documentation

We do not need to limit=
 the maximum ACC message length to just 1280=2E Also
improve the comments a=
nd documentation to be clearer=2E

Fix that the management notification abo=
ut negotiated protocol is not send
when in p2p mode (or if a server has pus=
h-peer-info in its configuration)

Change-Id: I3a268fc602e916bf54853c950761=
977cf3d7f835
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/man=
agement-notes=2Etxt
M src/openvpn/acc=2Ec
M src/openvpn/acc=2Eh
M src/openv=
pn/ssl=2Ec
M tests/unit_tests/openvpn/test_acc=2Ec
5 files changed, 27 inse=
rtions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/30/2130/2

diff --git a/doc/management-notes=2Etxt b/d=
oc/management-notes=2Etxt
index 6c798c0=2E=2E73d2886 100644
--- a/doc/manag=
ement-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -1398,11 +1398,17 @@
=
     next message should be concatenated to this message to form a complete=

     message=2E
 
-    Note that the OpenVPN implementation operates here =
with the robustness
-    principle ("be conservative in what you send, be l=
iberal in what you
-    accept" - RFC 793 and others) and allows receiving =
messages longer than
-    maximum allowed message length=2E Implementations=
 should be prepared to
-    handle messages that are longer than the maximu=
m allowed message length=2E
+    Note that fragment is basically a flag for=
 allowing peers communicating
+    over ACC to indicate if multiple ACC mes=
sage should be considered to
+    be a single message=2E If the ACC protoco=
l is a stream based protocol
+    then all messages can be sent without fra=
gment flag=2E
+
+    Note that the OpenVPN implementation allows receiving =
messages longer than
+    announced maximum allowed message length=2E Imple=
mentations must be prepared
+    to handle messages that are longer than th=
e maximum allowed message length=2E
+    Overlong message are considered in=
valid and indicate that the peer is
+    misbehaving=2E Disconnecting/dropp=
ing the peer is considered a valid
+    response to such messages=2E
 
    =
 OpenVPN does not verify that the message is valid base64=2E A peer that
  =
   sends invalid base64 payload will be passed to the management interface=
=2E
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
index 455f56d=2E=
=2Ee5b6283 100644
--- a/src/openvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -1=
90,10 +190,10 @@
     }
 
     /* We do not check the length here=2E We mak=
e no promises to support
-     * anything larger than our announced message=
 length but according to
-     * the robustness principle
-     * ("be cons=
ervative in what you send, be liberal in what you accept" - RFC 793 and oth=
ers)
-     * we accept also longer messages */
+     * anything larger than=
 our announced message length but we accept also
+     * longer messages if=
 they manage to get through all the other layers
+     * that restrict the =
message size like TLS_CHANNEL_BUF_SIZE (2048)=2E
+     */
 
     int payloa=
d_len;
     const char *payload_len_str =3D buf_extract_field(&buf, ',', &g=
c);
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
index 9c99b11=2E=
=2Ea080048 100644
--- a/src/openvpn/acc=2Eh
+++ b/src/openvpn/acc=2Eh
@@ -2=
9,7 +29,9 @@
 #include "openvpn=2Eh"
 
 #define ACC_MIN_MSG_LEN 64
-#define=
 ACC_MAX_MSG_LEN 1280
+/* This is a conservative limit=2E The theoretical m=
aximum
+ * is much closer to the TLS_CHANNEL_BUF_SIZE (2048) */
+#define AC=
C_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)
 
 /**
  * This method parses an=
 app custom control message and delivers it to the
diff --git a/src/openvpn=
/ssl=2Ec b/src/openvpn/ssl=2Ec
index b701c0a=2E=2E4976646 100644
--- a/src/=
openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2396,6 +2396,12 @@
     }
 
 =
    determine_common_acc_protocols(multi, session);
+    if (multi->opt=2Em=
ode !=3D MODE_SERVER)
+    {
+        /* This is required to support ACC in=
 p2p mode or when the server
+         * sends peer-info */
+        notify=
_client_acc_protocols(multi);
+    }
 
     if (username_len < 0 || passwor=
d_len < 0)
     {
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/test=
s/unit_tests/openvpn/test_acc=2Ec
index 9364d12=2E=2Eff88362 100644
--- a/t=
ests/unit_tests/openvpn/test_acc=2Ec
+++ b/tests/unit_tests/openvpn/test_ac=
c=2Ec
@@ -181,7 +181,7 @@
     int max_len =3D 0;
     const char *protocol=
s =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
     as=
sert_string_equal(protocols, "flower:happy");
-    assert_int_equal(max_len=
, 1280);
+    assert_int_equal(max_len, 2048 - 128);
 
     /* a client doe=
s not accept a length longer than it supports */
     protocols =3D parse_a=
cc_parameters(info_acc_msg, " ", &max_len, false, &gc);
@@ -250,11 +250,11 =
@@
 
     determine_common_acc_protocols(multi, &c->c2=2Etls_multi->session=
[TM_ACTIVE]);
 
-    assert_int_equal(multi->acc_max_message_length, ACC_MA=
X_MSG_LEN);
+    assert_int_equal(multi->acc_max_message_length, 1400);
   =
  assert_string_equal(multi->acc_negotiated_protocols, "power:flower");
 
 =
    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_protocols"), "acc=
_protocols=3Dpower:flower");
-    assert_string_equal(env_set_get(multi->op=
t=2Ees, "acc_message_len"), "acc_message_len=3D1280");
+    assert_string_e=
qual(env_set_get(multi->opt=2Ees, "acc_message_len"), "acc_message_len=3D14=
00");
 
     free(multi->acc_negotiated_protocols);
     gc_free(&c->option=
s=2Egc);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/213=
0?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268=
fc602e916bf54853c950761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-Patch=
Set: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--dIT5yB1qsE8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #2</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review-1 by Frank Lichtenheld, Code-Review-1 by R=C4=83zva=
n Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and=
 improve documentation<br><br>We do not need to limit the maximum ACC messa=
ge length to just 1280=2E Also<br>improve the comments and documentation to=
 be clearer=2E<br><br>Fix that the management notification about negotiated=
 protocol is not send<br>when in p2p mode (or if a server has push-peer-inf=
o in its configuration)<br><br>Change-Id: I3a268fc602e916bf54853c950761977c=
f3d7f835<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<b=
r>M doc/management-notes=2Etxt<br>M src/openvpn/acc=2Ec<br>M src/openvpn/ac=
c=2Eh<br>M src/openvpn/ssl=2Ec<br>M tests/unit_tests/openvpn/test_acc=2Ec<b=
r>5 files changed, 27 insertions(+), 13 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/21=
30/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=
=2Etxt</span><br><span>index 6c798c0=2E=2E73d2886 100644</span><br><span>--=
- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=
=2Etxt</span><br><span>@@ -1398,11 +1398,17 @@</span><br><span>     next me=
ssage should be concatenated to this message to form a complete</span><br><=
span>     message=2E</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    Note that the OpenVPN implementation operates here wit=
h the robustness</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
rinciple (&quot;be conservative in what you send, be liberal in what you</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    accept&quot; - RFC 7=
93 and others) and allows receiving messages longer than</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    maximum allowed message length=2E Im=
plementations should be prepared to</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    handle messages that are longer than the maximum allowed =
message length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  Note that fragment is basically a flag for allowing peers communicating</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    over ACC to indic=
ate if multiple ACC message should be considered to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    be a single message=2E If the ACC pro=
tocol is a stream based protocol</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    then all messages can be sent without fragment flag=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    Note that the OpenVPN implementation =
allows receiving messages longer than</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    announced maximum allowed message length=2E Implement=
ations must be prepared</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    to handle messages that are longer than the maximum allowed message=
 length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Overl=
ong message are considered invalid and indicate that the peer is</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    misbehaving=2E Disconnecti=
ng/dropping the peer is considered a valid</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    response to such messages=2E</span><br><span> </=
span><br><span>     OpenVPN does not verify that the message is valid base6=
4=2E A peer that</span><br><span>     sends invalid base64 payload will be =
passed to the management interface=2E</span><br><span>diff --git a/src/open=
vpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index 455f56d=2E=2Ee5b628=
3 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br><span>+++ b/sr=
c/openvpn/acc=2Ec</span><br><span>@@ -190,10 +190,10 @@</span><br><span>   =
  }</span><br><span> </span><br><span>     /* We do not check the length he=
re=2E We make no promises to support</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * anything larger than our announced message length but=
 according to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * t=
he robustness principle</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * (&quot;be conservative in what you send, be liberal in what you ac=
cept&quot; - RFC 793 and others)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * we accept also longer messages */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * anything larger than our announced=
 message length but we accept also</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * longer messages if they manage to get through all the=
 other layers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 that restrict the message size like TLS_CHANNEL_BUF_SIZE (2048)=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span> </=
span><br><span>     int payload_len;</span><br><span>     const char *paylo=
ad_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br=
><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><sp=
an>index 9c99b11=2E=2Ea080048 100644</span><br><span>--- a/src/openvpn/acc=
=2Eh</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -29,7 +29=
,9 @@</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><span> </=
span><br><span> #define ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* This is a conservative limit=2E The theore=
tical maximum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is =
much closer to the TLS_CHANNEL_BUF_SIZE (2048) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE=
 - 128)</span><br><span> </span><br><span> /**</span><br><span>  * This met=
hod parses an app custom control message and delivers it to the</span><br><=
span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span=
>index b701c0a=2E=2E4976646 100644</span><br><span>--- a/src/openvpn/ssl=2E=
c</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2396,6 +239=
6,12 @@</span><br><span>     }</span><br><span> </span><br><span>     deter=
mine_common_acc_protocols(multi, session);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (multi-&gt;opt=2Emode !=3D MODE_SERVER)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* This is required to support =
ACC in p2p mode or when the server</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * sends peer-info */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        notify_client_acc_protocols(multi);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </s=
pan><br><span>     if (username_len &lt; 0 || password_len &lt; 0)</span><b=
r><span>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_a=
cc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>index 9364d1=
2=2E=2Eff88362 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_a=
cc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><b=
r><span>@@ -181,7 +181,7 @@</span><br><span>     int max_len =3D 0;</span><=
br><span>     const char *protocols =3D parse_acc_parameters(info_acc_msg, =
&quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span>     assert_st=
ring_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    assert_int_equal(max_len, 1280);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 2=
048 - 128);</span><br><span> </span><br><span>     /* a client does not acc=
ept a length longer than it supports */</span><br><span>     protocols =3D =
parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp=
;gc);</span><br><span>@@ -250,11 +250,11 @@</span><br><span> </span><br><sp=
an>     determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt=
;session[TM_ACTIVE]);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_int_equal(multi-&gt;acc_max_message_length, AC=
C_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(multi-&gt;acc_max_message_length, 1400);</span><br><span> =
    assert_string_equal(multi-&gt;acc_negotiated_protocols, &quot;power:flo=
wer&quot;);</span><br><span> </span><br><span>     assert_string_equal(env_=
set_get(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;acc_protocols=
=3Dpower:flower&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message=
_len&quot;), &quot;acc_message_len=3D1280&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_get(multi-&gt=
;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_message_len=3D1400&quot;=
);</span><br><span> </span><br><span>     free(multi-&gt;acc_negotiated_pro=
tocols);</span><br><span>     gc_free(&amp;c-&gt;options=2Egc);</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2130?usp=3Demail">change 2130</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2130 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--dIT5yB1qsE8=--


--===============0242563331859316244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0242563331859316244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0242563331859316244==--

