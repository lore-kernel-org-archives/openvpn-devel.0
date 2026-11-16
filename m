Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A51606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B511/Nzt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iCKL4/5Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lFVrxrT2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NZPLRG2v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dSYmKGFAkhM07YP9ddZ7lSONos8bcHvcV9+LAO1CCqQ=; b=B511/NzthKd4bWQwY7kAunxN0Q
	jCuqgkcZaf+I4sapzhrznb7277qUUUHQxQ6ldpwl1q5VtQUVl6FBow+Oo11WKzNt+z5YcFr7y3zBe
	Uh8EhHv/9MwyozrJflbAbrtoqA1nqiSLCDqjdXEE5I2+ti4jX9J/4omh3woZuQFkWEsU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStv7-0000000085S-1PZN;
	Mon, 16 Nov 2026 10:26:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xStv5-0000000085L-2dQQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w1cuIgQBwYQJoqE0gSv6iftYfJpAi4nZgWqhX8GXpGg=; b=iCKL4/5Zl3gSLEFiR+Miya2JEn
 0pQQ3l3c06Nh3HGLUztqazFQH2j72+ez0VkTcBND4psHkStP9GQ93Y8fvpqwoPNvrRm4NV0oGhmPW
 cpBUXSPNqVtWrV3jjDPg60H7KgYQq/xBb2ECF1LqiKlPPkeKGC1FKjjOiPE33xEPVNck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w1cuIgQBwYQJoqE0gSv6iftYfJpAi4nZgWqhX8GXpGg=; b=lFVrxrT2y29suPflZ0eiZNp+yq
 i0uouWc9F9q55s2HsXswsO+jdTzwMBVXnZkWH0JXaW1G8cgv0gbaAopA86wXmdK/XP1R2fvFFkylx
 TFNjK3P+KMGU4tBIj0jzKWDNjxv8Ig7zQN76EawVFUuSr2p6OfJsN9AiqaJfVcwlgMYI=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xStv3-000000000sR-1PvT for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:26:39 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so6683575e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794824791; x=1795429591; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w1cuIgQBwYQJoqE0gSv6iftYfJpAi4nZgWqhX8GXpGg=;
 b=NZPLRG2vv0URGrOX+d04A0Fp6YBmS6mIERGhUMtJbZQ9wFKm7RpGnJfc7ePelP1y2Q
 6Ii1d3bRiO+K63am4uOG4OUZJekQArrbn5DXCgdFhDqyztUx5aoiMgs+uAOsOb5HK7ai
 PYNVBMgvxpISQqLpxBwOt0BL2lc2YSRgqBUIsbn5pi0ownia4hqzHslJnvxwbb67Bgvd
 GmuEVHhJdzoRo/TEhrEcrNu7vRJEyiQ6Jqm0riwvMn4g3LMdIazZ6ZMB9MdrVRgCGtTK
 jrPtnozaHAr3V/Q4y9+h6O5hlbDOJovbsLS0/F5LSUWVE+2h0UPoRvarVDPGKrcoFe05
 iGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794824791; x=1795429591;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w1cuIgQBwYQJoqE0gSv6iftYfJpAi4nZgWqhX8GXpGg=;
 b=vC2p2EFYoqu5q2vFBjtmzuqWLqIp/MCQ4Jy3UxSP+ynLcHIpP3FqMHsqQvJRMwBomD
 5EzzVvvuznNyIjzmtscnmZuJYfd25X9yEOr9fzyAn975v1T5iMc1AuTSUySPY+fftfAY
 4qPXcQb6xGaQ4OdbigcI8lDUrbVEj6UdyZ9fjb+7roOSbUfzv8MGe6cTd2EuU7MwZ3xG
 2Du9a8Sk31tGrC6KLvr4e3Iza7LvbYdyF8RIph+e7mvE8txuqdzyZk+MZzOTyelPQvUI
 rH2Hl4AidSwukZWXCfexYf8ctfXBDzx4TAXa9465uO768z5AStzmaULpRNbUrimRPh0n
 mtdg==
