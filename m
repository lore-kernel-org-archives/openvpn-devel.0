Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484A606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MF76gnDb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kv4va7bB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bwnK0BIy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bcg4Nisq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nUKZ1DpBfXw4FxemZ5Z/aIRji2plUqPVJKn4U8hXOF4=; b=MF76gnDbZdlsUv4g9pB5NGR4Fg
	Ru1c4Fidz51FNPDiLf2EDO/oEQFeQVvcdJlXxi83UAe3Karj1dxs6rhJcDfneCEGJHlyYdMGY1QhM
	h4uCOXx6JwHCiPaXRaWIBT6vCoaOyXjFuS7ostl4HVdFe8JvQZH+rCM0O2EfxzemQGIU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXlg-000000007PH-2LKs;
	Thu, 26 Nov 2026 11:36:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXld-000000007P8-2Cg4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:35:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qEbPeXOUH/dsnMeOMV691VMeTMepXGeu+BohngKkdw=; b=Kv4va7bBGfP06s8IE4PUjN1Yjc
 ToW4rpfTXYkbaqgGNnBQVJnz9ViGsLjxn18i6usyG5A7I3sYTfm9S2ZUJjTuug5zn2jAoEXsLIuiO
 91fet6E7CsH5j6jg0tPLPAElg9jiI59HoVZRmY1kevjm7se1DOI9lzlGqQnSxGZebgyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qEbPeXOUH/dsnMeOMV691VMeTMepXGeu+BohngKkdw=; b=bwnK0BIyLX+OOPtj6jxBb4K9+r
 KcuDSAhn45QidKZpXBZikvICkWqasjEZhYgYEOwkhPYhHIywGQ6S3SOoqRmBue8ktbvtv7k+I1q0F
 Nu2pWt180vSUS2f6NIeU9SPgVt/QfxYfIcaPtL789upoX7KnefrjNDFN8ZpflsEm5KWk=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXlb-000000000cD-2agi for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:35:57 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so73522565e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795692949; x=1796297749; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4qEbPeXOUH/dsnMeOMV691VMeTMepXGeu+BohngKkdw=;
 b=bcg4NisqDL90bG21B5+n9HcVP1rwJM8EYCioL5JCYDX1xVr0cvb5vYTGrNygGOmRil
 d+urUt7XRuejclyLyQ60Vaxta608Bszb9lyFoQGggEYyodwv7jUhMWzxRbaAnIEN8ODS
 CAaOCfy7FXdUhX29rH8sUL0xuffgqmeLqbXFiAA+VD5VOFJYDneuJLM3kZsxRRWnt03A
 ticlar50f8t05OjbtNO06ygL4kD3875dhd7fsEIwd1aK7j9gLpfm6iDcXCbt6wEmxK3J
 rN3SgGJbj49dNIn+F2fwKJXysPFircrlFmxtPyCJhuqQGPzS97WvgvSU2VjJbgGO6UH6
 qv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795692949; x=1796297749;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4qEbPeXOUH/dsnMeOMV691VMeTMepXGeu+BohngKkdw=;
 b=gTrbTZ9Ek98y/wo0R/kbJrQK59hixaYyVtfQf0AGTuAO8ql4C6qxO+6s3InV2uc58e
 3SmwU3Dr6pYTz/oKfCo27rz+cNQPIAjA1jpfIdjZro0tZ3lRX7KZ9063TKmSWD4XWDPT
 7ynZsH1FSxjUmZ4N0gbVXGX2qOnOOPMKv0eHptgfERoMXuvn4OAYV932nc6kZEtJnZAQ
 EUP2YduSPC4XFEYO9lPjPL83U7SXBpuzRXvbKKyfAXYp8kMf58R6EiL+MAnJOP6Fh18D
 6l6z17uodaaahaXZLkc17MtV2qLn+VELTKspFzZ48Tq1xHjBhZCinhZLP80HZHf2Dzh2
 DfRA==
