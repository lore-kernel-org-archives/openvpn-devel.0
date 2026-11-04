Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E10E60A262D
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fn8kF93V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aMgYI227;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cW9S3Sik;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FT3FyQ7V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aNyqC6k1VyTmfQ51+3icdlzzeLBRq6wWg2z2NVK0Pvc=; b=Fn8kF93VwKtGtcwuaW5ibqslkz
	XGBhE12rda+3vO2/wCe2hj038rDde1FFc2lM4ZlN3W0wVYyoD8iuFbj5I6tbB/StjW5PebuTSauPD
	hau39e2Zkjwz05dCmVEaKLyKm3iujab86157uHuvEpPKSsovj91Y/SV3GHs8/7hQqJWg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOd4j-000000007Vt-2HHf;
	Wed, 04 Nov 2026 15:38:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOd4R-000000007UW-08rU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yFedkFHgg22Ob0zTL7m3VZxhN9/95hH4dy2MceLJC1M=; b=aMgYI227AauJjH7g13Cwjqu7nK
 qSHsEb3TIaoLW+Rl//euJGkEg0r5932+8zcLps8qq+a5H+DbiwcHBLM30CBGJVptMbNJ8TRTXNcaw
 xwsW9ZvJgolSSXjKhbGidRlO30QTWBCjBuZnieZRLnb8quFDZFYJ7wkRWp0j2ZS2COSo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yFedkFHgg22Ob0zTL7m3VZxhN9/95hH4dy2MceLJC1M=; b=cW9S3SiksAaadUCmr7s4wrSfOt
 KXlW7Z469nRxS+h6jOcuqLl7rxCKVOLyalKOMJQB7/TXpUqceBKSuM8kKAcHhmVV7Nsj+yoYROI7a
 WI95pD5sQjkCC6eWfob4iIvX2N/ZM4LyJGTyI53qu3WPmxVQG3CkVBnyzUT7yokYSB4c=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOd4J-000000007Ty-4Amz for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:38:38 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so7297025e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793806705; x=1794411505; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yFedkFHgg22Ob0zTL7m3VZxhN9/95hH4dy2MceLJC1M=;
 b=FT3FyQ7VZ3r8LRVgeFpew6aYABdfpgR/OY9i5n+8jF7ylnBxsH/Pun+Nk0gwrC5tH+
 2HwWHQXXWfMSJtP1ykRpkAyMmTfmaR6pBECu8oxMIfJIFiRjWcELfhymuj7PcOzHjb7e
 q5IbJ8pX5pfySnHL7exMb2GrRQTzfjLyu5VDZGMR6oD+SZOgPkpm2mkvowR25RvJkCQS
 cu5rAchKVaYcgH9xQuJ/KGlC7N85w4Oe9Q4bdjZWYW8mOW06NFVkI/DLeiRGIsvcbzYC
 lE/39B+KPDlJNcspzLe8iTvPW0YWhXiQC4Dc74N1wr1nXchooJy8olzCI1gvvkibvmFz
 LMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793806705; x=1794411505;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yFedkFHgg22Ob0zTL7m3VZxhN9/95hH4dy2MceLJC1M=;
 b=JKXtu4yzcV76hFIjOH9cAcNHezqz9IT4QnccyuJ1H8TxDswbyi76WVzypeE5l01ZFD
 eaOjsdgpHM5DedZTS6n43aonvZZugUPrKn+Ev3kAY2MAaebfLlLZuR9lxeiO2sDPij5Y
 vYAlBQukM4y5sddFnfY/E+yGkRWHMWkaLQ3+5fXtuFedBqXMfJqZsGiUXtKFltlFjHwr
 t042RbDWwShrsOIZwc6AfFZjwgTrIzo0ln2PTzGrJ2uX7A3eAX3rAUZPnHeijOPGEMmL
 v25ejln361oCs8VWkQuEX+wbFb2DLsSqCV/fZkEK4kLoVNEguFA7BSPsEuBkFSsFuQcl
 p8Fw==
X-Gm-Message-State: APuU4Z8k89zJ6GOPaai1a+M/cPp9/seo4pwAE8AnivDodjzq8leSBzUU
 kOn3DqhCO6zOpVLo4jS6S+/cxvCmoCxaBF7PWfiD9LC/xg1DC71jPjV92/OG/Fi3tF92QBL2zsw
 z+7UFU3rUiuWGhM8IB1SBXFtrzg5PpzQ2VnEDuy/7BoJRKqXInqc8ZTwy/9UhapjN/6CFN9kJSW
 10RfijuA==
X-Gm-Gg: AYBFou0M/5ADjKeq8+PuDddOG4NOdfFk9zUHJWV464WDz0nY3ckaCD/YzWc8hSI+W29
 klhQLpcm7RkfJe+PMRJczQtZBtiHkyIFsEhn+G9fRmOIBR2BdPgsf9xmIJUq4RcGj1R+clzIJ5y
 yHOr290ll/0r24gSXMvPWFCCZ+ki4MQ0OIXZaeYK6/6RoQPuu8UPNABKEAnI+CIXEM369KA87dw
 yDV06/UgNvbEdSZjdg1zYqn/arP5VNfbJNIbF3KG/qvFHX2MfwKV871Nuj4xJGvp6g4fWhh5G9n
 gRyKW2I1HOxKKPAvEvm1GXMyWoIpTojjp+F+yldNQUvOrTm9FoCvlOF/JqGTBXq71TDsZatjQ98
 rxuEhoZoRBMjpwpIWC/zw36fGmdlAS3DOB7aJw9+8TNBzMy5GVMrjixX/MevPfC1VYV/U2IZWf8
 5CAMR8W10lEU21BA8cXwSuUyborGEh+tlgwqv+2L5G4v1NivK5XiXRw1YMQdX9Xu/RJviikQF04
 o0m/wyKUCfwRQvzdWyvzYs80lnIHrmfNUfoUuE6W5w7Dtx4OVHWHigUkAN7sMuFRaEOE3EEGYlC
 9hWAmr+JCWMU/gvCYL2NkGNIaBdCaC7CGrhB5Q8IwBU0PYkuSWdfdpxKreyzWHPSS9SyaW3T0+x
 txIwopMvGYabgc3Onv+/9JLI+vHrrWInx3RcjHVchb3L4QXjf2BHyVvRDtXUpQN5O72SfiJFB7O
 3EjIfLceUxxogajjxhoau6vWv5DxtydKze+HE=
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4ac14ec873emr362922845e9.4.1793806704926; 
 Wed, 04 Nov 2026 07:38:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm89848665e9.5.2026.11.04.07.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:38:24 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:38:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: de5de87aafd7ad3390d7c748f79a37cf6dd6eb24
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bf87ca75f684ba8565a171dd88271454943deb9d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOd4J-000000007Ty-4Amz
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8879916983321966039=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8879916983321966039==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3mFLsEhgLtE="; charset=UTF-8

