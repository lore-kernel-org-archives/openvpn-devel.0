Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AD606A332
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MRlmGkG8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aJF0U4TD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SisqFfD2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S9OO+aLC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=STKQvBnFlEMrelU5AE350u9Zq9H+07Htcr5yEjvD5Wk=; b=MRlmGkG8JSFFd0YJxrN3J+w7aI
	c8ifU6BsPlww3O0KE8/0Iq5565Vb8dRVbe1QdgDkSuHK+94yUvvWuYwtUXZHF36BOzuJdvks+C1dO
	IHTwB55niAnQpJbvmfLC9Nzl5xSaR7AkuDJVn0dQhAagG5WJ2LPabTGfPwUJv57DBPXc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOjE6-000000005Hn-2t6x;
	Wed, 04 Nov 2026 22:13:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOjE4-000000005HX-2av6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xz4gQYo8JKtogVmJua8/ryx84ffgXOuTeKaF1cS+I1A=; b=aJF0U4TDCPNlkzfQ47n1cEVdK3
 xJaNG7GVv30JeoWmIvTRMqfAkxY5BURvTs/OvKhhaT+FIrY6JuYK6/NC3HLpO0Co91v0VuSzJxkrv
 9pJKyCFR6/97qFfmjJn0L7/s9sho6s1ic/L5dn3QzUXVcfUjwt37M19826h85DY4LdY8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xz4gQYo8JKtogVmJua8/ryx84ffgXOuTeKaF1cS+I1A=; b=SisqFfD2PM1jhooa5FuEBf7V/3
 rZ/IMjCUP2LVpQxLlkN7H/IX1H648v1Znl6Kv1jByMVHWoqBAeIRIMYBVKKOousaFbcrzqqFKTf4e
 grMc5mc29/XYmoJbKUULwkVk/1uXaBBzgXq/pD0nAYPcT/xdbKQ+Ujh/vUAQtLiOWBwA=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOjE2-0000000089f-1vbl for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:13:00 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso130256f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793830372; x=1794435172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Xz4gQYo8JKtogVmJua8/ryx84ffgXOuTeKaF1cS+I1A=;
 b=S9OO+aLC/ZDBqcPHGxvnCGBZQfQnlJf8JA0xknwB8scqIctKtfX91ZbE6hGt8+hy0T
 DXmWYaS2R6yV9E8aHKzj5dUR5vQzIpSYDbyaZJt0HmAaFHsc3BU2EpcLxLLhOOHxtzNN
 559NQ3Jk9RrkUWxxb7WckR4EriM3WYnmyBe4K2y/KunwH6QtVQg5A2ZJknUcQ0jDiNJi
 akf1wF0E/45wRhn0o/0XIkt47TIfhI7+m14nM0X4FuoI0dHl1uBULrFw2H3GwpSJ2mKu
 7hynNgeDae+q+JRCA9Sz4+UnAZEp6FwPMlC7/c+LPcGW/qeJUqcdKcfVq7m7zvzr0JGD
 k19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830372; x=1794435172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Xz4gQYo8JKtogVmJua8/ryx84ffgXOuTeKaF1cS+I1A=;
 b=AcEOJ5vbHHF5ur9dZsfrku6gwqO0xtP6kGaM1BOI+3pEKPvhnuDk/bfAat307pUkaf
 TtSfeNSct+IVosuglzYK55AAl3QTL3WaMWwsM9Qf45i9Pu0kIPRf1Bazlrf4qn03+w7T
 /HSjrng/zTvADl4ZtekHw7CaF3Anm1JaeRy5LT5oO6y5dQ+psMsiLk3pof3CL4ITUD3v
 QJqSNzCTfVY0NEmk+pqRZuDEp6Cu0JcgnOGYyAhOFAJsS1xF6JMl/dWl95d02pQYMfUl
 DdEHjAVWC7PORxxuJKAfVFAxQyfBf6l9cmcM6DTYq8AnBE3t4ykIzGypsbY3BAy2a5u8
 AIGA==