X-Forwarded-Encrypted: i=1;
 AL+hErHXc6WAfGE7BVmGVRIYpf6yd57NM6X3LGTSuM/y6+CHN67vW2tI0P1OefOvTGU8Uk5FziO3SbaofUpVWDZ0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9qa9hEFxp8qO1mqxuv3k7ElP9Mx5IAqrXvwRweCeXY0YWFQDZh
 Fu30yr2Ukaiz1MgyXZDnv9crSDYSjsu5P+ZfbFROELFYqXUmKkys9lcshYataqTi64+fc60EBII
 O+HBmj/I6g8108XBHaEtsga+8V/eE0uWtvPdARLlicLAC0wkmG6gKiK8QoTe1Aqcu3oSRfjFzV2
 /HDAC6SQ==
X-Gm-Gg: AZFdTZe6fEF2JqhCxK0GBudUbljkeatKgLrAazDjcoL2R8mDK+qebNr2TGpcdwpxTS3
 pLj8HZ9g0vN05ujPnbiav+y36uYiW8T7zyzgjxz9LgqDDUVKSN607F2Ohktz3Lg5XLkezw6pme8
 UZCFj1kvc7u5mxZWVaMZSRa9T/9ucrFeHYBnN72yz5qienPhTZChu8nTNDLFJGeIaKIkhFmX0Vp
 fERdMwOdhhtUOwIQvumX6GVgQrjml+1DZA8YDCc2iDogq+1xiHTNorob2CEZyVxn9Kw1JIK+yN6
 9xNucmxC/H+qILixoDSwpp6hSXPKLLbVkmFzvywpRoOFuuHSErCCLAxtbaNMvWmoyfxBg1GT6Mj
 Q4hBdwEU2wXUL0cb7bYFgsgb6pyq/Alj+JbXa6LhAePn+OfnLzQsgxjROVl6hbt57aCnxJCtafJ
 wyknC6txP/l6bpQppBGhKFnHJ9STmvHyNWHRd51VoFWSbk1QYaoyUnho4LfDw5q6E5AKYwWHFJO
 tw/wOhUZSoAg9F8hWWTQ3Pf+QgcUdm3oPkux7n6eKJ+7JNEtdeLeno0nGTqZBW89IodOpS33fad
 zxRB5y1b8j76AtdLNyH3XXKFXZfluUqy3aT9u1iXgxJbzs+c9kS1GatE3zxTjPf4rSG6fDojyei
 kxPizpT7LSY+lwJ2WdXxxRDlz8uOnMAVQyPf8UUcAUwBTDFETvPTseW9qZNcPogo3/QMTvMsGYj
 86/Kov2GuhdhF8IBY=
X-Received: by 2002:a05:600c:8210:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4bb887e25e8mr414733475e9.2.1795692948867; 
 Thu, 26 Nov 2026 03:35:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm573138265e9.8.2026.11.26.03.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:35:48 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:35:48 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: cd9a867eae0bf147107a388a8d7d22aa4f4b1c77
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71ae0c0aafb37f0c8f7feddc4c21cacb651e392c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWXlb-000000000cD-2agi
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1227843356641886410=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1227843356641886410==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uYoBn4B5PME="; charset=UTF-8

--uYoBn4B5PME=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2342?usp=3Demail )

Change subject: Windows: Switch all uses of=
 address family to ADDRESS_FAMILY type
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Windows: Switch all uses of address family to ADD=
RESS_FAMILY type

Previously we had conversion errors between short
and uns=
igned short=2E

Also remove useless SetNameServers wrapper=2E Wrapping
only=
 a name is really not that useful=2E

Add a definition for ADDRESS_FAMILY f=
or cppcheck=2E
The built-in windows platform definition doesn't
cover it=2E=


Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342
M=
essage-Id: <20261125173055=2E23341-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41952=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-too=
ls/openvpn-cppcheck-windows=2Ecfg
M include/openvpn-msg=2Eh
M src/openvpn/t=
un=2Ec
M src/openvpnserv/interactive=2Ec
4 files changed, 22 insertions(+),=
 36 deletions(-)




diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg =
b/dev-tools/openvpn-cppcheck-windows=2Ecfg
index dca2b07=2E=2E19d32a1 10064=
4
--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg
+++ b/dev-tools/openvpn-cp=
pcheck-windows=2Ecfg
@@ -8,6 +8,7 @@
       <formatstr />
     </arg>
   </=
