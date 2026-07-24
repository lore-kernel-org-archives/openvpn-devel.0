Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D520C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9a4OJ/Wa9FdJHV/QfxATQTjzOq2jITsLpme61OYWq4k=; b=Vrjcr0BUfLFea3nqW8mnR3BsDF
	eCVHMj1FX/7WHc8Gmn5QbQ88aEajAsNj+Y9dilMoxWW8kFojJ/C4TpxiHYH0tHqGxPA4PwkApfJSU
	AGrw1VUBUON1ahV/a0nQ3LNuJwjtaAiI7GufNzP0+CCHxC/+BZ9Mw2XUXPxbJxURaNIY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIzo-0003y5-Uk;
	Fri, 24 Jul 2026 16:43:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIzn-0003xk-ED
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:43:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fdk7dVFgjawVED52dnMyhNBLhwtMox+hUtwEmCZgUzI=; b=F3h4WmeSAKn6roRRU11DstkIEJ
 ofHeSnPHzBHZSUPZCMWRYusouJ93tkm7iz3jznCrCbKw8yL8tFkCsMQHcO2z6T4YkHArCfreVaQvq
 mXh+RAaf9hIXN3iFJ3zfIGDb4CSVgyBn+GTp3ia3HfV/eiHzVibTG+LejylCIo05P6aI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fdk7dVFgjawVED52dnMyhNBLhwtMox+hUtwEmCZgUzI=; b=N
 9rlfDbNuf/YjuXQ6P9A7KPzs3Vuwsj49MzRtQImzGv/qt+wEYuEdARrjLoTl/uTx2IqXGOG0wZUWM
 3x2BTBzuVXWcXj3mIpKFiaZTXjLNcbzo73KpMewwq6yFxIzLAs3meW7JtN6Cb0c51dlGA9uKlUmXS
 24yq2kUgWlH55agU=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIzb-0007Nu-Hx for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:43:21 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso5350495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784911393; x=1785516193; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fdk7dVFgjawVED52dnMyhNBLhwtMox+hUtwEmCZgUzI=;
 b=Kq8p538Np4TT5so+YrnKp2scyEkfNJQtHEfBlnxQSkRqFkspR7+SWNIRSPl1x5DhUE
 UWd7th/HlIke4/r5ZCfKPDARgD1Bhq6cykeiKaUob5li52/lwA7CKPxBVz3wkSGvOQr2
 lG7El8uYKSYMe7cI+ZJGKsLVAVENX7z5dMXp6SrNxogvNl61j7rPaZx114prNMNz61MF
 tD7N3OCQBx/AEIWZXOxbn3NCslRzTea2nRR4pVm5IFTSJNXkH8GL7iPI963xF7K8qpG3
 kIrM7zpnGgvpo+pDrurTdJFjZP3HURHOOOYJ3fhdGYo0ERtEpUPqdj1W+4DykPl7aRfN
 bvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911393; x=1785516193;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fdk7dVFgjawVED52dnMyhNBLhwtMox+hUtwEmCZgUzI=;
 b=aCuEmFkkcEGf3yQYLPkWHCe/ZkOniOGrmRKBzdp55WvXrm6DDeNs/X3agNj7g1ZNl+
 xaI8o6KCvWgNtvThQIOlukUmlMSMWPup3VlaE3fkYEUEsXG3npOEcHfzRmEF8e/chOKb
 hDelUMPaOxbB6Z+9Ni+N+njirNSIzwhU2YxPNDUW6TnwSamTY9ao2aM4pkjxCLU5jpEB
 ceEOExe+lIDo2gnAiGD2P4aaM3/L+t9lkeZBySgyj5ms98UMwmKUSpvClXMUjBBjtZEL
 9qc3qJjwpgWdii3mKuYU7vm6UKnl+sCuLz/6UYjom6nAkO6Oxh+H/hDRuMVsKac7rzT8
 AMBw==
X-Gm-Message-State: AOJu0YxLC8Y5O180QB0yqWfJE9j3d6bSyhRmn5Yf70URoeKjZoGos0nl
 ipOeXvDybUpL7dvB4J+V6fA/UIGviLxMqLuhL/HBpWOhIlamg7xdu+3BuoPK54L6JWhSQnQ8uZM
 Htce8wnrzjVEiIqN+xuqlnoWCSkIaHWfIyChLKNswFn2IYElojl5Bnp8eZZ6hHzSjYSnc
