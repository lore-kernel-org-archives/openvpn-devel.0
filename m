Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDFCC531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LclgEj+Luv+H2iie4M6DyrrabcBr5fRFqqJVr1UklDE=; b=dR8XoHuF0kDg7WexDF/rfvjLH4
	AE3v0oNZORfNlm6e5Jtn4S++r5Rlx23D2E89ry1mx+soZcwyMooIOb14HBDl/hjxvb3CK3MftmaLi
	cegqcuh39dbzJkGD2FlmrCfCOrJ5rxl27bQYKAixpNg6Sf42yL1cS8hOryaxUcWEdL5g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIzr-0007cQ-7l;
	Fri, 24 Jul 2026 16:43:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIzp-0007cC-Te
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:43:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=F4ZgZ0EikVWSkiYxcN7hMBjkDi9MFgU5V3YbdT0IkL8=; b=Bvm3LVDqmLRhhCT/8S+XOobal0
 69jPyWTypHP441cPa6MXCioAQtDYrsP0RQ+pRFZ11p9S4m7ZBmNsFT0egXvA8AWtBl0CFyufqFQz5
 t88MgUz09E3D65o0AfFZZjJcAUfZsW+XWAz+AQc9kj1C1hePmWEt6qdzPipah2LrORQE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F4ZgZ0EikVWSkiYxcN7hMBjkDi9MFgU5V3YbdT0IkL8=; b=m
 9kkgUClCLTYe1tjwth6z38bMNbDrN4M20LdCB7WeeJyoT37kEbS/U/DaA259i9Ps0dl2ec0AxKieq
 NFEIcXwZn1W1V+Nv8nxMLDTgDOc3SFN2F1ve3T2u3VwwPKWSTqL/XXD6F/dSjjXnVhZyMNxS3+l2K
 DeGGjZAwtCD8AYvo=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIzZ-0002ZO-I9 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:43:23 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so339026f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784911395; x=1785516195; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F4ZgZ0EikVWSkiYxcN7hMBjkDi9MFgU5V3YbdT0IkL8=;
 b=PZWz5ORgAPS26X/aFWLJLcyyxesfOUyftBNxwKkeRjZiVcuUy23oYLZ37m6G90spqI
 FH3xlxkHEy3b8bxEHDSHOQbIV4jTo+nzuMu/f2K708U/NkgCAo7BAWu0dUszKLygAkcW
 CkDiiORHtV6czryIT3yFGHQ3vCeBm1pQzL9SoRrBuJRBNqlvO0yslHRYifCu5cee4JVT
 hcGmq0INWLWBFf6LWUrRSf4C00YegNODehFqC+L+VIP464uoKto0VyHzU2Igziq2HR69
 E6Vaa1JrltC5poshGH9hoQhn0XpALAmKwEvCjZhIV2fiQ6Xl1rKQwVl/Cw0sjb0/DaDs
 T2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911395; x=1785516195;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F4ZgZ0EikVWSkiYxcN7hMBjkDi9MFgU5V3YbdT0IkL8=;
 b=DtLcbqQYGKo9eQLCb10cFd7TZUVkiAmfuzQ5K2oUubiUX5M+rUI9LsHQhZbQ+BZ4La
 DyulTphxy9sOsqWmxs/D0DP8rXOphhdIoLKG0mgQKbfXWvr4XR6zBcY5sepmumlMhO3e
 M3qZvp4ByJREIUZ5EoTFn7XmCnHHNNnixt8+i2L0+Zb3wyNesWpRTmltH0vtmczjqXTt
 P+7LKgBGtUZ54iqsh4FxmgyWuyc4k5fDnNT0URMKjdRTGWEEeu4jvcino3epUMSZFhXx
 c4ufNLZjjcmQlUpckqeDdXAdx1m9z3lURADxL5ggwDTpUIzJywuwhQjCT++DAPzWGJ/h
 HvBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou0BATk753XeUS7fePGm7ScFpMNJvIF+UwBGvgo87lX+mdcUkmJHgi4zavIQ/L0pVtQQRIcBm8hkTa6iRU@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzrur1ml9JXyvEEgGWb3PdedCsun9ezA+pmeKe10+mY80qrmWCQ
 q+FroEsyzrWpweGQ2Ud0CCpOdT8gv7DY8HmcbklEDnz9MtJ+MjDUB/CyyrONnfzrLvU2CBGCJV6
 ha0Q5eRnAGY5JV8ShtV/HoGV0tkHqbEclJNujzeG4vMxu6+NkxBEP4CL2a1t9Q4E2yfXr
