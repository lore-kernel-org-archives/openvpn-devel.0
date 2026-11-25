Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2662606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eswvqQFV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TjICHSEU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UUlnNECg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A/azolJw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yqvesboyE13/GmW7AuG826RDgd8J6RvZCol09HG0PUc=; b=eswvqQFVAgMnQB/H33vmwUP9Iy
	GNl+UHC2Z6G2lORaJp5fYQQR0Y7F/+luu7xUzd3grGjtRc8Q91XcSUzXoPRkKmstluhirA5E9O+uf
	7E83v6PW1NfmsLXk1YYE8X6R7rB4WhiNUAlIggZdcTMvNI72OnQ59dMzYyoKCtIgcw4M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGUo-0000000008G-24MF;
	Wed, 25 Nov 2026 17:09:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWGUl-0000000008A-3qnJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:09:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TQqse25nPvJ6xwkMYbI59bAteT6dwMKO1+EUMc3wlM=; b=TjICHSEUdI6myTchqdtkK+b5GK
 vUmWDs/USYzp6qUkb6ysEXR7TAmTFHTgvY2O/MHTVJSh8MGy7Fu58qseMCyU0l62KtXkqbSxYs+RM
 dOCD+zAGVLbUPmZRPfibU3bgp5ASAb7MIQzKUZnR+b5aih9YW8ooDvX/PcTnzgtDeQc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TQqse25nPvJ6xwkMYbI59bAteT6dwMKO1+EUMc3wlM=; b=UUlnNECgioT8ON3MtgcXKyRvrQ
 PHZi3BPCNAT4Xn/KBUpcVcKGEpPSe7byjgpoenNoc4WIwMIUJ0k7XiTYjuZMGgnCAAafoTj8ZSvUD
 9LrR6UfCx1W2s1FD7VS/5UAovywEgfl//9VsSaDKuB1D/ngUnAL+wepltLWN8Rtmmj6w=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWGUk-0000000085m-1eep for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:09:23 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so65160695e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795626556; x=1796231356; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4TQqse25nPvJ6xwkMYbI59bAteT6dwMKO1+EUMc3wlM=;
 b=A/azolJw8TqzPr43oMacBAx6ljBmZk7UXzgejjqiw5f9nrjam/xbMoP9GGncjPPK9x
 OUEHjgQbczTFylXwpxxngaHR7pf4w7DeCTABSTdeKmYEhwifrnL2pNOdtu1TQTeASo+3
 TwbDHkY4JT2fhKPqU3QfL1mZGjset1wNIDLJsCY5NwSiUp02pv2+iIgJdREhhxs25Kgt
 8FWuJLRxxqT3ML/RflOrw+DVAVrkrB70WP9COsEOOFtq43gz4FKsKtOGy/lYpwgC6Wu3
 0QPIn/3/TYrmZZWh27AAUHXAmPG7MAoMNAGrorxo3wn4TlJvp96skCaWujG9hnh6hhMH
 k2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795626556; x=1796231356;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4TQqse25nPvJ6xwkMYbI59bAteT6dwMKO1+EUMc3wlM=;
 b=PC+nXgi2bm07dx7qOdKbgHW0AOnKMkhRrLH274YxA/tdMLFduWEzzUuXH5jMd++zAX
 NH3UI/Q8Qb2L6yr9aAzGGQV9jg3qrGDiXdPxWpIsX4Mslk/cTJmu5lWmYBtrECpWBVpC
 cuTKEZvwWhHtYr/Ipau+IvPm2teKsKb9sOOjxxeNuD8NtZ2ZPjusfnMZDpV7IpWmAO5I
 UB6dg35GQ3pmjbiPzVtfO7e5rQZF22bJxI7x2xEADJo6dbB3Y2HfvxJiGvVK8p0a7E3A
 oR28EqzgHenkBIccR3pFcqO1LayrTBNWHqElvtK0kLS2hFHDf5rIpbKx0psVsHuweBEh
 /W9g==
