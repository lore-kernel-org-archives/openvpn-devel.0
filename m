Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D2C5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsubsxIRyMMUIh8xnBN62yCBo2rfrhwsEX5mL5afTV8=; b=a5jTFL6wTDmtpG8nXpJAQhABoK
	1A0NI1eXnrsBeJTS037h5+LpYoLPpd6hK9Er968b1u61zXM9P/+jPTX+Z9RVsHfa2z3uq3px9txR+
	J+Ip+9FalnPWDnwO5gory/HsF8GCRiN8mDeFtVk4GDrNkyxTlPp29aonJd0jg6LdP6hA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wym60-0004jE-B8;
	Tue, 25 Aug 2026 08:01:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wym5z-0004j6-3l
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UrPmdhNhPrZBfeJbqKiTLuKNGmEmlU0Hwk3+zZS5/WM=; b=f4HVWADmALfb1ImfmUm1MpyACZ
 HVqdGSYfh5xdaYunx+RjP49lkUU2fGPxeEyDhW2NgBDchz8HJ1p2zFwrOdZT5ZMb9WJ1Unaq3TEGG
 wuy08Rcek5uBHjpG4bnPJIT++ufrTwYTLeEH/0foBN90yuN1zr6BQl2Kcv6ni3ZVlkmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UrPmdhNhPrZBfeJbqKiTLuKNGmEmlU0Hwk3+zZS5/WM=; b=X
 kyq1+CmV9OZmGV5FAkqA4VmTz23I+Wj+lA6dfPWKLn+bdkZ16hWK/B+lscSACqrDeOz4TN8QCDyjk
 PcTv0Ru8feQnoGEZDvVQDqGBr+Whai/0UMwMxIxymjn5G0vq45sq7wZ2ZL1Lt0fLY54mND1t2C98m
 gTLfjzWVB9x3XQLs=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wym5r-0008A2-Qo for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:01:23 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso524663266b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787644869; x=1788249669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UrPmdhNhPrZBfeJbqKiTLuKNGmEmlU0Hwk3+zZS5/WM=;
 b=COl3TnwlS7/ezuDHGQPZ6zsYHZ/Z+Q2d2dDGkK838lG7Q/gSvh5/MmZ8imoirU/Wft
 LdQ20aruw4DfAZ87nvmtCGHzjxgqkXuekE1ZCQaGyC7pi/YxMRIH66yGkmgI7FXalncd
 Ti4QQu5ACuJoF3TbcL+bwXEQczVot0jomcG3hs3NnIE/nykX5RPJfqoqJ6iLtWoMTbBw
 QDHascrFsGd0fEoLpoD+/bU6rwGbuGdEaaU9LJYVM5heKr8zrhESju4pmMvFMq5DN70i
 wUl7XbHSfW8qXddnmwWe0zACUXcCUNw/PAWwfnd2R+tAEozYZZu37dY2F5mqhMsUfvGS
 k3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787644869; x=1788249669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UrPmdhNhPrZBfeJbqKiTLuKNGmEmlU0Hwk3+zZS5/WM=;
 b=DH44ika59iX0tTslnlDxFqfmWgBFKhyTZwTEBQBs+1//B7gPJVDfGAfWW5J0O9VIUx
 txDbSDPxrHq6pcFVviqZQuWCUwfAP8IdNgUrwKQMssB2Pf6B3Ia58Ewy4ZIrbHhuS7xL
 nDhAr158Kbq2LMmkTlqkkKbcdKcf/oN1wK2lUaocVMNVAP9K9g1gJMXUPmv0qKBUE9m3
 GHaAliUldl1MdZdJaUglqKPozKvz+asNa1PcaZDIN3jYvujH58kX2oFoXkmVyLnEXano
 V6wKaB2KU0PW6yBDgJ68JkZ9G/7JbeS28aaUrkfUeclNXknDILnGy9Y4h9+AFx4xgn1P
 cCGg==
X-Gm-Message-State: AFuF++kC5Ob3fHmMthWAqOKuv0n+msSuQMN1H4yvPJ9zHAw2yyr+oTof
 5sQ4Euj8IDkCAZ/bLNAMj5iexIoD4vinVpiHrIX9AqQgOZuxS45QehTtq3HRunD90qbNTVEpBxo
 TgbzrzLkMZihUJhb1jqa0N0kL2KDk8jBNNWpRsmUtzjFCDkgKuWxfXdwd8XZcAzdpRGv+
X-Gm-Gg: AR+sD12YFN1w8h2sVFnV++Ij7ghluNgcLxgOCK8VhBuGNuR4QgpYHfW1v9c/WQ6kZ8U
 N4nD0VFQ59cUNLqjZD7uHa2kL1gpYVzvBvxqyVwHveYYR/ml3m6jjXf/1SrOASCYf0RHhdlKscw
 //PBIdrCY+EJc7mHWLtagt28YhDeGPHbnW8aZknVzDC2xFgpEqXsXaUI9oyecmit6g90A2m/2Nc
 nI9RuD6iKe+uek1DyDOzwzcSy08qpXzH+B41OMmSYDS6JEI6svn0sFE3+GNEIr0RtdMLp+2yzM7
 tJunEVb1HzyR0RTSmEACE1FIFLitS84bfY7hjmo1oXseTvxw3S1gqYgxNNaDAH315y/4bjYsVQv
 aCzjy7o0u4FEd69YE9iQvPVWzp729dQ6nZhiZNJiDIh/mqpHfiNXJW35Xi5Lbf1Ig8HlnTy465z
 UYKQH/WZ0BoedO/tjK2gkYeWKqb0RvjHm0/YDLO6hU0hQIsPIz63co1MnlFqWAL+oPBnZZDFkJE
 ZtAwPyniPqyrHoDXynC6h11vOEjN36Q0OWsQF4Bk4gwF41BS98TdMyoKGlWrPdT2aGv6C/LoS3C
 m+cBxNbPjS0ZqiyZfWkoRllazLJD0bO98BTS/MncTddNQQPRzo8=
X-Received: by 2002:a17:907:a892:b0:c16:5cf0:3aff with SMTP id
 a640c23a62f3a-c246a62afb5mr3363238566b.18.1787644866787; 
 Tue, 25 Aug 2026 01:01:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f64e0sm1929380266b.32.2026.08.25.01.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 01:01:05 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 08:00:59 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
X-Gerrit-Change-Number: 1661
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1661?usp=email>
X-Gerrit-Commit: a82c1ecde0fbeb1a9626e5f41914b2e468137998
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDEzNjAxMDAwLkkyYjcxZGFlMzdlYmU2M2MyNmE2Njc2MWY4NzdiMjVkMzI2ZWQxNDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9562da74d5ac7aa9badf500db3a2b6fd11ea5623-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wym5r-0008A2-Qo
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5199422005839026149=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5199422005839026149==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gp0IHTYZo0U="; charset=UTF-8

--gp0IHTYZo0U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#15) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by razvanc


Change subject: Remove instances of constVariable/constVariab=
lePointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Remove instances of constVariable/constVariablePointer cpp=
check warnings

Of varied usefulness, but easier to just address all of
the=
m=2E

Also change vpn_* parameters of dco_new_peer to const since
that is r=
equired by one of the changes and it works (and would
happen anyway when do=
ing constParameterPointer)=2E

Change-Id: I2b71dae37ebe63c26a66761f877b25d3=
26ed140f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1661
Message-Id: <20260824162651=2E3228-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38646=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M sample/sample-plugins/d=
efer/multi-auth=2Ec
M sample/sample-plugins/log/log=2Ec
M sample/sample-plu=
gins/log/log_v3=2Ec
M sample/sample-plugins/simple/simple=2Ec
M src/openvpn=
/argv=2Ec
M src/openvpn/auth_token=2Ec
M src/openvpn/base64=2Ec
M src/openv=
pn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/comp-lz4=2Ec
M src/ope=
nvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/cryptoapi=2Ec
=
M src/openvpn/dco=2Ec
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_inter=
nal=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn=
/dns=2Ec
M src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/in=
it=2Ec
M src/openvpn/list=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/misc=
=2Ec
M src/openvpn/mss=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M =
src/openvpn/multi=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/opti=
ons=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/options_util=2Ec
M sr=
c/openvpn/pool=2Ec
M src/openvpn/proxy=2Ec
M src/openvpn/push=2Ec
M src/ope=
nvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/open=
vpn/ssl=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_verify=2Ec
M sr=
c/openvpn/tun=2Ec
M src/openvpn/win32=2Ec
M src/openvpnmsica/msica_arg=2Ec
=
M src/openvpnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
M src=
/plugins/auth-pam/auth-pam=2Ec
M src/tapctl/main=2Ec
M tests/unit_tests/ope=
nvpn/test_buffer=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M tests/uni=
t_tests/openvpn/test_cryptoapi=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec=

M tests/unit_tests/openvpn/test_ssl=2Ec
M tests/unit_tests/plugins/auth-pa=
m/test_search_and_replace=2Ec
56 files changed, 163 insertions(+), 164 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/61/1661/15

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppc=
heck-suppression
index 2e3350b=2E=2E900e03c 100644
--- a/dev-tools/cppcheck=
-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -3,8 +3,6 @@
 constPar=
ameter
 constParameterCallback
 constParameterPointer
-constVariable
-const=
VariablePointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
 usle=
epCalled
diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/s=
ample-plugins/defer/multi-auth=2Ec
index f6bbf44=2E=2Ebacf557 100644
--- a/=
sample/sample-plugins/defer/multi-auth=2Ec
+++ b/sample/sample-plugins/defe=
r/multi-auth=2Ec
@@ -381,7 +381,7 @@
     }
     const char **argv =3D args=
->argv;
     const char **envp =3D args->envp;
-    struct plugin_context *=
context =3D (struct plugin_context *)args->handle;
+    const struct plugin=
_context *context =3D (struct plugin_context *)args->handle;
     struct pl=
ugin_per_client_context *pcc =3D
         (struct plugin_per_client_context=
 *)args->per_client_context;
     switch (args->type)
@@ -399,7 +399,7 @@
 =
OPENVPN_EXPORT void *
 openvpn_plugin_client_constructor_v1(openvpn_plugin_=
handle_t handle)
 {
-    struct plugin_context *context =3D (struct plugin_=
context *)handle;
+    const struct plugin_context *context =3D (struct plu=
gin_context *)handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_c=
lient_constructor_v1");
     return calloc(1, sizeof(struct plugin_per_clie=
nt_context));
 }
@@ -407,7 +407,7 @@
 OPENVPN_EXPORT void
 openvpn_plugin_c=
lient_destructor_v1(openvpn_plugin_handle_t handle, void *per_client_contex=
t)
 {
-    struct plugin_context *context =3D (struct plugin_context *)hand=
le;
+    const struct plugin_context *context =3D (struct plugin_context *)=
handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_destruct=
or_v1");
     free(per_client_context);
 }