X-Gm-Message-State: APuU4Z83ZCg2w8LNlHv8KU+x3VUNKE7cgqo7yskZAr5NuP8yHmFFngF0
 2GRdYvvwmHfWaH/u7JHSkInXAS6vcsUPmtPe1JRnPYd61tsS6j/AX1JVo+Ge1Vlp3B8H/VlFT1z
 Hy6THOUMqmXrEes2OuDrqd25mF5Z2/vWVT0BTIfZ70hgnBCT7zyZgwrEAA05dJ21mw2Oqg+b6RP
 /2JiRfPA==
X-Gm-Gg: AYBFou3eRZK7J2iMVMFpKO6umMTb8QAkW1ybFF3vORsXmrkbHlRrjA3HU8b55xlhDx/
 xOitq5K/BF/xeDsDEey/r6LXPX/7OeXwLNbnXe9FpC4wo8ZESphQMZ8qLRu9UdSX85CFwoCxf1r
 NZQ+DyAGx1xhP3Jk3iD4BMtnsW9or0S+YjaMO5SIrVF70evahQqQePj7Fvzx7TVmVryA+S2Rw9r
 to7aUlNx6FDj0dloC81xQzXEu122piRAUlN6+o/1xVez0XmcocwnzXaaLtIhtfaLghMqXc+HN4P
 evF6lQDWPeYeSTlY6PSVZdED9laUx/oplZsrKKepjEqKResatPzuG2oUUXkffTQqTcds0ZHQ2Eu
 HIEAkpVfCWXrpdqmVOBjj16JJg3BvYE9oTN/p8NEJkyPM9xCHUhaMytnvcer/deJQWtRJItZwgj
 yDRgmKISPX0SsYf6ed8AlEGODlAOZetBXw3lQ8+LduFqW2X7WR+TyGNbTWlSlXv7suTMf9q6Gzm
 ouP2qYTYlkyPzx32pluPQ6CljPM6uJ+JQ4rEqXdHy4zlFEQAjwzs6PX1EfYgaFyU8hv9YR0MDjz
 676YVQgH6wFKnQaz2BKdsbavd4fnfz91FErRU2F1T7+YQhZub9cavthhg8jIZEr1ucKWIByalLv
 TNul5SSGQWd8waBfcm/C6UxNr8RnEMFMMF2A2pbMztu2goTV6+24QN48T20A22t3CFtl5puuO27
 N3j4jwA8XKVrZWUEo=
X-Received: by 2002:a05:600c:4692:b0:4a2:1612:6367 with SMTP id
 5b1f17b1804b1-4bb55a67bf6mr205030405e9.15.1794824790362; 
 Mon, 16 Nov 2026 02:26:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac1159sm249752015e9.4.2026.11.16.02.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:26:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 10:26:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: 2d1014eaf4112c9d3d002523ab40671cf32931c7
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abf4663eed5b08ac69e816c1afaca937fa0ff459-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xStv3-000000000sR-1PvT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2934733833475811998=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2934733833475811998==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="581FC3//5js="; charset=UTF-8

--581FC3//5js=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2162?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Heiko Hund


Change subject: openvpnserv: keep IPv6 name=
 servers in NRPT exclude rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

openvpnserv: keep IPv6 name servers in NRPT exclude rul=
es

GetNrptExcludeData() stored the IPv6 name servers after the IPv4 list,
=
but the IPv4 size includes the terminating NUL=2E With both present, the
st=
ring ended at the IPv4 list and the IPv6 servers never made it into
Generic=
DNSServers=2E Join the lists by replacing that NUL with a
delimiter=2E

Bot=
h readers now start from an empty string: RegGetValueA() leaves the
buffer =
untouched when the value is missing, and a slot is reused after
an interfac=
e is skipped, so an interface without name servers could
inherit those of t=
he skipped one=2E They also return the length of the
list without trailing =
delimiters, instead of the registry value size,
which can include NUL paddi=
ng=2E

