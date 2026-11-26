Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333A606A326
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ebZbpLtm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SZbN1rCF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DuB5gJP2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AfgNNK4+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+FsDkHfaWTciEd6RU95o9pCrIrtjK/lHsEGWzNrk1m0=; b=ebZbpLtmAYjn7yu5MaQqZh56vC
	YGXugepXaFSVmTObhn0hRQeNzvokF4KHqp4NLQXH1QopERpYfl7286ljU7e94G1qgQ4Wq7KXxa+hr
	J42MKIUfTC0xE0PwRYayJN0xTvFOAJbmvJ+TqSDB3l9bxs0LbHqYCsvwIWW6V5sROAHU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXhI-0000000077R-0qiz;
	Thu, 26 Nov 2026 11:31:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXhG-0000000077I-3pue
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=txHmNSc3wuMC79Xq1WgMbmJzPC0l2S8E9W9hKifiLvg=; b=SZbN1rCFA43vYgVK5a17otQ1bc
 p9TNAWt/iikXA+WKXudLHo886jxFajrM5gNqdEuy5vKZia0rmlWjiy19FwhGkvjo1D8Xa07tfTE2k
 Sc0ai9jz+G4SMOfcPlcWBsvvcXyg0c4mxjitq5eQCU9f4Bqo6Shz+GG46dnEAZpDmfSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=txHmNSc3wuMC79Xq1WgMbmJzPC0l2S8E9W9hKifiLvg=; b=DuB5gJP2bwAm8rz3+7wnWmWVeA
 jav4IbG2yIx24T3SGTR9waW+EAmV2mbBhTcZVP1Vi47XwT2J2PTbB7zfWWcDQxpzq/yXcdDv11hbV
 g1Hs4gJMVDjacqqPu9QHa17tJC32gG2/VgaBMEhG3uahCaf70UhfQ2lIrHr06q6c2moI=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXhF-000000000Tn-0u5k for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:31:26 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e47347279so4189686f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795692679; x=1796297479; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=txHmNSc3wuMC79Xq1WgMbmJzPC0l2S8E9W9hKifiLvg=;
 b=AfgNNK4+eq4Do4ZdqMF2tHgw9sgx7paO1FThQXXICOZ1LqtNIxmulWJavgmV00oJI5
 9jnRelwBR6cR3WNeuIHFvLYAykkul8ZAQE4zbbMm4bO67EGvhhLBlYJx+h18tV8AECwL
 FeRwZvEYH43q8q0UGdI/1gFYxujhICgdKf/WbumHHZ9Mdf0ruw19CeEbFy4kUMZ1rkSD
 HrbQGnjDNpM9jNqQTO4f6FSjk26uW+BOhg9nomwMkb60vU8W5WLytcOXPIE48+idmUuI
 yskBLKlIHbE+RF+OJtLSULj9Zoa7hkVJIiYSfw03I9oudNbbOpH5af51HltcMG2wqJXb
 2Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795692679; x=1796297479;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=txHmNSc3wuMC79Xq1WgMbmJzPC0l2S8E9W9hKifiLvg=;
 b=raUC+9FfmwkTAtE1jYhg/mFG3wnsKh0r92zTKliA+FhQjVXeq20fKzB8eE6rfmGAaj
 Ev8j0wVSBXXvdlU4OSg8nN1gz08e/fZoedio7GOmdIuNcO3KGFuuKAGXa6kP37rwEmrE
 BV4lBnlsZ3pJ1+/SCO1cqMvV6o0qlwkANgaAo7vbtY+GiqyCrge0+hztYuo4Hr/6kjfC
 BPKBE8Tig44B9f6L10SP5g78TLUBYK3hR/w+fYduihWQRGlv8t1pkcp79gmbsXdc159j
 P3v4Z01Sy4hFaHFBYhQmUORmuFyXwWgZvBXfW7IAM92MXH0wUH4+XQL9gQjjrTTVz4Lq
 WOsg==
X-Gm-Message-State: APuU4Z/DQddOTChgSh35zN19K4R9rV6jA7HmtNFmEwvN6R4CnfuuQQgU
 /Qmouby9ZGjhB+NzVwRhYHDZzsrXQY9mYqysMiOlNAOsvUKE4s4stK22PAaWd8iPi0k4TdT4XoB
 8jmswc4qQzskuoLPL+LsBshMGjxXGxwJifB4ZTSihc2zqly8ljygDUg6NRfnqEdNUIJWi
