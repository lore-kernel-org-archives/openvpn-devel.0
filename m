Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C7606A338
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Zn5CJ+5z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WKvTbzCS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YRMQhv4G;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bg5dUCWc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q69PMW+ujM/4cQ8Dn+s0pVpPf/Ne/qfhO3Bgh1mIQas=; b=Zn5CJ+5zUfIVtdy3wBmlbInkRs
	fvlqoHPUfCnLXJRmpvTjTRJLaG11CFcOO8EJodRHYnpwbaTgucUZ+B+WThOWAAuY4DePpg9Zw+Cab
	Z/zXWpEyARkdnJihkneXiqdvjLgp7owmUhfnFe4aZ5QLsJfRikuS9FKcZFmZ/xzz2gAw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXhK-000000002Us-15c1;
	Thu, 26 Nov 2026 11:31:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXhI-000000002Ul-0ksU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OCu5nEMVvgyvtHju6AZRHXjTMiQk9E+eEm/i5lwbQrA=; b=WKvTbzCS8ae7jflPCX16A3YQ0z
 86sG+0za9SvvzbXIaDZoTZiRRuTySNJqcBmmHJyFtBAr5+OKuCbc8AcFM9WsnjMSDyMzzQlVp2zXZ
 evFtKiCySDn0krvjLk0+6XzKd0ZLKApjOYnKS1AfHVWMrzySLbzla10ZLq7jwZY/UOA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OCu5nEMVvgyvtHju6AZRHXjTMiQk9E+eEm/i5lwbQrA=; b=YRMQhv4G0IT1HZOAJovj0eWRXx
 nr82ZwxiMJ9LcH/ltja9SU8r2IIvdMfXt6eo7Y5/QDxtWB6eqlm89N9HA63h+0cD1VQr231gsMZ5i
 lXBxllL7YwphXGTwyaG7A97ROEjDKVbqiwpIrOjp//lngr3c9KtJglZxDt5GvuzKpmYQ=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXhG-000000000To-2e0z for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:31:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so60985435e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795692680; x=1796297480; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OCu5nEMVvgyvtHju6AZRHXjTMiQk9E+eEm/i5lwbQrA=;
 b=Bg5dUCWc/zWp6wWyHUFYEl5HXdj8VfgE4ZkOE692sbLH/XDxeX+6rMDHrg4YI1kxRO
 POeCfwOQuhqKIbyAF3kEHWCzMIMXi7mSMLR8eTuxgK63GQiuyArlnHPmyHayqb72BXDf
 v0vfvI1jqlrhkWwZXKNHPP7VyEs5G/eaTHippbamb7tfPApr8tZ7yZiE8n/fx6iOTfG4
 5ECCngA9Nz+rYJmp+UDKvFVN0gTgg6UAoCocAGAJhp7OaZYAy/lcYI82yHFAwYQcduCq
 DtMr8h0aaTuDPXMzclbF0O83sr5Bpb0l4Knm43EgtGOW8KDxBENTmKcsiHcXq8QccqtF
 jB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795692680; x=1796297480;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OCu5nEMVvgyvtHju6AZRHXjTMiQk9E+eEm/i5lwbQrA=;
 b=mZ1t7HnQdgChOlcTU/47bzMeZ2yVFCDmMEfaXKVk/kieJJxj0rDy5PSUgDN5+JBOmA
 Ck6yAHcMEd/1jGGjKkQtu1Jrsgnv1rOHYq/4le6KxV5wsi1JbnSfDBETsQln/piCVUkn
 aUb8klWe14tjK8z7Ep0UkYnVY6Dq2gobW9+VRI/Gqgm6LrEehJZjPfXgZ94b2ILHHfdi
 a1uZXBYoz4OcWFrT8GkhKD+DuarIagWaR4H17jlWSAoPdDi20MEkAkIlVVFFq6u9w2Fb
 gsuuitk9daFJ9oGBeoxuL75HxioA/Z6gg5JJGbMBXvJLeLwfgWJYtawSDsRrtCGTvyE0
 i4nA==
