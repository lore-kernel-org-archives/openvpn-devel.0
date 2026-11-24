Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E197606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=la8H/m5H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AC0QbmMS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O3upMIKf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ut33QV5a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=6/FDQlexTqavQ34R0/M7SGBH5rdMzcZb0h1/PxLN7+s=; b=la8H/m5HMle/vEAHxfwSsDqgit
	Aj/l66PIEnIEPD6yRny9C2PZbDOzIHWE9YwTmMXEzaG8VdQAdQaoBZKnespONJuS9MT3sxZPtEeFq
	kYKukabuxTkD5Ml2JUUaLdfkU8Opo2qSlhr2lloOlMtA/QgEgRpz5hblCY06fvqtprcI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xW00c-000000003Kl-3czW;
	Tue, 24 Nov 2026 23:33:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xW00b-000000003Kd-1WuU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 23:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KLBFQOBD6IVe6RWwpy39XiPn78C1viTZqAW2zx0w86g=; b=AC0QbmMSWdTUxukMFOv95z2ET3
 5Eh4X8wycBX/ReAM7hsUayvwW49jiUTH+2L5H62ek4BwXXNnm7s80ucjx4T0lvv1xMLrdhdUoq0Ne
 K4y9Vy17LBUwOJ5v25yahi/V+Wj3o7kKsH6B5nUpxdFuScsBdFV6fQuik9ZdDoPRjMeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KLBFQOBD6IVe6RWwpy39XiPn78C1viTZqAW2zx0w86g=; b=O3upMIKfuXunsWz92lu5mXgKxM
 CVAfwOZlaNhY0P/IhdYphqv7I4hpnSTnT4gAK4OJ+iJ2J7TEgJDu2aQBCuWOpAmzgBGQMZY+gkryw
 wuiyvUMHSHc7lwfSjz7YdNnPoki14wD3tGSDnoN0HhToc3QZN0LM1ievfKdQGJMr2Xm0=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xW00Z-000000000rd-3H5w for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 23:33:09 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so2929243f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 15:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795563181; x=1796167981; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KLBFQOBD6IVe6RWwpy39XiPn78C1viTZqAW2zx0w86g=;
 b=Ut33QV5aNaUcsJQWMASjUleAyiC0Y2vHy2PFJW2YWKAMlz1C4+ZNI22YQkY04euRMU
 F1X32yGTOkphFWFabQMSZ7PsC24sr5FyYDVY1QzNE6qE7llD2jjXUw0n5epRi/s3ai/u
 efPg/YEE3zJdMwCBOOdC91SEATHOKS0gwzWzO0NiHFn0DIor1utQ9UsGABOKQsbiI4TN
 n75Fmyk0twyiAmurunUlW+prj0f5UAcyR3G4zuoaukc7InM155pOJhRT0w4yAO4TqQdY
 vlSkt66AdNVr2HulQ0/em1jo3KGB5fsfpWh7kCbtez2nhk6QKuVzgRUeRG/E+yMPSIoe
 JLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795563181; x=1796167981;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLBFQOBD6IVe6RWwpy39XiPn78C1viTZqAW2zx0w86g=;
 b=frktzz5Vqm7Xr/Nqo+F/W0hiDZpt0pELFB+H22EWWuzqLlT6wuNs/+Tjb8AqH/ndcA
 SX4pqv/GoQqe6qXx9bO7Ulb0XmxrX5QqTSYuiF+AX1dQAuf+lrvzy6TH8S0B8kyQCn3J
 v43/6N/KEibd7nHcUdaHlKJNq6ofrkHPhxzI2uGPfnecGOxMxl39kE5BwdJ5kJeXMiVL
 WLwmCVcHSCNHjObSt05pLnDBGC7THxE44eAQQbBMLZ7E6WMF8EdsJ9SQd72YsnsOx73+
 Y3zpHi5fwHUpIHpcbBGDq22Mb8/R8XIK5Bul9hiM4COMtbPELbM1PKNyJAQub+B/yz/6
 /ohw==