--3mFLsEhgLtE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, R=
=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

=
    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail

to look at=
 the new patch set (#4)=2E

The following approvals got outdated and were r=
emoved:
Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: control_msg=
: Add a shared TLV codec and use it for early negotiation
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_msg: Add a shared TL=
V codec and use it for early negotiation

Early negotiation in the reset pa=
ckets is a sequence of TLVs, and
planned out-of-band and control data messa=
ges will use the same TLV
format and type space=2E Add one TLV codec for al=
l of them,
control_msg=2Ec/h, and move early negotiation onto it=2E

The co=
dec only handles the framing: reading and writing TLV headers,
writing a 16=
-bit TLV, and walking a payload TLV by TLV with each value
checked against =
the payload=2E How to treat an unknown type is up to each
message=2E

The c=
odec splits the top bit of the type field off as the "optional"
flag, which=
 the previous early negotiation parser did not do=2E The flags
TLV is defin=
ed with that bit clear, so the parser only accepts it when
the bit is clear=
 and skips the type word 0x8001 as unknown exactly as
before=2E No function=
al change=2E

Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Signed-o=
ff-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvp=
n/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A src/openvpn/control_msg=2Eh=

M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
=
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_co=
ntrol_msg=2Ec
A tests/unit_tests/openvpn/test_control_msg=2Eh
M tests/unit_=
tests/openvpn/test_pkt=2Ec
11 files changed, 481 insertions(+), 23 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/6=
5/1965/4

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 5cf1a30=2E=
=2E305c26c 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -457,6 +=
457,8 @@
     src/openvpn/console=2Ec
     src/openvpn/console_builtin=2Ec
=
     src/openvpn/console=2Eh
+    src/openvpn/control_msg=2Ec
+    src/open=
vpn/control_msg=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh=

     src/openvpn/crypto_backend=2Eh
@@ -896,6 +898,8 @@
 
     target_sour=
ces(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_execve=2E=
c
+        tests/unit_tests/openvpn/test_control_msg=2Ec
+        src/openv=
pn/control_msg=2Ec
         src/openvpn/argv=2Ec
         src/openvpn/base6=
4=2Ec
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefi=
le=2Eam b/src/openvpn/Makefile=2Eam
index bb31053=2E=2Ebe1044d 100644
--- a=
/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -57,6 +57,7 @=
@
 	common=2Eh \
 	comp=2Ec comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=
=2Eh \
+	control_msg=2Ec control_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_b=
ackend=2Eh \
 	crypto_openssl=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls=2Ec=
 crypto_mbedtls=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvp=
n/control_msg=2Ec
new file mode 100644
index 0000000=2E=2Ee3e4b17
--- /dev/=
null
+++ b/src/openvpn/control_msg=2Ec
@@ -0,0 +1,85 @@
+/*
+ *  OpenVPN --=
 An application to securely tunnel IP networks
+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based
+ *             session auth=
entication and key exchange,
+ *             packet encryption, packet auth=
entication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C=
) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free=
 software; you can redistribute it and/or modify
+ *  it under the terms of=
 the GNU General Public License version 2
+ *  as published by the Free Sof=
tware Foundation=2E
+ *
+ *  This program is distributed in the hope that i=
t will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied w=
arranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the
+ *  GNU General Public License for more details=2E
+ *
+ *  You shoul=
d have received a copy of the GNU General Public License along
+ *  with th=
is program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifd=
ef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+=

+#include "control_msg=2Eh"
+
+bool
+ctrl_msg_tlv_write_header(struct buff=
er *buf, uint16_t type, bool optional, uint16_t value_len)
+{
+    /* the t=
ype has 15 bits; the top bit is the optional flag */
+    ASSERT(type <=3D =
CTRL_MSG_TLV_TYPE_MASK);
+    uint16_t field =3D type;
+    if (optional)
+=
    {
+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return bu=
f_write_u16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_=
msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16_=
t value)
+{
+    return ctrl_msg_tlv_write_header(buf, type, optional, size=
of(uint16_t))
+           && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_ms=
g_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+=
    int field =3D buf_read_u16(buf);
+    if (field < 0)
+    {
+        re=
turn false;
+    }
+    int len =3D buf_read_u16(buf);
+    if (len < 0)
+ =
   {
+        return false;
+    }
+    hdr->type =3D (uint16_t)(field & CT=
RL_MSG_TLV_TYPE_MASK);
+    hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONA=
L_FLAG) !=3D 0;
+    hdr->value_len =3D (uint16_t)len;
+    return true;
+}=

+
+bool
+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header =
*hdr, struct buffer *value)
+{
+    if (!ctrl_msg_tlv_read_header(buf, hdr)=
)
+    {
+        return false; /* fewer than 4 bytes left: truncated heade=
r */
+    }
+    /* Advance past the value; fails if buf is shorter than th=
e header claims=2E */
+    const uint8_t *v =3D buf_read_alloc(buf, hdr->va=
lue_len);
+    if (!v)
+    {
+        return false;
+    }
+    buf_set_re=
ad(value, v, hdr->value_len);
+    return true;
+}
diff --git a/src/openvpn=
/control_msg=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
index 0=
000000=2E=2E56c1590
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0=
 +1,100 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single TCP/UDP port, with support for SSL/TLS-base=
d
+ *             session authentication and key exchange,
+ *             =
packet encryption, packet authentication, and
+ *             packet compre=
ssion=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>=

