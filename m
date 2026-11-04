Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED86606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jUy5AnPv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qh+0Y2+B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DOeb9uLM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Iu8ahHFw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=clG3L9IyznXL8YiLZgddBRdX0wCeEIm+B3Wcqp1r3jU=; b=jUy5AnPvrSKcJL47skuTgbcTh4
	1fsWH+6YI7ThtuXsERZ9umOznoYBqAMDI6H4aE8rw71R+uCLdGcJEfi88wcphPv29+PoPHv8L/Tn/
	1zV2+mc/emDL1OA5fjFWHmFzdMmX4nf6kjJBOh/hZf6qz5Fdi4nlM0wvnsIInPOPW8uU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZpJ-000000005Kn-42ve;
	Wed, 04 Nov 2026 12:10:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOZpJ-000000005Kg-0qcL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gF+KDGfMPbOZefDSG+i30lDSBc8/KI1iIXyuuMMBLI=; b=Qh+0Y2+Bd/FN/xMQG6utVhotDW
 /WbVXUfF1pm/NMdQcUFbWKUym/gDhkNFnRf1MKuSOCeBYvLOzJxTvnr/O8heC04jTRr0yQo7VyBY4
 iVMxmwYI/lzqjk6yQYhI9t77cp72DDW+dXiR6mHUDIMh9UlwcOzWoTETJzaohcPtkgNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gF+KDGfMPbOZefDSG+i30lDSBc8/KI1iIXyuuMMBLI=; b=DOeb9uLM47YEX4tBguN3hq1loc
 Ar4MR/y13fX4+tQSLwC2IRiM6L3zAYnVyz58eC8dApTTfnfmw93nXyf/u5k1XFdmmIpgjsMzdVPpt
 L1uPpJGfuY3C3lPChSXzU5VsI6GtA1mX7MVKtZ99zwO08rxJFrEJD2TygwMfG4CusEw4=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOZpG-000000007rH-0ZSl for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:10:49 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso6215415e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793794239; x=1794399039; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9gF+KDGfMPbOZefDSG+i30lDSBc8/KI1iIXyuuMMBLI=;
 b=Iu8ahHFw452t4eZT8w1w4xp+0NeqwN/t212ZkNvJN+YFlVc06WOH0rZw2DKLOKEow+
 uQrXjDp8ni2rihVQzbchg2YCMHr2p05hmMRRVstnMLMCHdksPk/LjOCOuYJjUo77Y1iv
 rZ7Uuu7K5lmBBfLV9P7WKQcfAGGo6JCh8JScvuZtAW4tvC5Las6E4B8rQSIuO75KLEq+
 cCoIhs08DfnQUKz8nFGJ451UbZsCP3UtfGelxaE1iU3gLQwscD3ZLW5WXvreMC1D+ckh
 fUXRjjg1J/skE6dtM1mvZZYQu2Bw5pydU4rRkzlmLDL4yXbBcSNRMMDLIt7nVeVotXxu
 +r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794239; x=1794399039;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9gF+KDGfMPbOZefDSG+i30lDSBc8/KI1iIXyuuMMBLI=;
 b=Vynsg0sBIuxQGlC/ItJsHD78XU4WqHUIs5DL0DbqECfDwGjhLz3tMPd/mDLQ8LZd9u
 ckCteYXZ3GOcsDjDmUxZjqlLdSQjcaNGtexFtk6Cb4PZI+V48AZrzQLw7eLOMNi6QQO2
 nxHimjt+8eMaFcwjXCP2sEY0fKhA9+Mr67Lp+iWfV8l6EQzA6pFRLb2BL7BlfQjlMwVs
 tJKsBHp/emdQWofhmDkzpZCFIj4+vvrMn5AmTw0Gh+mzEvjw5cQZRdB4PPI/lPIaXaJo
 iNnHM054nCKS1gAnWq1KxvOzyWSJp6PLuHKmgHdOzHlZb7evfXLxOnU4viZpf0wPq+KY
 V57A==
X-Gm-Message-State: APuU4Z+RJ0R3EoPHGMOR3CKYqEuiJZ8eYQLEUzUaDOfXA7jI2/yt2kls
 2k4f4VLy/QvPpBMKFp8Mfzm4rSwNeUz85fGncVHAY3gCErm8bjhrBmrb2iPz9S4Op2uhuKmgxmP
 ZjYLxSbDvw57oTm+/qjBAf05MiR4N7/MBmc4+hG1hNb0dSZ422Gr9SVUj9CpUW3Ll6y5orFMbmU
 0I2IxSUA==
