Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642AD607113B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ym/uH4Ma;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TDr6zl6C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OcAcQk4m;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Y7k5Uuyl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M8oMMAkxCebBNiFInSZQKtcoVmuZpqnIMbwL1RU488o=; b=Ym/uH4MaNlwqWXZRUDmQi6rISR
	ecMhToNx6OV1AOwOkYhG5sjTfg2mE8pkzINpr/EQAwDLLc/79ux6x7krCtAEDjqAgXLB2eYsfEOg/
	gEyJBT0tL6RI095uZbfksxYfjxYjZ3gdoBT7oezHkm7zTXkcCzn4+WwZfg6jnjoxtxs8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP3Pu-000000007wG-0Bri;
	Thu, 05 Nov 2026 19:46:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP3Pt-000000007w4-0z2x
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kX/XxFcGpVFAHQZ6hMyP1Kss8jbil2Sfh6bbZz+kXD0=; b=TDr6zl6C60rZfoX4R+C5dyMfBq
 ig6bth0/TROsue2rh5kiXnUe2dMHuvDHHJbs0qTtHMZKYok44gtnC+Z22dxAsuQgNe93TuoMSAveH
 4Q7oNGjIXePOTxeTY89cY88J3CAGr4lum77KAjepR/sJeDEkgMK0KsfKP0F47DQaHAEE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kX/XxFcGpVFAHQZ6hMyP1Kss8jbil2Sfh6bbZz+kXD0=; b=OcAcQk4mS3S7pJi88tCdKOiaHb
 fNsJolJlMzUzNA/6u47I4OwLW8aHU+CLtuE6ZN6tUDXD1rnqdhhO/U3Ht3DVQ/y+ulKZ6gFhmxioW
 VX1VZUBPfq29FOLGFNLCgEg9E/JxuqkWc/hJs5frW9zePDPE29dDm5PIPEcHSQXCpbx8=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP3Pq-000000006s2-1ggA for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:46:33 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1040646f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793907984; x=1794512784; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kX/XxFcGpVFAHQZ6hMyP1Kss8jbil2Sfh6bbZz+kXD0=;
 b=Y7k5Uuyl4WRTgpP6Vd1VT4D6EK2XDP7eiu8rcuPNBdorzGqBbufigMalIOxNq6uPYh
 tAebz3J/fiPlekMHUMV+OSNtcdyu57Vy21sXazfxofHXv0MoWO8faseGGHUQce2nrAoj
 DeCYq4QmxSobU7RweyUgx4aM4hl3c25SRCm5WKTr2lBtJ+JISYaf7NsYttpTePSfT2HD
 M++bTZpQcI6DL6a78XzuG4y/mw2zTkbfMhVcTh0OTPwmiHz4Z4PuWbJUkxiD9WCanh60
 cOALc5kN9+x69Mh09Z5UUDa75FJIzHNg1DPSdu1rTRT+HkYgiApQeeFLRXoTo1XjMnN/
 E77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793907984; x=1794512784;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kX/XxFcGpVFAHQZ6hMyP1Kss8jbil2Sfh6bbZz+kXD0=;
 b=hW7+I1FO4XXbn7KKfcUrOc2I5fog/K8o1nNv7cLy6F8YmqWotPqdP8tPgBJtQ12NSV
 zm+br4iQrLoiM12AE58JAIfj4gNFNKeHp+UYQp+t/MGoroqIHDsrEaYakw/e+3AA69hf
 FjjbKxKKVO1SYtaIl3cp6wX+z47csEJBztsHdC0AXcfRmmqULOtGx6L6Qugjht0qLuq5
 BPrElXIrBCQb7jhdeNmApo0mAsxhMYvhIgJwbkOlAZ3NYobu6peoGnL7Dw1ofYuMCBNY
 s9fxV6lzYHxhHx9KEmcMu8F3TTphiyIY02nk4XJ4WIG6RZoM1BT3DZ6zJv0IeD5Sb24H
 tNuQ==
X-Gm-Message-State: APuU4Z+tL06PdzTlp3YUZPBDu39ifnYpaOrpEGS4wZ4kFSpYW0VrEqoi
 ttrtSDpBq2P2EN/Hvrw3JhUN2iRrIovfnkrX+CioEeh8KQsJMQ6IlPLAOPoSg8CT+MxePJQdEfN
 GQ6qV0xmc24pwBqlvFvxiP36/f8AzMNbPtK5gGwm7Gz8+U4FyifwBYU+styHIpaddtKjZI6s9JK
 yVifmI/g==
