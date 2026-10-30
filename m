Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AF606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L5FaExCV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YFfUSSfx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KpkxONT/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IjLG3iox
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XzmMeNlhWofPZhgv9xsfLe8sdYrG7WDw3+nfIBj8x/8=; b=L5FaExCV/I1GTbepc6IMxBFoz4
	/LbadhY+I+x1x5ugwLNHaqkZ68U2PUyKUFhZA0uaoIIyBPofiw4ePP9VdPhKFIX/XK6ULrKNGYNiy
	mLqhYCgrG4ZNsvD0zw7ZXXgIkCZ3VlUV+eNUG0qPPWv4zSPkiJqkwDwgYHLUPk/d98CE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMpGZ-000000008M5-26zF;
	Fri, 30 Oct 2026 16:15:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMpGX-000000008Lr-2ry6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:15:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y8Og3gICiT6qPhWWwb1iHFYuzscWZXQVPmOiNSGGRco=; b=YFfUSSfxKS/w2HTAT2hG4E/9xC
 o1Z995C27RBPP7qeZ9j3lhb8lsrhwXterExmvFH97pVM2ctGuOHVf1CtZ/pVOoEqwzryowk1wA4OK
 pqyiOipHygGcfvqriWvDEDOfUDR6qHOWVSXwHk3T5guK9D0GV1UL2YsrhX6TOHUmLgcg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y8Og3gICiT6qPhWWwb1iHFYuzscWZXQVPmOiNSGGRco=; b=KpkxONT/57PkDyONuAJiip4jrP
 OH+y4lpfAEOek4Rz2JdWyV/OxioJNQqjQrgGShRrlmJ1SlhG4een7vBva9LqKDByUwDvhM42LIqXM
 Oyb0m6ZckWrbKtlHUWr+NcrlDuf5y/e+V08+zmI4qiCCfvNnYfNoixZxXYZM1c8Y8i9M=;
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMpGQ-0000000068r-29FO for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:15:41 +0000
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so1136711a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793376928; x=1793981728; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y8Og3gICiT6qPhWWwb1iHFYuzscWZXQVPmOiNSGGRco=;
 b=IjLG3ioxTBF0DxO9DFVkzaEAtfGmqZ4zUqBw+BWnB+bdC/u0B95jG3+vSkaItaZWZn
 pcUcpKQtyk5gxoxMXieowFpWUNQAWhGX+4FWtuBuuVRINl6qtt2utknd+w4eaeE62+Bp
 ZaiiTZc1wWIz7pFFt4sBdIDmEvpwg07kVs3lznBEmZKrts5Vf8paWqzZqHHq8WhlM07Q
 yObkJyh64fsj31m7Ld7Ypl4nul1ra+X4t7Yfl5qVflEi7kcaITir2WbaFoFxaTZg3qsF
 qf6E1CT9ctgYB6Ykq48BOBuGc9we5eWvj3eWOgyWW3SNW9/XfLtOr3P032UbKSstY41g
 CM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793376928; x=1793981728;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y8Og3gICiT6qPhWWwb1iHFYuzscWZXQVPmOiNSGGRco=;
 b=e1Qo7Onmtmcp8xve3lbeiGbQUYxn2Jf3KIoFlbC2d8JcPaQvj/wxyJGNFuQLaclYee
 C2f+MG6bKSUO5/8ggAcInD0gglQ/BFiCvOCvmpeVM4NUfLpyJWQmul4xA7u5B5KB7aCk
 WN1N5NuhLCLlryBRod8+Y9PxDonnaHf+g7L0hs2ubod+8XsFOGxeGeZoUR14flsWCMw3
 9/aQ+lxFWKQ1YQxtnYMEyu2fUrzg5GKoiuIjqU5xOebjgRt7SjIw1ZPZU+G0f3KUZ8IP
 b9zU+1HB8xf7EsYGuCK8DPxblG7o1gxrSA693/MqWYkH4qqRWzs2Q0LJ+FJjB0A8OfOk
 Hh6g==
X-Gm-Message-State: AFq9FYJg69vUlbpCp5KdU0mjP3th7XkuFfM/KwNJ/XJSB3LqEs2HsHSP
 b/DPVCd9FQR31apKY9jIH/EY1z8Vos87qcWkaSg8vSENvvwc8BmyyV34GBmxnZpw2/fbi85j/P+
 LO6iJzKdc1UUnyZeL+VM1VujkosgRui76fN1yP1PuxYkXCKtHp/1fq+mk9t+PWzB9B94n
X-Gm-Gg: AYBFou3X9lXJa05RtLvkyLI1rlyGkVyrOyvcQFEtj9htuqeV5sCA7SXtfuoC7IFISzB
 Uo+cXYTK8q+Buf2CxsETW7HAgyDMICLyEPkU4DyZYtSlin/skfl1RwHKGMw+hIW7AoOeR0tQV/r
 B40FWCMpHG4e2sPICq0bcbeayc+K/DGHrTLbDAhyDRuy8CO7FEQcSktVuJm004o6Ca+xgESnAD6
 HYbLPJzjmxnBFrLSrA6ZlBXj80RzH6cFoMfw6D+oNyJ5vK5gKSy8a3CssETpiQiLxJ8siwNFoql
 s/DCuqaPyGOE0TIvz5+XCZX/0WW2wnh3X8WfM7MgILzUUoUrxXIU0NbB9ESBtP0A4s1jUN6IPrZ
 wiEQs/nzI2v2wz9vlt/JdKZxp1rRnfa8d452m8pPqILAobZ6QLlRbXLKCcuafCbUnQ6Cg8j9NHU
 klBdoDponVeOGlrh6JhKQaVMNMiYcIYMKnBKS0FqRpl8yxNZJc1C3QLNePKeC0sHJ60ipx8T7wV
 Vjx/ughnTgFLL1vdOqzdn20QgaI9kK46P1VNyoTKlLosN/iVRAlGx9cIiqknFo4fAS9Ij9ZJKrR
 eq+7kt2Cm5b7GMG+r0l/RvzBgnNV/+CfTe9zAzOjv6uEmEwAG5nFXk7q8mYaBQ/v5EKqPk+y52M
 NWIKkHHO13BZyZSDftrHu+0fw/kqmwaUFJOq4FXC5VDbDvhf2N9MQk4N9n6lI9eoOcKeRgveV7z
 sczam24Rd9+bDYpPej4G7/+UCz7zYWWTOBfOdo
X-Received: by 2002:a05:6402:324c:b0:6b1:c7d9:b631 with SMTP id
 4fb4d7f45d1cf-6b4d4877be2mr1787165a12.23.1793376926869; 
 Fri, 30 Oct 2026 09:15:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca0f2a0sm141683a12.25.2026.10.30.09.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:15:26 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 16:15:23 +0000
To: chugly <charlie.vigue@openvpn.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 5f607a5226a716c1e2b6bde9beb5ee9bc9405e83
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8978366b14545af79e640d6bf5de4dd74520387b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMpGQ-0000000068r-29FO
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8580142938545066613=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8580142938545066613==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VQIhANvRbGM="; charset=UTF-8

--VQIhANvRbGM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru, chugly=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru,=
 chugly, 

I'd like you to reexamine a change=2E Please visit

    https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail

to look at the new pat=
ch set (#24)=2E

The following approvals got outdated and were removed:
Cod=
e-Review+2 by chugly, Code-Review-1 by R=C4=83zvan Cojocaru

The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E


Change subject: Implement sending/receiving app custom control=
 protocol messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Implement sending/receiving app custom control protocol messages

T=
his allows openvpn GUI/front-ends and server via management
to use the Open=
VPN control channel to pass messages between each other
while OpenVPN handl=
es the marshalling/unmarshalling of these and
negotiate the common app cust=
om control protocols=2E

This provides an easy to use secure channel that d=
oes not depend on
the network itself to work and can also be used before fu=
lly
authenticating the client=2E See the management-notes=2Etxt for more
de=
tails how to use this feature=2E An upcoming patch will also add
some examp=
le python scripts that showcase this feature=2E

Change-Id: I4a6a6ef41e1589=
6b8b79d795b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>=

---
M CMakeLists=2Etxt
M doc/man-sections/client-options=2Erst
M doc/man-s=
ections/management-options=2Erst
M doc/man-sections/script-options=2Erst
M =
doc/management-notes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2E=
c
A src/openvpn/acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M =
src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M s=
rc/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M s=
rc/openvpn/push=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M te=
sts/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_manage=
ment=2Ec
M tests/unit_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit=
_tests/openvpn/test_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests=
/unit_tests/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec=

26 files changed, 1,546 insertions(+), 23 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/24

diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt
index 184a95a=2E=2E4deabe7 100644
--- a=
/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,6 +435,8 @@
     src/compa=
t/compat-strlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/comp=
at-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/=
openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -=
826,6 +828,8 @@
             tests/unit_tests/openvpn/mock_management=2Ec
 =
            tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
            =
 tests/unit_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_tes=
ts/openvpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src/o=
penvpn/argv=2Ec
             src/openvpn/base64=2Ec
             src/openvp=
n/crypto_epoch=2Ec
@@ -842,6 +846,7 @@
             src/openvpn/packet_id=
=2Ec
             src/openvpn/run_command=2Ec
             src/openvpn/ssl_=
mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
             src/openvpn/s=
sl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
             src/openv=
pn/ssl_verify_mbedtls=2Ec
diff --git a/doc/man-sections/client-options=2Ers=
t b/doc/man-sections/client-options=2Erst
index 87c138a=2E=2E16309f9 100644=

--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-=
options=2Erst
@@ -437,6 +437,12 @@
         Additional authentication metho=
ds supported by the client=2E
         This may be set by the client UI/GUI=
 using ``--setenv``=2E
 
+  :code:`IV_ACC=3D<max_msg_len>,<flags>,<protocol=
s>`
+        If the option ``--app-custom-control`` is set, the client will=

+        send the supported max ACC message length, the supported formats
=
+        as (:code:`A:6`) and the list of configured protocols (e=2Eg=2E
+ =
       :code:`flower:happy:power`)
+
   The following flags depend on which=
 compression formats are compiled in
   and whether compression is allowed =
by options=2E See `Protocol options`_
   for more details=2E
diff --git a/d=
oc/man-sections/management-options=2Erst b/doc/man-sections/management-opti=
ons=2Erst
index 2c79d05=2E=2E315e567 100644
--- a/doc/man-sections/manageme=
nt-options=2Erst
+++ b/doc/man-sections/management-options=2Erst
@@ -144,3 =
+144,17 @@
 
 --management-up-down
   Report tunnel up/down events to manag=
ement interface=2E
+
+--app-custom-control protocol-list
+  Sets the list o=
f supported app custom control protocols=2E
+  These protocols are announce=
d to the server via the IV_ACC peer info
+  variable when this option is us=
ed on a client=2E
+  If the option is set on a server it will negotiate com=
mon protocols
+  with the client=2E
+
+  The protocol-list is a : separated=
 list of protocol identifiers=2E Protocol
+  identifiers must consist of al=
phanumeric characters, :code:`-`, and
+  :code:`_`=2E
+
+  See management-n=
otes=2Etxt in the OpenVPN distribution and the OpenVPN RFC
+  draft for a d=
escription of app custom control protocol support=2E
diff --git a/doc/man-s=
ections/script-options=2Erst b/doc/man-sections/script-options=2Erst
index =
f420380f=2E=2E474c7fd 100644
--- a/doc/man-sections/script-options=2Erst
++=
+ b/doc/man-sections/script-options=2Erst
@@ -1006,3 +1006,12 @@
        X5=
09_1_L=3DBISHKEK
        X509_1_ST=3DNA
        X509_1_C=3DKG
+
+:code:`acc=
_protocols`
+    If ``--app-custom-control`` is configured and the client s=
upports any of the
+    protocols that server also supports, this variable =
contains a list of
+    common protocols separated by :=2E
+
+:code:`acc_me=
ssage_len`
+    if :code:`acc_protocols` is set, this variable contains the=
 maximum
+    message length for app custom protocol message=2E
diff --git =
a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 4d726c4=2E=
=2E48cbb54 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-not=
es=2Etxt
@@ -828,6 +828,58 @@
 that is required to continue the connection =
(unlike MFA or opening a browser)
 this message is not negotiated but can j=
ust be sent as a gratuitous message=2E
 
+app custom control
+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is =
passed as {EXTRA} OpenVPN will determine
+the common app custom protocols b=
etween the client and the server and instruct
+the client that the server w=
ill send control messages to the client using
+the ACC protocol=2E
+
+The s=
erver should then use client-acc-msg command to send app custom
+control me=
ssages to the client to facilitate the pending authentication=2E
+
+COMMAND=
 -- client-acc-msg (OpenVPN 2=2E8 or higher)
+-----------------------------=
--------------------
+
+On an OpenVPN instance running in server mode this =
command sends an
+app custom control message to a client=2E The format of t=
he command is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  =
{message}
+  END
+
+CID,KID -- client ID and Key ID=2E See documentation fo=
r ">CLIENT:"
+notification for more info=2E
+
+protocol -- the ACC protocol=
 identifier that this message should be
+            tagged with=2E
+
+flag=
s    -- a character list of the encoding and the flag if the
+            m=
essage is a fragment=2E E=2Eg=2E "6F" for a base64 encoded
+            mes=
sage that is also a fragment and not complete yet=2E
+
+message  -- The mes=
sage encoded in the encoding specified in flags
+
+
+COMMAND -- acc-msg (Op=
enVPN 2=2E8 or higher)
+------------------------------------------
+
+When =
OpenVPN is running in --client mode this command sends an app
+custom comma=
nd to the server=2E The format of the command is
+
+  acc-msg
+  {protocol}=

+  {flags}
+  {message}
+  END
+
+See the client-acc-msg command for more =
details about the format of the
+message=2E Since a client has only one pee=
r there is no need to specify the
+client id and key id=2E
+
+
 COMMAND -- =
client-deny  (OpenVPN 2=2E1 or higher)
 -----------------------------------=
------------
 
@@ -1302,6 +1354,52 @@
    response=2E Mechanisms that need =
multiple rounds or more complex answers
    should implement a different re=
sponse type than CR_RESPONSE=2E
 
+(6) App custom control message
+
+    Th=
is message is an application specific payload message that is transported
+=
    over the OpenVPN control channel=2E
+
+    In server mode:
+
+    >CLIE=
NT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}
+
+    In client mode=
:
+
+    >ACC:{protocol},{fragment},{msg_base64}
+
+    The protocol is a s=
hort ascii string identifying the app specific custom
+    protocol=2E If f=
ragment is set to 1, the message is not complete and the
+    next message =
should be concatenated to this message to form a complete
+    message=2E
+=

