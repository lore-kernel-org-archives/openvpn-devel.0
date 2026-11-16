Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A9606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IxiDxwG+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PzJsaihU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dKcMw8vL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OBz+oLqd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V8ppOdE3an+df6yNNZqQ940u80xqiTlEzk7dXDi/V3I=; b=IxiDxwG+hOiRTnc1XwUU3+eG+3
	ot9W83pxtQ0yV7j8Dd+GrmiDF5P4rdK7NN5UBIA9HJNS0miN1DkU/+eQ+9qKEVAYH4MVzRZWpwfOm
	T4/u6Tc2+uE7XLeBb9vcqNLqhZCz7YMpcV6PtUtoNETXqIq2lT9XaAzOU/q8EOIf9m0k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStv7-0000000052x-2jvR;
	Mon, 16 Nov 2026 10:26:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xStv5-0000000052p-3QEu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jn9cbSf72vAwoWYCnz33fLu/rUkKrg9p0XiRSdvbY4w=; b=PzJsaihUvCdyj8mmLuF/97ZiBH
 UOOu14Ypdwsd9vPLcwBTl9BGZG2rmFvyomG2YuK1ox5tngPO1a3nyJmjJPL3fJF6kVN7cyy+0J2/A
 QuObjU5vmkG0gLzhxnRLUorgIpBxU/+AtCnlimOWFyRcymseYypdgeq97ArToPA943nE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jn9cbSf72vAwoWYCnz33fLu/rUkKrg9p0XiRSdvbY4w=; b=dKcMw8vL+O2sWUTNJpReevrAl5
 TDOcyyR4Bu+2ENGvRARd2gNb1JXn3eInNsAe0CriAGbsnVMx6AmH4JGYpdKImDmVcMc9Yf7TSpieZ
 wApjP1AqKNMj5SvDcaHX9/XR/ocdCXhDVZyQKawrFplfkLAPwhnguQJ4JaMMePal3+/Q=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xStv4-000000000sS-3WRx for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:26:39 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so13988845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 02:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794824792; x=1795429592; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jn9cbSf72vAwoWYCnz33fLu/rUkKrg9p0XiRSdvbY4w=;
 b=OBz+oLqdJuwO6BsgdZN/uaB34fOmaEf/X81b9C99kDrMz67iiFbZo1sVCMuPmq+vzf
 AKKMqBmVk6xTgo0xy9/+yQe8gbpGy3ovp7WBwrQcCwbvjnB/O7tbFkw63xA9EMaT0jmk
 /GBZUqpX5wIZwglCU319A4uNEzSzv24FwFEXuBNRhenfyWv2zEMxj0thVfifqS2+nL/h
 92bu96vnms9fD57cq3QxyxBdxHLK1ovbPdXciiLDJt+UbCZd8SHZy4tb+AWNa8ezPYWi
 CjWCRSQMdpWCSdXih+9nS8r566CmYQkytH6B+mUvi5xDxd7VXiLKO9hNKVinXkJCRV+p
 3B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794824792; x=1795429592;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Jn9cbSf72vAwoWYCnz33fLu/rUkKrg9p0XiRSdvbY4w=;
 b=iWlYYHrZjIH7Cl+ZcKxBNozyYp68um1263eCRiUhfT1bqWbvP1X7xvBvoPB+A0e+9x
 5vFb/wI2Ux8TT39lLxvxsazneeEzOjusxc4ZWbnfq3WTD5FihXv84/VsYFWiZl9esmnq
 gi0mSdngyG7xIsPzVCjlxJvm0+HfFLEbKq6VnJSp6SmNSc8j/1uvl81DqfsyqsTPUujB
 C4qhVoko4YZykVUMcijKUSRrQ4Gwl91jHDUR69/u3VQDvb5HHlhE2Z4YhMbKQCiGYKG7
 gQRVJeAZ+Ijq4NQaIofjlBSta5F/MTtUapdY6zXDzEgyI7sOoMK8rmMtOOklZL+evwiz
 Qotw==
X-Forwarded-Encrypted: i=1;
 AL+hErFWihWjHXaeIR99GanNZW5ffvW0cj1DBTeOJr8MgZeMQCC0jRIxNJr930Fb+ioVl40fA6Sp0RlC7IEsV4cW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9dhpmifTK07zVU9B91V5MhdmG92cAQ3OSaWsKiNmK1ZVY4uw9S
 Cv9fxAi/BtlvFiGt3V7U0rmIkgMiby1rPQDKYggsvhS/w4svyE0eTu/4brRsp7BZJSUS+j4NDcr
 N/j8hAq+gFgW3EgKYomPkkPpbU1Ub4LXEi89Bsjot9UVW+6Bbeq/41kEMHh2iw5kT688N