function>
+  <podtype name=3D"ADDRESS_FAMILY" sign=3D"u" size=3D"2" />
   <=
!-- MinGW uses GCC, so we need to handle GCC builtins=2E gnu=2Ecfg has thes=
e,
        but we do not load it for Windows=2E Without this cppcheck does =
not
        understand our likely()/unlikely() macros=2E -->
diff --git a/i=
nclude/openvpn-msg=2Eh b/include/openvpn-msg=2Eh
index ca3267e8=2E=2Edd20f7=
b 100644
--- a/include/openvpn-msg=2Eh
+++ b/include/openvpn-msg=2Eh
@@ -80=
,7 +80,7 @@
 typedef struct
 {
     message_header_t header;
-    short fam=
ily;
+    ADDRESS_FAMILY family;
     inet_address_t address;
     int pref=
ix_len;
     interface_t iface;
@@ -89,7 +89,7 @@
 typedef struct
 {
     m=
essage_header_t header;
-    short family;
+    ADDRESS_FAMILY family;
    =
 inet_address_t prefix;
     int prefix_len;
     inet_address_t gateway;
@=
@ -102,7 +102,7 @@
     message_header_t header;
     interface_t iface;
  =
   char domains[512];
-    short family;
+    ADDRESS_FAMILY family;
     u=
nsigned int addr_len;
     inet_address_t addr[4]; /* support up to 4 dns a=
ddresses */
 } dns_cfg_message_t;
@@ -150,7 +150,7 @@
 typedef struct
 {
  =
   message_header_t header;
-    short family;
+    ADDRESS_FAMILY family;
=
     interface_t iface;
 } flush_neighbors_message_t;
 
@@ -177,7 +177,7 @@=

 {
     message_header_t header;
     interface_t iface;
-    short family=
;
+    ADDRESS_FAMILY family;
     int mtu;
 } set_mtu_message_t;
 
diff --=
git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index fe1af45=2E=2E65edf73 =
100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -101,7 +101,7=
 @@
 static void netsh_ifconfig(const struct tuntap_options *to, DWORD adap=
ter_index, const in_addr_t ip,
                            const in_addr_t =
netmask, const unsigned int flags);
 
-static void windows_set_mtu(const in=
t iface_index, const short family, const int mtu);
+static void windows_set=
_mtu(const int iface_index, const ADDRESS_FAMILY family, const int mtu);
 
=
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const=
 unsigned int addr_len,
                                    DWORD adapter_i=
ndex);
@@ -118,7 +118,7 @@
 #endif
 
 static bool
-do_address_service(const=
 bool add, const short family, const struct tuntap *tt)
+do_address_service=
(const bool add, const ADDRESS_FAMILY family, const struct tuntap *tt)
 {
 =
    bool ret =3D false;
     ack_message_t ack;
@@ -241,7 +241,7 @@
 }
 
 s=
tatic void
-do_dns_service(bool add, const short family, const struct tunta=
p *tt)
+do_dns_service(bool add, const ADDRESS_FAMILY family, const struct =
tuntap *tt)
 {
     ack_message_t ack;
     struct gc_arena gc =3D gc_new()=
;
@@ -366,7 +366,7 @@
 }
 
 static bool
-do_set_mtu_service(const struct tu=
ntap *tt, const short family, const int mtu)
+do_set_mtu_service(const stru=
ct tuntap *tt, const ADDRESS_FAMILY family, const int mtu)
 {
     bool ret=
 =3D false;
     ack_message_t ack;
@@ -5320,7 +5320,7 @@
 }
 
 static void=

-windows_set_mtu(const int iface_index, const short family, const int mtu)=

