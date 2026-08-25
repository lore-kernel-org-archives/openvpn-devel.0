Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E318C61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z0r68xWLU7i8rqXe0HUzudbQiLrknwXcrnpZHvB5dUg=; b=bi4f1t0ADA4kKyN/VDbl08x6bT
	+H2tXa0yfkWJzmHLLjZOxNbmqi5x8QrI++1bfeGlV0Q1kVAKBYe+s4WgCZeOFDP0kBWIZioIHqoVE
	ud8PB2eQLUrADtTaxuhnUMPdXSMY6NYkXGj7hhpZwUwb0rm7EbyXskgGIQJXlpqRdhLg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wym66-0004k5-9K;
	Tue, 25 Aug 2026 08:01:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wym64-0004jy-38
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X3Dyty1QszB6UjlmLXTZVBjlcRa86C9K4kPJvUpxw2c=; b=GayAN7NfhmspfNL1yGjOQCslC+
 zf1JvAECEC49bw7DY75tYQZ3NIisJFRyXsQSNxtPWIiNh3CCWxTDhlXoWhuu34F6iBT8iLO4aRk+4
 cEvIL9mgJF+gRWTYUSuTT9hQFdKyGZ2yJmhRbjhsMdv3bqd8FZxXKWyfJolVCV+tFiMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X3Dyty1QszB6UjlmLXTZVBjlcRa86C9K4kPJvUpxw2c=; b=b
 ewpejKWyGmPaWfYKadkVmuwleINOgnazbz5iBubci0vsnl7UQniNPuHngMUsIu1kT4uZ97yPDgC93
 gBHJMUXe/8WQp0/2g7VZAXB2MsXXVM2MMhGofHvSBu7485twoy7L1zQIRUebobwMkbEyr33LXSS0m
 ZfPGeuwJvD/osyuQ=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wym5v-0001OP-R6 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:01:28 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so8236031a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787644873; x=1788249673; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X3Dyty1QszB6UjlmLXTZVBjlcRa86C9K4kPJvUpxw2c=;
 b=VzZprkWJ3lnLgMNNf72u9+fY1bDqr0CdLp5LuivqbX88oD7/cQJ6aVxFW4IJwFjXqN
 taMVt2YPj7zQC1HTiIW2Vi9iJtnXztqI+FXaodSaUw39DPXGu2kBCs1q2OEbjMF91v9e
 DESryIiSEyEt0/T/d8JqokL3cjj4vyIyLlqHgza2m8bYPJ/VRX/vlvLAmXS3d/OWm080
 cfD4pXTNSVYaNW0Vz9ZkFpiyxGSBKkddqxsLJhKEtKvUBNjBF/O4kDjvfxnfYmUepzkT
 ZY1sUgQZ+/sZKV3HpPDhYb+0rTXZKkeCv5MCbay1RFk8VMUq0236TMJTd/4AdDtHDO1u
 hKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787644873; x=1788249673;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X3Dyty1QszB6UjlmLXTZVBjlcRa86C9K4kPJvUpxw2c=;
 b=Pe1BEhYhx07fX+OlL3xcmwDIfzEcWbdey7nYGk7fNYfgOp0ANVED7plR0gfjXOOR3y
 YhpuuQ5EbQC2/9khQeRQCm7VA94IZrcMBE/QP6z1NDABphXrkapcbadqJ6w+tCP0Km9t
 tlCxS1DR72V5eFsESspDh6x1BR5vGUVcdvlUc5H183ENMWvJ6j4baGXsFOPwn6rrgrlI
 /YVni0WDPRXv/XJ8UKRHeqYK9h9pzq4zFIqJO0xCY7sbXj4BOgFpjIHSWS+rYHgac3NX
 TyDXqaIPG+u+7pfWMW1lFFwiMMOlMDGCMMwdf9sssjwyrAz9AevxmDucaxtRIuHgL2x8
 7izw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2nI1mR+5cCBYaIdc2hqYNkfLWjrVFwa4IPHTDF2SsK7EJgsjyTv9d53D4JTwk+fBtPeCb8q2q6+WggGR9@lists.sourceforge.net
X-Gm-Message-State: AFuF++lBlMzZvoXP17zDM1bOBLmf1Sgm732Xx7+gxHS5gNOAyPFEmgJK
 82Y2cYpddOOZ3ypBAHoo0h3ERwjE+nvqZgS/0bbdnkpIWbNpnym4bBICYZdMrCXAbnSG7TiHh8u
 S8rBzHzNpEXPhLk7X3hHTpzZuqHTaKX5/X+60qREchUqICTkE5+Orl4vDqSyh6CXbbBL2
X-Gm-Gg: AR+sD13dvLS0xTZLjXdbbrAo+L9oH3Er4lc40oV+VajTLYhIkW29cjFc9Ir4f6MpO30
 agKrjX0nP8pU+NqAlzEDELJm/YrJVGH3/ogzkvZY+4H5khCkR7JFkAzvKUIu2pGDLf5GGMo5UQu
 FBkxcup/XI0E0bDSCO6t7BUX409JjNeZRA8I/Ai0tcGRHySPH+RwRtUvjeDIYcbBHuYuR5dO8ej
 a3GojXiTY2phldw4fL305TmnMz2fiG3F8gCVRWX8ACbX8fBsWvOAiazFxXq9qDkMut8BWBhswCo
 hZKUxvgEzPr8CUkhKFHK4FzVJt9AbVLIx/eXrCweyWF6kk1I25xPdQhaoXAPYrwihF/aLYA+Y38
 CkUCBriOjN0k8ePoHXbV2IbwyVmaIMuXmzzUm9gM2c9yDBmzmR5AVyoOxhcDvEBzw7zVwmC/FQx
 p3g2qnzpG5W7gL67zTdP5OOFs9ZaXuYdAnpl5igi4WfEVFlF3gYAzkeaDx/bqrKmsfsl5KFeJzi
 6BJy50dkndmzzJxRxeOG4p6dJiwxMJkpObG1OUrFP3mRgnXUEKlv3s0LInG2giZme51YdnIYrli
 HLBjA7wPLNihnZuYJORjjCuatjbN/47o/hAk+V5I0Jae51n28mI=
X-Received: by 2002:a17:906:7949:b0:c21:8191:12cc with SMTP id
 a640c23a62f3a-c24e6027fcemr468479466b.22.1787644871605; 
 Tue, 25 Aug 2026 01:01:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685ef7bsm1924714766b.52.2026.08.25.01.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 01:01:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 08:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
X-Gerrit-Change-Number: 1661
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1661?usp=email>
X-Gerrit-Commit: a82c1ecde0fbeb1a9626e5f41914b2e468137998
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDEzNjAxMDAwLkkyYjcxZGFlMzdlYmU2M2MyNmE2Njc2MWY4NzdiMjVkMzI2ZWQxNDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9562da74d5ac7aa9badf500db3a2b6fd11ea5623-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wym5v-0001OP-R6
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1220035809521219894=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1220035809521219894==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tRQOz3FJOGg="; charset=UTF-8

--tRQOz3FJOGg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1661?usp=3Demail )

Change subject: Remove instances of constVariable/c=
onstVariablePointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Remove instances of constVariable/constVariablePo=
inter cppcheck warnings

Of varied usefulness, but easier to just address a=
ll of
them=2E

Also change vpn_* parameters of dco_new_peer to const since
=
that is required by one of the changes and it works (and would
happen anywa=
y when doing constParameterPointer)=2E

Change-Id: I2b71dae37ebe63c26a66761=
f877b25d326ed140f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1661
Message-Id: <20260824162651=2E3228-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38646=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M sample/sample-=
plugins/defer/multi-auth=2Ec
M sample/sample-plugins/log/log=2Ec
M sample/s=
ample-plugins/log/log_v3=2Ec
M sample/sample-plugins/simple/simple=2Ec
M sr=
c/openvpn/argv=2Ec
M src/openvpn/auth_token=2Ec
M src/openvpn/base64=2Ec
M =
src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/comp-lz4=2Ec
=
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/crypt=
oapi=2Ec
M src/openvpn/dco=2Ec
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/=
dco_internal=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M sr=
c/openvpn/dns=2Ec
M src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/o=
penvpn/init=2Ec
M src/openvpn/list=2Ec
M src/openvpn/manage=2Ec
M src/openv=
pn/misc=2Ec
M src/openvpn/mss=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=
=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openv=
pn/options=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/options_util=
=2Ec
M src/openvpn/pool=2Ec
M src/openvpn/proxy=2Ec
M src/openvpn/push=2Ec
=
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M=
 src/openvpn/ssl=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_verify=
=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/win32=2Ec
M src/openvpnmsica/msica=
_arg=2Ec
M src/openvpnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactive=
=2Ec
M src/plugins/auth-pam/auth-pam=2Ec
M src/tapctl/main=2Ec
M tests/unit=
_tests/openvpn/test_buffer=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M=
 tests/unit_tests/openvpn/test_cryptoapi=2Ec
M tests/unit_tests/openvpn/tes=
t_misc=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
M tests/unit_tests/plugi=
ns/auth-pam/test_search_and_replace=2Ec
56 files changed, 163 insertions(+)=
, 164 deletions(-)




diff --git a/dev-tools/cppcheck-suppression b/dev-to=
ols/cppcheck-suppression
index 2e3350b=2E=2E900e03c 100644
--- a/dev-tools/=
cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -3,8 +3,6 @@
 =
constParameter
 constParameterCallback
 constParameterPointer
-constVariabl=
e
-constVariablePointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_ui=
nt
 usleepCalled
diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/=
sample/sample-plugins/defer/multi-auth=2Ec
index f6bbf44=2E=2Ebacf557 10064=
4
--- a/sample/sample-plugins/defer/multi-auth=2Ec
+++ b/sample/sample-plug=
ins/defer/multi-auth=2Ec
@@ -381,7 +381,7 @@
     }
     const char **argv =
=3D args->argv;
     const char **envp =3D args->envp;
-    struct plugin_c=
ontext *context =3D (struct plugin_context *)args->handle;
+    const struc=
t plugin_context *context =3D (struct plugin_context *)args->handle;
     s=
truct plugin_per_client_context *pcc =3D
         (struct plugin_per_client=
_context *)args->per_client_context;
     switch (args->type)
@@ -399,7 +39=
9,7 @@
 OPENVPN_EXPORT void *
 openvpn_plugin_client_constructor_v1(openvpn=
_plugin_handle_t handle)
 {
-    struct plugin_context *context =3D (struct=
 plugin_context *)handle;
+    const struct plugin_context *context =3D (st=
ruct plugin_context *)handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_=
plugin_client_constructor_v1");
     return calloc(1, sizeof(struct plugin_=
per_client_context));
 }
@@ -407,7 +407,7 @@
 OPENVPN_EXPORT void
 openvpn_=
plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *per_clien=
t_context)
 {
-    struct plugin_context *context =3D (struct plugin_contex=
t *)handle;
+    const struct plugin_context *context =3D (struct plugin_co=
ntext *)handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_=
destructor_v1");
     free(per_client_context);
 }