X-Gm-Gg: AZFdTZely6a2CkFIimL/TT8cRhqlBuRjFBFGYXQYS3ag5gw8LaoU7hRADY36tmvGr6k
 4SGD3Qc6A1pHGJxYY0QvW4Utk+7YHdxYN4ioPTvc//q/XEUVq4yer8EK3ca3K/gcLQDNR+Uey+I
 HKvxXx/IP2CE6CJiawV1bTuyOvB5lpxPkctsLA8E1HRNUAI7cnuNg6p78wh0z39GEzwPGD/S4Vz
 Gsj+5fjsbM/I0BG2GUXfQqK6kWc30WU1Fj/9+zU43zKrWHxZ+dsi3cVNQCmWmA42l3IkYXYRwun
 BVPRQa8BI1eY7BneH42JV1/xycZmXi2fhg4ux6HzrdN9gvOzFkbPZRfTeg1mJG0fxSQG3xQgSOb
 pkrKrIUD64/LelnhzUtITEW+BrdkSGkFQ5N9HYvmxJXVghzVvASGfExWQnoOlS5fqVWA/UA3tpq
 /TeiJZaeMsesKUk1gczy0uisvn4VP+Qi5qUxsLbzWlc9jpLdKji7pGsp3T4rQD4mHJMRwQZYZ7+
 E61uk2uA+fcs6gIqC6KiYb+Ozn8woKqhBxqIpcWiTt13seUOQ3PQJ0usTzn88IfLd3fUoWEHA7f
 +2BHbF0U2bgzko1XfcYSyBipZmkT2aTHOdTJtv6rj/mZiAjshfAZlzSViBNlGhQQs+nLOcsc4XK
 YfGVfIQHzgeLHAxrlI5hg2pz64jdZgGaR8mG96Gt5Nl5okmUYX4t5ZmXKi5gbpFcyZq/WlKwAYa
 /m3EhFGxKxZHrMKk4=
X-Received: by 2002:adf:e00e:0:10b0:4a7:e4c7:2775 with SMTP id
 ffacd0b85a97d-4abb759e42emr27481762f8f.45.1795692678402; 
 Thu, 26 Nov 2026 03:31:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dcf9sm39596210f8f.32.2026.11.26.03.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:31:18 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:31:17 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
X-Gerrit-Change-Number: 2343
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2343?usp=email>
X-Gerrit-Commit: c485c4e1ed95d790c2b9e3e4adf1068703e64ea4
In-Reply-To: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
References: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjEzOTAzMDAwLkk4ZDA4MWM4N2FmMGQ3NDZhNWUzYTIzODI1NjdmMDQzMzI2Mzk2MjJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75f78f021d691ea4110324b88f0fe2c13c1d55f8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWXhF-000000000Tn-0u5k
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Add more
 printf-style functions
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3177970072804040828=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3177970072804040828==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CTQOhMJdI6o="; charset=UTF-8

--CTQOhMJdI6o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
343?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: cppcheck: Add more p=
rintf-style functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

cppcheck: Add more printf-style functions

Also fix the two issu=
es raised by this=2E

Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
=
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2343
Message-Id: <20261125151936=2E10270-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41936=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M dev-tools/openvpn-cppcheck-library=2Ecfg
M dev-tools/openvpn-c=
ppcheck-windows=2Ecfg
M src/openvpn/networking_iproute2=2Ec
M src/openvpnse=
rv/interactive=2Ec
4 files changed, 14 insertions(+), 2 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/2343/2

d=
iff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cp=
pcheck-library=2Ecfg
index 0537b39=2E=2E37195d8 100644
--- a/dev-tools/open=
vpn-cppcheck-library=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg
@=
@ -6,6 +6,12 @@
       <formatstr />
     </arg>
   </function>
+  <functio=
n name=3D"argv_printf">
+    <formatstr type=3D"printf"/>
+    <arg nr=3D"2=
">
+      <formatstr />
+    </arg>
+  </function>
   <function name=3D"buf=
_printf">
     <formatstr type=3D"printf"/>
     <arg nr=3D"2">
diff --git =
a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-win=
dows=2Ecfg
index 932d586=2E=2Edca2b07 100644
--- a/dev-tools/openvpn-cppche=
ck-windows=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg
@@ -2,6 +2,=
12 @@
 <!-- Only used for the Windows run=2E Can't be in openvpn-cppcheck-l=
ibrary=2Ecfg
      because it conflicts with gnu=2Ecfg=2E -->
 <def>
+  <fu=
nction name=3D"MsgToEventLog">
+    <formatstr type=3D"printf"/>
+    <arg =
nr=3D"2">
+      <formatstr />
+    </arg>
+  </function>
   <!-- MinGW use=
s GCC, so we need to handle GCC builtins=2E gnu=2Ecfg has these,
        bu=
t we do not load it for Windows=2E Without this cppcheck does not
        u=
