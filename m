Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E0CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3oojZgrdkLFdaTCoje+4bpTdBwafFs5S7kvGzNrRt2s=; b=EtCEZVoOwWZhjNUq2xqpITb7qW
	Zss5Z+CuoIrtTySXs1iMhgT1JVZfu045LwFpWIYs44/vXe58wdR+K6Ix3k/s1YuK/x1qYJ6IrNjqp
	6QYLYBoBFJ+v6hgGQQGkR6LE7B7ev/jugFnehuUawDaInRpD8HUhGngToO5dtqVNwKbk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIS8g-0000gT-Tt;
	Sun, 18 Oct 2026 14:45:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIS8e-0000gN-9V
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:45:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EBp/M9b84AmZABD+VN4FUYd0LDnfp12QZ7cgGWfvr9g=; b=TPLYlfPbIbRZ41lWg64YXdvA8X
 poStZVi0+kqO+nR7M6PJ8wBgood/BzGSR+VW5wLpIhuBMy5+CkIa5r78VSS4QVrI+P6tFY/v5injR
 ZRmDPsFGfKMiHAw10Q9NzO1o1wVlvHzLNZUv85qgD8UQ9WEGTLt4KhEJASJLBaxtiqKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EBp/M9b84AmZABD+VN4FUYd0LDnfp12QZ7cgGWfvr9g=; b=K
 k70fkjLq05ihLYavOxNIsTN5akMFBo925IT9Z6oSkOB1zIoZs8D9OgTBcEz4SzngR4aJnpC08Mk5C
 9RyEZ9W9eXxLYAtx+tdfu0TdIXamZlWj80rpWVcpYhdoFdku6f3K36miio9l8vo56sx3oE5Dv2Wzi
 3cTWxhp8KjrbCOdI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIS8d-0000NY-F6 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:45:28 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso5783465e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792334721; x=1792939521; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EBp/M9b84AmZABD+VN4FUYd0LDnfp12QZ7cgGWfvr9g=;
 b=eBtg2/NwfzAZi6IBQFR2INCXawTopUm4O7JtYmf/C2KuYb2Um6vvAEP/AJCrM0eN+p
 aLG6DnBanwLpoW63p5f+nnqQVSevhQdyBRSDsPKNaW04OsMmarh2RJUlXJo/cFUMYygo
 tVm/PeVC89bK5NwQe+yBH/2kI1/Mz+Q4eHMc1y8QkDcjOFqATE9tmZUQA13/xhHo7itw
 TpCeWDBG0LosU4bd/ldiFJ7iEgmVDG2KVTFKejPSMRC6XCO2WMktCQH+EB3QVuiF5eQ0
 zDyPDwslaPizXLmtL7Y3pKE6XEn8j/O4ea7QYudSwAZ7ittVTTWE6z5iOW1QLtOou5a9
 VRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792334721; x=1792939521;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EBp/M9b84AmZABD+VN4FUYd0LDnfp12QZ7cgGWfvr9g=;
 b=KJcexz7ahYUT4WKYJT5SLDh2DTZYTJ6lyHZNs6Lgzm4znsWI3VxSDLcay33JiAhr+T
 JzeA9ImVyaIG/K3hDL0x70pDRjYb6UaC1Np+jepez94isHmce++ywihzWed9k/2cZLEM
 HizPjcKD34N0dWeRxPxTbhVRYf2KrSiXv+0tXB34NJ31FC4bmEiShCsqo2s+7heMwVCi
 VfuEYp0Zfq1qjfgdovsFruwQsV3/GB8NO4jlBfguTMyqnfxZkXT3CTTT8GkiJ7bRmrl2
 kdz1R8aGnSOa+oW8cvznnOUQXw0XwfBPI+Vn53k1rSpDDDyCAOg0cApVmU1oA3gjXupe
 jkdw==
X-Gm-Message-State: AFq9FYLqDAX7tn6uoCOggFMDmatdyuzbN7e1VMGc+Pck5RjVJ/WPchZs
 qda1pMraNo3Yb1ESNBTq9koAiHH08C+YWxAfSEH+rKmxaRv6kPar+9b7OFAAgqBMSKUIy2uWWsa
 E/c6INLTBXAVBXHBt6fGkw/VyjssKl5ZZMIdZIX2hDVDwfTdcCFqFsJIrbWHB5TG7tE/4TcgehK
 VjBlU4gA==
