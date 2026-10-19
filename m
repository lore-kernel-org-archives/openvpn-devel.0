Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23649CCF2E3
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BL2UH7Og4Zru1BlPm7oILejOM/3pQcHe5lBqbZGyVJw=; b=l8+D8v1YGVTEErKeYzObeCEf0V
	0rjhVqoWlRAlHg9EYeN/mJ1j+7yk/pI6nZ6TpZ29qDBRhTBfoc8bWgm2xhnVIUNADEKyiv2aUXVu6
	RZOyrA2zCe3aoENZL1ePYge6LMXBvyiV3AYJBkwY6E49Qk20a5XvQWrFTtj+9pZEzweY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn7I-0002NS-3Y;
	Mon, 19 Oct 2026 13:09:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIn7E-0002N7-U6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QCttMBbxMrEnY8jfeQW1yFaOkI+U4L3fPcY0pWphvmk=; b=lGWBLl1oSTKCNqZBa3q+1bIoMT
 cveFPsdgFXxTiHjIjh44lx9P6HfjEhD7WSlsYRJqosozCC3IunbKajU2Xf8+4PSySaftdv9x4vI8G
 4zgVcxJj270dvTy5iP+5MsMzXlz+svLLEdvRbdWB8XIajogKxg1zUE4TnyZVkN1FGwE8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QCttMBbxMrEnY8jfeQW1yFaOkI+U4L3fPcY0pWphvmk=; b=n
 L44rRHuDepZtUVO7iIi8bk58Q2z3mvBC4ABDLQuEdQ69GP1Ompt2vheL7aPzxIsvrtbspsYzcsEjy
 HSt0pwdeQ7p5iLonyK28z8X64Je9Wx9EF2qWrwNYWonEiJhdW7n7UwE232/Rin/gW39LnU1RR0jn0
 AewJfvKJpFtRnQRQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIn6y-0007mQ-Ak for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:09 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so26204705e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792415342; x=1793020142; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QCttMBbxMrEnY8jfeQW1yFaOkI+U4L3fPcY0pWphvmk=;
 b=F62yFZ/vP6lHyyRtNuEyxTRboubFgFiC2947ZScrCTDcmJurmsnJpzwFhDHskZW3o8
 FxL565VH1ijgaHSkwFrypYbEqRuHPJ+4ftxRY7cTrl0Un+PYe5jaR0dz9YZTp+uAM1HP
 OTg4BVSCH20vapobA5t613QTkR8pEu/BWxG7RqoBnmv0xOmwPwL2gMjhW7ZPCS8b1hK9
 3WwNCva67kg8LOr7J316srhnvJ/EzoinC3Y5gc804MkB5my8ptn2kJbuJmq11qwYdQc8
 WTfDaG8WvXCP03zDgEwxsiPA83epsrtpA756+RCZSqZQbit/pM8IXLGgQqKfXmcKPJFL
 12ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415342; x=1793020142;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QCttMBbxMrEnY8jfeQW1yFaOkI+U4L3fPcY0pWphvmk=;
 b=z3e8fN6og5R9oJd/QSDJqKILlNrAoEshPLr8eXbirIJCmdbO/Dmy2gVdy0K90jTgo+
 XnFmwUxloPZu+g+YZ/I1lJVIedLxYj0vz9a8BxqfGZei3OHP58Ad3qs0eFUPWjEbLFvD
 iNwWeUCnZY5unwqrcrY1MUWO3A1MjnpIyssgKSsI+JQsEPEXEt953WGhkQ9vlENwYZds
 qkaP4qNOYO9lWaSnarSMwIjUss0nQir89L5Xmc/x6cfEYRADw7yaRFJa6w318Kuy8WTk
 vDq95dZ6iMmHTxm87pPjXL1tIDwmuZ6CIwgGFLckazPAEleA2LdApuTG0s1UPpxpoXno
 9ZAw==
X-Gm-Message-State: AFq9FYLmY/O4bajyijrMeW3UMzkG0ndFs7sMK3Mc7yQ880HYu8eZC2xh
 8JVqd8I6Z2pFoH1wVO6ieJb3cSnyEf+Er6dB2JHL422qrG/uJNP8LLamKYWObBI0frT8AusKOzr
 ZywMZyrzButsiXv0ekL5SoWQFYRce/DBysvfF+KROKc2yBaze9BXWmVOrPX6EaGiSJQykkAxONq
 GSSeH76g==