diff --git a/sample/sample-plugi=
ns/log/log=2Ec b/sample/sample-plugins/log/log=2Ec
index 330e3e0=2E=2E76350=
ee 100644
--- a/sample/sample-plugins/log/log=2Ec
+++ b/sample/sample-plugi=
ns/log/log=2Ec
@@ -173,7 +173,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_h=
andle_t handle, const int type, const char *argv[],
                       =
 const char *envp[])
 {
-    struct plugin_context *context =3D (struct plu=
gin_context *)handle;
+    const struct plugin_context *context =3D (struct=
 plugin_context *)handle;
 
     show(type, argv, envp);
 
diff --git a/sam=
ple/sample-plugins/log/log_v3=2Ec b/sample/sample-plugins/log/log_v3=2Ec
in=
dex d2d44c7=2E=2E09c6735 100644
--- a/sample/sample-plugins/log/log_v3=2Ec
=
+++ b/sample/sample-plugins/log/log_v3=2Ec
@@ -245,7 +245,7 @@
 openvpn_plu=
gin_func_v3(const int version, struct openvpn_plugin_args_func_in const *ar=
gs,
                        struct openvpn_plugin_args_func_return *retptr)=

 {
-    struct plugin_context *context =3D (struct plugin_context *)args->=
handle;
+    const struct plugin_context *context =3D (struct plugin_contex=
t *)args->handle;
 
     printf("\nopenvpn_plugin_func_v3() :::::>> ");
   =
  show(args->type, args->argv, args->envp);
diff --git a/sample/sample-plug=
ins/simple/simple=2Ec b/sample/sample-plugins/simple/simple=2Ec
index 687a6=
33=2E=2E3182be0 100644
--- a/sample/sample-plugins/simple/simple=2Ec
+++ b/=
sample/sample-plugins/simple/simple=2Ec
@@ -104,7 +104,7 @@
 openvpn_plugin=
_func_v1(openvpn_plugin_handle_t handle, const int type, const char *argv[]=
,
                        const char *envp[])
 {
-    struct plugin_context=
 *context =3D (struct plugin_context *)handle;
+    const struct plugin_con=
text *context =3D (struct plugin_context *)handle;
 
     /* get username/p=
assword from envp string array */
     const char *username =3D get_env("us=
ername", envp);
diff --git a/src/openvpn/argv=2Ec b/src/openvpn/argv=2Ec
in=
dex 6a5d92e=2E=2E028671d 100644
--- a/src/openvpn/argv=2Ec
+++ b/src/openvp=
n/argv=2Ec
@@ -359,7 +359,7 @@
      *
      */
     size_t argc =3D argres=
->argc;
-    char *f =3D argv_prep_format(format, delim, &argc, &argres->gc=
);
+    const char *f =3D argv_prep_format(format, delim, &argc, &argres->g=
c);
     if (f =3D=3D NULL)
     {
         goto out;
diff --git a/src/open=
vpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index bd90212=2E=2Ef928a41 =
100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@=
 -235,7 +235,7 @@
      * a new token with the empty username since we do n=
ot want to loose
      * the information that the username cannot be truste=
d
      */
-    struct key_state *ks =3D &multi->session[TM_ACTIVE]=2Ekey[K=
S_PRIMARY];
+    const struct key_state *ks =3D &multi->session[TM_ACTIVE]=
=2Ekey[KS_PRIMARY];
     if (ks->auth_token_state_flags & AUTH_TOKEN_VALID_=
EMPTYUSER)
     {
         hmac_ctx_update(ctx, (const uint8_t *)"", 0);
di=
ff --git a/src/openvpn/base64=2Ec b/src/openvpn/base64=2Ec
index 7af8976=2E=
=2E5752844 100644
--- a/src/openvpn/base64=2Ec
+++ b/src/openvpn/base64=2Ec=

@@ -161,7 +161,7 @@
 {
     const char *p;
     unsigned char *q;
-    uns=
igned char *e =3D NULL;
+    const unsigned char *e =3D NULL;
 
     q =3D =
data;
     if (size >=3D 0)
diff --git a/src/openvpn/buffer=2Ec b/src/openv=
pn/buffer=2Ec
index 8c19902=2E=2E2b4d05d 100644
--- a/src/openvpn/buffer=2E=
c
+++ b/src/openvpn/buffer=2Ec
@@ -500,7 +500,7 @@
 void
 buf_null_terminat=
e(struct buffer *buf)
 {
-    char *last =3D (char *)BLAST(buf);
+    const=
 char *last =3D (char *)BLAST(buf);
     if (last && *last =3D=3D '\0') /* =
already terminated? */
     {
         return;
@@ -523,7 +523,7 @@
 {
     =
while (true)
     {
-        char *last =3D (char *)BLAST(buf);
+        co=
nst char *last =3D (char *)BLAST(buf);
         if (!last)
         {
     =
        break;
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh=

index 651aaed=2E=2Ebc5cffb 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/o=
penvpn/buffer=2Eh
@@ -1318,7 +1318,7 @@
 static inline bool
 buf_copy_n(str=
uct buffer *dest, struct buffer *src, int n)
 {
-    uint8_t *cp =3D buf_re=
ad_alloc(src, n);
+    const uint8_t *cp =3D buf_read_alloc(src, n);
     i=
f (!cp)
     {
         return false;
@@ -1409,7 +1409,7 @@
 static inline =
bool
 buf_read(struct buffer *src, void *dest, int size)
 {
-    uint8_t *c=
p =3D buf_read_alloc(src, size);
+    const uint8_t *cp =3D buf_read_alloc(=
src, size);
     if (!cp)
     {
         return false;
diff --git a/src/op=
envpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec
index 45f138c=2E=2E48797b0 10=
0644
--- a/src/openvpn/comp-lz4=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -164,=
7 +164,7 @@
     ASSERT(buf_init(&work, frame->buf=2Eheadroom));
 
     /* =
do unframing/swap (assumes buf->len > 0) */
-    uint8_t *head =3D BPTR(buf=
);
+    const uint8_t *head =3D BPTR(buf);
     c =3D *head;
 
     /* Not =
compressed */
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
=
index 8f59838=2E=2E8bbc566 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/op=
envpn/crypto=2Ec
@@ -1212,7 +1212,7 @@
 
     /* init implicit IV */
     {=

-        cipher_ctx_t *cipher =3D co->key_ctx_bi=2Eencrypt=2Ecipher;
+    =
    const cipher_ctx_t *cipher =3D co->key_ctx_bi=2Eencrypt=2Ecipher;
     =
    if (cipher_ctx_mode_aead(cipher))
         {
             ASSERT(cipher=
_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
@@ -1922,7 +1922,7 @@
 =
    const char *seed =3D "tls1-prf-test";
     const char *secret =3D "tls1=
-prf-test-secret";
     uint8_t out[8];
-    uint8_t expected_out[] =3D { '=
q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
+    const uint8_t expected_out[=
] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
 
     int ret =3D ssl_=
tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,
                =
            strlen(secret), out, sizeof(out));
diff --git a/src/openvpn/cry=
pto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 37933a1=2E=2E158c841 100=
644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@=
@ -213,7 +213,7 @@
      *
      * The last generated key might have been m=
oved to the decrypt key already=2E
      */
-    struct key_ctx *highest_fu=
ture_key =3D
+    const struct key_ctx *highest_future_key =3D
         &co=
->epoch_data_keys_future[co->epoch_data_keys_future_count - 1];
 
     ASSE=
RT(co->epoch_key_recv=2Eepoch =3D=3D 1 || highest_future_key->epoch =3D=3D =
co->epoch_key_recv=2Eepoch
diff --git a/src/openvpn/cryptoapi=2Ec b/src/ope=
nvpn/cryptoapi=2Ec
index 0f95ab7=2E=2Ead2706c 100644
--- a/src/openvpn/cryp=
toapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -225,7 +225,6 @@
     const CE=
RT_INFO *info =3D cert_ctx->pCertInfo;
     const CERT_EXTENSION *ext;
    =
 DWORD cbext;
-    void *pvext;
     struct gc_arena gc =3D gc_new();
     =
const WCHAR *tmpl_name =3D wide_string(cert_prop, &gc);
 
@@ -233,7 +232,7 =
@@
     ext =3D CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info->cExtens=
ion, info->rgExtension);
     if (ext)
     {
-        pvext =3D decode_obj=
ect(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext);
+        const=
 void *pvext =3D decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value,=
 0, &cbext);
         if (pvext && cbext >=3D sizeof(CERT_TEMPLATE_EXT))
  =
       {
             const CERT_TEMPLATE_EXT *cte =3D (const CERT_TEMPLATE=
_EXT *)pvext;
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index =
ce73701=2E=2E8eae4bf 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=
=2Ec
@@ -112,7 +112,7 @@
     for (int i =3D 0; i < KEY_SCAN_SIZE; ++i)
   =
  {
         struct key_state *ks =3D get_key_scan(multi, i);
-        stru=
ct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
+        const str=
uct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
 
         if (ks=
 =3D=3D primary)
         {
@@ -577,7 +577,7 @@
                         st=
ruct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
-    struct context=
 *c =3D &mi->context;
+    const struct context *c =3D &mi->context;
 
    =
 if (!proto_is_udp(c->c2=2Elink_sockets[0]->info=2Eproto)
         || !(c->=
options=2Esockflags & SF_USE_IP_PKTINFO))
@@ -625,7 +625,7 @@
 int
 dco_mul=
ti_add_new_peer(struct multi_context *m, struct multi_instance *mi)
 {
-   =
 struct context *c =3D &mi->context;
+    const struct context *c =3D &mi->=
context;
 
     int peer_id =3D c->c2=2Etls_multi->rx_peer_id;
     struct =
sockaddr *remoteaddr, *localaddr =3D NULL;
@@ -646,14 +646,14 @@
 
     /* =
In server mode we need to fetch the remote addresses from the push config *=
/
     struct in_addr vpn_ip4 =3D { 0 };
-    struct in_addr *vpn_addr4 =3D=
 NULL;
+    const struct in_addr *vpn_addr4 =3D NULL;
     if (c->c2=2Epush=
_ifconfig_defined)
     {
         vpn_ip4=2Es_addr =3D htonl(c->c2=2Epush_=
ifconfig_local);
         vpn_addr4 =3D &vpn_ip4;
     }
 
-    struct in6_=
addr *vpn_addr6 =3D NULL;
+    const struct in6_addr *vpn_addr6 =3D NULL;
 =
    if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
         vpn_addr6 =3D &=
c->c2=2Epush_ifconfig_ipv6_local;
@@ -702,7 +702,7 @@
     }
 #endif
 
-   =
 struct context *c =3D &mi->context;
+    const struct context *c =3D &mi->=
context;
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_WIN32)=

@@ -750,7 +750,7 @@
     }
     ASSERT(TUNNEL_TYPE(mi->context=2Ec1=2Etunt=
ap) =3D=3D DEV_TYPE_TUN);
 
-    struct context *c =3D &mi->context;
+    c=
onst struct context *c =3D &mi->context;
 
     if (mi->context=2Ec2=2Epush=
_ifconfig_defined)
     {
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/op=
envpn/dco_freebsd=2Ec
index eaca86b=2E=2Ed933aaf 100644
--- a/src/openvpn/d=
co_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -134,7 +134,8 @@
 
 int=

 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sock=
addr *localaddr,
-             struct sockaddr *remoteaddr, struct in_addr =
*vpn_ipv4, struct in6_addr *vpn_ipv6)
+             struct sockaddr *remote=
addr, const struct in_addr *vpn_ipv4,
+             const struct in6_addr *=
vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *local_nvl, *remote=
_nvl;
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=
=2Eh
index da07780=2E=2Efcf8aca 100644
--- a/src/openvpn/dco_internal=2Eh
+=
++ b/src/openvpn/dco_internal=2Eh
@@ -60,7 +60,7 @@
  */
 
 int dco_new_pee=
r(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct s=
ockaddr *localaddr,
-                 struct sockaddr *remoteaddr, struct i=
n_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);
+                 struct sock=
addr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vp=
n_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned int peerid);
 
di=
ff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 4074=
6bd=2E=2E56f6259 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/d=
co_linux=2Ec
@@ -222,7 +222,8 @@
 
 int
 dco_new_peer(dco_context_t *dco, u=
nsigned int peerid, int sd, struct sockaddr *localaddr,
-             struc=
t sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6=
)
+             struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4=
,
+             const struct in6_addr *vpn_ipv6)
 {
     struct gc_arena gc=
 =3D gc_new();
     const char *remotestr =3D "[undefined]";
@@ -697,7 +698=
,7 @@
 {
     dco_context_t *dco =3D arg;
     struct nlattr *tb[CTRL_ATTR_=
MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
+   =
 const struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
 
     nla_p=
arse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(gnlh, 0)=
, NULL);
 
@@ -706,7 +707,7 @@
         return NL_SKIP;
     }
 
-    struc=
t nlattr *mcgrp;
+    const struct nlattr *mcgrp;
     int rem_mcgrp;
     =
nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)
     {
di=
ff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 2e26f2a=
=2E=2Eb3268bc 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_wi=
n=2Ec
@@ -285,8 +285,8 @@
     msg(D_DCO_DEBUG, "%s", __func__);
 
     int=
 ai_family =3D sock->info=2Elsa->bind_local->ai_family;
-    struct addrinf=
o *local =3D sock->info=2Elsa->bind_local;
-    struct addrinfo *cur =3D NU=
LL;
+    const struct addrinfo *local =3D sock->info=2Elsa->bind_local;
+  =
  const struct addrinfo *cur =3D NULL;
 
     for (cur =3D local; cur; cur =
=3D cur->ai_next)
     {
@@ -334,7 +334,7 @@
     struct addrinfo *remotead=
dr =3D sock->info=2Elsa->current_remote;
 
     struct sockaddr *local =3D =
NULL;
-    struct sockaddr *remote =3D remoteaddr->ai_addr;
+    const stru=
ct sockaddr *remote =3D remoteaddr->ai_addr;
 
     if (remoteaddr->ai_prot=
ocol =3D=3D IPPROTO_TCP || remoteaddr->ai_socktype =3D=3D SOCK_STREAM)
    =
 {
@@ -348,7 +348,7 @@
     if (sock->bind_local)
     {
         /* Use fi=
rst local address with correct address family */
-        struct addrinfo *=
bind =3D sock->info=2Elsa->bind_local;
+        const struct addrinfo *bind=
 =3D sock->info=2Elsa->bind_local;
         while (bind && !local)
        =
 {
             if (bind->ai_family =3D=3D remote->sa_family)
@@ -415,8 +41=
5,9 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned int peerid, soc=
ket_descriptor_t sd, struct sockaddr *localaddr,
-             struct socka=
ddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
+dco_=
new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd,
+=
             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+    =
         const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 =
{
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd " SOCKET_PRINTF, __func__, peer=
id, sd);
 
@@ -745,7 +746,7 @@
     struct gc_arena gc =3D gc_new();
 
    =
 int ret =3D 0;
-    struct tuntap *tt =3D dco->tt;
+    const struct tunta=
p *tt =3D dco->tt;
 
     if (!tuntap_defined(tt))
     {
@@ -869,7 +870,7 =
@@
 int
 dco_get_peer_stats_fallback(struct context *c, const bool raise_si=
gusr1_on_err)
 {
-    struct tuntap *tt =3D c->c1=2Etuntap;
+    const stru=
ct tuntap *tt =3D c->c1=2Etuntap;
 
     if (!tuntap_defined(tt))
     {
@@=
 -898,7 +899,7 @@
 int
 dco_get_peer_stats(struct context *c, const bool ra=
ise_sigusr1_on_err)
 {
-    struct tuntap *tt =3D c->c1=2Etuntap;
+    cons=
t struct tuntap *tt =3D c->c1=2Etuntap;
 
     if (!tuntap_defined(tt))
   =
  {
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 1465cdf=2E=
=2E7f4dde4 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -1=
32,7 +132,7 @@
     }
     else
     {
-        struct sockaddr_in6 *sin6 =
=3D (struct sockaddr_in6 *)ai->ai_addr;
+        const struct sockaddr_in6 =
*sin6 =3D (struct sockaddr_in6 *)ai->ai_addr;
         server->addr[server-=
>addr_count]=2Ein=2Ea6 =3D sin6->sin6_addr;
     }
 
@@ -156,7 +156,7 @@
  =
   /* Append all domains to the end of the list */
     while (*domains)
  =
   {
-        char *domain =3D *domains++;
+        const char *domain =3D =
*domains++;
         if (!validate_domain(domain))
         {
             =
return false;
@@ -699,7 +699,7 @@
 run_up_down_command(bool up, struct opti=
ons *o, const struct tuntap *tt,
                     struct dns_updown_run=
ner_info *updown_runner)
 {
-    struct dns_options *dns =3D &o->dns_option=
s;
+    const struct dns_options *dns =3D &o->dns_options;
     if (!dns->u=
pdown || (o->up_script && !dns_updown_user_set(dns) && !dns_updown_forced(d=
ns)))
     {
         return;
@@ -864,7 +864,7 @@
     }
 #ifdef _WIN32
   =
  /* Don't use iservice in DHCP mode */
-    struct tuntap_options *tto =3D=
 &o->tuntap_options;
+    const struct tuntap_options *tto =3D &o->tuntap_o=
ptions;
     if (tto->ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || tto->ip_w=
in32_type =3D=3D IPW32_SET_ADAPTIVE)
     {
         return;
diff --git a/s=
rc/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 9e17807=2E=2E8b7716a 100=
644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -557,7 +557,=
7 @@
 ep_del(struct event_set *es, event_t event)
 {
     struct epoll_even=
t ev;
-    struct ep_set *eps =3D (struct ep_set *)es;
+    const struct ep=
_set *eps =3D (struct ep_set *)es;
 
     dmsg(D_EVENT_WAIT, "EP_DEL ev=3D%=
d", (int)event);
 
@@ -572,7 +572,7 @@
 static void
 ep_ctl(struct event_se=
t *es, event_t event, unsigned int rwflags, void *arg)
 {
-    struct ep_se=
t *eps =3D (struct ep_set *)es;
+    const struct ep_set *eps =3D (struct e=
p_set *)es;
     struct epoll_event ev;
 
     CLEAR(ev);
diff --git a/src/=
openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 46e1a53=2E=2E2ade321 10=
0644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1213,7=
 +1213,7 @@
 {
     if (float_sa->sa_family =3D=3D AF_INET)
     {
-       =
 struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
+        co=
nst struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
        =
 /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4=2E However, on a
   =
       * dual-stack socket, we need to preserve the mapping otherwise openv=
pn
          * will not be able to find the peer by its transport address=
=2E
@@ -1236,7 +1236,7 @@
     }
     else
     {
-        struct sockaddr_=
in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
+        const struct sock=
addr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
         memcpy(&out_=
osaddr->addr=2Ein6, float6, sizeof(struct sockaddr_in6));
     }
 }
@@ -136=
6,8 +1366,8 @@
         return;
     }
 
-    struct openvpn_sockaddr *link=
_addr =3D &c->c2=2Eto_link_addr->dest;
-    struct link_socket_info *lsi =
=3D get_link_socket_info(c);
+    const struct openvpn_sockaddr *link_addr =
=3D &c->c2=2Eto_link_addr->dest;
+    const struct link_socket_info *lsi =
=3D get_link_socket_info(c);
 
     int ip_hdr_offset =3D 0;
     int tun_i=
p_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1=2Etuntap), buf, &ip_hdr_offset);=

@@ -1404,7 +1404,7 @@
         }
 
         /* drop packets with same dest=
 addr and port as remote */
-        uint8_t *l4_hdr =3D (uint8_t *)pip + i=
p_hlen;
+        const uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;
 
    =
     uint16_t link_port =3D ntohs(link_addr->addr=2Ein4=2Esin_port);
 
@@ -=
1451,7 +1451,7 @@
         uint16_t link_port =3D ntohs(link_addr->addr=2Ei=
n6=2Esin6_port);
 
         /* drop packets with same dest addr and port as=
 remote */
-        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct ope=
nvpn_ipv6hdr);
+        const uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(=
struct openvpn_ipv6hdr);
         uint16_t src_port =3D ntohs(*(uint16_t *)=
l4_hdr);
         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof=
(uint16_t)));
         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr=2Ei=
n6=2Esin6_addr, &pip6->daddr)) && (link_port =3D=3D dst_port))
@@ -2210,7 +=
2210,7 @@
 
                     if (e->arg >=3D MULTI_N)
                 =
    {
-                        struct event_arg *ev_arg =3D (struct event_a=
rg *)e->arg;
+                        const struct event_arg *ev_arg =3D (s=
truct event_arg *)e->arg;
                         if (ev_arg->type !=3D EV=
ENT_ARG_LINK_SOCKET)
                         {
                           =
  c->c2=2Eevent_set_status =3D ES_ERROR;
diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec
index 66bae34=2E=2Ea8e041d 100644
--- a/src/openvpn/=
init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -321,8 +321,8 @@
 management_callbac=
k_remote_entry_count(void *arg)
 {
     ASSERT(arg);
-    struct context *c=
 =3D (struct context *)arg;
-    struct connection_list *l =3D c->options=
=2Econnection_list;
+    const struct context *c =3D (struct context *)arg;=

+    const struct connection_list *l =3D c->options=2Econnection_list;
 
 =
    return l->len;
 }
@@ -339,7 +339,7 @@
 
     if (l->len > 0 && index < =
(unsigned int)l->len)
     {
-        struct connection_entry *ce =3D l->ar=
ray[index];
+        const struct connection_entry *ce =3D l->array[index];=

         const char *proto =3D proto2ascii(ce->proto, ce->af, false);
    =
     const char *status =3D (ce->flags & CE_DISABLED) ? "disabled" : "enabl=
ed";
 
@@ -517,7 +517,7 @@
 {
     struct connection_list *l =3D c->options=
=2Econnection_list;
     bool ce_defined;
-    struct connection_entry *ce;=

+    const struct connection_entry *ce;
     int n_cycles =3D 0;
 
     do=

@@ -1563,10 +1563,10 @@
     /* Tell management interface that we initiali=
zed */
     if (management)
     {
-        in_addr_t *tun_local =3D NULL;
=
-        struct in6_addr *tun_local6 =3D NULL;
+        const in_addr_t *tu=
n_local =3D NULL;
+        const struct in6_addr *tun_local6 =3D NULL;
    =
     struct openvpn_sockaddr local, remote;
-        struct link_socket_act=
ual *actual;
+        const struct link_socket_actual *actual;
         soc=
klen_t sa_len =3D sizeof(local);
         const char *detail =3D "SUCCESS";=

         if (flags & ISC_ERRORS)
@@ -4282,7 +4282,7 @@
     /* On some new=
er Android handsets, changing to a different network
      * often does not=
 trigger a TCP reset but continue using the old
      * connection (e=2Eg=
=2E using mobile connection when WiFi becomes available */
-    struct link=
_socket_info *lsi =3D get_link_socket_info(c);
+    const struct link_socke=
t_info *lsi =3D get_link_socket_info(c);
     if (lsi && proto_is_tcp(lsi->=
proto) && !samenetwork)
     {
         return -2;
diff --git a/src/openvpn=
/list=2Ec b/src/openvpn/list=2Ec
index 9e80761=2E=2Ee51dcd0 100644
--- a/sr=
c/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -167,7 +167,7 @@
 hash_rem=
ove_by_value(struct hash *hash, void *value)
 {
     struct hash_iterator h=
i;
-    struct hash_element *he;
+    const struct hash_element *he;
 
    =
 hash_iterator_init(hash, &hi);
     while ((he =3D hash_iterator_next(&hi)=
))
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 95ff2=
46=2E=2E2b0a661 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manag=
e=2Ec
@@ -3821,7 +3821,7 @@
 {
     int ok;
     char *result =3D NULL;
-  =
  struct buffer *buf;
+    const struct buffer *buf;
 
     ok =3D manageme=
nt_query_multiline(man, b64_data, prompt, cmd, state, input);
     if (ok &=
& buffer_list_defined(*input))
@@ -3850,7 +3850,7 @@
 {
     int ok;
     c=
har *result =3D NULL;
-    struct buffer *buf;
+    const struct buffer *bu=
f;
 
     ok =3D management_query_multiline(man, b64_data, prompt, cmd, sta=
te, input);
     if (ok && buffer_list_defined(*input))
diff --git a/src/op=
envpn/misc=2Ec b/src/openvpn/misc=2Ec
index a8c88c9=2E=2E54af890 100644
---=
 a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -131,7 +131,7 @@
    =
 struct auth_challenge_info *ac;
     const int len =3D strlen(auth_challen=
ge);
     char *work =3D (char *)gc_malloc(len + 1, false, gc);
-    char *=
cp;
+    const char *cp;
 
     struct buffer b;
     buf_set_read(&b, (con=
st uint8_t *)auth_challenge, len);
diff --git a/src/openvpn/mss=2Ec b/src/o=
penvpn/mss=2Ec
index 14112b4=2E=2E36bbb43 100644
--- a/src/openvpn/mss=2Ec
=
+++ b/src/openvpn/mss=2Ec
@@ -65,7 +65,7 @@
         struct buffer newbuf =
=3D *buf;
         if (buf_advance(&newbuf, hlen))
         {
-            =
struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbuf);
+    =
        const struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&=
newbuf);
             if (tc->flags & OPENVPN_TCPH_SYN_MASK)
             {=

                 mss_fixup_dowork(&newbuf, maxmss);
@@ -122,7 +122,7 @@
  =
   newbuf =3D *buf;
     if (buf_advance(&newbuf, 40) && BLENZ(&newbuf) >=
=3D sizeof(struct openvpn_tcphdr))
     {
-        struct openvpn_tcphdr *t=
c =3D (struct openvpn_tcphdr *)BPTR(&newbuf);
+        const struct openvpn=
_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbuf);
         if (tc->fl=
ags & OPENVPN_TCPH_SYN_MASK)
         {
             mss_fixup_dowork(&newb=
uf, maxmss - 20);
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
=
index f000283=2E=2E5d88f8a 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/open=
vpn/mtcp=2Ec
@@ -130,7 +130,7 @@
 void
 multi_tcp_dereference_instance(stru=
ct multi_io *multi_io, struct multi_instance *mi)
 {
-    struct link_socke=
t *sock =3D mi->context=2Ec2=2Elink_sockets[0];
+    const struct link_sock=
et *sock =3D mi->context=2Ec2=2Elink_sockets[0];
     if (sock && mi->socke=
t_set_called)
     {
         event_del(multi_io->es, socket_event_handle(s=
ock));
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 632b0=
64=2E=2E6d9c181 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2E=
c
@@ -102,7 +102,7 @@
     verdict =3D tls_pre_decrypt_lite(tas, state, &m-=
>top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
     uint8_t *hmac_key =3D m->top=
=2Ec2=2Esession_id_key;
-    struct openvpn_sockaddr *from =3D &m->top=2Ec2=
=2Efrom=2Edest;
+    const struct openvpn_sockaddr *from =3D &m->top=2Ec2=
=2Efrom=2Edest;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_window=
;
 
     if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDIC=
T_VALID_RESET_V2)
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index 20b4f14=2E=2E60a5148 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/o=
penvpn/multi=2Ec
@@ -86,7 +86,7 @@
     struct gc_arena gc =3D gc_new();
  =
   struct env_set *es;
     bool ret =3D true;
-    struct plugin_list *plu=
gins;
+    const struct plugin_list *plugins;
 
     /* get environmental v=
ariable source */
     if (mi && mi->context=2Ec2=2Ees)
@@ -1793,7 +1793,7 =
@@
      * Push the first cipher from --data-ciphers to the client that
   =
   * the client announces to be supporting=2E
      */
-    char *push_ciph=
er =3D
+    const char *push_cipher =3D
         ncp_get_best_cipher(o->ncp=
_ciphers, peer_info, tls_multi->remote_ciphername, &o->gc);
     if (push_c=
ipher)
     {
@@ -1924,7 +1924,7 @@
 static enum client_connect_return
 ccs=
_test_deferred_ret_file(struct multi_instance *mi)
 {
-    struct client_co=
nnect_defer_state *ccs =3D &(mi->client_connect_defer_state);
+    const st=
ruct client_connect_defer_state *ccs =3D &(mi->client_connect_defer_state);=

     FILE *fp =3D fopen(ccs->deferred_ret_file, "r");
     if (!fp)
     {=

@@ -2165,7 +2165,7 @@
 {
     ASSERT(mi);
     ASSERT(option_types_found);=

-    struct client_connect_defer_state *ccs =3D &(mi->client_connect_defer=
_state);
+    const struct client_connect_defer_state *ccs =3D &(mi->client=
_connect_defer_state);
     enum client_connect_return ret =3D CC_RET_SKIPP=
ED;
 
     ret =3D ccs_test_deferred_ret_file(mi);
@@ -2567,7 +2567,7 @@
 o=
verride_locked_username(struct multi_instance *mi)
 {
     struct tls_multi=
 *multi =3D mi->context=2Ec2=2Etls_multi;
-    struct options *options =3D =
&mi->context=2Eoptions;
+    const struct options *options =3D &mi->context=
=2Eoptions;
     struct tls_session *session =3D &multi->session[TM_ACTIVE]=
;
 
     if (!multi->locked_username)
@@ -2986,7 +2986,7 @@
     {
 #if def=
ined(ENABLE_ASYNC_PUSH)
         bool was_unauthenticated =3D true;
-      =
  struct key_state *ks =3D NULL;
+        const struct key_state *ks =3D NU=
LL;
         if (mi->context=2Ec2=2Etls_multi)
         {
             ks =
=3D &mi->context=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY];
@@=
 -3919,7 +3919,7 @@
 static int
 management_callback_n_clients(void *arg)
 =
{
-    struct multi_context *m =3D (struct multi_context *)arg;
+    const =
struct multi_context *m =3D (struct multi_context *)arg;
     return m->n_c=
lients;
 }
 
@@ -4430,7 +4430,7 @@
 bool
 multi_check_push_ifconfig_extra_r=
oute(struct multi_instance *mi, in_addr_t dest)
 {
-    struct options *o =
=3D &mi->context=2Eoptions;
+    const struct options *o =3D &mi->context=
=2Eoptions;
     in_addr_t local_addr, local_netmask;
 
     if (!o->ifconf=
ig_local || !o->ifconfig_remote_netmask)
@@ -4452,7 +4452,7 @@
 multi_check=
_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
                =
                            struct in6_addr *dest)
 {
-    struct options *=
o =3D &mi->context=2Eoptions;
+    const struct options *o =3D &mi->context=
=2Eoptions;
 
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits=
)
     {
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networ=
king_sitnl=2Ec
index b3f8e2b=2E=2Ee6e72d0 100644
--- a/src/openvpn/networki=
ng_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -462,7 +462,7 @@
   =
  struct rtattr *rta =3D RTM_RTA(r);
     size_t len =3D n->nlmsg_len - NLM=
SG_LENGTH(sizeof(*r));
     unsigned int table, ifindex =3D 0;
-    void *g=
w =3D NULL;
+    const void *gw =3D NULL;
 
     /* filter-out non-zero dst=
 prefixes */
     if (res->default_only && r->rtm_dst_len !=3D 0)
@@ -1179,=
7 +1179,7 @@
 net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst=
, int prefixlen, const in_addr_t *gw,
                  const char *iface, =
uint32_t table, int metric)
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

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63=
c26a66761f877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 15
G=
errit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--gp0IHTYZo0U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #15</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Remove instances of c=
onstVariable/constVariablePointer cppcheck warnings<br><br>Of varied useful=
ness, but easier to just address all of<br>them=2E<br><br>Also change vpn_*=
 parameters of dco_new_peer to const since<br>that is required by one of th=
e changes and it works (and would<br>happen anyway when doing constParamete=
rPointer)=2E<br><br>Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-=
by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1661<br>Message-Id: &lt;20260824162651=2E3=
228-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg38646=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-=
suppression<br>M sample/sample-plugins/defer/multi-auth=2Ec<br>M sample/sam=
ple-plugins/log/log=2Ec<br>M sample/sample-plugins/log/log_v3=2Ec<br>M samp=
le/sample-plugins/simple/simple=2Ec<br>M src/openvpn/argv=2Ec<br>M src/open=
vpn/auth_token=2Ec<br>M src/openvpn/base64=2Ec<br>M src/openvpn/buffer=2Ec<=
br>M src/openvpn/buffer=2Eh<br>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/=
crypto=2Ec<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/cryptoapi=2Ec=
<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn=
/dco_internal=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=
=2Ec<br>M src/openvpn/dns=2Ec<br>M src/openvpn/event=2Ec<br>M src/openvpn/f=
orward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/list=2Ec<br>M src/ope=
nvpn/manage=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/mss=2Ec<br>M src=
/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M=
 src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/ope=
nvpn/options_parse=2Ec<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/p=
ool=2Ec<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/push=2Ec<br>M src/openv=
pn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M s=
rc/openvpn/ssl=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ve=
rify=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openv=
pnmsica/msica_arg=2Ec<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/openv=
pnserv/interactive=2Ec<br>M src/plugins/auth-pam/auth-pam=2Ec<br>M src/tapc=
tl/main=2Ec<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_t=
ests/openvpn/test_crypto=2Ec<br>M tests/unit_tests/openvpn/test_cryptoapi=
=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/open=
vpn/test_ssl=2Ec<br>M tests/unit_tests/plugins/auth-pam/test_search_and_rep=
lace=2Ec<br>56 files changed, 163 insertions(+), 164 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/61/1661/15</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/de=
v-tools/cppcheck-suppression</span><br><span>index 2e3350b=2E=2E900e03c 100=
644</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>++=
+ b/dev-tools/cppcheck-suppression</span><br><span>@@ -3,8 +3,6 @@</span><b=
r><span> constParameter</span><br><span> constParameterCallback</span><br><=
span> constParameterPointer</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-constVariable</span><br><span style=3D"color: hsl(0, 100%, 40%);">-co=
nstVariablePointer</span><br><span> invalidPrintfArgType_sint</span><br><sp=
an> invalidPrintfArgType_uint</span><br><span> usleepCalled</span><br><span=
>diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/sample-pl=
ugins/defer/multi-auth=2Ec</span><br><span>index f6bbf44=2E=2Ebacf557 10064=
4</span><br><span>--- a/sample/sample-plugins/defer/multi-auth=2Ec</span><b=
r><span>+++ b/sample/sample-plugins/defer/multi-auth=2Ec</span><br><span>@@=
 -381,7 +381,7 @@</span><br><span>     }</span><br><span>     const char **=
argv =3D args-&gt;argv;</span><br><span>     const char **envp =3D args-&gt=
;envp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct plug=
in_context *context =3D (struct plugin_context *)args-&gt;handle;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_conte=
xt *context =3D (struct plugin_context *)args-&gt;handle;</span><br><span> =
    struct plugin_per_client_context *pcc =3D</span><br><span>         (str=
uct plugin_per_client_context *)args-&gt;per_client_context;</span><br><spa=
n>     switch (args-&gt;type)</span><br><span>@@ -399,7 +399,7 @@</span><br=
><span> OPENVPN_EXPORT void *</span><br><span> openvpn_plugin_client_constr=
uctor_v1(openvpn_plugin_handle_t handle)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct plugin_context *context =
=3D (struct plugin_context *)handle;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const struct plugin_context *context =3D (struct plugi=
n_context *)handle;</span><br><span>     plog(context, PLOG_NOTE, &quot;FUN=
C: openvpn_plugin_client_constructor_v1&quot;);</span><br><span>     return=
 calloc(1, sizeof(struct plugin_per_client_context));</span><br><span> }</s=
pan><br><span>@@ -407,7 +407,7 @@</span><br><span> OPENVPN_EXPORT void</spa=
n><br><span> openvpn_plugin_client_destructor_v1(openvpn_plugin_handle_t ha=
ndle, void *per_client_context)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct plugin_context *context =3D (struct=
 plugin_context *)handle;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct plugin_context *context =3D (struct plugin_context *=
)handle;</span><br><span>     plog(context, PLOG_NOTE, &quot;FUNC: openvpn_=
plugin_client_destructor_v1&quot;);</span><br><span>     free(per_client_co=
ntext);</span><br><span> }</span><br><span>diff --git a/sample/sample-plugi=
ns/log/log=2Ec b/sample/sample-plugins/log/log=2Ec</span><br><span>index 33=
0e3e0=2E=2E76350ee 100644</span><br><span>--- a/sample/sample-plugins/log/l=
og=2Ec</span><br><span>+++ b/sample/sample-plugins/log/log=2Ec</span><br><s=
pan>@@ -173,7 +173,7 @@</span><br><span> openvpn_plugin_func_v1(openvpn_plu=
gin_handle_t handle, const int type, const char *argv[],</span><br><span>  =
                      const char *envp[])</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct plugin_context *context =
=3D (struct plugin_context *)handle;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const struct plugin_context *context =3D (struct plugi=
n_context *)handle;</span><br><span> </span><br><span>     show(type, argv,=
 envp);</span><br><span> </span><br><span>diff --git a/sample/sample-plugin=
s/log/log_v3=2Ec b/sample/sample-plugins/log/log_v3=2Ec</span><br><span>ind=
ex d2d44c7=2E=2E09c6735 100644</span><br><span>--- a/sample/sample-plugins/=
log/log_v3=2Ec</span><br><span>+++ b/sample/sample-plugins/log/log_v3=2Ec</=
span><br><span>@@ -245,7 +245,7 @@</span><br><span> openvpn_plugin_func_v3(=
const int version, struct openvpn_plugin_args_func_in const *args,</span><b=
r><span>                        struct openvpn_plugin_args_func_return *ret=
ptr)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct plugin_context *context =3D (struct plugin_context *)args-&gt;=
handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct plugin_context *context =3D (struct plugin_context *)args-&gt;handle;<=
/span><br><span> </span><br><span>     printf(&quot;\nopenvpn_plugin_func_v=
3() :::::&gt;&gt; &quot;);</span><br><span>     show(args-&gt;type, args-&g=
t;argv, args-&gt;envp);</span><br><span>diff --git a/sample/sample-plugins/=
simple/simple=2Ec b/sample/sample-plugins/simple/simple=2Ec</span><br><span=
>index 687a633=2E=2E3182be0 100644</span><br><span>--- a/sample/sample-plug=
ins/simple/simple=2Ec</span><br><span>+++ b/sample/sample-plugins/simple/si=
mple=2Ec</span><br><span>@@ -104,7 +104,7 @@</span><br><span> openvpn_plugi=
n_func_v1(openvpn_plugin_handle_t handle, const int type, const char *argv[=
],</span><br><span>                        const char *envp[])</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct plug=
in_context *context =3D (struct plugin_context *)handle;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_context *conte=
xt =3D (struct plugin_context *)handle;</span><br><span> </span><br><span> =
    /* get username/password from envp string array */</span><br><span>    =
 const char *username =3D get_env(&quot;username&quot;, envp);</span><br><s=
pan>diff --git a/src/openvpn/argv=2Ec b/src/openvpn/argv=2Ec</span><br><spa=
n>index 6a5d92e=2E=2E028671d 100644</span><br><span>--- a/src/openvpn/argv=
=2Ec</span><br><span>+++ b/src/openvpn/argv=2Ec</span><br><span>@@ -359,7 +=
359,7 @@</span><br><span>      *</span><br><span>      */</span><br><span> =
    size_t argc =3D argres-&gt;argc;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    char *f =3D argv_prep_format(format, delim, &amp;argc, &=
amp;argres-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *f =3D argv_prep_format(format, delim, &amp;argc, &amp;argre=
s-&gt;gc);</span><br><span>     if (f =3D=3D NULL)</span><br><span>     {</=
span><br><span>         goto out;</span><br><span>diff --git a/src/openvpn/=
auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index bd90212=
=2E=2Ef928a41 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span=
><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -235,7 +235,=
7 @@</span><br><span>      * a new token with the empty username since we d=
o not want to loose</span><br><span>      * the information that the userna=
me cannot be trusted</span><br><span>      */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct key_state *ks =3D &amp;multi-&gt;session=
[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct key_state *ks =3D &amp;multi-&gt;session[TM_ACT=
IVE]=2Ekey[KS_PRIMARY];</span><br><span>     if (ks-&gt;auth_token_state_fl=
ags &amp; AUTH_TOKEN_VALID_EMPTYUSER)</span><br><span>     {</span><br><spa=
n>         hmac_ctx_update(ctx, (const uint8_t *)&quot;&quot;, 0);</span><b=
r><span>diff --git a/src/openvpn/base64=2Ec b/src/openvpn/base64=2Ec</span>=
<br><span>index 7af8976=2E=2E5752844 100644</span><br><span>--- a/src/openv=
pn/base64=2Ec</span><br><span>+++ b/src/openvpn/base64=2Ec</span><br><span>=
@@ -161,7 +161,7 @@</span><br><span> {</span><br><span>     const char *p;<=
/span><br><span>     unsigned char *q;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned char *e =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const unsigned char *e =3D NULL;</span><br>=
<span> </span><br><span>     q =3D data;</span><br><span>     if (size &gt;=
=3D 0)</span><br><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/bu=
ffer=2Ec</span><br><span>index 8c19902=2E=2E2b4d05d 100644</span><br><span>=
--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</=
span><br><span>@@ -500,7 +500,7 @@</span><br><span> void</span><br><span> b=
uf_null_terminate(struct buffer *buf)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char *last =3D (char *)BLAST(buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *last =
=3D (char *)BLAST(buf);</span><br><span>     if (last &amp;&amp; *last =3D=
=3D &#39;\0&#39;) /* already terminated? */</span><br><span>     {</span><b=
r><span>         return;</span><br><span>@@ -523,7 +523,7 @@</span><br><spa=
n> {</span><br><span>     while (true)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        char *last =3D (char *)BLAS=
T(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t char *last =3D (char *)BLAST(buf);</span><br><span>         if (!last)</s=
pan><br><span>         {</span><br><span>             break;</span><br><spa=
n>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><s=
pan>index 651aaed=2E=2Ebc5cffb 100644</span><br><span>--- a/src/openvpn/buf=
fer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -13=
18,7 +1318,7 @@</span><br><span> static inline bool</span><br><span> buf_co=
py_n(struct buffer *dest, struct buffer *src, int n)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *cp =3D buf_r=
ead_alloc(src, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const uint8_t *cp =3D buf_read_alloc(src, n);</span><br><span>     if (!=
cp)</span><br><span>     {</span><br><span>         return false;</span><br=
><span>@@ -1409,7 +1409,7 @@</span><br><span> static inline bool</span><br>=
<span> buf_read(struct buffer *src, void *dest, int size)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *cp =3D =
buf_read_alloc(src, size);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const uint8_t *cp =3D buf_read_alloc(src, size);</span><br><span=
>     if (!cp)</span><br><span>     {</span><br><span>         return false=
;</span><br><span>diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-=
lz4=2Ec</span><br><span>index 45f138c=2E=2E48797b0 100644</span><br><span>-=
-- a/src/openvpn/comp-lz4=2Ec</span><br><span>+++ b/src/openvpn/comp-lz4=2E=
c</span><br><span>@@ -164,7 +164,7 @@</span><br><span>     ASSERT(buf_init(=
&amp;work, frame-&gt;buf=2Eheadroom));</span><br><span> </span><br><span>  =
   /* do unframing/swap (assumes buf-&gt;len &gt; 0) */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *head =3D =
BPTR(buf);</span><br><span>     c =3D *head;</span><br><span> </span><br><s=
pan>     /* Not compressed */</span><br><span>diff --git a/src/openvpn/cryp=
to=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 8f59838=2E=2E8bbc566 =
100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/s=
rc/openvpn/crypto=2Ec</span><br><span>@@ -1212,7 +1212,7 @@</span><br><span=
> </span><br><span>     /* init implicit IV */</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        cipher_ctx_t *ciphe=
r =3D co-&gt;key_ctx_bi=2Eencrypt=2Ecipher;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const cipher_ctx_t *cipher =3D co-&gt;key_c=
tx_bi=2Eencrypt=2Ecipher;</span><br><span>         if (cipher_ctx_mode_aead=
(cipher))</span><br><span>         {</span><br><span>             ASSERT(ci=
pher_ctx_iv_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>=
@@ -1922,7 +1922,7 @@</span><br><span>     const char *seed =3D &quot;tls1-=
prf-test&quot;;</span><br><span>     const char *secret =3D &quot;tls1-prf-=
test-secret&quot;;</span><br><span>     uint8_t out[8];</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    uint8_t expected_out[] =3D { &#39;q&#=
39;, &#39;D&#39;, 0xfe, &#39;%&#39;, &#39;@&#39;, &#39;s&#39;, &#39;u&#39;,=
 0x95 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t expected_out[] =3D { &#39;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#39;, &#=
39;@&#39;, &#39;s&#39;, &#39;u&#39;, 0x95 };</span><br><span> </span><br><s=
pan>     int ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *=
)secret,</span><br><span>                            strlen(secret), out, s=
izeof(out));</span><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/sr=
c/openvpn/crypto_epoch=2Ec</span><br><span>index 37933a1=2E=2E158c841 10064=
4</span><br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/=
src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -213,7 +213,7 @@</span><br>=
<span>      *</span><br><span>      * The last generated key might have bee=
n moved to the decrypt key already=2E</span><br><span>      */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct key_ctx *highest_future=
_key =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct key_ctx *highest_future_key =3D</span><br><span>         &amp;co-&gt;=
epoch_data_keys_future[co-&gt;epoch_data_keys_future_count - 1];</span><br>=
<span> </span><br><span>     ASSERT(co-&gt;epoch_key_recv=2Eepoch =3D=3D 1 =
|| highest_future_key-&gt;epoch =3D=3D co-&gt;epoch_key_recv=2Eepoch</span>=
<br><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2E=
c</span><br><span>index 0f95ab7=2E=2Ead2706c 100644</span><br><span>--- a/s=
rc/openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=2Ec</s=
pan><br><span>@@ -225,7 +225,6 @@</span><br><span>     const CERT_INFO *inf=
o =3D cert_ctx-&gt;pCertInfo;</span><br><span>     const CERT_EXTENSION *ex=
t;</span><br><span>     DWORD cbext;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    void *pvext;</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     const WCHAR *tmpl_name =3D wide_string(cert=
_prop, &amp;gc);</span><br><span> </span><br><span>@@ -233,7 +232,7 @@</spa=
n><br><span>     ext =3D CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info=
-&gt;cExtension, info-&gt;rgExtension);</span><br><span>     if (ext)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    pvext =3D decode_object(&amp;gc, X509_CERTIFICATE_TEMPLATE, &amp;ext-&g=
t;Value, 0, &amp;cbext);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const void *pvext =3D decode_object(&amp;gc, X509_CERTIFICATE_=
TEMPLATE, &amp;ext-&gt;Value, 0, &amp;cbext);</span><br><span>         if (=
pvext &amp;&amp; cbext &gt;=3D sizeof(CERT_TEMPLATE_EXT))</span><br><span> =
        {</span><br><span>             const CERT_TEMPLATE_EXT *cte =3D (co=
nst CERT_TEMPLATE_EXT *)pvext;</span><br><span>diff --git a/src/openvpn/dco=
=2Ec b/src/openvpn/dco=2Ec</span><br><span>index ce73701=2E=2E8eae4bf 10064=
4</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openv=
pn/dco=2Ec</span><br><span>@@ -112,7 +112,7 @@</span><br><span>     for (in=
t i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span>     {</span><br><spa=
n>         struct key_state *ks =3D get_key_scan(multi, i);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct key_ctx_bi *key =3D &a=
mp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const struct key_ctx_bi *key =3D &amp;ks-&gt;cry=
pto_options=2Ekey_ctx_bi;</span><br><span> </span><br><span>         if (ks=
 =3D=3D primary)</span><br><span>         {</span><br><span>@@ -577,7 +577,=
7 @@</span><br><span>                         struct sockaddr_storage *loca=
l)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &amp;mi-&g=
t;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><sp=
an>     if (!proto_is_udp(c-&gt;c2=2Elink_sockets[0]-&gt;info=2Eproto)</spa=
n><br><span>         || !(c-&gt;options=2Esockflags &amp; SF_USE_IP_PKTINFO=
))</span><br><span>@@ -625,7 +625,7 @@</span><br><span> int</span><br><span=
> dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct context *c =3D &amp;mi-&gt;conte=
xt;</span><br><span> </span><br><span>     int peer_id =3D c-&gt;c2=2Etls_m=
ulti-&gt;rx_peer_id;</span><br><span>     struct sockaddr *remoteaddr, *loc=
aladdr =3D NULL;</span><br><span>@@ -646,14 +646,14 @@</span><br><span> </s=
pan><br><span>     /* In server mode we need to fetch the remote addresses =
from the push config */</span><br><span>     struct in_addr vpn_ip4 =3D { 0=
 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct in_addr=
 *vpn_addr4 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct in_addr *vpn_addr4 =3D NULL;</span><br><span>     if (c-=
&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span>    =
     vpn_ip4=2Es_addr =3D htonl(c-&gt;c2=2Epush_ifconfig_local);</span><br>=
<span>         vpn_addr4 =3D &amp;vpn_ip4;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct in=
6_addr *vpn_addr6 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct in6_addr *vpn_addr6 =3D NULL;</span><br><span>    =
 if (c-&gt;c2=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</span><b=
r><span>         vpn_addr6 =3D &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local;</s=
pan><br><span>@@ -702,7 +702,7 @@</span><br><span>     }</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct context *c =3D &amp;mi-&gt;co=
ntext;</span><br><span>     if (addrtype =3D=3D MR_ADDR_IPV6)</span><br><sp=
an>     {</span><br><span> #if defined(_WIN32)</span><br><span>@@ -750,7 +7=
50,7 @@</span><br><span>     }</span><br><span>     ASSERT(TUNNEL_TYPE(mi-&=
gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &amp;=
mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><b=
r><span>     if (mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/op=
envpn/dco_freebsd=2Ec</span><br><span>index eaca86b=2E=2Ed933aaf 100644</sp=
an><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/op=
envpn/dco_freebsd=2Ec</span><br><span>@@ -134,7 +134,8 @@</span><br><span> =
</span><br><span> int</span><br><span> dco_new_peer(dco_context_t *dco, uns=
igned int peerid, int sd, struct sockaddr *localaddr,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             struct sockaddr *remoteaddr, s=
truct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             struct sockaddr *remoteaddr,=
 const struct in_addr *vpn_ipv4,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             const struct in6_addr *vpn_ipv6)</span><br><span>=
 {</span><br><span>     struct ifdrv drv;</span><br><span>     nvlist_t *nv=
l, *local_nvl, *remote_nvl;</span><br><span>diff --git a/src/openvpn/dco_in=
ternal=2Eh b/src/openvpn/dco_internal=2Eh</span><br><span>index da07780=2E=
=2Efcf8aca 100644</span><br><span>--- a/src/openvpn/dco_internal=2Eh</span>=
<br><span>+++ b/src/openvpn/dco_internal=2Eh</span><br><span>@@ -60,7 +60,7=
 @@</span><br><span>  */</span><br><span> </span><br><span> int dco_new_pee=
r(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct s=
ockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struc=
t in6_addr *vpn_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 struct sockaddr *remoteaddr, const struct in_addr *vpn_=
ipv4, const struct in6_addr *vpn_ipv6);</span><br><span> </span><br><span> =
int dco_del_peer(dco_context_t *dco, unsigned int peerid);</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_=
linux=2Ec</span><br><span>index 40746bd=2E=2E56f6259 100644</span><br><span=
>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linu=
x=2Ec</span><br><span>@@ -222,7 +222,8 @@</span><br><span> </span><br><span=
> int</span><br><span> dco_new_peer(dco_context_t *dco, unsigned int peerid=
, int sd, struct sockaddr *localaddr,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-             struct sockaddr *remoteaddr, struct in_addr *v=
pn_ipv4, struct in6_addr *vpn_ipv6)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             struct sockaddr *remoteaddr, const struct in_a=
ddr *vpn_ipv4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        const struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>     const char *rem=
otestr =3D &quot;[undefined]&quot;;</span><br><span>@@ -697,7 +698,7 @@</sp=
an><br><span> {</span><br><span>     dco_context_t *dco =3D arg;</span><br>=
<span>     struct nlattr *tb[CTRL_ATTR_MAX + 1];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg=
_hdr(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span> =
</span><br><span>     nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0=
), genlmsg_attrlen(gnlh, 0), NULL);</span><br><span> </span><br><span>@@ -7=
06,7 +707,7 @@</span><br><span>         return NL_SKIP;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct nlattr *mcgrp;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct nlattr *mcgrp;</span><br><span>     int rem_mcgrp;</=
span><br><span>     nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], =
rem_mcgrp)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index 2e26f2a=2E=2Eb3=
268bc 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>=
+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -285,8 +285,8 @@</span><br=
><span>     msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><br><span> </=
span><br><span>     int ai_family =3D sock-&gt;info=2Elsa-&gt;bind_local-&g=
t;ai_family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t addrinfo *local =3D sock-&gt;info=2Elsa-&gt;bind_local;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *cur =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct addrinf=
o *local =3D sock-&gt;info=2Elsa-&gt;bind_local;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct addrinfo *cur =3D NULL;</span=
><br><span> </span><br><span>     for (cur =3D local; cur; cur =3D cur-&gt;=
ai_next)</span><br><span>     {</span><br><span>@@ -334,7 +334,7 @@</span><=
br><span>     struct addrinfo *remoteaddr =3D sock-&gt;info=2Elsa-&gt;curre=
nt_remote;</span><br><span> </span><br><span>     struct sockaddr *local =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct s=
ockaddr *remote =3D remoteaddr-&gt;ai_addr;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct sockaddr *remote =3D remoteaddr-&g=
t;ai_addr;</span><br><span> </span><br><span>     if (remoteaddr-&gt;ai_pro=
tocol =3D=3D IPPROTO_TCP || remoteaddr-&gt;ai_socktype =3D=3D SOCK_STREAM)<=
/span><br><span>     {</span><br><span>@@ -348,7 +348,7 @@</span><br><span>=
     if (sock-&gt;bind_local)</span><br><span>     {</span><br><span>      =
   /* Use first local address with correct address family */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct addrinfo *bind =3D so=
ck-&gt;info=2Elsa-&gt;bind_local;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const struct addrinfo *bind =3D sock-&gt;info=2Elsa-&=
gt;bind_local;</span><br><span>         while (bind &amp;&amp; !local)</spa=
n><br><span>         {</span><br><span>             if (bind-&gt;ai_family =
=3D=3D remote-&gt;sa_family)</span><br><span>@@ -415,8 +415,9 @@</span><br>=
<span> }</span><br><span> </span><br><span> int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco, unsigned int pee=
rid, socket_descriptor_t sd, struct sockaddr *localaddr,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-             struct sockaddr *remoteaddr=
, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_context_t *dco, unsigne=
d int peerid, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             struct sockaddr *localaddr, struct sockaddr =
*remoteaddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)</spa=
n><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d, =
fd &quot; SOCKET_PRINTF, __func__, peerid, sd);</span><br><span> </span><br=
><span>@@ -745,7 +746,7 @@</span><br><span>     struct gc_arena gc =3D gc_n=
ew();</span><br><span> </span><br><span>     int ret =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap *tt =3D dco-&gt;tt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tu=
ntap *tt =3D dco-&gt;tt;</span><br><span> </span><br><span>     if (!tuntap=
_defined(tt))</span><br><span>     {</span><br><span>@@ -869,7 +870,7 @@</s=
pan><br><span> int</span><br><span> dco_get_peer_stats_fallback(struct cont=
ext *c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap *tt =3D c-&gt;c1=2E=
tuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct tuntap *tt =3D c-&gt;c1=2Etuntap;</span><br><span> </span><br><span>  =
   if (!tuntap_defined(tt))</span><br><span>     {</span><br><span>@@ -898,=
7 +899,7 @@</span><br><span> int</span><br><span> dco_get_peer_stats(struct=
 context *c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap *tt =3D c-&gt;=
c1=2Etuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct tuntap *tt =3D c-&gt;c1=2Etuntap;</span><br><span> </span><br><sp=
an>     if (!tuntap_defined(tt))</span><br><span>     {</span><br><span>dif=
f --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><span>index 1=
465cdf=2E=2E7f4dde4 100644</span><br><span>--- a/src/openvpn/dns=2Ec</span>=
<br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -132,7 +132,7 @@</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr_in6 =
*sin6 =3D (struct sockaddr_in6 *)ai-&gt;ai_addr;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const struct sockaddr_in6 *sin6 =3D (s=
truct sockaddr_in6 *)ai-&gt;ai_addr;</span><br><span>         server-&gt;ad=
dr[server-&gt;addr_count]=2Ein=2Ea6 =3D sin6-&gt;sin6_addr;</span><br><span=
>     }</span><br><span> </span><br><span>@@ -156,7 +156,7 @@</span><br><sp=
an>     /* Append all domains to the end of the list */</span><br><span>   =
  while (*domains)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        char *domain =3D *domains++;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const char *domain =3D *domain=
s++;</span><br><span>         if (!validate_domain(domain))</span><br><span=
>         {</span><br><span>             return false;</span><br><span>@@ -=
699,7 +699,7 @@</span><br><span> run_up_down_command(bool up, struct option=
s *o, const struct tuntap *tt,</span><br><span>                     struct =
dns_updown_runner_info *updown_runner)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct dns_options *dns =3D &amp;o-=
&gt;dns_options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct dns_options *dns =3D &amp;o-&gt;dns_options;</span><br><span>=
     if (!dns-&gt;updown || (o-&gt;up_script &amp;&amp; !dns_updown_user_se=
t(dns) &amp;&amp; !dns_updown_forced(dns)))</span><br><span>     {</span><b=
r><span>         return;</span><br><span>@@ -864,7 +864,7 @@</span><br><spa=
n>     }</span><br><span> #ifdef _WIN32</span><br><span>     /* Don&#39;t u=
se iservice in DHCP mode */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct tuntap_options *tto =3D &amp;o-&gt;tuntap_options;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tuntap_opt=
ions *tto =3D &amp;o-&gt;tuntap_options;</span><br><span>     if (tto-&gt;i=
p_win32_type =3D=3D IPW32_SET_DHCP_MASQ || tto-&gt;ip_win32_type =3D=3D IPW=
32_SET_ADAPTIVE)</span><br><span>     {</span><br><span>         return;</s=
pan><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec</s=
pan><br><span>index 9e17807=2E=2E8b7716a 100644</span><br><span>--- a/src/o=
penvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><br><spa=
n>@@ -557,7 +557,7 @@</span><br><span> ep_del(struct event_set *es, event_t=
 event)</span><br><span> {</span><br><span>     struct epoll_event ev;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ep_set *eps =3D=
 (struct ep_set *)es;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct ep_set *eps =3D (struct ep_set *)es;</span><br><span> </=
span><br><span>     dmsg(D_EVENT_WAIT, &quot;EP_DEL ev=3D%d&quot;, (int)eve=
nt);</span><br><span> </span><br><span>@@ -572,7 +572,7 @@</span><br><span>=
 static void</span><br><span> ep_ctl(struct event_set *es, event_t event, u=
nsigned int rwflags, void *arg)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct ep_set *eps =3D (struct ep_set *)es=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct e=
p_set *eps =3D (struct ep_set *)es;</span><br><span>     struct epoll_event=
 ev;</span><br><span> </span><br><span>     CLEAR(ev);</span><br><span>diff=
 --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>=
index 46e1a53=2E=2E2ade321 100644</span><br><span>--- a/src/openvpn/forward=
=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -1213=
,7 +1213,7 @@</span><br><span> {</span><br><span>     if (float_sa-&gt;sa_f=
amily =3D=3D AF_INET)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        struct sockaddr_in *float4 =3D (struct socka=
ddr_in *)float_sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;=
</span><br><span>         /* DCO treats IPv4-mapped IPv6 addresses as pure =
IPv4=2E However, on a</span><br><span>          * dual-stack socket, we nee=
d to preserve the mapping otherwise openvpn</span><br><span>          * wil=
l not be able to find the peer by its transport address=2E</span><br><span>=
@@ -1236,7 +1236,7 @@</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct sock=
addr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;</span><br><span>     =
    memcpy(&amp;out_osaddr-&gt;addr=2Ein6, float6, sizeof(struct sockaddr_i=
n6));</span><br><span>     }</span><br><span> }</span><br><span>@@ -1366,8 =
+1366,8 @@</span><br><span>         return;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct o=
penvpn_sockaddr *link_addr =3D &amp;c-&gt;c2=2Eto_link_addr-&gt;dest;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_info=
 *lsi =3D get_link_socket_info(c);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct openvpn_sockaddr *link_addr =3D &amp;c-&gt;=
c2=2Eto_link_addr-&gt;dest;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct link_socket_info *lsi =3D get_link_socket_info(c);=
</span><br><span> </span><br><span>     int ip_hdr_offset =3D 0;</span><br>=
<span>     int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;c1=2Etuntap)=
, buf, &amp;ip_hdr_offset);</span><br><span>@@ -1404,7 +1404,7 @@</span><br=
><span>         }</span><br><span> </span><br><span>         /* drop packet=
s with same dest addr and port as remote */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const uint8=
_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;</span><br><span> </span><br><span>=
         uint16_t link_port =3D ntohs(link_addr-&gt;addr=2Ein4=2Esin_port);=
</span><br><span> </span><br><span>@@ -1451,7 +1451,7 @@</span><br><span>  =
       uint16_t link_port =3D ntohs(link_addr-&gt;addr=2Ein6=2Esin6_port);<=
/span><br><span> </span><br><span>         /* drop packets with same dest a=
ddr and port as remote */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv=
6hdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);</spa=
n><br><span>         uint16_t src_port =3D ntohs(*(uint16_t *)l4_hdr);</spa=
n><br><span>         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + siz=
eof(uint16_t)));</span><br><span>         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&=
amp;link_addr-&gt;addr=2Ein6=2Esin6_addr, &amp;pip6-&gt;daddr)) &amp;&amp; =
(link_port =3D=3D dst_port))</span><br><span>@@ -2210,7 +2210,7 @@</span><b=
r><span> </span><br><span>                     if (e-&gt;arg &gt;=3D MULTI_=
N)</span><br><span>                     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        struct event_arg *ev_arg =3D (s=
truct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        const struct event_arg *ev_arg =3D (struct=
 event_arg *)e-&gt;arg;</span><br><span>                         if (ev_arg=
-&gt;type !=3D EVENT_ARG_LINK_SOCKET)</span><br><span>                     =
    {</span><br><span>                             c-&gt;c2=2Eevent_set_sta=
tus =3D ES_ERROR;</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/o=
penvpn/init=2Ec</span><br><span>index 66bae34=2E=2Ea8e041d 100644</span><br=
><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2E=
c</span><br><span>@@ -321,8 +321,8 @@</span><br><span> management_callback_=
remote_entry_count(void *arg)</span><br><span> {</span><br><span>     ASSER=
T(arg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct con=
text *c =3D (struct context *)arg;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct connection_list *l =3D c-&gt;options=2Econnection_l=
ist;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t context *c =3D (struct context *)arg;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct connection_list *l =3D c-&gt;options=
=2Econnection_list;</span><br><span> </span><br><span>     return l-&gt;len=
;</span><br><span> }</span><br><span>@@ -339,7 +339,7 @@</span><br><span> <=
/span><br><span>     if (l-&gt;len &gt; 0 &amp;&amp; index &lt; (unsigned i=
nt)l-&gt;len)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct connection_entry *ce =3D l-&gt;array[index];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 connection_entry *ce =3D l-&gt;array[index];</span><br><span>         cons=
t char *proto =3D proto2ascii(ce-&gt;proto, ce-&gt;af, false);</span><br><s=
pan>         const char *status =3D (ce-&gt;flags &amp; CE_DISABLED) ? &quo=
t;disabled&quot; : &quot;enabled&quot;;</span><br><span> </span><br><span>@=
@ -517,7 +517,7 @@</span><br><span> {</span><br><span>     struct connectio=
n_list *l =3D c-&gt;options=2Econnection_list;</span><br><span>     bool ce=
_defined;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct c=
onnection_entry *ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct connection_entry *ce;</span><br><span>     int n_cycles =
=3D 0;</span><br><span> </span><br><span>     do</span><br><span>@@ -1563,1=
0 +1563,10 @@</span><br><span>     /* Tell management interface that we ini=
tialized */</span><br><span>     if (management)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        in_addr_t *tun_lo=
cal =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
struct in6_addr *tun_local6 =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const in_addr_t *tun_local =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const struct in6_addr *t=
un_local6 =3D NULL;</span><br><span>         struct openvpn_sockaddr local,=
 remote;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t link_socket_actual *actual;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const struct link_socket_actual *actual;</span><br><span>=
         socklen_t sa_len =3D sizeof(local);</span><br><span>         const=
 char *detail =3D &quot;SUCCESS&quot;;</span><br><span>         if (flags &=
amp; ISC_ERRORS)</span><br><span>@@ -4282,7 +4282,7 @@</span><br><span>    =
 /* On some newer Android handsets, changing to a different network</span><=
br><span>      * often does not trigger a TCP reset but continue using the =
old</span><br><span>      * connection (e=2Eg=2E using mobile connection wh=
en WiFi becomes available */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct link_socket_info *lsi =3D get_link_socket_info(c);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct link_sock=
et_info *lsi =3D get_link_socket_info(c);</span><br><span>     if (lsi &amp=
;&amp; proto_is_tcp(lsi-&gt;proto) &amp;&amp; !samenetwork)</span><br><span=
>     {</span><br><span>         return -2;</span><br><span>diff --git a/sr=
c/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index 9e80761=2E=
=2Ee51dcd0 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><spa=
n>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -167,7 +167,7 @@</span><br>=
<span> hash_remove_by_value(struct hash *hash, void *value)</span><br><span=
> {</span><br><span>     struct hash_iterator hi;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct hash_element *he;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct hash_element *he;</sp=
an><br><span> </span><br><span>     hash_iterator_init(hash, &amp;hi);</spa=
n><br><span>     while ((he =3D hash_iterator_next(&amp;hi)))</span><br><sp=
an>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><=
span>index 95ff246=2E=2E2b0a661 100644</span><br><span>--- a/src/openvpn/ma=
nage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3=
821,7 +3821,7 @@</span><br><span> {</span><br><span>     int ok;</span><br>=
<span>     char *result =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct buffer *buf;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const struct buffer *buf;</span><br><span> </span><br><=
span>     ok =3D management_query_multiline(man, b64_data, prompt, cmd, sta=
te, input);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*inp=
ut))</span><br><span>@@ -3850,7 +3850,7 @@</span><br><span> {</span><br><sp=
an>     int ok;</span><br><span>     char *result =3D NULL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *buf;</sp=
an><br><span> </span><br><span>     ok =3D management_query_multiline(man, =
b64_data, prompt, cmd, state, input);</span><br><span>     if (ok &amp;&amp=
; buffer_list_defined(*input))</span><br><span>diff --git a/src/openvpn/mis=
c=2Ec b/src/openvpn/misc=2Ec</span><br><span>index a8c88c9=2E=2E54af890 100=
644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/op=
envpn/misc=2Ec</span><br><span>@@ -131,7 +131,7 @@</span><br><span>     str=
uct auth_challenge_info *ac;</span><br><span>     const int len =3D strlen(=
auth_challenge);</span><br><span>     char *work =3D (char *)gc_malloc(len =
+ 1, false, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
har *cp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *cp;</span><br><span> </span><br><span>     struct buffer b;</span><br>=
<span>     buf_set_read(&amp;b, (const uint8_t *)auth_challenge, len);</spa=
n><br><span>diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><b=
r><span>index 14112b4=2E=2E36bbb43 100644</span><br><span>--- a/src/openvpn=
/mss=2Ec</span><br><span>+++ b/src/openvpn/mss=2Ec</span><br><span>@@ -65,7=
 +65,7 @@</span><br><span>         struct buffer newbuf =3D *buf;</span><br=
><span>         if (buf_advance(&amp;newbuf, hlen))</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct=
 openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            const struct op=
envpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br>=
<span>             if (tc-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br>=
<span>             {</span><br><span>                 mss_fixup_dowork(&amp=
;newbuf, maxmss);</span><br><span>@@ -122,7 +122,7 @@</span><br><span>     =
newbuf =3D *buf;</span><br><span>     if (buf_advance(&amp;newbuf, 40) &amp=
;&amp; BLENZ(&amp;newbuf) &gt;=3D sizeof(struct openvpn_tcphdr))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct o=
penvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br=
><span>         if (tc-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><sp=
an>         {</span><br><span>             mss_fixup_dowork(&amp;newbuf, ma=
xmss - 20);</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn=
/mtcp=2Ec</span><br><span>index f000283=2E=2E5d88f8a 100644</span><br><span=
>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</spa=
n><br><span>@@ -130,7 +130,7 @@</span><br><span> void</span><br><span> mult=
i_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance=
 *mi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct link_socket *sock =3D mi-&gt;context=2Ec2=2Elink_sockets[0];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct lin=
k_socket *sock =3D mi-&gt;context=2Ec2=2Elink_sockets[0];</span><br><span> =
    if (sock &amp;&amp; mi-&gt;socket_set_called)</span><br><span>     {</s=
pan><br><span>         event_del(multi_io-&gt;es, socket_event_handle(sock)=
);</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec=
</span><br><span>index 632b064=2E=2E6d9c181 100644</span><br><span>--- a/sr=
c/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><sp=
an>@@ -102,7 +102,7 @@</span><br><span>     verdict =3D tls_pre_decrypt_lit=
e(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span=
><br><span> </span><br><span>     uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Ese=
ssion_id_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct openvpn_socka=
ddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int h=
andwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> </sp=
an><br><span>     if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=
=3D VERDICT_VALID_RESET_V2)</span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 20b4f14=2E=2E60a5148 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -86,7 +86,7 @@</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span>     struct env_set *es;</spa=
n><br><span>     bool ret =3D true;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct plugin_list *plugins;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct plugin_list *plugins;</span><br=
><span> </span><br><span>     /* get environmental variable source */</span=
><br><span>     if (mi &amp;&amp; mi-&gt;context=2Ec2=2Ees)</span><br><span=
>@@ -1793,7 +1793,7 @@</span><br><span>      * Push the first cipher from -=
-data-ciphers to the client that</span><br><span>      * the client announc=
es to be supporting=2E</span><br><span>      */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    char *push_cipher =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *push_cipher =3D</span><br=
><span>         ncp_get_best_cipher(o-&gt;ncp_ciphers, peer_info, tls_multi=
-&gt;remote_ciphername, &amp;o-&gt;gc);</span><br><span>     if (push_ciphe=
r)</span><br><span>     {</span><br><span>@@ -1924,7 +1924,7 @@</span><br><=
span> static enum client_connect_return</span><br><span> ccs_test_deferred_=
ret_file(struct multi_instance *mi)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct client_connect_defer_state *ccs=
 =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct client_connect_defer_state *ccs=
 =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><span>     FILE *f=
p =3D fopen(ccs-&gt;deferred_ret_file, &quot;r&quot;);</span><br><span>    =
 if (!fp)</span><br><span>     {</span><br><span>@@ -2165,7 +2165,7 @@</spa=
n><br><span> {</span><br><span>     ASSERT(mi);</span><br><span>     ASSERT=
(option_types_found);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct client_connect_defer_state *ccs =3D &amp;(mi-&gt;client_connect_=
defer_state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct client_connect_defer_state *ccs =3D &amp;(mi-&gt;client_connect_=
defer_state);</span><br><span>     enum client_connect_return ret =3D CC_RE=
T_SKIPPED;</span><br><span> </span><br><span>     ret =3D ccs_test_deferred=
_ret_file(mi);</span><br><span>@@ -2567,7 +2567,7 @@</span><br><span> overr=
ide_locked_username(struct multi_instance *mi)</span><br><span> {</span><br=
><span>     struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct options *opti=
ons =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct options *options =3D &amp;mi-&gt;contex=
t=2Eoptions;</span><br><span>     struct tls_session *session =3D &amp;mult=
i-&gt;session[TM_ACTIVE];</span><br><span> </span><br><span>     if (!multi=
-&gt;locked_username)</span><br><span>@@ -2986,7 +2986,7 @@</span><br><span=
>     {</span><br><span> #if defined(ENABLE_ASYNC_PUSH)</span><br><span>   =
      bool was_unauthenticated =3D true;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct key_state *ks =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const struct key_state *ks =
=3D NULL;</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi)</sp=
an><br><span>         {</span><br><span>             ks =3D &amp;mi-&gt;con=
text=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><=
span>@@ -3919,7 +3919,7 @@</span><br><span> static int</span><br><span> man=
agement_callback_n_clients(void *arg)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct multi_context *m =3D (struct =
multi_context *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct multi_context *m =3D (struct multi_context *)arg;</span><=
br><span>     return m-&gt;n_clients;</span><br><span> }</span><br><span> <=
/span><br><span>@@ -4430,7 +4430,7 @@</span><br><span> bool</span><br><span=
> multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_=
t dest)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct options *o =3D &=
amp;mi-&gt;context=2Eoptions;</span><br><span>     in_addr_t local_addr, lo=
cal_netmask;</span><br><span> </span><br><span>     if (!o-&gt;ifconfig_loc=
al || !o-&gt;ifconfig_remote_netmask)</span><br><span>@@ -4452,7 +4452,7 @@=
</span><br><span> multi_check_push_ifconfig_ipv6_extra_route(struct multi_i=
nstance *mi,</span><br><span>                                            st=
ruct in6_addr *dest)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct options *o =3D &amp;mi-&gt;context=2Eoptions;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct opt=
ions *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span> </span><br><spa=
n>     if (!o-&gt;ifconfig_ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/networking_sitn=
l=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index b3f8e2b=2E=
=2Ee6e72d0 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</s=
pan><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -46=
2,7 +462,7 @@</span><br><span>     struct rtattr *rta =3D RTM_RTA(r);</span=
><br><span>     size_t len =3D n-&gt;nlmsg_len - NLMSG_LENGTH(sizeof(*r));<=
/span><br><span>     unsigned int table, ifindex =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    void *gw =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const void *gw =3D NULL;</span><br=
><span> </span><br><span>     /* filter-out non-zero dst prefixes */</span>=
<br><span>     if (res-&gt;default_only &amp;&amp; r-&gt;rtm_dst_len !=3D 0=
)</span><br><span>@@ -1179,7 +1179,7 @@</span><br><span> net_route_v4_add(o=
penvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t=
 *gw,</span><br><span>                  const char *iface, uint32_t table, =
int metric)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const in_addr_t *dst_ptr =3D NU=
LL, *gw_ptr =3D NULL;</span><br><span>     in_addr_t dst_be =3D 0, gw_be =
=3D 0;</span><br><span>     char dst_str[INET_ADDRSTRLEN];</span><br><span>=
     char gw_str[INET_ADDRSTRLEN];</span><br><span>@@ -1326,7 +1326,7 @@</s=
pan><br><span> #if defined(ENABLE_DCO)</span><br><span>     if (arg &amp;&a=
mp; (strcmp(type, OVPN_FAMILY_NAME) =3D=3D 0))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_context_t *dco =
=3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st dco_context_t *dco =3D arg;</span><br><span>         struct rtattr *data=
 =3D SITNL_NEST(&amp;req=2En, sizeof(req), IFLA_INFO_DATA);</span><br><span=
> </span><br><span>         /* the netlink format is uint8_t for this and u=
sing something</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/o=
penvpn/options=2Ec</span><br><span>index 107b3fa9=2E=2E23741f0 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -1696,7 +1696,7 @@</span><br><span> </span><=
br><span>     for (int i =3D 0; i &lt; ce-&gt;local_list-&gt;len; i++)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct local_entry *le =3D ce-&gt;local_list-&gt;array[i];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const struct local_entr=
y *le =3D ce-&gt;local_list-&gt;array[i];</span><br><span> </span><br><span=
>         if (proto_is_net(le-&gt;proto) &amp;&amp; string_defined_equal(le=
-&gt;local, ce-&gt;remote)</span><br><span>             &amp;&amp; string_d=
efined_equal(le-&gt;port, ce-&gt;remote_port))</span><br><span>@@ -7693,7 +=
7693,7 @@</span><br><span> #ifdef ENABLE_PKCS11</span><br><span>     else i=
f (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !p[3])</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char=
 *provider =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const char *provider =3D p[1];</span><br><span>         bool cert_=
private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=3D 0))=
;</span><br><span> </span><br><span> #ifdef DEFAULT_PKCS11_MODULE</span><br=
><span>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_par=
se=2Ec</span><br><span>index a8c4aee=2E=2E88ab4d2 100644</span><br><span>--=
- a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options=
_parse=2Ec</span><br><span>@@ -268,7 +268,7 @@</span><br><span>     while (=
in_src_get(is, line, sizeof(line)))</span><br><span>     {</span><br><span>=
         (*num_lines)++;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        char *line_ptr =3D line;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        const char *line_ptr =3D line;</span><br><span>    =
     /* Remove leading spaces */</span><br><span>         while (isspace(*l=
ine_ptr))</span><br><span>         {</span><br><span>diff --git a/src/openv=
pn/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index d7=
2ea25c=2E=2E779c38e 100644</span><br><span>--- a/src/openvpn/options_util=
=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ =
-273,7 +273,7 @@</span><br><span>         return true;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct pull_filter *f;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct pull_filter *f;</span><br><span> </span><br><span>  =
   for (f =3D o-&gt;pull_filter_list-&gt;head; f; f =3D f-&gt;next)</span><=
br><span>     {</span><br><span>diff --git a/src/openvpn/pool=2Ec b/src/ope=
nvpn/pool=2Ec</span><br><span>index ff74e7c=2E=2E80dec6c 100644</span><br><=
span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec<=
/span><br><span>@@ -63,7 +63,7 @@</span><br><span> </span><br><span>     fo=
r (i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct ifconfig_pool_entry =
*ipe =3D &amp;pool-&gt;list[i];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const struct ifconfig_pool_entry *ipe =3D &amp;pool-&gt=
;list[i];</span><br><span>         if (!ipe-&gt;in_use)</span><br><span>   =
      {</span><br><span>             /*</span><br><span>diff --git a/src/op=
envpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 9acb2fa=2E=2E=
e0700aa 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>=
+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -703,7 +703,7 @@</span><br><=
span> #if PROXY_DIGEST_AUTH</span><br><span>         else if (p-&gt;auth_me=
thod =3D=3D HTTP_AUTH_DIGEST &amp;&amp; !processed)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *=
pa =3D p-&gt;proxy_authenticate;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            const char *pa =3D p-&gt;proxy_authenticate;</span=
><br><span>             const int method =3D p-&gt;auth_method;</span><br><=
span>             ASSERT(pa);</span><br><span> </span><br><span>diff --git =
a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 5b15f71=
=2E=2Efa7bf1e 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><=
span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -271,8 +271,8 @@</span><=
br><span>     }</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> =
    struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[T=
M_ACTIVE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
man_def_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct env_set *es =3D session=
-&gt;opt-&gt;es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct man_def_auth_context *mda =3D session-&gt;opt-&gt;mda_context=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct e=
nv_set *es =3D session-&gt;opt-&gt;es;</span><br><span>     unsigned int md=
a_key_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><b=
r><span> </span><br><span>     management_notify_client_cr_response(mda_key=
_id, mda, es, m);</span><br><span>@@ -917,7 +917,7 @@</span><br><span> push=
_options(struct options *o, char **p, msglvl_t msglevel, struct gc_arena *g=
c)</span><br><span> {</span><br><span>     const char **argv =3D make_exten=
ded_arg_array(p, false, gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    char *opt =3D print_argv(argv, gc, 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char *opt =3D print_argv(argv, gc, =
0);</span><br><span>     push_option(o, opt, msglevel);</span><br><span> }<=
/span><br><span> </span><br><span>@@ -1199,7 +1199,7 @@</span><br><span>   =
                  /* parse route-ipv6 arguments */</span><br><span>        =
             if (get_ipv6_addr(p[1], &amp;network, &amp;netbits, D_ROUTE_DE=
BUG))</span><br><span>                     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        struct iroute_ipv6 *ir;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
const struct iroute_ipv6 *ir;</span><br><span> </span><br><span>           =
              /* does this route-ipv6 match an iroute-ipv6? */</span><br><s=
pan>                         for (ir =3D o-&gt;iroutes_ipv6; ir !=3D NULL; =
ir =3D ir-&gt;next)</span><br><span>diff --git a/src/openvpn/route=2Ec b/sr=
c/openvpn/route=2Ec</span><br><span>index 6dbe3ec=2E=2E03a2526 100644</span=
><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/ro=
ute=2Ec</span><br><span>@@ -667,7 +667,7 @@</span><br><span> </span><br><sp=
an>     /* parse the routes from opt to rl */</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        struct route_option =
*ro;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const s=
truct route_option *ro;</span><br><span>         for (ro =3D opt-&gt;routes=
; ro; ro =3D ro-&gt;next)</span><br><span>         {</span><br><span>      =
       struct addrinfo *netlist =3D NULL;</span><br><span>@@ -679,7 +679,7 =
@@</span><br><span>             }</span><br><span>             else</span><=
br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                struct addrinfo *curele;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                const struct addrinfo *curele;</span=
><br><span>                 for (curele =3D netlist; curele; curele =3D cur=
ele-&gt;ai_next)</span><br><span>                 {</span><br><span>       =
              struct route_ipv4 *new;</span><br><span>@@ -799,7 +799,7 @@</=
span><br><span>     need_remote_ipv6_route =3D false;</span><br><span> </sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      struct route_ipv6_option *ro6;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const struct route_ipv6_option *ro6;</span><br><sp=
an>         for (ro6 =3D opt6-&gt;routes_ipv6; ro6; ro6 =3D ro6-&gt;next)</=
span><br><span>         {</span><br><span>             struct route_ipv6 *r=
6;</span><br><span>@@ -1187,7 +1187,7 @@</span><br><span> {</span><br><span=
>     if (rl6 &amp;&amp; (rl6-&gt;iflags &amp; RL_ROUTES_ADDED))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct route_ipv6 *r6;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const struct route_ipv6 *r6;</span><br><span>         for (r6 =3D=
 rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;next)</span><br><span>         {</s=
pan><br><span>             delete_route_ipv6(r6, tt, es, ctx);</span><br><s=
pan>@@ -1226,7 +1226,7 @@</span><br><span> void</span><br><span> print_rout=
e_options(const struct route_option_list *rol, msglvl_t msglevel)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct r=
oute_option *ro;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct route_option *ro;</span><br><span>     if (rol-&gt;flags &amp=
; RG_ENABLE)</span><br><span>     {</span><br><span>         msg(msglevel, =
&quot;  [redirect_default_gateway local=3D%d]&quot;, (rol-&gt;flags &amp; R=
G_LOCAL) !=3D 0);</span><br><span>@@ -1335,7 +1335,7 @@</span><br><span> se=
tenv_routes(struct env_set *es, const struct route_list *rl)</span><br><spa=
n> {</span><br><span>     int i =3D 1;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct route_ipv4 *r;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct route_ipv4 *r;</span><br><span>    =
 for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</span><br><span>     {</spa=
n><br><span>         setenv_route(es, r, i++);</span><br><span>@@ -1372,7 +=
1372,7 @@</span><br><span> setenv_routes_ipv6(struct env_set *es, const str=
uct route_ipv6_list *rl6)</span><br><span> {</span><br><span>     int i =3D=
 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct route_i=
pv6 *r6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct route_ipv6 *r6;</span><br><span>     for (r6 =3D rl6-&gt;routes_ipv6;=
 r6; r6 =3D r6-&gt;next)</span><br><span>     {</span><br><span>         se=
tenv_route_ipv6(es, r6, i++);</span><br><span>@@ -2423,7 +2423,7 @@</span><=
br><span>          */</span><br><span>         if (rl &amp;&amp; tt-&gt;did=
_ifconfig_setup)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            struct route_ipv4 *r;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            const struct route_ipv4 *r;=
</span><br><span>             for (r =3D rl-&gt;routes, len =3D 0; r; r =3D=
 r-&gt;next, ++len)</span><br><span>             {</span><br><span>        =
         test_route_helper(&amp;ret, &amp;count, &amp;good, &amp;ambig, ada=
pters, r-&gt;gateway);</span><br><span>@@ -3110,7 +3110,8 @@</span><br><spa=
n>     /* scan adapter list */</span><br><span>     if (rgi-&gt;flags &amp;=
 RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        struct ifreq *ifr, *ifend;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const struct ifreq *ifr;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct ifreq =
*ifend;</span><br><span>         in_addr_t addr, netmask;</span><br><span> =
        struct ifreq ifreq;</span><br><span>         struct ifconf ifc;</sp=
an><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</=
span><br><span>index 0f66ad51=2E=2Efba0a22 100644</span><br><span>--- a/src=
/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br>=
<span>@@ -393,7 +393,7 @@</span><br><span> </span><br><span>             fo=
r (int j =3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</span><br><span>    =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     struct local_entry *le =3D ce-&gt;local_list-&gt;array[j];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                const struct lo=
cal_entry *le =3D ce-&gt;local_list-&gt;array[j];</span><br><span> </span><=
br><span>                 if (!le-&gt;local)</span><br><span>              =
   {</span><br><span>@@ -898,12 +898,10 @@</span><br><span>      * What is =
the correct way to deal with it?</span><br><span>      */</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *=
cur;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     ASSERT(local);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     /* find the first addrinfo with corre=
ct ai_family */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct addrinfo *cur;</span><br><span>     for (cur =3D local; cur; c=
ur =3D cur-&gt;ai_next)</span><br><span>     {</span><br><span>         if =
(cur-&gt;ai_family =3D=3D ai_family)</span><br><span>@@ -1490,7 +1488,7 @@<=
/span><br><span>         /* Socket is always bound on the first matching ad=
dress,</span><br><span>          * For bound sockets with no remote addr th=
is is the element of</span><br><span>          * the list */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct addrinfo *cur;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct addri=
nfo *cur;</span><br><span>         for (cur =3D sock-&gt;info=2Elsa-&gt;bin=
d_local; cur; cur =3D cur-&gt;ai_next)</span><br><span>         {</span><br=
><span>             if (!ai_family || ai_family =3D=3D cur-&gt;ai_family)</=
span><br><span>@@ -1621,7 +1619,7 @@</span><br><span> create_socket_dco_win=
(struct context *c, struct link_socket *sock, struct signal_info *sig_info)=
</span><br><span> {</span><br><span>     /* in P2P mode we must have remote=
 resolved at this point */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct addrinfo *remoteaddr =3D sock-&gt;info=2Elsa-&gt;current_re=
mote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct addrinfo *remoteaddr =3D sock-&gt;info=2Elsa-&gt;current_remote;</span><=
br><span>     if ((c-&gt;options=2Emode =3D=3D MODE_POINT_TO_POINT) &amp;&a=
mp; (!remoteaddr))</span><br><span>     {</span><br><span>         return;<=
/span><br><span>@@ -1910,7 +1908,7 @@</span><br><span>                     =
          const struct link_socket_actual *from_addr)</span><br><span> {</s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *ai;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct addrinfo *ai;</span><=
br><span> </span><br><span>     switch (from_addr-&gt;dest=2Eaddr=2Esa=2Esa=
_family)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/so=
cket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 1a532e1=2E=2E89465b=
c 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b=
/src/openvpn/socket=2Eh</span><br><span>@@ -761,7 +761,7 @@</span><br><span=
> {</span><br><span>     if (sock &amp;&amp; ipbuf)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct openvpn=
_iphdr *iph =3D (struct openvpn_iphdr *)BPTR(ipbuf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn_iphdr *iph =
=3D (struct openvpn_iphdr *)BPTR(ipbuf);</span><br><span>         sock-&gt;=
ptos =3D iph-&gt;tos;</span><br><span>         sock-&gt;ptos_defined =3D tr=
ue;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec</span><br><span>index d5bd602=2E=2E5f5d1f9 100644</s=
pan><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/s=
sl=2Ec</span><br><span>@@ -1488,7 +1488,7 @@</span><br><span> static bool</=
span><br><span> generate_key_expansion(struct tls_multi *multi, struct key_=
state *ks, struct tls_session *session)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct key_ctx_bi *key =3D &amp;ks=
-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_optio=
ns=2Ekey_ctx_bi;</span><br><span>     bool ret =3D false;</span><br><span> =
    struct key2 key2;</span><br><span> </span><br><span>@@ -1750,7 +1750,7 =
@@</span><br><span> static void</span><br><span> flush_payload_buffer(struc=
t key_state *ks)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct buffer *b;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const struct buffer *b;</span><br><span> </span><br><sp=
an>     while ((b =3D buffer_list_peek(ks-&gt;paybuf)))</span><br><span>   =
  {</span><br><span>@@ -2779,7 +2779,7 @@</span><br><span>     /* Outgoing =
Ciphertext to reliable buffer */</span><br><span>     if (ks-&gt;state &gt;=
=3D S_START)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        struct buffer *buf =3D reliable_get_buf_output_sequen=
ced(ks-&gt;send_reliable);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const struct buffer *buf =3D reliable_get_buf_output_sequenc=
ed(ks-&gt;send_reliable);</span><br><span>         if (buf)</span><br><span=
>         {</span><br><span>             if (!write_outgoing_tls_ciphertext=
(session, continue_tls_process))</span><br><span>@@ -2848,7 +2848,7 @@</spa=
n><br><span>     {</span><br><span>         int opcode;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer *=
buf =3D reliable_send(ks-&gt;send_reliable, &amp;opcode);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const struct buffer *buf =3D =
reliable_send(ks-&gt;send_reliable, &amp;opcode);</span><br><span>         =
ASSERT(buf);</span><br><span>         struct buffer b =3D *buf;</span><br><=
span>         INCR_SENT;</span><br><span>@@ -3211,7 +3211,7 @@</span><br><s=
pan> static void</span><br><span> check_session_buf_not_used(struct buffer =
*to_link, struct tls_session *session)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&gt;da=
ta;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_=
t *dataptr =3D to_link-&gt;data;</span><br><span>     if (!dataptr)</span><=
br><span>     {</span><br><span>         return;</span><br><span>@@ -3233,7=
 +3233,7 @@</span><br><span> </span><br><span>     for (int i =3D 0; i &lt;=
 KS_SIZE; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct key_state *ks =3D &amp;session-&gt;key[i];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct =
key_state *ks =3D &amp;session-&gt;key[i];</span><br><span>         if (ks-=
&gt;state =3D=3D S_UNDEF)</span><br><span>         {</span><br><span>      =
       continue;</span><br><span>@@ -3304,7 +3304,7 @@</span><br><span>    =
 {</span><br><span>         struct tls_session *session =3D &amp;multi-&gt;=
session[i];</span><br><span>         struct key_state *ks =3D &amp;session-=
&gt;key[KS_PRIMARY];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       struct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct k=
ey_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK];</span><br><span> =
</span><br><span>         /* set initial remote address=2E This triggers co=
nnecting with that</span><br><span>          * session=2E So we only do tha=
t if the TM_ACTIVE session is not</span><br><span>@@ -3505,7 +3505,7 @@</sp=
an><br><span> </span><br><span>     for (int i =3D 0; i &lt; KEY_SCAN_SIZE;=
 ++i)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        struct key_state *ks =3D get_key_scan(multi, i);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const struct key_state =
*ks =3D get_key_scan(multi, i);</span><br><span>         if (ks-&gt;key_id =
!=3D key_id)</span><br><span>         {</span><br><span>             contin=
ue;</span><br><span>@@ -4070,7 +4070,7 @@</span><br><span> void</span><br><=
span> tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *b=
uf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct key_state *ks =3D multi-&gt;save_ks;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct key_state *ks =3D multi-&gt;s=
ave_ks;</span><br><span> </span><br><span>     msg(D_TLS_DEBUG, __func__);<=
/span><br><span> </span><br><span>@@ -4084,7 +4084,7 @@</span><br><span> vo=
id</span><br><span> tls_prepend_opcode_v2(const struct tls_multi *multi, st=
ruct buffer *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct key_state *ks =3D multi-&gt;save_ks;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct key_state *ks =
=3D multi-&gt;save_ks;</span><br><span>     uint32_t peer;</span><br><span>=
 </span><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><span>diff --g=
it a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><s=
pan>index 6d7ac04=2E=2Efaf5a27 100644</span><br><span>--- a/src/openvpn/ssl=
_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><s=
pan>@@ -730,7 +730,7 @@</span><br><span> static inline size_t</span><br><sp=
an> external_key_len(void *vctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct external_context *const ctx =3D =
vctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct external_context *const ctx =3D vctx;</span><br><span> </span><br><span>=
     return ctx-&gt;signature_length;</span><br><span> }</span><br><span>di=
ff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><b=
r><span>index 162f68f=2E=2E063fa5d 100644</span><br><span>--- a/src/openvpn=
/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br>=
<span>@@ -409,7 +409,7 @@</span><br><span>                     const char *=
subject, const struct x509_track *x509_track)</span><br><span> {</span><br>=
<span>     char envname[64];</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    char *serial =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *serial =3D NULL;</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     /* Save X5=
09 fields in environment */</span><br><span>@@ -699,7 +699,7 @@</span><br><=
span>                 goto cleanup;</span><br><span>         }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct v=
erify_hash_list *current_hash =3D opt-&gt;verify_hash;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const struct verify_hash_list *c=
urrent_hash =3D opt-&gt;verify_hash;</span><br><span> </span><br><span>    =
     while (current_hash)</span><br><span>         {</span><br><span>@@ -15=
32,7 +1532,7 @@</span><br><span> verify_user_pass_management(struct tls_ses=
sion *session, const struct user_pass *up)</span><br><span> {</span><br><sp=
an>     int retval =3D KMDA_ERROR;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];=
 /* primary key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* prim=
ary key */</span><br><span> </span><br><span>     /* set username/password =
in private env space */</span><br><span>     setenv_str(session-&gt;opt-&gt=
;es, &quot;password&quot;, up-&gt;password);</span><br><span>diff --git a/s=
rc/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index f2a4394=2E=
=2Eaf48921 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span=
>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -871,7 +871,7 @@</span><br><s=
pan>          */</span><br><span>         if (strict_warn)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 struct addrinfo *curele;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            const struct addrinfo *curele;</span><br><span>          =
   ifconfig_sanity_check(tun_p2p, tt-&gt;remote_netmask);</span><br><span> =
</span><br><span>             /*</span><br><span>@@ -1726,7 +1726,7 @@</spa=
n><br><span>     {</span><br><span>         u_int32_t type;</span><br><span=
>         struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct ip *iph =3D (struct ip *)buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct ip *iph =3D (struct =
ip *)buf;</span><br><span> </span><br><span>         if (iph-&gt;ip_v =3D=
=3D 6)</span><br><span>         {</span><br><span>@@ -3414,7 +3414,7 @@</sp=
an><br><span>         SP_DEVINFO_DATA device_info_data;</span><br><span>   =
      BOOL res;</span><br><span>         HKEY dev_key;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        char net_cfg_instance_id_string[] =
=3D &quot;NetCfgInstanceId&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const char net_cfg_instance_id_string[] =3D &quot;Net=
CfgInstanceId&quot;;</span><br><span>         BYTE net_cfg_instance_id[256]=
;</span><br><span>         char device_instance_id[256];</span><br><span>  =
       DWORD len;</span><br><span>@@ -3542,7 +3542,7 @@</span><br><span>   =
      HKEY unit_key;</span><br><span>         char component_id_string[] =
=3D &quot;ComponentId&quot;;</span><br><span>         char component_id[256=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char net_cf=
g_instance_id_string[] =3D &quot;NetCfgInstanceId&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const char net_cfg_instance_id=
_string[] =3D &quot;NetCfgInstanceId&quot;;</span><br><span>         BYTE n=
et_cfg_instance_id[256];</span><br><span>         DWORD data_type;</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/=
win32=2Ec</span><br><span>index ca08ead=2E=2E44b010d 100644</span><br><span=
>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</s=
pan><br><span>@@ -889,7 +889,7 @@</span><br><span> </span><br><span>     if=
 (es)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        struct env_item *e;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct env_item *e;</span><br><span>         c=
har *ret;</span><br><span>         char *p;</span><br><span>         size_t=
 nchars =3D 1;</span><br><span>diff --git a/src/openvpnmsica/msica_arg=2Ec =
b/src/openvpnmsica/msica_arg=2Ec</span><br><span>index a334710=2E=2Ed763d93=
 100644</span><br><span>--- a/src/openvpnmsica/msica_arg=2Ec</span><br><spa=
n>+++ b/src/openvpnmsica/msica_arg=2Ec</span><br><span>@@ -92,7 +92,7 @@</s=
pan><br><span> {</span><br><span>     /* Count required space=2E */</span><=
br><span>     size_t size =3D 2 /*x + zero-terminator*/;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    for (struct msica_arg *p =3D seq-&gt=
;head; p !=3D NULL; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (const struct msica_arg *p =3D seq-&gt;head; p !=
=3D NULL; p =3D p-&gt;next)</span><br><span>     {</span><br><span>        =
 size +=3D wcslen(p-&gt;val) + 1 /*space delimiter|zero-terminator*/;</span=
><br><span>     }</span><br><span>@@ -119,7 +119,7 @@</span><br><span> </sp=
an><br><span>     /* Join=2E */</span><br><span>     LPWSTR s =3D str + 1 /=
*x*/;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (struct =
msica_arg *p =3D seq-&gt;head; p !=3D NULL; p =3D p-&gt;next)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (const struct msica_arg *=
p =3D seq-&gt;head; p !=3D NULL; p =3D p-&gt;next)</span><br><span>     {</=
span><br><span>         /* Convert zero-terminator into space delimiter=2E =
*/</span><br><span>         s[0] =3D L&#39; &#39;;</span><br><span>diff --g=
it a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec<=
/span><br><span>index 9d12963=2E=2E3911006 100644</span><br><span>--- a/src=
/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openv=
pnmsica=2Ec</span><br><span>@@ -196,7 +196,7 @@</span><br><span> </span><br=
><span>     /* Count adapters=2E */</span><br><span>     size_t adapter_cou=
nt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (str=
uct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; pAdapter =3D pAd=
apter-&gt;pNext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (const struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; p=
Adapter =3D pAdapter-&gt;pNext)</span><br><span>     {</span><br><span>    =
     adapter_count++;</span><br><span>     }</span><br><span>diff --git a/s=
rc/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br>=
<span>index 32c1b9c=2E=2Ea9e9665 100644</span><br><span>--- a/src/openvpnse=
rv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</s=
pan><br><span>@@ -2685,7 +2685,7 @@</span><br><span>     unsigned n =3D 0;<=
/span><br><span>     for (size_t i =3D 0; i &lt; _countof(data); ++i)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    nrpt_exclude_data_t *d =3D &amp;data[i];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const nrpt_exclude_data_t *d =3D &amp;data=
[i];</span><br><span>         if (d-&gt;domains_size =3D=3D 0)</span><br><s=
pan>         {</span><br><span>             break;</span><br><span>diff --g=
it a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec<=
/span><br><span>index 3b7bcc2=2E=2E948b6af 100644</span><br><span>--- a/src=
/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/a=
uth-pam=2Ec</span><br><span>@@ -526,7 +526,7 @@</span><br><span> openvpn_pl=
ugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char *ar=
gv[],</span><br><span>                        const char *envp[])</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct a=
uth_pam_context *context =3D (struct auth_pam_context *)handle;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct auth_pam_conte=
xt *context =3D (struct auth_pam_context *)handle;</span><br><span> </span>=
<br><span>     if (type =3D=3D OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY &amp;&a=
mp; context-&gt;foreground_fd &gt;=3D 0)</span><br><span>     {</span><br><=
span>diff --git a/src/tapctl/main=2Ec b/src/tapctl/main=2Ec</span><br><span=
>index 6a4a240=2E=2E6697d14 100644</span><br><span>--- a/src/tapctl/main=2E=
c</span><br><span>+++ b/src/tapctl/main=2Ec</span><br><span>@@ -317,7 +317,=
7 @@</span><br><span>             return NULL;</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct tap_adapter_node *conflict =3D find_adapter_by_name(requested_nam=
e, adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const struct tap_adapter_node *conflict =3D find_adapter_by_name(requ=
ested_name, adapter_list);</span><br><span>         if (conflict)</span><br=
><span>         {</span><br><span>             LPOLESTR adapter_id =3D NULL=
;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/t=
ests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index 326de40=2E=2E=
ce38bbe 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><=
br><span>@@ -88,7 +88,7 @@</span><br><span> </span><br><span>     int maxou=
tput =3D 0;</span><br><span>     unsigned int blocksize =3D 5;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    char *separator =3D &quot; &qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*separator =3D &quot; &quot;;</span><br><span>     output =3D format_hex_ex=
(input, input_size, maxoutput, blocksize, separator, &amp;gc);</span><br><s=
pan>     assert_string_equal(output, &quot;0100ff10ff 00f00f090a&quot;);</s=
pan><br><span> </span><br><span>@@ -174,7 +174,7 @@</span><br><span>     /*=
 With a max length of 2, no aggregation should take place */</span><br><spa=
n>     buffer_list_aggregate_separator(ctx-&gt;one_two_three, 2, testsep);<=
/span><br><span>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 3);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =
=3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(=
ctx-&gt;one_two_three);</span><br><span>     assert_buf_equals_str(buf, tes=
tstr1);</span><br><span> }</span><br><span> </span><br><span>@@ -189,7 +189=
,7 @@</span><br><span>      */</span><br><span>     buffer_list_aggregate_s=
eparator(ctx-&gt;one_two_three, strlen(expected) + 1, testsep);</span><br><=
span>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 2);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_=
list_peek(ctx-&gt;one_two_three);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(ctx-&gt;one=
_two_three);</span><br><span>     assert_buf_equals_str(buf, expected);</sp=
an><br><span> }</span><br><span> </span><br><span>@@ -201,7 +201,7 @@</span=
><br><span>     /* Aggregate all */</span><br><span>     buffer_list_aggreg=
ate_separator(ctx-&gt;one_two_three, 1 &lt;&lt; 16, testsep);</span><br><sp=
an>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 1);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_li=
st_peek(ctx-&gt;one_two_three);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_t=
wo_three);</span><br><span>     assert_buf_equals_str(buf, teststr1 testsep=
 teststr2 testsep teststr3 testsep);</span><br><span> }</span><br><span> </=
span><br><span>@@ -213,7 +213,7 @@</span><br><span>     /* Aggregate all */=
</span><br><span>     buffer_list_aggregate_separator(ctx-&gt;one_two_three=
, 1 &lt;&lt; 16, testnosep);</span><br><span>     assert_int_equal(ctx-&gt;=
one_two_three-&gt;size, 1);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_three);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buff=
er *buf =3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><span>     a=
ssert_buf_equals_str(buf, teststr1 teststr2 teststr3);</span><br><span> }</=
span><br><span> </span><br><span>@@ -226,7 +226,7 @@</span><br><span>     /=
* Aggregate all */</span><br><span>     buffer_list_aggregate_separator(bl_=
zerolen, 1 &lt;&lt; 16, testnosep);</span><br><span>     assert_int_equal(b=
l_zerolen-&gt;size, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct buffer *buf =3D buffer_list_peek(bl_zerolen);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buf=
fer_list_peek(bl_zerolen);</span><br><span>     assert_buf_equals_str(buf, =
&quot;&quot;);</span><br><span> }</span><br><span> </span><br><span>@@ -239=
,7 +239,7 @@</span><br><span>     /* Aggregate all */</span><br><span>     =
buffer_list_aggregate_separator(bl_emptybuffers, 1 &lt;&lt; 16, testnosep);=
</span><br><span>     assert_int_equal(bl_emptybuffers-&gt;size, 1);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D b=
uffer_list_peek(bl_emptybuffers);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(bl_emptybuf=
fers);</span><br><span>     assert_int_equal(BLEN(buf), 0);</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span=
>index 77cf295=2E=2E07c54b4 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
crypto=2Ec</span><br><span>@@ -482,9 +482,9 @@</span><br><span> crypto_test=
_hkdf_expand_testa1(void **state)</span><br><span> {</span><br><span>     /=
* RFC 5889 A=2E1 Test Case 1 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x3=
2, 0xdf, 0x0d, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7=
, 0x3b, 0xb5, 0x0f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3,=
 0xe5 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, =
0xdc, 0x3f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                      0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b,=
 0xb5, 0x0f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                       0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3=
, 0xe5 };</span><br><span> </span><br><span>     uint8_t info[10] =3D { 0xf=
0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };</span><br><span>=
 </span><br><span>@@ -503,9 +503,9 @@</span><br><span> crypto_test_hkdf_exp=
and_testa2(void **state)</span><br><span> {</span><br><span>     /* RFC 588=
9 A=2E2 Test Case 2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint8_t prk[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, =
0x06, 0x10, 0x4c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0=
x90, 0x46,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t pr=
k[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4=
c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
             0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x=
46,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
              0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };=
</span><br><span> </span><br><span>     uint8_t info[80] =3D { 0xb0, 0xb1, =
0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb,</span><br><span=
>                          0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, =
0xc4, 0xc5, 0xc6, 0xc7,</span><br><span>@@ -534,11 +534,11 @@</span><br><sp=
an> crypto_test_hkdf_expand_testa3(void **state)</span><br><span> {</span><=
br><span>     /* RFC 5889 A=2E3 Test Case 3 */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, =
0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa9,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0=
x96, 0x59, 0x67, 0x76, 0xaf, 0xdb,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x=
29, 0x3c, 0xcb, 0x04 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7=
b, 0x16, 0x7f, 0x33, 0xa9,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                              0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x=
59, 0x67, 0x76, 0xaf, 0xdb,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                              0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0=
x29, 0x3c, 0xcb, 0x04 };</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint8_t info[] =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint8_t info[] =3D { 0 };</span><b=
r><span> </span><br><span>     int L =3D 42;</span><br><span>     uint8_t o=
km[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x=
80,</span><br><span>@@ -558,9 +558,9 @@</span><br><span>     /* tests the H=
DKF with a label/okm that OpenVPN itself uses in OpenSSL 3</span><br><span>=
      * HDKF unit test*/</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c=
, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90,=
 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, =
0xc2, 0xb3, 0xe5 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0=
xdf, 0x0d, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, =
0xc7, 0x3b, 0xb5, 0x0f,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7,=
 0xc2, 0xb3, 0xe5 };</span><br><span> </span><br><span>     uint8_t info[18=
] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,</span><br><sp=
an>                          0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74=
, 0x00 };</span><br><span>@@ -680,7 +680,7 @@</span><br><span> static int</=
span><br><span> crypto_test_epoch_setup(void **state)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint16_t *num_future=
_keys =3D (uint16_t *)*state;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint16_t *num_future_keys =3D (uint16_t *)*state;</span=
><br><span>     struct epoch_test_state *data =3D calloc(1, sizeof(struct e=
poch_test_state));</span><br><span> </span><br><span>     data-&gt;gc =3D g=
c_new();</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoa=
pi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span>index =
508afc9=2E=2E37bbe92 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_cryptoapi=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryp=
toapi=2Ec</span><br><span>@@ -233,7 +233,7 @@</span><br><span>         cons=
t CERT_CONTEXT *ctx =3D NULL;</span><br><span>         while ((ctx =3D Cert=
EnumCertificatesInStore(user_store, ctx)))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *friendly_=
name =3D get_cert_name(ctx, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            const char *friendly_name =3D get_cert_name(c=
tx, &amp;gc);</span><br><span>             if (!lookup_cert(friendly_name))=
 /* not our cert */</span><br><span>             {</span><br><span>        =
         continue;</span><br><span>@@ -310,7 +310,7 @@</span><br><span>    =
      */</span><br><span>         assert_non_null(ctx);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *friendly_=
name =3D get_cert_name(ctx, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const char *friendly_name =3D get_cert_name(ctx, =
&amp;gc);</span><br><span>         struct test_cert *found =3D lookup_cert(=
friendly_name);</span><br><span>         assert_non_null(found);</span><br>=
<span>         assert_string_equal(found-&gt;cname, c-&gt;cname);</span><br=
><span>@@ -343,7 +343,7 @@</span><br><span>          */</span><br><span>   =
      assert_non_null(ctx);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        char *friendly_name =3D get_cert_name(ctx, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char *friendly_name =3D get_cert_name(ctx, &amp;gc);</span><br><span>  =
       struct test_cert *found =3D lookup_cert(friendly_name);</span><br><s=
pan>         assert_non_null(found);</span><br><span>         assert_string=
_equal(found-&gt;issuer, c-&gt;issuer);</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</=
span><br><span>index 5f03860=2E=2Ea41c27b 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec</span><br><span>@@ -300,7 +300,7 @@</span><br><span>  =
   {</span><br><span>         for (ptr_type i =3D 1; i &lt;=3D 16; ++i)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            struct hash_element *item =3D hash_lookup_by_value(nhash, (vo=
id *)i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 const struct hash_element *item =3D hash_lookup_by_value(nhash, (void *)i)=
;</span><br><span>             hash_remove_by_value(nhash, (void *)i);</spa=
n><br><span>             /* check item got removed if it was present before=
 */</span><br><span>             if (item)</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec<=
/span><br><span>index d6b63d0=2E=2E887c492 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_ssl=2Ec</span><br><span>@@ -676,7 +676,7 @@</span><br><span>   =
  openvpn_encrypt(&amp;buf, encrypt_workspace, &amp;co);</span><br><span> <=
/span><br><span>     /* separate buffer in authenticated data and encrypted=
 data */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *=
ad_start =3D BPTR(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const uint8_t *ad_start =3D BPTR(&amp;buf);</span><br><span>  =
   buf_advance(&amp;buf, 4);</span><br><span> </span><br><span>     if (epo=
ch)</span><br><span>diff --git a/tests/unit_tests/plugins/auth-pam/test_sea=
rch_and_replace=2Ec b/tests/unit_tests/plugins/auth-pam/test_search_and_rep=
lace=2Ec</span><br><span>index a861bfd=2E=2E89f0642 100644</span><br><span>=
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec</span><=
br><span>+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace=2E=
c</span><br><span>@@ -12,7 +12,7 @@</span><br><span> static void</span><br>=
<span> pass_any_null_param__returns_null(void **state)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char DUMMY[] =3D &q=
uot;DUMMY&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char DUMMY[] =3D &quot;DUMMY&quot;;</span><br><span> </span><br><spa=
n>     assert_null(searchandreplace(NULL, DUMMY, DUMMY));</span><br><span> =
    assert_null(searchandreplace(DUMMY, NULL, DUMMY));</span><br><span>@@ -=
22,8 +22,8 @@</span><br><span> static void</span><br><span> pass_any_empty_=
string__returns_null(void **state)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char DUMMY[] =3D &quot;DUMMY&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    char EMPTY[] =3D &quo=
t;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char DUMMY[] =3D &quot;DUMMY&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char EMPTY[] =3D &quot;&quot;;</span><br><span> <=
/span><br><span>     assert_null(searchandreplace(EMPTY, DUMMY, DUMMY));</s=
pan><br><span>     assert_null(searchandreplace(DUMMY, EMPTY, DUMMY));</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1661?usp=3Demail">change 1661</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2b71dae37ebe63c26=
a66761f877b25d326ed140f </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1661 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
=
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--gp0IHTYZo0U=--


--===============5199422005839026149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5199422005839026149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5199422005839026149==--

