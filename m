Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7621AC61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ZtL/n0tKMrZWoqdymTsFc3QUbC9wqpIm1dK5hVF5JA=; b=W2lG6AW5vPf+gZwEYjjvddx7r9
	rvrmtTFPezig0EJ5R46S+9aSx10iGgGADs/n6BhhPharJSpAAfDUoWm04cG/JjgAH5NhT0RyVCvIH
	JCOkymuqX98JfixQ6q0galE22eijwymIko8vjz+D+7isyeUAXu+1eOJHsYRMfD/94YmU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztuH-0006Uw-7L;
	Fri, 28 Aug 2026 10:33:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wztuE-0006UY-6H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cyFn5ckO+OwFwV/G7NK1l2qk/g7S8umigvNB3Ns3B14=; b=GdvTzrtEQXwb27xYxkIhy27V5D
 33nQAZ1s5oLHQPiP+KqM13IFMyOENEQxBDilep/NccON3+rIgL+9znkh7cF5kt+kL6+nom6TDBWbt
 eORJ6FiisIWprvRf1moAa9UnCr1OIgsRLlSNGI+tFrKEkqPbopL2mx+6Vq8r+hcRqFIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cyFn5ckO+OwFwV/G7NK1l2qk/g7S8umigvNB3Ns3B14=; b=c
 O4zJnMYCvHE8oaFrqN79a/IDaYhlhK2h7ugdZaaftE0dzGcN2SYO/oeMpZRJCNbnl5LybANmK1HIG
 BMsgXnUXB/1Akums+MKOucv6P2Ph9gw3+WkkphESZVu937vU4rVkE5yerGnQ68NLfIsI+lY0ndP/G
 WalR0vzqkum9NZIE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztuE-000812-74 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:33:54 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso7586895e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787913228; x=1788518028; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cyFn5ckO+OwFwV/G7NK1l2qk/g7S8umigvNB3Ns3B14=;
 b=DUoonBc/+Mfv1lVKTAKHgNoItx5EC4sDFGx3IblZvplGH0g4RDEBS3e6Vj2SNd/99l
 mYYir2NOwL9NdNJpw7g5NcbEma0uLALs+HduVKgnkhExKTjqNUc1aO9QVkycpw+a6W6W
 fhq7kUwmcFtLxx4CZDk7z/eg+Q4hzIv7wahDuKbKrM3z/6SmnmLSrK30IdcwAGUvcLL/
 +Hdac8swiQlFilUsLHA6bY/agwj+KIUeci7ayrBWIVMhDPLhebQUv7V9GDlU5Pgedngm
 zsdkWsJKpFsl1u5aHFeQ+5Hr2Dw1R+eClcBeVbesCGUIWNSkebCjeGGYsnfV+/O+NJjq
 750w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787913228; x=1788518028;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cyFn5ckO+OwFwV/G7NK1l2qk/g7S8umigvNB3Ns3B14=;
 b=ejhmSsEjSZRve7WNaSYrYA8teGTo0JLa4iFuKULP6Z22ooaLGc5Djlw7albra1/G7J
 PC0Lh9z2Iq1JbMhlpFEo1Uh2nbUCEwvGSH4+odUh3o5jr8oo4btMrF+Mp/qA/O8LpK3p
 yNxKtYKTI02ljnVTsbkuJDyJN44a0wn+EEjg/Jaea+k3VcdO3Q/vU4yOhenAsx7vqt54
 EpKq5O1Nr3OHWQlsxWmINeTt4eRWF2iLIb7s48LPh6nFmw0XTte/3pPGntb5UegPqFNZ
 Fq+odrTB2LFzp2LWoPcfe9gKF3XKXTA1QGMv2/JLKcykY+aopbhj5ZitJ5Ok/ghBlX6l
 54iQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcmD4NWkX/Feao2evWUGqr7ZMhoyW21lAC4nlhhKKbfwMIFTJteu2PSmhVCax3kQCr6HGWHlzIgfuLZfqI@lists.sourceforge.net
X-Gm-Message-State: AFuF++mhBtlzsJCW2VwvVKIlHn3oDmjskeWKRSFalF31TTQBY7GTOlbJ
 Hj25IOAzGk2q2J84szGzbvIQaMyRp5g/UTWMwiuwnwapJ7lWZ87husjs1z202Ogvh1ohSc7+Zrp
 j383w66l/o+Ij2kcoFd/UsFw8SZ4Kzb3S/qiI06n41M64lgptOxe0DylXEaEUXK12VpGR
X-Gm-Gg: AR+sD12qpr4zCik/hWbgpzYbfLh/OndfsycG7z4gpv/FyhSnBwZSqIB4RG+KtB4c/5z
 LvBTn6mSugnfztKxEzeM9PLElUJAgD257zJVOTxiyuQn3h/o8nbKlIvh+65V+hgpD8sAGoocLjZ
 QQ/nYfRyOugMRjY2FlJ79CvKyJxr2+vuwVc1eDDOsvGn++BbRg48JNgYcW8XXQCibOZeU0CL+rS
 dOMQj/Kk0eDOcZrBF8xiMDmbDXec2rAonAZpKQD10sMt+jbf7NgoJwdLg+X/6AoRX49urchoBxm
 +uJMykbaGL9pEfToRx0unVgRReHdoXA22oI3/tOlXjbK3aTWxSx9T0CZDj4hv1vfmdeOZJXmhsp
 7zgJBdDrsBoYDV+x/JktlFxadygnikThWjy2IZMxi72KVjEMeGVbbzznONOcBitWFI/iBzyNNIr
 f5bDsFTde/cN9p8v2yg+p3UPG0L743Z/w3fK6ZkVGVThO5qLTK1JH0G7UM6xir3mQvquiI1Yfb8
 MWs9iyg25Js+ITb53vo/7YryzSBpDuRfb7GSL1JtfFTMjAk0TlcgqrpkUkDAkT2JINJOBjAZXBK
 6tQ/IniJiZ0ndZfmpHxl2pMbb+NyY0thvtGvAG77ZTEQNiC2KQB9DvkD3oHVig==
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49b91a67d36mr62792235e9.6.1787913227481; 
 Fri, 28 Aug 2026 03:33:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c5790csm46395585e9.0.2026.08.28.03.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:33:47 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:33:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I432df6c69249b49e9b9a3a904803904d134387a0