X-Gm-Gg: AYBFou3OlE5ZrcauQKgI73HkN2tr5yhxfXpLmJlIJrSi/7IbfViGzRm698ANGVvwfCD
 caBCkYVdQBZid0RI6RpMsTGKOzZbVUaAKjjTowUykIeGDpH9pHyPWfcxwFaK0U3rvmOTe+drlnz
 EN6LgIuVFO5/yijPQH3jNVIIQ6mjhPezTHmIQ2//mkydHWV2jl8mqX8HM8+tI0z45p1pRL2nxpT
 2hn8L8ulWWj8w9woXeBaKMHdgYiEI9ivB4Bb0eQCqjbKajHA0HO2WZgDT+w8Hh5PJ06uRu5oRWZ
 NDjoIwDCoWtSiQTWeRffaBfXML+V/CsKp/rnou/W/Ex6NsjbmI8OcYUwZQPQeEJyE5O3utyuwky
 VqU9pbGiIRsTqrdv/r6XO94EDuo9oRtIZOfC7gp9Yuw4LVocs4nu0pphNFdrnsDpRWyunlHSJxN
 Q9Bi6A/rXXNPq2sAxmhKlzwubuRlrKb8hIbXeaapBoJxygd6H7c3tP+60+U6fquwflB9QiIkc+X
 xo9X4kKt/5RzrB/Pqjj5SdGW7V43YH9j8y+m1meIJuZ39IeNrzmCM4AzgpbSuH0wvO9950KcIuN
 10UjNImtWE32KdBnGf7XIaJPE4t0Hlb/otm3Z5qWpsojIJrEpKCPJuIFCrrC9T4nVhGrMdCGVpp
 5Jux/iQTN/pLuNzhHBq1uFr3C1zm2uW3ko+cR9TfBbTjVDLpDZPVpZ+f3Ewk0SuaQwWc9i04T/T
 iUML5Xejmf1I7wOQHeEQpb9YCpPSi1MMlbCeQ=
X-Received: by 2002:a05:600c:6990:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4b6dd82aa17mr2259565e9.9.1793907983621; 
 Thu, 05 Nov 2026 11:46:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b432a883ffsm68438515e9.3.2026.11.05.11.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:46:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 19:46:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
X-Gerrit-Change-Number: 2107
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2107?usp=email>
X-Gerrit-Commit: adf5ecfd8f09da1935a00b039cc0b92bc800c87d
In-Reply-To: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
References: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkkzNjQzMGJhYjg5N2U1ZmU5YjFjZmQ0OGRlNTAyMjQzOTVkNTZkOGZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e33c4ab504c2035b563eab8745653556fa74b483-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP3Pq-000000006s2-1ggA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Provide minimal
 netlink defines for cppcheck on FreeBSD and macOS
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6674134921347266756=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6674134921347266756==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZOYjhmLYtSo="; charset=UTF-8

--ZOYjhmLYtSo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Frank Lichtenheld


Change subject: Provide minimal netlink defi=
nes for cppcheck on FreeBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Provide minimal netlink defines for cppcheck on F=
reeBSD and macOS

Without these defines and the hidden goto inside the NLA_=
PUT functions
cppcheck complains about ret in dco_linux=2Ec=2E This allows =
to run
cppcheck on macOS and FreeBSD without triggering these warnings=2E

=
Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107
Message=
-Id: <20261103141439=2E14041-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40579=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
A dev-tools/openv=
pn-cppcheck-netlink=2Ecfg
M dev-tools/run-cppcheck=2Esh
2 files changed, 10=
 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/07/2107/2

diff --git a/dev-tools/openvpn-cppcheck=
-netlink=2Ecfg b/dev-tools/openvpn-cppcheck-netlink=2Ecfg
new file mode 100=
644
index 0000000=2E=2Eb63adf0
--- /dev/null
+++ b/dev-tools/openvpn-cppche=
ck-netlink=2Ecfg
@@ -0,0 +1,7 @@
+<?xml version =3D"1=2E0"?>
+<def>
+  <!--=
 minimal defines to supress the errors on non-Linux platforms that do not h=
ave the netlink headers -->
+  <define name=3D"NLA_PUT(msg, attrtype, attrl=
en, data)" value=3D"if (nla_cppcheck_dummy(msg, attrtype, attrlen, data) < =
0) goto nla_put_failure;" />
+  <define name=3D"NLA_PUT_U32(msg, attrtype, =
value)" value=3D"NLA_PUT(msg, uint32_t, attrtype, value)" />
+  <define nam=
e=3D"NLA_PUT_STRING(msg, attrtype, value)" value=3D"NLA_PUT(msg, attrtype, =
(int) strlen(value) + 1, value)" />
+</def>
diff --git a/dev-tools/run-cppc=
heck=2Esh b/dev-tools/run-cppcheck=2Esh
index d1c22c5=2E=2Edebcd46 100755
-=
-- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -20,9=
 +20,11 @@
 if [ $(uname) =3D "Darwin" ] || [ $(uname) =3D "FreeBSD" ]; the=
n
     SCRIPT_DIR=3D$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
     num_=
