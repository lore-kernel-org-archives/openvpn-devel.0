Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE6606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fWgEzwKB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YcfM5Orr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S20DOxiM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S2EwVp5T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nrAac4wxB1m3bYulM+YRzUgI0h+2FVsMhhi1EPqDuFw=; b=fWgEzwKBTVhY+HjqEqEFD5FyNf
	pTts3YZ5aoKhuC0Lz5OAaRqouqzBCMYb0JplloeK2DST9dizU03HzCyJoBNeB1sR7FnvcJyLP7wlD
	LmiWBlGImkcBafL6MZe72UUZYyVJKt9qtGzp1Q7ifDtS6YHA2+mkEjX85y4P8dwvkaWw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRmy4-000000001hC-0CCU;
	Fri, 13 Nov 2026 08:49:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRmy2-000000001gw-2sTe
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 08:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ms0MAmYik6q9pIqfeNIAZMaknAzUlfkeTQsq6W5i/0E=; b=YcfM5OrrCb11MbcEoErd869cVV
 5ROpiJ0oR2D0Fnm4I80V4k3pBbNCs4TS/wlSbByf2i9a9q7C8cxV2j+4LKxvvJt4b2Z6p/yON0WdB
 /DfsrDix/TtuQFcWvYsPmbThOZlrb+JdAWlISiCnDcgeyIgqTp1jq4vpJh8a3ww9f2Mo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ms0MAmYik6q9pIqfeNIAZMaknAzUlfkeTQsq6W5i/0E=; b=S20DOxiMF0wvoJ7T8QWAIqz0r6
 AFP4tB3hn2UyHbnB8iOf6cM2in2EZIBa0pRee3pEuVd2hXiYO1ANKPXnLsRLS49W73HsSp2u61nh5
 W7c2M0xwrvtVA3RbvN1DrVkpfxCE8Q/0e9zB7RXICpziTdxlej9aDriAZ/LSzUbLBM8E=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRmxx-000000001ql-46J8 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 08:49:06 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so4652935e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794559735; x=1795164535; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ms0MAmYik6q9pIqfeNIAZMaknAzUlfkeTQsq6W5i/0E=;
 b=S2EwVp5TGspxuCSal39QbPVHslkUJMjquIkqO2awXodDNhLzfxIB4dT417OagnZIOO
 WB9ohNYlpdU/+nZAOMvNmkFutyrGkntS+1uaFjXoHkxam5EdEAJ3LQdKugZOoBQCshHQ
 YwR57OhnLNkcVXacRWk4XvcX++0v8fHFPtmie25pVLcmEzQ7F9uGJ9Q86LzhWR1rb/TH
 SprGO29p7e7R8MZmzUhLnZb+GQN9hwBOVKYM/q97Qr6oqhErMhuk6WO8hReVaiUb8tdv
 UVhZcuOFdXdZEAd3X+0R7hurZuiy2Ob+VIbNSk7Mxnf9Q3zf31edHeMs8GJcty8VsuTn
 7MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559735; x=1795164535;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ms0MAmYik6q9pIqfeNIAZMaknAzUlfkeTQsq6W5i/0E=;
 b=pH/pTXhdgs1Ha2DpBEnlbcKiiTXP9B66VcUTHNtCiY7nWDoLcHzH7gxHKXdBOTmSM+
 P+YjR0tO/jR02Iz4JzovuTWEhPq6rxlvtVuJI4E4VGO1QYDGPe9oiaHIibZ4ge1fY2Y/
 NJ0IjxKUU/ty1oKXwA/BCOzrU0JTe23bwCh4gXxdeNd0uR8cMS59eWJaV+iP+zmjzrfG
 /PoUjLdeSDpmZUkuxAfyYH/EGdoZEpHYGl5SmGhUbq90QRCTOmS/QwTlrp+1iRe100su
 ay9kwPpB8KFtN5IpZugfP0vFft5hTkS8Mlt0GjuolIqZAu3hCmGo80/u7zDrmpxeB1Hn
 v4Ww==
X-Gm-Message-State: APuU4Z8GNth7iRWqWIouBvB2U7ohvIlVFgZNC1RHxVY7P/fpUXFxma2j
 6tGYm1PW7lbfoEO14xHJBlNK8ULWWf2JfEivfwC++DmL3ycgujL9LIX0ZlvHf9hEC1n2BiISx90
 Sk3B/WAuNqZLxNHO4o8vB0DoFxdGhM59E3FCN10UxcOqdHMPxGkrjdcvfjdnpbUgLiTgD
X-Gm-Gg: AYBFou1iiPG68kIIc9uHFf+VDfY65/dfFo6S7hfyTSrqhReqGs7R2D51M9OSOm6Lap9
 Cypa+n3+rcvpWGjve52EYI0moF6F/l9xuVH3GK/3jAp68UdWJn9WLQJFZoVEeiLEh+6Y5dtA8hq
 B+6zCDegKcTMFMp4V8YkpChbtT0vl+8sDA4GtbWgJvPwtGudcxk7TmUS0jkhbhwk6dKBq3o1xVl
 rR/CGO6CkbZwELgQL4L1RgjVv6YQ1nXylS2JuGwdEB+9n6XkMOAR/GVG1Fz4EeEFrWNdyxfLocB
 1EgmrYrv85SgFEEdJnZv2gpwyRRfEHYHFwBKDprPBDFFRZnFcJ6zzJMsEogw8Ru0sNB60LPVy80
 nsJn4++ruVOt9fHWYA79XcImh2q7CqGI01zu/T27X7aG+gdjG5mJ0DTDEDnZHeq6P11IPgNxeM/
 1LcYy3ewSAe4Umg2T6A+013GuNt5QvwsXrXzDCsoICYbwLgBEXBtwPhKUSw0uadulDRYU71hsnP
 CND2V/rChwHvIFAphPw/7Hu+NUy8VSncX++ux9k/iJ6VUEOpOE/W7BKu1FoZYHUdh6PHrt3wCmz
 KeLKUi1dgFNIK67mMuy6HTDo3qEen7kx7EH4aJ6j+QgPaRV0r/V4qKoM5DHAse9xoipsqJBfJeE
 WB8G7v5+lHZ3tebHmold5jI6k8lizf1ia3Hi9n+UfYDhM+xTLON/Ra5koEutnkoD95+qnoxSG2B
 8a+Pb3yJjECOv3E6w=
