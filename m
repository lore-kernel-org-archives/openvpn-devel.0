Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF009606D82F
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jMYHqbFc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GYW1c5cp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GJkRBKlX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PwqT5D06
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=+cV4SEGRn9PJ8Ja6iboeNADp4wJnNVidTiyo/2LTo6s=; b=jMYHqbFcrxsgcuPCiIONggWzJy
	UeHIe9SJao0WiLQ1965tBbhcsLDAk4dou/0hw1TRKwoeHNTffaqyIv/dsFWY50J2WAbyyr035Javf
	yzuy3VJOXA0oGvtO9UbnjOuTFoLxsLmKXlR7eHq81XLfiZb5P30AXnUcS2RZc39RkFls=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODsj-000000001wT-1mSD;
	Tue, 03 Nov 2026 12:44:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODsT-000000001wA-3wnB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wqlrofaIn8LpcWKXciJ1LgLL++ijrkJl0NCaH2u88Ts=; b=GYW1c5cpyCz0sABRgV6T2aHZZY
 +9nDARaYLlqnzLQT+d2OIqiU0/48nkPq94jc2T+lrqdPtyX9AP0sQmnR3pxpZlJIi0PYQDkcfD9sI
 DIZ9u8bTkqgr1CDeFmn9B71ArBbSBnOt1geljxSLFqQECOOzSYR3tWHAxHzzhTUKwqBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wqlrofaIn8LpcWKXciJ1LgLL++ijrkJl0NCaH2u88Ts=; b=GJkRBKlXd+X/Ito0MtBpct1fTe
 AOArudRRTYR6yOP7F7N/fbYA+Crqb96ESE0JmqSvhSPRNUae2aKxQmcXhSM2IeKBh0X75PMcniW/K
 dA401sTCzdlDsSvhAJtB/Pw4Ub6HZAH+J5xrrxa8D9Z8o31Mnbcwck0tSuBj+qomz/2g=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODsH-000000002Og-3WQk for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:28 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so31158925e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793709859; x=1794314659; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wqlrofaIn8LpcWKXciJ1LgLL++ijrkJl0NCaH2u88Ts=;
 b=PwqT5D06+U477qV8HYKsWxsNmdv46FWBORa6/SRLbudjTCoEpZflb18oLxwZdG8BaL
 FhDXMK0jsDvKKj961jLyPvkmqHCUNcyzfw1w/T12u04MyBI/BPSTGa2zYqiuIArNL8LO
 jjMCeNEw4ql5PfhqWluZbV1RghDP5VTTvjBtn/Y4vHl2D1SbIxC8OUNB73rGJJHSB5zG
 lN90ucStLqOZo9HMi94Pf438BVlwHos67zwM68/RoLKFmLh/+S3IdmclLKyTGOb09gz5
 WcXjozwZgpWqZN6wKj7S5qZE4qFqEPjCpgxSDSF4nfIgl+oOy2WGzPjLWxMkv4l8sFTN
 CZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709859; x=1794314659;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqlrofaIn8LpcWKXciJ1LgLL++ijrkJl0NCaH2u88Ts=;
 b=oYQGHyPTgl7ObKbZJtkRP6JU2YX6R2jKc43OtIO4bC4rNY5P4+DpgUxRW6u51Y02l3
 WP36jt7NuSVwtwiUNy8HSMiJT8695Ew/V4BTdTiPQ5NjoPvJJyTDU0jGhjypN2GzePRA
 Stud8f4CX4kyW/zIax/GDoOOHMAXTReEc4iziW8aOqxEGwSe25mWuAq1a9PcMew8Kw3e
 ssnlbjffAGsRg9tbyfpBk5K50DzgEmVa3TjPOQ6xY3/EBqUkd/LJUEpLfGjTC2qJi0aa
 ZiLbaBmxz5l6JekNymrgEViIx8QRyUBUUv8YfE25ACsX/B+4ImD3qu+AEA1bwMTThhln
 OJmg==
X-Gm-Message-State: APuU4Z8VFugG9AxO/ECQxmYh1kx2jXSNR28CRIgSgYps1jaNaS9kdhvW
 oMw0inaycSuIYpDRSG4RdvSkjzyuRAXCBTSMHWY7+OAtZMdM0WbLWStuNsKwk0FA3uUU02OrJnO
 Sd1vPpK/THq5TCsee4v7tlYLCOB3aJRkL2EC+v2iUCePEpBbT0tv+501wzaT914QuCrzXyUdl2g
 181qmYSQ==