Broken since 0f3b7d17 ("win: implement --dns option support with
NRP=
T")=2E

Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Signed-off-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Heiko Hund <heiko@ist=2E=
eigentlich=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
62
Message-Id: <20261112181513=2E27212-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg412=
27=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/o=
penvpnserv/interactive=2Ec
1 file changed, 29 insertions(+), 4 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/21=
62/5

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/intera=
ctive=2Ec
index f9a2c970=2E=2E354fe09 100644
--- a/src/openvpnserv/interact=
ive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2147,6 +2147,24 @@
 }
 
 =
/**
+ * Remove trailing delimiters from a name server list
+ *
+ * @param  =
addrs      NUL-terminated list of addresses
+ *
+ * @return the size of the=
 list in bytes, including the terminating NUL
+ */
+static DWORD
+TrimNameS=
ervers(PSTR addrs)
+{
+    size_t len =3D strlen(addrs);
+    while (len &&=
 (addrs[len - 1] =3D=3D ',' || addrs[len - 1] =3D=3D ' '))
+    {
+        =
addrs[--len] =3D '\0';
+    }
+    return (DWORD)len + 1;
+}
+
+/**
  * Get=
 DNS server IPv4 addresses of an interface
  *
  * @param  itf_key    regis=
try key of the IPv4 interface data
@@ -2159,6 +2177,7 @@
 static LSTATUS
 G=
etItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
 {
+    addrs[0] =
=3D '\0';
     addrs[*size - 1] =3D '\0';
 
     LSTATUS err;
@@ -2184,7 +2=
203,7 @@
 
     if (strchr(addrs, '=2E'))
     {
-        *size =3D s;
+   =
     *size =3D TrimNameServers(addrs);
         return NO_ERROR;
     }
 
@=
@ -2197,13 +2216,15 @@
  *
  * @param  itf_key    registry key of the IPv6 =
interface data
  * @param  addrs      pointer to the buffer addresses are r=
eturned in
- * @param  size       pointer to the size of the buffer
+ * @pa=
ram  size       pointer to the size of the buffer, contains the
+ *        =
            size of the addresses on return
  *
  * @return LSTATUS NO_ERRO=
R on success, a Windows error code otherwise
  */
 static LSTATUS
 GetItfDn=
sServersV6(HKEY itf_key, PSTR addrs, PDWORD size)
 {
+    addrs[0] =3D '\0'=
;
     addrs[*size - 1] =3D '\0';
 
     LSTATUS err;
@@ -2250,12 +2271,11 =
@@
             pos +=3D addr_len;
             s -=3D (DWORD)addr_len;
   =
      }
-        s =3D (DWORD)strlen(addrs) + 1;
     }
 
     if (strchr(a=
ddrs, ':'))
     {
-        *size =3D s;
+        *size =3D TrimNameServers=
(addrs);
         return NO_ERROR;
     }
 
@@ -2582,6 +2602,11 @@
        =
                       __func__, itf_guid, err);
                 goto next=
_itf;
             }
+            if (v4_addrs_size && v6_addrs_size)
+    =
        {
+                /* Join the lists: replace the v4 terminating NU=
L with a delimiter */
+                data[i]=2Eaddresses[v4_addrs_size - =
1] =3D ',';
+            }
         }
 
         if (v4_addrs_size || v6_ad=
drs_size)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
62?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic602=
b125d857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 2162
Gerrit-Patc=
hSet: 5
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-R=
eviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--581FC3//5js=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2162?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Heiko Hund</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">openv=
pnserv: keep IPv6 name servers in NRPT exclude rules<br><br>GetNrptExcludeD=
ata() stored the IPv6 name servers after the IPv4 list,<br>but the IPv4 siz=
e includes the terminating NUL=2E With both present, the<br>string ended at=
 the IPv4 list and the IPv6 servers never made it into<br>GenericDNSServers=
=2E Join the lists by replacing that NUL with a<br>delimiter=2E<br><br>Both=
 readers now start from an empty string: RegGetValueA() leaves the<br>buffe=