X-Gm-Gg: AYBFou3MPZ1IbgdnHlD/2+vTWRlP3pAHlaQnPtlkiYMMAajiBKX3NrMpD2zt+mILKWF
 urpDpAslGpCE6XJdzriZJfKIX/vB8ttN7gdfa/U8yIjZLYAhZieLG1dWPu0jNWBUlAyrdHn/LGC
 pmjUtvlgvmsLt5kPs8EZbuMzzKXTEmwVhESl7urcSLIllOLfY7G5/BmgbuGz5aWXtpHUa6mB8TT
 ziOWWh9USeZysNQrM0vxUugxI9lfRP1KYP/Mc4UY53L+Kcd4t1XXTKbMguOZiXZGk6/CsqGlshD
 GCKxfzMsIs4/9C22vEEfenMqVUBgZkfzkk4WygPV+v/a/TK99PR/d+cxS2vOsUNcFHBhjSoH4qw
 SFNe/G5RFtX/NBQ9DW+OLnD99/MD4pIooQvLJ1p/Y53+ihtZmS0g1GqQMeAkruBS5EpgqByTRXI
 Htqy8QFyrMvarLQGqFjwLRwVfYSEzaaNBkTTHlBl2YhKayrGKe9Fb/gOz1Kyr7D/STZnJEuKOH+
 ZShtUZ0vrXTCdMlSnOK8wE8X7cIbi38SY0RrJLqB4iioe8AqR0H6iayHIQvlnVJQlPnpYozDF/v
 D3shmiNGh6++UCDjEB31GJRWuXHa+stCOzXUjfpHChUYP3a+kbaFOsAurQznJQvuwDOIoQ8KKr5
 6iv7wtwZfJt6WmOYlJjtR7Xm5EP3n0oTW7RkIrxOJHGLOabatV/AyHeXydoaLWXlrxAVyFSN4Cp
 QmAa+x4xyojqz+Uwdo//84gz+ufdQ/FSAXLgu43g==
X-Received: by 2002:a05:600c:8819:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4bb55a6ad4emr192396445e9.20.1794824792069; 
 Mon, 16 Nov 2026 02:26:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb69ac4e16sm105216215e9.0.2026.11.16.02.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:26:31 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 10:26:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: 2d1014eaf4112c9d3d002523ab40671cf32931c7
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abf4663eed5b08ac69e816c1afaca937fa0ff459-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xStv4-000000000sS-3WRx
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0769389267642205033=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0769389267642205033==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FQcUU4sPVL0="; charset=UTF-8

--FQcUU4sPVL0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2162?usp=3Demail )

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





diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interac=
tive=2Ec
index f9a2c970=2E=2E354fe09 100644
--- a/src/openvpnserv/interacti=
ve=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2147,6 +2147,24 @@
 }
 
 /=