X-Gm-Message-State: APuU4Z8AksPyKj0h3OGQ+90AQvl6NWR9lAriCBBamAZcT14MbF1GOtLV
 fJXBR6iwmzMhJ8nc0ZGRGjtPRa/JSBv0Yfwy3VuWjofqHp2exQr9wa4rqj1Z/9d4LN/jdEz6mww
 GyEYHLG+fNl4sH1yvsCngxnTv5lreK+WS/LfoFuXc9jQHYA4IuSK3hnOLte+IdVT/gR9Q
X-Gm-Gg: AZFdTZdb8CM+5VJReDjTbH+O8SNNyF7VOCPKQqBqpoRl0pSppSw1i6WVI2Ot0tMlnvp
 Wn6VVnEnqyDAjUqU9jl+2mIDswYizb4j0AWiAuj6s67a7OkB9hkmXNOZIZaMGPWRaWlQlUf3Mum
 KdFutQ07QIYMvm1GallP48OkQhjdNAx1Ud9pc8EBfG+hZ0BIvzIcR06VM7mk/Nd/Ll8EEptDA9D
 KEgEFDt3Mbm+BH5UDKkH0DsddeQDI41/ntlKyn4BPUqy4yqTmwSfQYQSrjlrou4N0NNDUBQyPKY
 R9FnDZKOr6o9JN6MCK6GkU+X/mBnCIpko990l30qwQcGQ0ShP/aVy1sKELJV6ZeWQhPxqiq+jfc
 RuWQVPOFirzsoNLWPQqtDMp3GWQVefgusN9vSe0sRhTwvL6fcms8qRUBUpKZNjRptwQowmtM1Ng
 I8Pbpw6qK5G5FKdPdVsD99D3iSlE1sniP75jehqy2Cec3DZUsuSRJNXLCMUrgH66hXI3Cy3lp8p
 q12mAVC4O/tuvFqbiHvNqW+MpT2bQC8a1tTKS+v3wP/lqfUZk8mLn9HyFmbG3ILi8xTz33LpTbI
 KXmWUKWySGPgMxj4MBZFShx4FTB3B8m76crXzuxFJgZt7UAMT2c5ePvBdRj9zOocGdzJJJ+4Cjp
 VfJFpplRC2Hxj9379yTNZeyeuzDQqDuaGp5qdpu4xONGdaeInXNjNM3BAI4xuxhDnBucg4UkJJ5
 5z/3nwhWU+nkXR+E0=
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb8892a21amr346099035e9.34.1795626555475; 
 Wed, 25 Nov 2026 09:09:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm35560861f8f.41.2026.11.25.09.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:09:15 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 17:09:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: f7498a7b2c968dd37b1b8068c93e6982ddbe02bf
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2a82213e44f8a96be275aa853110f7267a8cbd87-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWGUk-0000000085m-1eep
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Windows: Switch all
 uses of address family to ADDRESS_FAMILY type
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0288890557990998410=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0288890557990998410==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sgs5+DvEdQM="; charset=UTF-8

--sgs5+DvEdQM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?=
usp=3Demail