X-Gm-Gg: AR+sD11cls73PWgbmj7quJS6lz31B4xZr8IhAedm9zOzMzIw1V5YpkMAgOcqx5BUUZr
 ctiZW69Cf9OHZt1cPmwOHn72YKK+tGOAweFAoF9qnKykhyicQ+aP0f+OkTwiBn0Hh7FHs7tdtZU
 wmz3rMRXi45zk/slVcX01Auj6jJx/54Dnw47zIZ04j+BAj0aufi6VkikAunoz9BcMOwquUlLNhj
 /Pl+RGxgeAGBn4UMMSuvaw6+WbVC4/EBrHaauskhkRRzL+qeLpnMjxZeRjgnu82db4t/lUtXnqf
 i0djWkyNSyRq00OzQd3QJpMRcOQOTrig09+r7oqVY1OHA0JSPdoeEnZ/YI9j9aKK6FrPWzLOl+v
 c3FeQ2/3rJ5RksoXSLBRalnVa4ibCPKG6outPAnibJ9t6kp1wCfWI+nG3ByvxpWTtaPpTZjQPZ8
 DdZWr9znMJuYmRD0RVUrk4LKhyu5xWZRogSRoUw5rhPbLgFB8S6DDB479Gt9d3VRRFs1ZAHNfSV
 +r9x0CoRxIdSmPopLvpK9pkfTtPfB29UWQoSlwR6aJlJ4HbCuOk8/e5ZuBJsGCJ8HCn
X-Received: by 2002:a05:600c:1f8f:b0:494:596e:e8c4 with SMTP id
 5b1f17b1804b1-49573cd02f2mr94147525e9.17.1784911393237; 
 Fri, 24 Jul 2026 09:43:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a659sm26254558f8f.6.2026.07.24.09.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:43:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:43:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
X-Gerrit-Change-Number: 1537
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1537?usp=email>
X-Gerrit-Commit: a6537f7549f70f16bb2efd5c0683e0e94a236f0c
In-Reply-To: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
References: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMjg0MjkxMDAwLkkwY2E3YjViN2VjMWEwMWFjYWFkMjIyYzk5ZGIxMzdjOTRjODg1NTVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2113d81598e7cd20225ee97a77686879773c9e76-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIzb-0007Nu-Hx
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6291643256157104467=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6291643256157104467==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rYQso3HrkCg="; charset=UTF-8

--rYQso3HrkCg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld


Change subject: options: make 'tun' the default for '--dev'
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: make 't=
un' the default for '--dev'

With this change, OpenVPN can be launched with=
out specifying
any --dev option and it will start a `tun` (L3) tunnel with =
the
interface named `tunX`=2E
As before, this behaviour can be changed usin=
g --dev or --dev-type=2E

Existing configs won't see any behavioural change=
 as they all
had to contain at least one --dev directive=2E

