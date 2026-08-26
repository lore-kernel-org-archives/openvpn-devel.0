Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489EEC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nq/AzJMYDz9K78tVXVgz3Bz2R6Ra43TGYwCvwuQSpA4=; b=RTIya0SbMFqrWkTn6Ng6RcnEjb
	YJH1o4h8k21AWHgFFkQfcnuemL+yIS6r206+aCqJ9KhiEol7dt1Ab2TGvVWg4srIRcco+IZKwcb8P
	C/h9a4IfsbBN2Ib86+hdhVBZv1hyraw7or5SlGASOEjtbzGlULqgEzLIPcZT4drkyOoQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGiA-0004Mr-2l;
	Wed, 26 Aug 2026 16:42:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGi6-0004Mi-Jk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DaasoHdllx11YSx/+OWRwkn5FfvkAbMimOqpfhYxA8g=; b=grkRwigVFgeUjOWj5OqMNOxyKc
 xbsCaxcghv7jJaogMCHKtoqKtO5QVJAGXmk3yfeQS9NN9cw7Og2kFU3ZZYA+rstXgH1c9fdx8FA9/
 K/bsmtf5qzc0xCzaI0HlRfbgHHJzQIq8PRVvW2jZxKCIyUqzXbbsPYNDrMiHWIl0Jaz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DaasoHdllx11YSx/+OWRwkn5FfvkAbMimOqpfhYxA8g=; b=h
 ZV3CQECi9vLA+NWJvxkloifVCrVe2ZHdX+70Gj+MTfqAfIZQP+iGFUydXtCwJkQIxO63DiKMm+VY1
 RKyDBCGViBsYgMOMYDmkIUbHeV/G8EO6qnq8wx2Z5cwSsCnbZjQ9EVse5jXHqCrfTIKBMKZaWPiEs
 jOfj3u2zqURqdT+s=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGhw-0002Ja-DS for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:43 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a41191c9a9so1625386a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787762550; x=1788367350; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DaasoHdllx11YSx/+OWRwkn5FfvkAbMimOqpfhYxA8g=;
 b=YvFmDZn+gEV2U3hGjy9q2wq8oAMrUh+AD9Ari8hWIzj0xNLR9leyBZPBoUBm8V2Q7I
 /vK8pcjUn1aMcOclTVQ2BuR3RR/PNPYkHsCRuH6lhIRN5pE2TdB1b8mGg7AWZTMnjYLU
 IpHrr5R0/LdaGBzHSNhZdarE9sQ+eBJZbo5Sb6RsLBwwehedLXVc8c+PljVahqCHC1Il
 o4yL8wIfHfHufw0jA+JAogtmvPw+yUykSawhmX0Sy6I/wo2X4Cs2EU0yw9Z2Jz38jX6W
 rhnvUboIhfU1Tl23n4kuokXhg3v4hz+qi1VeYdGFyTH2btpWw+Q/QG9LOI0jLg75+8zM
 gfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762550; x=1788367350;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DaasoHdllx11YSx/+OWRwkn5FfvkAbMimOqpfhYxA8g=;
 b=HpDVAPPBPJ1afaLWn9eQBcaCta50JgL0tbhllOM3ZtJgU6fo/fZhswBIJeE01FuUco
 vuUar4CugSvv8m3jlWQejRV0LQT31duwODiwhKhTp+PBdPUxx3+ksPSSa4CMKNmVjzWa
 UEfxxbrWNChl2zMM7blbJHUZVDdzgA7JpltXiPkeDTEqhME9ZdNbeFv+9tDokJsM8Zep
 5Gv86c6mX37NZ3oSFEBDy6FsC38cz5YIhMzOOHQtH4kW9MGe/6aJf4p+NKrDsFKGUqVU
 UDWNsA4CmskOiM8Mj+lIwI2WRbBdmJ+vBW9WOIGmVzDAzYLRTtbPbH8TMIq2ZR1Twe0F
 ACaQ==
X-Gm-Message-State: AFuF++nGQL3C1DXnuKZT+Z1G/SCvBihXvmoq2Bp44GV9W+Olbfrbozhw
 aGBZATS60jzPr1i008lAuTF3Bp50OYZBfeuqYiO4DRJyCiYiO+7vvvqPEvKs/cUYbFeB5E3HG0/
 mS3MX0zFRjI4rENtEEZepTwFQG4lz9/tBPnAKiKr1SU+yNVZrL7Qqy50g93PA4+yfimp5A6OeBR
 FohagLOg==
X-Gm-Gg: AR+sD11TBPuP4YrsX+g7UyVy1HnWP9sg7aEMYWBLe7DPWHMw7ukC8PSDZZwqHbaKfCW
 IPrPJlEIl3atAebH/zqZDpuoS5KR8KXWcafcObQs+24XfjUMI5qBM3rzHnUP/B8oXGUG83JexJh
 EB6TIvGUYnPJ/qUa0OJSMDsbDRslRn/kr9j4il+1mMG4Vo+RLBKLgpZD/UTKl21vcFAOumk9ekq
 j2Uaz3HX0qhjZnroQ+uZdRV/vGh0nG2A7bp8BPOUEb93euo/KThTR6ZH3S0Z7j08HrdFveAND02
 E/nv17ErgMEJ/NDic4CfqKfEnDZGcX+ruVUCtKiez/oaH8DK+fE6hl6x6aRF2yWCQWIFJNPWeeN
 KI3FElJpnFL9GbW+RVNCvBXNHBuqFZWZ5A6tGy4iaK067I3GFEFZmjYJvhksFZPM1FHHrtAh5O9
 HJZxVSZnUQtm3jayKQ2P3GJMTBDppf2M9LMlpWg61ILDqkRorrCdtekGQOYaXCNZOngiBgMK5An
 RhgeIKIBL/yMJ+jrCmYn+hv2ar16OUmlrT7tu1UDXasIz7JTHtoNE6SjtvYYl42A0sCCp/oMpr9
 +F+fU+8MzmDwUpKhX6bJXZqDldg1ORm8nadlNymtTKKbkqG4tnRS
X-Received: by 2002:a17:906:c149:b0:c12:b2db:873d with SMTP id
 a640c23a62f3a-c250bac808emr914510266b.5.1787762548229; 
 Wed, 26 Aug 2026 09:42:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fda44sm642275266b.14.2026.08.26.09.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:42:27 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:42:17 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: e2cb43cea1ce42185473b44c7335d4c49fee41c6
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b91aadbbbf9470027e70ceb19975159761494225-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGhw-0002Ja-DS
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2740916287631708672=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2740916287631708672==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g+AIlqSRH2M="; charset=UTF-8

--g+AIlqSRH2M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1858?usp=3Demail

to look at the new patch set (#8=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Implement sending/receiving app custom co=
ntrol protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Implement sending/receiving app custom control protocol

This allows open=
vpn GUI/front-ends and server via management
to use the OpenVPN control cha=
nnel to pass messages between each other
while OpenVPN handles the marshall=
ing/unmarshalling of these and
negotiate the common app custom control prot=
ocols=2E

This provides an easy to use secure channel that does not depends=
 on
the network itself to work and can also used before fully authenticatin=
g
the client=2E See the management-notes=2Etxt for more details how to use
=
this feature=2E An upcoming patch will also add some example python
script =
that showcase this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86=
b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=
=2Etxt
M doc/man-sections/client-options=2Erst
M doc/management-notes=2Etxt=

M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M =
src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M s=
rc/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M s=
rc/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/=
openvpn/push_util=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M =
tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_mana=
gement=2Ec
A tests/unit_tests/openvpn/mock_management=2Eh
M tests/unit_test=
s/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/openvpn/test_acc=2E=
c
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_tests/openvpn/test_c=
ommon=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/openv=
pn/test_ssl=2Ec
27 files changed, 1,345 insertions(+), 27 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/8
=

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ea9331c=
2 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -424,6 +424,8 @@
=
     src/compat/compat-gettimeofday=2Ec
     src/compat/compat-strsep=2Ec
 =
    src/compat/compat-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvp=
n/acc=2Eh
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/open=
vpn/base64=2Ec
@@ -560,9 +562,9 @@
     src/openvpn/ps=2Ec
     src/openvpn=
/ps=2Eh
     src/openvpn/push=2Ec
-    src/openvpn/push_util=2Ec
     src/o=
penvpn/push=2Eh
-    src/openvpn/pushlist=2Eh
+    src/openvpn/push_util=2E=
c
+        src/openvpn/pushlist=2Eh
     src/openvpn/reflect_filter=2Ec
   =
  src/openvpn/reflect_filter=2Eh
     src/openvpn/reliable=2Ec
@@ -812,7 +8=
14,10 @@
             tests/unit_tests/openvpn/mock_management=2Ec
        =
     tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
             tests/=
unit_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_tests/open=
vpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src/openvpn/=
argv=2Ec
+            src/openvpn/auth_token=2Ec
             src/openvpn/b=
ase64=2Ec
             src/openvpn/crypto_epoch=2Ec
             src/openvp=
n/crypto_mbedtls=2Ec
@@ -826,8 +831,11 @@
             src/openvpn/options_=
util=2Ec
             src/openvpn/otime=2Ec
             src/openvpn/packet=
_id=2Ec
+            src/openvpn/reliable=2Ec
+            src/openvpn/sess=
ion_id=2Ec
             src/openvpn/run_command=2Ec
             src/openvp=
n/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
             src/ope=
nvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
             src=
/openvpn/ssl_verify_mbedtls=2Ec
@@ -844,6 +852,8 @@
     target_sources(tes=
t_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random=2Ec
      =
   tests/unit_tests/openvpn/test_schedule=2Ec
+        tests/unit_tests/ope=
nvpn/mock_management=2Ec
+        src/openvpn/base64=2Ec
         src/openv=
pn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/openvpn/ssl=
_util=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sect=
ions/client-options=2Erst
index 87c138a=2E=2E89ba7cf 100644
--- a/doc/man-s=
ections/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@=
 -12,6 +12,17 @@
   When this option is set, OpenVPN will not drop incoming=
 tun packets with
   same destination as host=2E
 
+--app-custom-control pr=
otocollist
+  Sets the list of supported app custom control protocols=2E
+ =
 These protocols are announced to the server when this option is used
+  as=
 a client=2E If the option is set on a server it will negotiate the
+  comm=
on protocols with the client=2E
+
+  The protocollist is a : separated list=
 of protocol identifiers=2E
+
+  See management-notes=2Etxt in the OpenVPN =
distribution  and the OpenVPN RFC
+  draft for a description of app custom =
control protocol support=2E
+
 --auth-token token
   This is not an option =
to be used directly in any configuration files,
   but rather push this opt=
ion from a ``--client-connect`` script or a
diff --git a/doc/management-not=
es=2Etxt b/doc/management-notes=2Etxt
index d6b3fbb=2E=2Ee5ab2f5 100644
---=
 a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -798,6 +7=
98,58 @@
 The client should return the response to the crtext challenge
 us=
ing the cr-response command=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed as=
 {EXTRA} OpenVPN will determine
+the common app custom protocols between th=
e client and the sever and instruct
+the client that the server will send c=
ontrol messages to the client using
+the ACC protocol=2E
+
+The server shou=
ld then use acc-msg command to send app custom control messages
+to the cli=
ent to faciliate the pending authentication=2E
+
+COMMAND -- client-acc-msg=
 (OpenVPN 2=2E8 or higher)
+------------------------------------------
+
+O=
n an OpenVPN instance running in server mode this command sends an
+app cus=
tom control message to a client=2E The format of the command is:
+
+  clien=
t-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
+CID,K=
ID -- client ID and Key ID=2E See documentation for ">CLIENT:"
+notificatio=
n for more info=2E
+
+protocol -- the ACC protocol identified that this mes=
sage should be
+            tagged with=2E
+
+flags    -- a colon separated=
 list of the encoding and the flag if
+            the message is a fragmen=
t=2E E=2Eg=2E "6:F" for a base64 encoded
+            message that is also =
a fragment and not complete yet=2E
+
+message  -- The message encoded in th=
e encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or hig=
her)
+------------------------------------------
+
+When OpenVPN is running=
 in --client mode this command sends an app
+custom command to the server=
=2E The format of the command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {=
message}
+  END
+
+See the client-acc-msg command for more details about th=
e format of the
+message=2E Since a client has only one peer there is no ne=
ed to specify the
+client id and key id=2E
+
+
 COMMAND -- client-deny  (Op=
enVPN 2=2E1 or higher)
 -----------------------------------------------
 
@=
@ -1247,6 +1299,23 @@
    response=2E Mechanisms that need multiple rounds =
or more complex answers
    should implement a different response type than=
 CR_RESPONSE=2E
 
+(6) App custom control message
+
+    This message is an=
 application specific payload message that is transported
+    over the Ope=
nVPN control channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KI=
D},{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:{p=
rotocol},{fragment},{msg_base64}
+
+    The protocol is a short ascii strin=
g identifying the app specific custom
+    protocol and identifies the prot=
ocol=2E If fragment is set to 1, the message
+    is not complete and the n=
ext message should be concatenated to this message
+    to form a complete =
message=2E
 
 Variables:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/ope=
nvpn/Makefile=2Eam
index 7fd12b4=2E=2Ede7a5e7 100644
--- a/src/openvpn/Make=
file=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -42,6 +42,7 @@
 sbin_PROGRAMS =
=3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2E=
h \
 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -121,7 +=
122,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
=
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \=

 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec =
reliable=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new f=
ile mode 100644
index 0000000=2E=2Eb101283
--- /dev/null
+++ b/src/openvpn/=
acc=2Ec
@@ -0,0 +1,396 @@
+/*
+ *  OpenVPN -- An application to securely tu=
nnel IP networks
+ *             over a single TCP/UDP port, with support f=
or SSL/TLS-based
+ *             session authentication and key exchange,
+=
 *             packet encryption, packet authentication, and
+ *           =
  packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@open=
vpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ =
*
+ *  This program is free software; you can redistribute it and/or modify=

+ *  it under the terms of the GNU General Public License version 2
+ *  a=
s published by the Free Software Foundation=2E
+ *
+ *  This program is dis=
tributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more de=
tails=2E
+ *
+ *  You should have received a copy of the GNU General Public=
 License along
+ *  with this program; if not, write to the Free Software F=
oundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#=
include "syshead=2Eh"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#inc=
lude "error=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"
+#include "opt=
ions_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+
+enum acc=
_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS=
_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
=
+log_acc_message(struct context *c, const struct buffer *buf, int payload_l=
en,
+                const char *protocol, int flags)
+{
+    bool fragment=
 =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    str=
uct gc_arena gc =3D gc_new();
+    const char *payload_msg =3D NULL;
+
+   =
 /* For simplicity, we always encode payload to be base64 encoded
+     * i=
f not already in base64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)=

+    {
+        char *b64out =3D NULL;
+        ASSERT(openvpn_base64_enco=
de(BPTR(buf), payload_len, &b64out) >=3D 0);
+        gc_addspecial(b64out,=
 free, &gc);
+        payload_msg =3D b64out;
+    }
+    else
+    {
+    =
    payload_msg =3D BSTR(buf);
+    }
+
+    if (management)
+    {
+      =
  struct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+=

+        struct man_def_auth_context *mda =3D session->opt->mda_context;
+=
        if (c->options=2Emode =3D=3D MODE_SERVER)
+        {
+            /=
* server mode=2E Report client context */
+            unsigned int mda_key=
_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_=
CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_i=
d, protocol, fragment, payload_msg);
+        }
+        else
+        {
+ =
           /* Client mode=2E Do not a report a CLIENT id */
+            ms=
g(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payload_msg);
+        }
+=
    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_P=