X-Gm-Gg: AYBFou2EdD76pO4MqpKwKlyDDr881Vw3GyBRutAJIwvLpqWTQZFqBQYNzapanU1v8w4
 hBSnsVetf9vJ3dNS0UivQBv2ooo8U36L0+KSvWAEHjDcf7sO9Ft4opymlu/6cB8M6u7ajP4g+Cx
 GzBZGY/wcb0hosLbiHuq5AhA/Gyq5sc8G8lYiLmLy7bZvElCAm18cfX4HvL/aUt4/pjqMq7vd8H
 6Cl/WPX7PbHMs0seT4/m4SaACcrUnszpeE+yxLabhDsC3sz4FNsIpjcMrJNf5niCfOWGk7STTOm
 kl4cqRKxZOmfbgKPMxA/97mTo2J7qUgSnMd69/hgVz9aE5uqrXun6uFNNDS72o8kwnJqjviPR3j
 27ul9w67ze7Y+PaL51gHHt/PSaSf4lxBt7czvf5kO6wcnOb4K8yjHdXdaH9MnHJ4XHYlx63YMXv
 gx7poe28xK70Vsw7oC3dE8JcxplPkP3Ts8zJm9t9wCew8bNXYOV0M5E+R/L7PiCh5T9f96i8iGp
 7GuKVPeuyf6/E5MJiXqoZ35/ZA6mJq1vW78pnDMv/0O0KNMWIV17+Cb0Q+D3Vj4Q1CE6xGAWm1M
 3rShrgltYnQotQU2kpKbN4aVbM7D79DV7hD6NGfzlGhjTIwnNj1kMKx4KZKB/88ZYc/rOflc/b8
 GqWUgxX3/M9ARHQ6mHlMRzGpDi+TeJZLSJmXD0TbezkKmymNMPRicPEDmK8wXQmVu8w+iGH1uxs
 te+ZskKSmL5bu7oc7AukeeEAGYOdTpxeSKrLU=
X-Received: by 2002:a05:600c:138c:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4ac18c740c5mr284585145e9.25.1793709859152; 
 Tue, 03 Nov 2026 04:44:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78c10sm24555425f8f.25.2026.11.03.04.44.18
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:44:18 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:44:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
X-Gerrit-Change-Number: 2107
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2107?usp=email>
X-Gerrit-Commit: 97b46b03aedaa8ebd563c76bc47a2f49daae61d5
References: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkkzNjQzMGJhYjg5N2U1ZmU5YjFjZmQ0OGRlNTAyMjQzOTVkNTZkOGZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b7db974a92459d4985a24dcc3fc0cedc1984b7bc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xODsH-000000002Og-3WQk
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4306367909473551721=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4306367909473551721==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G45YoSsCG8k="; charset=UTF-8

--G45YoSsCG8k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2107?usp=3Demail )


Change subject: Provide minimal =
netlink defines for cppcheck on FreeBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Provide minimal netlink defines for c=
ppcheck on FreeBSD and macOS

Without these defines and the hidden goto ins=
ide the NLA_PUT functions
cppcheck complains about ret in dco_linux=2Ec=2E =
This allows to run
cppcheck on macOS and FreeBSD without triggering these w=
arnings=2E

Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
Signed-off=
-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A dev-tools/openvpn-cppcheck-net=
link=2Ecfg
M dev-tools/run-cppcheck=2Esh
2 files changed, 10 insertions(+),=
 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/07/2107/1

diff --git a/dev-tools/openvpn-cppcheck-netlink=2Ecfg=
 b/dev-tools/openvpn-cppcheck-netlink=2Ecfg
new file mode 100644
index 0000=
000=2E=2Eb63adf0
--- /dev/null
+++ b/dev-tools/openvpn-cppcheck-netlink=2Ec=
fg
@@ -0,0 +1,7 @@
+<?xml version =3D"1=2E0"?>
+<def>
+  <!-- minimal defin=
es to supress the errors on non-Linux platforms that do not have the netlin=
k headers -->
+  <define name=3D"NLA_PUT(msg, attrtype, attrlen, data)" val=
ue=3D"if (nla_cppcheck_dummy(msg, attrtype, attrlen, data) < 0) goto nla_pu=
t_failure;" />
+  <define name=3D"NLA_PUT_U32(msg, attrtype, value)" value=
=3D"NLA_PUT(msg, uint32_t, attrtype, value)" />
+  <define name=3D"NLA_PUT_=
STRING(msg, attrtype, value)" value=3D"NLA_PUT(msg, attrtype, (int) strlen(=
value) + 1, value)" />
+</def>
diff --git a/dev-tools/run-cppcheck=2Esh b/d=
ev-tools/run-cppcheck=2Esh
index d1c22c5=2E=2Edebcd46 100755
--- a/dev-tool=
s/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -20,9 +20,11 @@
 i=
f [ $(uname) =3D "Darwin" ] || [ $(uname) =3D "FreeBSD" ]; then
     SCRIPT=