Change-Id: I0c=
a7b5b7ec1a01acaad222c99db137c94c88555a
Signed-off-by: Antonio Quartulli <an=
tonio@mandelbit=2Ecom>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537
Message-Id: <=
20260724055529=2E1376-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37825=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man-sections/examp=
les=2Erst
M doc/man-sections/vpn-network-options=2Erst
M sample/sample-conf=
ig-files/client=2Econf
M sample/sample-config-files/server=2Econf
M src/ope=
nvpn/options=2Ec
5 files changed, 15 insertions(+), 1 deletion(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1537/4

diff=
 --git a/doc/man-sections/examples=2Erst b/doc/man-sections/examples=2Erst
=
index 80ef2df=2E=2E416e576 100644
--- a/doc/man-sections/examples=2Erst
+++=
 b/doc/man-sections/examples=2Erst
@@ -63,6 +63,10 @@
 Example 1: A simple =
tunnel without security (not recommended)
 --------------------------------=
-----------------------------
 
+Since :code:`tun` is the default device ty=
pe, ``--dev`` is optional; when it
+is omitted OpenVPN creates a dynamicall=
y-named ``tunX`` device=2E The examples
+below still name the device (``--d=
ev tun1``) explicitly for clarity=2E
+
 On bob::
 
    openvpn --remote ali=
ce=2Eexample=2Ecom --dev tun1 \
diff --git a/doc/man-sections/vpn-network-o=
ptions=2Erst b/doc/man-sections/vpn-network-options=2Erst
index 33ebedb=2E=
=2E960c6ad 100644
--- a/doc/man-sections/vpn-network-options=2Erst
+++ b/do=
c/man-sections/vpn-network-options=2Erst
@@ -50,6 +50,10 @@
   :code:`null`=
 or an arbitrary name string (:code:`X` can be omitted for
   a dynamic dev=
ice=2E)
 
+  If neither ``--dev`` nor ``--dev-type`` is specified, OpenVPN =
defaults to
+  :code:`tun`, i=2Ee=2E it creates a dynamically-named :code:`=
tunX` device and
+  runs a layer-3 tunnel=2E
+
   See examples section belo=
w for an example on setting up a TUN device=2E
 
   You must use either tun=
 devices on both ends of the connection or tap
diff --git a/sample/sample-c=
onfig-files/client=2Econf b/sample/sample-config-files/client=2Econf
index =
53b8027=2E=2E1806b24 100644
--- a/sample/sample-config-files/client=2Econf
=
+++ b/sample/sample-config-files/client=2Econf
@@ -20,6 +20,8 @@
 # On most=
 systems, the VPN will not function
 # unless you partially or fully disabl=
e
 # the firewall for the TUN/TAP interface=2E
+# "tun" is the default devi=
ce type, so the
+# "dev tun" line below is optional=2E
 ;dev tap
 dev tun
 =

diff --git a/sample/sample-config-files/server=2Econf b/sample/sample-conf=
ig-files/server=2Econf
index 8943c34=2E=2E924fb96 100644
--- a/sample/sampl=
e-config-files/server=2Econf
+++ b/sample/sample-config-files/server=2Econf=

@@ -49,6 +49,8 @@
 # On most systems, the VPN will not function
 # unless =
you partially or fully disable/open
 # the firewall for the TUN/TAP interfa=
ce=2E
+# "tun" is the default device type, so the
+# "dev tun" line below i=
s optional=2E
 ;dev tap
 dev tun
 
diff --git a/src/openvpn/options=2Ec b/s=
rc/openvpn/options=2Ec
index d4675ca=2E=2Ed0f447c 100644
--- a/src/openvpn/=
options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -189,7 +189,8 @@
     " or --s=
ocks-proxy"
     " is used)=2E\n"
     "--nobind        : Do not bind to lo=
cal address and port=2E\n"
-    "--dev tunX|tapX : tun/tap device (X can be=
 omitted for dynamic device=2E\n"
+    "--dev tunX|tapX : tun/tap device (X=
 can be omitted for dynamic device)=2E\n"
+    "                  Defaults =
to \"tun\" if neither --dev nor --dev-type is given=2E\n"
     "--dev-type =
dt   : Which device type are we using? (dt =3D tun or tap) Use\n"
     "   =
               this option only if the tun/tap device used with --dev\n"
  =
   "                  does not begin with \"tun\" or \"tap\"=2E\n"
@@ -803,=
6 +804,7 @@
     gc_init(&o->dns_options=2Egc);
 
     o->mode =3D MODE_POI=
NT_TO_POINT;
+    o->dev =3D "tun";
     o->topology =3D TOP_UNDEF;
     o-=
>ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94=
c88555a
Gerrit-Change-Number: 1537
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <=
antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--rYQso3HrkCg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">options: make &#39;tun&#39=
; the default for &#39;--dev&#39;<br><br>With this change, OpenVPN can be l=
aunched without specifying<br>any --dev option and it will start a `tun` (L=
3) tunnel with the<br>interface named `tunX`=2E<br>As before, this behaviou=
r can be changed using --dev or --dev-type=2E<br><br>Existing configs won&#=
39;t see any behavioural change as they all<br>had to contain at least one =
--dev directive=2E<br><br>Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c885=
55a<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>=
Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537<br>Message-Id: &lt;20260724=
055529=2E1376-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37825=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-s=
ections/examples=2Erst<br>M doc/man-sections/vpn-network-options=2Erst<br>M=
 sample/sample-config-files/client=2Econf<br>M sample/sample-config-files/s=