X-Gm-Gg: AR+sD12/jhPjQ5q2wZhSqgqJwHVB/nDYdI07FZOUF2+f6ATSHv7IfMlz6wOUVL53lao
 6p/K+iK48yuMT93HK629ilcGPf2RvOukQk9oznbi3tXkwqYSdwbxM1psIavbCyPV30a44MuBbuH
 wkJi35Kx5mr9nYb330aOHpdN0Nh7qOG2d0zw6FQN2tiQvTIxYrNdOMqLGkIgpijYMKngt18APR0
 JiNLZ6Nxkj5JWU0ydKMQUYXK3HB21gGQELXyk25Ucduh6J50ySuCSKk1z3jLY7KbjkA5K2+8rru
 7k622k9htMK/kUGgryMWa6nei4Gw48jfJ+EWMTHkZ/NUCJhKzh7TBZbCVLwMFVa1GcIsyx5sL8x
 cJz7BtGqebJB30Fosj9eqwyBam/GwVp1miQxhEFgp4JmPmkO52t0IndLklHlWo9tX243eoUVDoL
 /Q93vDFT28QhRkVWAA//3jnBEXaCrKQiwoc20RvEcr+TuvXUAabvxD626ZvBH1C+tTE2NnpvGoF
 XYo7ahzpnOh432oslzu9LPrRuBvG3yjdoRkzTP2fZVXLFvmhbD8olAiol4tcfwBpTfT
X-Received: by 2002:a05:6000:2906:b0:47f:77dc:aaa2 with SMTP id
 ffacd0b85a97d-47f8dcae738mr9968307f8f.45.1784911394649; 
 Fri, 24 Jul 2026 09:43:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c631fdsm24744734f8f.28.2026.07.24.09.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:43:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:43:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
X-Gerrit-Change-Number: 1537
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1537?usp=email>
X-Gerrit-Commit: a6537f7549f70f16bb2efd5c0683e0e94a236f0c
In-Reply-To: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
References: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMjg0MjkxMDAwLkkwY2E3YjViN2VjMWEwMWFjYWFkMjIyYzk5ZGIxMzdjOTRjODg1NTVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2113d81598e7cd20225ee97a77686879773c9e76-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIzZ-0002ZO-I9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make 'tun'
 the default for '--dev'
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5762332649004708437=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5762332649004708437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5L2FPCFz/tc="; charset=UTF-8

--5L2FPCFz/tc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1537?usp=3Demail )

Change subject: options: make 'tun' the default for=
 '--dev'
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

opti=
ons: make 'tun' the default for '--dev'

With this change, OpenVPN can be l=
aunched without specifying
any --dev option and it will start a `tun` (L3) =
tunnel with the
interface named `tunX`=2E
As before, this behaviour can be =
changed using --dev or --dev-type=2E

Existing configs won't see any behavi=
oural change as they all
had to contain at least one --dev directive=2E

Ch=
ange-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
Signed-off-by: Antonio Q=
uartulli <antonio@mandelbit=2Ecom>
Acked-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537
M=
essage-Id: <20260724055529=2E1376-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37825=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man-se=
ctions/examples=2Erst
M doc/man-sections/vpn-network-options=2Erst
M sample=
/sample-config-files/client=2Econf
M sample/sample-config-files/server=2Eco=
nf
M src/openvpn/options=2Ec
5 files changed, 15 insertions(+), 1 deletion(=
-)




diff --git a/doc/man-sections/examples=2Erst b/doc/man-sections/exam=
ples=2Erst
index 80ef2df=2E=2E416e576 100644
--- a/doc/man-sections/example=
s=2Erst
+++ b/doc/man-sections/examples=2Erst
@@ -63,6 +63,10 @@
 Example 1=
: A simple tunnel without security (not recommended)
 ---------------------=
----------------------------------------
 
+Since :code:`tun` is the defaul=
t device type, ``--dev`` is optional; when it
+is omitted OpenVPN creates a=
 dynamically-named ``tunX`` device=2E The examples
+below still name the de=
vice (``--dev tun1``) explicitly for clarity=2E
+
 On bob::
 
    openvpn -=
-remote alice=2Eexample=2Ecom --dev tun1 \
diff --git a/doc/man-sections/vp=
n-network-options=2Erst b/doc/man-sections/vpn-network-options=2Erst
index =
33ebedb=2E=2E960c6ad 100644
--- a/doc/man-sections/vpn-network-options=2Ers=
t
+++ b/doc/man-sections/vpn-network-options=2Erst
@@ -50,6 +50,10 @@
   :c=