+ *
+ *  This program is free software; you can redistribute it and/or mod=
ify
+ *  it under the terms of the GNU General Public License version 2
+ *=
  as published by the Free Software Foundation=2E
+ *
+ *  This program is =
distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more=
 details=2E
+ *
+ *  You should have received a copy of the GNU General Pub=
lic License along
+ *  with this program; if not, see <https://www=2Egnu=2E=
org/licenses/>=2E
+ */
+
+/**
+ * @file
+ * TLV framing shared by the TLV-b=
ased control messages of the wire protocol=2E
+ *
+ * Such a message payloa=
d is a sequence of TLV entries=2E Each TLV starts with a
+ * 4-byte header:=
 a 16-bit field whose most significant bit is the "optional"
+ * flag and w=
hose remaining 15 bits are the type, followed by a 16-bit length
+ * giving=
 the size of the value that follows the header=2E
+ *
+ * All of these mess=
ages share one TLV type space, so the TLV types are all
+ * defined here=2E=
 Only the framing is handled here: what a message does with a
+ * TLV type =
it does not know, marked optional or not, is up to its parser=2E
+ */
+
+#i=
fndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* T=
LV types */
+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, =
in the reset packets */
+
+/* TLV header bit layout of the first 16-bit fie=
ld */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE=
_MASK     0x7fff
+
+/** The header every TLV carries: the 15-bit type and o=
ptional flag packed into
+ * the first 16-bit field, then the length of the=
 value that follows=2E */
+struct ctrl_msg_tlv_header
+{
+    uint16_t type=
;      /**< the 15-bit TLV type */
+    bool optional;      /**< value of t=
he optional flag */
+    uint16_t value_len; /**< length of the value follo=
wing the header */
+};
+
+/**
+ * Write a TLV header (type + optional flag =
+ value length) to buf=2E
+ * type must fit in the 15 bits of the type fiel=
d=2E
+ *
+ * @return true on success, false if buf has insufficient space=
=2E
+ */
+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type,=
 bool optional,
+                               uint16_t value_len);
+
+/**=

+ * Write a complete TLV whose value is a single 16-bit integer to buf=2E
=
+ *
+ * @return true on success, false if buf has insufficient space=2E
+ *=
/
+bool ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool opti=
onal, uint16_t value);
+
+/**
+ * Read a TLV header from buf, advancing pas=
t it=2E
+ *
+ * @param buf  buffer positioned at the TLV header
+ * @param =
hdr  filled with the type, optional flag and value length on success
+ * @r=
eturn true on success, false if there are not enough bytes for a header=2E
=
+ */
+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv=
_header *hdr);
+
+/**
+ * Read the next TLV from buf, advancing past its he=
ader and value=2E Call it
+ * while BLEN(buf) > 0 to walk a whole payload=
=2E
+ *
+ * The length from the header is validated against buf, so on succ=
ess the
+ * whole value is present: a header claiming more bytes than buf h=
olds is
+ * rejected=2E
+ *
+ * @param buf    buffer positioned at a TLV he=
ader
+ * @param hdr    filled with the TLV's type, optional flag and value =
length
+ * @param value  set to a buffer covering exactly the TLV's value; =
it points
+ *               into buf and owns no storage
+ * @return true o=
n success, false if the header or the value is truncated; buf
+ *         m=
ay then be left partly consumed=2E
+ */
+bool ctrl_msg_tlv_next(struct buff=
er *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);
+
+#endif =
/* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/s=
sl=2Ec
index 12b6119=2E=2Ee531613 100644
--- a/src/openvpn/ssl=2Ec
+++ b/sr=
c/openvpn/ssl=2Ec
@@ -52,6 +52,7 @@
 #include "pkcs11=2Eh"
 #include "route=
=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 #include "cr=
ypto_epoch=2Eh"
 #include "ssl=2Eh"
@@ -2645,26 +2646,28 @@
 {
     while (=
buf->len > 0)
     {
-        if (buf_len(buf) < 4)
-        {
-           =
 goto error;
-        }
-        /* read type */
-        int type =3D buf_=
read_u16(buf);
-        int len =3D buf_read_u16(buf);
-        if (type < =
0 || len < 0 || buf_len(buf) < len)
+        struct ctrl_msg_tlv_header hdr=
;
+        struct buffer value;
+        if (!ctrl_msg_tlv_next(buf, &hdr, =
&value))
         {
             goto error;
         }
 
-        switch (=
type)
+        switch (hdr=2Etype)
         {
             case TLV_TYPE_EA=
RLY_NEG_FLAGS:
-                if (len !=3D sizeof(uint16_t))
+           =
     /* This TLV is defined with the optional bit clear=2E A type
+        =
         * word that has the bit set is not this TLV, so skip it as
+      =
           * an unknown type rather than parsing it as the flags=2E */
+   =
             if (hdr=2Eoptional)
+                {
+                    br=
eak;
+                }
+                if (BLEN(&value) !=3D sizeof(uint1=
6_t))
                 {
                     goto error;
                 =
}
-                int flags =3D buf_read_u16(buf);
+                int fl=
ags =3D buf_read_u16(&value);
 
                 if (flags & EARLY_NEG_FLAG=
_RESEND_WKC)
                 {
@@ -2683,8 +2686,8 @@
                 brea=
k;
 
             default:
-                /* Skip types we do not parse *=
/
-                buf_advance(buf, len);
+                /* Skip types we=
 do not parse, marked optional or not */
+                break;
         }=

     }
     reliable_mark_deleted(ks->rec_reliable, buf);
diff --git a/src=
/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index f78782f=2E=2Ef4564ef 1=
00644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -33,6 =
+33,7 @@
 #include "reliable=2Eh"
 #include "siphash=2Eh"
 #include "tls_cr=