**
+ * Remove trailing delimiters from a name server list
+ *
+ * @param  a=
ddrs      NUL-terminated list of addresses
+ *
+ * @return the size of the =
list in bytes, including the terminating NUL
+ */
+static DWORD
+TrimNameSe=
rvers(PSTR addrs)
+{
+    size_t len =3D strlen(addrs);
+    while (len && =
(addrs[len - 1] =3D=3D ',' || addrs[len - 1] =3D=3D ' '))
+    {
+        a=
ddrs[--len] =3D '\0';
+    }
+    return (DWORD)len + 1;
+}
+
+/**
  * Get =
DNS server IPv4 addresses of an interface
  *
  * @param  itf_key    regist=
ry key of the IPv4 interface data
@@ -2159,6 +2177,7 @@
 static LSTATUS
 Ge=
tItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
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

Gerrit-MessageType: merged=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic602b125d=
857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 2162
Gerrit-PatchSet:=
 5
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Review=
er: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=2Eei=
gentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--FQcUU4sPVL0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2162?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: keep IPv6 name server=
s in NRPT exclude rules<br><br>GetNrptExcludeData() stored the IPv6 name se=
rvers after the IPv4 list,<br>but the IPv4 size includes the terminating NU=
L=2E With both present, the<br>string ended at the IPv4 list and the IPv6 s=
ervers never made it into<br>GenericDNSServers=2E Join the lists by replaci=
ng that NUL with a<br>delimiter=2E<br><br>Both readers now start from an em=
pty string: RegGetValueA() leaves the<br>buffer untouched when the value is=
 missing, and a slot is reused after<br>an interface is skipped, so an inte=
rface without name servers could<br>inherit those of the skipped one=2E The=
y also return the length of the<br>list without trailing delimiters, instea=
d of the registry value size,<br>which can include NUL padding=2E<br><br>Br=
oken since 0f3b7d17 (&quot;win: implement --dns option support with<br>NRPT=
&quot;)=2E<br><br>Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: He=
iko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2162<br>Message-Id: &lt;20261112181513=2E27212=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41227=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/intera=
ctive=2Ec<br>1 file changed, 29 insertions(+), 4 deletions(-)<br><br></pre>=

<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interact=
ive=2Ec</span><br><span>index f9a2c970=2E=2E354fe09 100644</span><br><span>=
--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv=
/interactive=2Ec</span><br><span>@@ -2147,6 +2147,24 @@</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Remove trailing delimiters from a name server list</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param  addrs      NUL-terminated li=
st of addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the size o=
f the list in bytes, including the terminating NUL</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+TrimNameServers(PSTR addrs)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t len =3D strlen(addrs);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    while (len &amp;&amp; (addrs[len - 1] =3D=3D &#39;,&#39; ||=
 addrs[len - 1] =3D=3D &#39; &#39;))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        addrs[--len] =3D &#39;\0&#39;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return (DWORD)len + 1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  =
* Get DNS server IPv4 addresses of an interface</span><br><span>  *</span><=
br><span>  * @param  itf_key    registry key of the IPv4 interface data</sp=
an><br><span>@@ -2159,6 +2177,7 @@</span><br><span> static LSTATUS</span><b=
r><span> GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)</span><b=
r><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addrs=
[0] =3D &#39;\0&#39;;</span><br><span>     addrs[*size - 1] =3D &#39;\0&#39=
;;</span><br><span> </span><br><span>     LSTATUS err;</span><br><span>@@ -=
2184,7 +2203,7 @@</span><br><span> </span><br><span>     if (strchr(addrs, =
&#39;=2E&#39;))</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        *size =3D s;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        *size =3D TrimNameServers(addrs);</span><br><span=
>         return NO_ERROR;</span><br><span>     }</span><br><span> </span><=
br><span>@@ -2197,13 +2216,15 @@</span><br><span>  *</span><br><span>  * @p=
aram  itf_key    registry key of the IPv6 interface data</span><br><span>  =
* @param  addrs      pointer to the buffer addresses are returned in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  size       pointe=
r to the size of the buffer</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param  size       pointer to the size of the buffer, contains t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *               =
     size of the addresses on return</span><br><span>  *</span><br><span>  =
* @return LSTATUS NO_ERROR on success, a Windows error code otherwise</span=
><br><span>  */</span><br><span> static LSTATUS</span><br><span> GetItfDnsS=
erversV6(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    addrs[0] =3D &#39;\0&#39=
;;</span><br><span>     addrs[*size - 1] =3D &#39;\0&#39;;</span><br><span>=
 </span><br><span>     LSTATUS err;</span><br><span>@@ -2250,12 +2271,11 @@=
</span><br><span>             pos +=3D addr_len;</span><br><span>          =
   s -=3D (DWORD)addr_len;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        s =3D (DWORD)strlen(addrs) + 1;</sp=
an><br><span>     }</span><br><span> </span><br><span>     if (strchr(addrs=
, &#39;:&#39;))</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        *size =3D s;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        *size =3D TrimNameServers(addrs);</span><br><span=
>         return NO_ERROR;</span><br><span>     }</span><br><span> </span><=
br><span>@@ -2582,6 +2602,11 @@</span><br><span>                           =
    __func__, itf_guid, err);</span><br><span>                 goto next_it=
f;</span><br><span>             }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (v4_addrs_size &amp;&amp; v6_addrs_size)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                /* Join the lis=
ts: replace the v4 terminating NUL with a delimiter */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                data[i]=2Eaddresses[v4_a=
ddrs_size - 1] =3D &#39;,&#39;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span>         }</span><br><span> </spa=
n><br><span>         if (v4_addrs_size || v6_addrs_size)</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?=
usp=3Demail">change 2162</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--FQcUU4sPVL0=--


--===============0769389267642205033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0769389267642205033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0769389267642205033==--