X-Gm-Message-State: APuU4Z97T1yT/6HTEVkONA9mWhWOv51uTyxYk7DPfAuyt5GxclLg8YTN
 ugRMVnUHvLvu/5exmY4oMp/FFa8slcVyeCl1fXgtDTxFvqLKtxv/Ecp43Lmw5m/0K+MGS7CFgDt
 g2Ny7p3K4GbgKbMzExchMqRwlrnGKnWH0GlNHKgk7g68N33Rggd+L2JpxGPJxK/8K42jsTvdtMY
 X0OBZMPw==
X-Gm-Gg: AYBFou0f2qVtT13ker0+g3mgUvWJ8GlQ8r/IA9/ZsDzy+DCGuDWRassVqrL9NRpVz6d
 duh6DmAaZKtR07hsJANOvtP64rTSMRx6jUt4jJL0w6lEH+e71m5HUKJV46yVY6qBXiVcuQEOYfH
 0GlVjfTvj1HvAkWlEWUD97lMztve8KfpIDjn6Nav8t5GkSdFy5Yk0DASTRdYnZwGzR3JDUdTVow
 TaLWCiWFmzMcHwuG45VcUkL/0tJLjU0EgkIA6zQljdC7y/27pFUBBkWVgUp62p4xU9J/YbinHKo
 Lbz2KQgL/VMY8mSTBGCtBjqvTaMQMAf/ZMrIcryCJFhxxOmHrJlPLp+JNwyZ/7Rw1SkLhFOgzMm
 JMaf3l2vXopMh6UGhJ/zfDYf58IcGcwr8IYvhENq91eL5aXQ/WJb0IfB478zjEvJ9Q/Iv8E6y96
 +HXua1HWZi/pkSh8MlAf+DPRFYlNuuekDA5NPn/o6r9rLaIJCJc2s6GOmDv8PnyCOFXm4zTOzZo
 WDxXjl9E+0pLtaC2c2SVu2ra93UZRqlVFY/IXg57ycXSt98hIjVajSBeaqxzYoARJ6VRCdZPQs7
 ulO5rDGbByj5+8cdCIUFtFH5u2f0Ed8QkV4ZQ9OkiWOxXNiq3fUL5GOTGVgM2CXmejpj2a4uomT
 HBEHQZl378t6TkZiaSQPSHUzDqOeUDLQqptXwTs17RRgFa9s2k+GL6nP86JvONaa6auZSqMRTf5
 3SaOZ4qFYzyCNEXg==
X-Received: by 2002:a05:6000:4b08:b0:48e:7508:bc20 with SMTP id
 ffacd0b85a97d-48e7508be83mr32565406f8f.2.1793830371613; 
 Wed, 04 Nov 2026 14:12:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed5538basm5814327f8f.44.2026.11.04.14.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:12:51 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:12:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 4789b833c6308269796058871518caef61e2f1b5
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d75db7c464e4326b75cd962610341c7c574aef8e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOjE2-0000000089f-1vbl
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
Content-Type: multipart/mixed; boundary="===============5018279538198492100=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5018279538198492100==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dseJbbXUfSs="; charset=UTF-8

--dseJbbXUfSs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail

to look at the new patch set (#3)=2E

=

Change subject: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve do=
cumentation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

A=
djust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation

We do=
 not need to limit the maximum ACC message length to just 1280=2E Also
impr=
ove the comments and documentation to be clearer=2E

Fix that the managemen=
t notification about negotiated protocol is not send
when in p2p mode (or i=
f a server has push-peer-info in its configuration)

Change-Id: I3a268fc602=
e916bf54853c950761977cf3d7f835
Signed-off-by: Arne Schwabe <arne@rfc2549=2E=
org>
---
M doc/management-notes=2Etxt
M src/openvpn/acc=2Ec
M src/openvpn/a=
cc=2Eh
M src/openvpn/ssl=2Ec
M tests/unit_tests/openvpn/test_acc=2Ec
5 file=
s changed, 31 insertions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/30/2130/3

diff --git a/doc/manageme=
nt-notes=2Etxt b/doc/management-notes=2Etxt
index 6c798c0=2E=2Ea98b45f 1006=
44
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -13=
98,11 +1398,17 @@
     next message should be concatenated to this message =
to form a complete
     message=2E
 
-    Note that the OpenVPN implementat=
ion operates here with the robustness
-    principle ("be conservative in w=
hat you send, be liberal in what you
-    accept" - RFC 793 and others) and=
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
index 455f56d=2E=2E7b04821 100644
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
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
i=
ndex 9c99b11=2E=2Ed640898 100644
--- a/src/openvpn/acc=2Eh
+++ b/src/openvp=
n/acc=2Eh
@@ -29,7 +29,9 @@
 #include "openvpn=2Eh"
 
 #define ACC_MIN_MSG_=
LEN 64
-#define ACC_MAX_MSG_LEN 1280
+/* This is a conservative limit=2E Th=
e theoretical maximum
+ * is much closer to the TLS_CHANNEL_BUF_SIZE */
+#d=
efine ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)
 
 /**
  * This method p=
arses an app custom control message and delivers it to the
diff --git a/src=
/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index b701c0a=2E=2E4976646 100644
--=
- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2396,6 +2396,12 @@
  =
   }
 
     determine_common_acc_protocols(multi, session);
+    if (multi-=
>opt=2Emode !=3D MODE_SERVER)
+    {
+        /* This is required to suppor=
t ACC in p2p mode or when the server
+         * sends peer-info */
+      =
  notify_client_acc_protocols(multi);
+    }
 
     if (username_len < 0 ||=
 password_len < 0)
     {
diff --git a/tests/unit_tests/openvpn/test_acc=2E=
c b/tests/unit_tests/openvpn/test_acc=2Ec
index 9364d12=2E=2E45fd349 100644=

--- a/tests/unit_tests/openvpn/test_acc=2Ec
+++ b/tests/unit_tests/openvpn=
/test_acc=2Ec
@@ -181,7 +181,11 @@
     int max_len =3D 0;
     const char =
*protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc)=
;
     assert_string_equal(protocols, "flower:happy");