X-Gm-Gg: AYBFou3WHU9fvtby4XoY5wo4LCrHS2znsC3ELmbYd+IiVUpBURbc2hagb/1+OfTaZVe
 zhywGAtCTlF2jw6nCFobfkWEdIupdJHwkvLFjsu/MxD+Plot3UWUoXVAuQwBtMNSM4rlqPT2luc
 8H5IJwJoxuhpZMxD0jnaRT0SCPN3g7DLX0r0fvE0+RP32bk0FCnssDkFvEf7dyc9sEGcFnJ2Cx7
 XR7bmPWhnxePzE1lZzFmop+bYFcm9pa5upgWiWlR0CK3GOyoOpYDSu4wd2f8DRW24QevKdxuWXo
 zBS1o1SupR6ZRXNomyKrf3mMaLElqQthj6nolO9tCUb817dPXcXqGdW0LBSgMXoDpZXEz9AGfs6
 xylCIfsexHlY/DUugP5pq7bd+pdlwlDHgWj08rg5g7n7VGQhVn9l7kjo2s5WwrmmWichkcpXtgO
 J64ngXVb4OeI/U4bpvUm1dVadRFeXpVMKdkGzAmLmuBzoVY0M8ZJhqeQLDq7/vsGG3U8iQqdzgT
 g7G0UCxOTzS0tW/w2/QSQuknAA80I0NYaan84JATb1DuBbCQB5MOcXCWAEMvB8xqxeJ24Vc8VSs
 b2Je+b63Jpw8Tmg8ZqOs0Fe5niPBRbMHTc6nDbYOCaYV4y1Q9czwxv+xM2lB
X-Received: by 2002:a05:600c:8a0d:20b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-4a1d7616d29mr112936485e9.23.1792415341566; 
 Mon, 19 Oct 2026 06:09:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dea678cdsm194293225e9.1.2026.10.19.06.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:09:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:09:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 340b9021f401b6638392193db933c2af6c9e0db5
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <502d15b9f7c2dcd8789e9e9542c4ac74aef73778-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIn6y-0007mQ-Ak
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5118279917150835360=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5118279917150835360==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XcE0xP+HiY8="; charset=UTF-8

--XcE0xP+HiY8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2014?usp=3Demail )

Change subject: Fix cppcheck warnings on ma=
cOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix cpp=
check warnings on macOS

- Replace bzero with CLEAR/memset

   memset is no=
wadays preferred to bzero

- add_route_ipv6: Fix %d used with unsigned int
=
- add const to two variables that can be const

Found-By: cppcheck on macOS=

Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Signed-off-by: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014
Messa=
ge-Id: <20261018145411=2E19775-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40015=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
route=2Ec
M src/openvpn/tun=2Ec
2 files changed, 11 insertions(+), 11 delet=
ions(-)




diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
inde=
x 8e93404=2E=2E0b1634c 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn=
/route=2Ec
@@ -1862,7 +1862,7 @@
 #elif defined(TARGET_ANDROID)
     char o=
ut[64];
 
-    snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits,=
 device);
+    snprintf(out, sizeof(out), "%s/%u %s", network, r6->netbits,=
 device);
 
     status =3D management_android_control(management, "ROUTE6"=
, out);
 
@@ -3348,10 +3348,10 @@
     rtm_addrs =3D RTA_DST | RTA_NETMASK =
| RTA_IFP;
 #endif
 
-    bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bzero(&so_=
dst, sizeof(so_dst));
-    bzero(&so_mask, sizeof(so_mask));
-    bzero(&rt=
m, sizeof(struct rt_msghdr));
+    CLEAR(m_rtmsg);
+    CLEAR(so_dst);
+   =
 CLEAR(so_mask);
+    CLEAR(rtm);
 
     rtm=2Ertm_type =3D RTM_GET;
     r=
tm=2Ertm_flags =3D RTF_UP | RTF_GATEWAY;
@@ -3566,10 +3566,10 @@
     rtm_a=
ddrs =3D RTA_DST | RTA_NETMASK | RTA_IFP;
 #endif
 
-    bzero(&m_rtmsg, si=
zeof(m_rtmsg));
-    bzero(&so_dst, sizeof(so_dst));
-    bzero(&so_mask, s=
izeof(so_mask));
-    bzero(&rtm, sizeof(struct rt_msghdr));
+    CLEAR(m_r=
tmsg);
+    CLEAR(so_dst);
+    CLEAR(so_mask);
+    CLEAR(rtm);
 
     rtm=
=2Ertm_type =3D RTM_GET;
     rtm=2Ertm_flags =3D RTF_UP;