X-Forwarded-Encrypted: i=1;
 AL+hErGAIv69SPKMB5mqR52GdXFSlHbOj3xGCIW4q9VGtY8FGeY5VnrCLrk5Ps1/3Y19bELSIBpfSO0wCDt0+1i2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/EotbSbACtgyHxNZshSODYCD5hkT1YoOfiN32YiBE351xrLZWW
 k/z9JZxTji1SY4LHGWw4H9xN+55Lmlc80Md13OFQ5hXkNUusL59SmZNbASsVtiLzQmWf830aQgy
 /EHXOmosw3JeHFNN+yCjDyAFQYMXnwO9WMLwK54W2bbtXQV3ikSiOPBkr6ZhfBDCoP0U0mmXxkW
 4hAhlvGw==
X-Gm-Gg: AZFdTZfkmZi2jQVvhVAS3v10KzxQMaHph6lTy1cB2qfWJ4MmGQrVwLnE5WwJ5+GEhUp
 wNav69k/Td4+AXatLSBoBs8sRtxiiFWPuIciy3dy+l8su4Tmpcb6U34twOA7mrTMShDTnI8iH/v
 856KKWowfJQZAg2lbr5rwTDDT6FcnCM3VGOJyZc7YOZvSwjIasV49PZM7sd+ZUHN8qIHx3Zov8N
 bTvBKCIKu5g9JHY5VbrJD4b3FjPSpppIYnuUlDRAX7Bv8EMhOD/+/AWoy6KvG1k+I4QaTWmxqsC
 d4lLpqqK+BSKQA7JIgbtwUAzIliFyDwrBJlfNuN0VtD8zacuYpSWPvV09yPBHHwOpVfEsSNfTM+
 yPPjb6HWPL7eT4ZwQWM4cJ7CW/zYbTU8srZK4HEzSYzaBG4qVfgINmKI4hKZvSQKFzRxDqVEYYY
 +OXoTfgS+LnmHWX3DTaVesjZmsTyBOolZhYmqC1j7W/gTIIvu71d/27kYjjdxcnN+oHvtisY7kQ
 s6ChqJSbwToo26RwPa4wwWjjLe5KqJ3Uxb0jW0dv/mkt+K/ZCrml+lQXWDmePnkdg1SzCuP7pz0
 ZsnpzE2dyAmDTenKfJWgDKhm2bBq8tht7YIl6pHnG5zNN6PmZ+XaNwLUPhhSbtqSy16HAhN1IHI
 aHx11/sOEe2s4zo1j02hCfk0wJHFwf/ybFUwJUVoSSoXbAwRgv1+FFF8AYxp+sLc8ai5UjJvYT+
 5rW8jgEl8F30CStv4=
X-Received: by 2002:a05:600c:3b0e:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4bb8882508emr443568205e9.35.1795692679111; 
 Thu, 26 Nov 2026 03:31:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bbab390cf5sm74226575e9.7.2026.11.26.03.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:31:18 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:31:18 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
X-Gerrit-Change-Number: 2343
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2343?usp=email>
X-Gerrit-Commit: c485c4e1ed95d790c2b9e3e4adf1068703e64ea4
In-Reply-To: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
References: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjEzOTAzMDAwLkk4ZDA4MWM4N2FmMGQ3NDZhNWUzYTIzODI1NjdmMDQzMzI2Mzk2MjJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75f78f021d691ea4110324b88f0fe2c13c1d55f8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWXhG-000000000To-2e0z
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7981247983519362359=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7981247983519362359==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qE+4+Q1RrUo="; charset=UTF-8

--qE+4+Q1RrUo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2343?usp=3Demail )

Change subject: cppcheck: Add more printf-s=
tyle functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


cppcheck: Add more printf-style functions