+    Note that the OpenVPN implementation operates here with the robustnes=
s
+    principle ("be conservative in what you send, be liberal in what you=

+    accept" - RFC 793 and others) and allows receiving messages longer th=
an
+    maximum allowed message length=2E Implementations should be prepare=
d to
+    handle messages that are longer than the maximum allowed message =
length=2E
+
+    OpenVPN does not verify that the message is valid base64=
=2E A peer that
+    sends invalid base64 payload will be passed to the man=
agement interface=2E
+    An implementation should be prepared to handle in=
valid base64 and
+    handle accordingly (e=2Eg=2E disconnect the client vi=
a client-deny or
+    ignore such messages)=2E
+
+(7) App custom control pr=
otocol message
+
+   This message informs the client about the common ACC
+=
   protocols and the maximum message length for an ACC message=2E
+
+   In =
client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=
=3D{max_msg_len}
+
+   protocol_list is the list of supported protocols by =
both server and client=2E
+   For example flower:power:sys_info would indic=
ate these three protocols
+   are supported=2E max_msg_len specifies the ma=
ximum message length that the
+   peer supports=2E
+
+   In server mode the=
se information are available in the acc_protocols and
+   acc_message_len v=
ariables of the client environment=2E
 
 Variables:
 
diff --git a/src/open=
vpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Eebc4db6 10=
0644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -45=
,6 +45,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec a=
cc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	base64=
=2Ec base64=2Eh \
@@ -124,7 +125,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec p=
roxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec=
 push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect=
_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/acc=2E=
c b/src/openvpn/acc=2Ec
new file mode 100644
index 0000000=2E=2Ea05d55c
---=
 /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,445 @@
+/*
+ *  OpenVPN -- =
An application to securely tunnel IP networks
+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwab=
e <arne@rfc2549=2Eorg>
+ *
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
 write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fi=
fth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#incl=
ude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <string=2Eh>=

+#include "buffer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include=
 "forward=2Eh"
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#incl=
ude "ssl_ncp=2Eh"
+#include "multi=2Eh"
+
+static void
+log_acc_message(str=
uct context *c, const struct buffer *buf, int payload_len,
+               =
 const char *protocol, int flags)
+{
+    bool fragment =3D flags & ACC_MES=
SAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =3D =
gc_new();
+    const char *payload_msg =3D NULL;
+
+    /* For simplicity, =
we always encode payload to be base64 encoded
+     * if not already in bas=
e64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        cha=
r *b64out =3D NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf), paylo=
ad_len, &b64out) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
+     =
   payload_msg =3D b64out;
+    }
+    else
+    {
+        payload_msg =3D=
 CBSTR(buf);
+    }
+
+    if (management)
+    {
+        struct tls_sessi=
on *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        if (c->o=
ptions=2Emode =3D=3D MODE_SERVER)
+        {
+            /* server mode=2E=
 Report client context */
+            struct man_def_auth_context *mda =3D=
 session->opt->mda_context;
+            unsigned int mda_key_id =3D get_pr=
imary_key(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLIE=
NT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol, f=
ragment, payload_msg);
+        }
+        else
+        {
+            /* =
Client mode=2E Do not a report a CLIENT id */
+            msg(M_CLIENT, ">=
ACC:%s,%d,%s", protocol, fragment, payload_msg);
+        }
+    }
+    gc_=
free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Received=
 custom app control message (protocol '%s'%s)",
+        protocol, fragment=
 ? ", fragment" : "");
+}
+
+
+int
+parse_acc_message_flags(const char *fla=
gs, const char **err_reason, struct gc_arena *gc)
+{
+    int acc_flags =3D=
 0;
+
+    for (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {=

+        if (*flag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_=
MESSAGE_FLAGS_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+      =
  {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+     =
   else if (*flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_ME=
SSAGE_FLAGS_FRAGMENT;
+        }
+        else
+        {
+            *err=
_reason =3D "Unknown flag in flags";
+            return -1;
+        }
+  =
  }
+    /* The message should be encoded with exactly one encoding=2E Ensu=
re that
+     * only one of the flags is present */
+    bool asciienc =3D =
(bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)=
(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=
=3D 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, gc);
+        snprin=
tf(tmp, 512, "number of encodings must be exactly one "
+                  =
         "(B64=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc);
=
+        *err_reason =3D tmp;
+        return -1;
+    }
+
+    return acc_=
flags;
+}
+
+/**
+ * Wrapper around parse_acc_message_flags to also include=
 the step of
+ * extracting the flags from the buffer and forwarding the bu=
ffer
+ * beyond the flags field=2E
+ */
+static int
+pase_acc_mesage_flags_=
buf(struct buffer *buf, const char **err_reason, struct gc_arena *gc)
+{
+ =
   const char *flags =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags=
)
+    {
+        *err_reason =3D "could not extract flags field";
+       =
 return -1;
+    }
+    return parse_acc_message_flags(flags, err_reason, g=
c);
+}
+
+void
+receive_acc_message(struct context *c, const struct buffer =
*buffer)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *err_reas=
on =3D "";
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+=
    struct buffer buf =3D *buffer;
+
+    const struct tls_multi *multi =3D=
 c->c2=2Etls_multi;
+    if (!multi->acc_negotiated_protocols)
+    {
+    =
    err_reason =3D "ACC not enabled or no negotiated protocols";
+        g=
oto err;
+    }
+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_read_u8=
(&buf) !=3D ',')
+    {
+        err_reason =3D "missing , after ACC";
+   =
     goto err;
+    }
+
+    /* extract protocol, payload length, flags sub=
strings */
+    const char *protocol =3D buf_extract_field(&buf, ',', &gc);=

+    if (!protocol)
+    {
+        err_reason =3D "could not extract prot=
ocol field";
+        goto err;
+    }
+
+    if (!tls_item_in_cipher_list(=
protocol, multi->acc_negotiated_protocols))
+    {
+        struct buffer m=
sg_buf =3D alloc_buf_gc(1024, &gc);
+        buf_printf(&msg_buf, "protocol=
 '%s' not in list of negotiated protocols '%s'",
+                   protoc=
ol, multi->acc_negotiated_protocols);
+        err_reason =3D buf_cstr(&msg=
_buf);
+
+
+        goto err;
+    }
+
+    /* We do not check the length h=
ere=2E We make no promises to support
+     * anything larger than our anno=
unced message length but according to
+     * the robustness principle
+   =
  * ("be conservative in what you send, be liberal in what you accept" - RF=
C 793 and others)
+     * we accept also longer messages */
+
+    int payl=
oad_len;
+    const char *payload_len_str =3D buf_extract_field(&buf, ',', =
&gc);
+    if (!payload_len_str
+        || !atoi_constrained(payload_len_s=
tr, &payload_len, "acc_payload_len", 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ER=
RORS))
+    {
+        err_reason =3D "could not extract payload length fie=
ld";
+        goto err;
+    }
+
+    int flags =3D pase_acc_mesage_flags_b=
uf(&buf, &err_reason, &gc);
+
+    if (flags < 0)
+    {
+        goto err;=

+    }
+
+    /* We should have a final NUL byte in the control message bu=
ffer
+     * and thus the length of the buffer should be payload_len + 1 */=

+    if (buf_len(&buf) !=3D payload_len + 1)
+    {
+        char *tmp =3D=
 gc_malloc(512, 1, &gc);
+        snprintf(tmp, 512, "field length %d, payl=
oad length %d mismatch",
+                 payload_len, buf_len(&buf) - 1);=

+        err_reason =3D tmp;
+        goto err;
+    }
+
+
+    log_acc_me=
ssage(c, &buf, payload_len, protocol, flags);
+    gc_free(&gc);
+    retur=
n;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: Received malformed custom app =
control channel "
+                       "message (%s): %s",
+        err_=
reason,
+        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+    gc=
_free(&gc);
+}
+
+
+bool
+send_acc_message(struct context *c,
+            =
     struct tls_multi *multi,
+                 struct tls_session *session=
,
+                 const char *protocol, bool fragment,
+                 =
const char *acc_msg_payload, bool base64)
+{
+    /*
+     * length of the =
protocol string + one ','
+     * 2 for the encoding (A or 6), potential F =
(fragment), and 1 for the ',',
+     * 4 for the message size itself and on=
e comma
+     * 1 for the comma before the message itself */
+    const siz=
e_t max_header_size =3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 +=
 1;
+    size_t len =3D max_header_size + strlen(acc_msg_payload);
+
+    i=
f (len > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CLIENT, "message lengt=
h (%zu) exceeds maximum possible message length (%d)", len, TLS_CHANNEL_BUF=
_SIZE);
+        return false;
+    }
+
+    if ((int)len > multi->acc_max_=
message_length)
+    {
+        msg(M_CLIENT, "header (%zu) + message size =
(%zu) length (%zu) exceeds "
+                      "maximum allowed length=
 negotiated with peer (%d)",
+            max_header_size, strlen(acc_msg_p=
ayload), len,
+            multi->acc_max_message_length);
+        return =
false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* add 1 for the=
 final \0 */
+    struct buffer buf =3D alloc_buf_gc(len + 1, &gc);
+
+    =
/* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&bu=
f, "ACC,%s,%zu,%s%s,%s", protocol,
+               strlen(acc_msg_payload),=

+               base64 ? "6" : "A",
+               fragment ? "F" : "",
+=
               acc_msg_payload);
+
+    bool ret =3D send_control_channel_s=
tring_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c)=
;
+    gc_free(&gc);
+    return ret;
+}
+
+char *
+parse_acc_parameters(co=
nst char *capabilities,
+                     const char *delim,
+         =
            int *max_acc_len,
+                     bool server,
+         =
            struct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc=
(capabilities, NULL);
+    char *tmp_message_orig =3D tmp_message;
+    cha=
r *lasts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_message, delim=
, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const char *prot=
ocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode we allow =
more capabilities than our own, in client
+     * mode we reject if we shou=
ld use capabilities that we do not support */
+    int allowed_acc_len =3D =
server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if=
 (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message length", ACC=
_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto=
 done;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A=
", token) || !tls_item_in_cipher_list("6", token)))
+        {
+           =
 msg(D_PUSH_ERRORS, "App custom control encoding must include base64 and as=
cii");
+            goto done;
+        }
+
+        if (p =3D=3D 1 && !ser=
ver && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+          =
  msg(D_PUSH_ERRORS, "App custom control encoding must be exactly base64 an=
d ascii");
+            goto done;
+        }
+
+        if (p =3D=3D 2)
+ =
       {
+            protocols =3D token;
+        }
+
+        if (p =3D=
=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters for =
INFO ACC message/IV_ACC=2E");
+            goto done;
+        }
+
+       =
 token =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_=
acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(pro=
tocols, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
+
+s=
truct buffer
+get_list_intersection(struct gc_arena *gc, const char *list1,=
 const char *list2)
+{
+    char *tmp =3D string_alloc(list1, NULL);
+    c=
har *lasts =3D NULL;
+    const char *token =3D strtok_r(tmp, ":", &lasts);=

+
+    /* The maximum possible length is the shorter of the two input list=
s */
+    size_t max_len =3D min_size(strlen(list1), strlen(list2));
+
+   =
 struct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);
+
+    w=
hile (token)
+    {
+        /* check for every items is in both lists and =
not already in the
+         * common list */
+        if (tls_item_in_ciph=
er_list(token, list2)
+            && !tls_item_in_cipher_list(token, buf_c=
str(&common_protocols)))
+        {
+            if (buf_len(&common_protoc=
ols) > 0)
+            {
+                buf_write_u8(&common_protocols, '=
:');
+            }
+            buf_printf(&common_protocols, "%s", token)=
;
+        }
+        token =3D strtok_r(NULL, ":", &lasts);
+    }
+    fr=
ee(tmp);
+    return common_protocols;
+}
+
+void
+determine_common_acc_pro=
tocols(struct tls_multi *multi, struct tls_session *session)
+{
+    if (!m=
ulti->opt=2Eacc_protocols)
+    {
+        /* No app custom protocols have =
been configured server-side=2E */
+        return;
+    }
+
+    if (multi-=
>acc_negotiated_protocols)
+    {
+        /* We already have determined th=
e common protocols=2E */
+        return;
+    }
+
+    struct gc_arena gc =
=3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+=
    const char *peer_info =3D multi->peer_info;
+    const char *iv_acc =3D=
 extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+   =
 {
+        gc_free(&gc);
+        return;
+    }
+
+    int max_acc_len =
=3D 0;
+    const char *protocols =3D parse_acc_parameters(iv_acc, ",", &ma=
x_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&gc);=

+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of peer is=
 malformed");
+        return;
+    }
+
+    struct buffer common_protocols=
 =3D get_list_intersection(&gc, multi->opt=2Eacc_protocols, protocols);
+
+=
    if (buf_len(&common_protocols) =3D=3D 0)
+    {
+        msg(D_PUSH_DEB=
UG, "WARNING: No common app custom control protocol=2E");
+        gc_free(=
&gc);
+        return;
+    }
+
+    multi->acc_negotiated_protocols =3D st=
ring_alloc(buf_str(&common_protocols), NULL);
+    multi->acc_max_message_l=
ength =3D max_acc_len;
+
+    setenv_str(session->opt->es, "acc_protocols",=
 multi->acc_negotiated_protocols);
+    setenv_int(session->opt->es, "acc_m=
essage_len", multi->acc_max_message_length);
+
+    gc_free(&gc);
+}
+
+voi=
d
+notify_client_acc_protocols(struct tls_multi *multi)
+{
+#ifdef ENABLE_M=
ANAGEMENT
+    if (management)
+    {
+        msg(M_CLIENT, ">ACC_PROTOCOL=
S:protocols=3D%s,message_len=3D%d",
+            multi->acc_negotiated_prot=
ocols, multi->acc_max_message_length);
+    }
+#endif
+}
diff --git a/src/o=
penvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 0000000=2E=
=2E9c99b11
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,130 @@
+/*
+ =
*  OpenVPN -- An application to securely tunnel IP networks
+ *            =
 over a single TCP/UDP port, with support for SSL/TLS-based
+ *            =
 session authentication and key exchange,
+ *             packet encryption=
, packet authentication, and
+ *             packet compression=2E
+ *
+ * =
 Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 20=
25 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free soft=
ware; you can redistribute it and/or modify
+ *  it under the terms of the =
GNU General Public License version 2
+ *  as published by the Free Software=
 Foundation=2E
+ *
+ *  This program is distributed in the hope that it wil=
l be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warran=
ty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
=
+ *  GNU General Public License for more details=2E
+ *
+ *  You should hav=
e received a copy of the GNU General Public License along
+ *  with this pr=
ogram; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H=

+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#d=
efine ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom cont=
rol message and delivers it to the
+ * management interface=2E We leave rea=
ssembly of fragmented messages to the
+ * management interface=2E
+ *
+ * @=
param c            The context struct
+ * @param buffer       Buffer contai=
ning the control message with ACC
+ */
+void
+receive_acc_message(struct co=
ntext *c, const struct buffer *buffer);
+
+bool
+send_acc_message(struct co=
ntext *c,
+                 struct tls_multi *tls_multi,
+                 =
struct tls_session *session,
+                 const char *protocol, bool f=
ragment,
+                 const char *msg, bool base64);
+
+
+/**
+ * Pars=
es an info message from the server that contains app custom control info
+ =
* information prior to the PUSH_REPLY to be able to use app custom control
=
+ * protocols before sending
+ *
+ * In client mode only allow what we supp=
ort ourselves=2E In server mode
+ * allow also capabilities that we not sup=
port ourselves=2E
+ *
+ * @param capabilities      The string to parse
+ * =
@param delim             The delimiter to use when parsing the string=2E
+ =
*                          IV_ACC uses "," as delimiter while the
+ *      =
                    custom-control PUSH message uses " " as "," is
+ *     =
                     already used to separate different push directives
+ *=
 @param max_acc_len       Set to the maximum ACC message length
+ * @param =
server            Whether we are server or client
+ * @param gc            =
    The gc arena to use for allocating the resulting string
+ * @return    =
              The resulting protocol string or NULL on error
+ */
+char *
+=
parse_acc_parameters(const char *capabilities,
+                     const =
char *delim,
+                     int *max_acc_len,
+                     =
bool server,
+                     struct gc_arena *gc);
+
+/**
+ * Parses =
the IV_ACC of the peer and sets multi=2Eacc_negotiated_protocols
+ * to the=
 common protocols of server and client and
+ * multi=2Eacc_max_message_leng=
th  to the maximum length of the ACC message
+ * support by both server and=
 client=2E
+ *
+ * If there is no common protocol or the client does not su=
pport any app custom
+ * protocol multi=2Eacc_negotiated_protocols will be =
set to NULL=2E
+ *
+ * @param multi      the multi instance to use the set =
the app custom protocols=2E
+ * @param session    the session to read the c=
lient env from
+ */
+void
+determine_common_acc_protocols(struct tls_multi =
*multi, struct tls_session *session);
+
+/**
+ * Flags returned by the pars=
e_acc_message_flags method
+ */
+enum acc_message_flag
+{
+    ACC_MESSAGE_=
FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FL=
AGS_FRAGMENT =3D 4,
+};
+
+/**
+ *  Parses the flags field of an app contro=
l message If there is an
+ *  error parsing the flags field the method retu=
rns -1 and
+ *  puts the error reason in err_reason
+ */
+int
+parse_acc_me=
ssage_flags(const char *flags, const char **err_reason, struct gc_arena *gc=
);
+
+/**
+ * Calculates the intersection of two list that are both separat=
ed by :
+ * Items in the result will have the same ordering as in the list1=

+ * parameters
+ * @param gc            Returned buffer will be allocated =
in this gc
+ * @param list1         First list to intersect
+ * @param list=
2         Second list to intersect=2E
+ * @return A (potentially empty) buf=
fer containing an intersection list
+ */
+struct buffer
+get_list_intersect=
ion(struct gc_arena *gc, const char *list1, const char *list2);
+
+/**
+ * =
Notifies a client via management interface of the negotiated app
+ * custom=
 protocols
+ * @param multi the tls_multi instance of the connection
+ */
+=
void
+notify_client_acc_protocols(struct tls_multi *multi);
+#endif
diff --=
git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2E=
eb41d03 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
=
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"
 #include =
"tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 =
+258,11 @@
     }
     else if (buf_string_match_head_str(buf, "INFO_PRE"))=

     {
-        server_pushed_info(buf, 8);
+        peer_pushed_info(c, b=
uf, 8);
     }
     else if (buf_string_match_head_str(buf, "INFO"))
     {=

-        server_pushed_info(buf, 4);
+        peer_pushed_info(c, buf, 4);=

     }
     else if (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {=

@@ -271,6 +272,10 @@
     {
         receive_auth_pending(c, buf);
     }
=
+    else if (buf_string_match_head_str(buf, "ACC"))
+    {
+        receiv=
e_acc_message(c, buf);
+    }
     else if (buf_string_match_head_str(buf, =
"EXIT"))
     {
         receive_exit_message(c);
diff --git a/src/openvpn/=
init=2Ec b/src/openvpn/init=2Ec
index 1b8b2a5=2E=2Ee0b99a4 100644
--- a/src=
/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -56,6 +56,7 @@
 #include "s=
chedule=2Eh"
 #include "options_string=2Eh"
 #include "resolve=2Eh"
+#inclu=
de "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -2279,6 +2280,13 @@
         }
 =
    }
 
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if (multi =
&& multi->acc_negotiated_protocols)
+    {
+        buf_printf(&out, " cust=
om-control %d A:6 %s",
+                   multi->acc_max_message_length, m=
ulti->acc_negotiated_protocols);
+    }
+
     if (BLENZ(&out) > strlen(hea=
der))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2530,=
11 @@
         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (=
c->options=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
=
     return flags;
 }
 
@@ -2730,6 +2743,18 @@
         frame->tun_mtu =3D =
min_int(frame->tun_max_mtu, c->options=2Ece=2Etun_mtu);
     }
 
+    if (f=
ound & OPT_P_ACC && c->options=2Epushed_acc_negotiated_protocols)
+    {
+ =
       struct tls_multi *multi =3D c->c2=2Etls_multi;
+        free(multi->=
acc_negotiated_protocols);
+        multi->acc_negotiated_protocols =3D str=
ing_alloc(c->options=2Epushed_acc_negotiated_protocols, NULL);
+        mul=
ti->acc_max_message_length =3D c->options=2Epushed_acc_max_message_length;
=
+
+        msg(D_PUSH, "OPTIONS IMPORT: ACC protocols: %s, msg len: %d",
+ =
           multi->acc_negotiated_protocols, multi->acc_max_message_length);=

+        notify_client_acc_protocols(multi);
+    }
+
     return true;
 }=

 
@@ -3352,6 +3377,7 @@
     to=2Everify_hash_depth =3D options->verify_ha=
sh_depth;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;
     =
memcpy(to=2Ex509_username_field, options->x509_username_field, sizeof(to=2E=
x509_username_field));
+    to=2Eacc_protocols =3D options->acc_protocols;
=
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,=
6 +4332,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+managem=
ent_acc_msg(void *arg,
+                   struct buffer_list *input) /* ow=
nership transferred */
+{
+    struct context *c =3D arg;
+
+    bool ret =
=3D false;
+    if (buffer_list_defined(input) && c->c2=2Etls_multi)
+    {=

+        struct tls_multi *multi =3D c->c2=2Etls_multi;
+        struct tl=
s_session *session =3D &multi->session[TM_ACTIVE];
+
+        ret =3D manag=
ement_send_acc_message(c, multi, session, input);
+    }
+
+    buffer_list=
_free(input);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 =
void
@@ -4322,6 +4366,7 @@
         cb=2Eproxy_cmd =3D management_callback_=
proxy_cmd;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
   =
      cb=2Esend_cc_message =3D management_callback_send_cc_message;
+      =
  cb=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=
=2Enetwork_change =3D management_callback_network_change;
 #endif
diff --gi=
t a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ac3d4b7=2E=2Eaff8=
146 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45=
,9 +45,11 @@
 #include "push=2Eh"
 #include "multi=2Eh"
 #include "resolve=
=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 #include "run_command=
=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh=
"
@@ -1081,6 +1083,35 @@
             }
             break;
 
+        case=
 IEC_CLIENT_ACC_MSG:
+            if (man->persist=2Ecallback=2Eclient_acc_=
msg)
+            {
+                bool status =3D (*man->persist=2Ecallb=
ack=2Eclient_acc_msg)(man->persist=2Ecallback=2Earg,
+                     =
                                                 man->connection=2Ein_extra=
_cid,
+                                                                    =
  man->connection=2Ein_extra_kid,
+                                        =
                              man->connection=2Ein_extra);
+               =
 man->connection=2Ein_extra =3D NULL;
+                report_command_statu=
s(status, "client-acc-msg");
+            }
+            else
+            =
{
+                man_command_unsupported("client-acc-msg");
+            =
}
+            break;
+
+        case IEC_ACC_MSG:
+            if (man->pe=
rsist=2Ecallback=2Eacc_msg)
+            {
+                bool status =3D=
 (*man->persist=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+     =
                                                          man->connection=
=2Ein_extra);
+                man->connection=2Ein_extra =3D NULL;
+      =
          report_command_status(status, "acc-msg");
+            }
+       =
     else
+            {
+                man_command_unsupported("acc-msg"=
);
+            }
+            break;
         case IEC_PK_SIGN:
          =
   man->connection=2Eext_key_state =3D EKS_READY;
             buffer_list_=
free(man->connection=2Eext_key_input);
@@ -1205,6 +1236,29 @@
 }
 
 static =
void
+man_client_acc_msg(struct management *man, const char *cid_str,
+    =
               const char *kid_str)
+{
+    struct man_connection *mc =3D &=
man->connection;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
=
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_s=
tr, "KID", &mc->in_extra_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLI=
ENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void=

+man_acc_msg(struct management *man)
+{
+    struct man_connection *mc =3D=
 &man->connection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_res=
et(mc, IER_NEW);
+}
+
+static void
 man_client_auth(struct management *man,=
 const char *cid_str, const char *kid_str, const bool extra)
 {
     struct=
 man_connection *mc =3D &man->connection;
@@ -1759,6 +1813,17 @@
          =
   man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
=
+    else if (streq(p[0], "client-acc-msg"))
+    {
+        if (man_need(p=
, 2, 0))
+        {
+            man_client_acc_msg(man, p[1], p[2]);
+    =
    }
+    }
+    else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_=
msg(man);
+    }
     else if (streq(p[0], "rsa-sig"))
     {
         man_=
pk_sig(man, "rsa-sig");
@@ -2975,7 +3040,9 @@
                             =
           "bytes_sent=3D",
                                        "bytes_=
received=3D",
                                        "session_id=3D",
-   =
                                    "session_state=3D" };
+                =
                       "session_state=3D",
+                               =
        "acc_protocols=3D",
+                                       "acc_me=
ssage_len=3D" };
 
     if (env_filter_level =3D=3D 0)
     {
@@ -3130,6 +3=
197,7 @@
     }
 }
 
+
 void
 management_connection_established(struct mana=
gement *man, struct man_def_auth_context *mdac,
                           =
        const struct env_set *es)
@@ -4372,6 +4440,58 @@
     }
 }
 