USH, "Received custom app control message (protocol '%s'%s)",
+        prot=
ocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses the flags fiel=
d of an app control message and moves the
+ *  buffer past the flags string=
=2E If there is an
+ *  error parsing the flags field the method returns -1=
 and
+ *  puts the error reason in err_reason
+ */
+static int
+parse_acc_m=
essage_flags(struct buffer *buf, const char **err_reason, struct gc_arena *=
gc)
+{
+    const char *flags =3D buf_extract_field(buf, ',', gc);
+
+    i=
f (!flags)
+    {
+        *err_reason =3D "could not extract flags field";=

+        return -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    for (const=
 char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+        if (*flag =
=3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;=

+        }
+        else if (*flag =3D=3D '6')
+        {
+            acc=
_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (*flag =
=3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGME=
NT;
+        }
+        else
+        {
+            *err_reason =3D "Unkno=
wn flag in flags";
+            return -1;
+        }
+    }
+    /* The me=
ssage should be encoded with exactly one encoding=2E Ensure that
+     * on=
ly one of the flags is present */
+    bool asciienc =3D (bool)(acc_flags &=
 ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_flags & ACC_M=
ESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+    {
+     =
   char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "number=
 of encodings must be exactly one "
+                           "(B64=3D%d,=
 ASCII=3D%d)",
+                 base64enc, asciienc);
+        *err_reason=
 =3D tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
+
+
+void
=
+receive_acc_message(struct context *c, const struct buffer *buffer)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    const char *err_reason =3D "";
+
+ =
   /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    struct buff=
er buf =3D *buffer;
+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_rea=
d_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "missing , after ACC";
=
+        goto err;
+    }
+
+    /* extract protocol, payload length, flags=
 substrings */
+    char *protocol =3D buf_extract_field(&buf, ',', &gc);
+=
    if (!protocol)
+    {
+        err_reason =3D "could not extract protoc=
ol field";
+        goto err;
+    }
+
+    int payload_len;
+    char *pay=
load_len_str =3D buf_extract_field(&buf, ',', &gc);
+    if (!payload_len_s=
tr || !((payload_len =3D atoi(payload_len_str))))
+    {
+        err_reaso=
n =3D "could not extract payload length field";
+        goto err;
+    }
+=

+    int flags =3D parse_acc_message_flags(&buf, &err_reason, &gc);
+
+   =
 if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We should have a=
 final NUL byte in the control message buffer
+     * and thus the length o=
f the buffer should be payload_len + 1 */
+    if (buf_len(&buf) !=3D paylo=
ad_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
+        =
snprintf(tmp, 512, "field length %d, payload length %d mismatch",
+        =
         payload_len, buf_len(&buf) - 1);
+        err_reason =3D tmp;
+   =
     goto err;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, protoc=
ol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERRORS,=
 "WARNING: Received malformed custom app control channel "
+               =
        "(%s) message control message: %s",
+        err_reason,
+        f=
ormat_hex(BPTR(&buf), BLEN(&buf), 80, &gc));
+    gc_free(&gc);
+}
+
+
+boo=
l
+send_acc_message(struct context *c,
+                 struct tls_multi *=
tls_multi,
+                 struct tls_session *session,
+                =
 const char *protocol, bool fragment,
+                 const char *msg, bo=
ol base64)
+{
+    /*
+     * length of the protocol string + one ','
+    =
 * 2 for the encoding (A or 6), potential F (fragment), and 1 for the ',',
=
+     * 4 for the message size itself and one comma
+     * 1 for the comma=
 before the message itself */
+    const size_t max_header_size =3D strlen(=
"ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_hea=
der_size + strlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    {
+    =
    msg(M_CLIENT, "message length (%zu) exceeds maximum possible message le=
ngth (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+    }
+
+  =
  if ((int)len > c->options=2Eacc_max_message_length)
+    {
+        msg(M=
_CLIENT, "header (%zu) + message size (%zu) length (%zu) exceeds "
+       =
               "maximum allowed length negotiated with peer (%d)",
+       =
     max_header_size, strlen(msg), len,
+            c->options=2Eacc_max_m=
essage_length);
+        return false;
+    }
+
+    struct gc_arena gc =3D=
 gc_new();
+    /* add 1 for the final \0 */
+    struct buffer buf =3D all=
oc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppets,15,A,I am M=
iss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+       =
        strlen(msg),
+               base64 ? "6" : "A",
+               fr=
agment ? "F" : "",
+               msg);
+
+    send_control_channel_string=
_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
+  =
  gc_free(&gc);
+    return true;
+}
+
+char *
+parse_acc_parameters(const =
char *capabilities,
+                     const char *delim,
+             =
        int *max_acc_len,
+                     bool server,
+             =
        struct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc(cap=
abilities, NULL);
+    char *tmp_message_orig =3D tmp_message;
+    char *l=
asts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_message, delim, &l=
asts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const char *protocol=
s =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode we allow more=
 capabilities than our own, in client
+     * mode we reject if we should u=
se capabilities that we do not support */
+    int allowed_acc_len =3D serv=
er ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if (p =
=3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message length", ACC_MIN=
_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto don=
e;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A", t=
oken) || !tls_item_in_cipher_list("6", token)))
+        {
+            msg=
(D_PUSH_ERRORS, "App custom control encoding must include base64 and ascii"=
);
+            goto done;
+        }
+
+        if (p =3D=3D 1 && !server =
&& strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+            ms=
g(D_PUSH_ERRORS, "App custom control encoding must exactly base64 and ascii=
");
+            goto done;
+        }
+
+        if (p =3D=3D 2)
+        =
{
+            protocols =3D token;
+        }
+
+        if (p =3D=3D 3)
+=
        {
+            msg(D_PUSH_ERRORS, "Too many parameters for INFO ACC=
 message/IV_ACC=2E");
+            goto done;
+        }
+
+        token =
=3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc_len=
 =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(protocols,=
 gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
+
+
+void
+=
determine_common_acc_protocols(struct context *c)
+{
+    if (!c->options=
=2Eacc_protocols)
+    {
+        /* No app custom protocols have been conf=
igured server-side=2E */
+        return;
+    }
+    if (c->options=2Eacc_=
negotiated_protocols)
+    {
+        /* We already have determined the com=
mon protocols=2E Doing this
+         * again would just add an extra strin=
g allocation to options->gc */
+        return;
+    }
+
+    struct gc_are=
na gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:powe=
r */
+    const char *peer_info =3D c->c2=2Etls_multi->peer_info;
+    char=
 *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!=
iv_acc)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+    int ma=
x_acc_len =3D 0;
+    char *protocols =3D parse_acc_parameters(iv_acc, ",",=
 &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&=
gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of pee=
r is malformed");
+        return;
+    }
+
+    char *lasts =3D NULL;
+   =
 const char *token =3D strtok_r(protocols, ":", &lasts);
+
+    struct buff=
er common_protocols =3D alloc_buf_gc(1024, &gc);
+
+    while (token)
+    =
{
+        if (tls_item_in_cipher_list(token, c->options=2Eacc_protocols))
=
+        {
+            /* protocol is in both server and client list */
+ =
           if (buf_len(&common_protocols) > 0)
+            {
+            =
    buf_write_u8(&common_protocols, ':');
+            }
+            buf_p=
rintf(&common_protocols, "%s", token);
+        }
+        token =3D strtok=
_r(NULL, ":", &lasts);
+    }
+
+    if (buf_len(&common_protocols) =3D=3D =
0)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_DEBUG, "WARNING: No co=
mmon app custom control protocol=2E");
+        return;
+    }
+
+    c->op=
tions=2Eacc_negotiated_protocols =3D string_alloc(buf_str(&common_protocols=
), &c->options=2Egc);
+    c->options=2Eacc_max_message_length =3D max_acc_=
len;
+    gc_free(&gc);
+}
\ No newline at end of file
diff --git a/src/ope=
nvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 0000000=2E=2E=
5d9b203
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,92 @@
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
yright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 A=
rne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software=
; you can redistribute it and/or modify
+ *  it under the terms of the GNU =
General Public License version 2
+ *  as published by the Free Software Fou=
ndation=2E
+ *
+ *  This program is distributed in the hope that it will be=
 useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ * =
 GNU General Public License for more details=2E
+ *
+ *  You should have re=
ceived a copy of the GNU General Public License along
+ *  with this progra=
m; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin =
Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#d=
efine ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#defin=
e ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom control =
message and delivers it to the
+ * management interface=2E We leave reassem=
bly of fragmented messages to the
+ * management interface=2E
+ *
+ * @para=
m c            The context struct
+ * @param buffer       Buffer containing=
 the control message with ACC
+ */
+void
+receive_acc_message(struct contex=
t *c, const struct buffer *buffer);
+
+
+bool
+send_acc_message(struct cont=
ext *c,
+                 struct tls_multi *tls_multi,
+                 st=
ruct tls_session *session,
+                 const char *protocol, bool fra=
gment,
+                 const char *msg, bool base64);
+
+
+/**
+ * Parses=
 an info message from the server that contains app custom control info
+ * =
information prior to the PUSH_REPLY to be able to use app custom control
+ =
* protocols before sending
+ *
+ * In client mode only allow what we suppor=
t ourselves=2E In server mode
+ * allow also capabilities that we not suppo=
rt ourselves=2E
+ *
+ * @param capabilities      The string to parse
+ * @p=
aram delim             The delimiter to use when parsing the string=2E
+ * =
                         IV_ACC uses "," as delimiter while the
+ *        =
                  custom-control PUSH message uses " " as "," is
+ *       =
                   already used to separate different push directives
+ * @=
param max_acc_len       Set to the maximum ACC message length
+ * @param se=
rver            Whether we are server or client
+ * @param gc              =
  The gc arena to use for allocating the resulting string
+ * @return      =
            The resulting protocol string or NULL on error
+ */
+char *
+pa=
rse_acc_parameters(const char *capabilities,
+                     const ch=
ar *delim,
+                     int *max_acc_len,
+                     bo=
ol server,
+                     struct gc_arena *gc);
+
+/**
+ * Parses th=
e IV_ACC of the peer and sets c->options=2Eacc_negotiated_protocols
+ * to =
the common protocols of server and client and
+ * c->options=2Eacc_max_mess=
age_length  to the maximum length of the ACC message
+ * support by both se=
rver and client=2E
+ *
+ * If there is no common protocol or the client doe=
s not support any app custom
+ * protocol c->options=2Eacc_negotiated_proto=
cols will be set to NULL=2E
+ *
+ * @param c     the client context to use =
the set the app custom protocols=2E
+ */
+void
+determine_common_acc_protoc=
ols(struct context *c);
+#endif
diff --git a/src/openvpn/forward=2Ec b/src/=
openvpn/forward=2Ec
index 2ade321=2E=2E736e975 100644
--- a/src/openvpn/for=
ward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh=
"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#include "acc=2Eh"=

 
 #include "memdbg=2Eh"
 
@@ -251,11 +252,11 @@
     }
     else if (buf_=
string_match_head_str(buf, "INFO_PRE"))
     {
-        server_pushed_info(=
buf, 8);
+        server_pushed_info(c, buf, 8);
     }
     else if (buf_s=
tring_match_head_str(buf, "INFO"))
     {
-        server_pushed_info(buf, =
4);
+        server_pushed_info(c, buf, 4);
     }
     else if (buf_string=
_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -265,6 +266,10 @@
     {
   =
      receive_auth_pending(c, buf);
     }
+    else if (buf_string_match_h=
ead_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf);
+    }
  =
   else if (buf_string_match_head_str(buf, "EXIT"))
     {
         receive=
_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
=
index 04220f4=2E=2Eaacbfe5a 100644
--- a/src/openvpn/init=2Ec
+++ b/src/ope=
nvpn/init=2Ec
@@ -2283,6 +2283,10 @@
             buf_printf(&out, " aead-e=
poch");
         }
     }
+    if (c->options=2Eacc_negotiated_protocols)
+=
    {
+        buf_printf(&out, " custom-control %d,A:6,%s", c->options=2Ea=
cc_max_message_length, c->options=2Eacc_negotiated_protocols);
+    }
 
   =
  if (BLENZ(&out) > strlen(header))
     {
@@ -2527,6 +2531,11 @@
         =
flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eac=
c_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
     return fla=
gs;
 }
 
@@ -3342,6 +3351,7 @@
     to=2Everify_hash_depth =3D options->ver=
ify_hash_depth;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;=

     memcpy(to=2Ex509_username_field, options->x509_username_field, sizeof=
(to=2Ex509_username_field));
+    to=2Eacc_protocols =3D options->acc_proto=
cols;
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ =
-4300,6 +4310,27 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+m=
anagement_acc_msg(void *arg,
+                   struct buffer_list *input)=
 /* ownership transferred */
+{
+    struct gc_arena gc =3D gc_new();
+    =
struct context *c =3D arg;
+
+    bool ret =3D true;
+    if (buffer_list_d=
efined(input) && c->c2=2Etls_multi)
+    {
+        struct tls_multi *multi=
 =3D c->c2=2Etls_multi;
+        struct tls_session *session =3D &multi->se=
ssion[TM_ACTIVE];
+        struct options *opt =3D &c->options;
+
+        =
ret =3D management_send_acc_message(c, multi, session, opt->acc_negotiated_=
protocols, input);
+    }
+
+    buffer_list_free(input);
+    gc_free(&gc)=
;
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -431=
6,6 +4347,7 @@
         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;
 =
        cb=2Eremote_cmd =3D management_callback_remote_cmd;
         cb=2Es=
end_cc_message =3D management_callback_send_cc_message;
+        cb=2Eacc_m=
sg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_cha=
nge =3D management_callback_network_change;
 #endif
diff --git a/src/openvp=
n/manage=2Ec b/src/openvpn/manage=2Ec
index 29fdffc=2E=2Eabf6f8b 100644
---=
 a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,8 +44,10 @@
 =
#include "dco=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#include "ac=
c=2Eh"
 
 #include "memdbg=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PK=
CS11
 #include "pkcs11=2Eh"
@@ -1080,6 +1082,35 @@
             }
         =
    break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (man->persis=
t=2Ecallback=2Eclient_acc_msg)
+            {
+                bool status =
=3D (*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecallback=2Ea=
rg,
+                                                                      =
man->connection=2Ein_extra_cid,
+                                          =
                            man->connection=2Ein_extra_kid,
+              =
                                                        man->connection=2Ei=
n_extra);
+                man->connection=2Ein_extra =3D NULL;
+          =
      report_command_status(status, "client-acc-msg");
+            }
+    =
        else
+            {
+                man_command_unsupported("clien=
t-acc-msg");
+            }
+            break;
+
+        case IEC_ACC_MSG=
:
+            if (man->persist=2Ecallback=2Eacc_msg)
+            {
+     =
           bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(man->persis=
t=2Ecallback=2Earg,
+                                                      =
         man->connection=2Ein_extra);
+                man->connection=2Ein=
_extra =3D NULL;
+                report_command_status(status, "acc-msg");=

+            }
+            else
+            {
+                man_comma=
nd_unsupported("acc-msg");
+            }
+            break;
         case=
 IEC_PK_SIGN:
             man->connection=2Eext_key_state =3D EKS_READY;
 =
            buffer_list_free(man->connection=2Eext_key_input);
@@ -1204,6 +=
1235,29 @@
 }
 
 static void
+man_client_acc_msg(struct management *man, co=
nst char *cid_str,
+                   const char *kid_str)
+{
+    struct =
man_connection *mc =3D &man->connection;
+    mc->in_extra_cid =3D 0;
+    =
mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+   =
     && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+        mc->=
in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
=
+    }
+}
+
+static void
+man_acc_msg(struct management *man)
+{
+    struc=
t man_connection *mc =3D &man->connection;
+    mc->in_extra_cmd =3D IEC_AC=
C_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_client_auth=
(struct management *man, const char *cid_str, const char *kid_str, const bo=
ol extra)
 {
     struct man_connection *mc =3D &man->connection;
@@ -1760,=
6 +1814,17 @@
             man_client_pending_auth(man, p[1], p[2], p[3], p=
[4]);
         }
     }
+    else if (streq(p[0], "client-acc-msg"))
+    {=

+        if (man_need(man, p, 2, 0))
+        {
+            man_client_ac=
c_msg(man, p[1], p[2]);
+        }
+    }
+    else if (streq(p[0], "acc-ms=
g"))
+    {
+        man_acc_msg(man);
+    }
     else if (streq(p[0], "rs=
a-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -3131,6 +3196,7 @@
=
     }
 }
 
+
 void
 management_connection_established(struct management *m=
anagement, struct man_def_auth_context *mdac,
                             =
      const struct env_set *es)
@@ -4362,6 +4428,62 @@
     }
 }
 
+bool
+m=
anagement_send_acc_message(struct context *c, struct tls_multi *multi, stru=
ct tls_session *session,
+                            const char *negotiate=
d_protocols, struct buffer_list *input)
+{
+    /* also ensures that are en=
ough inputs in the list to safely call
+     * buffer_list_peek without ext=
ra NULL checks */
+    if (!input || input->size < 3)
+    {
+        msg(M=
_CLIENT, "not enough input lines for sending acc message, "
+              =
        "missing protocol, flag and/or messages lines");
+        return fa=
lse;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    const struct buf=
fer *proto_buf =3D buffer_list_peek(input);
+    const char *protocol =3D s=
tring_alloc(BSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+    cons=
t struct buffer *encoding_buf =3D buffer_list_peek(input);
+    char *encod=
ing =3D buf_str(encoding_buf);
+    char *flag =3D NULL;
+    bool b64encod=
ing =3D false;
+    bool fragment =3D false;
+
+    while ((flag =3D strsep=
(&encoding, ":")))
+    {
+        if (!strcmp(flag, "6"))
+        {
+    =
        b64encoding =3D true;
+        }
+        else if (!strcmp(flag, "F=
"))
+        {
+            fragment =3D true;
+        }
+    }
+    buffe=
r_list_pop(input);
+
+    buffer_list_aggregate_separator(input, 10000, "")=
;
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);
+
+   =
 if (!negotiated_protocols || !tls_item_in_cipher_list(protocol, negotiated=
_protocols))
+    {
+        msg(M_CLIENT, "protocol not in the list of neg=
otiated protocols: %s", np(negotiated_protocols));
+        goto error;
+  =
  }
+
+    bool ret =3D send_acc_message(c, multi, session, protocol,
+    =
                            fragment, buf_str(acc_msg_buf),
+              =
                  b64encoding);
+    gc_free(&gc);
+    return ret;
+error:=

+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef ENABLE_MANAGEMENT=
 */
 
 #include "win32=2Eh"
diff --git a/src/openvpn/manage=2Eh b/src/openv=
pn/manage=2Eh
index f752fec=2E=2Ede9303b 100644
--- a/src/openvpn/manage=2E=
h
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (*n_clients)(=
void *arg);
     bool (*send_cc_message)(void *arg, const char *message, co=
nst char *parameter);
     bool (*kill_by_cid)(void *arg, const unsigned lo=
ng cid, const char *kill_msg);
+
     bool (*client_auth)(void *arg, const =
unsigned long cid, const unsigned int mda_key_id,
                         =
const bool auth, const char *reason, const char *client_reason,
           =
              struct buffer_list *cc_config); /* ownership transferred */
 =
    bool (*client_pending_auth)(void *arg, const unsigned long cid, const u=
nsigned int kid,
                                 const char *extra, unsign=
ed int timeout);
     char *(*get_peer_info)(void *arg, const unsigned long=
 cid);
+    bool (*client_acc_msg)(void *arg,
+                           c=
onst unsigned long cid,
+                           const unsigned int mda_=
key_id,
+                           struct buffer_list *msg);
+    bool (*a=
cc_msg)(void *arg,
+                    struct buffer_list *msg);
     bool=
 (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cmd)(void *arg=
, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
     struct=
 command_line *in;
     struct buffer_list *out;
 
-#define IEC_UNDEF      =
 0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#define IEC_CL=
IENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#define =
IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#d=
efine IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#define IEC_CERTIFIC=
ATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWORD       6
+#defi=
ne IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int in_extra_cmd=
;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid;
@@ -5=
03,6 +512,14 @@
 
 void man_persist_client_stats(struct management *man, st=
ruct context *c);
 
+/** Parses the ACC message from the input buffer_list =
and send to the
+ * session identified by session and multi
+ */
+struct tl=
s_session;
+struct tls_multi;
+bool
+management_send_acc_message(struct con=
text *c, struct tls_multi *multi, struct tls_session *session,
+           =
                 const char *negotiated_protocols, struct buffer_list *inpu=
t);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index 46ff1ba=2E=2E1eb6c5b 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -52,6 +52,7 @@
 #include=
 "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#includ=
e "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1773,6 +1774,13 @@
=
         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }
 
+ =
   if (o->acc_protocols)
+    {
+        /* If ACC is enabled server side c=
all to find common acc protocols,
+         * will be pushed during push me=
ssage */
+        determine_common_acc_protocols(c);
+    }
+
     /* Selec=
t cipher if client supports Negotiable Crypto Parameters */
 
     /* if we=
 have already created our key, we cannot *change* our own
@@ -4032,6 +4040,=
24 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(struct =
context *c, struct gc_arena *gc)
+{
+    determine_common_acc_protocols(c);=

+
+    if (!c->options=2Eacc_negotiated_protocols)
+    {
+        msg(M_C=
LIENT, "ACC: No negotiated protocols");
+        return NULL;
+    }
+
+   =
 struct buffer buf =3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC=
:%d A:6 %s", c->options=2Eacc_max_message_length, c->options=2Eacc_negotiat=
ed_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 management_c=
lient_pending_auth(void *arg, const unsigned long cid, const unsigned int m=
da_key_id,
                                const char *extra, unsigned int =
timeout)
@@ -4042,10 +4068,22 @@
     if (mi)
     {
         struct tls_mu=
lti *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =
=3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+            e=
xtra =3D calculate_app_control_extra(&mi->context, &gc);
+            if (!=
extra)
+            {
+                gc_free(&gc);
+                retur=
n false;
+            }
+        }
         struct tls_session *session =3D=
 lookup_session_by_mda_key_id(multi, mda_key_id);
 
         if (!session)
=
         {
+            gc_free(&gc);
             return false;
         }=

 
@@ -4053,6 +4091,7 @@
         bool ret =3D send_auth_pending_messages(m=
ulti, session, extra, timeout);
         reschedule_multi_process(&mi->cont=
ext);
         multi_schedule_context_wakeup(m, mi);
+        gc_free(&gc);=

         return ret;
     }
     return false;
@@ -4096,6 +4135,39 @@
    =
 return ret;
 }
 
+
+static bool
+management_client_acc_msg(void *arg,
+   =
                       const unsigned long cid,
+                          =
const unsigned int mda_key_id,
+                          struct buffer_lis=
t *input) /* ownership transferred */
+{
+    struct multi_context *m =3D (=
struct multi_context *)arg;
+    struct multi_instance *mi =3D lookup_by_ci=
d(m, cid);
+
+    bool ret =3D false;
+    if (mi && buffer_list_defined(in=
put))
+    {
+        struct tls_multi *multi =3D mi->context=2Ec2=2Etls_mu=
lti;
+        struct tls_session *session =3D lookup_session_by_mda_key_id(=
multi, mda_key_id);
+        if (!session)
+        {
+            msg(M_CL=
IENT, "client session not found");
+            buffer_list_free(input);
+ =
           return false;
+        }
+
+        struct options *opt =3D &mi-=
>context=2Eoptions;
+
+        ret =3D management_send_acc_message(&mi->con=
text, multi, session, opt->acc_negotiated_protocols, input);
+        multi=
_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(input);
+  =
  return ret;
+}
+
+
 static char *
 management_get_peer_info(void *arg, co=
nst unsigned long cid)
 {
@@ -4132,6 +4204,7 @@
         cb=2En_clients =3D=
 management_callback_n_clients;
         cb=2Ekill_by_cid =3D management_ki=
ll_by_cid;
         cb=2Eclient_auth =3D management_client_auth;
+        c=
b=2Eclient_acc_msg =3D management_client_acc_msg;
         cb=2Eclient_pend=
ing_auth =3D management_client_pending_auth;
         cb=2Eget_peer_info =
=3D management_get_peer_info;
         cb=2Epush_update_broadcast =3D manag=
ement_callback_send_push_update_broadcast;
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 1939c69=2E=2E729aabc 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #inc=
lude "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include "=
error=2Eh"
 #include "common=2Eh"
@@ -7106,6 +7107,28 @@
         VERIFY_PE=
RMISSION(OPT_P_GENERAL);
         options->force_key_material_export =3D tr=
ue;
     }
+    else if (streq(p[0], "app-custom-control") && p[1] && !p[2]=
)
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->acc_p=
rotocols =3D p[1];
+    }
+    else if (streq(p[0], "custom-control") && p[=
1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC);
=
+
+        if (!streq(p[2], "A:6") && !streq(p[2], "6:A"))
+        {
+    =
        msg(msglevel, "App custom control encoding must be base64 and ascii=
");
+            goto err;
+        }
+
+        if (!atoi_constrained(p[1]=
, &options->acc_max_message_length,
+                              "app cus=
tom message message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+=
        {
+            goto err;
+        }
+        options->acc_negotiate=
d_protocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !=
p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL libra=
ry PRNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opti=
ons=2Eh
index 131513e=2E=2Eef4f1fe 100644
--- a/src/openvpn/options=2Eh
+++=
 b/src/openvpn/options=2Eh
@@ -711,6 +711,16 @@
     /* force using TLS key=
 material export for data channel key generation */
     bool force_key_mat=
erial_export;
 
+    /** The app custom control protocols we should announc=
e as supported */
+    const char *acc_protocols;
+
+    /** the protocols =
that are negotiated with the peer=2E As a client we
+     * trust the serve=
r pushed list here */
+    const char *acc_negotiated_protocols;
+
+    /**=
 the maximum length of an ACC control channel message */
+    int acc_max_m=
essage_length;
+
     bool vlan_tagging;
     enum vlan_acceptable_frames v=
lan_accept;
     uint16_t vlan_pvid;
@@ -762,8 +772,10 @@
 #define OPT_P_IN=
LINE          (1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define=
 OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 3=
2)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEE=
R_ID | 0x0ull))
+/* Options allowed in the normal configuration file (vs pu=
shed options or in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE |=
 OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt)=
 ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
i=
ndex fa7bf1e=2E=2E12068b5 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openv=
pn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh=
"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #include "crypto=2Eh"
 #in=
clude "ssl=2Eh"
@@ -220,9 +222,8 @@
 #endif
 }
 
-
 void
-server_pushed_inf=
o(const struct buffer *buffer, const int adv)
+server_pushed_info(struct co=
ntext *c, const struct buffer *buffer, const int adv)
 {
     const char *m=
 =3D "";
     struct buffer buf =3D *buffer;
@@ -232,6 +233,27 @@
         =
m =3D BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
=
+        int max_acc_len =3D 0;
+
+
+        /* example string to parse: AC=
C:1400 A:6 flower:happy */
+        /* Skip over the ACC: prefix */
+      =
  m +=3D 4;
+
+        char *protocols =3D parse_acc_parameters(m, " ", &ma=
x_acc_len, false, &c->options=2Egc);
+        if (protocols)
+        {
+  =
          c->options=2Eacc_negotiated_protocols =3D protocols;
+           =
 c->options=2Eacc_max_message_length =3D max_acc_len;
+        }
+        e=
lse
+        {
+            msg(D_PUSH_ERRORS, "WARNING: Received ACC info =
command with invalid parameters");
+        }
+    }
+
 #ifdef ENABLE_MANAG=
EMENT
     struct gc_arena gc;
     if (management)
@@ -284,6 +306,7 @@
   =
  msg(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
+
 /**
  * =
Parse the keyword for the AUTH_PENDING request
  * @param buffer           =
     buffer containing the keywords, the buffer's
@@ -440,7 +463,6 @@
     =
const char *const peer_info =3D tls_multi->peer_info;
     unsigned int pro=
to =3D extract_iv_proto(peer_info);
 
-
     /* Calculate the maximum timeo=
ut and subtract the time we already waited */
     unsigned int max_timeout=
 =3D
         max_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi-=
>opt=2Ehandshake_window);
@@ -731,6 +753,11 @@
                 client_max_=
mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
     }
+
+    if (c->opt=
ions=2Eacc_negotiated_protocols)
+    {
+        push_option_fmt(gc, push_l=
ist, M_USAGE, "custom-control %d A:6 %s", c->options=2Eacc_max_message_leng=
th, c->options=2Eacc_negotiated_protocols);
+    }
 }
 
 #if defined(__GNUC=
__) || defined(__clang__)
diff --git a/src/openvpn/push=2Eh b/src/openvpn/p=
ush=2Eh
index dff945f=2E=2E3aca8a7 100644
--- a/src/openvpn/push=2Eh
+++ b/=
src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_incoming_push_request=
(struct context *c);
 
+
 /**
  * @brief Handles the receiving of a push-up=
date message and applies updates to the specified
  * options=2E
@@ -92,7 +=
93,7 @@
 
 void receive_exit_message(struct context *c);
 
-void server_pus=
hed_info(const struct buffer *buffer, const int adv);
+void server_pushed_i=
nfo(struct context *c, const struct buffer *buffer, const int adv);
 
 void=
 receive_cr_response(struct context *c, const struct buffer *buffer);
 
dif=
f --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index fcc54=
11=2E=2E6462a97 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/pu=
sh_util=2Ec
@@ -370,4 +370,4 @@
 
     RETURN_UPDATE_STATUS(n_sent);
 }
-#e=
ndif /* ifdef ENABLE_MANAGEMENT */
+#endif /* ifdef ENABLE_MANAGEMENT */
\ =
No newline at end of file
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ss=
l=2Ec
index 5f5d1f9=2E=2Ea5663e3 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src=
/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include=
 "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_ba=
ckend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -2054,6 +2055,11 @@
                 =
    }
                 }
             }
+
+            if (session->opt->ac=
c_protocols)
+            {
+                buf_printf(&out, "IV_ACC=3D%d,=
6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+            }
  =
       }
     }
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl=
_common=2Eh
index 6b86bc0=2E=2E0270c23 100644
--- a/src/openvpn/ssl_common=
=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -452,6 +452,9 @@
     size_t ekm_s=
ize;
 
     bool dco_enabled; /**< Whether keys have to be installed in DCO=
 or not */
+
+    /** The app custom control protocols we should announce a=
s supported */
+    const char *acc_protocols;
 };
 
 /** @addtogroup contr=
ol_processor
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/un=
it_tests/openvpn/Makefile=2Eam
index 5954902=2E=2E753e59d 100644
--- a/test=
s/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam
@@ -103,9 +103,11 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2E=
c \
+    test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_commo=
n=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_exec=
ve=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/=
argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/buffer=2Ec \
@@ -127,6 +129,7 @@
 	$(top_srcdir)/src/openvpn/run_comma=
nd=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/=
openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top=
_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_=
mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \
@@ -375,=
8 +378,10 @@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \
 	test_schedule=
=2Ec test_schedule=2Eh \
+	mock_management=2Ec mock_management=2Eh \
 	mock=
_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/ope=
nvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/=
src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
@=
@ -388,6 +393,7 @@
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir=
)/src/openvpn/siphash_reference=2Ec
 
+
 push_update_msg_testdriver_CFLAGS =
=3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_=
srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/openvpn/mo=
ck_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index 77f6=
ce2=2E=2Ecddd669 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
=
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 
 #in=
clude "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
 #ifd=
ef ENABLE_MANAGEMENT
@@ -60,4 +61,4 @@
 void
 management_sleep(const int n)=

 {
-}
+}
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn=
/mock_management=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh
new fil=
e mode 100644
index 0000000=2E=2Ee21aec43
--- /dev/null
+++ b/tests/unit_te=
sts/openvpn/mock_management=2Eh
@@ -0,0 +1,32 @@
+/*
+ *  OpenVPN -- An app=
lication to securely tunnel IP networks
+ *             over a single TCP/U=
DP port, with support for SSL/TLS-based
+ *             session authenticat=
ion and key exchange,
+ *             packet encryption, packet authenticat=
ion, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 =
OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arn=
e@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redist=
ribute it and/or modify
+ *  it under the terms of the GNU General Public L=
icense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+=
 *  This program is distributed in the hope that it will be useful,
+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Pub=
lic License for more details=2E
+ *
+ *  You should have received a copy of=
 the GNU General Public License along
+ *  with this program; if not, write=
 to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef MOCK_MANAGEMENT_H
+#defin=
e MOCK_MANAGEMENT_H
+void init_mock_management(void);
+
+void uninit_mock_m=
anagement(void);
+
+#endif
diff --git a/tests/unit_tests/openvpn/mock_push_=
dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
inde=
x 112bcfd=2E=2Ec16d0cb 100644
--- a/tests/unit_tests/openvpn/mock_push_depe=
ndencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -=
43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P=
_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SHA=
PER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT_=
P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-        =
             | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | O=
PT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUS=
H_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
    =
 return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/te=
sts/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=
=2E16b2b3b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,=
0 +1,298 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networ=
ks
+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *=
  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This pr=
ogram is free software; you can redistribute it and/or modify
+ *  it under=
 the terms of the GNU General Public License version 2
+ *  as published by=
 the Free Software Foundation=2E
+ *
+ *  This program is distributed in th=
e hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even =
the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+=
 *  You should have received a copy of the GNU General Public License along=

+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ *=
/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshe=
ad=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2E=
h>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+=
#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include "test_common=2Eh"
+
+=
#include "mock_msg=2Eh"
+
+char control_channel_mesage_sent[2048];
+
+/* Mo=
ck functions */
+bool
+send_control_channel_string_dowork(struct tls_sessio=
n *session,
+                                   const char *str, int msglev=
el)
+{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    memcpy(contro=
l_channel_mesage_sent, str, strlen(str));
+    return true;
+}
+
+void
+sen=
d_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_cl=
ient_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#define M=
SG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+    =
                "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