to look at the new patch set (#2)=2E

The following approvals =
got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Chan=
ge subject: Windows: Switch all uses of address family to ADDRESS_FAMILY ty=
pe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Windows: S=
witch all uses of address family to ADDRESS_FAMILY type

Previously we had =
conversion errors between short
and unsigned short=2E

Also remove useless =
SetNameServers wrapper=2E Wrapping
only a name is really not that useful=2E=


Add a definition for ADDRESS_FAMILY for cppcheck=2E
The built-in windows =
platform definition doesn't
cover it=2E

Change-Id: I225c21dbd843601b697fe7=
12b5b66c2a4f5c2ac2
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
---
M dev-tools/openvpn-cppcheck-windows=2Ecfg
M include/openvpn-msg=2Eh=

M src/openvpn/tun=2Ec
M src/openvpnserv/interactive=2Ec
4 files changed, 2=
2 insertions(+), 36 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/42/2342/2

diff --git a/dev-tools/openvpn-cppche=
ck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-windows=2Ecfg
index dca2b07=
=2E=2E19d32a1 100644
--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg
+++ b/d=
ev-tools/openvpn-cppcheck-windows=2Ecfg
@@ -8,6 +8,7 @@
       <formatstr /=
>
     </arg>
   </function>
+  <podtype name=3D"ADDRESS_FAMILY" sign=3D"u"=
 size=3D"2" />
   <!-- MinGW uses GCC, so we need to handle GCC builtins=2E=
 gnu=2Ecfg has these,
        but we do not load it for Windows=2E Without =
this cppcheck does not
        understand our likely()/unlikely() macros=2E=
 -->
diff --git a/include/openvpn-msg=2Eh b/include/openvpn-msg=2Eh
index c=
a3267e8=2E=2Edd20f7b 100644
--- a/include/openvpn-msg=2Eh
+++ b/include/ope=
nvpn-msg=2Eh
@@ -80,7 +80,7 @@
 typedef struct
 {
     message_header_t hea=
der;
-    short family;
+    ADDRESS_FAMILY family;
     inet_address_t add=
ress;
     int prefix_len;
     interface_t iface;
@@ -89,7 +89,7 @@
 typed=
ef struct
 {
     message_header_t header;
-    short family;
+    ADDRESS_=
FAMILY family;
     inet_address_t prefix;
     int prefix_len;
     inet_a=
ddress_t gateway;
@@ -102,7 +102,7 @@
     message_header_t header;
     in=
terface_t iface;
     char domains[512];
-    short family;
+    ADDRESS_FA=
MILY family;
     unsigned int addr_len;
     inet_address_t addr[4]; /* su=
pport up to 4 dns addresses */
 } dns_cfg_message_t;
@@ -150,7 +150,7 @@
 t=
ypedef struct
 {
     message_header_t header;
-    short family;
+    ADDR=
ESS_FAMILY family;
     interface_t iface;
 } flush_neighbors_message_t;
 
=
@@ -177,7 +177,7 @@
 {
     message_header_t header;
     interface_t iface=
;
-    short family;
+    ADDRESS_FAMILY family;
     int mtu;
 } set_mtu_m=
essage_t;
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index fe=
1af45=2E=2E65edf73 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=
=2Ec
@@ -101,7 +101,7 @@
 static void netsh_ifconfig(const struct tuntap_op=
tions *to, DWORD adapter_index, const in_addr_t ip,
                       =
     const in_addr_t netmask, const unsigned int flags);
 
-static void win=
dows_set_mtu(const int iface_index, const short family, const int mtu);
+st=
atic void windows_set_mtu(const int iface_index, const ADDRESS_FAMILY famil=
y, const int mtu);
 
 static void netsh_set_dns6_servers(const struct in6_a=
ddr *addr_list, const unsigned int addr_len,
                              =
      DWORD adapter_index);
@@ -118,7 +118,7 @@
 #endif
 
 static bool
-do_=
address_service(const bool add, const short family, const struct tuntap *tt=
)
+do_address_service(const bool add, const ADDRESS_FAMILY family, const st=
ruct tuntap *tt)
 {
     bool ret =3D false;
     ack_message_t ack;
@@ -24=
1,7 +241,7 @@
 }
 
 static void
-do_dns_service(bool add, const short famil=
y, const struct tuntap *tt)
+do_dns_service(bool add, const ADDRESS_FAMILY =
family, const struct tuntap *tt)
 {
     ack_message_t ack;
     struct gc_=
arena gc =3D gc_new();
@@ -366,7 +366,7 @@
 }
 
 static bool
-do_set_mtu_se=
rvice(const struct tuntap *tt, const short family, const int mtu)
+do_set_m=
tu_service(const struct tuntap *tt, const ADDRESS_FAMILY family, const int =
mtu)
 {
     bool ret =3D false;
     ack_message_t ack;
@@ -5320,7 +5320,7=
 @@
 }
 
 static void
-windows_set_mtu(const int iface_index, const short f=
amily, const int mtu)
+windows_set_mtu(const int iface_index, const ADDRESS=
_FAMILY family, const int mtu)
 {
     DWORD err =3D 0;
     MIB_IPINTERFAC=
E_ROW ipiface;
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnse=
rv/interactive=2Ec
index ad0fda2=2E=2Efb7463a 100644
--- a/src/openvpnserv/=
interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -536,7 +536,7 @@
 =
#endif
 
 static SOCKADDR_INET
-sockaddr_inet(short family, const inet_addr=
ess_t *addr)
+sockaddr_inet(ADDRESS_FAMILY family, const inet_address_t *ad=
dr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet=
));
@@ -1865,7 +1865,7 @@
  * @return BOOL to indicate success or failure
 =
 */
 static BOOL
-GetInterfacesKey(short family, PHKEY key)
+GetInterfacesK=
ey(ADDRESS_FAMILY family, PHKEY key)
 {
     PCSTR itfs_key =3D family =3D=
=3D AF_INET6
                          ? "SYSTEM\\CurrentControlSet\\Servic=
es\\Tcpip6\\Parameters\\Interfaces"
@@ -1875,7 +1875,7 @@
     if (err)
   =
  {
         *key =3D INVALID_HANDLE_VALUE;
-        MsgToEventLog(M_SYSERR=
, L"%S: could not open interfaces registry key for family %d (%lu)",
+     =
   MsgToEventLog(M_SYSERR, L"%S: could not open interfaces registry key for=
 family %hu (%lu)",
                       __func__, family, err);
     }
 =

@@ -1892,7 +1892,7 @@
  * @return DWORD NO_ERROR on success, a Windows err=
or code otherwise
  */
 static DWORD
-SetNameServersValue(PCWSTR itf_id, sh=
ort family, PCSTR value)
+SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY=
 family, PCSTR value)
 {
     DWORD err;
 
@@ -1906,7 +1906,7 @@
     err =
=3D RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
     if (err)
   =
  {
-        MsgToEventLog(M_SYSERR, L"%S: could not open interface key for=
 %s family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not open=
 interface key for %s family %hu (%lu)",
                       __func__, i=
tf_id, family, err);
         goto out;
     }
@@ -1914,7 +1914,7 @@
     e=
rr =3D RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, (DWORD)st=
rlen(value) + 1);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%=
S: could not set name servers '%S' for %s family %d (%lu)",
+        MsgToE=
ventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s family %hu (=
%lu)",
                       __func__, value, itf_id, family, err);
     }=

 
@@ -1931,21 +1931,6 @@
 }
 
 /**
- * Set the DNS name servers in a regis=
try interface configuration
- *
- * @param itf_id    the interface id to se=
t the servers for
- * @param family    internet address family to set the s=
ervers for
- * @param addrs     comma separated list of name server address=
es
- *
- * @return DWORD NO_ERROR on success, a Windows error code otherwis=
e
- */
-static DWORD
-SetNameServers(PCWSTR itf_id, short family, PCSTR add=
rs)
-{
-    return SetNameServersValue(itf_id, family, addrs);
-}
-
-/**
  =
* Delete all DNS name servers from a registry interface configuration
  *
 =
 * @param itf_id    the interface id to clear the servers for
@@ -1954,7 +1=
939,7 @@
  * @return DWORD NO_ERROR on success, a Windows error code otherw=
ise
  */
 static DWORD