X-Gm-Gg: AYBFou0a7ZwX0xWZ2at1/vqzPnGANLbJHNKXleALb5g5HSNxwMS09Kmbi1MP7AL5K9F
 qQ86iZl0/Gtnd2/Cn8MF4jnPlfOpSgrlXIaUn7SFkyHhNlyNjlwVzt9lTOIuBIAwsoFU34txzFU
 OVxBPowEqun9C81jgkcib6FL/AOMKx8TETWqS4hdHcVNa8A6svVj+za5bSHdZoSaaKza18w1NvV
 3UkXtI4DY/3DsM0udO1ldW58j4sHdP133fB0JafWR35k+XEM4XPTUZaBEna+fYbV57Sbw7pETUI
 AIloDQI1a+dm3+y94DlxuKiISUsHh6UR8nnJdC5I4nFde+PuuVj4fXRFqHwhxMYLyuH1z6OxxmH
 0UM/NG5IkWnIY+bxs7Z9qSczPYX3t/SvIUXxXa4k4nmqwzTl3lFhvYdOY59qhMicwdclW4p0Gqk
 vzeMTGvwMpMoG4BzJam1aIck+tZHPoarnF+fYR8L1hTe4uYgQSq4BDAQUF6DV6POJxuasPF0b/x
 3P2zjK6UJLEXM55u77lTtceDD5/HoJOU1izIOhOb8gGfz5SoNcywVDBa5GDddch3XXs1bli+mq7
 /YFBImCEpPMQrPOsUqzwPM4bQmIZAzSjE6LxUSLm3K5Et6U8szPo7/KzuEf9ba+c+a+ERQA5oDi
 It5lhNMFSp7C/NsuvLBAwdxkkHkufa90iZxRz7VvMGUup/+zga9ty+LDYFZU5LP8YE/r+x/yolp
 AsCKxPZouBGwoXdg==
X-Received: by 2002:a05:600c:19d3:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4ac14fbdd29mr360198185e9.3.1793794239139; 
 Wed, 04 Nov 2026 04:10:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed0844c8sm3815434f8f.26.2026.11.04.04.10.37
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:10:37 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:10:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 4209c014003f70b1e0fd21f154d8eac8969d816d
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <402c9e80c809cabc8fcb0a70e4306de9fc114030-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOZpG-000000007rH-0ZSl
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN to be less conservative and improve documentation
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2747134391254825284=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2747134391254825284==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8/+o1lptQdg="; charset=UTF-8

--8/+o1lptQdg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2130?usp=3Demail )


Change subject: Adjust ACC_MAX_M=
SG_LEN to be less conservative and improve documentation
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Adjust ACC_MAX_MSG_LEN to be le=
ss conservative and improve documentation

We do not need to limit the maxi=
mum ACC message length to just 1280=2E Also
improve the comments and docume=
ntation to be clearer=2E

Change-Id: I3a268fc602e916bf54853c950761977cf3d7f=
835
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/management-n=
otes=2Etxt
M src/openvpn/acc=2Ec
M src/openvpn/acc=2Eh
M tests/unit_tests/o=
penvpn/test_acc=2Ec
4 files changed, 21 insertions(+), 13 deletions(-)



 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/2130/1=


diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
inde=
x 6c798c0=2E=2E73d2886 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/ma=
nagement-notes=2Etxt
@@ -1398,11 +1398,17 @@
     next message should be co=
ncatenated to this message to form a complete
     message=2E
 