Also fix the two issues raised=
 by this=2E

Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2343
Message-Id: <20261125151936=2E10270-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg41936=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M dev-tools/openvpn-cppcheck-library=2Ecfg
M dev-tools/openvpn-cppcheck-win=
dows=2Ecfg
M src/openvpn/networking_iproute2=2Ec
M src/openvpnserv/interact=
ive=2Ec
4 files changed, 14 insertions(+), 2 deletions(-)




diff --git a/=
dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-libra=
ry=2Ecfg
index 0537b39=2E=2E37195d8 100644
--- a/dev-tools/openvpn-cppcheck=
-library=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg
@@ -6,6 +6,12=
 @@
       <formatstr />
     </arg>
   </function>
+  <function name=3D"ar=
gv_printf">
+    <formatstr type=3D"printf"/>
+    <arg nr=3D"2">
+      <f=
ormatstr />
+    </arg>
+  </function>
   <function name=3D"buf_printf">
  =
   <formatstr type=3D"printf"/>
     <arg nr=3D"2">
diff --git a/dev-tools/=
openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-windows=2Ecfg
i=
ndex 932d586=2E=2Edca2b07 100644
--- a/dev-tools/openvpn-cppcheck-windows=
=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg
@@ -2,6 +2,12 @@
 <!-=
- Only used for the Windows run=2E Can't be in openvpn-cppcheck-library=2Ec=
fg
      because it conflicts with gnu=2Ecfg=2E -->
 <def>
+  <function nam=
e=3D"MsgToEventLog">
+    <formatstr type=3D"printf"/>
+    <arg nr=3D"2">
=
+      <formatstr />
+    </arg>
+  </function>
   <!-- MinGW uses GCC, so =
we need to handle GCC builtins=2E gnu=2Ecfg has these,
        but we do no=
t load it for Windows=2E Without this cppcheck does not
        understand =
our likely()/unlikely() macros=2E -->
diff --git a/src/openvpn/networking_i=
proute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index 6c4c8f4=2E=2Eb07975=
7 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/openvpn/networ=
king_iproute2=2Ec
@@ -112,7 +112,7 @@
 {
     struct argv argv =3D argv_new=
();
 
-    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path,=
 iface, mtu);
+    argv_printf(&argv, "%s link set dev %s up mtu %u", iprou=
te_path, iface, mtu);
     argv_msg(M_INFO, &argv);
     openvpn_execve_che=
ck(&argv, ctx->es, S_FATAL, "Linux ip link set failed");
 