-ResetNameServers(PCWSTR itf_id, short family)
+Rese=
tNameServers(PCWSTR itf_id, ADDRESS_FAMILY family)
 {
     return SetNameSe=
rversValue(itf_id, family, "");
 }
@@ -2042,7 +2027,7 @@
             offse=
t =3D strlen(addrs);
         }
 
-        err =3D SetNameServers(iid, msg-=
>family, addrs);
+        err =3D SetNameServersValue(iid, msg->family, add=
rs);
         if (err)
         {
             return err;
@@ -2103,10 +208=
8,10 @@
 static LSTATUS
 SetNameServerAddresses(PWSTR itf_id, const nrpt_ad=
dress_t *addresses)
 {
-    const short families[] =3D { AF_INET, AF_INET6 =
};
+    const ADDRESS_FAMILY families[] =3D { AF_INET, AF_INET6 };
     for=
 (size_t i =3D 0; i < _countof(families); i++)
     {
-        short family=
 =3D families[i];
+        ADDRESS_FAMILY family =3D families[i];
 
       =
  /* Create a comma sparated list of addresses of this family */
         s=
ize_t offset =3D 0;
@@ -2134,7 +2119,7 @@
         }
 
         /* Set name=
 server addresses */
-        LSTATUS err =3D SetNameServers(itf_id, family=
, addr_list);
+        LSTATUS err =3D SetNameServersValue(itf_id, family, =
addr_list);
         if (err)
         {
             return err;

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I225c21dbd843601b697fe71=
2b5b66c2a4f5c2ac2
Gerrit-Change-Number: 2342
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--sgs5+DvEdQM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld <strong>uploaded patch set #2</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">View=
 Change</a></p><p>The following approvals got outdated and were removed:
Co=
de-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Windows: Switch all us=
es of address family to ADDRESS_FAMILY type<br><br>Previously we had conver=
sion errors between short<br>and unsigned short=2E<br><br>Also remove usele=
ss SetNameServers wrapper=2E Wrapping<br>only a name is really not that use=
ful=2E<br><br>Add a definition for ADDRESS_FAMILY for cppcheck=2E<br>The bu=
ilt-in windows platform definition doesn&#39;t<br>cover it=2E<br><br>Change=
-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/openvpn-cppch=
eck-windows=2Ecfg<br>M include/openvpn-msg=2Eh<br>M src/openvpn/tun=2Ec<br>=
M src/openvpnserv/interactive=2Ec<br>4 files changed, 22 insertions(+), 36 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/42/2342/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/open=
vpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span=
><br><span>index dca2b07=2E=2E19d32a1 100644</span><br><span>--- a/dev-tool=
s/openvpn-cppcheck-windows=2Ecfg</span><br><span>+++ b/dev-tools/openvpn-cp=
pcheck-windows=2Ecfg</span><br><span>@@ -8,6 +8,7 @@</span><br><span>      =
 &lt;formatstr /&gt;</span><br><span>     &lt;/arg&gt;</span><br><span>   &=
lt;/function&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &=
lt;podtype name=3D&quot;ADDRESS_FAMILY&quot; sign=3D&quot;u&quot; size=3D&q=
uot;2&quot; /&gt;</span><br><span>   &lt;!-- MinGW uses GCC, so we need to =
handle GCC builtins=2E gnu=2Ecfg has these,</span><br><span>        but we =
do not load it for Windows=2E Without this cppcheck does not</span><br><spa=
n>        understand our likely()/unlikely() macros=2E --&gt;</span><br><sp=
an>diff --git a/include/openvpn-msg=2Eh b/include/openvpn-msg=2Eh</span><br=
><span>index ca3267e8=2E=2Edd20f7b 100644</span><br><span>--- a/include/ope=
nvpn-msg=2Eh</span><br><span>+++ b/include/openvpn-msg=2Eh</span><br><span>=
@@ -80,7 +80,7 @@</span><br><span> typedef struct</span><br><span> {</span>=
<br><span>     message_header_t header;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    short family;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ADDRESS_FAMILY family;</span><br><span>     inet_addres=
s_t address;</span><br><span>     int prefix_len;</span><br><span>     inte=
rface_t iface;</span><br><span>@@ -89,7 +89,7 @@</span><br><span> typedef s=
truct</span><br><span> {</span><br><span>     message_header_t header;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    short family;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</=
span><br><span>     inet_address_t prefix;</span><br><span>     int prefix_=
len;</span><br><span>     inet_address_t gateway;</span><br><span>@@ -102,7=
 +102,7 @@</span><br><span>     message_header_t header;</span><br><span>  =
   interface_t iface;</span><br><span>     char domains[512];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    short family;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</span><br>=
<span>     unsigned int addr_len;</span><br><span>     inet_address_t addr[=
4]; /* support up to 4 dns addresses */</span><br><span> } dns_cfg_message_=
t;</span><br><span>@@ -150,7 +150,7 @@</span><br><span> typedef struct</spa=
n><br><span> {</span><br><span>     message_header_t header;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    short family;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</span><br><=
span>     interface_t iface;</span><br><span> } flush_neighbors_message_t;<=
/span><br><span> </span><br><span>@@ -177,7 +177,7 @@</span><br><span> {</s=
pan><br><span>     message_header_t header;</span><br><span>     interface_=
t iface;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    short fam=
ily;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_FAM=
ILY family;</span><br><span>     int mtu;</span><br><span> } set_mtu_messag=
e_t;</span><br><span> </span><br><span>diff --git a/src/openvpn/tun=2Ec b/s=
rc/openvpn/tun=2Ec</span><br><span>index fe1af45=2E=2E65edf73 100644</span>=
<br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=
=2Ec</span><br><span>@@ -101,7 +101,7 @@</span><br><span> static void netsh=
_ifconfig(const struct tuntap_options *to, DWORD adapter_index, const in_ad=
dr_t ip,</span><br><span>                            const in_addr_t netmas=
k, const unsigned int flags);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static void windows_set_mtu(const int iface_index=
, const short family, const int mtu);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void windows_set_mtu(const int iface_index, const =
ADDRESS_FAMILY family, const int mtu);</span><br><span> </span><br><span> s=
tatic void netsh_set_dns6_servers(const struct in6_addr *addr_list, const u=
nsigned int addr_len,</span><br><span>                                    D=
WORD adapter_index);</span><br><span>@@ -118,7 +118,7 @@</span><br><span> #=
endif</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_address_service(const bool add, const sh=
ort family, const struct tuntap *tt)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+do_address_service(const bool add, const ADDRESS_FAMILY fa=
mily, const struct tuntap *tt)</span><br><span> {</span><br><span>     bool=
 ret =3D false;</span><br><span>     ack_message_t ack;</span><br><span>@@ =
-241,7 +241,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_dns_service=
(bool add, const short family, const struct tuntap *tt)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+do_dns_service(bool add, const ADDRESS_=
FAMILY family, const struct tuntap *tt)</span><br><span> {</span><br><span>=
     ack_message_t ack;</span><br><span>     struct gc_arena gc =3D gc_new(=
);</span><br><span>@@ -366,7 +366,7 @@</span><br><span> }</span><br><span> =
</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-do_set_mtu_service(const struct tuntap *tt, const short family, con=
st int mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_set_m=
tu_service(const struct tuntap *tt, const ADDRESS_FAMILY family, const int =
mtu)</span><br><span> {</span><br><span>     bool ret =3D false;</span><br>=
<span>     ack_message_t ack;</span><br><span>@@ -5320,7 +5320,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-windows_set_mtu(const int iface_index,=
 const short family, const int mtu)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+windows_set_mtu(const int iface_index, const ADDRESS_FAMILY=
 family, const int mtu)</span><br><span> {</span><br><span>     DWORD err =
=3D 0;</span><br><span>     MIB_IPINTERFACE_ROW ipiface;</span><br><span>di=
ff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2E=
c</span><br><span>index ad0fda2=2E=2Efb7463a 100644</span><br><span>--- a/s=
rc/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/intera=
ctive=2Ec</span><br><span>@@ -536,7 +536,7 @@</span><br><span> #endif</span=
><br><span> </span><br><span> static SOCKADDR_INET</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-sockaddr_inet(short family, const inet_address=
_t *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sockaddr_i=
net(ADDRESS_FAMILY family, const inet_address_t *addr)</span><br><span> {</=
span><br><span>     SOCKADDR_INET sa_inet;</span><br><span>     ZeroMemory(=
&amp;sa_inet, sizeof(sa_inet));</span><br><span>@@ -1865,7 +1865,7 @@</span=
><br><span>  * @return BOOL to indicate success or failure</span><br><span>=
  */</span><br><span> static BOOL</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-GetInterfacesKey(short family, PHKEY key)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+GetInterfacesKey(ADDRESS_FAMILY family, P=
HKEY key)</span><br><span> {</span><br><span>     PCSTR itfs_key =3D family=
 =3D=3D AF_INET6</span><br><span>                          ? &quot;SYSTEM\\=
CurrentControlSet\\Services\\Tcpip6\\Parameters\\Interfaces&quot;</span><br=
><span>@@ -1875,7 +1875,7 @@</span><br><span>     if (err)</span><br><span>=
     {</span><br><span>         *key =3D INVALID_HANDLE_VALUE;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&=
quot;%S: could not open interfaces registry key for family %d (%lu)&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLo=
g(M_SYSERR, L&quot;%S: could not open interfaces registry key for family %h=
u (%lu)&quot;,</span><br><span>                       __func__, family, err=
);</span><br><span>     }</span><br><span> </span><br><span>@@ -1892,7 +189=
2,7 @@</span><br><span>  * @return DWORD NO_ERROR on success, a Windows err=
or code otherwise</span><br><span>  */</span><br><span> static DWORD</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-SetNameServersValue(PCWSTR i=
tf_id, short family, PCSTR value)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family, PCS=
TR value)</span><br><span> {</span><br><span>     DWORD err;</span><br><spa=
n> </span><br><span>@@ -1906,7 +1906,7 @@</span><br><span>     err =3D RegO=
penKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &amp;itf);</span><br><span>     =
if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;%S: could not open interfa=
ce key for %s family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%S: could not open =
interface key for %s family %hu (%lu)&quot;,</span><br><span>              =
         __func__, itf_id, family, err);</span><br><span>         goto out;=
</span><br><span>     }</span><br><span>@@ -1914,7 +1914,7 @@</span><br><sp=
an>     err =3D RegSetValueExA(itf, &quot;NameServer&quot;, 0, REG_SZ, (PBY=
TE)value, (DWORD)strlen(value) + 1);</span><br><span>     if (err)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 MsgToEventLog(M_SYSERR, L&quot;%S: could not set name servers &#39;%S&#39;=
 for %s family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%S: could not set name se=
rvers &#39;%S&#39; for %s family %hu (%lu)&quot;,</span><br><span>         =
              __func__, value, itf_id, family, err);</span><br><span>     }=
</span><br><span> </span><br><span>@@ -1931,21 +1931,6 @@</span><br><span> =
}</span><br><span> </span><br><span> /**</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Set the DNS name servers in a registry interface conf=
iguration</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @param itf_id    the interfa=
ce id to set the servers for</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @param family    internet address family to set the servers for</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param addrs     com=
ma separated list of name server addresses</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @return DWORD NO_ERROR on success, a Windows error code otherwise</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-SetNameServers(PCWSTR itf_id, short family, PCSTR ad=
drs)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return SetNameServersValue(itf_id=
, family, addrs);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span>  * Delete all DNS name=
 servers from a registry interface configuration</span><br><span>  *</span>=
<br><span>  * @param itf_id    the interface id to clear the servers for</s=
pan><br><span>@@ -1954,7 +1939,7 @@</span><br><span>  * @return DWORD NO_ER=
ROR on success, a Windows error code otherwise</span><br><span>  */</span><=
br><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-ResetNameServers(PCWSTR itf_id, short family)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ResetNameServers(PCWSTR itf_id, ADDRESS_FAMILY f=
amily)</span><br><span> {</span><br><span>     return SetNameServersValue(i=
tf_id, family, &quot;&quot;);</span><br><span> }</span><br><span>@@ -2042,7=
 +2027,7 @@</span><br><span>             offset =3D strlen(addrs);</span><b=
r><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        err =3D SetNameServers(iid, msg-&gt;family, addrs);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D SetN=
ameServersValue(iid, msg-&gt;family, addrs);</span><br><span>         if (e=
rr)</span><br><span>         {</span><br><span>             return err;</sp=
an><br><span>@@ -2103,10 +2088,10 @@</span><br><span> static LSTATUS</span>=
<br><span> SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addre=
sses)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const short families[] =3D { AF_INET, AF_INET6 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const ADDRESS_FAMILY families[] =
=3D { AF_INET, AF_INET6 };</span><br><span>     for (size_t i =3D 0; i &lt;=
 _countof(families); i++)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        short family =3D families[i];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        ADDRESS_FAMILY family =
=3D families[i];</span><br><span> </span><br><span>         /* Create a com=
ma sparated list of addresses of this family */</span><br><span>         si=
ze_t offset =3D 0;</span><br><span>@@ -2134,7 +2119,7 @@</span><br><span>  =
       }</span><br><span> </span><br><span>         /* Set name server addr=
esses */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        LSTAT=
US err =3D SetNameServers(itf_id, family, addr_list);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        LSTATUS err =3D SetNameServersVal=
ue(itf_id, family, addr_list);</span><br><span>         if (err)</span><br>=
<span>         {</span><br><span>             return err;</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342=
?usp=3Demail">change 2342</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2342?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2342 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--sgs5+DvEdQM=--


--===============0288890557990998410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0288890557990998410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0288890557990998410==--