ypt=2Eh"
+#include "control_msg=2Eh"
 
 /*
  * Dependent on hmac size, opco=
de size, and session_id size=2E
@@ -432,9 +433,8 @@
     /* Add indication =
for tls-crypt-v2 to resend the WKc with the reply */
     if (request_resen=
d_wkc)
     {
-        buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TY=
PE: flags */
-        buf_write_u16(&buf, sizeof(uint16_t));
-        buf_w=
rite_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
+        ASSERT(ctrl_msg_tlv_wri=
te_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                            =
          EARLY_NEG_FLAG_RESEND_WKC));
     }
 
     /* Add tls-auth/tls-cr=
ypt wrapping, this might replace buf with
diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh
index 8203e4a=2E=2E218c6bb 100644
--- a/src/=
openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -306,10 +306,8 @@
 #de=
fine EARLY_NEG_START 0x0f000000
 
 
-/* Early negotiation that part of the =
server response in the RESET_V2 packet=2E
- * Since clients that announce e=
arly negotiation support will treat the payload
- * of reset packets specia=
l and parse it as TLV messages=2E
- * as TLV (type, length, value) */
-#def=
ine TLV_TYPE_EARLY_NEG_FLAGS  0x0001
+/* Early negotiation: clients that an=
nounce support for it parse the payload of
+ * the reset packets as TLVs (s=
ee control_msg=2Eh)=2E Flags carried in the value of
+ * the TLV_TYPE_EARLY=
_NEG_FLAGS TLV: */
 #define EARLY_NEG_FLAG_RESEND_WKC 0x0001
 #endif /* ifn=
def SSL_PKT_H */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam
index 70cf7b2=2E=2E11f92f4 100644
--- a/=
tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makef=
ile=2Eam
@@ -164,11 +164,15 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/sr=
c/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFL=
AGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2E=
c mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \
+pkt_testdriver_SOUR=
CES =3D test_pkt=2Ec \
+	test_control_msg=2Ec test_control_msg=2Eh \
+	mock=
_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	test_common=2Eh \
 	$(top_s=
rcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec=
 \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buf=
fer=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=2Ec \
 	$(top_srcdir)/src=
/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(to=
p_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/op=
envpn/test_control_msg=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec
=
new file mode 100644
index 0000000=2E=2E7e6ed06
--- /dev/null
+++ b/tests/u=
nit_tests/openvpn/test_control_msg=2Ec
@@ -0,0 +1,177 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is fre=
e software; you can redistribute it and/or modify
+ *  it under the terms o=
f the GNU General Public License version 2
+ *  as published by the Free So=
ftware Foundation=2E
+ *
+ *  This program is distributed in the hope that =
it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the
+ *  GNU General Public License for more details=2E
+ *
+ *  You shou=
ld have received a copy of the GNU General Public License along
+ *  with t=
his program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#if=
def HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
=
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#in=
clude <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include "ssl_pkt=2Eh"
+#=
include "test_common=2Eh"
+#include "test_control_msg=2Eh"
+
+/* The early =
negotiation flags TLV of a reset packet asking a tls-crypt-v2
+ * client to=
 resend its WKc, as older versions wrote it by hand=2E */
+void
+test_tlv_w=
rite_u16_wire_format(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_=
msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                 =
                      EARLY_NEG_FLAG_RESEND_WKC));
+    const uint8_t expec=
ted[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLE=
N(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, =
sizeof(expected));
+
+    /* the optional flag is the most significant bit =
of the type field */
+    buf_clear(&buf);
+    assert_true(ctrl_msg_tlv_wr=
ite_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+    assert_int_equal(BP=
TR(&buf)[0], 0x80);
+    assert_int_equal(BPTR(&buf)[1], 0x01);
+
+    gc_f=
ree(&gc);
+}
+
+/* A TLV header survives the round trip, the optional flag =
kept apart from
+ * the 15-bit type=2E */
+void
+test_tlv_header_roundtrip(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer b=
uf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(=
&buf, 0x1234, true, 5));
+    assert_int_equal(BLEN(&buf), 4);
+
+    struc=
t ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_header(&buf, =
&hdr));
+    assert_int_equal(hdr=2Etype, 0x1234);
+    assert_true(hdr=2Eo=
ptional);
+    assert_int_equal(hdr=2Evalue_len, 5);
+    assert_int_equal(=
BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Walking a payload returns eac=
h TLV in turn, with a value covering exactly
+ * its bytes, and consumes th=
e payload=2E */
+void
+test_tlv_next_walks_payload(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(64, =
&gc);
+
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FL=
AGS, false, 0xabcd));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7f=
f, true, 4));
+    assert_true(buf_write_u32(&buf, 0x11223344));
+    asser=
t_true(ctrl_msg_tlv_write_header(&buf, 0x5, false, 0)); /* empty value */
+=

+    struct ctrl_msg_tlv_header hdr;
+    struct buffer value;
+
+    asse=
rt_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=
=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_false(hdr=2Eoptional);
+   =
 assert_int_equal(BLEN(&value), 2);
+    assert_int_equal(buf_read_u16(&val=
ue), 0xabcd);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+ =
   assert_int_equal(hdr=2Etype, 0x7ff);
+    assert_true(hdr=2Eoptional);
+=
    assert_int_equal(BLEN(&value), 4);
+    assert_int_equal(buf_read_u32(&=
value, NULL), 0x11223344);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr,=
 &value));