-    Note t=
hat the OpenVPN implementation operates here with the robustness
-    princ=
iple ("be conservative in what you send, be liberal in what you
-    accept=
" - RFC 793 and others) and allows receiving messages longer than
-    maxi=
mum allowed message length=2E Implementations should be prepared to
-    ha=
ndle messages that are longer than the maximum allowed message length=2E
+ =
   Note that fragment is basically a flag for allowing peers communicating
=
+    over ACC to indicate if multiple ACC message should be considered to
+=
    be a single message=2E If the ACC protocol is a stream based protocol
+=
    then all messages can be sent without fragment flag=2E
+
+    Note that=
 the OpenVPN implementation allows receiving messages longer than
+    anno=
unced maximum allowed message length=2E Implementations must be prepared
+ =
   to handle messages that are longer than the maximum allowed message leng=
th=2E
+    Overlong message are considered invalid and indicate that the pe=
er is
+    misbehaving=2E Disconnecting/dropping the peer is considered a v=
alid
+    response to such messages=2E
 
     OpenVPN does not verify that =
the message is valid base64=2E A peer that
     sends invalid base64 payloa=
d will be passed to the management interface=2E
diff --git a/src/openvpn/ac=
c=2Ec b/src/openvpn/acc=2Ec
index 455f56d=2E=2Ee5b6283 100644
--- a/src/ope=
nvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -190,10 +190,10 @@
     }
 
     =
/* We do not check the length here=2E We make no promises to support
-     =
* anything larger than our announced message length but according to
-     =
* the robustness principle
-     * ("be conservative in what you send, be l=
iberal in what you accept" - RFC 793 and others)
-     * we accept also lon=
ger messages */
+     * anything larger than our announced message length b=
ut we accept also
+     * longer messages if they manage to get through all=
 the other layers
+     * that restrict the message size like TLS_CHANNEL_B=
UF_SIZE (2048)=2E
+     */
 
     int payload_len;
     const char *payload=
_len_str =3D buf_extract_field(&buf, ',', &gc);
diff --git a/src/openvpn/ac=
c=2Eh b/src/openvpn/acc=2Eh
index 9c99b11=2E=2Ea080048 100644
--- a/src/ope=
nvpn/acc=2Eh
+++ b/src/openvpn/acc=2Eh
@@ -29,7 +29,9 @@
 #include "openvpn=
=2Eh"
 
 #define ACC_MIN_MSG_LEN 64
-#define ACC_MAX_MSG_LEN 1280
+/* This =
is a conservative limit=2E The theoretical maximum
+ * is much closer to th=
e TLS_CHANNEL_BUF_SIZE (2048) */
+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_=
SIZE - 128)
 
 /**
  * This method parses an app custom control message and=
 delivers it to the
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/te=
sts/unit_tests/openvpn/test_acc=2Ec
index 9364d12=2E=2Eff88362 100644
--- a=
/tests/unit_tests/openvpn/test_acc=2Ec
+++ b/tests/unit_tests/openvpn/test_=
acc=2Ec
@@ -181,7 +181,7 @@
     int max_len =3D 0;
     const char *protoc=
ols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
     =
assert_string_equal(protocols, "flower:happy");
-    assert_int_equal(max_l=
en, 1280);
+    assert_int_equal(max_len, 2048 - 128);
 
     /* a client d=
oes not accept a length longer than it supports */
     protocols =3D parse=
_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
@@ -250,11 +250,1=
1 @@
 
     determine_common_acc_protocols(multi, &c->c2=2Etls_multi->sessi=
on[TM_ACTIVE]);
 