ode:`null` or an arbitrary name string (:code:`X` can be omitted for
   a d=
ynamic device=2E)
 
+  If neither ``--dev`` nor ``--dev-type`` is specified=
, OpenVPN defaults to
+  :code:`tun`, i=2Ee=2E it creates a dynamically-nam=
ed :code:`tunX` device and
+  runs a layer-3 tunnel=2E
+
   See examples se=
ction below for an example on setting up a TUN device=2E
 
   You must use =
either tun devices on both ends of the connection or tap
diff --git a/sampl=
e/sample-config-files/client=2Econf b/sample/sample-config-files/client=2Ec=
onf
index 53b8027=2E=2E1806b24 100644
--- a/sample/sample-config-files/clie=
nt=2Econf
+++ b/sample/sample-config-files/client=2Econf
@@ -20,6 +20,8 @@
=
 # On most systems, the VPN will not function
 # unless you partially or fu=
lly disable
 # the firewall for the TUN/TAP interface=2E
+# "tun" is the de=
fault device type, so the
+# "dev tun" line below is optional=2E
 ;dev tap
=
 dev tun
 
diff --git a/sample/sample-config-files/server=2Econf b/sample/s=
ample-config-files/server=2Econf
index 8943c34=2E=2E924fb96 100644
--- a/sa=
mple/sample-config-files/server=2Econf
+++ b/sample/sample-config-files/ser=
ver=2Econf
@@ -49,6 +49,8 @@
 # On most systems, the VPN will not function
=
 # unless you partially or fully disable/open
 # the firewall for the TUN/T=
AP interface=2E
+# "tun" is the default device type, so the
+# "dev tun" li=
ne below is optional=2E
 ;dev tap
 dev tun
 
diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec
index d4675ca=2E=2Ed0f447c 100644
--- a/sr=
c/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -189,7 +189,8 @@
   =
  " or --socks-proxy"
     " is used)=2E\n"
     "--nobind        : Do not =