+    assert_int_equal(hdr=2Etype, 0x5);
+    assert_int_equal(BL=
EN(&value), 0);
+
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc)=
;
+}
+
+/* A TLV header claiming more value bytes than the payload holds is=
 rejected,
+ * rather than read past the end of the payload=2E */
+void
+te=
st_tlv_next_value_truncated(void **state)
+{
+    struct gc_arena gc =3D gc=
_new();
+    struct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_tru=
e(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+  =
  assert_true(buf_write_u32(&buf, 0));
+
+    struct ctrl_msg_tlv_header hd=
r;
+    struct buffer value;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr=
, &value));
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV header must fail wh=
en the buffer holds less data than a
+ * complete 4-byte header, rather tha=
n read past the available data=2E */
+void
+test_tlv_header_truncated(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    const uint8_t bytes[=
] =3D { 0x00, 0x01, 0x00 };
+
+    /* 0 to 3 bytes: none, part of the type =
field, the type field, and the type
+     * field with half of the length *=
/
+    for (size_t n =3D 0; n <=3D sizeof(bytes); n++)
+    {
+        stru=
ct buffer buf =3D alloc_buf_gc(16, &gc);
+        assert_true(buf_write(&bu=
f, bytes, n));
+        struct buffer copy =3D buf;
+
+        struct ctrl_=
msg_tlv_header hdr;
+        struct buffer value;
+        assert_false(ctr=
l_msg_tlv_read_header(&buf, &hdr));
+        assert_false(ctrl_msg_tlv_next=
(&copy, &hdr, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails,=
 rather than writes a partial TLV, when buf is too small=2E */
+void
+test_=
tlv_write_no_room(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+
=
+    struct buffer buf =3D alloc_buf_gc(3, &gc);
+    assert_false(ctrl_msg=
_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+
+    /* roo=
m for the header but not the value */
+    buf =3D alloc_buf_gc(5, &gc);
+ =
   assert_false(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, fals=
e, 1));
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_=
control_msg=2Eh b/tests/unit_tests/openvpn/test_control_msg=2Eh
new file mo=
de 100644
index 0000000=2E=2Eef7a030
--- /dev/null
+++ b/tests/unit_tests/o=
penvpn/test_control_msg=2Eh
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks
+ *             over a single TCP/UDP p=
ort, with support for SSL/TLS-based
+ *             session authentication =
and key exchange,
+ *             packet encryption, packet authentication,=
 and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026=
 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; =
you can redistribute it and/or modify
+ *  it under the terms of the GNU Ge=
neral Public License version 2
+ *  as published by the Free Software Found=
ation=2E
+ *
+ *  This program is distributed in the hope that it will be u=
seful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  G=
NU General Public License for more details=2E
+ *
+ *  You should have rece=
ived a copy of the GNU General Public License along
+ *  with this program;=
 if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_CO=
NTROL_MSG_H
+#define TEST_CONTROL_MSG_H
+
+void test_tlv_write_u16_wire_for=
mat(void **state);
+
+void test_tlv_header_roundtrip(void **state);
+
+void=
 test_tlv_next_walks_payload(void **state);
+
+void test_tlv_next_value_tru=
ncated(void **state);
+
+void test_tlv_header_truncated(void **state);
+
+v=
oid test_tlv_write_no_room(void **state);
+#endif
diff --git a/tests/unit_t=
ests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fbb=
b40f=2E=2E990a317 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/=
tests/unit_tests/openvpn/test_pkt=2Ec
@@ -37,12 +37,14 @@
 #include "crypto=
=2Eh"
 #include "options=2Eh"
 #include "ssl_backend=2Eh"
+#include "contro=
l_msg=2Eh"
 #include "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
 #include "m=
ss=2Eh"
 #include "reliable=2Eh"
 #include "siphash=2Eh"
+#include "test_co=
ntrol_msg=2Eh"
 
 int
 parse_line(const char *line, char **p, const int n, =
const char *file, const int line_num,
@@ -655,6 +657,46 @@
     free_buf(&t=
as=2Eworkbuf);
 }
 
+/* A reset reply asking a tls-crypt-v2 client to resen=
d its WKc ends in the
+ * early negotiation flags TLV, the bytes older vers=
ions wrote by hand, and the
+ * TLV parses back=2E */
+static void
+test_ge=
nerate_reset_packet_resend_wkc(void **ut_state)
+{
+    struct tls_auth_sta=
ndalone tas =3D { 0 };
+
+    struct session_id client_id =3D { { 0, 1, 2, =
3, 4, 5, 6, 7 } };
+    struct session_id server_id =3D { { 8, 9, 0, 9, 8, =
7, 6, 2 } };
+
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    struct fr=
ame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 =
}, 0 };
+    tas=2Eframe =3D frame;
+    tas=2Eworkbuf =3D alloc_buf(1600);=

+
+    uint8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_=
SHIFT);
+
+    struct buffer plain =3D
+        tls_reset_standalone(&tas=
=2Etls_wrap, &tas, &client_id, &server_id, header, false);
+    const int p=
lain_len =3D BLEN(&plain);
+    struct buffer buf =3D
+        tls_reset_st=
andalone(&tas=2Etls_wrap, &tas, &client_id, &server_id, header, true);
+
+ =
   const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    ass=
ert_int_equal(BLEN(&buf), plain_len + (int)sizeof(tlv));
+    assert_memory=
_equal(BPTR(&buf) + plain_len, tlv, sizeof(tlv));
+
+    struct buffer payl=
oad =3D buf;
+    assert_true(buf_advance(&payload, plain_len));
+    struc=
t ctrl_msg_tlv_header hdr;
+    struct buffer value;
+    assert_true(ctrl_=
msg_tlv_next(&payload, &hdr, &value));
+    assert_int_equal(hdr=2Etype, TL=
V_TYPE_EARLY_NEG_FLAGS);
+    assert_int_equal(buf_read_u16(&value), EARLY_=
NEG_FLAG_RESEND_WKC);
+    assert_int_equal(BLEN(&payload), 0);
+
+    free=
_buf(&tas=2Eworkbuf);
+}
+
 static void
 test_generate_reset_packet_tls_aut=