+bool
=
+management_send_acc_message(struct context *c, struct tls_multi *multi, st=
ruct tls_session *session,
+                            struct buffer_list =
*input)
+{
+    /* also ensures that are enough inputs in the list to safel=
y call
+     * buffer_list_peek without extra NULL checks */
+    if (!inpu=
t || input->size < 3)
+    {
+        msg(M_CLIENT, "not enough input lines=
 for sending acc message, "
+                      "missing protocol, flag =
and/or messages lines");
+        return false;
+    }
+
+    struct gc_are=
na gc =3D gc_new();
+
+    const struct buffer *proto_buf =3D buffer_list_p=
eek(input);
+    const char *protocol =3D string_alloc(CBSTR(proto_buf), &g=
c);
+    buffer_list_pop(input);
+
+    const struct buffer *encoding_buf =
=3D buffer_list_peek(input);
+
+    const char *acc_err_reason =3D NULL;
+ =
   int acc_flags =3D parse_acc_message_flags(buf_cstr(encoding_buf), &acc_e=
rr_reason, &gc);
+    if (acc_flags < 0)
+    {
+        msg(M_CLIENT, "ERR=
OR: parsing acc message flags failed: %s", acc_err_reason);
+        goto e=
rror;
+    }
+
+    buffer_list_pop(input);
+
+    buffer_list_aggregate_se=
parator(input, 10000, "");
+    const struct buffer *acc_msg_buf =3D buffer=
_list_peek(input);
+
+    if (!multi->acc_negotiated_protocols
+        || =
!tls_item_in_cipher_list(protocol, multi->acc_negotiated_protocols))
+    {=

+        msg(M_CLIENT, "ERROR: protocol not in the list of negotiated prot=
ocols: %s",
+            np(multi->acc_negotiated_protocols));
+        got=
o error;
+    }
+
+    bool ret =3D send_acc_message(c, multi, session, pro=
tocol,
+                                acc_flags & ACC_MESSAGE_FLAGS_FRAGM=
ENT,
+                                buf_cstr(acc_msg_buf),
+             =
                   acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+    gc_free(&gc)=
;
+    return ret;
+error:
+    gc_free(&gc);
+    return false;
+}
 #else =
/* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff --git a/src/open=
vpn/manage=2Eh b/src/openvpn/manage=2Eh
index 157039d=2E=2Ecc9c264 100644
-=
-- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19=
 @@
     int (*n_clients)(void *arg);
     bool (*send_cc_message)(void *ar=
g, const char *message, const char *parameter);
     bool (*kill_by_cid)(vo=
id *arg, const unsigned long cid, const char *kill_msg);
+
     bool (*clie=
nt_auth)(void *arg, const unsigned long cid, const unsigned int mda_key_id,=

                         const bool auth, const char *reason, const char *=
client_reason,
                         struct buffer_list *cc_config); /* =
ownership transferred */
     bool (*client_pending_auth)(void *arg, const =
unsigned long cid, const unsigned int kid,
                                =
 const char *extra, unsigned int timeout);
     char *(*get_peer_info)(void=
 *arg, const unsigned long cid);
+    bool (*client_acc_msg)(void *arg,
+  =
                         const unsigned long cid,
+                        =
   const unsigned int mda_key_id,
+                           struct buffer=
_list *msg);
+    bool (*acc_msg)(void *arg,
+                    struct bu=
ffer_list *msg);
     bool (*proxy_cmd)(void *arg, const char **p);
     bo=
ol (*remote_cmd)(void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292=
,13 +299,15 @@
     struct command_line *in;
     struct buffer_list *out;
=
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF =
         0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REM=
OVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#de=
fine IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN    =
   3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define I=
EC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG     =
   8
     int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigne=
d long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(=
struct management *man, struct context *c);
 
+/** Parses the ACC message f=
rom the input buffer_list and send to the
+ * session identified by session=
 and multi
+ */
+struct tls_session;
+struct tls_multi;
+bool
+management_s=
end_acc_message(struct context *c, struct tls_multi *multi,
+              =
              struct tls_session *session, struct buffer_list *input);
 #en=
dif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/multi=2Ec=
 b/src/openvpn/multi=2Ec
index e302a81=2E=2Ea3eb3ca 100644
--- a/src/openvp=
n/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include "ssl_ut=
il=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#include "acc=
=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +4086,26 @@
     }=

 }
 
+static const char *
+calculate_app_control_extra(struct multi_instan=
ce *mi, struct gc_arena *gc)
+{
+    struct context *c =3D &mi->context;
+ =
   struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->acc_ne=
gotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negotiated proto=
cols");
+        return NULL;
+    }
+
+    struct buffer buf =3D alloc_buf=
_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi->acc_max_mess=
age_length,
+               multi->acc_negotiated_protocols);
+    return b=
uf_str(&buf);
+}
+
+
 static bool
 management_client_pending_auth(void *arg=
, const unsigned long cid, const unsigned int mda_key_id,
                 =
               const char *extra, unsigned int timeout)
@@ -4095,10 +4116,2=
2 @@
     if (mi)
     {
         struct tls_multi *multi =3D mi->context=
=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new();
+        if =
(!strcmp(extra, "ACC"))
+        {
+            extra =3D calculate_app_con=
trol_extra(mi, &gc);
+            if (!extra)
+            {
+             =
   gc_free(&gc);
+                return false;
+            }
+        }
 =
        struct tls_session *session =3D lookup_session_by_mda_key_id(multi,=
 mda_key_id);
 
         if (!session)
         {
+            gc_free(&gc)=
;
             return false;
         }
 
@@ -4106,6 +4139,7 @@
         bo=
ol ret =3D send_auth_pending_messages(multi, session, extra, timeout);
    =
     reschedule_multi_process(&mi->context);
         multi_schedule_contex=
t_wakeup(m, mi);
+        gc_free(&gc);
         return ret;
     }
     re=
turn false;
@@ -4149,6 +4183,37 @@
     return ret;
 }
 
+
+static bool
+ma=
nagement_client_acc_msg(void *arg,
+                          const unsigne=
d long cid,
+                          const unsigned int mda_key_id,
+    =
                      struct buffer_list *input) /* ownership transferred *=
/
+{
+    struct multi_context *m =3D (struct multi_context *)arg;
+    str=
uct multi_instance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false=
;
+    if (mi && buffer_list_defined(input))
+    {
+        struct tls_mul=
ti *multi =3D mi->context=2Ec2=2Etls_multi;
+        struct tls_session *se=
ssion =3D lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (!se=
ssion)
+        {
+            msg(M_CLIENT, "client session not found");
+=
            buffer_list_free(input);
+            return false;
+        }
=
+
+        ret =3D management_send_acc_message(&mi->context, multi, session=
, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+    buff=
er_list_free(input);
+    return ret;
+}
+
+
 static char *
 management_get=
_peer_info(void *arg, const unsigned long cid)
 {
@@ -4185,6 +4250,7 @@
   =
      cb=2En_clients =3D management_callback_n_clients;
         cb=2Ekill_=
by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth =3D management=
_client_auth;
+        cb=2Eclient_acc_msg =3D management_client_acc_msg;
 =
        cb=2Eclient_pending_auth =3D management_client_pending_auth;
      =
   cb=2Eget_peer_info =3D management_get_peer_info;
         cb=2Epush_upda=
te_broadcast =3D management_callback_send_push_update_broadcast;
diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index fb319ae=2E=2Ea5e=
7396 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ =
-35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "b=
uffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -2552,6 +2553,8 =
@@
     o->push_option_types_found =3D 0;
     o->push_update_options_found=
 =3D 0;
     o->imported_protocol_flags =3D 0;
+    o->pushed_acc_max_messa=
ge_length =3D 0;
+    o->pushed_acc_negotiated_protocols =3D NULL;
 }
 
 st=
atic void
@@ -7107,6 +7110,47 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);=

         options->force_key_material_export =3D true;
     }
+    else if =
(streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {
+        VERIFY=
_PERMISSION(OPT_P_GENERAL);
+        if (!string_class(p[1], CC_ALNUM | CC_=
COLON | CC_UNDERBAR | CC_DASH, 0))
+        {
+            msg(msglevel, "A=
pp custom control protocols must only contain "
+                          =
"alphanumeric characters, '-', and '_'=2E");
+            goto err;
+      =
  }
+        options->acc_protocols =3D p[1];
+    }
+    else if (streq(p[=
0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+        VER=
IFY_PERMISSION(OPT_P_ACC);
+
+        /* check if the list from the server =
is a real subset of our list */
+        struct gc_arena gc_local =3D gc_ne=
w();
+        struct buffer common_list =3D get_list_intersection(&gc_local=
, p[3], options->acc_protocols);
+
+        if (buf_len(&common_list) =3D=
=3D 0 || !streq(p[3], buf_cstr(&common_list)))
+        {
+            msg(=
msglevel, "App custom control list from server contains "
+                =
          "unsupported protocols");
+            gc_free(&gc_local);
+     =
       goto err;
+        }
+        gc_free(&gc_local);
+
+        if (!st=
req(p[2], "6:A") && !streq(p[2], "A:6"))
+        {
+            msg(msglev=
el, "App custom control encoding must be base64 and ascii");
+            g=
oto err;
+        }
+
+        if (!atoi_constrained(p[1], &options->pushed=
_acc_max_message_length,
+                              "app custom message=
 message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        {
+=
            goto err;
+        }
+        options->pushed_acc_negotiated_pr=
otocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3]=
)
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library P=
RNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh
index 6a3bf61=2E=2Eb7945e0 100644
--- a/src/openvpn/options=2Eh
+++ b/=
src/openvpn/options=2Eh
@@ -715,6 +715,18 @@
     /* force using TLS key ma=
terial export for data channel key generation */
     bool force_key_materi=