diff --git a/sample/samp=
le-plugins/log/log=2Ec b/sample/sample-plugins/log/log=2Ec
index 330e3e0=2E=
=2E76350ee 100644
--- a/sample/sample-plugins/log/log=2Ec
+++ b/sample/samp=
le-plugins/log/log=2Ec
@@ -173,7 +173,7 @@
 openvpn_plugin_func_v1(openvpn_=
plugin_handle_t handle, const int type, const char *argv[],
               =
         const char *envp[])
 {
-    struct plugin_context *context =3D (st=
ruct plugin_context *)handle;
+    const struct plugin_context *context =3D=
 (struct plugin_context *)handle;
 
     show(type, argv, envp);
 
diff --g=
it a/sample/sample-plugins/log/log_v3=2Ec b/sample/sample-plugins/log/log_v=
3=2Ec
index d2d44c7=2E=2E09c6735 100644
--- a/sample/sample-plugins/log/log=
_v3=2Ec
+++ b/sample/sample-plugins/log/log_v3=2Ec
@@ -245,7 +245,7 @@
 ope=
nvpn_plugin_func_v3(const int version, struct openvpn_plugin_args_func_in c=
onst *args,
                        struct openvpn_plugin_args_func_return =
*retptr)
 {
-    struct plugin_context *context =3D (struct plugin_context =
*)args->handle;
+    const struct plugin_context *context =3D (struct plugi=
n_context *)args->handle;
 
     printf("\nopenvpn_plugin_func_v3() :::::>>=
 ");
     show(args->type, args->argv, args->envp);
diff --git a/sample/sam=
ple-plugins/simple/simple=2Ec b/sample/sample-plugins/simple/simple=2Ec
ind=
ex 687a633=2E=2E3182be0 100644
--- a/sample/sample-plugins/simple/simple=2E=
c
+++ b/sample/sample-plugins/simple/simple=2Ec
@@ -104,7 +104,7 @@
 openvp=
n_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char=
 *argv[],
                        const char *envp[])
 {
-    struct plugin=
_context *context =3D (struct plugin_context *)handle;
+    const struct pl=
ugin_context *context =3D (struct plugin_context *)handle;
 
     /* get us=
ername/password from envp string array */
     const char *username =3D get=
_env("username", envp);
diff --git a/src/openvpn/argv=2Ec b/src/openvpn/arg=
v=2Ec
index 6a5d92e=2E=2E028671d 100644
--- a/src/openvpn/argv=2Ec
+++ b/sr=
c/openvpn/argv=2Ec
@@ -359,7 +359,7 @@
      *
      */
     size_t argc =
=3D argres->argc;
-    char *f =3D argv_prep_format(format, delim, &argc, &=
argres->gc);
+    const char *f =3D argv_prep_format(format, delim, &argc, =
&argres->gc);
     if (f =3D=3D NULL)
     {
         goto out;
diff --git =
a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index bd90212=2E=
=2Ef928a41 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_t=
oken=2Ec
@@ -235,7 +235,7 @@
      * a new token with the empty username si=
nce we do not want to loose
      * the information that the username canno=
t be trusted
      */
-    struct key_state *ks =3D &multi->session[TM_ACTI=
VE]=2Ekey[KS_PRIMARY];
+    const struct key_state *ks =3D &multi->session[=
TM_ACTIVE]=2Ekey[KS_PRIMARY];
     if (ks->auth_token_state_flags & AUTH_TO=
KEN_VALID_EMPTYUSER)
     {
         hmac_ctx_update(ctx, (const uint8_t *)=
"", 0);
diff --git a/src/openvpn/base64=2Ec b/src/openvpn/base64=2Ec
index =
7af8976=2E=2E5752844 100644
--- a/src/openvpn/base64=2Ec
+++ b/src/openvpn/=
base64=2Ec
@@ -161,7 +161,7 @@
 {
     const char *p;
     unsigned char *q=
;
-    unsigned char *e =3D NULL;
+    const unsigned char *e =3D NULL;
 
 =
    q =3D data;
     if (size >=3D 0)
diff --git a/src/openvpn/buffer=2Ec b=
/src/openvpn/buffer=2Ec
index 8c19902=2E=2E2b4d05d 100644
--- a/src/openvpn=
/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -500,7 +500,7 @@
 void
 buf_nul=
l_terminate(struct buffer *buf)
 {
-    char *last =3D (char *)BLAST(buf);
=
+    const char *last =3D (char *)BLAST(buf);
     if (last && *last =3D=3D=
 '\0') /* already terminated? */
     {
         return;
@@ -523,7 +523,7 @=
@
 {
     while (true)
     {
-        char *last =3D (char *)BLAST(buf);
+=
        const char *last =3D (char *)BLAST(buf);
         if (!last)
      =
   {
             break;
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/=
buffer=2Eh
index 651aaed=2E=2Ebc5cffb 100644
--- a/src/openvpn/buffer=2Eh
+=
++ b/src/openvpn/buffer=2Eh
@@ -1318,7 +1318,7 @@
 static inline bool
 buf_=
copy_n(struct buffer *dest, struct buffer *src, int n)
 {
-    uint8_t *cp =
=3D buf_read_alloc(src, n);
+    const uint8_t *cp =3D buf_read_alloc(src, =
n);
     if (!cp)
     {
         return false;
@@ -1409,7 +1409,7 @@
 stat=
ic inline bool
 buf_read(struct buffer *src, void *dest, int size)
 {
-    =
uint8_t *cp =3D buf_read_alloc(src, size);
+    const uint8_t *cp =3D buf_r=
ead_alloc(src, size);
     if (!cp)
     {
         return false;
diff --gi=
t a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec
index 45f138c=2E=2E=
48797b0 100644
--- a/src/openvpn/comp-lz4=2Ec
+++ b/src/openvpn/comp-lz4=2E=
c
@@ -164,7 +164,7 @@
     ASSERT(buf_init(&work, frame->buf=2Eheadroom));
=
 
     /* do unframing/swap (assumes buf->len > 0) */
-    uint8_t *head =
=3D BPTR(buf);
+    const uint8_t *head =3D BPTR(buf);
     c =3D *head;
 
=
     /* Not compressed */
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn=
/crypto=2Ec
index 8f59838=2E=2E8bbc566 100644
--- a/src/openvpn/crypto=2Ec
=
+++ b/src/openvpn/crypto=2Ec
@@ -1212,7 +1212,7 @@
 
     /* init implicit =
IV */
     {
-        cipher_ctx_t *cipher =3D co->key_ctx_bi=2Eencrypt=2Ec=
ipher;
+        const cipher_ctx_t *cipher =3D co->key_ctx_bi=2Eencrypt=2Ec=
ipher;
         if (cipher_ctx_mode_aead(cipher))
         {
             A=
SSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
@@ -1922,7 =
+1922,7 @@
     const char *seed =3D "tls1-prf-test";
     const char *secr=
et =3D "tls1-prf-test-secret";
     uint8_t out[8];
-    uint8_t expected_o=
ut[] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
+    const uint8_t e=
xpected_out[] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
 
     int =
ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,
    =
                        strlen(secret), out, sizeof(out));
diff --git a/src=
/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 37933a1=2E=
=2E158c841 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/cryp=
to_epoch=2Ec
@@ -213,7 +213,7 @@
      *
      * The last generated key mig=
ht have been moved to the decrypt key already=2E
      */
-    struct key_c=
tx *highest_future_key =3D
+    const struct key_ctx *highest_future_key =
=3D
         &co->epoch_data_keys_future[co->epoch_data_keys_future_count -=
 1];
 
     ASSERT(co->epoch_key_recv=2Eepoch =3D=3D 1 || highest_future_ke=
y->epoch =3D=3D co->epoch_key_recv=2Eepoch
diff --git a/src/openvpn/cryptoa=
pi=2Ec b/src/openvpn/cryptoapi=2Ec
index 0f95ab7=2E=2Ead2706c 100644
--- a/=
src/openvpn/cryptoapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -225,7 +225,6 =
@@
     const CERT_INFO *info =3D cert_ctx->pCertInfo;
     const CERT_EXTE=
NSION *ext;
     DWORD cbext;
-    void *pvext;
     struct gc_arena gc =3D=
 gc_new();
     const WCHAR *tmpl_name =3D wide_string(cert_prop, &gc);
 
@=
@ -233,7 +232,7 @@
     ext =3D CertFindExtension(szOID_CERTIFICATE_TEMPLAT=
E, info->cExtension, info->rgExtension);
     if (ext)
     {
-        pvex=
t =3D decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext)=
;
+        const void *pvext =3D decode_object(&gc, X509_CERTIFICATE_TEMPLA=
TE, &ext->Value, 0, &cbext);
         if (pvext && cbext >=3D sizeof(CERT_T=
EMPLATE_EXT))
         {
             const CERT_TEMPLATE_EXT *cte =3D (con=
st CERT_TEMPLATE_EXT *)pvext;
diff --git a/src/openvpn/dco=2Ec b/src/openvp=
n/dco=2Ec
index ce73701=2E=2E8eae4bf 100644
--- a/src/openvpn/dco=2Ec
+++ b=
/src/openvpn/dco=2Ec
@@ -112,7 +112,7 @@
     for (int i =3D 0; i < KEY_SCA=
N_SIZE; ++i)
     {
         struct key_state *ks =3D get_key_scan(multi, i=
);
-        struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
+ =
       const struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
 =

         if (ks =3D=3D primary)
         {
@@ -577,7 +577,7 @@
           =
              struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
-  =
  struct context *c =3D &mi->context;
+    const struct context *c =3D &mi-=
>context;
 
     if (!proto_is_udp(c->c2=2Elink_sockets[0]->info=2Eproto)
 =
        || !(c->options=2Esockflags & SF_USE_IP_PKTINFO))
@@ -625,7 +625,7 =
@@
 int
 dco_multi_add_new_peer(struct multi_context *m, struct multi_insta=
nce *mi)
 {
-    struct context *c =3D &mi->context;
+    const struct cont=
ext *c =3D &mi->context;
 
     int peer_id =3D c->c2=2Etls_multi->rx_peer_=
id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
@@ -646,14 +646,=
14 @@
 
     /* In server mode we need to fetch the remote addresses from t=
he push config */
     struct in_addr vpn_ip4 =3D { 0 };
-    struct in_add=
r *vpn_addr4 =3D NULL;
+    const struct in_addr *vpn_addr4 =3D NULL;
     =
if (c->c2=2Epush_ifconfig_defined)
     {
         vpn_ip4=2Es_addr =3D hto=
nl(c->c2=2Epush_ifconfig_local);
         vpn_addr4 =3D &vpn_ip4;
     }
 
=
-    struct in6_addr *vpn_addr6 =3D NULL;
+    const struct in6_addr *vpn_a=
ddr6 =3D NULL;
     if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
        =
 vpn_addr6 =3D &c->c2=2Epush_ifconfig_ipv6_local;
@@ -702,7 +702,7 @@
     =
}
 #endif
 
-    struct context *c =3D &mi->context;
+    const struct cont=
ext *c =3D &mi->context;
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if=
 defined(_WIN32)
@@ -750,7 +750,7 @@
     }
     ASSERT(TUNNEL_TYPE(mi->con=
text=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
-    struct context *c =3D &mi-=
>context;
+    const struct context *c =3D &mi->context;
 
     if (mi->con=
text=2Ec2=2Epush_ifconfig_defined)
     {
diff --git a/src/openvpn/dco_free=
bsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index eaca86b=2E=2Ed933aaf 100644
---=
 a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -134,7 =
+134,8 @@
 
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int=
 sd, struct sockaddr *localaddr,
-             struct sockaddr *remoteaddr,=
 struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
+             struct =
sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,
+             const s=
truct in6_addr *vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *lo=
cal_nvl, *remote_nvl;
diff --git a/src/openvpn/dco_internal=2Eh b/src/openv=
pn/dco_internal=2Eh
index da07780=2E=2Efcf8aca 100644
--- a/src/openvpn/dco=
_internal=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -60,7 +60,7 @@
  */
 
 =
int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor=
_t sd, struct sockaddr *localaddr,
-                 struct sockaddr *remot=
eaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);
+             =
    struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const stru=
ct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned in=
t peerid);
 
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=
=2Ec
index 40746bd=2E=2E56f6259 100644
--- a/src/openvpn/dco_linux=2Ec
+++ =
b/src/openvpn/dco_linux=2Ec
@@ -222,7 +222,8 @@
 
 int
 dco_new_peer(dco_co=
ntext_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
-   =
          struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6=
_addr *vpn_ipv6)
+             struct sockaddr *remoteaddr, const struct in=
_addr *vpn_ipv4,
+             const struct in6_addr *vpn_ipv6)
 {
     str=
uct gc_arena gc =3D gc_new();
     const char *remotestr =3D "[undefined]";=

@@ -697,7 +698,7 @@
 {
     dco_context_t *dco =3D arg;
     struct nlattr=
 *tb[CTRL_ATTR_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_=
hdr(msg));
+    const struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg)=
);
 
     nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_a=
ttrlen(gnlh, 0), NULL);
 
@@ -706,7 +707,7 @@
         return NL_SKIP;
    =
 }
 
-    struct nlattr *mcgrp;
+    const struct nlattr *mcgrp;
     int r=
em_mcgrp;
     nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_m=
cgrp)
     {
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec=

index 2e26f2a=2E=2Eb3268bc 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/=
openvpn/dco_win=2Ec
@@ -285,8 +285,8 @@
     msg(D_DCO_DEBUG, "%s", __func_=
_);
 
     int ai_family =3D sock->info=2Elsa->bind_local->ai_family;
-    =
struct addrinfo *local =3D sock->info=2Elsa->bind_local;
-    struct addrin=
fo *cur =3D NULL;
+    const struct addrinfo *local =3D sock->info=2Elsa->b=
ind_local;
+    const struct addrinfo *cur =3D NULL;
 
     for (cur =3D lo=
cal; cur; cur =3D cur->ai_next)
     {
@@ -334,7 +334,7 @@
     struct addr=
info *remoteaddr =3D sock->info=2Elsa->current_remote;
 
     struct sockad=
dr *local =3D NULL;
-    struct sockaddr *remote =3D remoteaddr->ai_addr;
+=
    const struct sockaddr *remote =3D remoteaddr->ai_addr;
 
     if (remot=
eaddr->ai_protocol =3D=3D IPPROTO_TCP || remoteaddr->ai_socktype =3D=3D SOC=
K_STREAM)
     {
@@ -348,7 +348,7 @@
     if (sock->bind_local)
     {
    =
     /* Use first local address with correct address family */
-        str=
uct addrinfo *bind =3D sock->info=2Elsa->bind_local;
+        const struct =
addrinfo *bind =3D sock->info=2Elsa->bind_local;
         while (bind && !l=
ocal)
         {
             if (bind->ai_family =3D=3D remote->sa_family)=

@@ -415,8 +415,9 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned i=
nt peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
-           =
  struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *v=
pn_ipv6)
+dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_desc=
riptor_t sd,
+             struct sockaddr *localaddr, struct sockaddr *rem=
oteaddr,
+             const struct in_addr *vpn_ipv4, const struct in6_add=
r *vpn_ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd " SOCKET_PRINTF, =
__func__, peerid, sd);
 
@@ -745,7 +746,7 @@
     struct gc_arena gc =3D gc=
_new();
 
     int ret =3D 0;
-    struct tuntap *tt =3D dco->tt;
+    cons=
t struct tuntap *tt =3D dco->tt;
 
     if (!tuntap_defined(tt))
     {
@@ =
-869,7 +870,7 @@
 int
 dco_get_peer_stats_fallback(struct context *c, const=
 bool raise_sigusr1_on_err)
 {
-    struct tuntap *tt =3D c->c1=2Etuntap;
+=
    const struct tuntap *tt =3D c->c1=2Etuntap;
 
     if (!tuntap_defined(=
tt))
     {
@@ -898,7 +899,7 @@
 int
 dco_get_peer_stats(struct context *c,=
 const bool raise_sigusr1_on_err)
 {
-    struct tuntap *tt =3D c->c1=2Etun=
tap;
+    const struct tuntap *tt =3D c->c1=2Etuntap;
 
     if (!tuntap_de=
fined(tt))
     {
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
in=
dex 1465cdf=2E=2E7f4dde4 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn=
/dns=2Ec
@@ -132,7 +132,7 @@
     }
     else
     {
-        struct sockad=
dr_in6 *sin6 =3D (struct sockaddr_in6 *)ai->ai_addr;
+        const struct =
sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)ai->ai_addr;
         server-=
>addr[server->addr_count]=2Ein=2Ea6 =3D sin6->sin6_addr;
     }
 
@@ -156,7=
 +156,7 @@
     /* Append all domains to the end of the list */
     while =
(*domains)
     {
-        char *domain =3D *domains++;
+        const char=
 *domain =3D *domains++;
         if (!validate_domain(domain))
         {
=
             return false;
@@ -699,7 +699,7 @@
 run_up_down_command(bool up=
, struct options *o, const struct tuntap *tt,
                     struct d=
ns_updown_runner_info *updown_runner)
 {
-    struct dns_options *dns =3D &=
o->dns_options;
+    const struct dns_options *dns =3D &o->dns_options;
   =
  if (!dns->updown || (o->up_script && !dns_updown_user_set(dns) && !dns_up=
down_forced(dns)))
     {
         return;
@@ -864,7 +864,7 @@
     }
 #ifd=
ef _WIN32
     /* Don't use iservice in DHCP mode */
-    struct tuntap_opt=
ions *tto =3D &o->tuntap_options;
+    const struct tuntap_options *tto =3D=
 &o->tuntap_options;
     if (tto->ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ=
 || tto->ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)
     {
         return;
d=
iff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 9e17807=2E=
=2E8b7716a 100644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@=
@ -557,7 +557,7 @@
 ep_del(struct event_set *es, event_t event)
 {
     str=
uct epoll_event ev;
-    struct ep_set *eps =3D (struct ep_set *)es;
+    c=
onst struct ep_set *eps =3D (struct ep_set *)es;
 
     dmsg(D_EVENT_WAIT, =
"EP_DEL ev=3D%d", (int)event);
 
@@ -572,7 +572,7 @@
 static void
 ep_ctl(s=
truct event_set *es, event_t event, unsigned int rwflags, void *arg)
 {
-  =
  struct ep_set *eps =3D (struct ep_set *)es;
+    const struct ep_set *eps=
 =3D (struct ep_set *)es;
     struct epoll_event ev;
 
     CLEAR(ev);
dif=
f --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 46e1a53=
=2E=2E2ade321 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forwar=
d=2Ec
@@ -1213,7 +1213,7 @@
 {
     if (float_sa->sa_family =3D=3D AF_INET)=

     {
-        struct sockaddr_in *float4 =3D (struct sockaddr_in *)float=
_sa;
+        const struct sockaddr_in *float4 =3D (struct sockaddr_in *)fl=
oat_sa;
         /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4=2E H=
owever, on a
          * dual-stack socket, we need to preserve the mapping=
 otherwise openvpn
          * will not be able to find the peer by its tra=
nsport address=2E
@@ -1236,7 +1236,7 @@
     }
     else
     {
-        st=
ruct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
+        con=
st struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
       =
  memcpy(&out_osaddr->addr=2Ein6, float6, sizeof(struct sockaddr_in6));
   =
  }
 }
@@ -1366,8 +1366,8 @@
         return;
     }
 
-    struct openvpn_=
sockaddr *link_addr =3D &c->c2=2Eto_link_addr->dest;
-    struct link_socke=
t_info *lsi =3D get_link_socket_info(c);
+    const struct openvpn_sockaddr=
 *link_addr =3D &c->c2=2Eto_link_addr->dest;
+    const struct link_socket_=
info *lsi =3D get_link_socket_info(c);
 
     int ip_hdr_offset =3D 0;
    =
 int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1=2Etuntap), buf, &ip_hd=
r_offset);
@@ -1404,7 +1404,7 @@
         }
 
         /* drop packets with=
 same dest addr and port as remote */
-        uint8_t *l4_hdr =3D (uint8_t=
 *)pip + ip_hlen;
+        const uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hl=
en;
 
         uint16_t link_port =3D ntohs(link_addr->addr=2Ein4=2Esin_por=
t);
 
@@ -1451,7 +1451,7 @@
         uint16_t link_port =3D ntohs(link_addr=
->addr=2Ein6=2Esin6_port);
 
         /* drop packets with same dest addr a=
nd port as remote */
-        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(=
struct openvpn_ipv6hdr);
+        const uint8_t *l4_hdr =3D (uint8_t *)pip6=
 + sizeof(struct openvpn_ipv6hdr);
         uint16_t src_port =3D ntohs(*(u=
int16_t *)l4_hdr);
         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hd=
r + sizeof(uint16_t)));
         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr=
->addr=2Ein6=2Esin6_addr, &pip6->daddr)) && (link_port =3D=3D dst_port))
@@=
 -2210,7 +2210,7 @@
 
                     if (e->arg >=3D MULTI_N)
       =
              {
-                        struct event_arg *ev_arg =3D (stru=
ct event_arg *)e->arg;
+                        const struct event_arg *ev_=
arg =3D (struct event_arg *)e->arg;
                         if (ev_arg->ty=
pe !=3D EVENT_ARG_LINK_SOCKET)
                         {
                 =
            c->c2=2Eevent_set_status =3D ES_ERROR;
diff --git a/src/openvpn=
/init=2Ec b/src/openvpn/init=2Ec
index 66bae34=2E=2Ea8e041d 100644
--- a/sr=
c/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -321,8 +321,8 @@
 manageme=
nt_callback_remote_entry_count(void *arg)
 {
     ASSERT(arg);
-    struct =
context *c =3D (struct context *)arg;
-    struct connection_list *l =3D c-=
>options=2Econnection_list;
+    const struct context *c =3D (struct contex=
t *)arg;
+    const struct connection_list *l =3D c->options=2Econnection_l=
ist;
 
     return l->len;
 }
@@ -339,7 +339,7 @@
 
     if (l->len > 0 && =
index < (unsigned int)l->len)
     {
-        struct connection_entry *ce =
=3D l->array[index];
+        const struct connection_entry *ce =3D l->arra=
y[index];
         const char *proto =3D proto2ascii(ce->proto, ce->af, fal=
se);
         const char *status =3D (ce->flags & CE_DISABLED) ? "disabled"=
 : "enabled";
 
@@ -517,7 +517,7 @@
 {
     struct connection_list *l =3D c=
->options=2Econnection_list;
     bool ce_defined;
-    struct connection_e=
ntry *ce;
+    const struct connection_entry *ce;
     int n_cycles =3D 0;
=
 
     do
@@ -1563,10 +1563,10 @@
     /* Tell management interface that we=
 initialized */
     if (management)
     {
-        in_addr_t *tun_local =
=3D NULL;
-        struct in6_addr *tun_local6 =3D NULL;
+        const in_=
addr_t *tun_local =3D NULL;
+        const struct in6_addr *tun_local6 =3D =
NULL;
         struct openvpn_sockaddr local, remote;
-        struct link_=
socket_actual *actual;
+        const struct link_socket_actual *actual;
  =
       socklen_t sa_len =3D sizeof(local);
         const char *detail =3D =
"SUCCESS";
         if (flags & ISC_ERRORS)
@@ -4282,7 +4282,7 @@
     /* O=
n some newer Android handsets, changing to a different network
      * ofte=
n does not trigger a TCP reset but continue using the old
      * connectio=
n (e=2Eg=2E using mobile connection when WiFi becomes available */
-    str=
uct link_socket_info *lsi =3D get_link_socket_info(c);
+    const struct li=
nk_socket_info *lsi =3D get_link_socket_info(c);
     if (lsi && proto_is_t=
cp(lsi->proto) && !samenetwork)
     {
         return -2;
diff --git a/src=
/openvpn/list=2Ec b/src/openvpn/list=2Ec
index 9e80761=2E=2Ee51dcd0 100644
=
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -167,7 +167,7 @@
 =
hash_remove_by_value(struct hash *hash, void *value)
 {
     struct hash_it=
erator hi;
-    struct hash_element *he;
+    const struct hash_element *he=
;
 
     hash_iterator_init(hash, &hi);
     while ((he =3D hash_iterator_n=
ext(&hi)))
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
ind=
ex 95ff246=2E=2E2b0a661 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openv=
pn/manage=2Ec
@@ -3821,7 +3821,7 @@
 {
     int ok;
     char *result =3D N=
ULL;
-    struct buffer *buf;
+    const struct buffer *buf;
 
     ok =3D =
management_query_multiline(man, b64_data, prompt, cmd, state, input);
     =
if (ok && buffer_list_defined(*input))
@@ -3850,7 +3850,7 @@
 {
     int ok=
;
     char *result =3D NULL;
-    struct buffer *buf;
+    const struct bu=
ffer *buf;
 
     ok =3D management_query_multiline(man, b64_data, prompt, =
cmd, state, input);
     if (ok && buffer_list_defined(*input))
diff --git =
a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index a8c88c9=2E=2E54af890 10=
0644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -131,7 +131,7=
 @@
     struct auth_challenge_info *ac;
     const int len =3D strlen(auth=
_challenge);
     char *work =3D (char *)gc_malloc(len + 1, false, gc);
-  =
  char *cp;
+    const char *cp;
 
     struct buffer b;
     buf_set_read(=
&b, (const uint8_t *)auth_challenge, len);
diff --git a/src/openvpn/mss=2Ec=
 b/src/openvpn/mss=2Ec
index 14112b4=2E=2E36bbb43 100644
--- a/src/openvpn/=
mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -65,7 +65,7 @@
         struct buffer =
newbuf =3D *buf;
         if (buf_advance(&newbuf, hlen))
         {
-     =
       struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbuf)=
;
+            const struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *=
)BPTR(&newbuf);
             if (tc->flags & OPENVPN_TCPH_SYN_MASK)
       =
      {
                 mss_fixup_dowork(&newbuf, maxmss);
@@ -122,7 +122,=
7 @@
     newbuf =3D *buf;
     if (buf_advance(&newbuf, 40) && BLENZ(&newb=
uf) >=3D sizeof(struct openvpn_tcphdr))
     {
-        struct openvpn_tcph=
dr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbuf);
+        const struct op=
envpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbuf);
         if (t=
c->flags & OPENVPN_TCPH_SYN_MASK)
         {
             mss_fixup_dowork(=
&newbuf, maxmss - 20);
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=
=2Ec
index f000283=2E=2E5d88f8a 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src=
/openvpn/mtcp=2Ec
@@ -130,7 +130,7 @@
 void
 multi_tcp_dereference_instance=
(struct multi_io *multi_io, struct multi_instance *mi)
 {
-    struct link_=
socket *sock =3D mi->context=2Ec2=2Elink_sockets[0];
+    const struct link=
_socket *sock =3D mi->context=2Ec2=2Elink_sockets[0];
     if (sock && mi->=
socket_set_called)
     {
         event_del(multi_io->es, socket_event_han=
dle(sock));
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index =
632b064=2E=2E6d9c181 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mu=
dp=2Ec
@@ -102,7 +102,7 @@
     verdict =3D tls_pre_decrypt_lite(tas, state=
, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
     uint8_t *hmac_key =3D m-=
>top=2Ec2=2Esession_id_key;
-    struct openvpn_sockaddr *from =3D &m->top=
=2Ec2=2Efrom=2Edest;
+    const struct openvpn_sockaddr *from =3D &m->top=
=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_w=
indow;
 
     if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D V=
ERDICT_VALID_RESET_V2)
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mul=
ti=2Ec
index 20b4f14=2E=2E60a5148 100644
--- a/src/openvpn/multi=2Ec
+++ b/=
src/openvpn/multi=2Ec
@@ -86,7 +86,7 @@
     struct gc_arena gc =3D gc_new(=
);
     struct env_set *es;
     bool ret =3D true;
-    struct plugin_list=
 *plugins;
+    const struct plugin_list *plugins;
 
     /* get environmen=
tal variable source */
     if (mi && mi->context=2Ec2=2Ees)
@@ -1793,7 +17=
93,7 @@
      * Push the first cipher from --data-ciphers to the client tha=
t
      * the client announces to be supporting=2E
      */
-    char *push=
_cipher =3D
+    const char *push_cipher =3D
         ncp_get_best_cipher(o=
->ncp_ciphers, peer_info, tls_multi->remote_ciphername, &o->gc);
     if (p=
ush_cipher)
     {
@@ -1924,7 +1924,7 @@
 static enum client_connect_return=

 ccs_test_deferred_ret_file(struct multi_instance *mi)
 {
-    struct clie=
nt_connect_defer_state *ccs =3D &(mi->client_connect_defer_state);
+    con=
st struct client_connect_defer_state *ccs =3D &(mi->client_connect_defer_st=
ate);
     FILE *fp =3D fopen(ccs->deferred_ret_file, "r");
     if (!fp)
 =
    {
@@ -2165,7 +2165,7 @@
 {
     ASSERT(mi);
     ASSERT(option_types_fo=
und);
-    struct client_connect_defer_state *ccs =3D &(mi->client_connect_=
defer_state);
+    const struct client_connect_defer_state *ccs =3D &(mi->c=
lient_connect_defer_state);
     enum client_connect_return ret =3D CC_RET_=
SKIPPED;
 
     ret =3D ccs_test_deferred_ret_file(mi);
@@ -2567,7 +2567,7 =
@@
 override_locked_username(struct multi_instance *mi)
 {
     struct tls_=
multi *multi =3D mi->context=2Ec2=2Etls_multi;
-    struct options *options=
 =3D &mi->context=2Eoptions;
+    const struct options *options =3D &mi->co=
ntext=2Eoptions;
     struct tls_session *session =3D &multi->session[TM_AC=
TIVE];
 
     if (!multi->locked_username)
@@ -2986,7 +2986,7 @@
     {
 #i=
f defined(ENABLE_ASYNC_PUSH)
         bool was_unauthenticated =3D true;
- =
       struct key_state *ks =3D NULL;
+        const struct key_state *ks =
=3D NULL;
         if (mi->context=2Ec2=2Etls_multi)
         {
           =
  ks =3D &mi->context=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY=
];
@@ -3919,7 +3919,7 @@
 static int
 management_callback_n_clients(void *a=
rg)
 {
-    struct multi_context *m =3D (struct multi_context *)arg;
+    c=
onst struct multi_context *m =3D (struct multi_context *)arg;
     return m=
->n_clients;
 }
 
@@ -4430,7 +4430,7 @@
 bool
 multi_check_push_ifconfig_ex=
tra_route(struct multi_instance *mi, in_addr_t dest)
 {
-    struct options=
 *o =3D &mi->context=2Eoptions;
+    const struct options *o =3D &mi->conte=
xt=2Eoptions;
     in_addr_t local_addr, local_netmask;
 
     if (!o->ifco=
nfig_local || !o->ifconfig_remote_netmask)
@@ -4452,7 +4452,7 @@
 multi_che=
ck_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
              =
                              struct in6_addr *dest)
 {
-    struct options=
 *o =3D &mi->context=2Eoptions;
+    const struct options *o =3D &mi->conte=
xt=2Eoptions;
 
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbi=
ts)
     {
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/netw=
orking_sitnl=2Ec
index b3f8e2b=2E=2Ee6e72d0 100644
--- a/src/openvpn/networ=
king_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -462,7 +462,7 @@
 =
    struct rtattr *rta =3D RTM_RTA(r);
     size_t len =3D n->nlmsg_len - N=
LMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex =3D 0;
-    void =
*gw =3D NULL;
+    const void *gw =3D NULL;
 
     /* filter-out non-zero d=
st prefixes */
     if (res->default_only && r->rtm_dst_len !=3D 0)
@@ -117=
9,7 +1179,7 @@
 net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *d=
st, int prefixlen, const in_addr_t *gw,
                  const char *iface=
, uint32_t table, int metric)
 {
-    in_addr_t *dst_ptr =3D NULL, *gw_ptr =
=3D NULL;
+    const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
     in=
_addr_t dst_be =3D 0, gw_be =3D 0;
     char dst_str[INET_ADDRSTRLEN];
    =
 char gw_str[INET_ADDRSTRLEN];
@@ -1326,7 +1326,7 @@
 #if defined(ENABLE_DC=
O)
     if (arg && (strcmp(type, OVPN_FAMILY_NAME) =3D=3D 0))
     {
-     =
   dco_context_t *dco =3D arg;
+        const dco_context_t *dco =3D arg;
 =
        struct rtattr *data =3D SITNL_NEST(&req=2En, sizeof(req), IFLA_INFO=
_DATA);
 
         /* the netlink format is uint8_t for this and using some=
thing
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index =
107b3fa9=2E=2E23741f0 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvp=
n/options=2Ec
@@ -1696,7 +1696,7 @@
 
     for (int i =3D 0; i < ce->local_=
list->len; i++)
     {
-        struct local_entry *le =3D ce->local_list->=
array[i];
+        const struct local_entry *le =3D ce->local_list->array[i=
];
 
         if (proto_is_net(le->proto) && string_defined_equal(le->local=
, ce->remote)
             && string_defined_equal(le->port, ce->remote_por=
t))
@@ -7693,7 +7693,7 @@
 #ifdef ENABLE_PKCS11
     else if (streq(p[0], "=
show-pkcs11-ids") && !p[3])
     {
-        char *provider =3D p[1];
+     =
   const char *provider =3D p[1];
         bool cert_private =3D (p[2] =3D=
=3D NULL ? false : (atoi_warn(p[2], msglevel) !=3D 0));
 
 #ifdef DEFAULT_P=
KCS11_MODULE
diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/optio=
ns_parse=2Ec
index a8c4aee=2E=2E88ab4d2 100644
--- a/src/openvpn/options_pa=
rse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -268,7 +268,7 @@
     while =
(in_src_get(is, line, sizeof(line)))
     {
         (*num_lines)++;
-     =
   char *line_ptr =3D line;
+        const char *line_ptr =3D line;
       =
  /* Remove leading spaces */
         while (isspace(*line_ptr))
         =
{
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
=
index d72ea25c=2E=2E779c38e 100644
--- a/src/openvpn/options_util=2Ec
+++ b=
/src/openvpn/options_util=2Ec
@@ -273,7 +273,7 @@
         return true;
   =
  }
 
-    struct pull_filter *f;
+    const struct pull_filter *f;
 
     =
for (f =3D o->pull_filter_list->head; f; f =3D f->next)
     {
diff --git a=
/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index ff74e7c=2E=2E80dec6c 100=
644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -63,7 +63,7 @@=

 
     for (i =3D 0; i < pool->size; ++i)
     {
-        struct ifconfig_=
pool_entry *ipe =3D &pool->list[i];
+        const struct ifconfig_pool_ent=
ry *ipe =3D &pool->list[i];
         if (!ipe->in_use)
         {
         =
    /*
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 9ac=
b2fa=2E=2Ee0700aa 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/prox=
y=2Ec
@@ -703,7 +703,7 @@
 #if PROXY_DIGEST_AUTH
         else if (p->auth_=
method =3D=3D HTTP_AUTH_DIGEST && !processed)
         {
-            char =
*pa =3D p->proxy_authenticate;
+            const char *pa =3D p->proxy_aut=
henticate;
             const int method =3D p->auth_method;
             A=
SSERT(pa);
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index=
 5b15f71=2E=2Efa7bf1e 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/p=
ush=2Ec
@@ -271,8 +271,8 @@
     }
 #ifdef ENABLE_MANAGEMENT
     struct tl=
s_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
-    struct =
man_def_auth_context *mda =3D session->opt->mda_context;
-    struct env_se=
t *es =3D session->opt->es;
+    const struct man_def_auth_context *mda =3D=
 session->opt->mda_context;
+    const struct env_set *es =3D session->opt-=
>es;
     unsigned int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->m=
da_key_id;
 
     management_notify_client_cr_response(mda_key_id, mda, es,=
 m);
@@ -917,7 +917,7 @@
 push_options(struct options *o, char **p, msglvl_=
t msglevel, struct gc_arena *gc)
 {
     const char **argv =3D make_extende=
d_arg_array(p, false, gc);
-    char *opt =3D print_argv(argv, gc, 0);
+   =
 const char *opt =3D print_argv(argv, gc, 0);
     push_option(o, opt, msgl=
evel);
 }
 
@@ -1199,7 +1199,7 @@
                     /* parse route-ipv6 =
arguments */
                     if (get_ipv6_addr(p[1], &network, &netbit=
s, D_ROUTE_DEBUG))
                     {
-                        struct i=
route_ipv6 *ir;
+                        const struct iroute_ipv6 *ir;
 
  =
                       /* does this route-ipv6 match an iroute-ipv6? */
   =
                      for (ir =3D o->iroutes_ipv6; ir !=3D NULL; ir =3D ir-=
>next)
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 6db=
e3ec=2E=2E03a2526 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rout=
e=2Ec
@@ -667,7 +667,7 @@
 
     /* parse the routes from opt to rl */
    =
 {
-        struct route_option *ro;
+        const struct route_option *ro=
;
         for (ro =3D opt->routes; ro; ro =3D ro->next)
         {
       =
      struct addrinfo *netlist =3D NULL;
@@ -679,7 +679,7 @@
             }=

             else
             {
-                struct addrinfo *curele;=

+                const struct addrinfo *curele;
                 for (cure=
le =3D netlist; curele; curele =3D curele->ai_next)
                 {
    =
                 struct route_ipv4 *new;
@@ -799,7 +799,7 @@
     need_remo=
te_ipv6_route =3D false;
 
     {
-        struct route_ipv6_option *ro6;
+=
        const struct route_ipv6_option *ro6;
         for (ro6 =3D opt6->ro=
utes_ipv6; ro6; ro6 =3D ro6->next)
         {
             struct route_ipv=
6 *r6;
@@ -1187,7 +1187,7 @@
 {
     if (rl6 && (rl6->iflags & RL_ROUTES_AD=
DED))
     {
-        struct route_ipv6 *r6;
+        const struct route_ip=
v6 *r6;
         for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
       =
  {
             delete_route_ipv6(r6, tt, es, ctx);
@@ -1226,7 +1226,7 @@
=
 void
 print_route_options(const struct route_option_list *rol, msglvl_t ms=
glevel)
 {
-    struct route_option *ro;
+    const struct route_option *ro=
;
     if (rol->flags & RG_ENABLE)
     {
         msg(msglevel, "  [redire=
ct_default_gateway local=3D%d]", (rol->flags & RG_LOCAL) !=3D 0);
@@ -1335,=
7 +1335,7 @@
 setenv_routes(struct env_set *es, const struct route_list *rl=
)
 {
     int i =3D 1;
-    struct route_ipv4 *r;
+    const struct route_i=
pv4 *r;
     for (r =3D rl->routes; r; r =3D r->next)
     {
         seten=
v_route(es, r, i++);
@@ -1372,7 +1372,7 @@
 setenv_routes_ipv6(struct env_s=
et *es, const struct route_ipv6_list *rl6)
 {
     int i =3D 1;
-    struct=
 route_ipv6 *r6;
+    const struct route_ipv6 *r6;
     for (r6 =3D rl6->ro=
utes_ipv6; r6; r6 =3D r6->next)
     {
         setenv_route_ipv6(es, r6, i=
++);
@@ -2423,7 +2423,7 @@
          */
         if (rl && tt->did_ifconfig=
_setup)
         {
-            struct route_ipv4 *r;
+            const st=
ruct route_ipv4 *r;
             for (r =3D rl->routes, len =3D 0; r; r =3D=
 r->next, ++len)
             {
                 test_route_helper(&ret, &c=
ount, &good, &ambig, adapters, r->gateway);
@@ -3110,7 +3110,8 @@
     /* s=
can adapter list */
     if (rgi->flags & RGI_ADDR_DEFINED)
     {
-       =
 struct ifreq *ifr, *ifend;
+        const struct ifreq *ifr;
+        cons=
t struct ifreq *ifend;
         in_addr_t addr, netmask;
         struct if=
req ifreq;
         struct ifconf ifc;
diff --git a/src/openvpn/socket=2Ec =
b/src/openvpn/socket=2Ec
index 0f66ad51=2E=2Efba0a22 100644
--- a/src/openv=
pn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -393,7 +393,7 @@
 
          =
   for (int j =3D 0; j < ce->local_list->len; j++)
             {
-        =
        struct local_entry *le =3D ce->local_list->array[j];
+             =
   const struct local_entry *le =3D ce->local_list->array[j];
 
           =
      if (!le->local)
                 {
@@ -898,12 +898,10 @@
      * What=
 is the correct way to deal with it?
      */
 
-    struct addrinfo *cur;
=
-
     ASSERT(local);
 
-
     /* find the first addrinfo with correct ai_f=
amily */
+    const struct addrinfo *cur;
     for (cur =3D local; cur; cur=
 =3D cur->ai_next)
     {
         if (cur->ai_family =3D=3D ai_family)
@@ =
-1490,7 +1488,7 @@
         /* Socket is always bound on the first matching=
 address,
          * For bound sockets with no remote addr this is the ele=
ment of
          * the list */
-        struct addrinfo *cur;
+        con=
st struct addrinfo *cur;
         for (cur =3D sock->info=2Elsa->bind_local=
; cur; cur =3D cur->ai_next)
         {
             if (!ai_family || ai_f=
amily =3D=3D cur->ai_family)
@@ -1621,7 +1619,7 @@
 create_socket_dco_win(s=
truct context *c, struct link_socket *sock, struct signal_info *sig_info)
 =
{
     /* in P2P mode we must have remote resolved at this point */
-    st=
ruct addrinfo *remoteaddr =3D sock->info=2Elsa->current_remote;
+    const =
struct addrinfo *remoteaddr =3D sock->info=2Elsa->current_remote;
     if (=
(c->options=2Emode =3D=3D MODE_POINT_TO_POINT) && (!remoteaddr))
     {
   =
      return;
@@ -1910,7 +1908,7 @@
                               const st=
ruct link_socket_actual *from_addr)
 {
     struct gc_arena gc =3D gc_new()=
;
-    struct addrinfo *ai;
+    const struct addrinfo *ai;
 
     switch (=
from_addr->dest=2Eaddr=2Esa=2Esa_family)
     {
diff --git a/src/openvpn/so=
cket=2Eh b/src/openvpn/socket=2Eh
index 1a532e1=2E=2E89465bc 100644
--- a/s=
rc/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -761,7 +761,7 @@
 {
 =
    if (sock && ipbuf)
     {
-        struct openvpn_iphdr *iph =3D (struc=
t openvpn_iphdr *)BPTR(ipbuf);
+        const struct openvpn_iphdr *iph =3D=
 (struct openvpn_iphdr *)BPTR(ipbuf);
         sock->ptos =3D iph->tos;
   =
      sock->ptos_defined =3D true;
     }
diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec
index d5bd602=2E=2E5f5d1f9 100644
--- a/src/openvpn/s=
sl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1488,7 +1488,7 @@
 static bool
 genera=
te_key_expansion(struct tls_multi *multi, struct key_state *ks, struct tls_=
session *session)
 {
-    struct key_ctx_bi *key =3D &ks->crypto_options=2E=
key_ctx_bi;
+    const struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey=
_ctx_bi;
     bool ret =3D false;
     struct key2 key2;
 
@@ -1750,7 +1750=
,7 @@
 static void
 flush_payload_buffer(struct key_state *ks)
 {
-    stru=
ct buffer *b;
+    const struct buffer *b;
 
     while ((b =3D buffer_list=
_peek(ks->paybuf)))
     {
@@ -2779,7 +2779,7 @@
     /* Outgoing Ciphertex=
t to reliable buffer */
     if (ks->state >=3D S_START)
     {
-        st=
ruct buffer *buf =3D reliable_get_buf_output_sequenced(ks->send_reliable);
=
+        const struct buffer *buf =3D reliable_get_buf_output_sequenced(ks-=
>send_reliable);
         if (buf)
         {
             if (!write_outgo=
ing_tls_ciphertext(session, continue_tls_process))
@@ -2848,7 +2848,7 @@
  =
   {
         int opcode;
 
-        struct buffer *buf =3D reliable_send(k=
s->send_reliable, &opcode);
+        const struct buffer *buf =3D reliable_=
send(ks->send_reliable, &opcode);
         ASSERT(buf);
         struct buf=
fer b =3D *buf;
         INCR_SENT;
@@ -3211,7 +3211,7 @@
 static void
 che=
ck_session_buf_not_used(struct buffer *to_link, struct tls_session *session=
)
 {
-    uint8_t *dataptr =3D to_link->data;
+    const uint8_t *dataptr =
=3D to_link->data;
     if (!dataptr)
     {
         return;
@@ -3233,7 +3=
233,7 @@
 
     for (int i =3D 0; i < KS_SIZE; i++)
     {
-        struct =
key_state *ks =3D &session->key[i];
+        const struct key_state *ks =3D=
 &session->key[i];
         if (ks->state =3D=3D S_UNDEF)
         {
      =
       continue;
@@ -3304,7 +3304,7 @@
     {
         struct tls_session *=
session =3D &multi->session[i];
         struct key_state *ks =3D &session-=
>key[KS_PRIMARY];
-        struct key_state *ks_lame =3D &session->key[KS_L=
AME_DUCK];
+        const struct key_state *ks_lame =3D &session->key[KS_LA=
ME_DUCK];
 
         /* set initial remote address=2E This triggers connect=
ing with that
          * session=2E So we only do that if the TM_ACTIVE se=
ssion is not
@@ -3505,7 +3505,7 @@
 
     for (int i =3D 0; i < KEY_SCAN_SI=
ZE; ++i)
     {
-        struct key_state *ks =3D get_key_scan(multi, i);
+=
        const struct key_state *ks =3D get_key_scan(multi, i);
         if =
(ks->key_id !=3D key_id)
         {
             continue;
@@ -4070,7 +4070=
,7 @@
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, struct bu=
ffer *buf)
 {
-    struct key_state *ks =3D multi->save_ks;
+    const stru=
ct key_state *ks =3D multi->save_ks;
 
     msg(D_TLS_DEBUG, __func__);
 
@=
@ -4084,7 +4084,7 @@
 void
 tls_prepend_opcode_v2(const struct tls_multi *m=
ulti, struct buffer *buf)
 {
-    struct key_state *ks =3D multi->save_ks;
=
+    const struct key_state *ks =3D multi->save_ks;
     uint32_t peer;
 
 =
    msg(D_TLS_DEBUG, __func__);
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/=
src/openvpn/ssl_mbedtls=2Ec
index 6d7ac04=2E=2Efaf5a27 100644
--- a/src/ope=
nvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -730,7 +730,7 @@
=
 static inline size_t
 external_key_len(void *vctx)
 {
-    struct external=
_context *const ctx =3D vctx;
+    const struct external_context *const ctx=
 =3D vctx;
 
     return ctx->signature_length;
 }
diff --git a/src/openvpn=
/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 162f68f=2E=2E063fa5d 100=
644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -4=
09,7 +409,7 @@
                     const char *subject, const struct x509_=
track *x509_track)
 {
     char envname[64];
-    char *serial =3D NULL;
+ =
   const char *serial =3D NULL;
     struct gc_arena gc =3D gc_new();
 
   =
  /* Save X509 fields in environment */
@@ -699,7 +699,7 @@
               =
  goto cleanup;
         }
 
-        struct verify_hash_list *current_hash=
 =3D opt->verify_hash;
+        const struct verify_hash_list *current_hash=
 =3D opt->verify_hash;
 
         while (current_hash)
         {
@@ -1532,=
7 +1532,7 @@
 verify_user_pass_management(struct tls_session *session, cons=
t struct user_pass *up)
 {
     int retval =3D KMDA_ERROR;
-    struct key_=
state *ks =3D &session->key[KS_PRIMARY]; /* primary key */
+    const struc=
t key_state *ks =3D &session->key[KS_PRIMARY]; /* primary key */
 
     /* =
set username/password in private env space */
     setenv_str(session->opt-=
>es, "password", up->password);
diff --git a/src/openvpn/tun=2Ec b/src/open=
vpn/tun=2Ec
index f2a4394=2E=2Eaf48921 100644
--- a/src/openvpn/tun=2Ec
+++=
 b/src/openvpn/tun=2Ec
@@ -871,7 +871,7 @@
          */
         if (strict=
_warn)
         {
-            struct addrinfo *curele;
+            const =
struct addrinfo *curele;
             ifconfig_sanity_check(tun_p2p, tt->re=
mote_netmask);
 
             /*
@@ -1726,7 +1726,7 @@
     {
         u_in=
t32_t type;
         struct iovec iv[2];
-        struct ip *iph =3D (struc=
t ip *)buf;
+        const struct ip *iph =3D (struct ip *)buf;
 
         =
if (iph->ip_v =3D=3D 6)
         {
@@ -3414,7 +3414,7 @@
         SP_DEVINF=
O_DATA device_info_data;
         BOOL res;
         HKEY dev_key;
-       =
 char net_cfg_instance_id_string[] =3D "NetCfgInstanceId";
+        const c=
har net_cfg_instance_id_string[] =3D "NetCfgInstanceId";
         BYTE net_=
cfg_instance_id[256];
         char device_instance_id[256];
         DWORD=
 len;
@@ -3542,7 +3542,7 @@
         HKEY unit_key;
         char component=
_id_string[] =3D "ComponentId";
         char component_id[256];
-        c=
har net_cfg_instance_id_string[] =3D "NetCfgInstanceId";
+        const cha=
r net_cfg_instance_id_string[] =3D "NetCfgInstanceId";
         BYTE net_cf=
g_instance_id[256];
         DWORD data_type;
 
diff --git a/src/openvpn/wi=
n32=2Ec b/src/openvpn/win32=2Ec
index ca08ead=2E=2E44b010d 100644
--- a/src=
/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -889,7 +889,7 @@
 
     i=
f (es)
     {
-        struct env_item *e;
+        const struct env_item *=
e;
         char *ret;
         char *p;
         size_t nchars =3D 1;
diff=
 --git a/src/openvpnmsica/msica_arg=2Ec b/src/openvpnmsica/msica_arg=2Ec
in=
dex a334710=2E=2Ed763d93 100644
--- a/src/openvpnmsica/msica_arg=2Ec
+++ b/=
src/openvpnmsica/msica_arg=2Ec
@@ -92,7 +92,7 @@
 {
     /* Count required =
space=2E */
     size_t size =3D 2 /*x + zero-terminator*/;
-    for (struc=
t msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->next)
+    for (const s=
truct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->next)
     {
      =
   size +=3D wcslen(p->val) + 1 /*space delimiter|zero-terminator*/;
     }=

@@ -119,7 +119,7 @@
 
     /* Join=2E */
     LPWSTR s =3D str + 1 /*x*/;
=
-    for (struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->next)
+ =
   for (const struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->next=
)
     {
         /* Convert zero-terminator into space delimiter=2E */
   =
      s[0] =3D L' ';
diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/o=
penvpnmsica/openvpnmsica=2Ec
index 9d12963=2E=2E3911006 100644
--- a/src/op=
envpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -196=
,7 +196,7 @@
 
     /* Count adapters=2E */
     size_t adapter_count =3D 0=
;
-    for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; p=
Adapter =3D pAdapter->pNext)
+    for (const struct tap_adapter_node *pAdap=
ter =3D pAdapterList; pAdapter; pAdapter =3D pAdapter->pNext)
     {
      =
   adapter_count++;
     }
diff --git a/src/openvpnserv/interactive=2Ec b/s=
rc/openvpnserv/interactive=2Ec
index 32c1b9c=2E=2Ea9e9665 100644
--- a/src/=
openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2685,=
7 +2685,7 @@
     unsigned n =3D 0;
     for (size_t i =3D 0; i < _countof(=
data); ++i)
     {
-        nrpt_exclude_data_t *d =3D &data[i];
+        c=
onst nrpt_exclude_data_t *d =3D &data[i];
         if (d->domains_size =3D=
=3D 0)
         {
             break;
diff --git a/src/plugins/auth-pam/aut=
h-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 3b7bcc2=2E=2E948b6af 10=
0644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/plugins/auth-pam/aut=
h-pam=2Ec
@@ -526,7 +526,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_handle=
_t handle, const int type, const char *argv[],
                        cons=
t char *envp[])
 {
-    struct auth_pam_context *context =3D (struct auth_p=
am_context *)handle;
+    const struct auth_pam_context *context =3D (struc=
t auth_pam_context *)handle;
 
     if (type =3D=3D OPENVPN_PLUGIN_AUTH_USE=
R_PASS_VERIFY && context->foreground_fd >=3D 0)
     {
diff --git a/src/tap=
ctl/main=2Ec b/src/tapctl/main=2Ec
index 6a4a240=2E=2E6697d14 100644
--- a/=
src/tapctl/main=2Ec
+++ b/src/tapctl/main=2Ec
@@ -317,7 +317,7 @@
         =
    return NULL;
         }
 
-        struct tap_adapter_node *conflict =
=3D find_adapter_by_name(requested_name, adapter_list);
+        const stru=
ct tap_adapter_node *conflict =3D find_adapter_by_name(requested_name, adap=
ter_list);
         if (conflict)
         {
             LPOLESTR adapter_=
id =3D NULL;
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/=
unit_tests/openvpn/test_buffer=2Ec
index 326de40=2E=2Ece38bbe 100644
--- a/=
tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/tes=
t_buffer=2Ec
@@ -88,7 +88,7 @@
 
     int maxoutput =3D 0;
     unsigned in=
t blocksize =3D 5;
-    char *separator =3D " ";
+    const char *separator=
 =3D " ";
     output =3D format_hex_ex(input, input_size, maxoutput, block=
size, separator, &gc);
     assert_string_equal(output, "0100ff10ff 00f00f0=
90a");
 
@@ -174,7 +174,7 @@
     /* With a max length of 2, no aggregation=
 should take place */
     buffer_list_aggregate_separator(ctx->one_two_thr=
ee, 2, testsep);
     assert_int_equal(ctx->one_two_three->size, 3);
-    s=
truct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    const stru=
ct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
     assert_buf_eq=
uals_str(buf, teststr1);
 }
 
@@ -189,7 +189,7 @@
      */
     buffer_list=
_aggregate_separator(ctx->one_two_three, strlen(expected) + 1, testsep);
  =
   assert_int_equal(ctx->one_two_three->size, 2);
-    struct buffer *buf =
=3D buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf =3D=
 buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, expe=
cted);
 }
 
@@ -201,7 +201,7 @@
     /* Aggregate all */
     buffer_list_a=
ggregate_separator(ctx->one_two_three, 1 << 16, testsep);
     assert_int_e=
qual(ctx->one_two_three->size, 1);
-    struct buffer *buf =3D buffer_list_=
peek(ctx->one_two_three);
+    const struct buffer *buf =3D buffer_list_pee=
k(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 testsep tes=
tstr2 testsep teststr3 testsep);
 }
 
@@ -213,7 +213,7 @@
     /* Aggregate=
 all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, t=
estnosep);
     assert_int_equal(ctx->one_two_three->size, 1);
-    struct =
buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    const struct buf=
fer *buf =3D buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_s=
tr(buf, teststr1 teststr2 teststr3);
 }
 
@@ -226,7 +226,7 @@
     /* Aggre=
gate all */
     buffer_list_aggregate_separator(bl_zerolen, 1 << 16, testn=
osep);
     assert_int_equal(bl_zerolen->size, 1);
-    struct buffer *buf =
=3D buffer_list_peek(bl_zerolen);
+    const struct buffer *buf =3D buffer_=
list_peek(bl_zerolen);
     assert_buf_equals_str(buf, "");
 }
 
@@ -239,7 =
+239,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_=
emptybuffers, 1 << 16, testnosep);
     assert_int_equal(bl_emptybuffers->s=
ize, 1);
-    struct buffer *buf =3D buffer_list_peek(bl_emptybuffers);
+  =
  const struct buffer *buf =3D buffer_list_peek(bl_emptybuffers);
     asse=
rt_int_equal(BLEN(buf), 0);
 }
 
diff --git a/tests/unit_tests/openvpn/test=
_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec
index 77cf295=2E=2E0=
7c54b4 100644
--- a/tests/unit_tests/openvpn/test_crypto=2Ec
+++ b/tests/un=
it_tests/openvpn/test_crypto=2Ec
@@ -482,9 +482,9 @@
 crypto_test_hkdf_expa=
nd_testa1(void **state)
 {
     /* RFC 5889 A=2E1 Test Case 1 */
-    uint8=
_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc=
, 0x3f,
-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, =
0xc7, 0x3b, 0xb5, 0x0f,
-                        0x9c, 0x31, 0x22, 0xec, 0x=
84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
+    const uint8_t prk[32] =3D { 0x07, =
0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,
+              =
                0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5,=
 0x0f,
+                              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0=
xd7, 0xc2, 0xb3, 0xe5 };
 
     uint8_t info[10] =3D { 0xf0, 0xf1, 0xf2, 0x=
f3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
 
@@ -503,9 +503,9 @@
 crypto_tes=
t_hkdf_expand_testa2(void **state)
 {
     /* RFC 5889 A=2E2 Test Case 2 */=

-    uint8_t prk[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a,=
 0x06, 0x10, 0x4c,
-                        0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0=
xef, 0x76, 0x00, 0x14, 0x90, 0x46,
-                        0x71, 0x01, 0x4=
a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };
+    const uint8_t prk[32] =
=3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,
+  =
                            0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00,=
 0x14, 0x90, 0x46,
+                              0x71, 0x01, 0x4a, 0x19, 0=
x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };
 
     uint8_t info[80] =3D { 0xb0, 0x=
b1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb,
           =
               0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, =
0xc6, 0xc7,
@@ -534,11 +534,11 @@
 crypto_test_hkdf_expand_testa3(void **st=
ate)
 {
     /* RFC 5889 A=2E3 Test Case 3 */
-    uint8_t prk[32] =3D { 0x=
19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa9,
-          =
              0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0=
xdb,
-                        0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3=
c, 0xcb, 0x04 };
+    const uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0=
x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa9,
+                              0x1=
d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0xdb,
+           =
                   0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x=
04 };
 
-    uint8_t info[] =3D { 0 };
+    const uint8_t info[] =3D { 0 };=

 
     int L =3D 42;
     uint8_t okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0x=
a5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,
@@ -558,9 +558,9 @@
     /* tests t=
he HDKF with a label/okm that OpenVPN itself uses in OpenSSL 3
      * HDKF=
 unit test*/
 
-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2=
e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,
-                        0x0d, 0xc4, 0x7b,=
 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
-                        0=
x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
+    const uin=
t8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0x=
dc, 0x3f,
+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90=
, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
+                              0x9c, 0x31, =
0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
 
     uint8_t info[18] =
=3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,
               =
           0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };
@@ -680,=
7 +680,7 @@
 static int
 crypto_test_epoch_setup(void **state)
 {
-    uint=
16_t *num_future_keys =3D (uint16_t *)*state;
+    const uint16_t *num_futu=
re_keys =3D (uint16_t *)*state;
     struct epoch_test_state *data =3D call=
oc(1, sizeof(struct epoch_test_state));
 
     data->gc =3D gc_new();
diff =
--git a/tests/unit_tests/openvpn/test_cryptoapi=2Ec b/tests/unit_tests/open=
vpn/test_cryptoapi=2Ec
index 508afc9=2E=2E37bbe92 100644
--- a/tests/unit_t=
ests/openvpn/test_cryptoapi=2Ec
+++ b/tests/unit_tests/openvpn/test_cryptoa=
pi=2Ec
@@ -233,7 +233,7 @@
         const CERT_CONTEXT *ctx =3D NULL;
     =
    while ((ctx =3D CertEnumCertificatesInStore(user_store, ctx)))
        =
 {
-            char *friendly_name =3D get_cert_name(ctx, &gc);
+         =
   const char *friendly_name =3D get_cert_name(ctx, &gc);
             if (=
!lookup_cert(friendly_name)) /* not our cert */
             {
            =
     continue;
@@ -310,7 +310,7 @@
          */
         assert_non_null(ct=
x);
 
-        char *friendly_name =3D get_cert_name(ctx, &gc);
+        co=
nst char *friendly_name =3D get_cert_name(ctx, &gc);
         struct test_c=
ert *found =3D lookup_cert(friendly_name);
         assert_non_null(found);=

         assert_string_equal(found->cname, c->cname);
@@ -343,7 +343,7 @@
=
          */
         assert_non_null(ctx);
 
-        char *friendly_name =
=3D get_cert_name(ctx, &gc);
+        const char *friendly_name =3D get_cer=
t_name(ctx, &gc);
         struct test_cert *found =3D lookup_cert(friendly=
_name);
         assert_non_null(found);
         assert_string_equal(found=
->issuer, c->issuer);
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b=
/tests/unit_tests/openvpn/test_misc=2Ec
index 5f03860=2E=2Ea41c27b 100644
-=
-- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/=
test_misc=2Ec
@@ -300,7 +300,7 @@
     {
         for (ptr_type i =3D 1; i =
<=3D 16; ++i)
         {
-            struct hash_element *item =3D hash_lo=
okup_by_value(nhash, (void *)i);
+            const struct hash_element *it=
em =3D hash_lookup_by_value(nhash, (void *)i);
             hash_remove_by_=
value(nhash, (void *)i);
             /* check item got removed if it was p=
resent before */
             if (item)
diff --git a/tests/unit_tests/openv=
pn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index d6b63d0=2E=2E=
887c492 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit=
_tests/openvpn/test_ssl=2Ec
@@ -676,7 +676,7 @@
     openvpn_encrypt(&buf, =
encrypt_workspace, &co);
 
     /* separate buffer in authenticated data an=
d encrypted data */
-    uint8_t *ad_start =3D BPTR(&buf);
+    const uint8=
_t *ad_start =3D BPTR(&buf);
     buf_advance(&buf, 4);
 
     if (epoch)
d=
iff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec b=
/tests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec
index a861bf=
d=2E=2E89f0642 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_a=
nd_replace=2Ec
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_repl=
ace=2Ec
@@ -12,7 +12,7 @@
 static void
 pass_any_null_param__returns_null(v=
oid **state)
 {
-    char DUMMY[] =3D "DUMMY";
+    const char DUMMY[] =3D =
"DUMMY";
 
     assert_null(searchandreplace(NULL, DUMMY, DUMMY));
     ass=
ert_null(searchandreplace(DUMMY, NULL, DUMMY));
@@ -22,8 +22,8 @@
 static v=
oid
 pass_any_empty_string__returns_null(void **state)
 {
-    char DUMMY[]=
 =3D "DUMMY";
-    char EMPTY[] =3D "";
+    const char DUMMY[] =3D "DUMMY"=
;
+    const char EMPTY[] =3D "";
 
     assert_null(searchandreplace(EMPTY=
, DUMMY, DUMMY));
     assert_null(searchandreplace(DUMMY, EMPTY, DUMMY));
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63c26a6=
6761f877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 15
Gerrit=
-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--tRQOz3FJOGg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1661?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Remove instances of constVariable/constVar=
iablePointer cppcheck warnings<br><br>Of varied usefulness, but easier to j=
ust address all of<br>them=2E<br><br>Also change vpn_* parameters of dco_ne=
w_peer to const since<br>that is required by one of the changes and it work=
s (and would<br>happen anyway when doing constParameterPointer)=2E<br><br>C=
hange-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1661<br>Message-Id: &lt;20260824162651=2E3228-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38646=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M sa=
mple/sample-plugins/defer/multi-auth=2Ec<br>M sample/sample-plugins/log/log=
=2Ec<br>M sample/sample-plugins/log/log_v3=2Ec<br>M sample/sample-plugins/s=
imple/simple=2Ec<br>M src/openvpn/argv=2Ec<br>M src/openvpn/auth_token=2Ec<=
br>M src/openvpn/base64=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/bu=
ffer=2Eh<br>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/crypto=2Ec<br>M src=
/openvpn/crypto_epoch=2Ec<br>M src/openvpn/cryptoapi=2Ec<br>M src/openvpn/d=
co=2Ec<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<b=
r>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn=
/dns=2Ec<br>M src/openvpn/event=2Ec<br>M src/openvpn/forward=2Ec<br>M src/o=
penvpn/init=2Ec<br>M src/openvpn/list=2Ec<br>M src/openvpn/manage=2Ec<br>M =
src/openvpn/misc=2Ec<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mtcp=2Ec<br>=
M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/networki=
ng_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_parse=2E=
c<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/pool=2Ec<br>M src/open=
vpn/proxy=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/route=2Ec<br>M src=
/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/ssl=2Ec<br=
>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/ope=
nvpn/tun=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnmsica/msica_arg=2Ec=
<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/openvpnserv/interactive=2E=
c<br>M src/plugins/auth-pam/auth-pam=2Ec<br>M src/tapctl/main=2Ec<br>M test=
s/unit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn/test_cry=
pto=2Ec<br>M tests/unit_tests/openvpn/test_cryptoapi=2Ec<br>M tests/unit_te=
sts/openvpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>M t=
ests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec<br>56 files ch=
anged, 163 insertions(+), 164 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/de=
v-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><sp=
an>index 2e3350b=2E=2E900e03c 100644</span><br><span>--- a/dev-tools/cppche=
ck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</span><=
br><span>@@ -3,8 +3,6 @@</span><br><span> constParameter</span><br><span> c=
onstParameterCallback</span><br><span> constParameterPointer</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-constVariable</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-constVariablePointer</span><br><span> inval=
idPrintfArgType_sint</span><br><span> invalidPrintfArgType_uint</span><br><=
span> usleepCalled</span><br><span>diff --git a/sample/sample-plugins/defer=
/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec</span><br><spa=
n>index f6bbf44=2E=2Ebacf557 100644</span><br><span>--- a/sample/sample-plu=
gins/defer/multi-auth=2Ec</span><br><span>+++ b/sample/sample-plugins/defer=
/multi-auth=2Ec</span><br><span>@@ -381,7 +381,7 @@</span><br><span>     }<=
/span><br><span>     const char **argv =3D args-&gt;argv;</span><br><span> =
    const char **envp =3D args-&gt;envp;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct plugin_context *context =3D (struct plugin_co=
ntext *)args-&gt;handle;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const struct plugin_context *context =3D (struct plugin_context *)=
args-&gt;handle;</span><br><span>     struct plugin_per_client_context *pcc=
 =3D</span><br><span>         (struct plugin_per_client_context *)args-&gt;=
per_client_context;</span><br><span>     switch (args-&gt;type)</span><br><=
span>@@ -399,7 +399,7 @@</span><br><span> OPENVPN_EXPORT void *</span><br><=
span> openvpn_plugin_client_constructor_v1(openvpn_plugin_handle_t handle)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct plugin_context *context =3D (struct plugin_context *)handle;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_co=
ntext *context =3D (struct plugin_context *)handle;</span><br><span>     pl=
og(context, PLOG_NOTE, &quot;FUNC: openvpn_plugin_client_constructor_v1&quo=
t;);</span><br><span>     return calloc(1, sizeof(struct plugin_per_client_=
context));</span><br><span> }</span><br><span>@@ -407,7 +407,7 @@</span><br=
><span> OPENVPN_EXPORT void</span><br><span> openvpn_plugin_client_destruct=
or_v1(openvpn_plugin_handle_t handle, void *per_client_context)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct plu=
gin_context *context =3D (struct plugin_context *)handle;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_context *cont=
ext =3D (struct plugin_context *)handle;</span><br><span>     plog(context,=
 PLOG_NOTE, &quot;FUNC: openvpn_plugin_client_destructor_v1&quot;);</span><=
br><span>     free(per_client_context);</span><br><span> }</span><br><span>=
diff --git a/sample/sample-plugins/log/log=2Ec b/sample/sample-plugins/log/=
log=2Ec</span><br><span>index 330e3e0=2E=2E76350ee 100644</span><br><span>-=
-- a/sample/sample-plugins/log/log=2Ec</span><br><span>+++ b/sample/sample-=
plugins/log/log=2Ec</span><br><span>@@ -173,7 +173,7 @@</span><br><span> op=
envpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const =
char *argv[],</span><br><span>                        const char *envp[])</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct plugin_context *context =3D (struct plugin_context *)handle;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_con=
text *context =3D (struct plugin_context *)handle;</span><br><span> </span>=
<br><span>     show(type, argv, envp);</span><br><span> </span><br><span>di=
ff --git a/sample/sample-plugins/log/log_v3=2Ec b/sample/sample-plugins/log=
/log_v3=2Ec</span><br><span>index d2d44c7=2E=2E09c6735 100644</span><br><sp=
an>--- a/sample/sample-plugins/log/log_v3=2Ec</span><br><span>+++ b/sample/=
sample-plugins/log/log_v3=2Ec</span><br><span>@@ -245,7 +245,7 @@</span><br=
><span> openvpn_plugin_func_v3(const int version, struct openvpn_plugin_arg=
s_func_in const *args,</span><br><span>                        struct openv=
pn_plugin_args_func_return *retptr)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct plugin_context *context =3D (st=
ruct plugin_context *)args-&gt;handle;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct plugin_context *context =3D (struct plu=
gin_context *)args-&gt;handle;</span><br><span> </span><br><span>     print=
f(&quot;\nopenvpn_plugin_func_v3() :::::&gt;&gt; &quot;);</span><br><span> =
    show(args-&gt;type, args-&gt;argv, args-&gt;envp);</span><br><span>diff=
 --git a/sample/sample-plugins/simple/simple=2Ec b/sample/sample-plugins/si=
mple/simple=2Ec</span><br><span>index 687a633=2E=2E3182be0 100644</span><br=
><span>--- a/sample/sample-plugins/simple/simple=2Ec</span><br><span>+++ b/=
sample/sample-plugins/simple/simple=2Ec</span><br><span>@@ -104,7 +104,7 @@=
</span><br><span> openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, co=
nst int type, const char *argv[],</span><br><span>                        c=
onst char *envp[])</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct plugin_context *context =3D (struct plugin_conte=
xt *)handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct plugin_context *context =3D (struct plugin_context *)handle;</spa=
n><br><span> </span><br><span>     /* get username/password from envp strin=
g array */</span><br><span>     const char *username =3D get_env(&quot;user=
name&quot;, envp);</span><br><span>diff --git a/src/openvpn/argv=2Ec b/src/=
openvpn/argv=2Ec</span><br><span>index 6a5d92e=2E=2E028671d 100644</span><b=
r><span>--- a/src/openvpn/argv=2Ec</span><br><span>+++ b/src/openvpn/argv=
=2Ec</span><br><span>@@ -359,7 +359,7 @@</span><br><span>      *</span><br>=
<span>      */</span><br><span>     size_t argc =3D argres-&gt;argc;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    char *f =3D argv_prep_fo=
rmat(format, delim, &amp;argc, &amp;argres-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *f =3D argv_prep_format(fo=
rmat, delim, &amp;argc, &amp;argres-&gt;gc);</span><br><span>     if (f =3D=
=3D NULL)</span><br><span>     {</span><br><span>         goto out;</span><=
br><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=
=2Ec</span><br><span>index bd90212=2E=2Ef928a41 100644</span><br><span>--- =
a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_token=
=2Ec</span><br><span>@@ -235,7 +235,7 @@</span><br><span>      * a new toke=
n with the empty username since we do not want to loose</span><br><span>   =
   * the information that the username cannot be trusted</span><br><span>  =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key_=
state *ks =3D &amp;multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct key_state *=
ks =3D &amp;multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span=
>     if (ks-&gt;auth_token_state_flags &amp; AUTH_TOKEN_VALID_EMPTYUSER)</=
span><br><span>     {</span><br><span>         hmac_ctx_update(ctx, (const =
uint8_t *)&quot;&quot;, 0);</span><br><span>diff --git a/src/openvpn/base64=
=2Ec b/src/openvpn/base64=2Ec</span><br><span>index 7af8976=2E=2E5752844 10=
0644</span><br><span>--- a/src/openvpn/base64=2Ec</span><br><span>+++ b/src=
/openvpn/base64=2Ec</span><br><span>@@ -161,7 +161,7 @@</span><br><span> {<=
/span><br><span>     const char *p;</span><br><span>     unsigned char *q;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned char *e =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
unsigned char *e =3D NULL;</span><br><span> </span><br><span>     q =3D dat=
a;</span><br><span>     if (size &gt;=3D 0)</span><br><span>diff --git a/sr=
c/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 8c19902=
=2E=2E2b4d05d 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br=
><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -500,7 +500,7 @@</sp=
an><br><span> void</span><br><span> buf_null_terminate(struct buffer *buf)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 char *last =3D (char *)BLAST(buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *last =3D (char *)BLAST(buf);</span><br><spa=
n>     if (last &amp;&amp; *last =3D=3D &#39;\0&#39;) /* already terminated=
? */</span><br><span>     {</span><br><span>         return;</span><br><spa=
n>@@ -523,7 +523,7 @@</span><br><span> {</span><br><span>     while (true)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        char *last =3D (char *)BLAST(buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const char *last =3D (char *)BLAST(buf);</s=
pan><br><span>         if (!last)</span><br><span>         {</span><br><spa=
n>             break;</span><br><span>diff --git a/src/openvpn/buffer=2Eh b=
/src/openvpn/buffer=2Eh</span><br><span>index 651aaed=2E=2Ebc5cffb 100644</=
span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openv=
pn/buffer=2Eh</span><br><span>@@ -1318,7 +1318,7 @@</span><br><span> static=
 inline bool</span><br><span> buf_copy_n(struct buffer *dest, struct buffer=
 *src, int n)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    uint8_t *cp =3D buf_read_alloc(src, n);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *cp =3D buf_read_alloc=
(src, n);</span><br><span>     if (!cp)</span><br><span>     {</span><br><s=
pan>         return false;</span><br><span>@@ -1409,7 +1409,7 @@</span><br>=
<span> static inline bool</span><br><span> buf_read(struct buffer *src, voi=
d *dest, int size)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint8_t *cp =3D buf_read_alloc(src, size);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *cp =3D buf_re=
ad_alloc(src, size);</span><br><span>     if (!cp)</span><br><span>     {</=
span><br><span>         return false;</span><br><span>diff --git a/src/open=
vpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec</span><br><span>index 45f138c=
=2E=2E48797b0 100644</span><br><span>--- a/src/openvpn/comp-lz4=2Ec</span><=
br><span>+++ b/src/openvpn/comp-lz4=2Ec</span><br><span>@@ -164,7 +164,7 @@=
</span><br><span>     ASSERT(buf_init(&amp;work, frame-&gt;buf=2Eheadroom))=
;</span><br><span> </span><br><span>     /* do unframing/swap (assumes buf-=
&gt;len &gt; 0) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 uint8_t *head =3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint8_t *head =3D BPTR(buf);</span><br><span>     c =3D=
 *head;</span><br><span> </span><br><span>     /* Not compressed */</span><=
br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span=
><br><span>index 8f59838=2E=2E8bbc566 100644</span><br><span>--- a/src/open=
vpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span=
>@@ -1212,7 +1212,7 @@</span><br><span> </span><br><span>     /* init impli=
cit IV */</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi=2Eencrypt=2Ec=
ipher;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi=2Eencrypt=2Ecipher;</span><br><=
span>         if (cipher_ctx_mode_aead(cipher))</span><br><span>         {<=
/span><br><span>             ASSERT(cipher_ctx_iv_length(cipher) &lt;=3D OP=
ENVPN_MAX_IV_LENGTH);</span><br><span>@@ -1922,7 +1922,7 @@</span><br><span=
>     const char *seed =3D &quot;tls1-prf-test&quot;;</span><br><span>     =
const char *secret =3D &quot;tls1-prf-test-secret&quot;;</span><br><span>  =
   uint8_t out[8];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 uint8_t expected_out[] =3D { &#39;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#39;, =
&#39;@&#39;, &#39;s&#39;, &#39;u&#39;, 0x95 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const uint8_t expected_out[] =3D { &#39;q&#3=
9;, &#39;D&#39;, 0xfe, &#39;%&#39;, &#39;@&#39;, &#39;s&#39;, &#39;u&#39;, =
0x95 };</span><br><span> </span><br><span>     int ret =3D ssl_tls1_PRF((ui=
nt8_t *)seed, strlen(seed), (uint8_t *)secret,</span><br><span>            =
                strlen(secret), out, sizeof(out));</span><br><span>diff --g=
it a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br>=
<span>index 37933a1=2E=2E158c841 100644</span><br><span>--- a/src/openvpn/c=
rypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><b=
r><span>@@ -213,7 +213,7 @@</span><br><span>      *</span><br><span>      *=
 The last generated key might have been moved to the decrypt key already=2E=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct key_ctx *highest_future_key =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct key_ctx *highest_future_key =3D=
</span><br><span>         &amp;co-&gt;epoch_data_keys_future[co-&gt;epoch_d=
ata_keys_future_count - 1];</span><br><span> </span><br><span>     ASSERT(c=
o-&gt;epoch_key_recv=2Eepoch =3D=3D 1 || highest_future_key-&gt;epoch =3D=
=3D co-&gt;epoch_key_recv=2Eepoch</span><br><span>diff --git a/src/openvpn/=
cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec</span><br><span>index 0f95ab7=2E=
=2Ead2706c 100644</span><br><span>--- a/src/openvpn/cryptoapi=2Ec</span><br=
><span>+++ b/src/openvpn/cryptoapi=2Ec</span><br><span>@@ -225,7 +225,6 @@<=
/span><br><span>     const CERT_INFO *info =3D cert_ctx-&gt;pCertInfo;</spa=
n><br><span>     const CERT_EXTENSION *ext;</span><br><span>     DWORD cbex=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *pvext;</s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     co=
nst WCHAR *tmpl_name =3D wide_string(cert_prop, &amp;gc);</span><br><span> =
</span><br><span>@@ -233,7 +232,7 @@</span><br><span>     ext =3D CertFindE=
xtension(szOID_CERTIFICATE_TEMPLATE, info-&gt;cExtension, info-&gt;rgExtens=
ion);</span><br><span>     if (ext)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        pvext =3D decode_object(&amp;g=
c, X509_CERTIFICATE_TEMPLATE, &amp;ext-&gt;Value, 0, &amp;cbext);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const void *pvext =3D=
 decode_object(&amp;gc, X509_CERTIFICATE_TEMPLATE, &amp;ext-&gt;Value, 0, &=
amp;cbext);</span><br><span>         if (pvext &amp;&amp; cbext &gt;=3D siz=
eof(CERT_TEMPLATE_EXT))</span><br><span>         {</span><br><span>        =
     const CERT_TEMPLATE_EXT *cte =3D (const CERT_TEMPLATE_EXT *)pvext;</sp=
an><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><=
br><span>index ce73701=2E=2E8eae4bf 100644</span><br><span>--- a/src/openvp=
n/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -112=
,7 +112,7 @@</span><br><span>     for (int i =3D 0; i &lt; KEY_SCAN_SIZE; +=
+i)</span><br><span>     {</span><br><span>         struct key_state *ks =
=3D get_key_scan(multi, i);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_c=
tx_bi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span>=
<br><span> </span><br><span>         if (ks =3D=3D primary)</span><br><span=
>         {</span><br><span>@@ -577,7 +577,7 @@</span><br><span>           =
              struct sockaddr_storage *local)</span><br><span> {</span><br>=
<span> #if ENABLE_IP_PKTINFO</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct context *c =3D &amp;mi-&gt;context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct context *c =3D &amp;mi-&=
gt;context;</span><br><span> </span><br><span>     if (!proto_is_udp(c-&gt;=
c2=2Elink_sockets[0]-&gt;info=2Eproto)</span><br><span>         || !(c-&gt;=
options=2Esockflags &amp; SF_USE_IP_PKTINFO))</span><br><span>@@ -625,7 +62=
5,7 @@</span><br><span> int</span><br><span> dco_multi_add_new_peer(struct =
multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &amp;mi=
-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br>=
<span>     int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><=
span>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span=
>@@ -646,14 +646,14 @@</span><br><span> </span><br><span>     /* In server =
mode we need to fetch the remote addresses from the push config */</span><b=
r><span>     struct in_addr vpn_ip4 =3D { 0 };</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct in_addr *vpn_addr4 =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct in_addr *vpn_=
addr4 =3D NULL;</span><br><span>     if (c-&gt;c2=2Epush_ifconfig_defined)<=
/span><br><span>     {</span><br><span>         vpn_ip4=2Es_addr =3D htonl(=
c-&gt;c2=2Epush_ifconfig_local);</span><br><span>         vpn_addr4 =3D &am=
p;vpn_ip4;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct in6_addr *vpn_addr6 =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct in6_a=
ddr *vpn_addr6 =3D NULL;</span><br><span>     if (c-&gt;c2=2Epush_ifconfig_=
ipv6_defined)</span><br><span>     {</span><br><span>         vpn_addr6 =3D=
 &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local;</span><br><span>@@ -702,7 +702,7=
 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &a=
mp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct context *c =3D &amp;mi-&gt;context;</span><br><span>     if=
 (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if=
 defined(_WIN32)</span><br><span>@@ -750,7 +750,7 @@</span><br><span>     }=
</span><br><span>     ASSERT(TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct context *c =3D &amp;mi-&gt;context;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct context *c =3D &=
amp;mi-&gt;context;</span><br><span> </span><br><span>     if (mi-&gt;conte=
xt=2Ec2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span>dif=
f --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><=
br><span>index eaca86b=2E=2Ed933aaf 100644</span><br><span>--- a/src/openvp=
n/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><=
br><span>@@ -134,7 +134,8 @@</span><br><span> </span><br><span> int</span><=
br><span> dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, str=
uct sockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-             struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, stru=
ct in6_addr *vpn_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             const=
 struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>     struct =
ifdrv drv;</span><br><span>     nvlist_t *nvl, *local_nvl, *remote_nvl;</sp=
an><br><span>diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_in=
ternal=2Eh</span><br><span>index da07780=2E=2Efcf8aca 100644</span><br><spa=
n>--- a/src/openvpn/dco_internal=2Eh</span><br><span>+++ b/src/openvpn/dco_=
internal=2Eh</span><br><span>@@ -60,7 +60,7 @@</span><br><span>  */</span><=
br><span> </span><br><span> int dco_new_peer(dco_context_t *dco, unsigned i=
nt peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                 struct sockaddr *=
remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 struct socka=
ddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6);</span><br><span> </span><br><span> int dco_del_peer(dco_context_t *=
dco, unsigned int peerid);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index =
40746bd=2E=2E56f6259 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec=
</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -222,7 =
+222,8 @@</span><br><span> </span><br><span> int</span><br><span> dco_new_p=
eer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr *local=
addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             str=
uct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ip=
v6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             str=
uct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             const struct in6_addr *v=
pn_ipv6)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>     const char *remotestr =3D &quot;[undefined]&quo=
t;;</span><br><span>@@ -697,7 +698,7 @@</span><br><span> {</span><br><span>=
     dco_context_t *dco =3D arg;</span><br><span>     struct nlattr *tb[CTR=
L_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct genlmsghdr *gnlh =3D nl=
msg_data(nlmsg_hdr(msg));</span><br><span> </span><br><span>     nla_parse(=
tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(gnlh, 0), NUL=
L);</span><br><span> </span><br><span>@@ -706,7 +707,7 @@</span><br><span> =
        return NL_SKIP;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *mcgrp;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct nlattr *m=
cgrp;</span><br><span>     int rem_mcgrp;</span><br><span>     nla_for_each=
_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)</span><br><span>     =
{</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_wi=
n=2Ec</span><br><span>index 2e26f2a=2E=2Eb3268bc 100644</span><br><span>---=
 a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</s=
pan><br><span>@@ -285,8 +285,8 @@</span><br><span>     msg(D_DCO_DEBUG, &qu=
ot;%s&quot;, __func__);</span><br><span> </span><br><span>     int ai_famil=
y =3D sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *local =3D sock-&gt;i=
nfo=2Elsa-&gt;bind_local;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct addrinfo *cur =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct addrinfo *local =3D sock-&gt;info=2Elsa=
-&gt;bind_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct addrinfo *cur =3D NULL;</span><br><span> </span><br><span>   =
  for (cur =3D local; cur; cur =3D cur-&gt;ai_next)</span><br><span>     {<=
/span><br><span>@@ -334,7 +334,7 @@</span><br><span>     struct addrinfo *r=
emoteaddr =3D sock-&gt;info=2Elsa-&gt;current_remote;</span><br><span> </sp=
an><br><span>     struct sockaddr *local =3D NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct sockaddr *remote =3D remoteaddr-&gt=
;ai_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct sockaddr *remote =3D remoteaddr-&gt;ai_addr;</span><br><span> </span=
><br><span>     if (remoteaddr-&gt;ai_protocol =3D=3D IPPROTO_TCP || remote=
addr-&gt;ai_socktype =3D=3D SOCK_STREAM)</span><br><span>     {</span><br><=
span>@@ -348,7 +348,7 @@</span><br><span>     if (sock-&gt;bind_local)</spa=
n><br><span>     {</span><br><span>         /* Use first local address with=
 correct address family */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct addrinfo *bind =3D sock-&gt;info=2Elsa-&gt;bind_local;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 addrinfo *bind =3D sock-&gt;info=2Elsa-&gt;bind_local;</span><br><span>   =
      while (bind &amp;&amp; !local)</span><br><span>         {</span><br><=
span>             if (bind-&gt;ai_family =3D=3D remote-&gt;sa_family)</span=
><br><span>@@ -415,8 +415,9 @@</span><br><span> }</span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_new_=
peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struc=
t sockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-             struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct=
 in6_addr *vpn_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t =
sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             str=
uct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             const struct in_addr *vpn_ip=
v4, const struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>   =
  msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd &quot; SOCKET_PRINTF, __func__,=
 peerid, sd);</span><br><span> </span><br><span>@@ -745,7 +746,7 @@</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br>=
<span>     int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct tuntap *tt =3D dco-&gt;tt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct tuntap *tt =3D dco-&gt;tt;</span><br=
><span> </span><br><span>     if (!tuntap_defined(tt))</span><br><span>    =
 {</span><br><span>@@ -869,7 +870,7 @@</span><br><span> int</span><br><span=
> dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_o=
n_err)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct tuntap *tt =3D c-&gt;c1=2Etuntap;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct tuntap *tt =3D c-&gt;c1=2Etun=
tap;</span><br><span> </span><br><span>     if (!tuntap_defined(tt))</span>=
<br><span>     {</span><br><span>@@ -898,7 +899,7 @@</span><br><span> int</=
span><br><span> dco_get_peer_stats(struct context *c, const bool raise_sigu=
sr1_on_err)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct tuntap *tt =3D c-&gt;c1=2Etuntap;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct tuntap *tt =3D c-&gt;c1=
=2Etuntap;</span><br><span> </span><br><span>     if (!tuntap_defined(tt))<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/dns=2Ec b/s=
rc/openvpn/dns=2Ec</span><br><span>index 1465cdf=2E=2E7f4dde4 100644</span>=
<br><span>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=
=2Ec</span><br><span>@@ -132,7 +132,7 @@</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 =
*)ai-&gt;ai_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)ai-&gt;ai_=
addr;</span><br><span>         server-&gt;addr[server-&gt;addr_count]=2Ein=
=2Ea6 =3D sin6-&gt;sin6_addr;</span><br><span>     }</span><br><span> </spa=
n><br><span>@@ -156,7 +156,7 @@</span><br><span>     /* Append all domains =
to the end of the list */</span><br><span>     while (*domains)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ch=
ar *domain =3D *domains++;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const char *domain =3D *domains++;</span><br><span>         =
if (!validate_domain(domain))</span><br><span>         {</span><br><span>  =
           return false;</span><br><span>@@ -699,7 +699,7 @@</span><br><spa=
n> run_up_down_command(bool up, struct options *o, const struct tuntap *tt,=
</span><br><span>                     struct dns_updown_runner_info *updown=
_runner)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct dns_options *dns =3D &amp;o-&gt;dns_options;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct dns_options *dns=
 =3D &amp;o-&gt;dns_options;</span><br><span>     if (!dns-&gt;updown || (o=
-&gt;up_script &amp;&amp; !dns_updown_user_set(dns) &amp;&amp; !dns_updown_=
forced(dns)))</span><br><span>     {</span><br><span>         return;</span=
><br><span>@@ -864,7 +864,7 @@</span><br><span>     }</span><br><span> #ifd=
ef _WIN32</span><br><span>     /* Don&#39;t use iservice in DHCP mode */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap_option=
s *tto =3D &amp;o-&gt;tuntap_options;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct tuntap_options *tto =3D &amp;o-&gt;tunta=
p_options;</span><br><span>     if (tto-&gt;ip_win32_type =3D=3D IPW32_SET_=
DHCP_MASQ || tto-&gt;ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)</span><br><sp=
an>     {</span><br><span>         return;</span><br><span>diff --git a/src=
/openvpn/event=2Ec b/src/openvpn/event=2Ec</span><br><span>index 9e17807=2E=
=2E8b7716a 100644</span><br><span>--- a/src/openvpn/event=2Ec</span><br><sp=
an>+++ b/src/openvpn/event=2Ec</span><br><span>@@ -557,7 +557,7 @@</span><b=
r><span> ep_del(struct event_set *es, event_t event)</span><br><span> {</sp=
an><br><span>     struct epoll_event ev;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct ep_set *eps =3D (struct ep_set *)es;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct ep_set *eps=
 =3D (struct ep_set *)es;</span><br><span> </span><br><span>     dmsg(D_EVE=
NT_WAIT, &quot;EP_DEL ev=3D%d&quot;, (int)event);</span><br><span> </span><=
br><span>@@ -572,7 +572,7 @@</span><br><span> static void</span><br><span> =
ep_ctl(struct event_set *es, event_t event, unsigned int rwflags, void *arg=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct ep_set *eps =3D (struct ep_set *)es;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct ep_set *eps =3D (struct ep_set =
*)es;</span><br><span>     struct epoll_event ev;</span><br><span> </span><=
br><span>     CLEAR(ev);</span><br><span>diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 46e1a53=2E=2E2ade321 1=
00644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/s=
rc/openvpn/forward=2Ec</span><br><span>@@ -1213,7 +1213,7 @@</span><br><spa=
n> {</span><br><span>     if (float_sa-&gt;sa_family =3D=3D AF_INET)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const struct sockaddr=
_in *float4 =3D (struct sockaddr_in *)float_sa;</span><br><span>         /*=
 DCO treats IPv4-mapped IPv6 addresses as pure IPv4=2E However, on a</span>=
<br><span>          * dual-stack socket, we need to preserve the mapping ot=
herwise openvpn</span><br><span>          * will not be able to find the pe=
er by its transport address=2E</span><br><span>@@ -1236,7 +1236,7 @@</span>=
<br><span>     }</span><br><span>     else</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr_in6 *fl=
oat6 =3D (struct sockaddr_in6 *)float_sa;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        const struct sockaddr_in6 *float6 =3D (struct=
 sockaddr_in6 *)float_sa;</span><br><span>         memcpy(&amp;out_osaddr-&=
gt;addr=2Ein6, float6, sizeof(struct sockaddr_in6));</span><br><span>     }=
</span><br><span> }</span><br><span>@@ -1366,8 +1366,8 @@</span><br><span> =
        return;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr *link_addr =
=3D &amp;c-&gt;c2=2Eto_link_addr-&gt;dest;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct link_socket_info *lsi =3D get_link_socket_i=
nfo(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct openvpn_sockaddr *link_addr =3D &amp;c-&gt;c2=2Eto_link_addr-&gt;dest;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct li=
nk_socket_info *lsi =3D get_link_socket_info(c);</span><br><span> </span><b=
r><span>     int ip_hdr_offset =3D 0;</span><br><span>     int tun_ip_ver =
=3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;c1=2Etuntap), buf, &amp;ip_hdr_offset)=
;</span><br><span>@@ -1404,7 +1404,7 @@</span><br><span>         }</span><b=
r><span> </span><br><span>         /* drop packets with same dest addr and =
port as remote */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const uint8_t *l4_hdr =3D (uint8_t *)=
pip + ip_hlen;</span><br><span> </span><br><span>         uint16_t link_por=
t =3D ntohs(link_addr-&gt;addr=2Ein4=2Esin_port);</span><br><span> </span><=
br><span>@@ -1451,7 +1451,7 @@</span><br><span>         uint16_t link_port =
=3D ntohs(link_addr-&gt;addr=2Ein6=2Esin6_port);</span><br><span> </span><b=
r><span>         /* drop packets with same dest addr and port as remote */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t *l4_hd=
r =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *l4_hdr =3D (uint=
8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);</span><br><span>         uint1=
6_t src_port =3D ntohs(*(uint16_t *)l4_hdr);</span><br><span>         uint1=
6_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));</span><br=
><span>         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&amp;link_addr-&gt;addr=2Ei=
n6=2Esin6_addr, &amp;pip6-&gt;daddr)) &amp;&amp; (link_port =3D=3D dst_port=
))</span><br><span>@@ -2210,7 +2210,7 @@</span><br><span> </span><br><span>=
                     if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span>       =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  struct event_arg *ev_arg =3D (struct event_arg *)e-&gt;ar=
g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       const struct event_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</s=
pan><br><span>                         if (ev_arg-&gt;type !=3D EVENT_ARG_L=
INK_SOCKET)</span><br><span>                         {</span><br><span>    =
                         c-&gt;c2=2Eevent_set_status =3D ES_ERROR;</span><b=
r><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br>=
<span>index 66bae34=2E=2Ea8e041d 100644</span><br><span>--- a/src/openvpn/i=
nit=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -321,=
8 +321,8 @@</span><br><span> management_callback_remote_entry_count(void *a=
rg)</span><br><span> {</span><br><span>     ASSERT(arg);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D (struct contex=
t *)arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct co=
nnection_list *l =3D c-&gt;options=2Econnection_list;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct context *c =3D (struct c=
ontext *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct connection_list *l =3D c-&gt;options=2Econnection_list;</span><b=
r><span> </span><br><span>     return l-&gt;len;</span><br><span> }</span><=
br><span>@@ -339,7 +339,7 @@</span><br><span> </span><br><span>     if (l-&=
gt;len &gt; 0 &amp;&amp; index &lt; (unsigned int)l-&gt;len)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t connection_entry *ce =3D l-&gt;array[index];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-=
&gt;array[index];</span><br><span>         const char *proto =3D proto2asci=
i(ce-&gt;proto, ce-&gt;af, false);</span><br><span>         const char *sta=
tus =3D (ce-&gt;flags &amp; CE_DISABLED) ? &quot;disabled&quot; : &quot;ena=
bled&quot;;</span><br><span> </span><br><span>@@ -517,7 +517,7 @@</span><br=
><span> {</span><br><span>     struct connection_list *l =3D c-&gt;options=
=2Econnection_list;</span><br><span>     bool ce_defined;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct connection_entry *ce;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct connectio=
n_entry *ce;</span><br><span>     int n_cycles =3D 0;</span><br><span> </sp=
an><br><span>     do</span><br><span>@@ -1563,10 +1563,10 @@</span><br><spa=
n>     /* Tell management interface that we initialized */</span><br><span>=
     if (management)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        in_addr_t *tun_local =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct in6_addr *tun_local6 =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst in_addr_t *tun_local =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct in6_addr *tun_local6 =3D NULL;</span><b=
r><span>         struct openvpn_sockaddr local, remote;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct link_socket_actual *actual=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const stru=
ct link_socket_actual *actual;</span><br><span>         socklen_t sa_len =
=3D sizeof(local);</span><br><span>         const char *detail =3D &quot;SU=
CCESS&quot;;</span><br><span>         if (flags &amp; ISC_ERRORS)</span><br=
><span>@@ -4282,7 +4282,7 @@</span><br><span>     /* On some newer Android =
handsets, changing to a different network</span><br><span>      * often doe=
s not trigger a TCP reset but continue using the old</span><br><span>      =
* connection (e=2Eg=2E using mobile connection when WiFi becomes available =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_soc=
ket_info *lsi =3D get_link_socket_info(c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct link_socket_info *lsi =3D get_link_=
socket_info(c);</span><br><span>     if (lsi &amp;&amp; proto_is_tcp(lsi-&g=
t;proto) &amp;&amp; !samenetwork)</span><br><span>     {</span><br><span>  =
       return -2;</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/o=
penvpn/list=2Ec</span><br><span>index 9e80761=2E=2Ee51dcd0 100644</span><br=
><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2E=
c</span><br><span>@@ -167,7 +167,7 @@</span><br><span> hash_remove_by_value=
(struct hash *hash, void *value)</span><br><span> {</span><br><span>     st=
ruct hash_iterator hi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct hash_element *he;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct hash_element *he;</span><br><span> </span><br><s=
pan>     hash_iterator_init(hash, &amp;hi);</span><br><span>     while ((he=
 =3D hash_iterator_next(&amp;hi)))</span><br><span>diff --git a/src/openvpn=
/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 95ff246=2E=2E2b0=
a661 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>++=
+ b/src/openvpn/manage=2Ec</span><br><span>@@ -3821,7 +3821,7 @@</span><br>=
<span> {</span><br><span>     int ok;</span><br><span>     char *result =3D=
 NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buff=
er *buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct buffer *buf;</span><br><span> </span><br><span>     ok =3D management=
_query_multiline(man, b64_data, prompt, cmd, state, input);</span><br><span=
>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><span>@@ -38=
50,7 +3850,7 @@</span><br><span> {</span><br><span>     int ok;</span><br><=
span>     char *result =3D NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct buffer *buf;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct buffer *buf;</span><br><span> </span><br><s=
pan>     ok =3D management_query_multiline(man, b64_data, prompt, cmd, stat=
e, input);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*inpu=
t))</span><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2E=
c</span><br><span>index a8c88c9=2E=2E54af890 100644</span><br><span>--- a/s=
rc/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><s=
pan>@@ -131,7 +131,7 @@</span><br><span>     struct auth_challenge_info *ac=
;</span><br><span>     const int len =3D strlen(auth_challenge);</span><br>=
<span>     char *work =3D (char *)gc_malloc(len + 1, false, gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    char *cp;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *cp;</span><br><span> <=
/span><br><span>     struct buffer b;</span><br><span>     buf_set_read(&am=
p;b, (const uint8_t *)auth_challenge, len);</span><br><span>diff --git a/sr=
c/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 14112b4=2E=2E=
36bbb43 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span><br><span>++=
+ b/src/openvpn/mss=2Ec</span><br><span>@@ -65,7 +65,7 @@</span><br><span> =
        struct buffer newbuf =3D *buf;</span><br><span>         if (buf_adv=
ance(&amp;newbuf, hlen))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            struct openvpn_tcphdr *tc =3D (=
struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            const struct openvpn_tcphdr *tc =3D (str=
uct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>             if (tc=
-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>             {</spa=
n><br><span>                 mss_fixup_dowork(&amp;newbuf, maxmss);</span><=
br><span>@@ -122,7 +122,7 @@</span><br><span>     newbuf =3D *buf;</span><b=
r><span>     if (buf_advance(&amp;newbuf, 40) &amp;&amp; BLENZ(&amp;newbuf)=
 &gt;=3D sizeof(struct openvpn_tcphdr))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        struct openvpn_tcphdr *tc =
=3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const struct openvpn_tcphdr *tc =3D (st=
ruct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>         if (tc-&g=
t;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>         {</span><br><=
span>             mss_fixup_dowork(&amp;newbuf, maxmss - 20);</span><br><sp=
an>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span=
>index f000283=2E=2E5d88f8a 100644</span><br><span>--- a/src/openvpn/mtcp=
=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -130,7 +=
130,7 @@</span><br><span> void</span><br><span> multi_tcp_dereference_insta=
nce(struct multi_io *multi_io, struct multi_instance *mi)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_sock=
et *sock =3D mi-&gt;context=2Ec2=2Elink_sockets[0];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket *sock =3D mi=
-&gt;context=2Ec2=2Elink_sockets[0];</span><br><span>     if (sock &amp;&am=
p; mi-&gt;socket_set_called)</span><br><span>     {</span><br><span>       =
  event_del(multi_io-&gt;es, socket_event_handle(sock));</span><br><span>di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>inde=
x 632b064=2E=2E6d9c181 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</s=
pan><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -102,7 +102,7 @=
@</span><br><span>     verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-=
&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><b=
r><span>     uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr *=
from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct openvpn_sockaddr *from =3D &amp;m-=
&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int handwindow =3D m-&gt;t=
op=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><span>     if =
(verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESE=
T_V2)</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mult=
i=2Ec</span><br><span>index 20b4f14=2E=2E60a5148 100644</span><br><span>---=
 a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span>=
<br><span>@@ -86,7 +86,7 @@</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>     struct env_set *es;</span><br><span>     bool r=
et =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t plugin_list *plugins;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct plugin_list *plugins;</span><br><span> </span><br><spa=
n>     /* get environmental variable source */</span><br><span>     if (mi =
&amp;&amp; mi-&gt;context=2Ec2=2Ees)</span><br><span>@@ -1793,7 +1793,7 @@<=
/span><br><span>      * Push the first cipher from --data-ciphers to the cl=
ient that</span><br><span>      * the client announces to be supporting=2E<=
/span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    char *push_cipher =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *push_cipher =3D</span><br><span>         ncp_get_b=
est_cipher(o-&gt;ncp_ciphers, peer_info, tls_multi-&gt;remote_ciphername, &=
amp;o-&gt;gc);</span><br><span>     if (push_cipher)</span><br><span>     {=
</span><br><span>@@ -1924,7 +1924,7 @@</span><br><span> static enum client_=
connect_return</span><br><span> ccs_test_deferred_ret_file(struct multi_ins=
tance *mi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct client_connect_defer_state *ccs =3D &amp;(mi-&gt;client_=
connect_defer_state);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct client_connect_defer_state *ccs =3D &amp;(mi-&gt;client_=
connect_defer_state);</span><br><span>     FILE *fp =3D fopen(ccs-&gt;defer=
red_ret_file, &quot;r&quot;);</span><br><span>     if (!fp)</span><br><span=
>     {</span><br><span>@@ -2165,7 +2165,7 @@</span><br><span> {</span><br>=
<span>     ASSERT(mi);</span><br><span>     ASSERT(option_types_found);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct client_connect=
_defer_state *ccs =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct client_connect=
_defer_state *ccs =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><=
span>     enum client_connect_return ret =3D CC_RET_SKIPPED;</span><br><spa=
n> </span><br><span>     ret =3D ccs_test_deferred_ret_file(mi);</span><br>=
<span>@@ -2567,7 +2567,7 @@</span><br><span> override_locked_username(struc=
t multi_instance *mi)</span><br><span> {</span><br><span>     struct tls_mu=
lti *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct options *options =3D &amp;mi-&gt;conte=
xt=2Eoptions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct options *options =3D &amp;mi-&gt;context=2Eoptions;</span><br><s=
pan>     struct tls_session *session =3D &amp;multi-&gt;session[TM_ACTIVE];=
</span><br><span> </span><br><span>     if (!multi-&gt;locked_username)</sp=
an><br><span>@@ -2986,7 +2986,7 @@</span><br><span>     {</span><br><span> =
#if defined(ENABLE_ASYNC_PUSH)</span><br><span>         bool was_unauthenti=
cated =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct key_state *ks =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const struct key_state *ks =3D NULL;</span><br><span> =
        if (mi-&gt;context=2Ec2=2Etls_multi)</span><br><span>         {</sp=
an><br><span>             ks =3D &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;s=
ession[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span>@@ -3919,7 +3919,7 @@<=
/span><br><span> static int</span><br><span> management_callback_n_clients(=
void *arg)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct multi_context *m =3D (struct multi_context *)arg;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct multi_con=
text *m =3D (struct multi_context *)arg;</span><br><span>     return m-&gt;=
n_clients;</span><br><span> }</span><br><span> </span><br><span>@@ -4430,7 =
+4430,7 @@</span><br><span> bool</span><br><span> multi_check_push_ifconfig=
_extra_route(struct multi_instance *mi, in_addr_t dest)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct options *o =
=3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct options *o =3D &amp;mi-&gt;context=2Eoption=
s;</span><br><span>     in_addr_t local_addr, local_netmask;</span><br><spa=
n> </span><br><span>     if (!o-&gt;ifconfig_local || !o-&gt;ifconfig_remot=
e_netmask)</span><br><span>@@ -4452,7 +4452,7 @@</span><br><span> multi_che=
ck_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span><br><spa=
n>                                            struct in6_addr *dest)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const struct options *o =3D &amp;mi-&gt;con=
text=2Eoptions;</span><br><span> </span><br><span>     if (!o-&gt;ifconfig_=
ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</span><br><span>     {</span><b=
r><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/network=
ing_sitnl=2Ec</span><br><span>index b3f8e2b=2E=2Ee6e72d0 100644</span><br><=
span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openv=
pn/networking_sitnl=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><span=
>     struct rtattr *rta =3D RTM_RTA(r);</span><br><span>     size_t len =
=3D n-&gt;nlmsg_len - NLMSG_LENGTH(sizeof(*r));</span><br><span>     unsign=
ed int table, ifindex =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    void *gw =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const void *gw =3D NULL;</span><br><span> </span><br><span>  =
   /* filter-out non-zero dst prefixes */</span><br><span>     if (res-&gt;=
default_only &amp;&amp; r-&gt;rtm_dst_len !=3D 0)</span><br><span>@@ -1179,=
7 +1179,7 @@</span><br><span> net_route_v4_add(openvpn_net_ctx_t *ctx, cons=
t in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span>     =
             const char *iface, uint32_t table, int metric)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t *dst=
_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span=
><br><span>     in_addr_t dst_be =3D 0, gw_be =3D 0;</span><br><span>     c=
har dst_str[INET_ADDRSTRLEN];</span><br><span>     char gw_str[INET_ADDRSTR=
LEN];</span><br><span>@@ -1326,7 +1326,7 @@</span><br><span> #if defined(EN=
ABLE_DCO)</span><br><span>     if (arg &amp;&amp; (strcmp(type, OVPN_FAMILY=
_NAME) =3D=3D 0))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        dco_context_t *dco =3D arg;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const dco_context_t *dco =3D arg=
;</span><br><span>         struct rtattr *data =3D SITNL_NEST(&amp;req=2En,=
 sizeof(req), IFLA_INFO_DATA);</span><br><span> </span><br><span>         /=
* the netlink format is uint8_t for this and using something</span><br><spa=
n>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br>=
<span>index 107b3fa9=2E=2E23741f0 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -1696,7 +1696,7 @@</span><br><span> </span><br><span>     for (int i =3D =
0; i &lt; ce-&gt;local_list-&gt;len; i++)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        struct local_entry *le =
=3D ce-&gt;local_list-&gt;array[i];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        const struct local_entry *le =3D ce-&gt;local_list-=
&gt;array[i];</span><br><span> </span><br><span>         if (proto_is_net(l=
e-&gt;proto) &amp;&amp; string_defined_equal(le-&gt;local, ce-&gt;remote)</=
span><br><span>             &amp;&amp; string_defined_equal(le-&gt;port, ce=
-&gt;remote_port))</span><br><span>@@ -7693,7 +7693,7 @@</span><br><span> #=
ifdef ENABLE_PKCS11</span><br><span>     else if (streq(p[0], &quot;show-pk=
cs11-ids&quot;) &amp;&amp; !p[3])</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        char *provider =3D p[1];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *provide=
r =3D p[1];</span><br><span>         bool cert_private =3D (p[2] =3D=3D NUL=
L ? false : (atoi_warn(p[2], msglevel) !=3D 0));</span><br><span> </span><b=
r><span> #ifdef DEFAULT_PKCS11_MODULE</span><br><span>diff --git a/src/open=
vpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index=
 a8c4aee=2E=2E88ab4d2 100644</span><br><span>--- a/src/openvpn/options_pars=
e=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@=
@ -268,7 +268,7 @@</span><br><span>     while (in_src_get(is, line, sizeof(=
line)))</span><br><span>     {</span><br><span>         (*num_lines)++;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *line_ptr =
=3D line;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char *line_ptr =3D line;</span><br><span>         /* Remove leading spa=
ces */</span><br><span>         while (isspace(*line_ptr))</span><br><span>=
         {</span><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/=
openvpn/options_util=2Ec</span><br><span>index d72ea25c=2E=2E779c38e 100644=
</span><br><span>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/s=
rc/openvpn/options_util=2Ec</span><br><span>@@ -273,7 +273,7 @@</span><br><=
span>         return true;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct pull_filter *f;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct pull_=
filter *f;</span><br><span> </span><br><span>     for (f =3D o-&gt;pull_fil=
ter_list-&gt;head; f; f =3D f-&gt;next)</span><br><span>     {</span><br><s=
pan>diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><spa=
n>index ff74e7c=2E=2E80dec6c 100644</span><br><span>--- a/src/openvpn/pool=
=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -63,7 +6=
3,7 @@</span><br><span> </span><br><span>     for (i =3D 0; i &lt; pool-&gt=
;size; ++i)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct ifconfig_pool_entry *ipe =3D &amp;pool-&gt;list=
[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const s=
truct ifconfig_pool_entry *ipe =3D &amp;pool-&gt;list[i];</span><br><span> =
        if (!ipe-&gt;in_use)</span><br><span>         {</span><br><span>   =
          /*</span><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/openv=
pn/proxy=2Ec</span><br><span>index 9acb2fa=2E=2Ee0700aa 100644</span><br><s=
pan>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec=
</span><br><span>@@ -703,7 +703,7 @@</span><br><span> #if PROXY_DIGEST_AUTH=
</span><br><span>         else if (p-&gt;auth_method =3D=3D HTTP_AUTH_DIGES=
T &amp;&amp; !processed)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            char *pa =3D p-&gt;proxy_authen=
ticate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
const char *pa =3D p-&gt;proxy_authenticate;</span><br><span>             c=
onst int method =3D p-&gt;auth_method;</span><br><span>             ASSERT(=
pa);</span><br><span> </span><br><span>diff --git a/src/openvpn/push=2Ec b/=
src/openvpn/push=2Ec</span><br><span>index 5b15f71=2E=2Efa7bf1e 100644</spa=
n><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/pu=
sh=2Ec</span><br><span>@@ -271,8 +271,8 @@</span><br><span>     }</span><br=
><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct tls_session *s=
ession =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct man_def_auth_context *mda=
 =3D session-&gt;opt-&gt;mda_context;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct env_set *es =3D session-&gt;opt-&gt;es;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct man_def_aut=
h_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct env_set *es =3D session-=
&gt;opt-&gt;es;</span><br><span>     unsigned int mda_key_id =3D get_primar=
y_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span> </span><br><sp=
an>     management_notify_client_cr_response(mda_key_id, mda, es, m);</span=
><br><span>@@ -917,7 +917,7 @@</span><br><span> push_options(struct options=
 *o, char **p, msglvl_t msglevel, struct gc_arena *gc)</span><br><span> {</=
span><br><span>     const char **argv =3D make_extended_arg_array(p, false,=
 gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *opt =
=3D print_argv(argv, gc, 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *opt =3D print_argv(argv, gc, 0);</span><br><span> =
    push_option(o, opt, msglevel);</span><br><span> }</span><br><span> </sp=
an><br><span>@@ -1199,7 +1199,7 @@</span><br><span>                     /* =
parse route-ipv6 arguments */</span><br><span>                     if (get_=
ipv6_addr(p[1], &amp;network, &amp;netbits, D_ROUTE_DEBUG))</span><br><span=
>                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        struct iroute_ipv6 *ir;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        const struct iroute_i=
pv6 *ir;</span><br><span> </span><br><span>                         /* does=
 this route-ipv6 match an iroute-ipv6? */</span><br><span>                 =
        for (ir =3D o-&gt;iroutes_ipv6; ir !=3D NULL; ir =3D ir-&gt;next)</=
span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</=
span><br><span>index 6dbe3ec=2E=2E03a2526 100644</span><br><span>--- a/src/=
openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><sp=
an>@@ -667,7 +667,7 @@</span><br><span> </span><br><span>     /* parse the =
routes from opt to rl */</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        struct route_option *ro;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const struct route_option *r=
o;</span><br><span>         for (ro =3D opt-&gt;routes; ro; ro =3D ro-&gt;n=
ext)</span><br><span>         {</span><br><span>             struct addrinf=
o *netlist =3D NULL;</span><br><span>@@ -679,7 +679,7 @@</span><br><span>  =
           }</span><br><span>             else</span><br><span>            =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                str=
uct addrinfo *curele;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                const struct addrinfo *curele;</span><br><span>          =
       for (curele =3D netlist; curele; curele =3D curele-&gt;ai_next)</spa=
n><br><span>                 {</span><br><span>                     struct =
route_ipv4 *new;</span><br><span>@@ -799,7 +799,7 @@</span><br><span>     n=
eed_remote_ipv6_route =3D false;</span><br><span> </span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct route_ip=
v6_option *ro6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const struct route_ipv6_option *ro6;</span><br><span>         for (ro6 =
=3D opt6-&gt;routes_ipv6; ro6; ro6 =3D ro6-&gt;next)</span><br><span>      =
   {</span><br><span>             struct route_ipv6 *r6;</span><br><span>@@=
 -1187,7 +1187,7 @@</span><br><span> {</span><br><span>     if (rl6 &amp;&a=
mp; (rl6-&gt;iflags &amp; RL_ROUTES_ADDED))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct route_ipv6 *r6;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struc=
t route_ipv6 *r6;</span><br><span>         for (r6 =3D rl6-&gt;routes_ipv6;=
 r6; r6 =3D r6-&gt;next)</span><br><span>         {</span><br><span>       =
      delete_route_ipv6(r6, tt, es, ctx);</span><br><span>@@ -1226,7 +1226,=
7 @@</span><br><span> void</span><br><span> print_route_options(const struc=
t route_option_list *rol, msglvl_t msglevel)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct route_option *ro;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct route_o=
ption *ro;</span><br><span>     if (rol-&gt;flags &amp; RG_ENABLE)</span><b=
r><span>     {</span><br><span>         msg(msglevel, &quot;  [redirect_def=
ault_gateway local=3D%d]&quot;, (rol-&gt;flags &amp; RG_LOCAL) !=3D 0);</sp=
an><br><span>@@ -1335,7 +1335,7 @@</span><br><span> setenv_routes(struct en=
v_set *es, const struct route_list *rl)</span><br><span> {</span><br><span>=
     int i =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct route_ipv4 *r;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct route_ipv4 *r;</span><br><span>     for (r =3D rl-&gt;ro=
utes; r; r =3D r-&gt;next)</span><br><span>     {</span><br><span>         =
setenv_route(es, r, i++);</span><br><span>@@ -1372,7 +1372,7 @@</span><br><=
span> setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *=
rl6)</span><br><span> {</span><br><span>     int i =3D 1;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct route_ipv6 *r6;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct route_ipv6 *r6;=
</span><br><span>     for (r6 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;ne=
xt)</span><br><span>     {</span><br><span>         setenv_route_ipv6(es, r=
6, i++);</span><br><span>@@ -2423,7 +2423,7 @@</span><br><span>          */=
</span><br><span>         if (rl &amp;&amp; tt-&gt;did_ifconfig_setup)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            struct route_ipv4 *r;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const struct route_ipv4 *r;</span><br><span>    =
         for (r =3D rl-&gt;routes, len =3D 0; r; r =3D r-&gt;next, ++len)</=
span><br><span>             {</span><br><span>                 test_route_h=
elper(&amp;ret, &amp;count, &amp;good, &amp;ambig, adapters, r-&gt;gateway)=
;</span><br><span>@@ -3110,7 +3110,8 @@</span><br><span>     /* scan adapte=
r list */</span><br><span>     if (rgi-&gt;flags &amp; RGI_ADDR_DEFINED)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       struct ifreq *ifr, *ifend;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const struct ifreq *ifr;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const struct ifreq *ifend;</span><br><sp=
an>         in_addr_t addr, netmask;</span><br><span>         struct ifreq =
ifreq;</span><br><span>         struct ifconf ifc;</span><br><span>diff --g=
it a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index =
0f66ad51=2E=2Efba0a22 100644</span><br><span>--- a/src/openvpn/socket=2Ec</=
span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -393,7 +393,=
7 @@</span><br><span> </span><br><span>             for (int j =3D 0; j &lt=
; ce-&gt;local_list-&gt;len; j++)</span><br><span>             {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                struct local_ent=
ry *le =3D ce-&gt;local_list-&gt;array[j];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                const struct local_entry *le =3D ce-=
&gt;local_list-&gt;array[j];</span><br><span> </span><br><span>            =
     if (!le-&gt;local)</span><br><span>                 {</span><br><span>=
@@ -898,12 +898,10 @@</span><br><span>      * What is the correct way to de=
al with it?</span><br><span>      */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *cur;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(local);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     /* find the first addrinfo with correct ai_family */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct addrinfo=
 *cur;</span><br><span>     for (cur =3D local; cur; cur =3D cur-&gt;ai_nex=
t)</span><br><span>     {</span><br><span>         if (cur-&gt;ai_family =
=3D=3D ai_family)</span><br><span>@@ -1490,7 +1488,7 @@</span><br><span>   =
      /* Socket is always bound on the first matching address,</span><br><s=
pan>          * For bound sockets with no remote addr this is the element o=
f</span><br><span>          * the list */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        struct addrinfo *cur;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const struct addrinfo *cur;</span><br=
><span>         for (cur =3D sock-&gt;info=2Elsa-&gt;bind_local; cur; cur =
=3D cur-&gt;ai_next)</span><br><span>         {</span><br><span>           =
  if (!ai_family || ai_family =3D=3D cur-&gt;ai_family)</span><br><span>@@ =
-1621,7 +1619,7 @@</span><br><span> create_socket_dco_win(struct context *c=
, struct link_socket *sock, struct signal_info *sig_info)</span><br><span> =
{</span><br><span>     /* in P2P mode we must have remote resolved at this =
point */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ad=
drinfo *remoteaddr =3D sock-&gt;info=2Elsa-&gt;current_remote;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct addrinfo *remot=
eaddr =3D sock-&gt;info=2Elsa-&gt;current_remote;</span><br><span>     if (=
(c-&gt;options=2Emode =3D=3D MODE_POINT_TO_POINT) &amp;&amp; (!remoteaddr))=
</span><br><span>     {</span><br><span>         return;</span><br><span>@@=
 -1910,7 +1908,7 @@</span><br><span>                               const st=
ruct link_socket_actual *from_addr)</span><br><span> {</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct addrinfo *ai;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const struct addrinfo *ai;</span><br><span> </span><br=
><span>     switch (from_addr-&gt;dest=2Eaddr=2Esa=2Esa_family)</span><br><=
span>     {</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openv=
pn/socket=2Eh</span><br><span>index 1a532e1=2E=2E89465bc 100644</span><br><=
span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=
=2Eh</span><br><span>@@ -761,7 +761,7 @@</span><br><span> {</span><br><span=
>     if (sock &amp;&amp; ipbuf)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct openvpn_iphdr *iph =3D (st=
ruct openvpn_iphdr *)BPTR(ipbuf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const struct openvpn_iphdr *iph =3D (struct openvpn_i=
phdr *)BPTR(ipbuf);</span><br><span>         sock-&gt;ptos =3D iph-&gt;tos;=
</span><br><span>         sock-&gt;ptos_defined =3D true;</span><br><span> =
    }</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c</span><br><span>index d5bd602=2E=2E5f5d1f9 100644</span><br><span>--- a/s=
rc/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><spa=
n>@@ -1488,7 +1488,7 @@</span><br><span> static bool</span><br><span> gener=
ate_key_expansion(struct tls_multi *multi, struct key_state *ks, struct tls=
_session *session)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=
=2Ekey_ctx_bi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</s=
pan><br><span>     bool ret =3D false;</span><br><span>     struct key2 key=
2;</span><br><span> </span><br><span>@@ -1750,7 +1750,7 @@</span><br><span>=
 static void</span><br><span> flush_payload_buffer(struct key_state *ks)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct buffer *b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct buffer *b;</span><br><span> </span><br><span>     while ((b =
=3D buffer_list_peek(ks-&gt;paybuf)))</span><br><span>     {</span><br><spa=
n>@@ -2779,7 +2779,7 @@</span><br><span>     /* Outgoing Ciphertext to reli=
able buffer */</span><br><span>     if (ks-&gt;state &gt;=3D S_START)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    struct buffer *buf =3D reliable_get_buf_output_sequenced(ks-&gt;send_re=
liable);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st struct buffer *buf =3D reliable_get_buf_output_sequenced(ks-&gt;send_rel=
iable);</span><br><span>         if (buf)</span><br><span>         {</span>=
<br><span>             if (!write_outgoing_tls_ciphertext(session, continue=
_tls_process))</span><br><span>@@ -2848,7 +2848,7 @@</span><br><span>     {=
</span><br><span>         int opcode;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct buffer *buf =3D reliable_s=
end(ks-&gt;send_reliable, &amp;opcode);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const struct buffer *buf =3D reliable_send(ks-&=
gt;send_reliable, &amp;opcode);</span><br><span>         ASSERT(buf);</span=
><br><span>         struct buffer b =3D *buf;</span><br><span>         INCR=
_SENT;</span><br><span>@@ -3211,7 +3211,7 @@</span><br><span> static void</=
span><br><span> check_session_buf_not_used(struct buffer *to_link, struct t=
ls_session *session)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&gt;data;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =3D to_=
link-&gt;data;</span><br><span>     if (!dataptr)</span><br><span>     {</s=
pan><br><span>         return;</span><br><span>@@ -3233,7 +3233,7 @@</span>=
<br><span> </span><br><span>     for (int i =3D 0; i &lt; KS_SIZE; i++)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const struct key_state *ks =3D =
&amp;session-&gt;key[i];</span><br><span>         if (ks-&gt;state =3D=3D S=
_UNDEF)</span><br><span>         {</span><br><span>             continue;</=
span><br><span>@@ -3304,7 +3304,7 @@</span><br><span>     {</span><br><span=
>         struct tls_session *session =3D &amp;multi-&gt;session[i];</span>=
<br><span>         struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct key_=
state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const struct key_state *ks_lame =
=3D &amp;session-&gt;key[KS_LAME_DUCK];</span><br><span> </span><br><span> =
        /* set initial remote address=2E This triggers connecting with that=
</span><br><span>          * session=2E So we only do that if the TM_ACTIVE=
 session is not</span><br><span>@@ -3505,7 +3505,7 @@</span><br><span> </sp=
an><br><span>     for (int i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        str=
uct key_state *ks =3D get_key_scan(multi, i);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const struct key_state *ks =3D get_key_sc=
an(multi, i);</span><br><span>         if (ks-&gt;key_id !=3D key_id)</span=
><br><span>         {</span><br><span>             continue;</span><br><spa=
n>@@ -4070,7 +4070,7 @@</span><br><span> void</span><br><span> tls_prepend_=
opcode_v1(const struct tls_multi *multi, struct buffer *buf)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key_st=
ate *ks =3D multi-&gt;save_ks;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct key_state *ks =3D multi-&gt;save_ks;</span><br>=
<span> </span><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><span> <=
/span><br><span>@@ -4084,7 +4084,7 @@</span><br><span> void</span><br><span=
> tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct key_state *ks =3D multi-&gt;save_ks;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct key_state *ks =3D multi-&gt;save_=
ks;</span><br><span>     uint32_t peer;</span><br><span> </span><br><span> =
    msg(D_TLS_DEBUG, __func__);</span><br><span>diff --git a/src/openvpn/ss=
l_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 6d7ac04=
=2E=2Efaf5a27 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -730,7 +73=
0,7 @@</span><br><span> static inline size_t</span><br><span> external_key_=
len(void *vctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct external_context *const ctx =3D vctx;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct external_context=
 *const ctx =3D vctx;</span><br><span> </span><br><span>     return ctx-&gt=
;signature_length;</span><br><span> }</span><br><span>diff --git a/src/open=
vpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 162f6=
8f=2E=2E063fa5d 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</sp=
an><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -409,7 +40=
9,7 @@</span><br><span>                     const char *subject, const stru=
ct x509_track *x509_track)</span><br><span> {</span><br><span>     char env=
name[64];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *se=
rial =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *serial =3D NULL;</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span> </span><br><span>     /* Save X509 fields in enviro=
nment */</span><br><span>@@ -699,7 +699,7 @@</span><br><span>              =
   goto cleanup;</span><br><span>         }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct verify_hash_list *cu=
rrent_hash =3D opt-&gt;verify_hash;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        const struct verify_hash_list *current_hash =3D opt=
-&gt;verify_hash;</span><br><span> </span><br><span>         while (current=
_hash)</span><br><span>         {</span><br><span>@@ -1532,7 +1532,7 @@</sp=
an><br><span> verify_user_pass_management(struct tls_session *session, cons=
t struct user_pass *up)</span><br><span> {</span><br><span>     int retval =
=3D KMDA_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* primary key */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct key=
_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* primary key */</span><b=
r><span> </span><br><span>     /* set username/password in private env spac=
e */</span><br><span>     setenv_str(session-&gt;opt-&gt;es, &quot;password=
&quot;, up-&gt;password);</span><br><span>diff --git a/src/openvpn/tun=2Ec =
b/src/openvpn/tun=2Ec</span><br><span>index f2a4394=2E=2Eaf48921 100644</sp=
an><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tu=
n=2Ec</span><br><span>@@ -871,7 +871,7 @@</span><br><span>          */</spa=
n><br><span>         if (strict_warn)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            struct addrinfo *cur=
ele;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st struct addrinfo *curele;</span><br><span>             ifconfig_sanity_ch=
eck(tun_p2p, tt-&gt;remote_netmask);</span><br><span> </span><br><span>    =
         /*</span><br><span>@@ -1726,7 +1726,7 @@</span><br><span>     {</s=
pan><br><span>         u_int32_t type;</span><br><span>         struct iove=
c iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t ip *iph =3D (struct ip *)buf;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const struct ip *iph =3D (struct ip *)buf;</span><br><s=
pan> </span><br><span>         if (iph-&gt;ip_v =3D=3D 6)</span><br><span> =
        {</span><br><span>@@ -3414,7 +3414,7 @@</span><br><span>         SP=
_DEVINFO_DATA device_info_data;</span><br><span>         BOOL res;</span><b=
r><span>         HKEY dev_key;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        char net_cfg_instance_id_string[] =3D &quot;NetCfgInstance=
Id&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char net_cfg_instance_id_string[] =3D &quot;NetCfgInstanceId&quot;;</sp=
an><br><span>         BYTE net_cfg_instance_id[256];</span><br><span>      =
   char device_instance_id[256];</span><br><span>         DWORD len;</span>=
<br><span>@@ -3542,7 +3542,7 @@</span><br><span>         HKEY unit_key;</sp=
an><br><span>         char component_id_string[] =3D &quot;ComponentId&quot=
;;</span><br><span>         char component_id[256];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        char net_cfg_instance_id_string[] =
=3D &quot;NetCfgInstanceId&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const char net_cfg_instance_id_string[] =3D &quot;Net=
CfgInstanceId&quot;;</span><br><span>         BYTE net_cfg_instance_id[256]=
;</span><br><span>         DWORD data_type;</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><sp=
an>index ca08ead=2E=2E44b010d 100644</span><br><span>--- a/src/openvpn/win3=
2=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -889,7=
 +889,7 @@</span><br><span> </span><br><span>     if (es)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct e=
nv_item *e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const struct env_item *e;</span><br><span>         char *ret;</span><br><sp=
an>         char *p;</span><br><span>         size_t nchars =3D 1;</span><b=
r><span>diff --git a/src/openvpnmsica/msica_arg=2Ec b/src/openvpnmsica/msic=
a_arg=2Ec</span><br><span>index a334710=2E=2Ed763d93 100644</span><br><span=
>--- a/src/openvpnmsica/msica_arg=2Ec</span><br><span>+++ b/src/openvpnmsic=
a/msica_arg=2Ec</span><br><span>@@ -92,7 +92,7 @@</span><br><span> {</span>=
<br><span>     /* Count required space=2E */</span><br><span>     size_t si=
ze =3D 2 /*x + zero-terminator*/;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    for (struct msica_arg *p =3D seq-&gt;head; p !=3D NULL; p =
=3D p-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (const struct msica_arg *p =3D seq-&gt;head; p !=3D NULL; p =3D p-&gt;n=
ext)</span><br><span>     {</span><br><span>         size +=3D wcslen(p-&gt=
;val) + 1 /*space delimiter|zero-terminator*/;</span><br><span>     }</span=
><br><span>@@ -119,7 +119,7 @@</span><br><span> </span><br><span>     /* Jo=
in=2E */</span><br><span>     LPWSTR s =3D str + 1 /*x*/;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (struct msica_arg *p =3D seq-&g=
t;head; p !=3D NULL; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (const struct msica_arg *p =3D seq-&gt;head; p !=
=3D NULL; p =3D p-&gt;next)</span><br><span>     {</span><br><span>        =
 /* Convert zero-terminator into space delimiter=2E */</span><br><span>    =
     s[0] =3D L&#39; &#39;;</span><br><span>diff --git a/src/openvpnmsica/o=
penvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>index 9=
d12963=2E=2E3911006 100644</span><br><span>--- a/src/openvpnmsica/openvpnms=
ica=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><=
span>@@ -196,7 +196,7 @@</span><br><span> </span><br><span>     /* Count ad=
apters=2E */</span><br><span>     size_t adapter_count =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for (struct tap_adapter_node *p=
Adapter =3D pAdapterList; pAdapter; pAdapter =3D pAdapter-&gt;pNext)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct tap_=
adapter_node *pAdapter =3D pAdapterList; pAdapter; pAdapter =3D pAdapter-&g=
t;pNext)</span><br><span>     {</span><br><span>         adapter_count++;</=
span><br><span>     }</span><br><span>diff --git a/src/openvpnserv/interact=
ive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 32c1b9c=2E=
=2Ea9e9665 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2685=
,7 +2685,7 @@</span><br><span>     unsigned n =3D 0;</span><br><span>     f=
or (size_t i =3D 0; i &lt; _countof(data); ++i)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        nrpt_exclude_data_=
t *d =3D &amp;data[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const nrpt_exclude_data_t *d =3D &amp;data[i];</span><br><span> =
        if (d-&gt;domains_size =3D=3D 0)</span><br><span>         {</span><=
br><span>             break;</span><br><span>diff --git a/src/plugins/auth-=
pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>index =
3b7bcc2=2E=2E948b6af 100644</span><br><span>--- a/src/plugins/auth-pam/auth=
-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/auth-pam=2Ec</span><br>=
<span>@@ -526,7 +526,7 @@</span><br><span> openvpn_plugin_func_v1(openvpn_p=
lugin_handle_t handle, const int type, const char *argv[],</span><br><span>=
                        const char *envp[])</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct auth_pam_context *conte=
xt =3D (struct auth_pam_context *)handle;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct auth_pam_context *context =3D (struc=
t auth_pam_context *)handle;</span><br><span> </span><br><span>     if (typ=
e =3D=3D OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY &amp;&amp; context-&gt;foregr=
ound_fd &gt;=3D 0)</span><br><span>     {</span><br><span>diff --git a/src/=
tapctl/main=2Ec b/src/tapctl/main=2Ec</span><br><span>index 6a4a240=2E=2E66=
97d14 100644</span><br><span>--- a/src/tapctl/main=2Ec</span><br><span>+++ =
b/src/tapctl/main=2Ec</span><br><span>@@ -317,7 +317,7 @@</span><br><span> =
            return NULL;</span><br><span>         }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tap_adapter_=
node *conflict =3D find_adapter_by_name(requested_name, adapter_list);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct tap=
_adapter_node *conflict =3D find_adapter_by_name(requested_name, adapter_li=
st);</span><br><span>         if (conflict)</span><br><span>         {</spa=
n><br><span>             LPOLESTR adapter_id =3D NULL;</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvp=
n/test_buffer=2Ec</span><br><span>index 326de40=2E=2Ece38bbe 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -88,7 +88,7 =
@@</span><br><span> </span><br><span>     int maxoutput =3D 0;</span><br><s=
pan>     unsigned int blocksize =3D 5;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    char *separator =3D &quot; &quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *separator =3D &quot; &q=
uot;;</span><br><span>     output =3D format_hex_ex(input, input_size, maxo=
utput, blocksize, separator, &amp;gc);</span><br><span>     assert_string_e=
qual(output, &quot;0100ff10ff 00f00f090a&quot;);</span><br><span> </span><b=
r><span>@@ -174,7 +174,7 @@</span><br><span>     /* With a max length of 2,=
 no aggregation should take place */</span><br><span>     buffer_list_aggre=
gate_separator(ctx-&gt;one_two_three, 2, testsep);</span><br><span>     ass=
ert_int_equal(ctx-&gt;one_two_three-&gt;size, 3);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_list_peek(ctx=
-&gt;one_two_three);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_three);<=
/span><br><span>     assert_buf_equals_str(buf, teststr1);</span><br><span>=
 }</span><br><span> </span><br><span>@@ -189,7 +189,7 @@</span><br><span>  =
    */</span><br><span>     buffer_list_aggregate_separator(ctx-&gt;one_two=
_three, strlen(expected) + 1, testsep);</span><br><span>     assert_int_equ=
al(ctx-&gt;one_two_three-&gt;size, 2);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_tw=
o_three);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><=
span>     assert_buf_equals_str(buf, expected);</span><br><span> }</span><b=
r><span> </span><br><span>@@ -201,7 +201,7 @@</span><br><span>     /* Aggre=
gate all */</span><br><span>     buffer_list_aggregate_separator(ctx-&gt;on=
e_two_three, 1 &lt;&lt; 16, testsep);</span><br><span>     assert_int_equal=
(ctx-&gt;one_two_three-&gt;size, 1);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_=
three);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><sp=
an>     assert_buf_equals_str(buf, teststr1 testsep teststr2 testsep testst=
r3 testsep);</span><br><span> }</span><br><span> </span><br><span>@@ -213,7=
 +213,7 @@</span><br><span>     /* Aggregate all */</span><br><span>     bu=
ffer_list_aggregate_separator(ctx-&gt;one_two_three, 1 &lt;&lt; 16, testnos=
ep);</span><br><span>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, =
1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer =
*buf =3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buffer_list_=
peek(ctx-&gt;one_two_three);</span><br><span>     assert_buf_equals_str(buf=
, teststr1 teststr2 teststr3);</span><br><span> }</span><br><span> </span><=
br><span>@@ -226,7 +226,7 @@</span><br><span>     /* Aggregate all */</span=
><br><span>     buffer_list_aggregate_separator(bl_zerolen, 1 &lt;&lt; 16, =
testnosep);</span><br><span>     assert_int_equal(bl_zerolen-&gt;size, 1);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf=
 =3D buffer_list_peek(bl_zerolen);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(bl_zerolen=
);</span><br><span>     assert_buf_equals_str(buf, &quot;&quot;);</span><br=
><span> }</span><br><span> </span><br><span>@@ -239,7 +239,7 @@</span><br><=
span>     /* Aggregate all */</span><br><span>     buffer_list_aggregate_se=
parator(bl_emptybuffers, 1 &lt;&lt; 16, testnosep);</span><br><span>     as=
sert_int_equal(bl_emptybuffers-&gt;size, 1);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_list_peek(bl_empty=
buffers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct buffer *buf =3D buffer_list_peek(bl_emptybuffers);</span><br><span> =
    assert_int_equal(BLEN(buf), 0);</span><br><span> }</span><br><span> </s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests=
/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index 77cf295=2E=2E07c5=
4b4 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><sp=
an>@@ -482,9 +482,9 @@</span><br><span> crypto_test_hkdf_expand_testa1(void=
 **state)</span><br><span> {</span><br><span>     /* RFC 5889 A=2E1 Test Ca=
se 1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t pr=
k[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3=
f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        0x=
9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t prk[32] =3D { 0x0=
7, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                              0x=
0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                              0=
x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</span><br><spa=
n> </span><br><span>     uint8_t info[10] =3D { 0xf0, 0xf1, 0xf2, 0xf3, 0xf=
4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };</span><br><span> </span><br><span>@@ -50=
3,9 +503,9 @@</span><br><span> crypto_test_hkdf_expand_testa2(void **state)=
</span><br><span> {</span><br><span>     /* RFC 5889 A=2E2 Test Case 2 */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t prk[32] =3D=
 { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        0x9c=
, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x46,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        0x71, 0x01,=
 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint8_t prk[32] =3D { 0x06, 0xa6, =
0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              0x9c, 0xeb,=
 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x46,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                              0x71, 0x01=
, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };</span><br><span> </span=
><br><span>     uint8_t info[80] =3D { 0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, =
0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb,</span><br><span>                       =
   0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,<=
/span><br><span>@@ -534,11 +534,11 @@</span><br><span> crypto_test_hkdf_exp=
and_testa3(void **state)</span><br><span> {</span><br><span>     /* RFC 588=
9 A=2E3 Test Case 3 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, =
0x7f, 0x33, 0xa9,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0=
xaf, 0xdb,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t pr=
k[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa=
9,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
             0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0x=
db,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
              0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 };=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 uint8_t info[] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const uint8_t info[] =3D { 0 };</span><br><span> </span><br><spa=
n>     int L =3D 42;</span><br><span>     uint8_t okm[42] =3D { 0x8d, 0xa4,=
 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,</span><br><span>@@ -=
558,9 +558,9 @@</span><br><span>     /* tests the HDKF with a label/okm tha=
t OpenVPN itself uses in OpenSSL 3</span><br><span>      * HDKF unit test*/=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d=
, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5,=
 0x0f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
         0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t prk[32=
] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
         0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
          0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</sp=
an><br><span> </span><br><span>     uint8_t info[18] =3D { 0x00, 0x1b, 0x0e=
, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,</span><br><span>                     =
     0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };</span><br><spa=
n>@@ -680,7 +680,7 @@</span><br><span> static int</span><br><span> crypto_t=
est_epoch_setup(void **state)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint16_t *num_future_keys =3D (uint16_t *)*s=
tate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint=
16_t *num_future_keys =3D (uint16_t *)*state;</span><br><span>     struct e=
poch_test_state *data =3D calloc(1, sizeof(struct epoch_test_state));</span=
><br><span> </span><br><span>     data-&gt;gc =3D gc_new();</span><br><span=
>diff --git a/tests/unit_tests/openvpn/test_cryptoapi=2Ec b/tests/unit_test=
s/openvpn/test_cryptoapi=2Ec</span><br><span>index 508afc9=2E=2E37bbe92 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><spa=
n>@@ -233,7 +233,7 @@</span><br><span>         const CERT_CONTEXT *ctx =3D =
NULL;</span><br><span>         while ((ctx =3D CertEnumCertificatesInStore(=
user_store, ctx)))</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            char *friendly_name =3D get_cert_name(c=
tx, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      const char *friendly_name =3D get_cert_name(ctx, &amp;gc);</span><br>=
<span>             if (!lookup_cert(friendly_name)) /* not our cert */</spa=
n><br><span>             {</span><br><span>                 continue;</span=
><br><span>@@ -310,7 +310,7 @@</span><br><span>          */</span><br><span=
>         assert_non_null(ctx);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        char *friendly_name =3D get_cert_name(c=
tx, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const char *friendly_name =3D get_cert_name(ctx, &amp;gc);</span><br><spa=
n>         struct test_cert *found =3D lookup_cert(friendly_name);</span><b=
r><span>         assert_non_null(found);</span><br><span>         assert_st=
ring_equal(found-&gt;cname, c-&gt;cname);</span><br><span>@@ -343,7 +343,7 =
@@</span><br><span>          */</span><br><span>         assert_non_null(ct=
x);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        char *friendly_name =3D get_cert_name(ctx, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const char *friendly_name =
=3D get_cert_name(ctx, &amp;gc);</span><br><span>         struct test_cert =
*found =3D lookup_cert(friendly_name);</span><br><span>         assert_non_=
null(found);</span><br><span>         assert_string_equal(found-&gt;issuer,=
 c-&gt;issuer);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 5f0=
3860=2E=2Ea41c27b 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</sp=
an><br><span>@@ -300,7 +300,7 @@</span><br><span>     {</span><br><span>   =
      for (ptr_type i =3D 1; i &lt;=3D 16; ++i)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct has=
h_element *item =3D hash_lookup_by_value(nhash, (void *)i);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            const struct hash_eleme=
nt *item =3D hash_lookup_by_value(nhash, (void *)i);</span><br><span>      =
       hash_remove_by_value(nhash, (void *)i);</span><br><span>            =
 /* check item got removed if it was present before */</span><br><span>    =
         if (item)</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index d6=
b63d0=2E=2E887c492 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</spa=
n><br><span>@@ -676,7 +676,7 @@</span><br><span>     openvpn_encrypt(&amp;b=
uf, encrypt_workspace, &amp;co);</span><br><span> </span><br><span>     /* =
separate buffer in authenticated data and encrypted data */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *ad_start =3D BPTR(&amp;b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8=
_t *ad_start =3D BPTR(&amp;buf);</span><br><span>     buf_advance(&amp;buf,=
 4);</span><br><span> </span><br><span>     if (epoch)</span><br><span>diff=
 --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec b/te=
sts/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec</span><br><span=
>index a861bfd=2E=2E89f0642 100644</span><br><span>--- a/tests/unit_tests/p=
lugins/auth-pam/test_search_and_replace=2Ec</span><br><span>+++ b/tests/uni=
t_tests/plugins/auth-pam/test_search_and_replace=2Ec</span><br><span>@@ -12=
,7 +12,7 @@</span><br><span> static void</span><br><span> pass_any_null_par=
am__returns_null(void **state)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    char DUMMY[] =3D &quot;DUMMY&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char DUMMY[] =3D =
&quot;DUMMY&quot;;</span><br><span> </span><br><span>     assert_null(searc=
handreplace(NULL, DUMMY, DUMMY));</span><br><span>     assert_null(searchan=
dreplace(DUMMY, NULL, DUMMY));</span><br><span>@@ -22,8 +22,8 @@</span><br>=
<span> static void</span><br><span> pass_any_empty_string__returns_null(voi=
d **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    char DUMMY[] =3D &quot;DUMMY&quot;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    char EMPTY[] =3D &quot;&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char DUMMY[] =3D &quot;D=
UMMY&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char EMPTY[] =3D &quot;&quot;;</span><br><span> </span><br><span>     ass=
ert_null(searchandreplace(EMPTY, DUMMY, DUMMY));</span><br><span>     asser=
t_null(searchandreplace(DUMMY, EMPTY, DUMMY));</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1661?usp=3Demail">change 1661</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1661?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merge=
d </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1661 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerr=
it-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

=
</body></html>
--tRQOz3FJOGg=--


--===============1220035809521219894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1220035809521219894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1220035809521219894==--