h(void **ut_state)
 {
@@ -791,9 +833,16 @@
         cmocka_unit_test(test_v=
erify_hmac_tls_auth),
         cmocka_unit_test(test_verify_hmac_none_out_o=
f_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
=
+        cmocka_unit_test(test_generate_reset_packet_resend_wkc),
         =
cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit=
_test(test_wkc_not_appended_without_key),
-        cmocka_unit_test(test_ex=
tract_control_message)
+        cmocka_unit_test(test_extract_control_messa=
ge),
+        cmocka_unit_test(test_tlv_write_u16_wire_format),
+        cm=
ocka_unit_test(test_tlv_header_roundtrip),
+        cmocka_unit_test(test_t=
lv_next_walks_payload),
+        cmocka_unit_test(test_tlv_next_value_trunc=
ated),
+        cmocka_unit_test(test_tlv_header_truncated),
+        cmock=
a_unit_test(test_tlv_write_no_room)
     };
 
     return cmocka_run_group_=
tests_name("pkt tests", tests, NULL, NULL);

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Ge=
rrit-Change-Number: 1965
Gerrit-PatchSet: 4
Gerrit-Owner: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov =
<lstipakov@gmail=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--3mFLsEhgLtE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, R=C4=
=83zvan Cojocaru=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #4</str=
ong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1965?usp=3Demail">View Change</a></p><p>The following approvals got=
 outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">control_msg: Add a shared TLV codec and use it for early negotiatio=
n<br><br>Early negotiation in the reset packets is a sequence of TLVs, and<=
br>planned out-of-band and control data messages will use the same TLV<br>f=
ormat and type space=2E Add one TLV codec for all of them,<br>control_msg=
=2Ec/h, and move early negotiation onto it=2E<br><br>The codec only handles=
 the framing: reading and writing TLV headers,<br>writing a 16-bit TLV, and=
 walking a payload TLV by TLV with each value<br>checked against the payloa=
d=2E How to treat an unknown type is up to each<br>message=2E<br><br>The co=
dec splits the top bit of the type field off as the &quot;optional&quot;<br=
>flag, which the previous early negotiation parser did not do=2E The flags<=
br>TLV is defined with that bit clear, so the parser only accepts it when<b=
r>the bit is clear and skips the type word 0x8001 as unknown exactly as<br>=
before=2E No functional change=2E<br><br>Change-Id: I89c3133e009dc75dc2c10c=
607b3f0a24c04e8146<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;=
<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openv=
pn/control_msg=2Ec<br>A src/openvpn/control_msg=2Eh<br>M src/openvpn/ssl=2E=
c<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit=
_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/test_control_msg=
=2Ec<br>A tests/unit_tests/openvpn/test_control_msg=2Eh<br>M tests/unit_tes=
ts/openvpn/test_pkt=2Ec<br>11 files changed, 481 insertions(+), 23 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/65/1965/4</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMa=
keLists=2Etxt</span><br><span>index 5cf1a30=2E=2E305c26c 100644</span><br><=
span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><b=
r><span>@@ -457,6 +457,8 @@</span><br><span>     src/openvpn/console=2Ec</s=
pan><br><span>     src/openvpn/console_builtin=2Ec</span><br><span>     src=
/openvpn/console=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/control_msg=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/control_msg=2Eh</span><br><span>     src/openv=
pn/crypto=2Ec</span><br><span>     src/openvpn/crypto=2Eh</span><br><span> =
    src/openvpn/crypto_backend=2Eh</span><br><span>@@ -896,6 +898,8 @@</spa=
n><br><span> </span><br><span>     target_sources(test_pkt PRIVATE</span><b=
r><span>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvp=
n/test_control_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        src/openvpn/control_msg=2Ec</span><br><span>         src/openvpn=
/argv=2Ec</span><br><span>         src/openvpn/base64=2Ec</span><br><span> =
        src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/openv=
pn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index bb31053=
=2E=2Ebe1044d 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span>=
<br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -57,6 +57,7 @@=
</span><br><span> 	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh compstu=
b=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</span>=
<br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	cr=
ypto_openssl=2Ec crypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls=2Ec =
crypto_mbedtls=2Eh \</span><br><span>diff --git a/src/openvpn/control_msg=
=2Ec b/src/openvpn/control_msg=2Ec</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2Ee3e4b17</span><br><span>--- /dev/null</span=
><br><span>+++ b/src/openvpn/control_msg=2Ec</span><br><span>@@ -0,0 +1,85 =
@@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             over a single TCP/UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             packet encryption, packet authenticati=
on, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is free software; you can redistribute =
it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 it under the terms of the GNU General Public License version 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free So=
ftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshe=
ad=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_header(struct buffer *=
buf, uint16_t type, bool optional, uint16_t value_len)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* the type has 15 bits; the top bit is the optional f=
lag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ty=
pe &lt;=3D CTRL_MSG_TLV_TYPE_MASK);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint16_t field =3D type;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (optional)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return buf_write_u16(buf, field) &amp;&amp; buf_w=
rite_u16(buf, value_len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_u16(struct buffer *buf, uin=
t16_t type, bool optional, uint16_t value)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return ctrl_msg_tlv_write_header(buf, type, optional, sizeof(uint1=
6_t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &am=
p;&amp; buf_write_u16(buf, value);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_read_header(struct buffe=
r *buf, struct ctrl_msg_tlv_header *hdr)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int field =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (field &lt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int len =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (len &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;typ=
e =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TYPE_MASK);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;optional =3D (field &amp; CTR=
L_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_next(str=
uct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_tlv_read_header(buf, hd=
r))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false; /* fewer=
 than 4 bytes left: truncated header */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Advance past the value; fails if buf is shorter than the heade=
r claims=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst uint8_t *v =3D buf_read_alloc(buf, hdr-&gt;value_len);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!v)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    buf_set_read(value, v, hdr-&gt;value_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>new file mo=
de 100644</span><br><span>index 0000000=2E=2E56c1590</span><br><span>--- /d=
ev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh</span><br><span>@=
@ -0,0 +1,100 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             session authentication and key exchange,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packe=
t authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet compression=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV frami=
ng shared by the TLV-based control messages of the wire protocol=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Such a message payload is a sequence of T=
LV entries=2E Each TLV starts with a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * 4-byte header: a 16-bit field whose most significant bi=
t is the &quot;optional&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * flag and whose remaining 15 bits are the type, followed by a 1=
6-bit length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * givi=
ng the size of the value that follows the header=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * All of these messages share one TLV type space, so the =
TLV types are all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 defined here=2E Only the framing is handled here: what a message does with=
 a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV type it do=
es not know, marked optional or not, is up to its parser=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV types */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_EARL=
Y_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* TLV header bit layout of the first 16-bit fiel=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MS=
G_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/** The header every TLV carries: the 15-bit type and optional fl=
ag packed into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * th=
e first 16-bit field, then the length of the value that follows=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_heade=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt; the =
15-bit TLV type */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool optional;      /**&lt; value of the optional flag */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&lt; le=
ngth of the value following the header */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV header (type + =
optional flag + value length) to buf=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * type must fit in the 15 bits of the type field=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if bu=
f has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctr=
l_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
         uint16_t value_len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete TLV w=
hose value is a single 16-bit integer to buf=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return true on success, false if buf has insufficient space=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_u16(stru=
ct buffer *buf, uint16_t type, bool optional, uint16_t value);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Read a TLV header from buf, advancing past it=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf  buffer positioned at the TLV header</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr  filled=
 with the type, optional flag and value length on success</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if =
there are not enough bytes for a header=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tl=
v_header *hdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Read the next TLV from buf, advancin=
g past its header and value=2E Call it</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * while BLEN(buf) &gt; 0 to walk a whole payload=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * The length from the header is validat=
ed against buf, so on success the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * whole value is present: a header claiming more bytes than =
buf holds is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reje=
cted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf    buffer posit=
ioned at a TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param hdr    filled with the TLV&#39;s type, optional flag and value =
length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param val=
ue  set to a buffer covering exactly the TLV&#39;s value; it points</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *               into buf a=
nd owns no storage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true on success, false if the header or the value is truncated; b=
uf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         may th=
en be left partly consumed=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool c=
trl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struc=
t buffer *value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef CONT=
ROL_MSG_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn=
/ssl=2Ec</span><br><span>index 12b6119=2E=2Ee531613 100644</span><br><span>=
--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><=
br><span>@@ -52,6 +52,7 @@</span><br><span> #include &quot;pkcs11=2Eh&quot;=
</span><br><span> #include &quot;route=2Eh&quot;</span><br><span> #include =
&quot;tls_crypt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> </span><br><spa=
n> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;ss=
l=2Eh&quot;</span><br><span>@@ -2645,26 +2646,28 @@</span><br><span> {</spa=
n><br><span>     while (buf-&gt;len &gt; 0)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf_len(buf) &lt; =
4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* read type */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int type =3D buf_read_u16(buf);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int len =3D b=
uf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (type &lt; 0 || len &lt; 0 || buf_len(buf) &lt; len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header =
hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (!ctrl_msg_tlv_next(buf, &amp;hdr, &amp;value))</span><br><span>      =
   {</span><br><span>             goto error;</span><br><span>         }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  switch (type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    switch (hdr=2Etype)</span><br><span>         {</span><br><span>        =
     case TLV_TYPE_EARLY_NEG_FLAGS:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                if (len !=3D sizeof(uint16_t))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* This TLV is def=
ined with the optional bit clear=2E A type</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 * word that has the bit set is not =
this TLV, so skip it as</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 * an unknown type rather than parsing it as the flags=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (hdr=2Eoptional)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if (BLEN(&amp;value) !=3D sizeof(uint16_t))</span><br=
><span>                 {</span><br><span>                     goto error;<=
/span><br><span>                 }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                int flags =3D buf_read_u16(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                int flags =3D buf=
_read_u16(&amp;value);</span><br><span> </span><br><span>                 i=
f (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>                 =
{</span><br><span>@@ -2683,8 +2686,8 @@</span><br><span>                 br=
eak;</span><br><span> </span><br><span>             default:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                /* Skip types we do =
not parse */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       buf_advance(buf, len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                /* Skip types we do not parse, marked optional or=
 not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    break;</span><br><span>         }</span><br><span>     }</span><br><spa=
n>     reliable_mark_deleted(ks-&gt;rec_reliable, buf);</span><br><span>dif=
f --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span=
>index f78782f=2E=2Ef4564ef 100644</span><br><span>--- a/src/openvpn/ssl_pk=
t=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -33,=
6 +33,7 @@</span><br><span> #include &quot;reliable=2Eh&quot;</span><br><sp=
an> #include &quot;siphash=2Eh&quot;</span><br><span> #include &quot;tls_cr=
ypt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;control_msg=2Eh&quot;</span><br><span> </span><br><span> /*</span>=
<br><span>  * Dependent on hmac size, opcode size, and session_id size=2E</=
span><br><span>@@ -432,9 +433,8 @@</span><br><span>     /* Add indication f=
or tls-crypt-v2 to resend the WKc with the reply */</span><br><span>     if=
 (request_resend_wkc)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_F=
LAGS); /* TYPE: flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        buf_write_u16(&amp;buf, sizeof(uint16_t));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, EARLY_NEG_F=
LAG_RESEND_WKC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ASSERT(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, fals=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                     EARLY_NEG_FLAG_RESEND_WKC));</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* Add tls-auth/tls-crypt wrapping, th=
is might replace buf with</span><br><span>diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 8203e4a=2E=2E218c6bb 1=
00644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/s=
rc/openvpn/ssl_pkt=2Eh</span><br><span>@@ -306,10 +306,8 @@</span><br><span=
> #define EARLY_NEG_START 0x0f000000</span><br><span> </span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Early negotiation tha=
t part of the server response in the RESET_V2 packet=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Since clients that announce early nego=
tiation support will treat the payload</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * of reset packets special and parse it as TLV messages=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * as TLV (type, l=
ength, value) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne TLV_TYPE_EARLY_NEG_FLAGS  0x0001</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Early negotiation: clients that announce support for it =
parse the payload of</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * the reset packets as TLVs (see control_msg=2Eh)=2E Flags carried in the=
 value of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the TLV=
_TYPE_EARLY_NEG_FLAGS TLV: */</span><br><span> #define EARLY_NEG_FLAG_RESEN=
D_WKC 0x0001</span><br><span> #endif /* ifndef SSL_PKT_H */</span><br><span=
>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/ope=
nvpn/Makefile=2Eam</span><br><span>index 70cf7b2=2E=2E11f92f4 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ =
b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -164,11 +164,15=
 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I=
$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span=
> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec =
mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCES =3D test_pkt=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_control_msg=
=2Ec test_control_msg=2Eh \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	test_common=2Eh \</span><br><span> =
	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base=
64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/co=
ntrol_msg=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_control_msg=2Ec b/tests/unit_tests/openv=
pn/test_control_msg=2Ec</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000=2E=2E7e6ed06</span><br><span>--- /dev/null</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span>@@ -0,0=
 +1,177 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         session authentication and key exchange,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet encryption, packet auth=
entication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           packet compression=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is free software; you can redis=
tribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  it under the terms of the GNU General Public License version 2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the=
 Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is distributed in the hope that it will be useful,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General=
 Public License for more details=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  You should have received a copy of the GNU General Public License along<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_control_msg=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* The early negotiation flags =
TLV of a reset packet asking a tls-crypt-v2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * client to resend its WKc, as older versions wrot=
e it by hand=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_u=
16_wire_format(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_=
TYPE_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                       EARLY_NEG_FLAG_RESEND_WKC))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t =
expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), siz=
eof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* the optional flag is the most significant =
bit of the type field */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_clear(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_N=
EG_FLAGS, true, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(BPTR(&amp;buf)[0], 0x80);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[1], 0x01);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* A TLV header survives the round trip, the optional flag kept apart from=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the 15-bit type=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_roundtrip(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x1234, true, 5));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(BLEN(&amp;buf), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_m=
sg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, =
0x1234);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(hdr=2Evalue_len, 5);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Walkin=
g a payload returns each TLV in turn, with a value covering exactly</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * its bytes, and consumes =
the payload=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_wal=
ks_payload(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE=
_EARLY_NEG_FLAGS, false, 0xabcd));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, t=
rue, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u32(&amp;buf, 0x11223344));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf,=
 0x5, false, 0)); /* empty value */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Et=
ype, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 2);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_r=
ead_u16(&amp;value), 0xabcd);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x7=
ff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(BLEN(&amp;value), 4);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(buf_read_u32(&amp;value, NULL), 0=
x11223344);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x5);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;valu=
e), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* A TLV header claiming more value bytes than the payload holds=
 is rejected,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rat=
her than read past the end of the payload=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_tlv_next_value_truncated(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
64, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_=
tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(=
&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_=
header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Readi=
ng a TLV header must fail when the buffer holds less data than a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * complete 4-byte header, rat=
her than read past the available data=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_tlv_header_truncated(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t bytes[] =3D { 0x00, 0x01, 0x0=
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* 0 to 3 bytes: none, part of=
 the type field, the type field, and the type</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * field with half of the length */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t n =3D 0; n &l=
t;=3D sizeof(bytes); n++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        assert_true(buf_write(&amp;buf, bytes,=
 n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 buffer copy =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ct=
rl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct buffer value;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        assert_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;hd=
r));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_=
false(ctrl_msg_tlv_next(&amp;copy, &amp;hdr, &amp;value));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Writing fails, rather than=
 writes a partial TLV, when buf is too small=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_tlv_write_no_room(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(3, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tl=
v_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* room for the header but not the value */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_g=
c(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, fals=
e, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_control_msg=2Eh b/tests/unit_tests/openvpn/=
test_control_msg=2Eh</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000=2E=2Eef7a030</span><br><span>--- /dev/null</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_control_msg=2Eh</span><br><span>@@ -0,0 +1=
,37 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single TCP/UDP port, with support for SSL/=
TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     session authentication and key exchange,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet encryption, packet authenti=
cation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet compression=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copy=
right (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  it under the terms of the GNU General Public License version 2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fre=
e Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pro=
gram is distributed in the hope that it will be useful,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pub=
lic License for more details=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 test_tlv_write_u16_wire_format(void **state);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void test_tlv_header_roundtrip(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_tlv_next_walks_payload(void **state);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void test_tlv_next_value_truncated(void **state);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void test_tlv_header_truncated(void **st=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_write_no_room(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/uni=
t_tests/openvpn/test_pkt=2Ec</span><br><span>index fbbb40f=2E=2E990a317 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -37,12 =
+37,14 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span>=
 #include &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backe=
nd=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;control_msg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&q=
uot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &qu=
ot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_con=
trol_msg=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> =
parse_line(const char *line, char **p, const int n, const char *file, const=
 int line_num,</span><br><span>@@ -655,6 +657,46 @@</span><br><span>     fr=
ee_buf(&amp;tas=2Eworkbuf);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* A reset reply asking a tls-=
crypt-v2 client to resend its WKc ends in the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * early negotiation flags TLV, the bytes older v=
ersions wrote by hand, and the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * TLV parses back=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_generate_reset_packet_resend_wkc(void **ut_state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id client_id =3D { { 0=
, 1, 2, 3, 4, 5, 6, 7 } };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_=
NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct fra=
me frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }=
, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Efra=
me =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ta=
s=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 &lt;&lt; P_OPCODE_SHIF=
T);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer plain =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_reset_standalon=
e(&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id, &amp;server_id, header, fa=
lse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int =
plain_len =3D BLEN(&amp;plain);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer buf =3D</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;ta=
s, &amp;client_id, &amp;server_id, header, true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(BLEN(&amp;buf), plain_len + (int)sizeof(tlv));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf) + =
plain_len, tlv, sizeof(tlv));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer payload =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(buf_advance(&amp;payload, plain_len));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(ctrl_msg_tlv_next(&amp;payload, &amp;hdr, &amp;value));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV=
_TYPE_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(buf_read_u16(&amp;value), EARLY_NEG_FLAG_RESEND_WK=
C);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(BLEN(&amp;payload), 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_b=
uf(&amp;tas=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> static void</span><br><span> test_generate_reset_packet_tls_auth(void *=
*ut_state)</span><br><span> {</span><br><span>@@ -791,9 +833,16 @@</span><b=
r><span>         cmocka_unit_test(test_verify_hmac_tls_auth),</span><br><sp=
an>         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span=
><br><span>         cmocka_unit_test(test_generate_reset_packet_plain),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_tes=
t(test_generate_reset_packet_resend_wkc),</span><br><span>         cmocka_u=
nit_test(test_generate_reset_packet_tls_auth),</span><br><span>         cmo=
cka_unit_test(test_wkc_not_appended_without_key),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_extract_control_m=
essage)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_extract_control_message),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_write_u16_wire_fo=
rmat),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_tlv_header_roundtrip),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_walks_payload),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_tlv_next_value_truncated),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_tlv_write_no_room)</span><br><span>     };</span><br><span> </span><br=
><span>     return cmocka_run_group_tests_name(&quot;pkt tests&quot;, tests=
, NULL, NULL);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75=
dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1965 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>=

<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--3mFLsEhgLtE=--


--===============8879916983321966039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8879916983321966039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8879916983321966039==--