al_export;
 
+    /** The app custom control protocols we should announce a=
s supported */
+    const char *acc_protocols;
+
+    /** the protocols tha=
t are negotiated with the peer=2E This is a
+     *  a temporary variable s=
ince options=2Ec push parser cannot access
+     *  tls multi struct */
+  =
  const char *pushed_acc_negotiated_protocols;
+
+    /** the maximum lengt=
h of an ACC control channel message via push message
+     * */
+    int pu=
shed_acc_max_message_length;
+
     bool vlan_tagging;
     enum vlan_accep=
table_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -764,8 +776,10 @@
 #d=
efine OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU        (1u <=
< 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC         =
    (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MO=
DE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal configurati=
on file (vs pushed options or in ccd files) */
+#define OPT_P_DEFAULT (~(OP=
T_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PUL=
L_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/open=
vpn/push=2Ec
index 42259c3=2E=2Ea18f33b 100644
--- a/src/openvpn/push=2Ec
+=
++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #inc=
lude "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #include "cr=
ypto=2Eh"
 #include "ssl=2Eh"
@@ -221,9 +223,56 @@
 #endif
 }
 
+static voi=
d
+parse_server_pushed_info_acc(struct context *c, struct buffer *buf)
+{
+=
    int max_acc_len =3D 0;
+    struct tls_multi *multi =3D c->c2=2Etls_mul=
ti;
+
+    if (multi->acc_negotiated_protocols)
+    {
+        return;
+  =
  }
+
+    if (!multi->opt=2Eacc_protocols || !c->options=2Epull)
+    {
+ =
       msg(D_PUSH_ERRORS, "Peer tried to push app custom control list "
+  =
                         "without client announcing support for it");
+    =
    return;
+    }
+
+    /* example string to parse: ACC:1400 A:6 flower:h=
appy */
+    /* Skip over the ACC: prefix */
+    buf_advance(buf, 4);
+
+ =
   struct gc_arena gc =3D gc_new();
+    const char *protocols =3D parse_ac=
c_parameters(buf_cstr(buf), " ", &max_acc_len, false, &gc);
+    if (!proto=
cols)
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC info comman=
d with invalid parameters");
+        gc_free(&gc);
+        return;
+    }=

+
+    /* check if the list from the server is a real subset of our list *=
/
+    struct buffer common_list =3D get_list_intersection(&gc, protocols, =
multi->opt=2Eacc_protocols);
+
+    if (buf_len(&common_list) =3D=3D 0 || !=
streq(protocols, buf_cstr(&common_list)))
+    {
+        msg(D_PUSH_ERRORS=
, "App custom control list from server contains "
+                        =
   "unsupported protocols");
+        gc_free(&gc);
+        return;
+    }=

+
+    multi->acc_negotiated_protocols =3D string_alloc(protocols, NULL);
=
+    multi->acc_max_message_length =3D max_acc_len;
+    notify_client_acc_=
protocols(multi);
+    gc_free(&gc);
+}
 
 void
-server_pushed_info(const s=
truct buffer *buffer, const int adv)
+peer_pushed_info(struct context *c, c=
onst struct buffer *buffer, const int adv)
 {
     const char *m =3D "";
  =
   struct buffer buf =3D *buffer;
@@ -233,6 +282,12 @@
         m =3D BSTR(=
&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        pa=
rse_server_pushed_info_acc(c, &buf);
+        return;
+    }
+
 #ifdef ENAB=
LE_MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ -257,7 +312,=
7 @@
         gc_free(&gc);
     }
 #endif
-    msg(D_PUSH, "Info command w=
as pushed by server ('%s')", m);
+    msg(D_PUSH, "Info command was pushed =
by peer ('%s')", m);
 }
 
 void
@@ -285,6 +340,7 @@
     msg(D_PUSH, "CR re=
sponse was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword fo=
r the AUTH_PENDING request
  * @param buffer                buffer containi=
ng the keywords, the buffer's
@@ -441,7 +497,6 @@
     const char *const pe=
er_info =3D tls_multi->peer_info;
     unsigned int proto =3D extract_iv_pr=
oto(peer_info);
 
-
     /* Calculate the maximum timeout and subtract the =
time we already waited */
     unsigned int max_timeout =3D
         max_ui=
nt(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_win=
dow);
@@ -732,6 +787,12 @@
                 client_max_mtu, o->ce=2Etun_mtu=
, o->ce=2Etun_mtu);
         }
     }
+
+    if (tls_multi->acc_negotiated_=
protocols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "custom-=
control %d A:6 %s",
+                        tls_multi->acc_max_message_len=
gth, tls_multi->acc_negotiated_protocols);
+    }
 }
 
 static bool
diff --=
git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2Ee08cd6=
6 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52=
,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /**
  *=
 @brief Handles the receiving of a push-update message and applies updates =
to the specified
  * options=2E
@@ -92,7 +93,15 @@
 
 void receive_exit_mes=
sage(struct context *c);
 
-void server_pushed_info(const struct buffer *bu=
ffer, const int adv);
+/**
+ * This message is called when an INFO or INFO_=
PRE message is received from
+ * a peer=2E
+ *
+ * @param c         Context=
 of the peer=2E
+ * @param buffer    Buffer containing the INFO/INFO_PRE me=
ssage=2E
+ * @param adv       number of character to advance past the INFO/=
INFO_PRE header
+ */
+void peer_pushed_info(struct context *c, const struct=
 buffer *buffer, const int adv);
 
 void receive_cr_response(struct context=
 *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec b/src=
/openvpn/ssl=2Ec
index 086a6fc=2E=2E97ef9b0 100644
--- a/src/openvpn/ssl=2E=
c
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh=
"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #incl=
ude "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
     fr=
ee(multi->locked_cn);
     free(multi->locked_username);
     free(multi->l=
ocked_original_username);
+    free(multi->acc_negotiated_protocols);
 
   =
  cert_hash_free(multi->locked_cert_hash_set);
 
@@ -2098,6 +2100,11 @@
 #e=
ndif
         }
 
+        if (session->opt->acc_protocols)
+        {
+   =
         buf_printf(&out, "IV_ACC=3D%d,A:6,%s\n", ACC_MAX_MSG_LEN, session-=
>opt->acc_protocols);
+        }
+
         if (session->opt->push_peer_inf=
o_detail > 1)
         {
             struct env_set *es =3D session->opt->=
es;
@@ -2398,6 +2405,8 @@
         multi->remote_ciphername =3D string_allo=
c("none", NULL);
     }
 
+    determine_common_acc_protocols(multi, sessio=
n);
+
     if (username_len < 0 || password_len < 0)
     {
         msg(D_=
TLS_ERRORS, "TLS Error: Username (%d) or password (%d) too long", abs(usern=
ame_len),
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=
=2Eh
index 9a55ead=2E=2E436770b 100644
--- a/src/openvpn/ssl_common=2Eh
+++=
 b/src/openvpn/ssl_common=2Eh
@@ -457,6 +457,9 @@
     size_t ekm_size;
 
 =
    bool dco_enabled; /**< Whether keys have to be installed in DCO or not =
*/
+
+    /** The app custom control protocols we should announce as suppor=
ted */
+    const char *acc_protocols;
 };
 
 /** @addtogroup control_proce=
ssor
@@ -730,6 +733,12 @@
     int dco_peer_id;
 
     dco_context_t *dco;
=
+
+    /** the protocols that are negotiated with the peer=2E */
+    char =
*acc_negotiated_protocols;
+
+    /** the maximum length of an ACC control =
channel message */
+    int acc_max_message_length;
 };
 
 /**  gets an ite=
m  of \c key_state objects in the
diff --git a/tests/unit_tests/openvpn/Mak=
efile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E6a73=
e1e 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_te=
sts/openvpn/Makefile=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SO=
URCES =3D test_ssl=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_=
msg=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=
=2Ec mock_win32_execve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec =
\
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2E=
c \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/bu=
ffer=2Ec \
@@ -132,6 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec =
\
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/openvpn=
/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir=
)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=
=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \
diff --git a/te=
sts/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_=
management=2Ec
index fff4c2b=2E=2Ef572dbb 100644
--- a/tests/unit_tests/ope=
nvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec=

@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #inc=
lude "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests=
/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_de=
pendencies=2Ec
index bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_tests/ope=
nvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_de=
pendencies=2Ec
@@ -43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_R=
OUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P=
_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
         =
             | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_=
PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MT=
U | OPT_P_ROUTE | OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OP=
T_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                   =
  | OPT_P_ACC;
     return flags;
 }
 
diff --git a/tests/unit_tests/openvp=
n/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
new file mode 100644=

index 0000000=2E=2E9364d12
--- /dev/null
+++ b/tests/unit_tests/openvpn/te=
st_acc=2Ec
@@ -0,0 +1,353 @@
+/*
+ *  OpenVPN -- An application to securely=
 tunnel IP networks
+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based
+ *             session authentication and key exchange=
,
+ *             packet encryption, packet authentication, and
+ *        =
     packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *=

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
+ *  with this program; if not, write to the Free Softwar=
e Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 0211=
0-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+=

+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#i=
nclude <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include=
 <cmocka=2Eh>
+
+#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include "tes=
t_common=2Eh"
+
+#include "mock_msg=2Eh"
+#include "multi=2Eh"
+
+char cont=
rol_channel_message_sent[2048];
+
+/* Mock functions */
+bool
+send_control=
_channel_string_dowork(struct tls_session *session,
+                      =
             const char *str, unsigned int msglevel)
+{
+    assert_int_in_=
range(strlen(str), 0, 2047);
+
+    strcpy(control_channel_message_sent, st=
r);
+    return true;
+}
+
+void
+send_push_reply_auth_token(struct tls_mul=
ti *multi)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *multi, c=
onst char *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxL=
BpZw9JnjI3tBM"                \
+                    "r4engpg/cDgS48DMaxyCd=
bzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+                    "4md4OJwoQAwEwITA=
xMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+                    "AJwBnwArAFA=
A5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "QAXAB4=
AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "I=
CAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                 =
   "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+            =
        "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_messages=
(void **state)
+{
+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    /* en=
sure that the messages get to mock_msg */
+    x_debug_level =3D 3;
+    ma=
nagement =3D (void *)0x12345678;
+    struct gc_arena gc =3D gc_new();
+
+ =
   /* contains a TLS 1=2E3 ClientHello */
+    const char msg[] =3D "ACC,cc=
k1,384,6," MSG_PAYLOAD;
+
+    struct buffer msg_buf;
+    struct context c=
 =3D { 0 };
+    c=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR=
_GC(c=2Ec2=2Etls_multi, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->=
session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_mu=
lti->session[TM_ACTIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
+    =
buf_set_read(&msg_buf, (void *)msg, sizeof(msg));
+
+    receive_acc_messag=
e(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WARNING: Received =
malformed custom app control channel message (ACC not enabled or no negotia=
ted protocols): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455=
641 774e616[more=2E=2E=2E]");
+    assert_string_equal(mock_managment_buf, =
"");
+
+    c=2Ec2=2Etls_multi->acc_negotiated_protocols =3D "no:common:pro=
tocol";
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mo=
ck_msg_buf, "WARNING: Received malformed custom app control channel message=
 (protocol 'cck1' not in list of negotiated protocols 'no:common:protocol')=
: 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[mo=
re=2E=2E=2E]");
+    assert_string_equal(mock_managment_buf, "");
+
+    c=
=2Ec2=2Etls_multi->acc_negotiated_protocols =3D "cck1:flower:power:fortune"=
;
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_equal(mock_m=
sg_buf, "Received custom app control message (protocol 'cck1')");
+    asse=
rt_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD);=

+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//S=
B0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower=
_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_buf);
+    ass=
ert_string_equal(mock_msg_buf, "Received custom app control message (protoc=
ol 'flower')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0=
,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+    =
CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[] =3D "ACC,for=
tune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=
=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, sizeof(msg_inc=
orrect_len));
+    receive_acc_message(&c, &msg_buf);
+    const char *erro=
r =3D "WARNING: Received malformed custom app control channel "
+          =
              "message (field length 62, payload length 64 mismatch): "
+  =
                      "4143432c 666f7274 756e652c 36322c36 2c496e73 67496d3=
1 "
+                        "6c496a6f 67496d5[more=2E=2E=2E]";
+
+    asse=
rt_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_managme=
nt_buf, "");
+
+    CLEAR(mock_managment_buf);
+    const char msg_fragment=
[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+    buf_set_read(&msg_buf, (voi=
d *)msg_fragment, sizeof(msg_fragment));
+    receive_acc_message(&c, &msg_=
buf);
+    assert_string_equal(mock_msg_buf, "Received custom app control m=
essage (protocol 'power', fragment)");
+    assert_string_equal(mock_managm=
ent_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock_man=
agment_buf);
+    /* check two encoding present */
+    const char flower_m=
sg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJ=
vZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_msg_two_encs, si=
zeof(flower_msg_two_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    =
error =3D "WARNING: Received malformed custom app control channel message "=

+            "(number of encodings must be exactly one (B64=3D1, ASCII=3D1=
)): "
+            "4143432c 666c6f77 65722c34 382c3641 2c535342 68625341 4=
1494574 "
+            "6c636d3[more=2E=2E=2E]";
+
+    assert_string_equal=
(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
=
+    /* no encoding present */
+    const char flower_msg_no_encs[] =3D "AC=
C,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    bu=
f_set_read(&msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs)=
);
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Recei=
ved malformed custom app control channel message "
+            "(number of=
 encodings must be exactly one (B64=3D0, ASCII=3D0)): "
+            "41434=
32c 666c6f77 65722c34 382c2c53 53426862 53414149 45746c63 "
+            "6=
d31706[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+   =
 assert_string_equal(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+=
    management =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_=
acc_parameters(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    =
/* parameters to INFO message */
+    const char *info_acc_msg =3D "4096 A:=
6 flower:happy";
+
+    int max_len =3D 0;
+    const char *protocols =3D p=
arse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_st=
ring_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1280)=
;
+
+    /* a client does not accept a length longer than it supports */
+ =
   protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &=
gc);
+    assert_null(protocols);
+
+    /* message with lower limit than o=
ur, should work for client and server */
+    info_acc_msg =3D "1111 A:6 fl=
ower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &ma=
x_len, false, &gc);
+    assert_string_equal(protocols, "flower:happy");
+ =
   assert_int_equal(max_len, 1111);