r untouched when the value is missing, and a slot is reused after<br>an int=
erface is skipped, so an interface without name servers could<br>inherit th=
ose of the skipped one=2E They also return the length of the<br>list withou=
t trailing delimiters, instead of the registry value size,<br>which can inc=
lude NUL padding=2E<br><br>Broken since 0f3b7d17 (&quot;win: implement --dn=
s option support with<br>NRPT&quot;)=2E<br><br>Change-Id: Ic602b125d857f1be=
ed4af8661f522d339bc9e972<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162<br>Message-I=
d: &lt;20261112181513=2E27212-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41227=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 29 insertions(+)=
, 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/62/2162/5</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>ind=
ex f9a2c970=2E=2E354fe09 100644</span><br><span>--- a/src/openvpnserv/inter=
active=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br>=
<span>@@ -2147,6 +2147,24 @@</span><br><span> }</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remov=
e trailing delimiters from a name server list</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param  addrs      NUL-terminated list of addresses</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return the size of the list in bytes, includ=
ing the terminating NUL</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static DWORD=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TrimNameServers(PST=
R addrs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D strlen(add=
rs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (len =
&amp;&amp; (addrs[len - 1] =3D=3D &#39;,&#39; || addrs[len - 1] =3D=3D &#39=
; &#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        addrs[--len] =3D=
 &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (DWORD)l=
en + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get DNS server IPv4 addre=
sses of an interface</span><br><span>  *</span><br><span>  * @param  itf_ke=
y    registry key of the IPv4 interface data</span><br><span>@@ -2159,6 +21=
77,7 @@</span><br><span> static LSTATUS</span><br><span> GetItfDnsServersV4=
(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    addrs[0] =3D &#39;\0&#39;;</span=
><br><span>     addrs[*size - 1] =3D &#39;\0&#39;;</span><br><span> </span>=
<br><span>     LSTATUS err;</span><br><span>@@ -2184,7 +2203,7 @@</span><br=
><span> </span><br><span>     if (strchr(addrs, &#39;=2E&#39;))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *s=
ize =3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *=
size =3D TrimNameServers(addrs);</span><br><span>         return NO_ERROR;<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -2197,13 +2216,=
15 @@</span><br><span>  *</span><br><span>  * @param  itf_key    registry k=
ey of the IPv6 interface data</span><br><span>  * @param  addrs      pointe=
r to the buffer addresses are returned in</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param  size       pointer to the size of the buffer=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  size    =
   pointer to the size of the buffer, contains the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *                    size of the addresses =
on return</span><br><span>  *</span><br><span>  * @return LSTATUS NO_ERROR =
on success, a Windows error code otherwise</span><br><span>  */</span><br><=
span> static LSTATUS</span><br><span> GetItfDnsServersV6(HKEY itf_key, PSTR=
 addrs, PDWORD size)</span><br><span> {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    addrs[0] =3D &#39;\0&#39;;</span><br><span>     add=
rs[*size - 1] =3D &#39;\0&#39;;</span><br><span> </span><br><span>     LSTA=
TUS err;</span><br><span>@@ -2250,12 +2271,11 @@</span><br><span>          =
   pos +=3D addr_len;</span><br><span>             s -=3D (DWORD)addr_len;<=
/span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        s =3D (DWORD)strlen(addrs) + 1;</span><br><span>     }</span><=
br><span> </span><br><span>     if (strchr(addrs, &#39;:&#39;))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *s=
ize =3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *=
size =3D TrimNameServers(addrs);</span><br><span>         return NO_ERROR;<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -2582,6 +2602,1=
1 @@</span><br><span>                               __func__, itf_guid, err=
);</span><br><span>                 goto next_itf;</span><br><span>        =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (v4_addrs_size &amp;&amp; v6_addrs_size)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                /* Join the lists: replace the v4 terminat=
ing NUL with a delimiter */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                data[i]=2Eaddresses[v4_addrs_size - 1] =3D &#39;,&#=
39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span>         }</span><br><span> </span><br><span>         if (v4=
_addrs_size || v6_addrs_size)</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail">change 2162</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ic602b125d857f1beed4af8661f522d339bc9e972 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2162 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko H=
und &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>

</body></html>
--581FC3//5js=--


--===============2934733833475811998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2934733833475811998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2934733833475811998==--