erver=2Econf<br>M src/openvpn/options=2Ec<br>5 files changed, 15 insertions=
(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/37/1537/4</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-=
sections/examples=2Erst b/doc/man-sections/examples=2Erst</span><br><span>i=
ndex 80ef2df=2E=2E416e576 100644</span><br><span>--- a/doc/man-sections/exa=
mples=2Erst</span><br><span>+++ b/doc/man-sections/examples=2Erst</span><br=
><span>@@ -63,6 +63,10 @@</span><br><span> Example 1: A simple tunnel witho=
ut security (not recommended)</span><br><span> ----------------------------=
---------------------------------</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Since :code:`tun` is the default device t=
ype, ``--dev`` is optional; when it</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+is omitted OpenVPN creates a dynamically-named ``tunX`` dev=
ice=2E The examples</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
below still name the device (``--dev tun1``) explicitly for clarity=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> On bob=
::</span><br><span> </span><br><span>    openvpn --remote alice=2Eexample=
=2Ecom --dev tun1 \</span><br><span>diff --git a/doc/man-sections/vpn-netwo=
rk-options=2Erst b/doc/man-sections/vpn-network-options=2Erst</span><br><sp=
an>index 33ebedb=2E=2E960c6ad 100644</span><br><span>--- a/doc/man-sections=
/vpn-network-options=2Erst</span><br><span>+++ b/doc/man-sections/vpn-netwo=
rk-options=2Erst</span><br><span>@@ -50,6 +50,10 @@</span><br><span>   :cod=
e:`null` or an arbitrary name string (:code:`X` can be omitted for</span><b=
r><span>   a dynamic device=2E)</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  If neither ``--dev`` nor ``--dev-type`` is =
specified, OpenVPN defaults to</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  :code:`tun`, i=2Ee=2E it creates a dynamically-named :code:`tu=
nX` device and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  run=
s a layer-3 tunnel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>   See examples section below for an example on setting =
up a TUN device=2E</span><br><span> </span><br><span>   You must use either=
 tun devices on both ends of the connection or tap</span><br><span>diff --g=
it a/sample/sample-config-files/client=2Econf b/sample/sample-config-files/=
client=2Econf</span><br><span>index 53b8027=2E=2E1806b24 100644</span><br><=
span>--- a/sample/sample-config-files/client=2Econf</span><br><span>+++ b/s=
ample/sample-config-files/client=2Econf</span><br><span>@@ -20,6 +20,8 @@</=
span><br><span> # On most systems, the VPN will not function</span><br><spa=
n> # unless you partially or fully disable</span><br><span> # the firewall =
for the TUN/TAP interface=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# &quot;tun&quot; is the default device type, so the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# &quot;dev tun&quot; line below =
is optional=2E</span><br><span> ;dev tap</span><br><span> dev tun</span><br=
><span> </span><br><span>diff --git a/sample/sample-config-files/server=2Ec=
onf b/sample/sample-config-files/server=2Econf</span><br><span>index 8943c3=
4=2E=2E924fb96 100644</span><br><span>--- a/sample/sample-config-files/serv=
er=2Econf</span><br><span>+++ b/sample/sample-config-files/server=2Econf</s=
pan><br><span>@@ -49,6 +49,8 @@</span><br><span> # On most systems, the VPN=
 will not function</span><br><span> # unless you partially or fully disable=
/open</span><br><span> # the firewall for the TUN/TAP interface=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# &quot;tun&quot; is the def=
ault device type, so the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# &quot;dev tun&quot; line below is optional=2E</span><br><span> ;dev =
tap</span><br><span> dev tun</span><br><span> </span><br><span>diff --git a=
/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index d4=
675ca=2E=2Ed0f447c 100644</span><br><span>--- a/src/openvpn/options=2Ec</sp=
an><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -189,7 +189,8=
 @@</span><br><span>     &quot; or --socks-proxy&quot;</span><br><span>    =
 &quot; is used)=2E\n&quot;</span><br><span>     &quot;--nobind        : Do=
 not bind to local address and port=2E\n&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &quot;--dev tunX|tapX : tun/tap device (X can =
be omitted for dynamic device=2E\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;--dev tunX|tapX : tun/tap device (X can be o=
mitted for dynamic device)=2E\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;                  Defaults to \&quot;tun\&quot;=
 if neither --dev nor --dev-type is given=2E\n&quot;</span><br><span>     &=
quot;--dev-type dt   : Which device type are we using? (dt =3D tun or tap) =
Use\n&quot;</span><br><span>     &quot;                  this option only i=
f the tun/tap device used with --dev\n&quot;</span><br><span>     &quot;   =
               does not begin with \&quot;tun\&quot; or \&quot;tap\&quot;=
=2E\n&quot;</span><br><span>@@ -803,6 +804,7 @@</span><br><span>     gc_ini=
t(&amp;o-&gt;dns_options=2Egc);</span><br><span> </span><br><span>     o-&g=
t;mode =3D MODE_POINT_TO_POINT;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    o-&gt;dev =3D &quot;tun&quot;;</span><br><span>     o-&gt;t=
opology =3D TOP_UNDEF;</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;=
</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1537?usp=3Demail">change 1537</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1537?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1537 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--rYQso3HrkCg=--


--===============6291643256157104467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6291643256157104467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6291643256157104467==--