X-Gm-Gg: AYBFou0PrfkYRY+KcUXW9UEwYJjUDX8w8SPt3cDorpOM8nfIhbqwlwXz950ytoQydO7
 fzyrsqr2iki2bSViSm523xGtx3Jp2h8t7UL2VamHR5UGQwxbqwzTS0tIojBqUpJVgsYZAjhhiwa
 6RPnN3E4AiZGIcevR5rT4TYmfNGgrNiv0hkbS4wivBle2dPK2UPiQIDMToHOLwXzkW1yJpWKX6K
 0SfMpJNWPmvPu4iE12QZYtXZ16bpAL6EWKNiiqFH203O8p+XMKNCBF3ys7ASGh3+DW0urz7frEm
 YsPym5EkMbCih4Tef3zHrPTcrXND+sSEY6UVmdmX8LkJf/VmkrBPiUjUpqdwICtBqJTYHysLdTU
 ee6JAW+L/b0zu8A2NJlBQJO4plZDmOoKckXfC19Stpk+iMeT9zsEf44I5RMMBnU5ohlr3HPA2rM
 O+a0bzqJJkA2qp6o6CWISokVnKhFfOkNLZsxM8Dz61l+vi+TnyXA5N1k36wSK+GcOV4MN85EC6B
 GRYrB9qYE35Ql/e2Rj+aAYguT+ZT6Q6LGcYeAZZ4vHrQCJO5gO3HEaeADF54l2R4epI75wNkJ9L
 qfrwoanDP/cGXE1tI9bEcP9HckIW85K6+5S68l+ioJEHDJPMXOVcTLw1ZiEG
X-Received: by 2002:a05:600c:37cf:b0:4a1:df14:ad07 with SMTP id
 5b1f17b1804b1-4a1df14b4d3mr73736445e9.18.1792334720781; 
 Sun, 18 Oct 2026 07:45:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm259980665e9.0.2026.10.18.07.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:45:20 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 14:45:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 262d36962c98a8ba3e5b6f4029bd9a21dca7389b
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a56b811ca67359526a005c1cffd0bedf2c567756-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIS8d-0000NY-F6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix cppcheck
 warnings on macOS
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0301286940132188229=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0301286940132188229==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H8nULoSigSE="; charset=UTF-8

--H8nULoSigSE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Gert Doering, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2014?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: Fix cppcheck warnings on macOS
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix cppcheck warnings on macOS
=

- Replace bzero with CLEAR/memset

   memset is nowadays preferred to bzer=
o

- add_route_ipv6: Fix %d used with unsigned int
- add const to two varia=
bles that can be const

Found-By: cppcheck on macOS
Change-Id: I10ebb582182=
9bf738e58fec23f9f9dd65d4626d3
---
M src/openvpn/route=2Ec
M src/openvpn/tun=
=2Ec
2 files changed, 11 insertions(+), 11 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/2014/2

diff --git a/s=
rc/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 8e93404=2E=2E0b1634c 100=
644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -1862,7 +186=
2,7 @@
 #elif defined(TARGET_ANDROID)
     char out[64];
 
-    snprintf(ou=
t, sizeof(out), "%s/%d %s", network, r6->netbits, device);
+    snprintf(ou=
t, sizeof(out), "%s/%u %s", network, r6->netbits, device);
 
     status =
=3D management_android_control(management, "ROUTE6", out);
 
@@ -3348,10 +3=
348,10 @@
     rtm_addrs =3D RTA_DST | RTA_NETMASK | RTA_IFP;
 #endif
 
-  =
  bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bzero(&so_dst, sizeof(so_dst));
- =
   bzero(&so_mask, sizeof(so_mask));
-    bzero(&rtm, sizeof(struct rt_msgh=
dr));
+    CLEAR(m_rtmsg);
+    CLEAR(so_dst);
+    CLEAR(so_mask);
+    CL=
EAR(rtm);
 
     rtm=2Ertm_type =3D RTM_GET;
     rtm=2Ertm_flags =3D RTF_U=
P | RTF_GATEWAY;
@@ -3566,10 +3566,10 @@
     rtm_addrs =3D RTA_DST | RTA_N=
ETMASK | RTA_IFP;
 #endif
 
-    bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bze=
ro(&so_dst, sizeof(so_dst));
-    bzero(&so_mask, sizeof(so_mask));
-    bz=
ero(&rtm, sizeof(struct rt_msghdr));
+    CLEAR(m_rtmsg);
+    CLEAR(so_dst=
);
+    CLEAR(so_mask);
+    CLEAR(rtm);
 
     rtm=2Ertm_type =3D RTM_GET;=

     rtm=2Ertm_flags =3D RTF_UP;