bind to local address and port=2E\n"
-    "--dev tunX|tapX : tun/tap device=
 (X can be omitted for dynamic device=2E\n"
+    "--dev tunX|tapX : tun/tap=
 device (X can be omitted for dynamic device)=2E\n"
+    "                 =
 Defaults to \"tun\" if neither --dev nor --dev-type is given=2E\n"
     "-=
-dev-type dt   : Which device type are we using? (dt =3D tun or tap) Use\n"=

     "                  this option only if the tun/tap device used with -=
-dev\n"
     "                  does not begin with \"tun\" or \"tap\"=2E\n=
"
@@ -803,6 +804,7 @@
     gc_init(&o->dns_options=2Egc);
 
     o->mode =
=3D MODE_POINT_TO_POINT;
+    o->dev =3D "tun";
     o->topology =3D TOP_UN=
DEF;
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99d=
b137c94c88555a
Gerrit-Change-Number: 1537
Gerrit-PatchSet: 4
Gerrit-Owner: =
ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--5L2FPCFz/tc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1537?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: make &#39;tun&#39; the default fo=
r &#39;--dev&#39;<br><br>With this change, OpenVPN can be launched without =
specifying<br>any --dev option and it will start a `tun` (L3) tunnel with t=
he<br>interface named `tunX`=2E<br>As before, this behaviour can be changed=
 using --dev or --dev-type=2E<br><br>Existing configs won&#39;t see any beh=
avioural change as they all<br>had to contain at least one --dev directive=
=2E<br><br>Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a<br>Signed-o=
ff-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1537<br>Message-Id: &lt;20260724055529=2E1376-=
1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg37825=2Ehtml<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-sections/exampl=
es=2Erst<br>M doc/man-sections/vpn-network-options=2Erst<br>M sample/sample=
-config-files/client=2Econf<br>M sample/sample-config-files/server=2Econf<b=
r>M src/openvpn/options=2Ec<br>5 files changed, 15 insertions(+), 1 deletio=
n(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/examples=2Erst b/doc/ma=
n-sections/examples=2Erst</span><br><span>index 80ef2df=2E=2E416e576 100644=
</span><br><span>--- a/doc/man-sections/examples=2Erst</span><br><span>+++ =
b/doc/man-sections/examples=2Erst</span><br><span>@@ -63,6 +63,10 @@</span>=
<br><span> Example 1: A simple tunnel without security (not recommended)</s=
pan><br><span> ------------------------------------------------------------=
-</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Since :code:`tun` is the default device type, ``--dev`` is optional; when i=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+is omitted OpenVPN=
 creates a dynamically-named ``tunX`` device=2E The examples</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+below still name the device (``--d=
ev tun1``) explicitly for clarity=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> On bob::</span><br><span> </span><br><sp=
an>    openvpn --remote alice=2Eexample=2Ecom --dev tun1 \</span><br><span>=
diff --git a/doc/man-sections/vpn-network-options=2Erst b/doc/man-sections/=
vpn-network-options=2Erst</span><br><span>index 33ebedb=2E=2E960c6ad 100644=
</span><br><span>--- a/doc/man-sections/vpn-network-options=2Erst</span><br=
><span>+++ b/doc/man-sections/vpn-network-options=2Erst</span><br><span>@@ =
-50,6 +50,10 @@</span><br><span>   :code:`null` or an arbitrary name string=
 (:code:`X` can be omitted for</span><br><span>   a dynamic device=2E)</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If n=
either ``--dev`` nor ``--dev-type`` is specified, OpenVPN defaults to</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`tun`, i=2Ee=2E i=
t creates a dynamically-named :code:`tunX` device and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  runs a layer-3 tunnel=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   See examples s=
ection below for an example on setting up a TUN device=2E</span><br><span> =
</span><br><span>   You must use either tun devices on both ends of the con=
nection or tap</span><br><span>diff --git a/sample/sample-config-files/clie=
nt=2Econf b/sample/sample-config-files/client=2Econf</span><br><span>index =
53b8027=2E=2E1806b24 100644</span><br><span>--- a/sample/sample-config-file=
s/client=2Econf</span><br><span>+++ b/sample/sample-config-files/client=2Ec=
onf</span><br><span>@@ -20,6 +20,8 @@</span><br><span> # On most systems, t=
he VPN will not function</span><br><span> # unless you partially or fully d=
isable</span><br><span> # the firewall for the TUN/TAP interface=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# &quot;tun&quot; is the de=
fault device type, so the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# &quot;dev tun&quot; line below is optional=2E</span><br><span> ;dev=
 tap</span><br><span> dev tun</span><br><span> </span><br><span>diff --git =
a/sample/sample-config-files/server=2Econf b/sample/sample-config-files/ser=
ver=2Econf</span><br><span>index 8943c34=2E=2E924fb96 100644</span><br><spa=
n>--- a/sample/sample-config-files/server=2Econf</span><br><span>+++ b/samp=
le/sample-config-files/server=2Econf</span><br><span>@@ -49,6 +49,8 @@</spa=
n><br><span> # On most systems, the VPN will not function</span><br><span> =
# unless you partially or fully disable/open</span><br><span> # the firewal=
l for the TUN/TAP interface=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# &quot;tun&quot; is the default device type, so the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# &quot;dev tun&quot; line belo=
w is optional=2E</span><br><span> ;dev tap</span><br><span> dev tun</span><=
br><span> </span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec</span><br><span>index d4675ca=2E=2Ed0f447c 100644</span><br>=
<span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns=2Ec</span><br><span>@@ -189,7 +189,8 @@</span><br><span>     &quot; or -=
-socks-proxy&quot;</span><br><span>     &quot; is used)=2E\n&quot;</span><b=
r><span>     &quot;--nobind        : Do not bind to local address and port=
=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;=
--dev tunX|tapX : tun/tap device (X can be omitted for dynamic device=2E\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--de=
v tunX|tapX : tun/tap device (X can be omitted for dynamic device)=2E\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;       =
           Defaults to \&quot;tun\&quot; if neither --dev nor --dev-type is=
 given=2E\n&quot;</span><br><span>     &quot;--dev-type dt   : Which device=
 type are we using? (dt =3D tun or tap) Use\n&quot;</span><br><span>     &q=
uot;                  this option only if the tun/tap device used with --de=
v\n&quot;</span><br><span>     &quot;                  does not begin with =
\&quot;tun\&quot; or \&quot;tap\&quot;=2E\n&quot;</span><br><span>@@ -803,6=
 +804,7 @@</span><br><span>     gc_init(&amp;o-&gt;dns_options=2Egc);</span=
><br><span> </span><br><span>     o-&gt;mode =3D MODE_POINT_TO_POINT;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;dev =3D &quot;t=
un&quot;;</span><br><span>     o-&gt;topology =3D TOP_UNDEF;</span><br><spa=
n>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =
=3D AF_UNSPEC;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail">change 1537=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ca7b=
5b7ec1a01acaad222c99db137c94c88555a </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1537 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--5L2FPCFz/tc=--


--===============5762332649004708437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5762332649004708437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5762332649004708437==--