-    assert_int_equa=
l(max_len, 1280);
+
+    /* Check that the ACC_MAX_MSG_LEN is 2048 to ensur=
e that the tests get
+     * adjusted if it changes */
+    assert_int_equa=
l(ACC_MAX_MSG_LEN, 2048);
+    assert_int_equal(max_len, ACC_MAX_MSG_LEN - =
128);
 
     /* a client does not accept a length longer than it supports *=
/
     protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, fals=
e, &gc);
@@ -250,11 +254,11 @@
 
     determine_common_acc_protocols(multi,=
 &c->c2=2Etls_multi->session[TM_ACTIVE]);
 
-    assert_int_equal(multi->ac=
c_max_message_length, ACC_MAX_MSG_LEN);
+    assert_int_equal(multi->acc_ma=
x_message_length, 1400);
     assert_string_equal(multi->acc_negotiated_pro=
tocols, "power:flower");
 
     assert_string_equal(env_set_get(multi->opt=
=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");
-    assert_strin=
g_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "acc_message_len=
=3D1280");
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_messa=
ge_len"), "acc_message_len=3D1400");
 
     free(multi->acc_negotiated_prot=
ocols);
     gc_free(&c->options=2Egc);

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Gerrit-=
Change-Number: 2130
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>

--dseJbbXUfSs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #3</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=
=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">Adjust ACC_MAX_MSG_LEN, fix ACC =
in p2p mode and improve documentation<br><br>We do not need to limit the ma=
ximum ACC message length to just 1280=2E Also<br>improve the comments and d=
ocumentation to be clearer=2E<br><br>Fix that the management notification a=
bout negotiated protocol is not send<br>when in p2p mode (or if a server ha=
s push-peer-info in its configuration)<br><br>Change-Id: I3a268fc602e916bf5=
4853c950761977cf3d7f835<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>---<br>M doc/management-notes=2Etxt<br>M src/openvpn/acc=2Ec<br>M=
 src/openvpn/acc=2Eh<br>M src/openvpn/ssl=2Ec<br>M tests/unit_tests/openvpn=
/test_acc=2Ec<br>5 files changed, 31 insertions(+), 13 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/30/2130/3</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/m=
anagement-notes=2Etxt</span><br><span>index 6c798c0=2E=2Ea98b45f 100644</sp=
an><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/man=
agement-notes=2Etxt</span><br><span>@@ -1398,11 +1398,17 @@</span><br><span=
>     next message should be concatenated to this message to form a complet=
e</span><br><span>     message=2E</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    Note that the OpenVPN implementation op=
erates here with the robustness</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    principle (&quot;be conservative in what you send, be liberal=
 in what you</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    accep=
t&quot; - RFC 793 and others) and allows receiving messages longer than</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    maximum allowed messa=
ge length=2E Implementations should be prepared to</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    handle messages that are longer than the m=
aximum allowed message length=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    Note that fragment is basically a flag for allowing peers =
communicating</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ov=
er ACC to indicate if multiple ACC messages should be considered to</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    be a single message=2E =
If the ACC protocol is a stream based protocol</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    then all messages can be sent without fragme=
nt flag=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    Note that the OpenVPN im=
plementation allows receiving messages longer than</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    announced maximum allowed message length=
=2E Implementations must be prepared</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    to handle messages that are longer than the maximum al=
lowed message length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    Overlong messages are considered invalid and indicate that the peer=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    misbehaving=
=2E Disconnecting/dropping the peer is considered a valid</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    response to such messages=2E</spa=
n><br><span> </span><br><span>     OpenVPN does not verify that the message=
 is valid base64=2E A peer that</span><br><span>     sends invalid base64 p=
ayload will be passed to the management interface=2E</span><br><span>diff -=
-git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index 455f=
56d=2E=2E7b04821 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br=
><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -190,10 +190,10 @@</spa=
n><br><span>     }</span><br><span> </span><br><span>     /* We do not chec=
k the length here=2E We make no promises to support</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * anything larger than our announced m=
essage length but according to</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     * the robustness principle</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * (&quot;be conservative in what you send, be liber=
al in what you accept&quot; - RFC 793 and others)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * we accept also longer messages */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * anything larger tha=
n our announced message length but we accept also</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * longer messages if they manage to get =
through all the other layers</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * that restrict the message size like TLS_CHANNEL_BUF_SIZE=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><=
span> </span><br><span>     int payload_len;</span><br><span>     const cha=
r *payload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</=
span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span=
><br><span>index 9c99b11=2E=2Ed640898 100644</span><br><span>--- a/src/open=
vpn/acc=2Eh</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -2=
9,7 +29,9 @@</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><s=
pan> </span><br><span> #define ACC_MIN_MSG_LEN 64</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define ACC_MAX_MSG_LEN 1280</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* This is a conservative limit=2E The=
 theoretical maximum</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * is much closer to the TLS_CHANNEL_BUF_SIZE */</span><br><span style=3D"=
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
2=2E=2E45fd349 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_a=
cc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><b=
r><span>@@ -181,7 +181,11 @@</span><br><span>     int max_len =3D 0;</span>=
<br><span>     const char *protocols =3D parse_acc_parameters(info_acc_msg,=
 &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span>     assert_s=
tring_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_int_equal(max_len, 1280);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Check that the ACC_MAX_MSG_LEN is 2048 to =
ensure that the tests get</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * adjusted if it changes */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ACC_MAX_MSG_LEN, 2048);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, A=
CC_MAX_MSG_LEN - 128);</span><br><span> </span><br><span>     /* a client d=
oes not accept a length longer than it supports */</span><br><span>     pro=
tocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, =
false, &amp;gc);</span><br><span>@@ -250,11 +254,11 @@</span><br><span> </s=
pan><br><span>     determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etl=
s_multi-&gt;session[TM_ACTIVE]);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_int_equal(multi-&gt;acc_max_message=
_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(multi-&gt;acc_max_message_length, 1400);</span>=
<br><span>     assert_string_equal(multi-&gt;acc_negotiated_protocols, &quo=
t;power:flower&quot;);</span><br><span> </span><br><span>     assert_string=
_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;ac=
c_protocols=3Dpower:flower&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;=
acc_message_len&quot;), &quot;acc_message_len=3D1280&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_ge=
t(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_message_len=
=3D1400&quot;);</span><br><span> </span><br><span>     free(multi-&gt;acc_n=
egotiated_protocols);</span><br><span>     gc_free(&amp;c-&gt;options=2Egc)=
;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2130?usp=3Demail">change 2130</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c9507619=
77cf3d7f835 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2130 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--dseJbbXUfSs=--


--===============5018279538198492100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5018279538198492100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5018279538198492100==--