diff --git a/src=
/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index bddaf8=
6=2E=2E77b91e0 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openv=
pnserv/interactive=2Ec
@@ -459,7 +459,7 @@
     size =3D bytes / sizeof(*da=
ta);
     if ((size =3D=3D 0) || (size > 4096)) /* our startup data is 1024=
 wchars at the moment */
     {
-        MsgToEventLog(M_SYSERR, L"malforme=
d startup data: %lu bytes received", size);
+        MsgToEventLog(M_SYSERR=
, L"malformed startup data: %zu bytes received", size);
         ReturnErro=
r(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
         go=
to err;
     }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2343?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: m=
erged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8d08=
1c87af0d746a5e3a2382567f04332639622a
Gerrit-Change-Number: 2343
Gerrit-Patc=
hSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--qE+4+Q1RrUo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2343?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">cppcheck: Add more printf-style fu=
nctions<br><br>Also fix the two issues raised by this=2E<br><br>Change-Id: =
I8d081c87af0d746a5e3a2382567f04332639622a<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2343<br>Message-Id: &lt;20261125151936=2E10270-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41936=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M d=
ev-tools/openvpn-cppcheck-windows=2Ecfg<br>M src/openvpn/networking_iproute=
2=2Ec<br>M src/openvpnserv/interactive=2Ec<br>4 files changed, 14 insertion=
s(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/openvpn-cppche=
ck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span=
>index 0537b39=2E=2E37195d8 100644</span><br><span>--- a/dev-tools/openvpn-=
cppcheck-library=2Ecfg</span><br><span>+++ b/dev-tools/openvpn-cppcheck-lib=
rary=2Ecfg</span><br><span>@@ -6,6 +6,12 @@</span><br><span>       &lt;form=
atstr /&gt;</span><br><span>     &lt;/arg&gt;</span><br><span>   &lt;/funct=
ion&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;functi=
on name=3D&quot;argv_printf&quot;&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &lt;formatstr type=3D&quot;printf&quot;/&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;arg nr=3D&quot;2&quo=
t;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      &lt;for=
matstr /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;/arg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/fun=
ction&gt;</span><br><span>   &lt;function name=3D&quot;buf_printf&quot;&gt;=
</span><br><span>     &lt;formatstr type=3D&quot;printf&quot;/&gt;</span><b=
r><span>     &lt;arg nr=3D&quot;2&quot;&gt;</span><br><span>diff --git a/de=
v-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-windows=
=2Ecfg</span><br><span>index 932d586=2E=2Edca2b07 100644</span><br><span>--=
- a/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>+++ b/dev-tool=
s/openvpn-cppcheck-windows=2Ecfg</span><br><span>@@ -2,6 +2,12 @@</span><br=
><span> &lt;!-- Only used for the Windows run=2E Can&#39;t be in openvpn-cp=
pcheck-library=2Ecfg</span><br><span>      because it conflicts with gnu=2E=
cfg=2E --&gt;</span><br><span> &lt;def&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;function name=3D&quot;MsgToEventLog&quot;&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;formatstr ty=
pe=3D&quot;printf&quot;/&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;arg nr=3D&quot;2&quot;&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      &lt;formatstr /&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;/arg&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;/function&gt;</span><br><span>   &lt;!-- M=
inGW uses GCC, so we need to handle GCC builtins=2E gnu=2Ecfg has these,</s=
pan><br><span>        but we do not load it for Windows=2E Without this cpp=
check does not</span><br><span>        understand our likely()/unlikely() m=
acros=2E --&gt;</span><br><span>diff --git a/src/openvpn/networking_iproute=
2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>index 6c4c8f4=
=2E=2Eb079757 100644</span><br><span>--- a/src/openvpn/networking_iproute2=
=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br><s=
pan>@@ -112,7 +112,7 @@</span><br><span> {</span><br><span>     struct argv=
 argv =3D argv_new();</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s link set dev %s up mt=
u %d&quot;, iproute_path, iface, mtu);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s link set dev %s up m=
tu %u&quot;, iproute_path, iface, mtu);</span><br><span>     argv_msg(M_INF=
O, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;argv, ctx-&gt=
;es, S_FATAL, &quot;Linux ip link set failed&quot;);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec</span><br><span>index bddaf86=2E=2E77b91e0 100644</span><br=
><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/open=
vpnserv/interactive=2Ec</span><br><span>@@ -459,7 +459,7 @@</span><br><span=
>     size =3D bytes / sizeof(*data);</span><br><span>     if ((size =3D=3D=
 0) || (size &gt; 4096)) /* our startup data is 1024 wchars at the moment *=
/</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        MsgToEventLog(M_SYSERR, L&quot;malformed startup data: %lu bytes=
 received&quot;, size);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        MsgToEventLog(M_SYSERR, L&quot;malformed startup data: %zu byte=
s received&quot;, size);</span><br><span>         ReturnError(pipe, ERROR_S=
TARTUP_DATA, L&quot;GetStartupData&quot;, 1, &amp;exit_event);</span><br><s=
pan>         goto err;</span><br><span>     }</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail=
">change 2343</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
343?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I8d081c87af0d746a5e3a2382567f04332639622a </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2343 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--qE+4+Q1RrUo=--


--===============7981247983519362359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7981247983519362359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7981247983519362359==--