X-Gm-Message-State: APuU4Z/KqipXGbquKNgkf4DoeEzekQMk0ZUzqoYuX/07B2XEl4Ir6kep
 tvmJAeofxOdZPpD0/2cpZtSZJg0SdHmjc2LRDRYMUWQjSjPTJqOURZ+U8s9tGpMVTk/5+CB2Upo
 8bdnwfSCt8XNgYjTYMWTAw16mfK0xafPBtPWSla514IUimWU5kxjkjBQAurL4zogWCy3T4P3B3z
 wtvNoclA==
X-Gm-Gg: AZFdTZcSaXh7PNP4qEmC0GGNNKcwNaYO4y5lCf12elXwb8eA3bIGbiV45CHJgonwB5a
 93jIqFl8XZcqRDYFfaQYYqh6tcjT6dteU4JF9u8v3xz+vabq1O6bPmkwJsJOGz1/t/AQ/cifRW+
 C0idZWTtAEqFJZc1a5h7bl3t5pHgPWz6lflOxyxcSIzspo6DrDbhNFB4hOFYLEyo8aCqfzWptQE
 6qV4B++6BA4wAocds/ZpOccRsgxAWebCahwvCm+2th/3Qa/ADKX4wyyM3FDvU9jvRvjW9IX6bGh
 Cyl4NzZHtZlCDHu1WnTws6M2esU0G9c5sGLJZ2C7qkbPdxYnMH1H2Xt7/f7byPBb+jQkHDbQdST
 mfVZmvoNvtJD0Dp/YzyRgmE/lkZM0myf7G81LLEouRx157ddMixGdIS9BJzvhYUYiin6SLygC8J
 4/datH8d2Fha5Eh5bcgk5YDiIr1S193N1DYs+elGzTdSFkNQQeZDPV3tcsi+CE3pzHCWNsA0ILe
 aFQNLtY8XoaAgY/82DPwP1Sp9WzSiPdTQl6D143TRnHhsPUpJhdPYn93bBBTBRzr222duOpwGzB
 0gLUh+1yMn6WABgBeFxtwN1SNba8niH/ZSM+DPLvFnlHdIN6NYJGUs/AV7w5iMFnkyQduCj2gOD
 Grj3Ths78t5Dt0qVPuOyQ6mIW3fSz0KO35CAGLeTrdTMmVt4QYE39wYBb8bpnqWNDyQTgYmqxmd
 nsnnFvcvP5DJg/axHy
X-Received: by 2002:a05:6000:26ca:b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-4abb0f3c225mr29994119f8f.17.1795563180928; 
 Tue, 24 Nov 2026 15:33:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b1ebsm32190996f8f.33.2026.11.24.15.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 15:33:00 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 23:33:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: 5aeb3a3f993032b6f77be9c1303a767720a0897b
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8d9dbb9ed05832fefbaf302b80155c9c9c6482d4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xW00Z-000000000rd-3H5w
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1329974629158773147=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1329974629158773147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/XgoukA3Oic="; charset=UTF-8

--/XgoukA3Oic=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2342?usp=3Demail

to review the following change=2E
=


Change subject: Windows: Switch all uses of address family to ADDRESS_FAM=
ILY type
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Wind=
ows: Switch all uses of address family to ADDRESS_FAMILY type

Previously w=
e had conversion errors between short
and unsigned short=2E

Also remove us=
eless SetNameServers wrapper=2E Wrapping
only a name is really not that use=
ful=2E

Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
Signed-off-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M include/openvpn-msg=2Eh
=
M src/openvpn/tun=2Ec
M src/openvpnserv/interactive=2Ec
3 files changed, 20=
 insertions(+), 35 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/42/2342/1

diff --git a/include/openvpn-msg=2Eh =
b/include/openvpn-msg=2Eh
index ca3267e8=2E=2Edd20f7b 100644
--- a/include/=
openvpn-msg=2Eh
+++ b/include/openvpn-msg=2Eh
@@ -80,7 +80,7 @@
 typedef st=