X-Gerrit-Change-Number: 1857
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1857?usp=email>
X-Gerrit-Commit: 269da702816e8ee9bce595b2444aa9997a34fc5c
In-Reply-To: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MzJkZjZjNjkyNDliNDllOWI5YTNhOTA0ODAzOTA0ZDEzNDM4N2EwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <076142799cd5680068729e9f068628e823bff482-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztuE-000812-74
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add mock support for
 management messages
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8451109388546218302=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8451109388546218302==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4gkFRHxMi9U="; charset=UTF-8

--4gkFRHxMi9U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1857?usp=3Demail )

Change subject: Add mock support for management mes=
sages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add moc=
k support for management messages

Change-Id: I432df6c69249b49e9b9a3a904803=
904d134387a0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1857
Message-Id: <20260826185248=2E17995-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg38745=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/mock_msg=2Ec
M tests/unit_tests=
/openvpn/mock_msg=2Eh
2 files changed, 11 insertions(+), 0 deletions(-)



=

diff --git a/tests/unit_tests/openvpn/mock_msg=2Ec b/tests/unit_tests/open=
vpn/mock_msg=2Ec
index 8176d2a=2E=2E3e73d19 100644
--- a/tests/unit_tests/o=
penvpn/mock_msg=2Ec
+++ b/tests/unit_tests/openvpn/mock_msg=2Ec
@@ -43,6 +4=
3,7 @@
 
 
 char mock_msg_buf[MOCK_MSG_BUF];
+char mock_managment_buf[MOCK_=
MSG_BUF];
 
 
 void
@@ -76,6 +77,14 @@
     {
         printf("FATAL ERROR:=
");
     }
+
+    if (flags & M_MSG_VIRT_OUT)
+    {
+        CLEAR(mock_ma=
nagment_buf);
+        vsnprintf(mock_managment_buf, sizeof(mock_managment_=
buf), format, arglist);
+        return;
+    }
+
     CLEAR(mock_msg_buf);=

     vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arglist);
 
dif=
f --git a/tests/unit_tests/openvpn/mock_msg=2Eh b/tests/unit_tests/openvpn/=
mock_msg=2Eh
index da96b212=2E=2E41ce48f 100644
--- a/tests/unit_tests/open=
vpn/mock_msg=2Eh
+++ b/tests/unit_tests/openvpn/mock_msg=2Eh
@@ -36,6 +36,8=
 @@
 
 extern bool fatal_error_triggered;
 extern char mock_msg_buf[MOCK_MS=
G_BUF];
+extern char mock_managment_buf[MOCK_MSG_BUF];
+
 
 msglvl_t mock_g=
et_debug_level(void);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1857?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I432df6c69249b49e9b9a3a904803904d134387a0
Gerrit-Change-Number: 1857
Gerr=
it-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--4gkFRHxMi9U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1857?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Add mock support for management messages<b=
r><br>Change-Id: I432df6c69249b49e9b9a3a904803904d134387a0<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1857<br>Message-Id: &lt;20260826185248=2E17995-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38745=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/mock_msg=2Ec=
<br>M tests/unit_tests/openvpn/mock_msg=2Eh<br>2 files changed, 11 insertio=
ns(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvp=
n/mock_msg=2Ec b/tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span>inde=
x 8176d2a=2E=2E3e73d19 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/mock_msg=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg=2Ec<=
/span><br><span>@@ -43,6 +43,7 @@</span><br><span> </span><br><span> </span=
><br><span> char mock_msg_buf[MOCK_MSG_BUF];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+char mock_managment_buf[MOCK_MSG_BUF];</span><br><=
span> </span><br><span> </span><br><span> void</span><br><span>@@ -76,6 +77=
,14 @@</span><br><span>     {</span><br><span>         printf(&quot;FATAL E=
RROR:&quot;);</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (flags &amp; M_MSG_VIRT_OUT)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        vsnprintf(mock_managment_buf, sizeof(mock_managment_=
buf), format, arglist);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     CLEAR(mock_msg_buf);</span><br><span>     vsnprintf(mock_msg_buf, s=
izeof(mock_msg_buf), format, arglist);</span><br><span> </span><br><span>di=
ff --git a/tests/unit_tests/openvpn/mock_msg=2Eh b/tests/unit_tests/openvpn=
/mock_msg=2Eh</span><br><span>index da96b212=2E=2E41ce48f 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/mock_msg=2Eh</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/mock_msg=2Eh</span><br><span>@@ -36,6 +36,8 @@</span>=
<br><span> </span><br><span> extern bool fatal_error_triggered;</span><br><=
span> extern char mock_msg_buf[MOCK_MSG_BUF];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+extern char mock_managment_buf[MOCK_MSG_BUF];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </spa=
n><br><span> msglvl_t mock_get_debug_level(void);</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1857?usp=3Demail">change 1857</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I432df6c69249b49e9b9a3a904803=
904d134387a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1857=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--4gkFRHxMi9U=--


--===============8451109388546218302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8451109388546218302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8451109388546218302==--