+
+    protocols =3D parse_acc_paramete=
rs(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protoc=
ols, "flower:happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more =
encodings than supported=2E Server should be okay, client should fail */
+ =
   info_acc_msg =3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc=
_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(prot=
ocols);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_l=
en, true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    a=
ssert_int_equal(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_=
msg =3D "1400 A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters=
(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+ =
   protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &=
gc);
+    assert_null(protocols);
+
+
+    const char *iv_acc_capabilities =
=3D "1400,A:6,flower:happy:power";
+    protocols =3D parse_acc_parameters(=
iv_acc_capabilities, ",", &max_len, true, &gc);
+    assert_string_equal(pr=
otocols, "flower:happy:power");
+
+    /* too small protocol length */
+   =
 info_acc_msg =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_param=
eters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);=

+
+    /* non-numerical protocol length */
+    info_acc_msg =3D "abff A:6=
 flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", =
&max_len, true, &gc);
+    assert_null(protocols);
+
+    gc_free(&gc);
+}
=
+
+void
+test_acc_common_protocols(void **state)
+{
+    struct multi_insta=
nce mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->options=
=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls=
_multi, &c->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROT=
O=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c->options=2Eacc_prot=
ocols =3D "power:flower:star";
+    struct tls_multi *multi =3D c->c2=2Etls=
_multi;
+    multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+  =
  multi->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D=
 env_set_create(&c->options=2Egc);
+
+    determine_common_acc_protocols(mu=
lti, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    assert_int_equal(multi=
->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(multi-=
>acc_negotiated_protocols, "power:flower");
+
+    assert_string_equal(env_=
set_get(multi->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");=

+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), =
"acc_message_len=3D1280");
+
+    free(multi->acc_negotiated_protocols);
+ =
   gc_free(&c->options=2Egc);
+}
+
+void
+test_acc_send_message(void **stat=
e)
+{
+    struct multi_instance mi =3D { 0 };
+    struct context *c =3D &=
mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(=
c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+    bool ret;
+   =
 struct tls_multi *multi =3D c->c2=2Etls_multi;
+    c->options=2Eacc_proto=
cols =3D "power:flower:emergency";
+    multi->opt=2Eacc_protocols =3D c->o=
ptions=2Eacc_protocols;
+    multi->session[TM_ACTIVE]=2Eopt =3D &multi->op=
t;
+    multi->opt=2Ees =3D env_set_create(&c->options=2Egc);
+
+    c->c2=
=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emer=
gency:power";
+    determine_common_acc_protocols(multi, &c->c2=2Etls_multi=
->session[TM_ACTIVE]);
+
+    struct tls_session *session =3D &c->c2=2Etls_=
multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_message(c, c->c2=2Etls_m=
ulti, session, "emergency", true,
+                           "EMERGENCY BR=
OADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    assert_true(ret);
+=
    assert_string_equal(control_channel_message_sent,
+                    =
    "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:=
");
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergen=
cy", false,
+                           "THE GOVERNMENT HAS ISSUED A RAINBO=
W COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_true(ret);
+    ass=
ert_string_equal(control_channel_message_sent,
+                        "AC=
C,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOU=
R AREA=2E");
+
+
+    /* test a long message (> 1000) with fragment to get =
the maximum header size */
+    char long_message[1200] =3D { 0 };
+
+    f=
or (int i =3D 0; i < 1024; i++)
+    {
+        long_message[i] =3D (char)(=
' ' + (i % 95));
+    }
+
+    /* last char of the message is a i and then =
a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    assert_int_equ=
al(long_message[1024], '\0');
+
+    ret =3D send_acc_message(c, c->c2=2Etl=
s_multi, session, "emergency", true,
+                           long_messa=
ge, false);
+
+    assert_true(ret);
+    size_t cc_len =3D strlen(control_=
channel_message_sent);
+    assert_int_equal(control_channel_message_sent[c=
c_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC,emergency,102=
4,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_channel_m=
essage_sent, expected_start_cc, strlen(expected_start_cc));
+
+    free(mul=
ti->acc_negotiated_protocols);
+    gc_free(&c->options=2Egc);
+}
+
+void
+=
test_list_intersection(void **state)
+{
+    const char *empty =3D "";
+   =
 const char *protos =3D "power:flower:emergency";
+
+    struct gc_arena gc=
 =3D gc_new();
+
+    struct buffer t1 =3D get_list_intersection(&gc, empty=
, protos);
+    assert_int_equal(buf_len(&t1), 0);
+
+    struct buffer t2 =
=3D get_list_intersection(&gc, protos, empty);
+    assert_int_equal(buf_le=
n(&t2), 0);
+
+    struct buffer t3 =3D get_list_intersection(&gc, protos, =
protos);
+    assert_string_equal(buf_cstr(&t3), protos);
+
+    const char=
 *protos2 =3D "flower:emergency:power:mario";
+    struct buffer t4 =3D get=
_list_intersection(&gc, protos2, protos);
+    assert_string_equal(buf_cstr=
(&t4), "flower:emergency:power");
+
+    const char *protos3 =3D "super:pap=
er:mario:flower";
+    struct buffer t5 =3D get_list_intersection(&gc, prot=
os2, protos3);
+    assert_string_equal(buf_cstr(&t5), "flower:mario");
+
+=
    const char *proto4 =3D "flower:flower:flower:flower";
+    struct buffe=
r t6 =3D get_list_intersection(&gc, proto4, "flower");
+    assert_string_e=
qual(buf_cstr(&t6), "flower");
+
+
+    gc_free(&gc);
+}
diff --git a/tests=
/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
ne=
w file mode 100644
index 0000000=2E=2E32421fb
--- /dev/null
+++ b/tests/uni=
t_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An applic=
ation to securely tunnel IP networks
+ *             over a single UDP port=
, with support for SSL/TLS-based
+ *             session authentication and=
 key exchange,
+ *             packet encryption, packet authentication, an=
d
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Op=
enVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you=
 can redistribute it and/or modify
+ *  it under the terms of the GNU Gener=
al Public License version 2
+ *  as published by the Free Software Foundati=
on=2E
+ *
+ *  This program is distributed in the hope that it will be usef=
ul,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU =
General Public License for more details=2E
+ *
+ *  You should have receive=
d a copy of the GNU General Public License along
+ *  with this program; if=
 not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+
+#ifndef TEST_ACC=
_H
+#define TEST_ACC_H
+void test_acc_parse_client_messages(void **state);
=
+
+void test_parse_acc_parameters(void **state);
+
+void test_acc_common_pr=
otocols(void **state);
+
+void test_acc_send_message(void **state);
+
+void=
 test_list_intersection(void **state);
+#endif
diff --git a/tests/unit_test=
s/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh
index =
8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_tests/openvpn/test_common=2Eh
=
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -43,11 +43,13 @@
 #define=
 LargestIntegralType uintmax_t
 #endif
 /* redefine 2=2Ex API in terms of 1=
=2Ex API */
-#define CMockaValueData             LargestIntegralType
-#defi=
ne check_expected_uint         check_expected
-#define expect_uint_value   =
        expect_value
-#define expect_check_data           expect_check
-#de=
fine cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValueData              =
         LargestIntegralType
+#define check_expected_uint                  =
 check_expected
+#define expect_uint_value                     expect_value=

+#define expect_check_data                     expect_check
+#define cast_=
ptr_to_cmocka_value(x)           (x)
+#define assert_int_in_range(value, mi=
n, max)  assert_in_range((value), (min), (max))
+#define assert_uint_in_ran=
ge(value, min, max) assert_in_range((value), (min), (max))
 #endif
 
 /**
d=
iff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvp=
n/test_ssl=2Ec
index 4baf8cc=2E=2E4987dd0 100644
--- a/tests/unit_tests/ope=
nvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,=
8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_a=
cc=2Eh"
+
 /* Mock function to be allowed to include win32=2Ec which is req=
uired for
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 =
@@
 {
     return;
 }
+void
+reschedule_multi_process(struct context *c)
+{=

+}
+
+/* Define a dummy dco cipher option to avoid linking against all the=
 DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported=
_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-=
GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req -x=
509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -1111,8 =
+1127,12 @@
         cmocka_unit_test(ssl_test_extract_last_matching_field)=
,
         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
        =
 cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
-        cmoc=
ka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_test(ssl_te=
st_extract_peer_info),
+        cmocka_unit_test(test_acc_parse_client_mess=
ages),
+        cmocka_unit_test(test_parse_acc_parameters),
+        cmock=
a_unit_test(test_acc_common_protocols),
+        cmocka_unit_test(test_acc_=
send_message),
+        cmocka_unit_test(test_list_intersection)
     };
 
=
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Chang=
e-Number: 1858
Gerrit-PatchSet: 24
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revi=
ewer: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evi=
gue@openvpn=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--VQIhANvRbGM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
, chugly=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #24</strong> to=
 this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858?usp=3Demail">View Change</a></p><p>The following approvals got outdat=
ed and were removed:
Code-Review+2 by chugly, Code-Review-1 by R=C4=83zvan =
Cojocaru</p><p>The change is no longer submittable: Code-Review and checks~=
ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">Implement sending/=
receiving app custom control protocol messages<br><br>This allows openvpn G=
UI/front-ends and server via management<br>to use the OpenVPN control chann=
el to pass messages between each other<br>while OpenVPN handles the marshal=
ling/unmarshalling of these and<br>negotiate the common app custom control =
protocols=2E<br><br>This provides an easy to use secure channel that does n=
ot depend on<br>the network itself to work and can also be used before full=
y<br>authenticating the client=2E See the management-notes=2Etxt for more<b=
r>details how to use this feature=2E An upcoming patch will also add<br>som=
e example python scripts that showcase this feature=2E<br><br>Change-Id: I4=
a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/c=
lient-options=2Erst<br>M doc/man-sections/management-options=2Erst<br>M doc=
/man-sections/script-options=2Erst<br>M doc/management-notes=2Etxt<br>M src=
/openvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br=
>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manag=
e=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openv=
pn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M =
src/openvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=
=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/open=
vpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/mock_push_dependencie=
s=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests/open=
vpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/u=
nit_tests/openvpn/test_ssl=2Ec<br>26 files changed, 1,546 insertions(+), 23=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/58/1858/24</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=2E4deabe7 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -435,6 +435,8 @@</span><br><span>     src/compat/com=
pat-strlcpy=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span><br=
><span>     src/compat/compat-strtok_r=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     src=
/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><span=
>     src/openvpn/base64=2Ec</span><br><span>@@ -826,6 +828,8 @@</span><br>=
<span>             tests/unit_tests/openvpn/mock_management=2Ec</span><br><=
span>             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span>=
<br><span>             tests/unit_tests/openvpn/mock_win32_execve=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_te=
sts/openvpn/test_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            src/openvpn/acc=2Ec</span><br><span>             src/openv=
pn/argv=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><br><=
span>             src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -842,6 +8=
46,7 @@</span><br><span>             src/openvpn/packet_id=2Ec</span><br><s=
pan>             src/openvpn/run_command=2Ec</span><br><span>             s=
rc/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            src/openvpn/ssl_ncp=2Ec</span><br><span>             src=
/openvpn/ssl_openssl=2Ec</span><br><span>             src/openvpn/ssl_util=
=2Ec</span><br><span>             src/openvpn/ssl_verify_mbedtls=2Ec</span>=
<br><span>diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sect=
ions/client-options=2Erst</span><br><span>index 87c138a=2E=2E16309f9 100644=
</span><br><span>--- a/doc/man-sections/client-options=2Erst</span><br><spa=
n>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -437,6 +43=
7,12 @@</span><br><span>         Additional authentication methods supporte=
d by the client=2E</span><br><span>         This may be set by the client U=
I/GUI using ``--setenv``=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags&g=
t;,&lt;protocols&gt;`</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        If the option ``--app-custom-control`` is set, the client will</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        send the suppo=
rted max ACC message length, the supported formats</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        as (:code:`A:6`) and the list of con=
figured protocols (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        :code:`flower:happy:power`)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>   The following flags depend on w=
hich compression formats are compiled in</span><br><span>   and whether com=
pression is allowed by options=2E See `Protocol options`_</span><br><span> =
  for more details=2E</span><br><span>diff --git a/doc/man-sections/managem=
ent-options=2Erst b/doc/man-sections/management-options=2Erst</span><br><sp=
an>index 2c79d05=2E=2E315e567 100644</span><br><span>--- a/doc/man-sections=
/management-options=2Erst</span><br><span>+++ b/doc/man-sections/management=
-options=2Erst</span><br><span>@@ -144,3 +144,17 @@</span><br><span> </span=
><br><span> --management-up-down</span><br><span>   Report tunnel up/down e=
vents to management interface=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-=
custom-control protocol-list</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Sets the list of supported app custom control protocols=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  These protocols are ann=
ounced to the server via the IV_ACC peer info</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  variable when this option is used on a client=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If the option =
is set on a server it will negotiate common protocols</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  with the client=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  The protocol-list is a : separated list of protocol ident=
ifiers=2E Protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 identifiers must consist of alphanumeric characters, :code:`-`, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`_`=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  See management-notes=2Etxt in the OpenVPN distri=
bution and the OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  draft for a description of app custom control protocol support=2E<=
/span><br><span>diff --git a/doc/man-sections/script-options=2Erst b/doc/ma=
n-sections/script-options=2Erst</span><br><span>index f420380f=2E=2E474c7fd=
 100644</span><br><span>--- a/doc/man-sections/script-options=2Erst</span><=
br><span>+++ b/doc/man-sections/script-options=2Erst</span><br><span>@@ -10=
06,3 +1006,12 @@</span><br><span>        X509_1_L=3DBISHKEK</span><br><span=
>        X509_1_ST=3DNA</span><br><span>        X509_1_C=3DKG</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+:code:`acc_protocols`</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    If ``--app-custom-control`` is configured and =
the client supports any of the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    protocols that server also supports, this variable contains =
a list of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    common=
 protocols separated by :=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`acc=
_message_len`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 :code:`acc_protocols` is set, this variable contains the maximum</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    message length for app cu=
stom protocol message=2E</span><br><span>diff --git a/doc/management-notes=
=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 4d726c4=2E=2E48cb=
b54 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span=
>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -828,6 +828,58 @@</spa=
n><br><span> that is required to continue the connection (unlike MFA or ope=
ning a browser)</span><br><span> this message is not negotiated but can jus=
t be sent as a gratuitous message=2E</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+app custom control</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+If t=
he special string &quot;ACC&quot; is passed as {EXTRA} OpenVPN will determi=
ne</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the common app cu=
stom protocols between the client and the server and instruct</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+the client that the server will s=
end control messages to the client using</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+the ACC protocol=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+The server should then use client-acc-msg command to send app custom</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+control messages to the =
client to facilitate the pending authentication=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+-------------------------------=
------------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+On an OpenVPN instan=
ce running in server mode this command sends an</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+app custom control message to a client=2E The f=
ormat of the command is:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client-acc-m=
sg {CID} {KID}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {pr=
otocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+CID,KID -- client ID and Key ID=2E See documentation for &quot;=
&gt;CLIENT:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+no=
tification for more info=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+protocol --=
 the ACC protocol identifier that this message should be</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            tagged with=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+flags    -- a character list of the encoding and t=
he flag if the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       message is a fragment=2E E=2Eg=2E &quot;6F&quot; for a base64 encode=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            messag=
e that is also a fragment and not complete yet=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+message  -- The message encoded in the encoding specified in fla=
gs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+------------------------------=
------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+When OpenVPN is running in=
 --client mode this command sends an app</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+custom command to the server=2E The format of the comm=
and is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+See the client-acc-msg c=
ommand for more details about the format of the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+message=2E Since a client has only one peer the=
re is no need to specify the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+client id and key id=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><sp=
an> -----------------------------------------------</span><br><span> </span=
><br><span>@@ -1302,6 +1354,52 @@</span><br><span>    response=2E Mechanism=
s that need multiple rounds or more complex answers</span><br><span>    sho=
uld implement a different response type than CR_RESPONSE=2E</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+(6) App custom co=
ntrol message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    This message is an ap=
plication specific payload message that is transported</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    over the OpenVPN control channel=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    In server mode:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_=
base64}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    In client mode:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &gt;ACC:{protocol},{fragment},{msg_base64}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    The protocol is a short ascii string =
identifying the app specific custom</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    protocol=2E If fragment is set to 1, the message is not=
 complete and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  next message should be concatenated to this message to form a complete</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    message=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    Note that the OpenVPN implementation opera=
tes here with the robustness</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    principle (&quot;be conservative in what you send, be liberal =
in what you</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    acce=
pt&quot; - RFC 793 and others) and allows receiving messages longer than</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    maximum allowed me=
ssage length=2E Implementations should be prepared to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    handle messages that are longer than =
the maximum allowed message length=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OpenVPN does not verify that the message is valid base64=2E A peer that<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sends invalid ba=
se64 payload will be passed to the management interface=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    An implementation should be prep=
ared to handle invalid base64 and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    handle accordingly (e=2Eg=2E disconnect the client via cl=
ient-deny or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ign=
ore such messages)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(7) App custom co=
ntrol protocol message</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   This message =
informs the client about the common ACC</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   protocols and the maximum message length for an ACC =
message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+   In client mode:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list}=
,message_len=3D{max_msg_len}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protoco=
l_list is the list of supported protocols by both server and client=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+   For example flower:po=
wer:sys_info would indicate these three protocols</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+   are supported=2E max_msg_len specifies the=
 maximum message length that the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   peer supports=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   In =
server mode these information are available in the acc_protocols and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   acc_message_len variabl=
es of the client environment=2E</span><br><span> </span><br><span> Variable=
s:</span><br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam=
 b/src/openvpn/Makefile=2Eam</span><br><span>index 8a60a94=2E=2Eebc4db6 100=
644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/s=
rc/openvpn/Makefile=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><br><span>=
 sbin_PROGRAMS =3D openvpn</span><br><span> </span><br><span> openvpn_SOURC=
ES =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec ac=
c=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=
=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><=
span>@@ -124,7 +125,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br>=
<span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \<=
/span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec refle=
ct_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><sp=
an>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2Ea05d55c</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span=
>@@ -0,0 +1,445 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
 free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, write to the Free Software Foundati=
on, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
yshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+log_acc_message=
(struct context *c, const struct buffer *buf, int payload_len,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                const char *prot=
ocol, int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D=
 flags &amp; ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *payload_msg =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* For simplicity, we always =
encode payload to be base64 encoded</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * if not already in base64 format */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS=
_ASCII)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        char *b64out =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(=
openvpn_base64_encode(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b=
64out, free, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        payload_msg =3D b64out;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D =
CBSTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct tls_session *session =3D &amp;c-&gt;c2=
=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* server mode=2E Report client context */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct =
man_def_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            unsigned int mda_key=
_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&=
gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                mda-&gt;cid, mda_key_id, protocol, fragmen=
t, payload_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* Client mode=2E =
Do not a report a CLIENT id */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol=
, fragment, payload_msg);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef =
ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_PUSH, &quot;Received custom app control message (protocol &#39;%=
s&#39;%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     protocol, fragment ? &quot;, fragment&quot; : &quot;&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(co=
nst char *flags, const char **err_reason, struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; fl=
ag++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#3=
9;A&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flag=
s |=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&=
#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=
=3D ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *er=
r_reason =3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return -1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* The message should be encoded with exactly one encoding=2E En=
sure that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * onl=
y one of the flags is present */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS=
_ASCII);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ba=
se64enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 51=
2, &quot;number of encodings must be exactly one &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                           &quot;(B64=
=3D%d, ASCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 base64enc, asciienc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *err_reason =3D tmp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return acc_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Wrapper around parse_acc_message_flags to also =
include the step of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * extracting the flags from the buffer and forwarding the buffer</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * beyond the flags field=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+pase_acc_mesage_flags_buf(struct buffer *buf,=
 const char **err_reason, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *flags =3D buf_extract_field(buf, &#39;,&#39;, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *err_reason =3D &quot;could not extract flags f=
ield&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return parse_acc_me=
ssage_flags(flags, err_reason, gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct context *=
c, const struct buffer *buffer)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *err_reason =3D &quot;&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D *buffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tls_m=
ulti *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        err_reason =3D &quot;ACC not enabled o=
r no negotiated protocols&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_advance(&=
amp;buf, strlen(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;mis=
sing , after ACC&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* extract protocol, payloa=
d length, flags substrings */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *protocol =3D buf_extract_field(&amp;buf, &#39;,&#=
39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!protocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =
=3D &quot;could not extract protocol field&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!tls_item_in_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct buffer msg_buf =3D =
alloc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf_printf(&amp;msg_buf, &quot;protocol &#39;%s&#39; not i=
n list of negotiated protocols &#39;%s&#39;&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   protocol, multi-&gt;acc_n=
egotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        err_reason =3D buf_cstr(&amp;msg_buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        g=
oto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* We do not check the length here=2E We=
 make no promises to support</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * anything larger than our announced message length but accor=
ding to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the r=
obustness principle</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * (&quot;be conservative in what you send, be liberal in what you acce=
pt&quot; - RFC 793 and others)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * we accept also longer messages */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int payload_len;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *payload_len_str =3D buf_extract_field(&amp;=
buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!payload_len_str</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        || !atoi_constrained(payload_len_str, &amp;payload_len=
, &quot;acc_payload_len&quot;, 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;coul=
d not extract payload length field&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags=
 =3D pase_acc_mesage_flags_buf(&amp;buf, &amp;err_reason, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We should h=
ave a final NUL byte in the control message buffer</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * and thus the length of the buffer sho=
uld be payload_len + 1 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512=
, &quot;field length %d, payload length %d mismatch&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 payload_len, buf_le=
n(&amp;buf) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      err_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_len, pr=
otocol, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Receiv=
ed malformed custom app control channel &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                       &quot;message (%s): %s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_rea=
son,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        format_=
hex(CBPTR(buffer), BLEN(buffer), 80, &amp;gc));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct t=
ls_multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              struct tls_session *session,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 const char *protocol, bool fragment=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 c=
onst char *acc_msg_payload, bool base64)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * len=
gth of the protocol string + one &#39;,&#39;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * 2 for the encoding (A or 6), potential F (f=
ragment), and 1 for the &#39;,&#39;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * 4 for the message size itself and one comma</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * 1 for the comma befo=
re the message itself */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;) + strlen=
(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    size_t len =3D max_header_size + strlen(acc_msg_payload);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;message=
 length (%zu) exceeds maximum possible message length (%d)&quot;, len, TLS_=
CHANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &gt; multi-&gt;=
acc_max_message_length)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_CLIENT, &quot;header (%zu) + message size (%zu) length (%zu) exceeds &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
       &quot;maximum allowed length negotiated with peer (%d)&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            max_header_siz=
e, strlen(acc_msg_payload), len,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi-&gt;acc_max_message_length);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(len + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example me=
ssage: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&qu=
ot;, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
          strlen(acc_msg_payload),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+               base64 ? &quot;6&quot; : &quot;A&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+               fragment ?=
 &quot;F&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+               acc_msg_payload);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool ret =3D send_control_channel_string_dowork(session, BSTR(&amp=
;buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
reschedule_multi_process(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabili=
ties,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
       const char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     int *max_acc_len,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     bool server,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     struct gc_arena=
 *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string=
_alloc(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char *tmp_message_orig =3D tmp_message;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_message, delim,=
 &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we =
allow more capabilities than our own, in client</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * mode we reject if we should use capabili=
ties that we do not support */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(tok=
en, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowed_a=
cc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp=
; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher_li=
st(&quot;6&quot;, token)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_PUSH_ERRORS, &quot;App custom control encoding must include =
base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            goto done;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D =
1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; s=
trcmp(token, &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_PUSH_ERRORS, &quot;App custom control encoding must be e=
xactly base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto done;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =
=3D=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            protocol=
s =3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too =
many parameters for INFO ACC message/IV_ACC=2E&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_list_inte=
rsection(struct gc_arena *gc, const char *list1, const char *list2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *tmp =3D string_alloc(list1, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *token =3D strtok_r(tmp, &quot;:&quot;, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* The maximum possible length is the shorter of the two=
 input lists */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
size_t max_len =3D min_size(strlen(list1), strlen(list2));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer common_protocols =3D alloc_buf_gc(max=
_len + 1, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* check for every items is in b=
oth lists and not already in the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * common list */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (tls_item_in_cipher_list(token, list2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !tl=
s_item_in_cipher_list(token, buf_cstr(&amp;common_protocols)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(&amp;common_proto=
cols) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    buf_write_u8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            buf_printf(&amp;common_protocols, &=
quot;%s&quot;, token);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free(tmp);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return common_protocols;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protoco=
ls(struct tls_multi *multi, struct tls_session *session)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* No app custom protocols have been confi=
gured server-side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_=
protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We already h=
ave determined the common protocols=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* example IV=
_ACC: IV_ACC=3D2048,6:A,flower:power */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *peer_info =3D multi-&gt;peer_info;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc =
=3D extract_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *protocols =3D parse_acc_parameters(iv_acc, &quot;=
,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info variable of peer is =
malformed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_protocols =3D =
get_list_intersection(&amp;gc, multi-&gt;opt=2Eacc_protocols, protocols);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_protocols) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG=
, &quot;WARNING: No common app custom control protocol=2E&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    multi-&gt;acc_negotiated_protocols =3D string_alloc(buf_=
str(&amp;common_protocols), NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    multi-&gt;acc_max_message_length =3D max_acc_len;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    setenv_str(session-&gt;opt-&gt;es, &quot;=
acc_protocols&quot;, multi-&gt;acc_negotiated_protocols);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    setenv_int(session-&gt;opt-&gt;es=
, &quot;acc_message_len&quot;, multi-&gt;acc_max_message_length);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_proto=
cols(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef E=
NABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLI=
ENT, &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_n=
egotiated_protocols, multi-&gt;acc_max_message_length);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/a=
cc=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E9c99b11</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/acc=2Eh</span><br><span>@@ -0,0 +1,130 @@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             session authentication and key e=
xchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write t=
o the Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method parses an =
app custom control message and delivers it to the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * management interface=2E We leave reassembl=
y of fragmented messages to the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * management interface=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param c            The context struct</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param buffer       Buffer containing the contro=
l message with ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct conte=
xt *c, const struct buffer *buffer);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(=
struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                struct tls_multi *tls_multi,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 struct tls_session *session,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const c=
har *protocol, bool fragment,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 const char *msg, bool base64);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an inf=
o message from the server that contains app custom control info</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * information prior to the PUS=
H_REPLY to be able to use app custom control</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * protocols before sending</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * In client mode only allow what we support ourselves=2E =
In server mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * al=
low also capabilities that we not support ourselves=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param capabilities      The string to parse</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param delim             T=
he delimiter to use when parsing the string=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *                          IV_ACC uses &quot;,&=
quot; as delimiter while the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          custom-control PUSH message uses &quot=
; &quot; as &quot;,&quot; is</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          already used to separate different pus=
h directives</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am max_acc_len       Set to the maximum ACC message length</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param server            Whether =
we are server or client</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param gc                The gc arena to use for allocating the resu=
lting string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn                  The resulting protocol string or NULL on error</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     const =
char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              int *max_acc_len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     bool server,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     struct gc_arena *gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Parses the IV_ACC of the peer and sets multi=2Eacc_negotia=
ted_protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to =
the common protocols of server and client and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * multi=2Eacc_max_message_length  to the maximum=
 length of the ACC message</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * support by both server and client=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * If there is no common protocol or the client does not support =
any app custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pr=
otocol multi=2Eacc_negotiated_protocols will be set to NULL=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param multi      the multi instance to use th=
e set the app custom protocols=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param session    the session to read the client env from<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct tls_multi *mu=
lti, struct tls_session *session);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Flags returned by=
 the parse_acc_message_flags method</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
enum acc_message_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_=
FLAGS_ASCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Parses the fla=
gs field of an app control message If there is an</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  error parsing the flags field the method =
returns -1 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  p=
uts the error reason in err_reason</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message=
_flags(const char *flags, const char **err_reason, struct gc_arena *gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Calculates the intersection of two list that are both =
separated by :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It=
ems in the result will have the same ordering as in the list1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * parameters</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param gc            Returned buffer=
 will be allocated in this gc</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param list1         First list to intersect</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param list2         Second list t=
o intersect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn A (potentially empty) buffer containing an intersection list</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena *gc, const c=
har *list1, const char *list2);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Notifies a client vi=
a management interface of the negotiated app</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * custom protocols</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param multi the tls_multi instance of the conn=
ection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct tls_multi=
 *multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec=
</span><br><span>index 681210d=2E=2Eeb41d03 100644</span><br><span>--- a/sr=
c/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><=
br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</s=
pan><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #includ=
e &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #i=
nclude &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -257,11 =
+258,11 @@</span><br><span>     }</span><br><span>     else if (buf_string_=
match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(buf,=
 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        peer_pu=
shed_info(c, buf, 8);</span><br><span>     }</span><br><span>     else if (=
buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_in=
fo(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
peer_pushed_info(c, buf, 4);</span><br><span>     }</span><br><span>     el=
se if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))</span><br><=
span>     {</span><br><span>@@ -271,6 +272,10 @@</span><br><span>     {</sp=
an><br><span>         receive_auth_pending(c, buf);</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (buf_str=
ing_match_head_str(buf, &quot;ACC&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        receive_acc_message(c, buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (buf_string_mat=
ch_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {</span><br><span>=
         receive_exit_message(c);</span><br><span>diff --git a/src/openvpn/=
init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 1b8b2a5=2E=2Ee0b99a4 =
100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src=
/openvpn/init=2Ec</span><br><span>@@ -56,6 +56,7 @@</span><br><span> #inclu=
de &quot;schedule=2Eh&quot;</span><br><span> #include &quot;options_string=
=2Eh&quot;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span=
><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><sp=
an> </span><br><span>@@ -2279,6 +2280,13 @@</span><br><span>         }</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi &amp;&amp;=
 multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        buf_printf(&amp;out, &quot; custom-control %d A:6 %s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   multi=
-&gt;acc_max_message_length, multi-&gt;acc_negotiated_protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (BLENZ(&amp;out)=
 &gt; strlen(header))</span><br><span>     {</span><br><span>         msg(D=
_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>@@ -2522,6 +25=
30,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     return flags;</span><br><span>=
 }</span><br><span> </span><br><span>@@ -2730,6 +2743,18 @@</span><br><span=
>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_mtu, c-&gt;option=
s=2Ece=2Etun_mtu);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (found &amp; OPT_P_ACC &amp;=
&amp; c-&gt;options=2Epushed_acc_negotiated_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(mul=
ti-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi-&gt;acc_negotiated_protocols =3D string_alloc(c=
-&gt;options=2Epushed_acc_negotiated_protocols, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_max_message_length=
 =3D c-&gt;options=2Epushed_acc_max_message_length;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: ACC protocols: %s,=
 msg len: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi-&gt;acc_negotiated_protocols, multi-&gt;acc_max_message_l=
ength);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        noti=
fy_client_acc_protocols(multi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     return true;</span><br><span> }</span><br><span> </span=
><br><span>@@ -3352,6 +3377,7 @@</span><br><span>     to=2Everify_hash_dept=
h =3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_=
no_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex=
509_username_field, options-&gt;x509_username_field, sizeof(to=2Ex509_usern=
ame_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=
=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><span>     to=2Ee=
s =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_c=
tx;</span><br><span> </span><br><span>@@ -4306,6 +4332,24 @@</span><br><spa=
n> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
struct buffer_list *input) /* ownership transferred */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_m=
ulti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *mu=
lti =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;session[TM=
_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_se=
nd_acc_message(c, multi, session, input);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_=
list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><=
br><span> void</span><br><span>@@ -4322,6 +4366,7 @@</span><br><span>      =
   cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><span>      =
   cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><span>    =
     cb=2Esend_cc_message =3D management_callback_send_cc_message;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D man=
agement_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>   =
      cb=2Enetwork_change =3D management_callback_network_change;</span><br=
><span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec</span><br><span>index ac3d4b7=2E=2Eaff8146 100644</span><b=
r><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/mana=
ge=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><span> #include &quot;p=
ush=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><sp=
an> #include &quot;resolve=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><=
span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;run_c=
ommand=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENA=
BLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span=
>@@ -1081,6 +1083,35 @@</span><br><span>             }</span><br><span>    =
         break;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Ecli=
ent_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(man-&gt;p=
ersist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                                                      =
man-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                            =
          man-&gt;connection=2Ein_extra_kid,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                                  =
                    man-&gt;connection=2Ein_extra);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_e=
xtra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           report_command_status(status, &quot;client-acc-msg&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                man_command_unsupported(=
&quot;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IEC_=
ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                bool status =3D (*man-&gt;persist=2Ecallba=
ck=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                               =
                man-&gt;connection=2Ein_extra);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_extra =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      report_command_status(status, &quot;acc-msg&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                man_command_unsupported(&quot;acc-=
msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span>         case IEC_PK_SIGN:</span><br><span>           =
  man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><br><span>       =
      buffer_list_free(man-&gt;connection=2Eext_key_input);</span><br><span=
>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_c=
lient_acc_msg(struct management *man, const char *cid_str,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                   const char *kid_s=
tr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D =
&amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in_extra_=
cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&a=
mp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IEC_CLIEN=
T_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
n_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt;conn=
ection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;i=
n_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span> man_client_auth(struct management *man, const char *cid_str, =
const char *kid_str, const bool extra)</span><br><span> {</span><br><span> =
    struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><span>=
@@ -1759,6 +1813,17 @@</span><br><span>             man_client_pending_auth=
(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (man_need(p, 2, 0))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            man_client_acc_msg(man, p[1], p[2]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[=
0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><span>         m=
an_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2975,7 +3040,9 @@<=
/span><br><span>                                        &quot;bytes_sent=3D=
&quot;,</span><br><span>                                        &quot;bytes=
_received=3D&quot;,</span><br><span>                                       =
 &quot;session_id=3D&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                       &quot;session_state=3D&quot; }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                     &quot;session_state=3D&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                       &quot=
;acc_protocols=3D&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                       &quot;acc_message_len=3D&quot; =
};</span><br><span> </span><br><span>     if (env_filter_level =3D=3D 0)</s=
pan><br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> management_=
connection_established(struct management *man, struct man_def_auth_context =
*mdac,</span><br><span>                                   const struct env_=
set *es)</span><br><span>@@ -4372,6 +4440,58 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ma=
nagement_send_acc_message(struct context *c, struct tls_multi *multi, struc=
t tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            struct buffer_list *input)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* also ensures that are enough inputs in the list=
 to safely call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * buffer_list_peek without extra NULL checks */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough =
input lines for sending acc message, &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      &quot;missing protocol, flag =
and/or messages lines&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer=
 *proto_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *protocol =3D string_alloc(CBSTR(proto_=
buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *acc_err_reason =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int acc_flags =3D parse_acc_message=
_flags(buf_cstr(encoding_buf), &amp;acc_err_reason, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (acc_flags &lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: parsin=
g acc message flags failed: %s&quot;, acc_err_reason);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffe=
r_list_aggregate_separator(input, 10000, &quot;&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *acc_msg_buf =
=3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!m=
ulti-&gt;acc_negotiated_protocols</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        || !tls_item_in_cipher_list(protocol, multi-&gt;acc_n=
egotiated_protocols))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_CLIENT, &quot;ERROR: protocol not in the list of negotiated protocols: %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
np(multi-&gt;acc_negotiated_protocols));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto error;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret=
 =3D send_acc_message(c, multi, session, protocol,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                acc_flags &a=
mp; ACC_MESSAGE_FLAGS_FRAGMENT,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                buf_cstr(acc_msg_buf),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEMENT */</span><b=
r><span> </span><br><span> #include &quot;win32=2Eh&quot;</span><br><span>d=
iff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span=
>index 157039d=2E=2Ecc9c264 100644</span><br><span>--- a/src/openvpn/manage=
=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -184,1=
2 +184,19 @@</span><br><span>     int (*n_clients)(void *arg);</span><br><s=
pan>     bool (*send_cc_message)(void *arg, const char *message, const char=
 *parameter);</span><br><span>     bool (*kill_by_cid)(void *arg, const uns=
igned long cid, const char *kill_msg);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     bool (*client_auth)(void *arg, con=
st unsigned long cid, const unsigned int mda_key_id,</span><br><span>      =
                   const bool auth, const char *reason, const char *client_=
reason,</span><br><span>                         struct buffer_list *cc_con=
fig); /* ownership transferred */</span><br><span>     bool (*client_pendin=
g_auth)(void *arg, const unsigned long cid, const unsigned int kid,</span><=
br><span>                                 const char *extra, unsigned int t=
imeout);</span><br><span>     char *(*get_peer_info)(void *arg, const unsig=
ned long cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool (*client_acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           const unsigned long cid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           con=
st unsigned int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           struct buffer_list *msg);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)(void *arg,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    str=
uct buffer_list *msg);</span><br><span>     bool (*proxy_cmd)(void *arg, co=
nst char **p);</span><br><span>     bool (*remote_cmd)(void *arg, const cha=
r **p);</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@ -292,13 +=
299,15 @@</span><br><span>     struct command_line *in;</span><br><span>   =
  struct buffer_list *out;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF          0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_AUTH    1</sp=
an><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIGN    3</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CERTIFICATE 4</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PK_SIGN     5=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PASSWORD =
   6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_RSA=
_SIGN       3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e IEC_CERTIFICATE    4</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define IEC_PK_SIGN        5</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define IEC_PASSWORD       6</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</span><br><span>=
     int in_extra_cmd;</span><br><span>     struct buffer_list *in_extra;</=
span><br><span>     unsigned long in_extra_cid;</span><br><span>@@ -503,6 +=
512,14 @@</span><br><span> </span><br><span> void man_persist_client_stats(=
struct management *man, struct context *c);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC message from t=
he input buffer_list and send to the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * session identified by session and multi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct tls_session;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct tls_multi;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+management_send_acc_message(struct context *c, struct tls_multi *mul=
ti,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            struct tls_session *session, struct buffer_list *input);</span>=
<br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br=
><span> /**</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index e302a81=2E=2Ea3eb3ca 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include &quot;ssl_util=
=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #=
include &quot;reflect_filter=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br=
><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><spa=
n>@@ -4085,6 +4086,26 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static con=
st char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+calculate_=
app_control_extra(struct multi_instance *mi, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;context;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi=
 *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_CLIENT, &quot;ACC: No negotiated protocols&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1024, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&=
quot;, multi-&gt;acc_max_message_length,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               multi-&gt;acc_negotiated_protocols);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&am=
p;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> ma=
nagement_client_pending_auth(void *arg, const unsigned long cid, const unsi=
gned int mda_key_id,</span><br><span>                                const =
char *extra, unsigned int timeout)</span><br><span>@@ -4095,10 +4116,22 @@<=
/span><br><span>     if (mi)</span><br><span>     {</span><br><span>       =
  struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &qu=
ot;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ext=
ra =3D calculate_app_control_extra(mi, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!extra)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
      struct tls_session *session =3D lookup_session_by_mda_key_id(multi, m=
da_key_id);</span><br><span> </span><br><span>         if (!session)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            gc_free(&amp;gc);</span><br><span>             return false;</=
span><br><span>         }</span><br><span> </span><br><span>@@ -4106,6 +413=
9,7 @@</span><br><span>         bool ret =3D send_auth_pending_messages(mul=
ti, session, extra, timeout);</span><br><span>         reschedule_multi_pro=
cess(&amp;mi-&gt;context);</span><br><span>         multi_schedule_context_=
wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   gc_free(&amp;gc);</span><br><span>         return ret;</span><br><span> =
    }</span><br><span>     return false;</span><br><span>@@ -4149,6 +4183,3=
7 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+management_client_acc_msg(void *arg,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                          cons=
t unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          const unsigned int mda_key_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                          struct buff=
er_list *input) /* ownership transferred */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D (struct multi_context *)arg;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *m=
i =3D lookup_by_cid(m, cid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool r=
et =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (mi &amp;&amp; buffer_list_defined(input))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct t=
ls_session *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!session)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quo=
t;client session not found&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buffer_list_free(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ret =3D management_send_acc_message(&amp;mi-&gt;context,=
 multi, session, input);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi_schedule_context_wakeup(m, mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static char *</s=
pan><br><span> management_get_peer_info(void *arg, const unsigned long cid)=
</span><br><span> {</span><br><span>@@ -4185,6 +4250,7 @@</span><br><span> =
        cb=2En_clients =3D management_callback_n_clients;</span><br><span> =
        cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br><span>      =
   cb=2Eclient_auth =3D management_client_auth;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D management_clie=
nt_acc_msg;</span><br><span>         cb=2Eclient_pending_auth =3D managemen=
t_client_pending_auth;</span><br><span>         cb=2Eget_peer_info =3D mana=
gement_get_peer_info;</span><br><span>         cb=2Epush_update_broadcast =
=3D management_callback_send_push_update_broadcast;</span><br><span>diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>ind=
ex fb319ae=2E=2Ea5e7396 100644</span><br><span>--- a/src/openvpn/options=2E=
c</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -35,6 +3=
5,7 @@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;acc=2Eh&quot;</span><br><span> #include &quot;buffer=2Eh&quot;=
</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> #include =
&quot;common=2Eh&quot;</span><br><span>@@ -2552,6 +2553,8 @@</span><br><spa=
n>     o-&gt;push_option_types_found =3D 0;</span><br><span>     o-&gt;push=
_update_options_found =3D 0;</span><br><span>     o-&gt;imported_protocol_f=
lags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&g=
t;pushed_acc_max_message_length =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    o-&gt;pushed_acc_negotiated_protocols =3D NULL;</spa=
n><br><span> }</span><br><span> </span><br><span> static void</span><br><sp=
an>@@ -7107,6 +7110,47 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_=
GENERAL);</span><br><span>         options-&gt;force_key_material_export =
=3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else if (streq(p[0], &quot;app-custom-control&quot;) &amp;=
&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!string_class(p[1], CC_ALNUM | CC_COLON | CC_U=
NDERBAR | CC_DASH, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(msglevel, &quot;App custom control protocols must only contain &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          &quot;alphanumeric characters, &#39;-&#39;, and &#39;_&#39;=2E&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            go=
to err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ac=
c_protocols =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(streq(p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &a=
mp;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      VERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* check if the list from the server is a real subset of our list */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_are=
na gc_local =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct buffer common_list =3D get_list_intersection(&amp;gc_l=
ocal, p[3], options-&gt;acc_protocols);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (buf_len(&amp;common_list) =3D=3D 0 || !streq(p[3], buf_cstr(&a=
mp;common_list)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(msglevel, &quot;App custom control list from server contains &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
   &quot;unsupported protocols&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            gc_free(&amp;gc_local);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        gc_free(&amp;gc_local);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!streq(p[2], &quot;6:A&quot;) &amp;&amp; !s=
treq(p[2], &quot;A:6&quot;))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(msglevel, &quot;App custom control encoding must be base64 a=
nd ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(=
p[1], &amp;options-&gt;pushed_acc_max_message_length,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              &quot;app c=
ustom message message length&quot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msgle=
vel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;pushed_acc_n=
egotiated_protocols =3D p[3];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;prng&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span> =
        msg(M_WARN, &quot;NOTICE: --prng option ignored (SSL library PRNG i=
s used)&quot;);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/=
openvpn/options=2Eh</span><br><span>index 6a3bf61=2E=2Eb7945e0 100644</span=
><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/=
options=2Eh</span><br><span>@@ -715,6 +715,18 @@</span><br><span>     /* fo=
rce using TLS key material export for data channel key generation */</span>=
<br><span>     bool force_key_material_export;</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom control=
 protocols we should announce as supported */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /** the protocols that are negotiated with the peer=
=2E This is a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
  a temporary variable since options=2Ec push parser cannot access</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     *  tls multi struct */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *push=
ed_acc_negotiated_protocols;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** th=
e maximum length of an ACC control channel message via push message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int pushed_acc_max_message_length=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    bool vlan_tagging;</span><br><span>     enum vlan_acceptable_frames vla=
n_accept;</span><br><span>     uint16_t vlan_pvid;</span><br><span>@@ -764,=
8 +776,10 @@</span><br><span> #define OPT_P_INLINE          (1u &lt;&lt; 29=
)</span><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br=
><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ACC             (1ull &lt;=
&lt; 32)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER=
_ID | 0x0ull))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Op=
tions allowed in the normal configuration file (vs pushed options or in ccd=
 files) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
PT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_AC=
C))</span><br><span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt=
;pull)</span><br><span> </span><br><span>diff --git a/src/openvpn/push=2Ec =
b/src/openvpn/push=2Ec</span><br><span>index 42259c3=2E=2Ea18f33b 100644</s=
pan><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/=
push=2Ec</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #include &quot;=
syshead=2Eh&quot;</span><br><span> </span><br><span> #include &quot;push=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</s=
pan><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &=
quot;crypto=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><=
br><span>@@ -221,9 +223,56 @@</span><br><span> #endif</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_server=
_pushed_info_acc(struct context *c, struct buffer *buf)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_pr=
otocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols || !c-&gt;options=2Ep=
ull)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &q=
uot;Peer tried to push app custom control list &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;without =
client announcing support for it&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* example s=
tring to parse: ACC:1400 A:6 flower:happy */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Skip over the ACC: prefix */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, 4);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D p=
arse_acc_parameters(buf_cstr(buf), &quot; &quot;, &amp;max_acc_len, false, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!p=
rotocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERROR=
S, &quot;WARNING: Received ACC info command with invalid parameters&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* check if the list from the server is a real=
 subset of our list */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer common_list =3D get_list_intersection(&amp;gc, protoco=
ls, multi-&gt;opt=2Eacc_protocols);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (buf_len(&amp;common_list) =3D=3D 0 || !streq(protocols, buf_cstr(&amp;=
common_list)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_=
ERRORS, &quot;App custom control list from server contains &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                           &q=
uot;unsupported protocols&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc=
_negotiated_protocols =3D string_alloc(protocols, NULL);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_max_message_length =
=3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 notify_client_acc_protocols(multi);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(const struct buff=
er *buffer, const int adv)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+peer_pushed_info(struct context *c, const struct buffer *buffer, con=
st int adv)</span><br><span> {</span><br><span>     const char *m =3D &quot=
;&quot;;</span><br><span>     struct buffer buf =3D *buffer;</span><br><spa=
n>@@ -233,6 +282,12 @@</span><br><span>         m =3D BSTR(&amp;buf);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        parse_server_pushed_info_acc(c, &=
amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</span><br><span>   =
  if (management)</span><br><span>@@ -257,7 +312,7 @@</span><br><span>     =
    gc_free(&amp;gc);</span><br><span>     }</span><br><span> #endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_PUSH, &quot;Info c=
ommand was pushed by server (&#39;%s&#39;)&quot;, m);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Info command was pu=
shed by peer (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span>@@ -285,6 +340,7 @@</span><br><span>=
     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&#39;)&quot;,=
 m);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Parse the k=
eyword for the AUTH_PENDING request</span><br><span>  * @param buffer      =
          buffer containing the keywords, the buffer&#39;s</span><br><span>=
@@ -441,7 +497,6 @@</span><br><span>     const char *const peer_info =3D tl=
s_multi-&gt;peer_info;</span><br><span>     unsigned int proto =3D extract_=
iv_proto(peer_info);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     /* Calculate the maximum timeout and=
 subtract the time we already waited */</span><br><span>     unsigned int m=
ax_timeout =3D</span><br><span>         max_uint(tls_multi-&gt;opt=2Erenego=
tiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span><br><span>@=
@ -732,6 +787,12 @@</span><br><span>                 client_max_mtu, o-&gt;=
ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         }</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_multi-&gt;acc_neg=
otiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_op=
tion_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6 %s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
tls_multi-&gt;acc_max_message_length, tls_multi-&gt;acc_negotiated_protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span> }</span><br><span> </span><br><span> static bool</span><br><span>dif=
f --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span>index=
 39302f6=2E=2Ee08cd66 100644</span><br><span>--- a/src/openvpn/push=2Eh</sp=
an><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</=
span><br><span> </span><br><span> int process_incoming_push_request(struct =
context *c);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /**</span><br><span>  * @brief Handles the rec=
eiving of a push-update message and applies updates to the specified</span>=
<br><span>  * options=2E</span><br><span>@@ -92,7 +93,15 @@</span><br><span=
> </span><br><span> void receive_exit_message(struct context *c);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void server_p=
ushed_info(const struct buffer *buffer, const int adv);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * This message is called when an INFO or INFO_PRE mess=
age is received from</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * a peer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c         Con=
text of the peer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param buffer    Buffer containing the INFO/INFO_PRE message=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param adv       number o=
f character to advance past the INFO/INFO_PRE header</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void peer_pushed_info(struct context *c, const struct buf=
fer *buffer, const int adv);</span><br><span> </span><br><span> void receiv=
e_cr_response(struct context *c, const struct buffer *buffer);</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c</span><br><span>index 086a6fc=2E=2E97ef9b0 100644</span><br><span>--- a/s=
rc/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><spa=
n>@@ -55,6 +55,7 @@</span><br><span> </span><br><span> #include &quot;crypt=
o_epoch=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</s=
pan><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #includ=
e &quot;ssl_backend=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&q=
uot;</span><br><span>@@ -1279,6 +1280,7 @@</span><br><span>     free(multi-=
&gt;locked_cn);</span><br><span>     free(multi-&gt;locked_username);</span=
><br><span>     free(multi-&gt;locked_original_username);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_pro=
tocols);</span><br><span> </span><br><span>     cert_hash_free(multi-&gt;lo=
cked_cert_hash_set);</span><br><span> </span><br><span>@@ -2098,6 +2100,11 =
@@</span><br><span> #endif</span><br><span>         }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt=
;opt-&gt;acc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      buf_printf(&amp;out, &quot;IV_ACC=3D%d,A:6,%s\n&quot;, ACC_MAX_MSG_LE=
N, session-&gt;opt-&gt;acc_protocols);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>         if (session-&gt;opt-&gt;push_peer_info_d=
etail &gt; 1)</span><br><span>         {</span><br><span>             struc=
t env_set *es =3D session-&gt;opt-&gt;es;</span><br><span>@@ -2398,6 +2405,=
8 @@</span><br><span>         multi-&gt;remote_ciphername =3D string_alloc(=
&quot;none&quot;, NULL);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_prot=
ocols(multi, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     if (username_len &lt; 0 || password_len &lt; 0)</s=
pan><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS E=
rror: Username (%d) or password (%d) too long&quot;, abs(username_len),</sp=
an><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_comm=
on=2Eh</span><br><span>index 9a55ead=2E=2E436770b 100644</span><br><span>--=
- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=
=2Eh</span><br><span>@@ -457,6 +457,9 @@</span><br><span>     size_t ekm_si=
ze;</span><br><span> </span><br><span>     bool dco_enabled; /**&lt; Whethe=
r keys have to be installed in DCO or not */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /** The app custom control protocols we should announce as suppor=
ted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *acc_protocols;</span><br><span> };</span><br><span> </span><br><span> /*=
* @addtogroup control_processor</span><br><span>@@ -730,6 +733,12 @@</span>=
<br><span>     int dco_peer_id;</span><br><span> </span><br><span>     dco_=
context_t *dco;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols t=
hat are negotiated with the peer=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *acc_negotiated_protocols;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /** the maximum length of an ACC control channel messag=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int acc_max=
_message_length;</span><br><span> };</span><br><span> </span><br><span> /**=
  gets an item  of \c key_state objects in the</span><br><span>diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 43a6743=2E=2E6a73e1e 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -107,10 +107,12 @@</span><br=
><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D=
 test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	tes=
t_acc=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_c=
ommon=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><span> 	mock_=
ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><span> 	$(top_srcdir=
)/src/compat/compat-strlcpy=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span=
><br><span>@@ -132,6 +134,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/=
run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn=
/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_t=
ests/openvpn/mock_management=2Ec</span><br><span>index fff4c2b=2E=2Ef572dbb=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</span><b=
r><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #include &quot=
;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> #include &quo=
t;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_push_depende=
ncies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><=
span>index bf2ccf3=2E=2Ef083f89 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_test=
s/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,8 @@</spa=
n><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_S=
OCKBUF | OPT_P_SOCKFLAGS</span><br><span>                      | OPT_P_SETE=
NV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><spa=
n>                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_EC=
HO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                    | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_RO=
UTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_=
ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     | OPT_P_ACC;</span><br><span>     return flags;</spa=
n><br><span> }</span><br><span> </span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E9364d12</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_acc=2Ec</span><br><span>@@ -0,0 +1,353 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             session authentication and key ex=
change,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  This program is free software; you can redistribute it and/or mod=
ify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the=
 terms of the GNU General Public License version 2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Founda=
tion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribut=
ed in the hope that it will be useful,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied w=
arranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for m=
ore details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have re=
ceived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_c=
ommon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char control_chan=
nel_message_sent[2048];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mock functio=
ns */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string_d=
owork(struct tls_session *session,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                   const char *str, unsigned=
 int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range=
(strlen(str), 0, 2047);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(cont=
rol_channel_message_sent, str);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_token(struct tls_mul=
ti *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+auth=
_set_client_reason(struct tls_multi *multi, const char *reason)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MSG=
_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;               =
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &qu=
ot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;AJw=
BnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    &quot;QAXAB4AGQ=
AYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;ICAgaCBsIHAgJCA=
oICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;AUEAwQDAwAtAAIBAQAzAC=
YAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;93rQwityP9eKSijXgcQ=3D=3D&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_acc_parse_client_messages(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    skip();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* ensure that the messages get to mock_msg */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 3;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D =
(void *)0x12345678;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* contains a TLS 1=2E3 ClientHello */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC,cck1,384,6,&quot; M=
SG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer msg_buf;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context c=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
options=2Emode =3D MODE_SERVER;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALL=
OC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eop=
t =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;=
mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg, sizeof(m=
sg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &=
amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(mock_msg_buf, &quot;WARNING: Received malformed custom ap=
p control channel message (ACC not enabled or no negotiated protocols): 414=
3432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=
=2E=2E]&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_negotiated_protocols =3D &qu=
ot;no:common:protocol&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &=
quot;WARNING: Received malformed custom app control channel message (protoc=
ol &#39;cck1&#39; not in list of negotiated protocols &#39;no:common:protoc=
ol&#39;): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 77=
4e616[more=2E=2E=2E]&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_negotiated_prot=
ocols =3D &quot;cck1:flower:power:fortune&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, =
&quot;Received custom app control message (protocol &#39;cck1&#39;)&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg[] =3D &quo=
t;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(=
&amp;msg_buf, (void *)flower_msg, sizeof(flower_msg));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg=
_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(mock_msg_buf, &quot;Received custom app control message (protoco=
l &#39;flower&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,=
0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_incorrect_l=
en[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSB=
hbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_incorrect_len, size=
of(msg_incorrect_len));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *error =3D &quot;WARNING: Rec=
eived malformed custom app control channel &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        &quot;message (field =
length 62, payload length 64 mismatch): &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        &quot;4143432c 666f7274 =
756e652c 36322c36 2c496e73 67496d31 &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        &quot;6c496a6f 67496d5[more=
=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char msg_fragment[] =3D &quot=
;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_fragment, s=
izeof(msg_fragment));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Re=
ceived custom app control message (protocol &#39;power&#39;, fragment)&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=
=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check two=
 encoding present */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char flower_msg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIE=
tlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower=
_msg_two_encs, sizeof(flower_msg_two_encs));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Received mal=
formed custom app control channel message &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;(number of encodings must be=
 exactly one (B64=3D1, ASCII=3D1)): &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;4143432c 666c6f77 65722c34 382c364=
1 2c535342 68625341 41494574 &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;6c636d3[more=2E=2E=2E]&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* no encoding present */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char flower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAA=
IEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)fl=
ower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Received ma=
lformed custom app control channel message &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;(number of encodings must b=
e exactly one (B64=3D0, ASCII=3D0)): &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;4143432c 666c6f77 65722c34 382c2c=
53 53426862 53414149 45746c63 &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;6d31706[more=2E=2E=2E]&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_m=
sg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    x_debug_level =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    management =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_parse_acc_parameters(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* parameters =
to INFO message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *info_acc_msg =3D &quot;4096 A:6 flower:happy&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int max_len =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(proto=
cols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(max_len, 1280);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* a client does not accept a length longer than it supports=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =
=3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* message with l=
ower limit than our, should work for client and server */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1111 A:6 f=
lower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, =
1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(proto=
cols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* more encodings than supported=2E Server should be okay, c=
lient should fail */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    info_acc_msg =3D &quot;1200 A:6:B flower:happy&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_paramete=
rs(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(in=
fo_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &qu=
ot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(max_len, 1200);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* extra parameter */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    info_acc_msg =3D &quot;1400 A:6 flower:happy 77&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_=
parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_paramete=
rs(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *iv_acc_capabilities =3D &quot;1400,A:6,flowe=
r:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    protocols =3D parse_acc_parameters(iv_acc_capabilities, &quot;,&quot;,=
 &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy:power&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* too small protocol length */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =
=3D &quot;32 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot=
; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* non-numerical protocol length */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:hap=
py&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_acc_common_protocols(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct multi_instance mi =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=2Econtext;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eg=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(=
c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot=
;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_protocols=
 =3D &quot;power:flower:star&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_p=
rotocols =3D c-&gt;options=2Eacc_protocols;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;mul=
ti-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mult=
i-&gt;opt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    determine_common_acc_protocols(multi, &amp;c-&gt;c=
2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(multi-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(multi-&gt;acc_negotiated_protocols, &quot;power:flower&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_get(multi-&gt;opt=
=2Ees, &quot;acc_protocols&quot;), &quot;acc_protocols=3Dpower:flower&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;=
acc_message_len=3D1280&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free=
(multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_send_me=
ssage(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_i=
nstance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct context *c =3D &amp;mi=2Econtext;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struc=
t tls_multi, &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool ret;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_prot=
ocols =3D &quot;power:flower:emergency&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_protocols =3D c-&gt;optio=
ns=2Eacc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Ees =3D env_s=
et_create(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D140=
0,A:6,flower:emergency:power&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Et=
ls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACT=
IVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(c, c=
-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           &quot;EME=
RGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(control_channel_message_s=
ent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NO=
T A DRILL:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc=
_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, false,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=
=2E&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(control_channel_message_sent,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        &quot;ACC,emerge=
ncy,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=
=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* test a long message (&gt; 1000) with fr=
agment to get the maximum header size */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char long_message[1200] =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        long_message[i] =3D (char)(&#39; &#39; +=
 (i % 95));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* last char of the message is a i an=
d then a \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(long_message[1023], &#39;i&#39;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1024], &#39=
;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message=
(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                           long=
_message, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cc_len =
=3D strlen(control_channel_message_sent);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(control_channel_message_sent[cc_=
len - 1], &#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *expected_start_cc =3D &quot;ACC,emergency,1024,AF, !\&q=
uot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_memory_equal(control_channel_message_sent, =
expected_start_cc, strlen(expected_start_cc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_list_intersection(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *empty =3D &quot;&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *protos =3D &quot;power:flower:emergency&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t1 =3D get_list_=
intersection(&amp;gc, empty, protos);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1), 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer t2 =3D get_list_intersection(&amp;g=
c, protos, empty);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(buf_len(&amp;t2), 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer t3 =3D get_list_intersection(&amp;gc, protos, protos);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(buf_cstr(&amp;t3), protos);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *protos2 =3D &quot;flower:emergency:power:mario&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t4 =3D get_li=
st_intersection(&amp;gc, protos2, protos);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t4), &quot;flo=
wer:emergency:power&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *protos3 =3D &quot;super:paper:mario:flower&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer t5 =3D get_list_inters=
ection(&amp;gc, protos2, protos3);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t5), &quot;flower:mari=
o&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *proto4 =3D &q=
uot;flower:flower:flower:flower&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer t6 =3D get_list_intersection(&amp;gc, =
proto4, &quot;flower&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(buf_cstr(&amp;t6), &quot;flower&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E32421fb</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Eh</spa=
n><br><span>@@ -0,0 +1,35 @@</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Open=
VPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software=
; you can redistribute it and/or modify</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licens=
e version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is distributed in the hope that it will be useful,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid test_acc_parse_client_messages(void **state);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void test_parse_acc_parameters(void **state);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void test_acc_common_protocols(void **state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void test_acc_send_message(void **state);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void test_list_intersection(void **state);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/ope=
nvpn/test_common=2Eh</span><br><span>index 8db4ea6=2E=2Ec865142 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>@@ -43,11 +4=
3,13 @@</span><br><span> #define LargestIntegralType uintmax_t</span><br><s=
pan> #endif</span><br><span> /* redefine 2=2Ex API in terms of 1=2Ex API */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CMockaValueDa=
ta             LargestIntegralType</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define check_expected_uint         check_expected</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define expect_uint_value        =
   expect_value</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e expect_check_data           expect_check</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define cast_ptr_to_cmocka_value(x) (x)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define CMockaValueData           =
            LargestIntegralType</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define check_expected_uint                   check_expected</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_uint_va=
lue                     expect_value</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define expect_check_data                     expect_check=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define cast_ptr_to=
_cmocka_value(x)           (x)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define assert_int_in_range(value, min, max)  assert_in_range((v=
alue), (min), (max))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define assert_uint_in_range(value, min, max) assert_in_range((value), (mi=
n), (max))</span><br><span> #endif</span><br><span> </span><br><span> /**</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/u=
nit_tests/openvpn/test_ssl=2Ec</span><br><span>index 4baf8cc=2E=2E4987dd0 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6=
 +52,8 @@</span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><s=
pan> #include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock=
 function to be allowed to include win32=2Ec which is required for</span><b=
r><span>  * getting the temp directory */</span><br><span> #ifdef _WIN32</s=
pan><br><span>@@ -86,6 +88,20 @@</span><br><span> {</span><br><span>     re=
turn;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reschedule=
_multi_process(struct context *c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy dco cipher option to av=
oid linking against all the DCO</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * units */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_get_supported_ciphers(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY13=
05&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> /* generated using</span><br><span>  * openssl req -x509 -new=
key ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>@@ =
-1111,8 +1127,12 @@</span><br><span>         cmocka_unit_test(ssl_test_extr=
act_last_matching_field),</span><br><span>         cmocka_unit_test(ssl_tes=
t_reject_null_in_cert_subject),</span><br><span>         cmocka_unit_test(s=
sl_test_escape_rfc_2253_chars_in_subject),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_extract_peer_info)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract=
_peer_info),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_acc_parse_client_messages),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_parse_acc_para=
meters),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_acc_common_protocols),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_send_message),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_list_intersection)</span><br><span>     };</span><br><span> </span><b=
r><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">=
change 1858</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chugly &lt=
;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--VQIhANvRbGM=--


--===============8580142938545066613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8580142938545066613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8580142938545066613==--