ruct
 {
     message_header_t header;
-    short family;
+    ADDRESS_FAMIL=
Y family;
     inet_address_t address;
     int prefix_len;
     interface_=
t iface;
@@ -89,7 +89,7 @@
 typedef struct
 {
     message_header_t header;=

-    short family;
+    ADDRESS_FAMILY family;
     inet_address_t prefix;=

     int prefix_len;
     inet_address_t gateway;
@@ -102,7 +102,7 @@
    =
 message_header_t header;
     interface_t iface;
     char domains[512];
-=
    short family;
+    ADDRESS_FAMILY family;
     unsigned int addr_len;
 =
    inet_address_t addr[4]; /* support up to 4 dns addresses */
 } dns_cfg_=
message_t;
@@ -150,7 +150,7 @@
 typedef struct
 {
     message_header_t hea=
der;
-    short family;
+    ADDRESS_FAMILY family;
     interface_t iface;=

 } flush_neighbors_message_t;
 
@@ -177,7 +177,7 @@
 {
     message_header=
_t header;
     interface_t iface;
-    short family;
+    ADDRESS_FAMILY f=
amily;
     int mtu;
 } set_mtu_message_t;
 
diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec
index fe1af45=2E=2E65edf73 100644
--- a/src/open=
vpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -101,7 +101,7 @@
 static void nets=
h_ifconfig(const struct tuntap_options *to, DWORD adapter_index, const in_a=
ddr_t ip,
                            const in_addr_t netmask, const unsign=
ed int flags);
 
-static void windows_set_mtu(const int iface_index, const =
short family, const int mtu);
+static void windows_set_mtu(const int iface_=
index, const ADDRESS_FAMILY family, const int mtu);
 
 static void netsh_se=
t_dns6_servers(const struct in6_addr *addr_list, const unsigned int addr_le=
n,
                                    DWORD adapter_index);
@@ -118,7 +118=
,7 @@
 #endif
 
 static bool
-do_address_service(const bool add, const shor=
t family, const struct tuntap *tt)
+do_address_service(const bool add, cons=
t ADDRESS_FAMILY family, const struct tuntap *tt)
 {
     bool ret =3D fals=
e;
     ack_message_t ack;
@@ -241,7 +241,7 @@
 }
 
 static void
-do_dns_se=
rvice(bool add, const short family, const struct tuntap *tt)
+do_dns_servic=
e(bool add, const ADDRESS_FAMILY family, const struct tuntap *tt)
 {
     a=
ck_message_t ack;
     struct gc_arena gc =3D gc_new();
@@ -366,7 +366,7 @@=

 }
 
 static bool
-do_set_mtu_service(const struct tuntap *tt, const short=
 family, const int mtu)
+do_set_mtu_service(const struct tuntap *tt, const =
ADDRESS_FAMILY family, const int mtu)
 {
     bool ret =3D false;
     ack_=
message_t ack;
@@ -5320,7 +5320,7 @@
 }
 
 static void
-windows_set_mtu(con=
st int iface_index, const short family, const int mtu)
+windows_set_mtu(con=
st int iface_index, const ADDRESS_FAMILY family, const int mtu)
 {
     DWO=
RD err =3D 0;
     MIB_IPINTERFACE_ROW ipiface;
diff --git a/src/openvpnser=
v/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index be57d43=2E=2E39f0=
7eb 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/inte=
ractive=2Ec
@@ -536,7 +536,7 @@
 #endif
 
 static SOCKADDR_INET
-sockaddr_i=
net(short family, const inet_address_t *addr)
+sockaddr_inet(ADDRESS_FAMILY=
 family, const inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     Ze=
roMemory(&sa_inet, sizeof(sa_inet));
@@ -1865,7 +1865,7 @@
  * @return BOOL=
 to indicate success or failure
  */
 static BOOL
-GetInterfacesKey(short f=
amily, PHKEY key)
+GetInterfacesKey(ADDRESS_FAMILY family, PHKEY key)
 {
  =
   PCSTR itfs_key =3D family =3D=3D AF_INET6
                          ? "S=
YSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters\\Interfaces"
@@ -189=
2,7 +1892,7 @@
  * @return DWORD NO_ERROR on success, a Windows error code =
otherwise
  */
 static DWORD
-SetNameServersValue(PCWSTR itf_id, short fami=
ly, PCSTR value)
+SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family,=
 PCSTR value)
 {
     DWORD err;
 
@@ -1906,7 +1906,7 @@
     err =3D RegOp=
enKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
     if (err)
     {
-    =
    MsgToEventLog(M_SYSERR, L"%S: could not open interface key for %s famil=
y %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not open interfac=
e key for %s family %d (%ld)",
                       __func__, itf_id, fam=
ily, err);
         goto out;
     }
@@ -1914,7 +1914,7 @@
     err =3D Reg=
SetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, (DWORD)strlen(value=
) + 1);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%S: could n=
ot set name servers '%S' for %s family %d (%lu)",
+        MsgToEventLog(M_=
SYSERR, L"%S: could not set name servers '%S' for %s family %d (%ld)",
    =
                   __func__, value, itf_id, family, err);
     }
 
@@ -1931=
,21 +1931,6 @@
 }
 
 /**
- * Set the DNS name servers in a registry interfa=
ce configuration
- *
- * @param itf_id    the interface id to set the serve=
rs for
- * @param family    internet address family to set the servers for
=
- * @param addrs     comma separated list of name server addresses
- *
- * =
@return DWORD NO_ERROR on success, a Windows error code otherwise
- */
-sta=
tic DWORD
-SetNameServers(PCWSTR itf_id, short family, PCSTR addrs)
-{
-   =
 return SetNameServersValue(itf_id, family, addrs);
-}
-
-/**
  * Delete al=
l DNS name servers from a registry interface configuration
  *
  * @param i=
tf_id    the interface id to clear the servers for
@@ -1954,7 +1939,7 @@
  =
* @return DWORD NO_ERROR on success, a Windows error code otherwise
  */
 s=
tatic DWORD
-ResetNameServers(PCWSTR itf_id, short family)
+ResetNameServer=
s(PCWSTR itf_id, ADDRESS_FAMILY family)
 {
     return SetNameServersValue(=
itf_id, family, "");
 }
@@ -2042,7 +2027,7 @@
             offset =3D strle=
n(addrs);
         }
 