procs=3D$(sysctl -n hw=2Encpu)
+    EXTRA_LIBRARY=3D"--library=3D${SCRIPT_D=
IR}/openvpn-cppcheck-netlink=2Ecfg"
 else
     SCRIPT_DIR=3D$(dirname $(rea=
dlink -e "${BASH_SOURCE[0]}"))
     num_procs=3D$(nproc)
+    EXTRA_LIBRARY=
=3D""
 fi
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$PWD}
@@=
 -35,6 +37,7 @@
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
  --enable=3Dall=
 ${disable_arg} \
  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecf=
g \
+ ${EXTRA_LIBRARY} \
  --library=3Dopenssl=2Ecfg \
  --suppress-xml=3D$=
{SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-suppr \
  --cppcheck-buil=
d-dir=3D${CPPCHECK_DIR} \

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2107?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
Gerrit-Change-Number: =
2107
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ZOYjhmLYtSo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/210=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Provid=
e minimal netlink defines for cppcheck on FreeBSD and macOS<br><br>Without =
these defines and the hidden goto inside the NLA_PUT functions<br>cppcheck =
complains about ret in dco_linux=2Ec=2E This allows to run<br>cppcheck on m=
acOS and FreeBSD without triggering these warnings=2E<br><br>Change-Id: I36=
430bab897e5fe9b1cfd48de50224395d56d8fc<br>Signed-off-by: Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107<b=
r>Message-Id: &lt;20261103141439=2E14041-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg40579=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>A dev-tools/openvpn-cppcheck-netlink=2Ecfg<br>M dev-tools/r=
un-cppcheck=2Esh<br>2 files changed, 10 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/07/2107/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/dev-tools/openvpn-cppcheck-netli=
nk=2Ecfg b/dev-tools/openvpn-cppcheck-netlink=2Ecfg</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2Eb63adf0</span><br><span>--=
- /dev/null</span><br><span>+++ b/dev-tools/openvpn-cppcheck-netlink=2Ecfg<=
/span><br><span>@@ -0,0 +1,7 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+&lt;?xml version =3D&quot;1=2E0&quot;?&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+&lt;def&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;!-- minimal defines to supress the errors =
on non-Linux platforms that do not have the netlink headers --&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;NL=
A_PUT(msg, attrtype, attrlen, data)&quot; value=3D&quot;if (nla_cppcheck_du=
mmy(msg, attrtype, attrlen, data) &lt; 0) goto nla_put_failure;&quot; /&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=
=3D&quot;NLA_PUT_U32(msg, attrtype, value)&quot; value=3D&quot;NLA_PUT(msg,=
 uint32_t, attrtype, value)&quot; /&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;define name=3D&quot;NLA_PUT_STRING(msg, attrtype,=
 value)&quot; value=3D&quot;NLA_PUT(msg, attrtype, (int) strlen(value) + 1,=
 value)&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
&lt;/def&gt;</span><br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev=
-tools/run-cppcheck=2Esh</span><br><span>index d1c22c5=2E=2Edebcd46 100755<=
/span><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev=
-tools/run-cppcheck=2Esh</span><br><span>@@ -20,9 +20,11 @@</span><br><span=
> if [ $(uname) =3D &quot;Darwin&quot; ] || [ $(uname) =3D &quot;FreeBSD&qu=
ot; ]; then</span><br><span>     SCRIPT_DIR=3D$(dirname $(readlink -f &quot=
;${BASH_SOURCE[0]}&quot;))</span><br><span>     num_procs=3D$(sysctl -n hw=
=2Encpu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EXTRA_L=
IBRARY=3D&quot;--library=3D${SCRIPT_DIR}/openvpn-cppcheck-netlink=2Ecfg&quo=
t;</span><br><span> else</span><br><span>     SCRIPT_DIR=3D$(dirname $(read=
link -e &quot;${BASH_SOURCE[0]}&quot;))</span><br><span>     num_procs=3D$(=
nproc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EXTRA_LIB=
RARY=3D&quot;&quot;</span><br><span> fi</span><br><span> : ${SOURCE_DIR:=3D=
$SCRIPT_DIR/=2E=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br><span=
>@@ -35,6 +37,7 @@</span><br><span>  -I${BUILD_DIR} -I${BUILD_DIR}/include/=
 \</span><br><span>  --enable=3Dall ${disable_arg} \</span><br><span>  --li=
brary=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ ${EXTRA_LIBRARY} \</span><br><span>  --=
library=3Dopenssl=2Ecfg \</span><br><span>  --suppress-xml=3D${SCRIPT_DIR}/=
cppcheck-suppressions=2Exml --inline-suppr \</span><br><span>  --cppcheck-b=
uild-dir=3D${CPPCHECK_DIR} \</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107?usp=3Demail">change 2107</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
6430bab897e5fe9b1cfd48de50224395d56d8fc </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2107 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--ZOYjhmLYtSo=--


--===============6674134921347266756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6674134921347266756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6674134921347266756==--