X-Received: by 2002:a05:600c:4ec6:b0:4a3:2f35:38aa with SMTP id
 5b1f17b1804b1-4bb55a93ab1mr34601735e9.29.1794559734771; 
 Fri, 13 Nov 2026 00:48:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55af1c5fsm43478515e9.12.2026.11.13.00.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:48:53 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 08:48:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 7aedc6fa5691436ccd65f17241fb66478b785b5e
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abbb1c7a79240403c9e96e27364fe28548b841a5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRmxx-000000001ql-46J8
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
Content-Type: multipart/mixed; boundary="===============2460951762535362594=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2460951762535362594==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JLmPxr393Vw="; charset=UTF-8

--JLmPxr393Vw=
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
 the new patch set (#7)=2E

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
message=2E With t=
he optional flag clear the codec writes the same bytes as
the hand-rolled c=
ode it replaces=2E

In the codec the most significant bit of the type field=
 is the
"optional" flag rather than part of the type=2E The old parser comp=
ared
the whole type word, so 0x8001 did not match the flags TLV and was
ski=
pped as unknown; now it matches and is parsed as one=2E

Change-Id: I89c313=
3e009dc75dc2c10c607b3f0a24c04e8146
Signed-off-by: Lev Stipakov <lev@openvpn=
=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/co=
ntrol_msg=2Ec
A src/openvpn/control_msg=2Eh
M src/openvpn/ssl=2Ec
M src/ope=
nvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makef=
ile=2Eam
A tests/unit_tests/openvpn/test_control_msg=2Ec
A tests/unit_tests=
/openvpn/test_control_msg=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
11 fi=
les changed, 490 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/7

diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt
index 5cf1a30=2E=2E305c26c 100644
--- a/CMakeL=
ists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -457,6 +457,8 @@
     src/openvpn/cons=
ole=2Ec
     src/openvpn/console_builtin=2Ec
     src/openvpn/console=2Eh
+=
    src/openvpn/control_msg=2Ec
+    src/openvpn/control_msg=2Eh
     src/o=
penvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     src/openvpn/crypto_backe=
nd=2Eh
@@ -896,6 +898,8 @@
 
     target_sources(test_pkt PRIVATE
         =
tests/unit_tests/openvpn/mock_win32_execve=2Ec
+        tests/unit_tests/op=
envpn/test_control_msg=2Ec
+        src/openvpn/control_msg=2Ec
         sr=
c/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn/cry=
pto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index bb31053=2E=2Ebe1044d 100644
--- a/src/openvpn/Makefile=2Eam
+++=
 b/src/openvpn/Makefile=2Eam
@@ -57,6 +57,7 @@
 	common=2Eh \
 	comp=2Ec co=
mp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec contr=
ol_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openssl=
=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \
diff --=
git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
new file mo=
de 100644
index 0000000=2E=2E0726941
--- /dev/null
+++ b/src/openvpn/contro=
l_msg=2Ec
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -- An application to securely t=
unnel IP networks
+ *             over a single TCP/UDP port, with support =
for SSL/TLS-based
+ *             session authentication and key exchange,
=
+ *             packet encryption, packet authentication, and
+ *          =
   packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sale=
s@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistribu=
te it and/or modify
+ *  it under the terms of the GNU General Public Licen=
se version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  =
This program is distributed in the hope that it will be useful,
+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public =
License for more details=2E
+ *
+ *  You should have received a copy of the=
 GNU General Public License along
+ *  with this program; if not, see <http=
s://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "c=
onfig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "control_msg=2Eh"
=
+
+bool
+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool =
optional, uint16_t value_len)
+{
+    /* the type has 15 bits; the top bit =
is the optional flag */
+    ASSERT(type <=3D CTRL_MSG_TLV_TYPE_MASK);
+
+ =
   /* Write nothing unless the whole TLV fits=2E The header promises that
+=
     * value_len bytes follow it, so a header written without room for the
=
+     * value would leave a partial TLV in buf=2E */
+    if (!buf_safe(buf=
, (size_t)CTRL_MSG_TLV_HEADER_LEN + value_len))
+    {
+        return fals=
e;
+    }
+    uint16_t field =3D type;
+    if (optional)
+    {
+        =
field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(buf=
, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_write_u=
16(struct buffer *buf, uint16_t type, bool optional, uint16_t value)
+{
+  =
  return ctrl_msg_tlv_write_header(buf, type, optional, sizeof(uint16_t))
+=
           && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_msg_tlv_read_head=
er(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    /* Read not=
hing unless the whole header is there, so that a truncated
+     * header l=
eaves buf untouched=2E */
+    if (BLEN(buf) < CTRL_MSG_TLV_HEADER_LEN)
+  =
  {
+        return false;
+    }
+    uint16_t field =3D (uint16_t)buf_rea=
d_u16(buf);
+    hdr->value_len =3D (uint16_t)buf_read_u16(buf);
+    hdr->=
type =3D field & CTRL_MSG_TLV_TYPE_MASK;
+    hdr->optional =3D (field & CT=
RL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    return true;
+}
+
+bool
+ctrl_msg_tl=
v_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *=
value)
+{
+    if (!ctrl_msg_tlv_read_header(buf, hdr))
+    {
+        ret=
urn false; /* fewer than 4 bytes left: truncated header */
+    }
+    /* A=
dvance past the value; fails if buf is shorter than the header claims=2E */=

+    const uint8_t *v =3D buf_read_alloc(buf, hdr->value_len);
+    if (!v=
)
+    {
+        return false;
+    }
+    buf_set_read(value, v, hdr->val=
ue_len);
+    return true;
+}
diff --git a/src/openvpn/control_msg=2Eh b/sr=
c/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=2E9a98b21
-=
-- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,107 @@
+/*
+ *  O=
penVPN -- An application to securely tunnel IP networks
+ *             ove=
r a single TCP/UDP port, with support for SSL/TLS-based
+ *             ses=
sion authentication and key exchange,
+ *             packet encryption, pa=
cket authentication, and
+ *             packet compression=2E
+ *
+ *  Cop=
yright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This progra=
m is free software; you can redistribute it and/or modify
+ *  it under the=
 terms of the GNU General Public License version 2
+ *  as published by the=
 Free Software Foundation=2E
+ *
+ *  This program is distributed in the ho=
pe that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the =
implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  =
You should have received a copy of the GNU General Public License along
+ *=
  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ *=
/
+
+/**
+ * @file
+ * TLV framing shared by the TLV-based control messages=
 of the wire protocol=2E
+ *
+ * Such a message payload is a sequence of TL=
V entries=2E Each TLV starts with a
+ * 4-byte header: a 16-bit field whose=
 most significant bit is the "optional"
+ * flag and whose remaining 15 bit=
s are the type, followed by a 16-bit length
+ * giving the size of the valu=
e that follows the header=2E
+ *
+ * All of these messages share one TLV ty=
pe space, so the TLV types are all
+ * defined here=2E Only the framing is =
handled here: what a message does with a
+ * TLV type it does not know, mar=
ked optional or not, is up to its parser=2E
+ */
+
+#ifndef CONTROL_MSG_H
+=
#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV types */
+#define =
TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets =
*/
+
+/* A TLV header is a 16-bit type/optional field plus a 16-bit length =
*/
+#define CTRL_MSG_TLV_HEADER_LEN 4
+
+/* bit layout of the first 16-bit =
field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_T=
YPE_MASK     0x7fff
+
+/** The header every TLV carries: the 15-bit type an=
d optional flag packed into
+ * the first 16-bit field, then the length of =
the value that follows=2E */
+struct ctrl_msg_tlv_header
+{
+    uint16_t t=
ype;      /**< the 15-bit TLV type */
+    bool optional;      /**< value o=
f the optional flag */
+    uint16_t value_len; /**< length of the value fo=
llowing the header */
+};
+
+/**
+ * Write a TLV header (type + optional fl=
ag + value length) to buf=2E
+ * type must fit in the 15 bits of the type f=
ield=2E
+ *
+ * Nothing is written unless the header and the value_len byte=
s of value
+ * that follow it both fit, so a failed write never leaves a pa=
rtial TLV
+ * behind=2E
+ *
+ * @return true on success, false if buf has i=
nsufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header(struct buffer *bu=
f, uint16_t type, bool optional,
+                               uint16_t v=
alue_len);
+
+/**
+ * Write a complete TLV whose value is a single 16-bit i=
nteger to buf=2E
+ *
+ * @return true on success, false if buf has insuffic=
ient space=2E
+ */
+bool ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_=
t type, bool optional, uint16_t value);
+
+/**
+ * Read a TLV header from b=
uf, advancing past it=2E
+ *
+ * @param buf  buffer positioned at the TLV h=
eader
+ * @param hdr  filled with the type, optional flag and value length =
on success
+ * @return true on success, false if there are not enough bytes=
 for a header=2E
+ */
+bool ctrl_msg_tlv_read_header(struct buffer *buf, st=
ruct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Read the next TLV from buf, adva=
ncing past its header and value=2E Call it
+ * while BLEN(buf) > 0 to walk =
a whole payload=2E
+ *
+ * The length from the header is validated against =
buf, so on success the
+ * whole value is present: a header claiming more b=
ytes than buf holds is
+ * rejected=2E
+ *
+ * @param buf    buffer positio=
ned at a TLV header
+ * @param hdr    filled with the TLV's type, optional =
flag and value length
+ * @param value  set to a buffer covering exactly th=
e TLV's value; it points
+ *               into buf and owns no storage
+ *=
 @return true on success, false if the header or the value is truncated; bu=
f
+ *         may then be left partly consumed=2E
+ */
+bool ctrl_msg_tlv_n=
ext(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *val=
ue);
+
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec
index 420daef=2E=2E9a72614 100644
--- a/src/openvpn/s=
sl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -52,6 +52,7 @@
 #include "pkcs11=2Eh"
 =
#include "route=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
=
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
@@ -2644,26 +2645,21 @@
=
 {
     while (buf->len > 0)
     {
-        if (buf_len(buf) < 4)
-       =
 {
-            goto error;
-        }
-        /* read type */
-        in=
t type =3D buf_read_u16(buf);
-        int len =3D buf_read_u16(buf);
-    =
    if (type < 0 || len < 0 || buf_len(buf) < len)
+        struct ctrl_msg=
_tlv_header hdr;
+        struct buffer value;
+        if (!ctrl_msg_tlv_n=
ext(buf, &hdr, &value))
         {
             goto error;
         }
 
- =
       switch (type)
+        switch (hdr=2Etype)
         {
             c=
ase TLV_TYPE_EARLY_NEG_FLAGS:
-                if (len !=3D sizeof(uint16_t=
))
+                if (BLEN(&value) !=3D sizeof(uint16_t))
               =
  {
                     goto error;
                 }
-                in=
t flags =3D buf_read_u16(buf);
+                int flags =3D buf_read_u16(=
&value);
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
        =
         {
@@ -2682,8 +2678,8 @@
                 break;
 
             def=
ault:
-                /* Skip types we do not parse */
-                bu=
f_advance(buf, len);
+                /* Skip types we do not parse, marked=
 optional or not */
+                break;
         }
     }
     reliable=
_mark_deleted(ks->rec_reliable, buf);
diff --git a/src/openvpn/ssl_pkt=2Ec =
b/src/openvpn/ssl_pkt=2Ec
index f78782f=2E=2Ef4564ef 100644
--- a/src/openv=
pn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include "r=
eliable=2Eh"
 #include "siphash=2Eh"
 #include "tls_crypt=2Eh"
+#include "c=
ontrol_msg=2Eh"
 
 /*
  * Dependent on hmac size, opcode size, and session_=
id size=2E
@@ -432,9 +433,8 @@
     /* Add indication for tls-crypt-v2 to r=
esend the WKc with the reply */
     if (request_resend_wkc)
     {
-      =
  buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
-       =
 buf_write_u16(&buf, sizeof(uint16_t));
-        buf_write_u16(&buf, EARLY_=
NEG_FLAG_RESEND_WKC);
+        ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE=
_EARLY_NEG_FLAGS, false,
+                                      EARLY_NEG_F=
LAG_RESEND_WKC));
     }
 
     /* Add tls-auth/tls-crypt wrapping, this mi=
ght replace buf with
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl=
_pkt=2Eh
index 8203e4a=2E=2E218c6bb 100644
--- a/src/openvpn/ssl_pkt=2Eh
++=
+ b/src/openvpn/ssl_pkt=2Eh
@@ -306,10 +306,8 @@
 #define EARLY_NEG_START 0=
x0f000000
 
 
-/* Early negotiation that part of the server response in the=
 RESET_V2 packet=2E
- * Since clients that announce early negotiation suppo=
rt will treat the payload
- * of reset packets special and parse it as TLV =
messages=2E
- * as TLV (type, length, value) */
-#define TLV_TYPE_EARLY_NEG=
_FLAGS  0x0001
+/* Early negotiation: clients that announce support for it =
parse the payload of
+ * the reset packets as TLVs (see control_msg=2Eh)=2E=
 Flags carried in the value of
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #d=
efine EARLY_NEG_FLAG_RESEND_WKC 0x0001
 #endif /* ifndef SSL_PKT_H */
diff =
--git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/M=
akefile=2Eam
index 70cf7b2=2E=2E11f92f4 100644
--- a/tests/unit_tests/openv=
pn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -164,11 +1=
64,15 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdi=
r)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@=

-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_wi=
n32_execve=2Ec test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec \=

+	test_control_msg=2Ec test_control_msg=2Eh \
+	mock_msg=2Ec mock_msg=2Eh =
mock_win32_execve=2Ec \
+	test_common=2Eh \
 	$(top_srcdir)/src/compat/comp=
at-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src=
/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcd=
ir)/src/openvpn/control_msg=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
=
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/=
crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/openvpn/test_control_msg=
=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec
new file mode 100644
i=
ndex 0000000=2E=2E795ec9dd
--- /dev/null
+++ b/tests/unit_tests/openvpn/tes=
t_control_msg=2Ec
@@ -0,0 +1,182 @@
+/*
+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks
+ *             over a single TCP/UDP port, with=
 support for SSL/TLS-based
+ *             session authentication and key e=
xchange,
+ *             packet encryption, packet authentication, and
+ * =
            packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN =
Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can r=
edistribute it and/or modify
+ *  it under the terms of the GNU General Pub=
lic License version 2
+ *  as published by the Free Software Foundation=2E
=
+ *
+ *  This program is distributed in the hope that it will be useful,
+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Genera=
l Public License for more details=2E
+ *
+ *  You should have received a co=
py of the GNU General Public License along
+ *  with this program; if not, =
see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#i=
nclude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=
=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
=
+
+#include "control_msg=2Eh"
+#include "ssl_pkt=2Eh"
+#include "test_commo=
n=2Eh"
+#include "test_control_msg=2Eh"
+
+/* The early negotiation flags T=
LV of a reset packet asking a tls-crypt-v2
+ * client to resend its WKc=2E =
*/
+void
+test_tlv_write_u16_wire_format(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+ =
   assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false=
,
+                                       EARLY_NEG_FLAG_RESEND_WKC));
+   =
 const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    =
assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BP=
TR(&buf), expected, sizeof(expected));
+
+    /* the optional flag is the m=
ost significant bit of the type field */
+    buf_clear(&buf);
+    assert_=
true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+   =
 assert_int_equal(BPTR(&buf)[0], 0x80);
+    assert_int_equal(BPTR(&buf)[1]=
, 0x01);
+
+    gc_free(&gc);
+}
+
+/* A TLV header survives the round trip=
, the optional flag kept apart from
+ * the 15-bit type=2E */
+void
+test_t=
lv_header_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
=
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_m=
sg_tlv_write_header(&buf, 0x1234, true, 5));
+    assert_int_equal(BLEN(&bu=
f), 4);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tl=
v_read_header(&buf, &hdr));
+    assert_int_equal(hdr=2Etype, 0x1234);
+   =
 assert_true(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, 5);