@@ -3654,7 +3654,7 @@
     /* get gateway=
 addr and interface name */
     if (gate !=3D NULL)
     {
-        struct=
 sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;
+        const struct so=
ckaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;
         struct in6_addr gw=
 =3D s6->sin6_addr;
 
 #ifndef TARGET_SOLARIS
diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec
index a226fc4=2E=2E18c1cff 100644
--- a/src/open=
vpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1833,7 +1833,7 @@
             fo=
r (int i =3D 0; i < 256; ++i)
             {
                 /* some platf=
orms have a dedicated directory per driver */
-                char *sep =
=3D "";
+                const char *sep =3D "";
 #if defined(TARGET_HAIKU)=

                 sep =3D "/";
 #endif

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Gerrit-=
Change-Number: 2014
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--H8nULoSigSE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Arne Schwabe <strong>uploaded=
 patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2014?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix cppcheck warnings on macOS<br><br>- Replace bzero with CLEAR/memset=
<br><br>   memset is nowadays preferred to bzero<br><br>- add_route_ipv6: F=
ix %d used with unsigned int<br>- add const to two variables that can be co=
nst<br><br>Found-By: cppcheck on macOS<br>Change-Id: I10ebb5821829bf738e58f=
ec23f9f9dd65d4626d3<br>---<br>M src/openvpn/route=2Ec<br>M src/openvpn/tun=
=2Ec<br>2 files changed, 11 insertions(+), 11 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/14/2014/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index 8e93404=2E=2E0b1634c 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -1862,7 +1862,7 @@</span><br><span> #elif defined(TARGET_ANDROI=
D)</span><br><span>     char out[64];</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    snprintf(out, sizeof(out), &quot;%s/%=
d %s&quot;, network, r6-&gt;netbits, device);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    snprintf(out, sizeof(out), &quot;%s/%u %s&quo=
t;, network, r6-&gt;netbits, device);</span><br><span> </span><br><span>   =
  status =3D management_android_control(management, &quot;ROUTE6&quot;, out=
);</span><br><span> </span><br><span>@@ -3348,10 +3348,10 @@</span><br><spa=
n>     rtm_addrs =3D RTA_DST | RTA_NETMASK | RTA_IFP;</span><br><span> #end=
if</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bzero(&amp;m_rtmsg, sizeof(m_rtmsg));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bzero(&amp;so_dst, sizeof(so_dst));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;so_mask, sizeof(so_mask=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;rtm=
, sizeof(struct rt_msghdr));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    CLEAR(m_rtmsg);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    CLEAR(so_dst);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(so_mask);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(rtm);</span><br><span> </span><br><span>     rtm=2Ertm_ty=
pe =3D RTM_GET;</span><br><span>     rtm=2Ertm_flags =3D RTF_UP | RTF_GATEW=
AY;</span><br><span>@@ -3566,10 +3566,10 @@</span><br><span>     rtm_addrs =
=3D RTA_DST | RTA_NETMASK | RTA_IFP;</span><br><span> #endif</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;m_r=
tmsg, sizeof(m_rtmsg));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    bzero(&amp;so_dst, sizeof(so_dst));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    bzero(&amp;so_mask, sizeof(so_mask));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;rtm, sizeof(struct r=
t_msghdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEA=
R(m_rtmsg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEA=
R(so_dst);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(so_mask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(rtm);</span><br><span> </span><br><span>     rtm=2Ertm_type =3D RTM_GET;</=
span><br><span>     rtm=2Ertm_flags =3D RTF_UP;</span><br><span>@@ -3654,7 =
+3654,7 @@</span><br><span>     /* get gateway addr and interface name */</=
span><br><span>     if (gate !=3D NULL)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr_in6 *s6 =
=3D (struct sockaddr_in6 *)gate;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const struct sockaddr_in6 *s6 =3D (struct sockaddr_in6=
 *)gate;</span><br><span>         struct in6_addr gw =3D s6-&gt;sin6_addr;<=
/span><br><span> </span><br><span> #ifndef TARGET_SOLARIS</span><br><span>d=
iff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index=
 a226fc4=2E=2E18c1cff 100644</span><br><span>--- a/src/openvpn/tun=2Ec</spa=
n><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -1833,7 +1833,7 @@=
</span><br><span>             for (int i =3D 0; i &lt; 256; ++i)</span><br>=
<span>             {</span><br><span>                 /* some platforms hav=
e a dedicated directory per driver */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                char *sep =3D &quot;&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                const char *sep =3D=
 &quot;&quot;;</span><br><span> #if defined(TARGET_HAIKU)</span><br><span> =
                sep =3D &quot;/&quot;;</span><br><span> #endif</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2014?usp=3Demail">change 2014</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2014?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2014 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--H8nULoSigSE=--


--===============0301286940132188229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0301286940132188229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0301286940132188229==--