nderstand our likely()/unlikely() macros=2E -->
diff --git a/src/openvpn/ne=
tworking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index 6c4c8f4=
=2E=2Eb079757 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/op=
envpn/networking_iproute2=2Ec
@@ -112,7 +112,7 @@
 {
     struct argv argv =
=3D argv_new();
 
-    argv_printf(&argv, "%s link set dev %s up mtu %d", i=
proute_path, iface, mtu);
+    argv_printf(&argv, "%s link set dev %s up mt=
u %u", iproute_path, iface, mtu);
     argv_msg(M_INFO, &argv);
     openvp=
n_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set failed");
 
diff=
 --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
=
index bddaf86=2E=2E77b91e0 100644
--- a/src/openvpnserv/interactive=2Ec
+++=
 b/src/openvpnserv/interactive=2Ec
@@ -459,7 +459,7 @@
     size =3D bytes =
/ sizeof(*data);
     if ((size =3D=3D 0) || (size > 4096)) /* our startup =
data is 1024 wchars at the moment */
     {
-        MsgToEventLog(M_SYSERR=
, L"malformed startup data: %lu bytes received", size);
+        MsgToEvent=
Log(M_SYSERR, L"malformed startup data: %zu bytes received", size);
       =
  ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);=

         goto err;
     }

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2343?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
Gerrit-Change-Number:=
 2343
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--CTQOhMJdI6o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2343?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">cppcheck: Add more printf-style functions<br><br>Also fix the two issue=
s raised by this=2E<br><br>Change-Id: I8d081c87af0d746a5e3a2382567f04332639=
622a<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br=
>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343<br>Message-Id: &lt;20261125151=
936=2E10270-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41936=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/o=
penvpn-cppcheck-library=2Ecfg<br>M dev-tools/openvpn-cppcheck-windows=2Ecfg=
<br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpnserv/interactive=
=2Ec<br>4 files changed, 14 insertions(+), 2 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
43/2343/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/d=
ev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>index 0537b39=2E=2E=
37195d8 100644</span><br><span>--- a/dev-tools/openvpn-cppcheck-library=2Ec=
fg</span><br><span>+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br=
><span>@@ -6,6 +6,12 @@</span><br><span>       &lt;formatstr /&gt;</span><b=
r><span>     &lt;/arg&gt;</span><br><span>   &lt;/function&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;function name=3D&quot;argv=
_printf&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;formatstr type=3D&quot;printf&quot;/&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;arg nr=3D&quot;2&quot;&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      &lt;formatstr /&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;/arg&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/function&gt;</span><br>=
<span>   &lt;function name=3D&quot;buf_printf&quot;&gt;</span><br><span>   =
  &lt;formatstr type=3D&quot;printf&quot;/&gt;</span><br><span>     &lt;arg=
 nr=3D&quot;2&quot;&gt;</span><br><span>diff --git a/dev-tools/openvpn-cppc=
heck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><sp=
an>index 932d586=2E=2Edca2b07 100644</span><br><span>--- a/dev-tools/openvp=
n-cppcheck-windows=2Ecfg</span><br><span>+++ b/dev-tools/openvpn-cppcheck-w=
indows=2Ecfg</span><br><span>@@ -2,6 +2,12 @@</span><br><span> &lt;!-- Only=
 used for the Windows run=2E Can&#39;t be in openvpn-cppcheck-library=2Ecfg=
</span><br><span>      because it conflicts with gnu=2Ecfg=2E --&gt;</span>=
<br><span> &lt;def&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;function name=3D&quot;MsgToEventLog&quot;&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &lt;formatstr type=3D&quot;printf&qu=
ot;/&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;arg=
 nr=3D&quot;2&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      &lt;formatstr /&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;/arg&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;/function&gt;</span><br><span>   &lt;!-- MinGW uses GCC, so we=
 need to handle GCC builtins=2E gnu=2Ecfg has these,</span><br><span>      =
  but we do not load it for Windows=2E Without this cppcheck does not</span=
><br><span>        understand our likely()/unlikely() macros=2E --&gt;</spa=
n><br><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/=
networking_iproute2=2Ec</span><br><span>index 6c4c8f4=2E=2Eb079757 100644</=
span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>++=
+ b/src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -112,7 +112,7 @@=
</span><br><span> {</span><br><span>     struct argv argv =3D argv_new();</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
rgv_printf(&amp;argv, &quot;%s link set dev %s up mtu %d&quot;, iproute_pat=
h, iface, mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
argv_printf(&amp;argv, &quot;%s link set dev %s up mtu %u&quot;, iproute_pa=
th, iface, mtu);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><b=
r><span>     openvpn_execve_check(&amp;argv, ctx-&gt;es, S_FATAL, &quot;Lin=
ux ip link set failed&quot;);</span><br><span> </span><br><span>diff --git =
a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><=
br><span>index bddaf86=2E=2E77b91e0 100644</span><br><span>--- a/src/openvp=
nserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec=
</span><br><span>@@ -459,7 +459,7 @@</span><br><span>     size =3D bytes / =
sizeof(*data);</span><br><span>     if ((size =3D=3D 0) || (size &gt; 4096)=
) /* our startup data is 1024 wchars at the moment */</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLo=
g(M_SYSERR, L&quot;malformed startup data: %lu bytes received&quot;, size);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventL=
og(M_SYSERR, L&quot;malformed startup data: %zu bytes received&quot;, size)=
;</span><br><span>         ReturnError(pipe, ERROR_STARTUP_DATA, L&quot;Get=
StartupData&quot;, 1, &amp;exit_event);</span><br><span>         goto err;<=
/span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail">change 2343</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8d081c87=
af0d746a5e3a2382567f04332639622a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2343 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--CTQOhMJdI6o=--


--===============3177970072804040828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3177970072804040828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3177970072804040828==--