-        err =3D SetNameServers(iid, msg->family, ad=
drs);
+        err =3D SetNameServersValue(iid, msg->family, addrs);
      =
   if (err)
         {
             return err;
@@ -2103,10 +2088,10 @@
 st=
atic LSTATUS
 SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *ad=
dresses)
 {
-    const short families[] =3D { AF_INET, AF_INET6 };
+    con=
st ADDRESS_FAMILY families[] =3D { AF_INET, AF_INET6 };
     for (size_t i =
=3D 0; i < _countof(families); i++)
     {
-        short family =3D famili=
es[i];
+        ADDRESS_FAMILY family =3D families[i];
 
         /* Create=
 a comma sparated list of addresses of this family */
         size_t offse=
t =3D 0;
@@ -2134,7 +2119,7 @@
         }
 
         /* Set name server add=
resses */
-        LSTATUS err =3D SetNameServers(itf_id, family, addr_list=
);
+        LSTATUS err =3D SetNameServersValue(itf_id, family, addr_list);=

         if (err)
         {
             return err;

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c=
2ac2
Gerrit-Change-Number: 2342
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/XgoukA3Oic=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Windows: Switch all uses of address family to ADDRESS_FAMI=
LY type<br><br>Previously we had conversion errors between short<br>and uns=
igned short=2E<br><br>Also remove useless SetNameServers wrapper=2E Wrappin=
g<br>only a name is really not that useful=2E<br><br>Change-Id: I225c21dbd8=
43601b697fe712b5b66c2a4f5c2ac2<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt;<br>---<br>M include/openvpn-msg=2Eh<br>M src/openvp=
n/tun=2Ec<br>M src/openvpnserv/interactive=2Ec<br>3 files changed, 20 inser=
tions(+), 35 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/2342/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
include/openvpn-msg=2Eh b/include/openvpn-msg=2Eh</span><br><span>index ca3=
267e8=2E=2Edd20f7b 100644</span><br><span>--- a/include/openvpn-msg=2Eh</sp=
an><br><span>+++ b/include/openvpn-msg=2Eh</span><br><span>@@ -80,7 +80,7 @=
@</span><br><span> typedef struct</span><br><span> {</span><br><span>     m=
essage_header_t header;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    short family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ADDRESS_FAMILY family;</span><br><span>     inet_address_t address;</sp=
an><br><span>     int prefix_len;</span><br><span>     interface_t iface;</=
span><br><span>@@ -89,7 +89,7 @@</span><br><span> typedef struct</span><br>=
<span> {</span><br><span>     message_header_t header;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    short family;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</span><br><span> =
    inet_address_t prefix;</span><br><span>     int prefix_len;</span><br><=
span>     inet_address_t gateway;</span><br><span>@@ -102,7 +102,7 @@</span=
><br><span>     message_header_t header;</span><br><span>     interface_t i=
face;</span><br><span>     char domains[512];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    short family;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</span><br><span>     unsig=
ned int addr_len;</span><br><span>     inet_address_t addr[4]; /* support u=
p to 4 dns addresses */</span><br><span> } dns_cfg_message_t;</span><br><sp=
an>@@ -150,7 +150,7 @@</span><br><span> typedef struct</span><br><span> {</=
span><br><span>     message_header_t header;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    short family;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ADDRESS_FAMILY family;</span><br><span>     interf=
ace_t iface;</span><br><span> } flush_neighbors_message_t;</span><br><span>=
 </span><br><span>@@ -177,7 +177,7 @@</span><br><span> {</span><br><span>  =
   message_header_t header;</span><br><span>     interface_t iface;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    short family;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</spa=
n><br><span>     int mtu;</span><br><span> } set_mtu_message_t;</span><br><=
span> </span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=
=2Ec</span><br><span>index fe1af45=2E=2E65edf73 100644</span><br><span>--- =
a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><=
span>@@ -101,7 +101,7 @@</span><br><span> static void netsh_ifconfig(const =
struct tuntap_options *to, DWORD adapter_index, const in_addr_t ip,</span><=
br><span>                            const in_addr_t netmask, const unsigne=
d int flags);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static void windows_set_mtu(const int iface_index, const short fa=
mily, const int mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void windows_set_mtu(const int iface_index, const ADDRESS_FAMILY f=
amily, const int mtu);</span><br><span> </span><br><span> static void netsh=
_set_dns6_servers(const struct in6_addr *addr_list, const unsigned int addr=
_len,</span><br><span>                                    DWORD adapter_ind=
ex);</span><br><span>@@ -118,7 +118,7 @@</span><br><span> #endif</span><br>=
<span> </span><br><span> static bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-do_address_service(const bool add, const short family, const=
 struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
do_address_service(const bool add, const ADDRESS_FAMILY family, const struc=
t tuntap *tt)</span><br><span> {</span><br><span>     bool ret =3D false;</=
span><br><span>     ack_message_t ack;</span><br><span>@@ -241,7 +241,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-do_dns_service(bool add, const =
short family, const struct tuntap *tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+do_dns_service(bool add, const ADDRESS_FAMILY family, co=
nst struct tuntap *tt)</span><br><span> {</span><br><span>     ack_message_=
t ack;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><spa=
n>@@ -366,7 +366,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_set_mt=
u_service(const struct tuntap *tt, const short family, const int mtu)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+do_set_mtu_service(const =
struct tuntap *tt, const ADDRESS_FAMILY family, const int mtu)</span><br><s=
pan> {</span><br><span>     bool ret =3D false;</span><br><span>     ack_me=
ssage_t ack;</span><br><span>@@ -5320,7 +5320,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-windows_set_mtu(const int iface_index, const short fami=
ly, const int mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+w=
indows_set_mtu(const int iface_index, const ADDRESS_FAMILY family, const in=
t mtu)</span><br><span> {</span><br><span>     DWORD err =3D 0;</span><br><=
span>     MIB_IPINTERFACE_ROW ipiface;</span><br><span>diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>=
index be57d43=2E=2E39f07eb 100644</span><br><span>--- a/src/openvpnserv/int=
eractive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><b=
r><span>@@ -536,7 +536,7 @@</span><br><span> #endif</span><br><span> </span=
><br><span> static SOCKADDR_INET</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-sockaddr_inet(short family, const inet_address_t *addr)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+sockaddr_inet(ADDRESS_FAMILY=
 family, const inet_address_t *addr)</span><br><span> {</span><br><span>   =
  SOCKADDR_INET sa_inet;</span><br><span>     ZeroMemory(&amp;sa_inet, size=
of(sa_inet));</span><br><span>@@ -1865,7 +1865,7 @@</span><br><span>  * @re=
turn BOOL to indicate success or failure</span><br><span>  */</span><br><sp=
an> static BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-GetInt=
erfacesKey(short family, PHKEY key)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+GetInterfacesKey(ADDRESS_FAMILY family, PHKEY key)</span><b=
r><span> {</span><br><span>     PCSTR itfs_key =3D family =3D=3D AF_INET6</=
span><br><span>                          ? &quot;SYSTEM\\CurrentControlSet\=
\Services\\Tcpip6\\Parameters\\Interfaces&quot;</span><br><span>@@ -1892,7 =
+1892,7 @@</span><br><span>  * @return DWORD NO_ERROR on success, a Windows=
 error code otherwise</span><br><span>  */</span><br><span> static DWORD</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-SetNameServersValue(PCWS=
TR itf_id, short family, PCSTR value)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family,=
 PCSTR value)</span><br><span> {</span><br><span>     DWORD err;</span><br>=
<span> </span><br><span>@@ -1906,7 +1906,7 @@</span><br><span>     err =3D =
RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &amp;itf);</span><br><span> =
    if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;%S: could not open int=
erface key for %s family %d (%lu)&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%S: could not o=
pen interface key for %s family %d (%ld)&quot;,</span><br><span>           =
            __func__, itf_id, family, err);</span><br><span>         goto o=
ut;</span><br><span>     }</span><br><span>@@ -1914,7 +1914,7 @@</span><br>=
<span>     err =3D RegSetValueExA(itf, &quot;NameServer&quot;, 0, REG_SZ, (=
PBYTE)value, (DWORD)strlen(value) + 1);</span><br><span>     if (err)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    MsgToEventLog(M_SYSERR, L&quot;%S: could not set name servers &#39;%S&#=
39; for %s family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%S: could not set name=
 servers &#39;%S&#39; for %s family %d (%ld)&quot;,</span><br><span>       =
                __func__, value, itf_id, family, err);</span><br><span>    =
 }</span><br><span> </span><br><span>@@ -1931,21 +1931,6 @@</span><br><span=
> }</span><br><span> </span><br><span> /**</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Set the DNS name servers in a registry interface co=
nfiguration</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param itf_id    the inter=
face id to set the servers for</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param family    internet address family to set the servers for=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param addrs     c=
omma separated list of name server addresses</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @return DWORD NO_ERROR on success, a Windows error code otherwise</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-SetNameServers(PCWSTR itf_id, short family, PCSTR a=
ddrs)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return SetNameServersValue(itf_i=
d, family, addrs);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
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

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2342 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--/XgoukA3Oic=--


--===============1329974629158773147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1329974629158773147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1329974629158773147==--