+windows_set_mtu(const int iface_index, const ADDRESS_FAMILY family, const=
 int mtu)
 {
     DWORD err =3D 0;
     MIB_IPINTERFACE_ROW ipiface;
diff -=
-git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
in=
dex 77b91e0=2E=2Ed155fd6 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b=
/src/openvpnserv/interactive=2Ec
@@ -529,7 +529,7 @@
 #endif
 
 static SOCK=
ADDR_INET
-sockaddr_inet(short family, const inet_address_t *addr)
+sockadd=
r_inet(ADDRESS_FAMILY family, const inet_address_t *addr)
 {
     SOCKADDR_=
INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
@@ -1858,7 +1858,=
7 @@
  * @return BOOL to indicate success or failure
  */
 static BOOL
-Get=
InterfacesKey(short family, PHKEY key)
+GetInterfacesKey(ADDRESS_FAMILY fam=
ily, PHKEY key)
 {
     PCSTR itfs_key =3D family =3D=3D AF_INET6
         =
                 ? "SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters=
\\Interfaces"
@@ -1868,7 +1868,7 @@
     if (err)
     {
         *key =3D =
INVALID_HANDLE_VALUE;
-        MsgToEventLog(M_SYSERR, L"%S: could not open=
 interfaces registry key for family %d (%lu)",
+        MsgToEventLog(M_SYS=
ERR, L"%S: could not open interfaces registry key for family %hu (%lu)",
  =
                     __func__, family, err);
     }
 
@@ -1885,7 +1885,7 @@=

  * @return DWORD NO_ERROR on success, a Windows error code otherwise
  */=

 static DWORD
-SetNameServersValue(PCWSTR itf_id, short family, PCSTR valu=
e)
+SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family, PCSTR value)
=
 {
     DWORD err;
 
@@ -1899,7 +1899,7 @@
     err =3D RegOpenKeyExW(itfs,=
 itf_id, 0, KEY_ALL_ACCESS, &itf);
     if (err)
     {
-        MsgToEvent=
Log(M_SYSERR, L"%S: could not open interface key for %s family %d (%lu)",
+=
        MsgToEventLog(M_SYSERR, L"%S: could not open interface key for %s f=
amily %hu (%lu)",
                       __func__, itf_id, family, err);
  =
       goto out;
     }
@@ -1907,7 +1907,7 @@
     err =3D RegSetValueExA(i=
tf, "NameServer", 0, REG_SZ, (PBYTE)value, (DWORD)strlen(value) + 1);
     =
if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%S: could not set name s=
ervers '%S' for %s family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S:=
 could not set name servers '%S' for %s family %hu (%lu)",
                =
       __func__, value, itf_id, family, err);
     }
 
@@ -1924,21 +1924,6 =
@@
 }
 
 /**
- * Set the DNS name servers in a registry interface configura=
tion
- *
- * @param itf_id    the interface id to set the servers for
- * @=
param family    internet address family to set the servers for
- * @param a=
ddrs     comma separated list of name server addresses
- *
- * @return DWOR=
D NO_ERROR on success, a Windows error code otherwise
- */
-static DWORD
-S=
etNameServers(PCWSTR itf_id, short family, PCSTR addrs)
-{
-    return SetN=
ameServersValue(itf_id, family, addrs);
-}
-
-/**
  * Delete all DNS name s=
ervers from a registry interface configuration
  *
  * @param itf_id    the=
 interface id to clear the servers for
@@ -1947,7 +1932,7 @@
  * @return DW=
ORD NO_ERROR on success, a Windows error code otherwise
  */
 static DWORD
=
-ResetNameServers(PCWSTR itf_id, short family)
+ResetNameServers(PCWSTR itf=
_id, ADDRESS_FAMILY family)
 {
     return SetNameServersValue(itf_id, fami=
ly, "");
 }
@@ -2035,7 +2020,7 @@
             offset =3D strlen(addrs);
  =
       }
 
-        err =3D SetNameServers(iid, msg->family, addrs);
+     =
   err =3D SetNameServersValue(iid, msg->family, addrs);
         if (err)
=
         {
             return err;
@@ -2096,10 +2081,10 @@
 static LSTATUS=

 SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)
 {
=
-    const short families[] =3D { AF_INET, AF_INET6 };
+    const ADDRESS_F=
AMILY families[] =3D { AF_INET, AF_INET6 };
     for (size_t i =3D 0; i < _=
countof(families); i++)
     {
-        short family =3D families[i];
+    =
    ADDRESS_FAMILY family =3D families[i];
 
         /* Create a comma spa=
rated list of addresses of this family */
         size_t offset =3D 0;
@@ =
-2127,7 +2112,7 @@
         }
 
         /* Set name server addresses */
- =
       LSTATUS err =3D SetNameServers(itf_id, family, addr_list);
+        =
LSTATUS err =3D SetNameServersValue(itf_id, family, addr_list);
         if=
 (err)
         {
             return err;

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
Gerrit-Cha=
nge-Number: 2342
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--uYoBn4B5PME=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2342?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Windows: Switch all uses of addres=
s family to ADDRESS_FAMILY type<br><br>Previously we had conversion errors =
between short<br>and unsigned short=2E<br><br>Also remove useless SetNameSe=
rvers wrapper=2E Wrapping<br>only a name is really not that useful=2E<br><b=
r>Add a definition for ADDRESS_FAMILY for cppcheck=2E<br>The built-in windo=
ws platform definition doesn&#39;t<br>cover it=2E<br><br>Change-Id: I225c21=
dbd843601b697fe712b5b66c2a4f5c2ac2<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342<=
br>Message-Id: &lt;20261125173055=2E23341-1-gert@greenie=2Emuc=2Ede&gt;<br>=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg41952=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt;<br>---<br>M dev-tools/openvpn-cppcheck-windows=2Ecfg<br>M include/op=
envpn-msg=2Eh<br>M src/openvpn/tun=2Ec<br>M src/openvpnserv/interactive=2Ec=
<br>4 files changed, 22 insertions(+), 36 deletions(-)<br><br></pre>
<pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppc=
heck-windows=2Ecfg</span><br><span>index dca2b07=2E=2E19d32a1 100644</span>=
<br><span>--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>++=
+ b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>@@ -8,6 +8,7 @=
@</span><br><span>       &lt;formatstr /&gt;</span><br><span>     &lt;/arg&=
gt;</span><br><span>   &lt;/function&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;podtype name=3D&quot;ADDRESS_FAMILY&quot; sign=
=3D&quot;u&quot; size=3D&quot;2&quot; /&gt;</span><br><span>   &lt;!-- MinG=
W uses GCC, so we need to handle GCC builtins=2E gnu=2Ecfg has these,</span=
><br><span>        but we do not load it for Windows=2E Without this cppche=
ck does not</span><br><span>        understand our likely()/unlikely() macr=
os=2E --&gt;</span><br><span>diff --git a/include/openvpn-msg=2Eh b/include=
/openvpn-msg=2Eh</span><br><span>index ca3267e8=2E=2Edd20f7b 100644</span><=
br><span>--- a/include/openvpn-msg=2Eh</span><br><span>+++ b/include/openvp=
n-msg=2Eh</span><br><span>@@ -80,7 +80,7 @@</span><br><span> typedef struct=
</span><br><span> {</span><br><span>     message_header_t header;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    short family;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</span>=
<br><span>     inet_address_t address;</span><br><span>     int prefix_len;=
</span><br><span>     interface_t iface;</span><br><span>@@ -89,7 +89,7 @@<=
/span><br><span> typedef struct</span><br><span> {</span><br><span>     mes=
sage_header_t header;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    short family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ADDRESS_FAMILY family;</span><br><span>     inet_address_t prefix;</span>=
<br><span>     int prefix_len;</span><br><span>     inet_address_t gateway;=
</span><br><span>@@ -102,7 +102,7 @@</span><br><span>     message_header_t =
header;</span><br><span>     interface_t iface;</span><br><span>     char d=
omains[512];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    short=
 family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ADDRESS=
_FAMILY family;</span><br><span>     unsigned int addr_len;</span><br><span=
>     inet_address_t addr[4]; /* support up to 4 dns addresses */</span><br=
><span> } dns_cfg_message_t;</span><br><span>@@ -150,7 +150,7 @@</span><br>=
<span> typedef struct</span><br><span> {</span><br><span>     message_heade=
r_t header;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    short =
family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_=
FAMILY family;</span><br><span>     interface_t iface;</span><br><span> } f=
lush_neighbors_message_t;</span><br><span> </span><br><span>@@ -177,7 +177,=
7 @@</span><br><span> {</span><br><span>     message_header_t header;</span=
><br><span>     interface_t iface;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    short family;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ADDRESS_FAMILY family;</span><br><span>     int mtu;</span><=
br><span> } set_mtu_message_t;</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index fe1af45=
=2E=2E65edf73 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><s=
pan>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -101,7 +101,7 @@</span><br=
><span> static void netsh_ifconfig(const struct tuntap_options *to, DWORD a=
dapter_index, const in_addr_t ip,</span><br><span>                         =
   const in_addr_t netmask, const unsigned int flags);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static void windows_set_=
mtu(const int iface_index, const short family, const int mtu);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void windows_set_mtu(cons=
t int iface_index, const ADDRESS_FAMILY family, const int mtu);</span><br><=
span> </span><br><span> static void netsh_set_dns6_servers(const struct in6=
_addr *addr_list, const unsigned int addr_len,</span><br><span>            =
                        DWORD adapter_index);</span><br><span>@@ -118,7 +11=
8,7 @@</span><br><span> #endif</span><br><span> </span><br><span> static bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_address_service(=
const bool add, const short family, const struct tuntap *tt)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+do_address_service(const bool add,=
 const ADDRESS_FAMILY family, const struct tuntap *tt)</span><br><span> {</=
span><br><span>     bool ret =3D false;</span><br><span>     ack_message_t =
ack;</span><br><span>@@ -241,7 +241,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-do_dns_service(bool add, const short family, const struct tuntap =
*tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_dns_service(=
bool add, const ADDRESS_FAMILY family, const struct tuntap *tt)</span><br><=
span> {</span><br><span>     ack_message_t ack;</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span>@@ -366,7 +366,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_set_mtu_service(const struct tuntap *tt,=
 const short family, const int mtu)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+do_set_mtu_service(const struct tuntap *tt, const ADDRESS_F=
AMILY family, const int mtu)</span><br><span> {</span><br><span>     bool r=
et =3D false;</span><br><span>     ack_message_t ack;</span><br><span>@@ -5=
320,7 +5320,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-windows_set_mt=
u(const int iface_index, const short family, const int mtu)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+windows_set_mtu(const int iface_ind=
ex, const ADDRESS_FAMILY family, const int mtu)</span><br><span> {</span><b=
r><span>     DWORD err =3D 0;</span><br><span>     MIB_IPINTERFACE_ROW ipif=
ace;</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/ope=
nvpnserv/interactive=2Ec</span><br><span>index 77b91e0=2E=2Ed155fd6 100644<=
/span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b=
/src/openvpnserv/interactive=2Ec</span><br><span>@@ -529,7 +529,7 @@</span>=
<br><span> #endif</span><br><span> </span><br><span> static SOCKADDR_INET</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-sockaddr_inet(short fam=
ily, const inet_address_t *addr)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+sockaddr_inet(ADDRESS_FAMILY family, const inet_address_t *add=
r)</span><br><span> {</span><br><span>     SOCKADDR_INET sa_inet;</span><br=
><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</span><br><span>@@ -=
1858,7 +1858,7 @@</span><br><span>  * @return BOOL to indicate success or f=
ailure</span><br><span>  */</span><br><span> static BOOL</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-GetInterfacesKey(short family, PHKEY key=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+GetInterfacesKey(A=
DDRESS_FAMILY family, PHKEY key)</span><br><span> {</span><br><span>     PC=
STR itfs_key =3D family =3D=3D AF_INET6</span><br><span>                   =
       ? &quot;SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters\\Int=
erfaces&quot;</span><br><span>@@ -1868,7 +1868,7 @@</span><br><span>     if=
 (err)</span><br><span>     {</span><br><span>         *key =3D INVALID_HAN=
DLE_VALUE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        Msg=
ToEventLog(M_SYSERR, L&quot;%S: could not open interfaces registry key for =
family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MsgToEventLog(M_SYSERR, L&quot;%S: could not open interfaces reg=
istry key for family %hu (%lu)&quot;,</span><br><span>                     =
  __func__, family, err);</span><br><span>     }</span><br><span> </span><b=
r><span>@@ -1885,7 +1885,7 @@</span><br><span>  * @return DWORD NO_ERROR on=
 success, a Windows error code otherwise</span><br><span>  */</span><br><sp=
an> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SetNa=
meServersValue(PCWSTR itf_id, short family, PCSTR value)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+SetNameServersValue(PCWSTR itf_id, ADD=
RESS_FAMILY family, PCSTR value)</span><br><span> {</span><br><span>     DW=
ORD err;</span><br><span> </span><br><span>@@ -1899,7 +1899,7 @@</span><br>=
<span>     err =3D RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &amp;itf)=
;</span><br><span>     if (err)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;%S:=
 could not open interface key for %s family %d (%lu)&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&q=
uot;%S: could not open interface key for %s family %hu (%lu)&quot;,</span><=
br><span>                       __func__, itf_id, family, err);</span><br><=
span>         goto out;</span><br><span>     }</span><br><span>@@ -1907,7 +=
1907,7 @@</span><br><span>     err =3D RegSetValueExA(itf, &quot;NameServer=
&quot;, 0, REG_SZ, (PBYTE)value, (DWORD)strlen(value) + 1);</span><br><span=
>     if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;%S: could not set na=
me servers &#39;%S&#39; for %s family %d (%lu)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%S=
: could not set name servers &#39;%S&#39; for %s family %hu (%lu)&quot;,</s=
pan><br><span>                       __func__, value, itf_id, family, err);=
</span><br><span>     }</span><br><span> </span><br><span>@@ -1924,21 +1924=
,6 @@</span><br><span> }</span><br><span> </span><br><span> /**</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Set the DNS name servers in a =
registry interface configuration</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m itf_id    the interface id to set the servers for</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param family    internet address family=
 to set the servers for</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param addrs     comma separated list of name server addresses</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @return DWORD NO_ERROR on success, a Windows =
error code otherwise</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-SetNameServers(PCWSTR itf_id=
, short family, PCSTR addrs)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return Se=
tNameServersValue(itf_id, family, addrs);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span> =
 * Delete all DNS name servers from a registry interface configuration</spa=
n><br><span>  *</span><br><span>  * @param itf_id    the interface id to cl=
ear the servers for</span><br><span>@@ -1947,7 +1932,7 @@</span><br><span> =
 * @return DWORD NO_ERROR on success, a Windows error code otherwise</span>=
<br><span>  */</span><br><span> static DWORD</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-ResetNameServers(PCWSTR itf_id, short family)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ResetNameServers(PCWSTR it=
f_id, ADDRESS_FAMILY family)</span><br><span> {</span><br><span>     return=
 SetNameServersValue(itf_id, family, &quot;&quot;);</span><br><span> }</spa=
n><br><span>@@ -2035,7 +2020,7 @@</span><br><span>             offset =3D s=
trlen(addrs);</span><br><span>         }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetNameServers(iid, ms=
g-&gt;family, addrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        err =3D SetNameServersValue(iid, msg-&gt;family, addrs);</span><b=
r><span>         if (err)</span><br><span>         {</span><br><span>      =
       return err;</span><br><span>@@ -2096,10 +2081,10 @@</span><br><span>=
 static LSTATUS</span><br><span> SetNameServerAddresses(PWSTR itf_id, const=
 nrpt_address_t *addresses)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const short families[] =3D { AF_INET, AF_INET6=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ADDRES=
S_FAMILY families[] =3D { AF_INET, AF_INET6 };</span><br><span>     for (si=
ze_t i =3D 0; i &lt; _countof(families); i++)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        short family =3D fam=
ilies[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        AD=
DRESS_FAMILY family =3D families[i];</span><br><span> </span><br><span>    =
     /* Create a comma sparated list of addresses of this family */</span><=
br><span>         size_t offset =3D 0;</span><br><span>@@ -2127,7 +2112,7 @=
@</span><br><span>         }</span><br><span> </span><br><span>         /* =
Set name server addresses */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        LSTATUS err =3D SetNameServers(itf_id, family, addr_list);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        LSTATUS err =
=3D SetNameServersValue(itf_id, family, addr_list);</span><br><span>       =
  if (err)</span><br><span>         {</span><br><span>             return e=
rr;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2342?usp=3Demail">change 2342</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66=
c2a4f5c2ac2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2342 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uYoBn4B5PME=--


--===============1227843356641886410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1227843356641886410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1227843356641886410==--