+ =
   assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Walking a=
 payload returns each TLV in turn, with a value covering exactly
+ * its by=
tes, and consumes the payload=2E */
+void
+test_tlv_next_walks_payload(void=
 **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_u16(&buf, =
TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));
+    assert_true(ctrl_msg_tlv_wr=
ite_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0x1=
1223344));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x5, false, 0))=
; /* empty value */
+
+    struct ctrl_msg_tlv_header hdr;
+    struct buff=
er value;
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    a=
ssert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_false(hd=
r=2Eoptional);
+    assert_int_equal(BLEN(&value), 2);
+    assert_int_equa=
l(buf_read_u16(&value), 0xabcd);
+
+    assert_true(ctrl_msg_tlv_next(&buf,=
 &hdr, &value));
+    assert_int_equal(hdr=2Etype, 0x7ff);
+    assert_true=
(hdr=2Eoptional);
+    assert_int_equal(BLEN(&value), 4);
+    assert_int_e=
qual(buf_read_u32(&value, NULL), 0x11223344);
+
+    assert_true(ctrl_msg_t=
lv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, 0x5);
+    =
assert_int_equal(BLEN(&value), 0);
+
+    assert_int_equal(BLEN(&buf), 0);
=
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than t=
he payload holds is rejected,
+ * rather than read past the end of the payl=
oad=2E */
+void
+test_tlv_next_value_truncated(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(64, &gc)=
;
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLA=
GS, false, 8));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct ctr=
l_msg_tlv_header hdr;
+    struct buffer value;
+    assert_false(ctrl_msg_=
tlv_next(&buf, &hdr, &value));
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV =
header must fail, rather than read past the available data,
+ * when the bu=
ffer holds less than a complete 4-byte header, and must leave the
+ * buffe=
r untouched=2E */
+void
+test_tlv_header_truncated(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    const uint8_t bytes[] =3D { 0x00, 0x01,=
 0x00 };
+
+    /* 0 to 3 bytes: none, part of the type field, the type fie=
ld, and the type
+     * field with half of the length */
+    for (size_t =
n =3D 0; n <=3D sizeof(bytes); n++)
+    {
+        struct buffer buf =3D a=
lloc_buf_gc(16, &gc);
+        assert_true(buf_write(&buf, bytes, n));
+   =
     struct buffer copy =3D buf;
+
+        struct ctrl_msg_tlv_header hdr;=

+        struct buffer value;
+        assert_false(ctrl_msg_tlv_read_head=
er(&buf, &hdr));
+        assert_int_equal(BLEN(&buf), n);
+        assert_=
false(ctrl_msg_tlv_next(&copy, &hdr, &value));
+        assert_int_equal(BL=
EN(&copy), n);
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails, rather t=
han writes a partial TLV, when buf is too small=2E */
+void
+test_tlv_write=
_no_room(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+
+    stru=
ct buffer buf =3D alloc_buf_gc(3, &gc);
+    assert_false(ctrl_msg_tlv_writ=
e_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+    assert_int_equal(=
BLEN(&buf), 0);
+
+    /* room for the header but not the value */
+    buf=
 =3D alloc_buf_gc(5, &gc);
+    assert_false(ctrl_msg_tlv_write_u16(&buf, T=
LV_TYPE_EARLY_NEG_FLAGS, false, 1));
+    assert_int_equal(BLEN(&buf), 0);
=
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_control_=
msg=2Eh b/tests/unit_tests/openvpn/test_control_msg=2Eh
new file mode 10064=
4
index 0000000=2E=2Eef7a030
--- /dev/null
+++ b/tests/unit_tests/openvpn/t=
est_control_msg=2Eh
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -- An application to =
securely tunnel IP networks
+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based
+ *             session authentication and key =
exchange,
+ *             packet encryption, packet authentication, and
+ *=
             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN=
 Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can =
redistribute it and/or modify
+ *  it under the terms of the GNU General Pu=
blic License version 2
+ *  as published by the Free Software Foundation=2E=

+ *
+ *  This program is distributed in the hope that it will be useful,
+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Gener=
al Public License for more details=2E
+ *
+ *  You should have received a c=
opy of the GNU General Public License along
+ *  with this program; if not,=
 see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_CONTROL_MS=
G_H
+#define TEST_CONTROL_MSG_H
+
+void test_tlv_write_u16_wire_format(void=
 **state);
+
+void test_tlv_header_roundtrip(void **state);
+
+void test_tl=
v_next_walks_payload(void **state);
+
+void test_tlv_next_value_truncated(v=
oid **state);
+
+void test_tlv_header_truncated(void **state);
+
+void test=
_tlv_write_no_room(void **state);
+#endif
diff --git a/tests/unit_tests/ope=
nvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fbbb40f=2E=
=2E7dc07aa 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_pkt=2Ec
@@ -37,12 +37,14 @@
 #include "crypto=2Eh"
 =
#include "options=2Eh"
 #include "ssl_backend=2Eh"
+#include "control_msg=
=2Eh"
 #include "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
 #include "mss=2E=
h"
 #include "reliable=2Eh"
 #include "siphash=2Eh"
+#include "test_control=
_msg=2Eh"
 
 int
 parse_line(const char *line, char **p, const int n, const=
 char *file, const int line_num,
@@ -655,6 +657,45 @@
     free_buf(&tas=2E=
workbuf);
 }
 
+/* A reset reply asking a tls-crypt-v2 client to resend its=
 WKc ends in the
+ * early negotiation flags TLV, and that TLV parses back=
=2E */
+static void
+test_generate_reset_packet_resend_wkc(void **ut_state)=

+{
+    struct tls_auth_standalone tas =3D { 0 };
+
+    struct session_id=
 client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
+    struct session_id serve=
r_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };
+
+    tas=2Etls_wrap=2Emode =3D T=
LS_WRAP_NONE;
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 20=
0, =2Epayload_size =3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
+    tas=2E=
workbuf =3D alloc_buf(1600);
+
+    uint8_t header =3D 0 | (P_CONTROL_HARD_=
RESET_SERVER_V2 << P_OPCODE_SHIFT);
+
+    struct buffer plain =3D
+       =
 tls_reset_standalone(&tas=2Etls_wrap, &tas, &client_id, &server_id, header=
, false);
+    const int plain_len =3D BLEN(&plain);
+    struct buffer buf=
 =3D
+        tls_reset_standalone(&tas=2Etls_wrap, &tas, &client_id, &serv=
er_id, header, true);
+
+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x=
02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), plain_len + (int)sizeof=
(tlv));
+    assert_memory_equal(BPTR(&buf) + plain_len, tlv, sizeof(tlv));=

+
+    struct buffer payload =3D buf;
+    assert_true(buf_advance(&payloa=
d, plain_len));
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer val=
ue;
+    assert_true(ctrl_msg_tlv_next(&payload, &hdr, &value));
+    asser=
t_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_int_equal(bu=
f_read_u16(&value), EARLY_NEG_FLAG_RESEND_WKC);
+    assert_int_equal(BLEN(=
&payload), 0);
+
+    free_buf(&tas=2Eworkbuf);
+}
+
 static void
 test_gen=
erate_reset_packet_tls_auth(void **ut_state)
 {
@@ -791,9 +832,16 @@
      =
   cmocka_unit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(t=
est_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_gene=
rate_reset_packet_plain),
+        cmocka_unit_test(test_generate_reset_pac=
ket_resend_wkc),
         cmocka_unit_test(test_generate_reset_packet_tls_a=
uth),
         cmocka_unit_test(test_wkc_not_appended_without_key),
-      =
  cmocka_unit_test(test_extract_control_message)
+        cmocka_unit_test(=
test_extract_control_message),
+        cmocka_unit_test(test_tlv_write_u16=
_wire_format),
+        cmocka_unit_test(test_tlv_header_roundtrip),
+     =
   cmocka_unit_test(test_tlv_next_walks_payload),
+        cmocka_unit_test=
(test_tlv_next_value_truncated),
+        cmocka_unit_test(test_tlv_header_=
truncated),
+        cmocka_unit_test(test_tlv_write_no_room)
     };
 
   =
  return cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c=
10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 7
Gerrit-=
Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>

--JLmPxr393Vw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, R=C4=
=83zvan Cojocaru=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #7</str=
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
d=2E How to treat an unknown type is up to each<br>message=2E With the opti=
onal flag clear the codec writes the same bytes as<br>the hand-rolled code =
it replaces=2E<br><br>In the codec the most significant bit of the type fie=
ld is the<br>&quot;optional&quot; flag rather than part of the type=2E The =
old parser compared<br>the whole type word, so 0x8001 did not match the fla=
gs TLV and was<br>skipped as unknown; now it matches and is parsed as one=
=2E<br><br>Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<=
br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_msg=2Ec<br>A src/op=
envpn/control_msg=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec=
<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<b=
r>A tests/unit_tests/openvpn/test_control_msg=2Ec<br>A tests/unit_tests/ope=
nvpn/test_control_msg=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>11 =
files changed, 490 insertions(+), 23 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/196=
5/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><spa=
n>index 5cf1a30=2E=2E305c26c 100644</span><br><span>--- a/CMakeLists=2Etxt<=
/span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -457,6 +457,8 @@<=
/span><br><span>     src/openvpn/console=2Ec</span><br><span>     src/openv=
pn/console_builtin=2Ec</span><br><span>     src/openvpn/console=2Eh</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/control_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><br><spa=
n>     src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/crypto_backe=
nd=2Eh</span><br><span>@@ -896,6 +898,8 @@</span><br><span> </span><br><spa=
n>     target_sources(test_pkt PRIVATE</span><br><span>         tests/unit_=
tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        tests/unit_tests/openvpn/test_control_msg=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/contr=
ol_msg=2Ec</span><br><span>         src/openvpn/argv=2Ec</span><br><span>  =
       src/openvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_e=
poch=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openv=
pn/Makefile=2Eam</span><br><span>index bb31053=2E=2Ebe1044d 100644</span><b=
r><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/M=
akefile=2Eam</span><br><span>@@ -57,6 +57,7 @@</span><br><span> 	common=2Eh=
 \</span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	com=
p-lz4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=
=2Eh crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec crypto_opens=
sl=2Eh \</span><br><span> 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \</span><b=
r><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E0726941</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
control_msg=2Ec</span><br><span>@@ -0,0 +1,90 @@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool o=
ptional, uint16_t value_len)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* th=
e type has 15 bits; the top bit is the optional flag */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(type &lt;=3D CTRL_MSG_TLV_TY=
PE_MASK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Write nothing unless t=
he whole TLV fits=2E The header promises that</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * value_len bytes follow it, so a header wri=
tten without room for the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * value would leave a partial TLV in buf=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(buf, (size_t)CTRL_M=
SG_TLV_HEADER_LEN + value_len))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t f=
ield =3D type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (optional)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        field |=3D CT=
RL_MSG_TLV_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn buf_write_u16(buf, field) &amp;&amp; buf_write_u16(buf, value_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, ui=
nt16_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_=
write_header(buf, type, optional, sizeof(uint16_t))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, =
value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv=
_header *hdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Read nothing unle=
ss the whole header is there, so that a truncated</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * header leaves buf untouched=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(buf) &lt; C=
TRL_MSG_TLV_HEADER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D=
 (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    hdr-&gt;value_len =3D (uint16_t)buf_read_u16(buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;type =3D field &am=
p; CTRL_MSG_TLV_TYPE_MASK;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    hdr-&gt;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hd=
r, struct buffer *value)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl=
_msg_tlv_read_header(buf, hdr))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false; /* fewer than 4 bytes left: truncated header */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Advance past the value; fails if b=
uf is shorter than the header claims=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const uint8_t *v =3D buf_read_alloc(buf, hdr-&gt=
;value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(value, v, hdr-&gt;value_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
>diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E9a98b2=
1</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_m=
sg=2Eh</span><br><span>@@ -0,0 +1,107 @@</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             session authentication and key excha=
nge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet encryption, packet authentication, and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales=
@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s free software; you can redistribute it and/or modify</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Genera=
l Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  as published by the Free Software Foundation=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is distributed in the hope that it w=
ill be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  b=
ut WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  GNU General Public License for more details=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/li=
censes/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * TLV framing shared by the TLV-based control messages of the wire=
 protocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Such a message payloa=
d is a sequence of TLV entries=2E Each TLV starts with a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * 4-byte header: a 16-bit field whose=
 most significant bit is the &quot;optional&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * flag and whose remaining 15 bits are the t=
ype, followed by a 16-bit length</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * giving the size of the value that follows the header=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * All of these messages share one TLV t=
ype space, so the TLV types are all</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * defined here=2E Only the framing is handled here: what a=
 message does with a</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * TLV type it does not know, marked optional or not, is up to its parser=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* TLV types */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset pa=
ckets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV header is a 16-bit ty=
pe/optional field plus a 16-bit length */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CTRL_MSG_TLV_HEADER_LEN 4</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* bit layout of the first 16-bit field */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_OPTIONAL_FLAG =
0x8000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_=
MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** The he=
ader every TLV carries: the 15-bit type and optional flag packed into</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the first 16-bit field=
, then the length of the value that follows=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint16_t type;      /**&lt; the 15-bit TLV type */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool optional;   =
   /**&lt; value of the optional flag */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint16_t value_len; /**&lt; length of the value fo=
llowing the header */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Write a TLV header (type + optional flag + valu=
e length) to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * type must fit in the 15 bits of the type field=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Nothing is written unless the header and the value_len =
bytes of value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * th=
at follow it both fit, so a failed write never leaves a partial TLV</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * behind=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true on success, false if buf has insuff=
icient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_wr=
ite_header(struct buffer *buf, uint16_t type, bool optional,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                               uin=
t16_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Write a complete TLV whose value i=
s a single 16-bit integer to buf=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true on success, false if buf has insufficient space=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_u16(struct buffer *bu=
f, uint16_t type, bool optional, uint16_t value);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Re=
ad a TLV header from buf, advancing past it=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buf  buffer positioned at the TLV header</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr  filled with the typ=
e, optional flag and value length on success</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return true on success, false if there are not=
 enough bytes for a header=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool c=
trl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Read the next TLV from buf, advancing past its he=
ader and value=2E Call it</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * while BLEN(buf) &gt; 0 to walk a whole payload=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * The length from the header is validated against bu=
f, so on success the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * whole value is present: a header claiming more bytes than buf holds is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejected=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf    buffer positioned at a T=
LV header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
hdr    filled with the TLV&#39;s type, optional flag and value length</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param value  set to a=
 buffer covering exactly the TLV&#39;s value; it points</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *               into buf and owns no s=
torage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return tr=
ue on success, false if the header or the value is truncated; buf</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *         may then be left p=
artly consumed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_=
next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *va=
lue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef CONTROL_MSG_H */=
</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</sp=
an><br><span>index 420daef=2E=2E9a72614 100644</span><br><span>--- a/src/op=
envpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ =
-52,6 +52,7 @@</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><=
span> #include &quot;route=2Eh&quot;</span><br><span> #include &quot;tls_cr=
ypt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;control_msg=2Eh&quot;</span><br><span> </span><br><span> #include =
&quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;<=
/span><br><span>@@ -2644,26 +2645,21 @@</span><br><span> {</span><br><span>=
     while (buf-&gt;len &gt; 0)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (buf_len(buf) &lt; 4)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* read type */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        int type =3D buf_read_u16(buf);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        int len =3D buf_read_u16(=
buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (type=
 &lt; 0 || len &lt; 0 || buf_len(buf) &lt; len)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header hdr;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer value=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ctrl_=
msg_tlv_next(buf, &amp;hdr, &amp;value))</span><br><span>         {</span><=
br><span>             goto error;</span><br><span>         }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        switch (ty=
pe)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        switch (=
hdr=2Etype)</span><br><span>         {</span><br><span>             case TL=
V_TYPE_EARLY_NEG_FLAGS:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if (len !=3D sizeof(uint16_t))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (BLEN(&amp;value) !=3D size=
of(uint16_t))</span><br><span>                 {</span><br><span>          =
           goto error;</span><br><span>                 }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                int flags =3D buf_read_=
u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      int flags =3D buf_read_u16(&amp;value);</span><br><span> </span><br><=
span>                 if (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br>=
<span>                 {</span><br><span>@@ -2682,8 +2678,8 @@</span><br><s=
pan>                 break;</span><br><span> </span><br><span>             =
default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   /* Skip types we do not parse */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                buf_advance(buf, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* Skip types we do not p=
arse, marked optional or not */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                break;</span><br><span>         }</span><br><sp=
an>     }</span><br><span>     reliable_mark_deleted(ks-&gt;rec_reliable, b=
uf);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl=
_pkt=2Ec</span><br><span>index f78782f=2E=2Ef4564ef 100644</span><br><span>=
--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec=
</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;reliable=
=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br><spa=
n> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> </s=
pan><br><span> /*</span><br><span>  * Dependent on hmac size, opcode size, =
and session_id size=2E</span><br><span>@@ -432,9 +433,8 @@</span><br><span>=
     /* Add indication for tls-crypt-v2 to resend the WKc with the reply */=
</span><br><span>     if (request_resend_wkc)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;b=
uf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, sizeof(uint16_t)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u=
16(&amp;buf, EARLY_NEG_FLAG_RESEND_WKC);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ASSERT(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TY=
PE_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                      EARLY_NEG_FLAG_RESEND_WKC));</=
span><br><span>     }</span><br><span> </span><br><span>     /* Add tls-aut=
h/tls-crypt wrapping, this might replace buf with</span><br><span>diff --gi=
t a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index=
 8203e4a=2E=2E218c6bb 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh<=
/span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -306,10 +3=
06,8 @@</span><br><span> #define EARLY_NEG_START 0x0f000000</span><br><span=
> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* Early negotiation that part of the server response in the RESET_V2 packet=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Since clients t=
hat announce early negotiation support will treat the payload</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * of reset packets special and par=
se it as TLV messages=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * as TLV (type, length, value) */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Early negotiation: clients that ann=
ounce support for it parse the payload of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * the reset packets as TLVs (see control_msg=2Eh)=2E=
 Flags carried in the value of</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */</span><br><span> #define=
 EARLY_NEG_FLAG_RESEND_WKC 0x0001</span><br><span> #endif /* ifndef SSL_PKT=
_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 70cf7b2=2E=2E=
11f92f4 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -164,11 +164,15 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_=
srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CF=
LAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =3D test_=
pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCE=
S =3D test_pkt=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	test_control_msg=2Ec test_control_msg=2Eh \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_common=2Eh \=
</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buff=
er=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/control_msg=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_control_msg=2Ec b/test=
s/unit_tests/openvpn/test_control_msg=2Ec</span><br><span>new file mode 100=
644</span><br><span>index 0000000=2E=2E795ec9dd</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/tests/unit_tests/openvpn/test_control_msg=2Ec</spa=
n><br><span>@@ -0,0 +1,182 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;test_control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The=
 early negotiation flags TLV of a reset packet asking a tls-crypt-v2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * client to resend its WK=
c=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_u16_wire_for=
mat(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_=
NEG_FLAGS, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                     EARLY_NEG_FLAG_RESEND_WKC));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t expected[] =
=3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), sizeof(expecte=
d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* the optional flag is the most significant bit of the =
type field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_clear(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, t=
rue, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(BPTR(&amp;buf)[0], 0x80);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[1], 0x01);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV h=
eader survives the round trip, the optional flag kept apart from</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * the 15-bit type=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_roundtrip(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x1234, true, 5));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
buf), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_heade=
r hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x1234);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(hdr=2Eo=
ptional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(hdr=2Evalue_len, 5);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Walking a payload=
 returns each TLV in turn, with a value covering exactly</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * its bytes, and consumes the payload=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_walks_payload(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG=
_FLAGS, false, 0xabcd));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_=
write_u32(&amp;buf, 0x11223344));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x5, fals=
e, 0)); /* empty value */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ct=
rl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_T=
YPE_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 2);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_read_u16(&a=
mp;value), 0xabcd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x7ff);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(hdr=2Eopt=
ional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;value), 4);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(buf_read_u32(&amp;value, NULL), 0x11223344)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&am=
p;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(hdr=2Etype, 0x5);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* A TLV header claiming more value bytes than the payload holds is reject=
ed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rather than r=
ead past the end of the payload=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_tlv_next_value_truncated(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_=
header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, =
0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading a TLV h=
eader must fail, rather than read past the available data,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * when the buffer holds less than a=
 complete 4-byte header, and must leave the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * buffer untouched=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_tlv_header_truncated(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t bytes[] =3D { 0x00, 0x0=
1, 0x00 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 to 3 bytes: none, p=
art of the type field, the type field, and the type</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * field with half of the length */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t n =3D=
 0; n &lt;=3D sizeof(bytes); n++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        assert_true(buf_write(&amp;buf=
, bytes, n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct buffer copy =3D buf;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct buffer value;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        assert_false(ctrl_msg_tlv_read_header(&amp;buf,=
 &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 assert_int_equal(BLEN(&amp;buf), n);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        assert_false(ctrl_msg_tlv_next(&amp;copy, &amp;hd=
r, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     assert_int_equal(BLEN(&amp;copy), n);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Writing fails, rather than writes a partia=
l TLV, when buf is too small=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_tlv_write_no_room(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer buf =3D alloc_buf_gc(3, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_write_header(&am=
p;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* room for the header but not the value */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_bu=
f_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, f=
alse, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_control_msg=2Eh b/t=
ests/unit_tests/openvpn/test_control_msg=2Eh</span><br><span>new file mode =
100644</span><br><span>index 0000000=2E=2Eef7a030</span><br><span>--- /dev/=
null</span><br><span>+++ b/tests/unit_tests/openvpn/test_control_msg=2Eh</s=
pan><br><span>@@ -0,0 +1,37 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef TEST_CONTROL_MSG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TEST_CONTROL_MSG_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void test_tlv_write_u16_wire_format(void **state);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_tlv_header_roundtrip(void **sta=
te);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_next_walks_payload(v=
oid **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_next_value_=
truncated(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_=
header_truncated(void **state);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void te=
st_tlv_write_no_room(void **state);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>inde=
x fbbb40f=2E=2E7dc07aa 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec<=
/span><br><span>@@ -37,12 +37,14 @@</span><br><span> #include &quot;crypto=
=2Eh&quot;</span><br><span> #include &quot;options=2Eh&quot;</span><br><spa=
n> #include &quot;ssl_backend=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> #=
include &quot;ssl_pkt=2Eh&quot;</span><br><span> #include &quot;tls_crypt=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;mss=2Eh&quot;<=
/span><br><span> #include &quot;reliable=2Eh&quot;</span><br><span> #includ=
e &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;test_control_msg=2Eh&quot;</span><br><span> </span><br=
><span> int</span><br><span> parse_line(const char *line, char **p, const i=
nt n, const char *file, const int line_num,</span><br><span>@@ -655,6 +657,=
45 @@</span><br><span>     free_buf(&amp;tas=2Eworkbuf);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* A reset reply asking a tls-crypt-v2 client to resend its WKc ends in the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * early negotiation=
 flags TLV, and that TLV parses back=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_generate_reset_packet_resend_wkc(void **ut_state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct session_id client_id =
=3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6=
, 2 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D =
TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =
=3D 1400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 tas=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    tas=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 &lt;&lt; P_O=
PCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer plain =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_rese=
t_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id, &amp;server_id,=
 header, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const int plain_len =3D BLEN(&amp;plain);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wr=
ap, &amp;tas, &amp;client_id, &amp;server_id, header, true);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02,=
 0x00, 0x01 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(BLEN(&amp;buf), plain_len + (int)sizeof(tlv));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&am=
p;buf) + plain_len, tlv, sizeof(tlv));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer payload =3D buf;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(buf_advance(&amp;payload, plain_len));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_h=
eader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(ctrl_msg_tlv_next(&amp;payload, &amp;hdr, &amp;value));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2E=
type, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(buf_read_u16(&amp;value), EARLY_NEG_FLAG_=
RESEND_WKC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(BLEN(&amp;payload), 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   free_buf(&amp;tas=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> static void</span><br><span> test_generate_reset_packet_tls_au=
th(void **ut_state)</span><br><span> {</span><br><span>@@ -791,9 +832,16 @@=
</span><br><span>         cmocka_unit_test(test_verify_hmac_tls_auth),</spa=
n><br><span>         cmocka_unit_test(test_verify_hmac_none_out_of_range_ac=
k),</span><br><span>         cmocka_unit_test(test_generate_reset_packet_pl=
ain),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_generate_reset_packet_resend_wkc),</span><br><span>        =
 cmocka_unit_test(test_generate_reset_packet_tls_auth),</span><br><span>   =
      cmocka_unit_test(test_wkc_not_appended_without_key),</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_extract_=
control_message)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_extract_control_message),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_write_u=
16_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_tlv_header_roundtrip),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_walks_=
payload),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_tlv_next_value_truncated),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_truncat=
ed),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_tlv_write_no_room)</span><br><span>     };</span><br><span> =
</span><br><span>     return cmocka_run_group_tests_name(&quot;pkt tests&qu=
ot;, tests, NULL, NULL);</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89c3=
133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lst=
ipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--JLmPxr393Vw=--


--===============2460951762535362594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2460951762535362594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2460951762535362594==--