@@ -3654,7 +3654,=
7 @@
     /* get gateway addr and interface name */
     if (gate !=3D NULL=
)
     {
-        struct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;
=
+        const struct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;
   =
      struct in6_addr gw =3D s6->sin6_addr;
 
 #ifndef TARGET_SOLARIS
diff =
--git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index a226fc4=2E=2E18c1cf=
f 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1833,7 +18=
33,7 @@
             for (int i =3D 0; i < 256; ++i)
             {
       =
          /* some platforms have a dedicated directory per driver */
-     =
           char *sep =3D "";
+                const char *sep =3D "";
 #if =
defined(TARGET_HAIKU)
                 sep =3D "/";
 #endif

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d=
4626d3
Gerrit-Change-Number: 2014
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@green=
ie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--XcE0xP+HiY8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2014?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix cppcheck warnings on macOS<br>=
<br>- Replace bzero with CLEAR/memset<br><br>   memset is nowadays preferre=
d to bzero<br><br>- add_route_ipv6: Fix %d used with unsigned int<br>- add =
const to two variables that can be const<br><br>Found-By: cppcheck on macOS=
<br>Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3<br>Signed-off-by: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2014<br>Message-Id: &lt;20261018145411=2E19775-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg40015=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>M src/openvp=
n/tun=2Ec<br>2 files changed, 11 insertions(+), 11 deletions(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br>=
<span>index 8e93404=2E=2E0b1634c 100644</span><br><span>--- a/src/openvpn/r=
oute=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -18=
62,7 +1862,7 @@</span><br><span> #elif defined(TARGET_ANDROID)</span><br><s=
pan>     char out[64];</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    snprintf(out, sizeof(out), &quot;%s/%d %s&quot;, net=
work, r6-&gt;netbits, device);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    snprintf(out, sizeof(out), &quot;%s/%u %s&quot;, network, r6=
-&gt;netbits, device);</span><br><span> </span><br><span>     status =3D ma=
nagement_android_control(management, &quot;ROUTE6&quot;, out);</span><br><s=
pan> </span><br><span>@@ -3348,10 +3348,10 @@</span><br><span>     rtm_addr=
s =3D RTA_DST | RTA_NETMASK | RTA_IFP;</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;m=
_rtmsg, sizeof(m_rtmsg));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    bzero(&amp;so_dst, sizeof(so_dst));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bzero(&amp;so_mask, sizeof(so_mask));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;rtm, sizeof(struct=
 rt_msghdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CL=
EAR(m_rtmsg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CL=
EAR(so_dst);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLE=
AR(so_mask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLE=
AR(rtm);</span><br><span> </span><br><span>     rtm=2Ertm_type =3D RTM_GET;=
</span><br><span>     rtm=2Ertm_flags =3D RTF_UP | RTF_GATEWAY;</span><br><=
span>@@ -3566,10 +3566,10 @@</span><br><span>     rtm_addrs =3D RTA_DST | R=
TA_NETMASK | RTA_IFP;</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;m_rtmsg, sizeof(m_=
rtmsg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&am=
p;so_dst, sizeof(so_dst));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bzero(&amp;so_mask, sizeof(so_mask));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    bzero(&amp;rtm, sizeof(struct rt_msghdr));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(m_rtmsg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(so_dst);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(so_mask);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(rtm);</span><b=
r><span> </span><br><span>     rtm=2Ertm_type =3D RTM_GET;</span><br><span>=
     rtm=2Ertm_flags =3D RTF_UP;</span><br><span>@@ -3654,7 +3654,7 @@</spa=
n><br><span>     /* get gateway addr and interface name */</span><br><span>=
     if (gate !=3D NULL)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        struct sockaddr_in6 *s6 =3D (struct socka=
ddr_in6 *)gate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const struct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;</span><b=
r><span>         struct in6_addr gw =3D s6-&gt;sin6_addr;</span><br><span> =
</span><br><span> #ifndef TARGET_SOLARIS</span><br><span>diff --git a/src/o=
penvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index a226fc4=2E=2E18c=
1cff 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b=
/src/openvpn/tun=2Ec</span><br><span>@@ -1833,7 +1833,7 @@</span><br><span>=
             for (int i =3D 0; i &lt; 256; ++i)</span><br><span>           =
  {</span><br><span>                 /* some platforms have a dedicated dir=
ectory per driver */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               char *sep =3D &quot;&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                const char *sep =3D &quot;&quot;;</s=
pan><br><span> #if defined(TARGET_HAIKU)</span><br><span>                 s=
ep =3D &quot;/&quot;;</span><br><span> #endif</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail=
">change 2014</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
014?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2014 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--XcE0xP+HiY8=--


--===============5118279917150835360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5118279917150835360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5118279917150835360==--