_DIR=3D$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
     num_procs=3D$(sys=
ctl -n hw=2Encpu)
+    EXTRA_LIBRARY=3D"--library=3D${SCRIPT_DIR}/openvpn-c=
ppcheck-netlink=2Ecfg"
 else
     SCRIPT_DIR=3D$(dirname $(readlink -e "${B=
ASH_SOURCE[0]}"))
     num_procs=3D$(nproc)
+    EXTRA_LIBRARY=3D""
 fi
 : =
${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$PWD}
@@ -35,6 +37,7 =
@@
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
  --enable=3Dall ${disable_ar=
g} \
  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \
+ ${EXTRA=
_LIBRARY} \
  --library=3Dopenssl=2Ecfg \
  --suppress-xml=3D${SCRIPT_DIR}/=
cppcheck-suppressions=2Exml --inline-suppr \
  --cppcheck-build-dir=3D${CPP=
CHECK_DIR} \

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2107?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
change
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I364=
30bab897e5fe9b1cfd48de50224395d56d8fc
Gerrit-Change-Number: 2107
Gerrit-Pat=
chSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--G45YoSsCG8k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2107?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Provide minimal netlink defines for cppcheck on FreeBSD and ma=
cOS<br><br>Without these defines and the hidden goto inside the NLA_PUT fun=
ctions<br>cppcheck complains about ret in dco_linux=2Ec=2E This allows to r=
un<br>cppcheck on macOS and FreeBSD without triggering these warnings=2E<br=
><br>Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc<br>Signed-off-by:=
 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A dev-tools/openvpn-cppc=
heck-netlink=2Ecfg<br>M dev-tools/run-cppcheck=2Esh<br>2 files changed, 10 =
insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/2107/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/dev-tools/openvpn-cppcheck-netlink=2Ecfg b/dev-tools/openvpn-cppcheck-ne=
tlink=2Ecfg</span><br><span>new file mode 100644</span><br><span>index 0000=
000=2E=2Eb63adf0</span><br><span>--- /dev/null</span><br><span>+++ b/dev-to=
ols/openvpn-cppcheck-netlink=2Ecfg</span><br><span>@@ -0,0 +1,7 @@</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+&lt;?xml version =3D&quot;1=
=2E0&quot;?&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;=
def&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- mi=
nimal defines to supress the errors on non-Linux platforms that do not have=
 the netlink headers --&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;define name=3D&quot;NLA_PUT(msg, attrtype, attrlen, data)&quo=
t; value=3D&quot;if (nla_cppcheck_dummy(msg, attrtype, attrlen, data) &lt; =
0) goto nla_put_failure;&quot; /&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;define name=3D&quot;NLA_PUT_U32(msg, attrtype, value=
)&quot; value=3D&quot;NLA_PUT(msg, uint32_t, attrtype, value)&quot; /&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&=
quot;NLA_PUT_STRING(msg, attrtype, value)&quot; value=3D&quot;NLA_PUT(msg, =
attrtype, (int) strlen(value) + 1, value)&quot; /&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+&lt;/def&gt;</span><br><span>diff --git a=
/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>=
index d1c22c5=2E=2Edebcd46 100755</span><br><span>--- a/dev-tools/run-cppch=
eck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>=
@@ -20,9 +20,11 @@</span><br><span> if [ $(uname) =3D &quot;Darwin&quot; ] =
|| [ $(uname) =3D &quot;FreeBSD&quot; ]; then</span><br><span>     SCRIPT_D=
IR=3D$(dirname $(readlink -f &quot;${BASH_SOURCE[0]}&quot;))</span><br><spa=
n>     num_procs=3D$(sysctl -n hw=2Encpu)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    EXTRA_LIBRARY=3D&quot;--library=3D${SCRIPT_DIR}/o=
penvpn-cppcheck-netlink=2Ecfg&quot;</span><br><span> else</span><br><span> =
    SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))</s=
pan><br><span>     num_procs=3D$(nproc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    EXTRA_LIBRARY=3D&quot;&quot;</span><br><span> fi</s=
pan><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}</span><br><span> : ${B=
UILD_DIR:=3D$PWD}</span><br><span>@@ -35,6 +37,7 @@</span><br><span>  -I${B=
UILD_DIR} -I${BUILD_DIR}/include/ \</span><br><span>  --enable=3Dall ${disa=
ble_arg} \</span><br><span>  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-lib=
rary=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ ${EXTR=
A_LIBRARY} \</span><br><span>  --library=3Dopenssl=2Ecfg \</span><br><span>=
  --suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-suppr=
 \</span><br><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2107?usp=3Demail">change 2107</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2107?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newc=
hange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 2107 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--G45YoSsCG8k=--


--===============4306367909473551721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4306367909473551721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4306367909473551721==--