=
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwC=
P" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgA=
WABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAu=
BAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDA=
wEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4T=
z2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D"
+=

+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENABLE_MAN=
AGEMENT
+    skip();
+#else
+    /* ensure that the messages get to mock_ms=
g */
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678;
+   =
 struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientHell=
o */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    struct=
 buffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=2Emode =
=3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_m=
ulti, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=
=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->mda_c=
ontext =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void *)msg, =
sizeof(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_=
equal(mock_msg_buf, "Received custom app control message (protocol 'cck1')"=
);
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," M=
SG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIE=
tlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (v=
oid *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_bu=
f);
+    assert_string_equal(mock_msg_buf, "Received custom app control mes=
sage (protocol 'flower')");
+    assert_string_equal(mock_managment_buf, ">=
CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=
=3D");
+
+    CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[=
] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2V=
ybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, =
sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+    co=
nst char *error =3D "WARNING: Received malformed custom app control channel=
 "
+                        "(field length 62, payload length 64 mismatch) =
message "
+                        "control message: 496e7367 496d316c 496a=
6f67 496d5a79 "
+                        "62326369 4c434141 65475a6d 2f534a=
7[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+    as=
sert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment_buf)=
;
+    const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+ =
   buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));
+   =
 receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, =
"Received custom app control message (protocol 'power', fragment)");
+    a=
ssert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=
=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding pres=
ent */
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAA=
IEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, =
(void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive_acc=
_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custo=
m app control channel (number of "
+            "encodings must be exactly =
one (B64=3D1, ASCII=3D1)) message control "
+            "message: 53534268=
 62534141 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 3737=
2b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    as=
sert_string_equal(mock_managment_buf, "");
+
+    /* no encoding present */=

+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlcm1pd=
CD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)f=
lower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_message(&c=
, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom app contr=
ol channel (number of "
+            "encodings must be exactly one (B64=3D=
0, ASCII=3D0)) message control "
+            "message: 53534268 62534141 4=
945746c 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[more=2E=
=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_string=
_equal(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    management=
 =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_parameters=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* parameters =
to INFO message */
+    const char *info_acc_msg =3D "4096 A:6 flower:happy=
";
+
+    int max_len =3D 0;
+    const char *protocols =3D parse_acc_param=
eters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(pro=
tocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a =
client does not accept a length longer than it supports */
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    ass=
ert_null(protocols);
+
+    /* message with lower limit than our, should wo=
rk for client and server */
+    info_acc_msg =3D "1111 A:6 flower:happy";
=
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false,=
 &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int=
_equal(max_len, 1111);
+
+    protocols =3D parse_acc_parameters(info_acc_m=
sg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:=
happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more encodings tha=
n supported=2E Server should be okay, client should fail */
+    info_acc_m=
sg =3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc_parameters(i=
nfo_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+  =
  protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc=
);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equ=
al(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg =3D "1400=
 A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg=
, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    ass=
ert_null(protocols);
+
+
+    const char *iv_acc_capabilities =3D "1400,A:6=
,flower:happy:power";
+    protocols =3D parse_acc_parameters(iv_acc_capabi=
lities, ",", &max_len, true, &gc);
+    assert_string_equal(protocols, "flo=
wer:happy:power");
+
+    /* too small protocol length */
+    info_acc_msg=
 =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_ac=
c_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* no=
n-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flower:happy=
 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &max_len, =
true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical protocol l=
ength */
+    info_acc_msg =3D "abff A:6 flower:happy 77";
+    protocols =
=3D parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+    asse=
rt_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protoc=
ols(void **state)
+{
+    struct context c =3D { 0 };
+    c=2Eoptions=2Egc=
 =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_mul=
ti, &c=2Eoptions=2Egc);
+
+    c=2Ec2=2Etls_multi->peer_info =3D "IV_PROTO=
=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c=2Eoptions=2Eacc_prot=
ocols =3D "power:flower:star";
+
+    determine_common_acc_protocols(&c);
+=

+    assert_int_equal(c=2Eoptions=2Eacc_max_message_length, ACC_MAX_MSG_LE=
N);
+    assert_string_equal(c=2Eoptions=2Eacc_negotiated_protocols, "flowe=
r:power");
+
+    gc_free(&c=2Eoptions=2Egc);
+}
+
+void
+test_acc_send_mes=
sage(void **state)
+{
+    struct context c =3D { 0 };
+    c=2Eoptions=2Eg=
c =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_mu=
lti, &c=2Eoptions=2Egc);
+    bool ret;
+
+    c=2Ec2=2Etls_multi->peer_inf=
o =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power";
+    c=
=2Eoptions=2Eacc_protocols =3D "power:flower:emergency";
+    determine_com=
mon_acc_protocols(&c);
+
+
+    struct tls_session *session =3D &c=2Ec2=2Et=
ls_multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_message(&c, c=2Ec2=2E=
tls_multi, session, "emergency", true,
+                           "EMERGEN=
CY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    assert_true(re=
t);
+    assert_string_equal(control_channel_mesage_sent,
+                =
        "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DR=
ILL:");
+
+    ret =3D send_acc_message(&c, c=2Ec2=2Etls_multi, session, "e=
mergency", false,
+                           "THE GOVERNMENT HAS ISSUED A =
RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_true(ret);
+ =
   assert_string_equal(control_channel_mesage_sent,
+                      =
  "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FO=
R YOUR AREA=2E");
+
+
+    /* test a long message (> 1000) with fragment to=
 get the maximum header size */
+    char long_message[1200] =3D { 0 };
+
+=
    for (int i =3D 0; i < 1024; i++)
+    {
+        long_message[i] =3D (c=
har)(' ' + (i % 95));
+    }
+
+    /* last char of the message is a i and =
then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    assert_in=
t_equal(long_message[1024], '\0');
+
+    ret =3D send_acc_message(&c, c=2E=
c2=2Etls_multi, session, "emergency", true,
+                           lon=
g_message, false);
+
+    assert_true(ret);
+    size_t cc_len =3D strlen(c=
ontrol_channel_mesage_sent);
+    assert_int_equal(control_channel_mesage_s=
ent[cc_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC,emergenc=
y,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_chan=
nel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));
+
+    gc_f=
ree(&c=2Eoptions=2Egc);
+}
\ No newline at end of file
diff --git a/tests/u=
nit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
new =
file mode 100644
index 0000000=2E=2Ea64bab5
--- /dev/null
+++ b/tests/unit_=
tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks
+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based
+ *             session authentication a=
nd key exchange,
+ *             packet encryption, packet authentication, =
and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenV=
PN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc=
2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistribut=
e it and/or modify
+ *  it under the terms of the GNU General Public Licens=
e version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  T=
his program is distributed in the hope that it will be useful,
+ *  but WIT=
HOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILIT=
Y or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public L=
icense for more details=2E
+ *
+ *  You should have received a copy of the =
GNU General Public License along
+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H=

+void test_acc_parse_client_messages(void **state);
+
+void test_parse_acc=
_parameters(void **state);
+
+void test_acc_common_protocols(void **state);=

+
+void test_acc_send_message(void **state);
+#endif
diff --git a/tests/un=
it_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh=

index 8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_tests/openvpn/test_comm=
on=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -43,11 +43,13 @@
 =
#define LargestIntegralType uintmax_t
 #endif
 /* redefine 2=2Ex API in ter=
ms of 1=2Ex API */
-#define CMockaValueData             LargestIntegralType=

-#define check_expected_uint         check_expected
-#define expect_uint_v=
alue           expect_value
-#define expect_check_data           expect_che=
ck
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValueData       =
                LargestIntegralType
+#define check_expected_uint           =
        check_expected
+#define expect_uint_value                     expec=
t_value
+#define expect_check_data                     expect_check
+#defin=
e cast_ptr_to_cmocka_value(x)           (x)
+#define assert_int_in_range(va=
lue, min, max)  assert_in_range((value), (min), (max))
+#define assert_uint=
_in_range(value, min, max) assert_in_range((value), (min), (max))
 #endif
 =

 /**
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_test=
s/openvpn/test_misc=2Ec
index a41c27b=2E=2E82292f1 100644
--- a/tests/unit_=
tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@=
 -40,11 +40,34 @@
 #include "list=2Eh"
 #include "mock_msg=2Eh"
 #include "=
crypto=2Eh"
+#include "test_schedule=2Eh"
+#include "multi=2Eh"
+
 #ifdef _=
WIN32
 #include "win32-util=2Eh"
 #endif
-#include "test_schedule=2Eh"
 
+/=
* extra mocks */
+bool
+apply_push_options(struct context *c, struct option=
s *options, struct buffer *buf,
+                   uint64_t permission_mas=
k, uint64_t *option_types_found,
+                   struct env_set *es, bo=
ol is_update)
+{
+    return true;
+}
+
+bool
+send_control_channel_string(=
struct context *c, const char *str, msglvl_t msglevel)
+{
+    check_expect=
ed_ptr(str);
+    return true;
+}
+
+struct multi_instance *
+lookup_by_cid=
(struct multi_context *m, const unsigned long cid)
+{
+    return *(m->inst=
ances);
+}
 
 static void
 test_compat_lzo_string(void **state)
diff --git =
a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec
index 887c492=2E=2Eaa639ff 100644
--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #inc=
lude "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_acc=2Eh"
+
=
 /* Mock function to be allowed to include win32=2Ec which is required for
=
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
    =
 return;
 }
+void
+reschedule_multi_process(struct context *c)
+{
+}
+
+/* =
Define a dummy dco cipher option to avoid linking against all the DCO
+ * u=
nits */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphers(v=
oid)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA=
20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req -x509 -newke=
y ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -960,8 +976,11 @@
=
         cmocka_unit_test(test_data_channel_known_vectors_epoch),
         =
cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
         cmoc=
ka_unit_test(crypto_test_print_cert_details),
-        cmocka_unit_test(ssl=
_test_extract_peer_info)
-
+        cmocka_unit_test(ssl_test_extract_peer_=
info),
+        cmocka_unit_test(test_acc_parse_client_messages),
+        =
cmocka_unit_test(test_parse_acc_parameters),
+        cmocka_unit_test(test=
_acc_common_protocols),
+        cmocka_unit_test(test_acc_send_message)
  =
   };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit=
-Change-Number: 1858
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: flichtenheld <frank@lichtenheld=2Ecom>

--g+AIlqSRH2M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement sending/receiving app custom control protocol<br><b=
r>This allows openvpn GUI/front-ends and server via management<br>to use th=
e OpenVPN control channel to pass messages between each other<br>while Open=
VPN handles the marshalling/unmarshalling of these and<br>negotiate the com=
mon app custom control protocols=2E<br><br>This provides an easy to use sec=
ure channel that does not depends on<br>the network itself to work and can =
also used before fully authenticating<br>the client=2E See the management-n=
otes=2Etxt for more details how to use<br>this feature=2E An upcoming patch=
 will also add some example python<br>script that showcase this feature=2E<=
br><br>Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-b=
y: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>=
M doc/man-sections/client-options=2Erst<br>M doc/management-notes=2Etxt<br>=
M src/openvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=
=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvp=
n/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M sr=
c/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2E=
c<br>M src/openvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>M src/openvpn=
/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/unit_tests/openvpn/Make=
file=2Eam<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>A tests/unit=
_tests/openvpn/mock_management=2Eh<br>M tests/unit_tests/openvpn/mock_push_=
dependencies=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit=
_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<b=
r>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/te=
st_ssl=2Ec<br>27 files changed, 1,345 insertions(+), 27 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/58/1858/8</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Et=
xt</span><br><span>index 6eb5954=2E=2Ea9331c2 100644</span><br><span>--- a/=
CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ =
-424,6 +424,8 @@</span><br><span>     src/compat/compat-gettimeofday=2Ec</s=
pan><br><span>     src/compat/compat-strsep=2Ec</span><br><span>     src/co=
mpat/compat-strtok_r=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    src/openvpn/acc=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    src/openvpn/acc=2Eh</span><br><span>     src/openvpn/argv=2Ec<=
/span><br><span>     src/openvpn/argv=2Eh</span><br><span>     src/openvpn/=
base64=2Ec</span><br><span>@@ -560,9 +562,9 @@</span><br><span>     src/ope=
nvpn/ps=2Ec</span><br><span>     src/openvpn/ps=2Eh</span><br><span>     sr=
c/openvpn/push=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 src/openvpn/push_util=2Ec</span><br><span>     src/openvpn/push=2Eh</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/pushlist=2Eh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pus=
h_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
rc/openvpn/pushlist=2Eh</span><br><span>     src/openvpn/reflect_filter=2Ec=
</span><br><span>     src/openvpn/reflect_filter=2Eh</span><br><span>     s=
rc/openvpn/reliable=2Ec</span><br><span>@@ -812,7 +814,10 @@</span><br><spa=
n>             tests/unit_tests/openvpn/mock_management=2Ec</span><br><span=
>             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br>=
<span>             tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/=
openvpn/test_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            src/openvpn/acc=2Ec</span><br><span>             src/openvpn/a=
rgv=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
src/openvpn/auth_token=2Ec</span><br><span>             src/openvpn/base64=
=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br><s=
pan>             src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -826,8 +=
831,11 @@</span><br><span>             src/openvpn/options_util=2Ec</span><=
br><span>             src/openvpn/otime=2Ec</span><br><span>             sr=
c/openvpn/packet_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            src/openvpn/reliable=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            src/openvpn/session_id=2Ec</span><br><span=
>             src/openvpn/run_command=2Ec</span><br><span>             src/=
openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            src/openvpn/ssl_ncp=2Ec</span><br><span>             src/op=
envpn/ssl_openssl=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec=
</span><br><span>             src/openvpn/ssl_verify_mbedtls=2Ec</span><br>=
<span>@@ -844,6 +852,8 @@</span><br><span>     target_sources(test_misc PRI=
VATE</span><br><span>         tests/unit_tests/openvpn/mock_get_random=2Ec<=
/span><br><span>         tests/unit_tests/openvpn/test_schedule=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/op=
envpn/mock_management=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        src/openvpn/base64=2Ec</span><br><span>         src/openvpn/o=
ptions_util=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><br><s=
pan>         src/openvpn/ssl_util=2Ec</span><br><span>diff --git a/doc/man-=
sections/client-options=2Erst b/doc/man-sections/client-options=2Erst</span=
><br><span>index 87c138a=2E=2E89ba7cf 100644</span><br><span>--- a/doc/man-=
sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client=
-options=2Erst</span><br><span>@@ -12,6 +12,17 @@</span><br><span>   When t=
his option is set, OpenVPN will not drop incoming tun packets with</span><b=
r><span>   same destination as host=2E</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+--app-custom-control protocollist</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the list of suppo=
rted app custom control protocols=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  These protocols are announced to the server when this op=
tion is used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as a =
client=2E If the option is set on a server it will negotiate the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  common protocols with the cl=
ient=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  The protocollist is a : separ=
ated list of protocol identifiers=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
See management-notes=2Etxt in the OpenVPN distribution  and the OpenVPN RFC=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  draft for a descr=
iption of app custom control protocol support=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> --auth-token token</span><br=
><span>   This is not an option to be used directly in any configuration fi=
les,</span><br><span>   but rather push this option from a ``--client-conne=
ct`` script or a</span><br><span>diff --git a/doc/management-notes=2Etxt b/=
doc/management-notes=2Etxt</span><br><span>index d6b3fbb=2E=2Ee5ab2f5 10064=
4</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/do=
c/management-notes=2Etxt</span><br><span>@@ -798,6 +798,58 @@</span><br><sp=
an> The client should return the response to the crtext challenge</span><br=
><span> using the cr-response command=2E</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+app custom control</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+I=
f the special string &quot;ACC&quot; is passed as {EXTRA} OpenVPN will dete=
rmine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the common app=
 custom protocols between the client and the sever and instruct</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+the client that the server will=
 send control messages to the client using</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+the ACC protocol=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+The server should then use acc-msg command to send app custom control m=
essages</span><br><span style=3D"color: hsl(120, 100%, 40%);">+to the clien=
t to faciliate the pending authentication=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+-------------------------------------=
-----</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+On an OpenVPN instance running in=
 server mode this command sends an</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+app custom control message to a client=2E The format of the =
command is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  client-acc-msg {CID} {KID=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+CID,KID -- client ID and Key ID=2E See documentation for &quot;&gt;CLIENT:=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+notification =
for more info=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+protocol -- the ACC pr=
otocol identified that this message should be</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            tagged with=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+flags    -- a colon separated list of the encoding and the f=
lag if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            t=
he message is a fragment=2E E=2Eg=2E &quot;6:F&quot; for a base64 encoded</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            message t=
hat is also a fragment and not complete yet=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+message  -- The message encoded in the encoding specified in flags<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+---------------------------------=
---------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+When OpenVPN is running in --=
client mode this command sends an app</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+custom command to the server=2E The format of the command=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+See the client-acc-msg comma=
nd for more details about the format of the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+message=2E Since a client has only one peer there i=
s no need to specify the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+client id and key id=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><span> =
-----------------------------------------------</span><br><span> </span><br=
><span>@@ -1247,6 +1299,23 @@</span><br><span>    response=2E Mechanisms th=
at need multiple rounds or more complex answers</span><br><span>    should =
implement a different response type than CR_RESPONSE=2E</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+(6) App custom contro=
l message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    This message is an applic=
ation specific payload message that is transported</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    over the OpenVPN control channel=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    In server mode:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_ba=
se64}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    In client mode:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &gt;ACC:{protocol},{fragment},{msg_base64}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    The protocol is a short ascii string ide=
ntifying the app specific custom</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    protocol and identifies the protocol=2E If fragment is set=
 to 1, the message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   is not complete and the next message should be concatenated to this mess=
age</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to form a co=
mplete message=2E</span><br><span> </span><br><span> Variables:</span><br><=
span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn=
/Makefile=2Eam</span><br><span>index 7fd12b4=2E=2Ede7a5e7 100644</span><br>=
<span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Mak=
efile=2Eam</span><br><span>@@ -42,6 +42,7 @@</span><br><span> sbin_PROGRAMS=
 =3D openvpn</span><br><span> </span><br><span> openvpn_SOURCES =3D \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span>=
<br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=
=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -121,7 =
+122,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=
=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br><sp=
an> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh=
 \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git=
 a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode =
100644</span><br><span>index 0000000=2E=2Eb101283</span><br><span>--- /dev/=
null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,3=
96 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application t=
o securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             over a single TCP/UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    session authentication and key exchange,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet encryption, packet authentic=
ation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+enum acc_message_flag</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_BASE64 =
=3D 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSA=
GE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+log_acc_message(struct context *c, const struct buffer *bu=
f, int payload_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                const char *protocol, int flags)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool fragment =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGMENT;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEME=
NT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *payload_msg =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* For simplicity, we always encode payload to be base64 encoded</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * if not already in ba=
se64 format */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        char *b64out =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ASSERT(openvpn_base64_encode(BPTR(buf), payload_le=
n, &amp;b64out) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        gc_addspecial(b64out, free, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D b64out;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        payload_msg =3D BSTR(buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m=
anagement)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_sess=
ion *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct man_def_auth_context *mda =3D se=
ssion-&gt;opt-&gt;mda_context;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* server mode=2E Report clie=
nt context */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt=
;mda_key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                mda-&gt;cid, mda=
_key_id, protocol, fragment, payload_msg);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* Client mode=2E Do not a report a CLIENT id */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;AC=
C:%s,%d,%s&quot;, protocol, fragment, payload_msg);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received custom app cont=
rol message (protocol &#39;%s&#39;%s)&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        protocol, fragment ? &quot;, fragment&quot=
; : &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Parses the flags field of an app control message and moves the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  buffer past the flags =
string=2E If there is an</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  error parsing the flags field the method returns -1 and</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  puts the error reason in e=
rr_reason</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(struct buff=
er *buf, const char **err_reason, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *flags =3D buf_extract_field(buf, &#39;,&#3=
9;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        *err_reason =3D &quot;could not extract =
flags field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A&=
#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=
=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&#39=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D =
ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *err_re=
ason =3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return -1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* The message should be encoded with exactly one encoding=2E Ensure=
 that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only on=
e of the flags is present */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASC=
II);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool base64=
enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &=
quot;number of encodings must be exactly one &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;(B64=3D%=
d, ASCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                 base64enc, asciienc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        *err_reason =3D tmp;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return acc_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+receive_acc_message(struct context *c, const struct buffer *buffer)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *err_reas=
on =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example mes=
sage: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D *buffer;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&quot;ACC&quot;)) |=
| buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        err_reason =3D &quot;missing , after ACC&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* extract protocol, payload length, flags substrings */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocol =3D bu=
f_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!protocol)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        err_reason =3D &quot;could not extract protocol field=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int payload_len;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *payload_len_str =3D buf_extract_fiel=
d(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!payload_len_str || !((payload_len =3D atoi(payload_=
len_str))))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D=
 &quot;could not extract payload length field&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int flags =3D parse_acc_message_flags(&amp;buf, &amp;err_reason, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 We should have a final NUL byte in the control message buffer</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * and thus the length of th=
e buffer should be payload_len + 1 */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snp=
rintf(tmp, 512, &quot;field length %d, payload length %d mismatch&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 paylo=
ad_len, buf_len(&amp;buf) - 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        err_reason =3D tmp;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    log_acc_message(c, &amp;buf, p=
ayload_len, protocol, flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;W=
ARNING: Received malformed custom app control channel &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                       &quot;(%s) =
message control message: %s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        err_reason,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        format_hex(BPTR(&amp;buf), BLEN(&amp;buf), 80, &amp;=
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc=
_message(struct context *c,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                 struct tls_multi *tls_multi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 struct tls_session *sess=
ion,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const char *protocol, bool fragment,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                 const char *msg, bool base64)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * length of the protocol string + one &#39;,&#39;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 2 for the encoding=
 (A or 6), potential F (fragment), and 1 for the &#39;,&#39;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * 4 for the message size its=
elf and one comma</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * 1 for the comma before the message itself */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const size_t max_header_size =3D strlen(&=
quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D max_header_size + s=
trlen(msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNE=
L_BUF_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, =
&quot;message length (%zu) exceeds maximum possible message length (%d)&quo=
t;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &g=
t; c-&gt;options=2Eacc_max_message_length)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_CLIENT, &quot;header (%zu) + message size (%zu) leng=
th (%zu) exceeds &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                      &quot;maximum allowed length negotiated with peer=
 (%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     max_header_size, strlen(msg), len,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            c-&gt;options=2Eacc_max_message_length);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(len + 1, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,=
%zu,%s%s,%s&quot;, protocol,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+               strlen(msg),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+               base64 ? &quot;6&quot; : &quot;A&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+               fragment=
 ? &quot;F&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+               msg);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
end_control_channel_string_dowork(session, BSTR(&amp;buf), D_PUSH);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    reschedule_multi_proces=
s(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+parse_acc_parameters(const char *capabilities,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                     const char *delim=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   int *max_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     bool server,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                     struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *tmp_message =3D string_alloc(capabilities, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_me=
ssage_orig =3D tmp_message;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *token =3D strtok_r(tmp_message, delim, &amp;lasts);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int acclen =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *protocols =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* In server mode we allow more capabilities th=
an our own, in client</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * mode we reject if we should use capabilities that we do not suppor=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int allowed=
_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    while (token)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p =3D=3D 0 &amp;&amp; !atoi_constrained(token, &amp;acclen, &quot;ACC=
 message length&quot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; (!tls_item_in_cipher_lis=
t(&quot;A&quot;, token) || !tls_item_in_cipher_list(&quot;6&quot;, token)))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS=
, &quot;App custom control encoding must include base64 and ascii&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto done=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; !server &amp;=
&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; strcmp(token, &quot;6:A&quo=
t;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ER=
RORS, &quot;App custom control encoding must exactly base64 and ascii&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto =
done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 2)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            protocols =3D token;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (p =3D=3D 3)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_PUSH_ERRORS, &quot;Too many parameters for INFO ACC=
 message/IV_ACC=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            goto done;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D s=
trtok_r(NULL, delim, &amp;lasts);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        p++;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    *max_acc_len =3D min_i=
nt(acclen, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ret =3D string_alloc(protocols, gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free(tmp_message_orig);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+determine_common_acc_protocols(struct context *c)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!c-&gt;options=2Eacc_protocols)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* No app custom protocols have been configu=
red server-side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;op=
tions=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* We already have determined the common protocols=2E Doing this</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * again would=
 just add an extra string allocation to options-&gt;gc */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *peer_info =3D c-&gt;c2=
=2Etls_multi-&gt;peer_info;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char *iv_acc =3D extract_var_peer_info(peer_info, &quot;IV_ACC=
=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!iv_acc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *protocols =3D parse_acc_parame=
ters(iv_acc, &quot;,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!protocols)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info v=
ariable of peer is malformed&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *token =3D strtok_r(protocols, &quot;:&quot;, &amp;lasts);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer common_protocols =3D alloc_buf_gc(10=
24, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (tls_item_in_cipher_list(token=
, c-&gt;options=2Eacc_protocols))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* protocol is in both server and client list */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(&amp;c=
ommon_protocols) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               buf_write_u8(&amp;common_protocols, &#39;:&#39;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;common_p=
rotocols, &quot;%s&quot;, token);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (buf_len(&amp;common_protocols) =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING: =
No common app custom control protocol=2E&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&g=
t;options=2Eacc_negotiated_protocols =3D string_alloc(buf_str(&amp;common_p=
rotocols), &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    c-&gt;options=2Eacc_max_message_length =3D max_acc_len=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>\ No newline at end of file</span><br><span>diff --git a/src/openvpn/acc=
=2Eh b/src/openvpn/acc=2Eh</span><br><span>new file mode 100644</span><br><=
span>index 0000000=2E=2E5d9b203</span><br><span>--- /dev/null</span><br><sp=
an>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -0,0 +1,92 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel I=
P networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      over a single TCP/UDP port, with support for SSL/TLS-based</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             session authent=
ication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet encryption, packet authentication, and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compre=
ssion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  This program is free software; you can redistri=
bute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  it under the terms of the GNU General Public License version 2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fr=
ee Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pr=
ogram is distributed in the hope that it will be useful,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pu=
blic License for more details=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, write to the Free Software Foundation, Inc=2E,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This me=
thod parses an app custom control message and delivers it to the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * management interface=2E We =
leave reassembly of fragmented messages to the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * management interface=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param c            The context struct</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param buffer       Buffer contai=
ning the control message with ACC</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+receive_acc_messa=
ge(struct context *c, const struct buffer *buffer);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(st=
ruct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              struct tls_multi *tls_multi,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 struct tls_session *session,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 const cha=
r *protocol, bool fragment,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                 const char *msg, bool base64);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an info =
message from the server that contains app custom control info</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * information prior to the PUSH_=
REPLY to be able to use app custom control</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * protocols before sending</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * In client mode only allow what we support ourselves=2E In =
server mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allow=
 also capabilities that we not support ourselves=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param capabilities      The string to parse</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param delim             Th=
e delimiter to use when parsing the string=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *                          IV_ACC uses &quot;,&q=
uot; as delimiter while the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                          custom-control PUSH message uses &quot;=
 &quot; as &quot;,&quot; is</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                          already used to separate different push=
 directives</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m max_acc_len       Set to the maximum ACC message length</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param server            Whether w=
e are server or client</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param gc                The gc arena to use for allocating the resul=
ting string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn                  The resulting protocol string or NULL on error</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     const cha=
r *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           int *max_acc_len,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                     bool server,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                     struct gc_arena *gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Parses the IV_ACC of the peer and sets c-&gt;options=2Eacc_ne=
gotiated_protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* to the common protocols of server and client and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * c-&gt;options=2Eacc_max_message_length  t=
o the maximum length of the ACC message</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * support by both server and client=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * If there is no common protocol or the client does=
 not support any app custom</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * protocol c-&gt;options=2Eacc_negotiated_protocols will be set to=
 NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c     the client c=
ontext to use the set the app custom protocols=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
etermine_common_acc_protocols(struct context *c);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openv=
pn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 2ade321=2E=
=2E736e975 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><=
span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span>=
<br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;aut=
h_token=2Eh&quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&q=
uot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</sp=
an><br><span> </span><br><span>@@ -251,11 +252,11 @@</span><br><span>     }=
</span><br><span>     else if (buf_string_match_head_str(buf, &quot;INFO_PR=
E&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        server_pushed_info(buf, 8);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        server_pushed_info(c, buf, 8);</span><br=
><span>     }</span><br><span>     else if (buf_string_match_head_str(buf, =
&quot;INFO&quot;))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        server_pushed_info(buf, 4);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        server_pushed_info(c, buf, 4);<=
/span><br><span>     }</span><br><span>     else if (buf_string_match_head_=
str(buf, &quot;CR_RESPONSE&quot;))</span><br><span>     {</span><br><span>@=
@ -265,6 +266,10 @@</span><br><span>     {</span><br><span>         receive=
_auth_pending(c, buf);</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (buf_string_match_head_str(buf, &quot=
;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        receive_acc_m=
essage(c, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     else if (buf_string_match_head_str(buf, &quot;EXIT&q=
uot;))</span><br><span>     {</span><br><span>         receive_exit_message=
(c);</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index 04220f4=2E=2Eaacbfe5a 100644</span><br><span>---=
 a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><b=
r><span>@@ -2283,6 +2283,10 @@</span><br><span>             buf_printf(&amp=
;out, &quot; aead-epoch&quot;);</span><br><span>         }</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt=
;options=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        buf_printf(&amp;out, &quot; custom-control %d,A:6,%s&quot;, c-&g=
t;options=2Eacc_max_message_length, c-&gt;options=2Eacc_negotiated_protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span> </span><br><span>     if (BLENZ(&amp;out) &gt; strlen(header))</span=
><br><span>     {</span><br><span>@@ -2527,6 +2531,11 @@</span><br><span>  =
       flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (c-&gt;options=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        flags |=3D OPT_P_ACC;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     return flags;</span><br><span> }</span><br><span> </span>=
<br><span>@@ -3342,6 +3351,7 @@</span><br><span>     to=2Everify_hash_depth=
 =3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_n=
o_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex5=
09_username_field, options-&gt;x509_username_field, sizeof(to=2Ex509_userna=
me_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=
=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><span>     to=2Ee=
s =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_c=
tx;</span><br><span> </span><br><span>@@ -4300,6 +4310,27 @@</span><br><spa=
n> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
struct buffer_list *input) /* ownership transferred */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D arg;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; =
c-&gt;c2=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct tls_session *session =3D &amp;mult=
i-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct options *opt =3D &amp;c-&gt;options;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ret =3D management_send_acc_message(c, multi, se=
ssion, opt-&gt;acc_negotiated_protocols, input);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span>=
 </span><br><span> void</span><br><span>@@ -4316,6 +4347,7 @@</span><br><sp=
an>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><sp=
an>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><=
span>         cb=2Esend_cc_message =3D management_callback_send_cc_message;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_ms=
g =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br>=
<span>         cb=2Enetwork_change =3D management_callback_network_change;<=
/span><br><span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec=
 b/src/openvpn/manage=2Ec</span><br><span>index 29fdffc=2E=2Eabf6f8b 100644=
</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/ope=
nvpn/manage=2Ec</span><br><span>@@ -44,8 +44,10 @@</span><br><span> #includ=
e &quot;dco=2Eh&quot;</span><br><span> #include &quot;push=2Eh&quot;</span>=
<br><span> #include &quot;multi=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </=
span><br><span> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=
=2Eh&quot;</span><br><span>@@ -1080,6 +1082,35 @@</span><br><span>         =
    }</span><br><span>             break;</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&g=
t;persist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                bool status =3D (*man-&gt;persist=2Ecallback=
=2Eclient_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
                             man-&gt;connection=2Ein_extra_cid,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                                       man-&gt;connection=2Ein_extra_kid,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                                 man-&gt;connection=2Ein_ex=
tra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  man-&gt;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                report_command_status(status, &quot;c=
lient-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   man_command_unsupported(&quot;client-acc-msg&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                bool status =3D=
 (*man-&gt;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                           man-&gt;connection=2Ein_extra);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                man-=
&gt;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                report_command_status(status, &quot;acc-msg=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                man_comman=
d_unsupported(&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            break;</span><br><span>         case IEC_PK_SIGN:</sp=
an><br><span>             man-&gt;connection=2Eext_key_state =3D EKS_READY;=
</span><br><span>             buffer_list_free(man-&gt;connection=2Eext_key=
_input);</span><br><span>@@ -1204,6 +1235,29 @@</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+man_client_acc_msg(struct management *man, const char *c=
id_str,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       const char *kid_str)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 man_connection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_st=
r, &amp;mc-&gt;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&g=
t;in_extra_kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in=
_extra_cmd =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        in_extra_reset(mc, IER_NEW);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct manage=
ment *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *=
mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span> man_client_auth(struct management *m=
an, const char *cid_str, const char *kid_str, const bool extra)</span><br><=
span> {</span><br><span>     struct man_connection *mc =3D &amp;man-&gt;con=
nection;</span><br><span>@@ -1760,6 +1814,17 @@</span><br><span>           =
  man_client_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>   =
      }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (streq(p[0], &quot;client-acc-msg&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (man_need(man, p, 2, 0))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            man_client_acc_msg(man, p[=
1], p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ac=
c-msg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(=
man);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span>     else if (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>   =
  {</span><br><span>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><b=
r><span>@@ -3131,6 +3196,7 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> void</span><br><span> management_connection_established(struct=
 management *management, struct man_def_auth_context *mdac,</span><br><span=
>                                   const struct env_set *es)</span><br><sp=
an>@@ -4362,6 +4428,62 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_mess=
age(struct context *c, struct tls_multi *multi, struct tls_session *session=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          const char *negotiated_protocols, struct buffer_list *input)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* also ensures that are enough input=
s in the list to safely call</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * buffer_list_peek without extra NULL checks */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size =
&lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quo=
t;not enough input lines for sending acc message, &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                      &quot;missing pr=
otocol, flag and/or messages lines&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct buffer *proto_buf =3D buffer_list_peek(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =3D string_alloc=
(BSTR(proto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct buffer *encoding_buf =3D buffer_list_peek(input);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(=
encoding_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
har *flag =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    bool b64encoding =3D false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool fragment =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    while ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            b64encoding =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else if (!strcmp(flag, =
&quot;F&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fr=
agment =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(in=
put, 10000, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!negotiated_protocols || !tls_ite=
m_in_cipher_list(protocol, negotiated_protocols))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the list of neg=
otiated protocols: %s&quot;, np(negotiated_protocols));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool ret =3D send_acc_message(c, multi, session, protocol,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
   fragment, buf_str(acc_msg_buf),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                b64encoding);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEME=
NT */</span><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</sp=
an><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</=
span><br><span>index f752fec=2E=2Ede9303b 100644</span><br><span>--- a/src/=
openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><=
span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_clients)(void *arg)=
;</span><br><span>     bool (*send_cc_message)(void *arg, const char *messa=
ge, const char *parameter);</span><br><span>     bool (*kill_by_cid)(void *=
arg, const unsigned long cid, const char *kill_msg);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool (*client_auth)=
(void *arg, const unsigned long cid, const unsigned int mda_key_id,</span><=
br><span>                         const bool auth, const char *reason, cons=
t char *client_reason,</span><br><span>                         struct buff=
er_list *cc_config); /* ownership transferred */</span><br><span>     bool =
(*client_pending_auth)(void *arg, const unsigned long cid, const unsigned i=
nt kid,</span><br><span>                                 const char *extra,=
 unsigned int timeout);</span><br><span>     char *(*get_peer_info)(void *a=
rg, const unsigned long cid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                           const unsigned long =
cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            const unsigned int mda_key_id,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                           struct buffer_list *msg);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)=
(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            struct buffer_list *msg);</span><br><span>     bool (*proxy_cmd=
)(void *arg, const char **p);</span><br><span>     bool (*remote_cmd)(void =
*arg, const char **p);</span><br><span> #ifdef TARGET_ANDROID</span><br><sp=
an>@@ -292,13 +299,15 @@</span><br><span>     struct command_line *in;</spa=
n><br><span>     struct buffer_list *out;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF          =
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT=
_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIG=
N    3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CER=
TIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC=
_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 IEC_PASSWORD    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define IEC_RSA_SIGN       3</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define IEC_CERTIFICATE    4</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</s=
pan><br><span>     int in_extra_cmd;</span><br><span>     struct buffer_lis=
t *in_extra;</span><br><span>     unsigned long in_extra_cid;</span><br><sp=
an>@@ -503,6 +512,14 @@</span><br><span> </span><br><span> void man_persist=
_client_stats(struct management *man, struct context *c);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC =
message from the input buffer_list and send to the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * session identified by session and multi</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+struct tls_session;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+management_send_acc_message(struct context *c, struct =
tls_multi *multi, struct tls_session *session,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                            const char *negotiat=
ed_protocols, struct buffer_list *input);</span><br><span> #endif /* ifdef =
ENABLE_MANAGEMENT */</span><br><span> </span><br><span> /**</span><br><span=
>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span=
>index 46ff1ba=2E=2E1eb6c5b 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -52,6 +=
52,7 @@</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span>=
 #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filte=
r=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;acc=2Eh&quot;</span><br><span> </span><br><span> /*#define MULTI_DEB=
UG_EVENT_LOOP*/</span><br><span> </span><br><span>@@ -1773,6 +1774,13 @@</s=
pan><br><span>         o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NO=
TIFY;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (o-&gt;acc_protocols)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* If ACC is enabled server side call to find=
 common acc protocols,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * will be pushed during push message */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        determine_common_acc_protocols(c)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Select =
cipher if client supports Negotiable Crypto Parameters */</span><br><span> =
</span><br><span>     /* if we have already created our key, we cannot *cha=
nge* our own</span><br><span>@@ -4032,6 +4040,24 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+calculate_app_control_extra(struct context *c, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_pro=
tocols(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc=
_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_CLIENT, &quot;ACC: No negotiated protocols&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(1024, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, c-&gt;op=
tions=2Eacc_max_message_length, c-&gt;options=2Eacc_negotiated_protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&=
amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> =
management_client_pending_auth(void *arg, const unsigned long cid, const un=
signed int mda_key_id,</span><br><span>                                cons=
t char *extra, unsigned int timeout)</span><br><span>@@ -4042,10 +4068,22 @=
@</span><br><span>     if (mi)</span><br><span>     {</span><br><span>     =
    struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &=
quot;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
xtra =3D calculate_app_control_extra(&amp;mi-&gt;context, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!extra)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span>         struct tls_session *session =3D lookup_session_by_m=
da_key_id(multi, mda_key_id);</span><br><span> </span><br><span>         if=
 (!session)</span><br><span>         {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span>          =
   return false;</span><br><span>         }</span><br><span> </span><br><sp=
an>@@ -4053,6 +4091,7 @@</span><br><span>         bool ret =3D send_auth_pe=
nding_messages(multi, session, extra, timeout);</span><br><span>         re=
schedule_multi_process(&amp;mi-&gt;context);</span><br><span>         multi=
_schedule_context_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gc_free(&amp;gc);</span><br><span>         return ret;=
</span><br><span>     }</span><br><span>     return false;</span><br><span>=
@@ -4096,6 +4135,39 @@</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_client_acc_msg(voi=
d *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
              const unsigned long cid,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          const unsigned int mda_key_id,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
       struct buffer_list *input) /* ownership transferred */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_context *m =3D (struct multi_conte=
xt *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 multi_instance *mi =3D lookup_by_cid(m, cid);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (mi &amp;&amp; buffer_list_defined(input))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D mi-&gt;cont=
ext=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        struct tls_session *session =3D lookup_session_by_mda_key_id(mult=
i, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_CLIENT, &quot;client session not found&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buffer_list_free(input);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct options *opt =3D &amp;mi-&gt;con=
text=2Eoptions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D managem=
ent_send_acc_message(&amp;mi-&gt;context, multi, session, opt-&gt;acc_negot=
iated_protocols, input);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi_schedule_context_wakeup(m, mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static char *</s=
pan><br><span> management_get_peer_info(void *arg, const unsigned long cid)=
</span><br><span> {</span><br><span>@@ -4132,6 +4204,7 @@</span><br><span> =
        cb=2En_clients =3D management_callback_n_clients;</span><br><span> =
        cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br><span>      =
   cb=2Eclient_auth =3D management_client_auth;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D management_clie=
nt_acc_msg;</span><br><span>         cb=2Eclient_pending_auth =3D managemen=
t_client_pending_auth;</span><br><span>         cb=2Eget_peer_info =3D mana=
gement_get_peer_info;</span><br><span>         cb=2Epush_update_broadcast =
=3D management_callback_send_push_update_broadcast;</span><br><span>diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>ind=
ex 1939c69=2E=2E729aabc 100644</span><br><span>--- a/src/openvpn/options=2E=
c</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -35,6 +3=
5,7 @@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;acc=2Eh&quot;</span><br><span> #include &quot;buffer=2Eh&quot;=
</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> #include =
&quot;common=2Eh&quot;</span><br><span>@@ -7106,6 +7107,28 @@</span><br><sp=
an>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         opti=
ons-&gt;force_key_material_export =3D true;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &qu=
ot;app-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;acc_=
protocols =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp=
;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    VERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot=
;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, =
&quot;App custom control encoding must be base64 and ascii&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;ac=
c_max_message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              &quot;app custom message message length&quo=
t;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        options-&gt;acc_negotiated_protocols =3D p[3];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     el=
se if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</spa=
n><br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --prn=
g option ignored (SSL library PRNG is used)&quot;);</span><br><span>diff --=
git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>ind=
ex 131513e=2E=2Eef4f1fe 100644</span><br><span>--- a/src/openvpn/options=2E=
h</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -711,6 +=
711,16 @@</span><br><span>     /* force using TLS key material export for d=
ata channel key generation */</span><br><span>     bool force_key_material_=
export;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /** The app custom control protocols we should announce as suppor=
ted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *acc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols=
 that are negotiated with the peer=2E As a client we</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * trust the server pushed list here =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *a=
cc_negotiated_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the ma=
ximum length of an ACC control channel message */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int acc_max_message_length;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool vlan_t=
agging;</span><br><span>     enum vlan_acceptable_frames vlan_accept;</span=
><br><span>     uint16_t vlan_pvid;</span><br><span>@@ -762,8 +772,10 @@</s=
pan><br><span> #define OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><sp=
an> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define=
 OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define OPT_P_ACC             (1ull &lt;&lt; 32)</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OP=
T_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Options allowed i=
n the normal configuration file (vs pushed options or in ccd files) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~=
(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><=
span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/p=
ush=2Ec</span><br><span>index fa7bf1e=2E=2E12068b5 100644</span><br><span>-=
-- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span>=
<br><span>@@ -27,6 +27,8 @@</span><br><span> #include &quot;syshead=2Eh&quo=
t;</span><br><span> </span><br><span> #include &quot;push=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> =
#include &quot;options=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh=
&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -22=
0,9 +222,8 @@</span><br><span> #endif</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(co=
nst struct buffer *buffer, const int adv)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+server_pushed_info(struct context *c, const struct bu=
ffer *buffer, const int adv)</span><br><span> {</span><br><span>     const =
char *m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *buffe=
r;</span><br><span>@@ -232,6 +233,27 @@</span><br><span>         m =3D BSTR=
(&amp;buf);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int max_acc_len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* example string to parse: ACC:1400 A:6 fl=
ower:happy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Skip over the ACC: prefix */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        m +=3D 4;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 char *protocols =3D parse_acc_parameters(m, &quot; &quot;, &amp;max_acc_le=
n, false, &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (protocols)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            c-&gt;options=2Eacc_negotiated_protocols =3D protocols=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;=
options=2Eacc_max_message_length =3D max_acc_len;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command =
with invalid parameters&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</sp=
an><br><span>     if (management)</span><br><span>@@ -284,6 +306,7 @@</span=
><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&#=
39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Parse the keyword for the AUTH_PENDING request</span><br><span>  * @param =
buffer                buffer containing the keywords, the buffer&#39;s</spa=
n><br><span>@@ -440,7 +463,6 @@</span><br><span>     const char *const peer=
_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int proto =
=3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maximum=
 timeout and subtract the time we already waited */</span><br><span>     un=
signed int max_timeout =3D</span><br><span>         max_uint(tls_multi-&gt;=
opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span=
><br><span>@@ -731,6 +753,11 @@</span><br><span>                 client_max=
_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         }</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;opt=
ions=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6 =
%s&quot;, c-&gt;options=2Eacc_max_message_length, c-&gt;options=2Eacc_negot=
iated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> }</span><br><span> </span><br><span> #if defined(__GNU=
C__) || defined(__clang__)</span><br><span>diff --git a/src/openvpn/push=2E=
h b/src/openvpn/push=2Eh</span><br><span>index dff945f=2E=2E3aca8a7 100644<=
/span><br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvp=
n/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</span><br><span> </span><br><s=
pan> int process_incoming_push_request(struct context *c);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/**</span><br><span>  * @brief Handles the receiving of a push-update messa=
ge and applies updates to the specified</span><br><span>  * options=2E</spa=
n><br><span>@@ -92,7 +93,7 @@</span><br><span> </span><br><span> void recei=
ve_exit_message(struct context *c);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void server_pushed_info(const struct buffer=
 *buffer, const int adv);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void server_pushed_info(struct context *c, const struct buffer *buffe=
r, const int adv);</span><br><span> </span><br><span> void receive_cr_respo=
nse(struct context *c, const struct buffer *buffer);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=
=2Ec</span><br><span>index fcc5411=2E=2E6462a97 100644</span><br><span>--- =
a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec=
</span><br><span>@@ -370,4 +370,4 @@</span><br><span> </span><br><span>    =
 RETURN_UPDATE_STATUS(n_sent);</span><br><span> }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_MANAGEMENT */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEM=
ENT */</span><br><span>\ No newline at end of file</span><br><span>diff --g=
it a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1f=
9=2E=2Ea5663e3 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><=
span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br>=
<span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><s=
pan> #include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;=
ssl_verify=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;<=
/span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -2054,=
6 +2055,11 @@</span><br><span>                     }</span><br><span>      =
           }</span><br><span>             }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (session-&gt;opt-&gt;acc_protocols)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &quot;IV=
_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span>         }</span><br><span>     }</span><br><span> </span><br=
><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh=
</span><br><span>index 6b86bc0=2E=2E0270c23 100644</span><br><span>--- a/sr=
c/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</=
span><br><span>@@ -452,6 +452,9 @@</span><br><span>     size_t ekm_size;</s=
pan><br><span> </span><br><span>     bool dco_enabled; /**&lt; Whether keys=
 have to be installed in DCO or not */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /** The app custom control protocols we should announce as supported */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc=
_protocols;</span><br><span> };</span><br><span> </span><br><span> /** @add=
togroup control_processor</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>index 5954902=2E=2E753e59d 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>@@ -103,9 +103,11 @@</span><br><span> 	@TEST_CFLAGS@=
</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRY=
PTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    test_acc=2Ec test_acc=
=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span>=
<br><span> 	mock_management=2Ec \</span><br><span> 	mock_ssl_dependencies=
=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base6=
4=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br>=
<span>@@ -127,6 +129,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/run_c=
ommand=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_nc=
p=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><span>@@ -=
375,8 +378,10 @@</span><br><span> </span><br><span> misc_testdriver_SOURCES=
 =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedule=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management=
=2Ec mock_management=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2Eh  =
\</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/ssl_util=2Ec \</span><br><span>@@ -388,6 +393,7 @@</span><br><span> 	$(top=
_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/siphash_reference=2Ec</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> push_update_msg_testdriver_CFLAGS=
 =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/co=
mpat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</span><=
br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/=
unit_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=2Ec=
ddd669 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_managemen=
t=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</s=
pan><br><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #include=
 &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> #includ=
e &quot;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span>@@ -60,4 +61,4 @@</span><br><span> void</span><br=
><span> management_sleep(const int n)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/unit_=
tests/openvpn/mock_management=2Eh</span><br><span>new file mode 100644</spa=
n><br><span>index 0000000=2E=2Ee21aec43</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Eh</span><br><sp=
an>@@ -0,0 +1,32 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An=
 application to securely tunnel IP networks</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with sup=
port for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             session authentication and key exchange,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pa=
cket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet compression=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne=
 Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
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
, 40%);">+ *  with this program; if not, write to the Free Software Foundat=
ion, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void init_mock_management(void);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void uninit_mock_management(void);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_pus=
h_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</s=
pan><br><span>index 112bcfd=2E=2Ec16d0cb 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,=
8 @@</span><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS =
| OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span>                      | O=
PT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span=
><br><span>                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY |=
 OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU |=
 OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU=
 | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     | OPT_P_ACC;</span><br><span>     return fl=
ags;</span><br><span> }</span><br><span> </span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E16b2=
b3b</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,298 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 write to the Free Software Foundation, Inc=2E,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_a=
cc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char control_c=
hannel_mesage_sent[2048];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mock funct=
ions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string=
_dowork(struct tls_session *session,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                   const char *str, int ms=
glevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range(strlen=
(str), 0, 2048);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(control_cha=
nnel_mesage_sent, str, strlen(str));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_token(struct tls_=
multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
auth_set_client_reason(struct tls_multi *multi, const char *reason)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;           =
     \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot=
;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;QAXAB=
4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;ICAgaCBsIHA=
gJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;AUEAwQDAwAtAAIB=
AQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;93rQwityP9eKSijXgcQ=
=3D=3D&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_acc_parse_client_messages(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    skip();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* ensure that the messages get to mock_msg */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =
=3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    managemen=
t =3D (void *)0x12345678;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* contains a TLS 1=2E3 ClientHello */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC,cck1,384,6,&q=
uot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer msg=
_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct con=
text c =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE=
]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eop=
t-&gt;mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg, si=
zeof(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rece=
ive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(mock_msg_buf, &quot;Received custom app control mes=
sage (protocol &#39;cck1&#39;)&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CL=
IENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char flower_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD=
//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg, siz=
eof(flower_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Receiv=
ed custom app control message (protocol &#39;flower&#39;)&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_=
managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aG=
Ug77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char msg_incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm=
1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg=
_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &a=
mp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *error =3D &quot;WARNING: Received malformed custom app control cha=
nnel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                &quot;(field length 62, payload length 64 mismatch) message=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            &quot;control message: 496e7367 496d316c 496a6f67 496d5a79 &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       &quot;62326369 4c434141 65475a6d 2f534a7[more=2E=2E=2E]&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG=
8gdw=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_set_read(&amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_messa=
ge(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom app contr=
ol message (protocol &#39;power&#39;, fragment)&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_=
buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* check two encoding present */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_m=
sg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94o=
CPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof(fl=
ower_msg_two_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    error =3D &quot;WARNING: Received malformed custom app control=
 channel (number of &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;encodings must be exactly one (B64=3D1, ASCII=3D1)=
) message control &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;message: 53534268 62534141 4945746c 636d3170 6443442=
f 2f534230 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, er=
ror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* no encoding present */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char flower_msg_no_encs[] =3D &quot;ACC,flower,48=
,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (v=
oid *)flower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg=
_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Rec=
eived malformed custom app control channel (number of &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;encodings must b=
e exactly one (B64=3D0, ASCII=3D0)) message control &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;message: 53534268 =
62534141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;61475567 37372b3[more=
=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_pars=
e_acc_parameters(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* parameters to INFO message */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &quot;4096 A:6 =
flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_len =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_le=
n, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1280=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* a client does not accept a le=
ngth longer than it supports */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &qu=
ot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* message with lower limit than our, should work for client and s=
erver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_ac=
c_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_ms=
g, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flowe=
r:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
otocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than supported=
=2E Server should be okay, client should fail */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B flower:h=
appy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prot=
ocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, f=
alse, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =
=3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flow=
er:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto=
cols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, fa=
lse, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capabilities=
 =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv_acc_cap=
abilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quo=
t;flower:happy:power&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* too=
 small protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_paramet=
ers(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol length */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D =
&quot;abff A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quo=
t;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* non-numerical protocol length */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:ha=
ppy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
otocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_acc_common_protocols(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct context c =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_=
multi, &amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,f=
lower:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    c=2Eoptions=2Eacc_protocols =3D &quot;power:flower:star&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(&amp;c=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(c=2Eoptions=2Ea=
cc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(c=2Eoptions=2Eacc_negotiated_p=
rotocols, &quot;flower:power&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_acc_send_message(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2E=
tls_multi, struct tls_multi, &amp;c=2Eoptions=2Egc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    c=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV=
_ACC=3D1400,A:6,flower:emergency:power&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    c=2Eoptions=2Eacc_protocols =3D &quot;power:f=
lower:emergency&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    determine_common_acc_protocols(&amp;c);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
tls_session *session =3D &amp;c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(&amp;c, c=2E=
c2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;EMERGENC=
Y BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(control_channel_mesage_sent,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DR=
ILL:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_messa=
ge(&amp;c, c=2Ec2=2Etls_multi, session, &quot;emergency&quot;, false,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E=
&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(control_channel_mesage_sent,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        &quot;ACC,emergency,=
65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* test a long message (&gt; 1000) with fragment=
 to get the maximum header size */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char long_message[1200] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        long_message[i] =3D (char)(&#39; &#39; + (i % =
95));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* last char of the message is a i and then=
 a \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(long_message[1023], &#39;i&#39;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1024], &#39;\0&#3=
9;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(&amp;=
c, c=2Ec2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           long_me=
ssage, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cc_len =3D =
strlen(control_channel_mesage_sent);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(control_channel_mesage_sent[cc_len - =
1], &#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *expected_start_cc =3D &quot;ACC,emergency,1024,AF, !\&quot;#$=
%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_memory_equal(control_channel_mesage_sent, expecte=
d_start_cc, sizeof(expected_start_cc));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/o=
penvpn/test_acc=2Eh</span><br><span>new file mode 100644</span><br><span>in=
dex 0000000=2E=2Ea64bab5</span><br><span>--- /dev/null</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             over a single TCP/UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc=2E,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_=
client_messages(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_parse_acc_parameters(void **state);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid test_acc_common_protocols(void **state);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void test_acc_send_message(void **state);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</s=
pan><br><span>index 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_common=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span=
> #define LargestIntegralType uintmax_t</span><br><span> #endif</span><br><=
span> /* redefine 2=2Ex API in terms of 1=2Ex API */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CMockaValueData             Largest=
IntegralType</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define c=
heck_expected_uint         check_expected</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define expect_uint_value           expect_value</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define expect_check_data   =
        expect_check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define cast_ptr_to_cmocka_value(x) (x)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CMockaValueData                       LargestInt=
egralType</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ch=
eck_expected_uint                   check_expected</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define expect_uint_value                   =
  expect_value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne expect_check_data                     expect_check</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x)      =
     (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ass=
ert_int_in_range(value, min, max)  assert_in_range((value), (min), (max))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_uint_i=
n_range(value, min, max) assert_in_range((value), (min), (max))</span><br><=
span> #endif</span><br><span> </span><br><span> /**</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/tes=
t_misc=2Ec</span><br><span>index a41c27b=2E=2E82292f1 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -40,11 +40,34 @@</span>=
<br><span> #include &quot;list=2Eh&quot;</span><br><span> #include &quot;mo=
ck_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> #ifdef _WIN32</span><br><span> #include &quot;win32-uti=
l=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &quot;test_schedule=2Eh&quot;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* extra mocks */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct context *c, str=
uct options *options, struct buffer *buf,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   uint64_t permission_mask, uint64_t=
 *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   struct env_set *es, bool is_update)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(struct c=
ontext *c, const char *str, msglvl_t msglevel)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    check_expected_ptr(str);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lookup_by_cid(stru=
ct multi_context *m, const unsigned long cid)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return *(m-&gt;instances);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span> </span><br><span> static void</span><=
br><span> test_compat_lzo_string(void **state)</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>index 887c492=2E=2Eaa639ff 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</span><br><span>=
 #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;openvp=
n=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* Mock function to be allowed to=
 include win32=2Ec which is required for</span><br><span>  * getting the te=
mp directory */</span><br><span> #ifdef _WIN32</span><br><span>@@ -86,6 +88=
,20 @@</span><br><span> {</span><br><span>     return;</span><br><span> }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_process(struct cont=
ext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Define a dummy dco cipher option to avoid linking against all th=
e DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * units */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers=
(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES-192-GCM:AE=
S-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* generated=
 using</span><br><span>  * openssl req -x509 -newkey ec -pkeyopt ec_paramge=
n_curve:secp384r1 -keyout - \</span><br><span>@@ -960,8 +976,11 @@</span><b=
r><span>         cmocka_unit_test(test_data_channel_known_vectors_epoch),</=
span><br><span>         cmocka_unit_test(test_data_channel_known_vectors_sh=
ortpktid),</span><br><span>         cmocka_unit_test(crypto_test_print_cert=
_details),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmo=
cka_unit_test(ssl_test_extract_peer_info)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(ssl_test_extract_peer_info),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_parse_=
client_messages),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_parse_acc_parameters),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_common_pro=
tocols),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_acc_send_message)</span><br><span>     };</span><br><spa=
n> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8=
ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--g+AIlqSRH2M=--


--===============2740916287631708672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2740916287631708672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2740916287631708672==--