-    assert_int_equal(multi->acc_max_message_length, ACC_=
MAX_MSG_LEN);
+    assert_int_equal(multi->acc_max_message_length, 1400);
 =
    assert_string_equal(multi->acc_negotiated_protocols, "power:flower");
 =

     assert_string_equal(env_set_get(multi->opt=2Ees, "acc_protocols"), "a=
cc_protocols=3Dpower:flower");
-    assert_string_equal(env_set_get(multi->=
opt=2Ees, "acc_message_len"), "acc_message_len=3D1280");
+    assert_string=
_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "acc_message_len=3D=
1400");
 
     free(multi->acc_negotiated_protocols);
     gc_free(&c->opti=
ons=2Egc);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
130?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newch=
ange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268=
fc602e916bf54853c950761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-Patch=
Set: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8/+o1lptQdg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Adjust ACC_MAX_MSG_LEN to be less conservative and improve doc=
umentation<br><br>We do not need to limit the maximum ACC message length to=
 just 1280=2E Also<br>improve the comments and documentation to be clearer=
=2E<br><br>Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M doc/management-n=
otes=2Etxt<br>M src/openvpn/acc=2Ec<br>M src/openvpn/acc=2Eh<br>M tests/uni=
t_tests/openvpn/test_acc=2Ec<br>4 files changed, 21 insertions(+), 13 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/30/2130/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/doc/management-note=
s=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 6c798c0=2E=2E73d=
2886 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><spa=
n>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -1398,11 +1398,17 @@<=
/span><br><span>     next message should be concatenated to this message to=
 form a complete</span><br><span>     message=2E</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    Note that the OpenVPN impl=
ementation operates here with the robustness</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    principle (&quot;be conservative in what you sen=
d, be liberal in what you</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    accept&quot; - RFC 793 and others) and allows receiving messages lo=
nger than</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    maximum =
allowed message length=2E Implementations should be prepared to</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    handle messages that are long=
er than the maximum allowed message length=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    Note that fragment is basically a flag for al=
lowing peers communicating</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    over ACC to indicate if multiple ACC message should be considere=
d to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    be a single=
 message=2E If the ACC protocol is a stream based protocol</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    then all messages can be sent wi=
thout fragment flag=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Note that th=
e OpenVPN implementation allows receiving messages longer than</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    announced maximum allowed me=
ssage length=2E Implementations must be prepared</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    to handle messages that are longer than th=
e maximum allowed message length=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    Overlong message are considered invalid and indicate th=
at the peer is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
isbehaving=2E Disconnecting/dropping the peer is considered a valid</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    response to such messag=
es=2E</span><br><span> </span><br><span>     OpenVPN does not verify that t=
he message is valid base64=2E A peer that</span><br><span>     sends invali=
d base64 payload will be passed to the management interface=2E</span><br><s=
pan>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>=
index 455f56d=2E=2Ee5b6283 100644</span><br><span>--- a/src/openvpn/acc=2Ec=
</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -190,10 +190,=
10 @@</span><br><span>     }</span><br><span> </span><br><span>     /* We d=
o not check the length here=2E We make no promises to support</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * anything larger than our ann=
ounced message length but according to</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * the robustness principle</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * (&quot;be conservative in what you send, =
be liberal in what you accept&quot; - RFC 793 and others)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     * we accept also longer messages *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * anything la=
rger than our announced message length but we accept also</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * longer messages if they manage=
 to get through all the other layers</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * that restrict the message size like TLS_CHANNEL_BUF=
_SIZE (2048)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span> </span><br><span>     int payload_len;</span><br><span=
>     const char *payload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#3=
9;, &amp;gc);</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvp=
n/acc=2Eh</span><br><span>index 9c99b11=2E=2Ea080048 100644</span><br><span=
>--- a/src/openvpn/acc=2Eh</span><br><span>+++ b/src/openvpn/acc=2Eh</span>=
<br><span>@@ -29,7 +29,9 @@</span><br><span> #include &quot;openvpn=2Eh&quo=
t;</span><br><span> </span><br><span> #define ACC_MIN_MSG_LEN 64</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define ACC_MAX_MSG_LEN 1280</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* This is a conservati=
ve limit=2E The theoretical maximum</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * is much closer to the TLS_CHANNEL_BUF_SIZE (2048) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN=
 (TLS_CHANNEL_BUF_SIZE - 128)</span><br><span> </span><br><span> /**</span>=
<br><span>  * This method parses an app custom control message and delivers=
 it to the</span><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=
=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>index 9364d12=
=2E=2Eff88362 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ac=
c=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br=
><span>@@ -181,7 +181,7 @@</span><br><span>     int max_len =3D 0;</span><b=
r><span>     const char *protocols =3D parse_acc_parameters(info_acc_msg, &=
quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span>     assert_str=
ing_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    assert_int_equal(max_len, 1280);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 20=
48 - 128);</span><br><span> </span><br><span>     /* a client does not acce=
pt a length longer than it supports */</span><br><span>     protocols =3D p=
arse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;=
gc);</span><br><span>@@ -250,11 +250,11 @@</span><br><span> </span><br><spa=
n>     determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;=
session[TM_ACTIVE]);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_int_equal(multi-&gt;acc_max_message_length, ACC=
_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(multi-&gt;acc_max_message_length, 1400);</span><br><span>  =
   assert_string_equal(multi-&gt;acc_negotiated_protocols, &quot;power:flow=
er&quot;);</span><br><span> </span><br><span>     assert_string_equal(env_s=
et_get(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;acc_protocols=
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
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2130 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--8/+o1lptQdg=--


--===============2747134391254825284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2747134391254825284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2747134391254825284==--

