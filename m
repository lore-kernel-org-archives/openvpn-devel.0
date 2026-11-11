Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330ED606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PJnM5zod;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z9+YRfeX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kfbe5eFZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NIJmumGH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ANAa80N+u4cy0eN/HLkGBY6xbIhr7VFYthyCROpAi5A=; b=PJnM5zodiWQ2YYl9mV+v7zK/NA
	cMswMyln3AGrpgavrwbQWITcQ+AwVa3JxWC5Xyhfg7NChHWHC0WeSP8KmJk5NgHRKBnlXzYnwXBTf
	gkxOZ7Q/ij71Wwd8Beazpp+e17Bmb6VbdnvN8EjIEVwktHu2a32N4A2yUs7/3lKv8poI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4IS-000000002gq-2vCQ;
	Wed, 11 Nov 2026 09:07:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4IO-000000002gh-3bLG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:07:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kMke+iqbLZh9m95BdyxI70ngBkQPytwCzF3ecl20SJw=; b=Z9+YRfeX4rN8mus9Uc2HpjWopP
 eADlReZ6vKdw2524ZnkLt7wuCXYVzMV5IiOSi08cvsvOJOwzf17/LElOkqj5Hd18U9ST9ab81LhCV
 vW9+PSVgB/MkjAe6dyPjhZXrhJf6CnopypB2ObCs0Q265lMkKh2H1F88VdCsFfkpdsOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kMke+iqbLZh9m95BdyxI70ngBkQPytwCzF3ecl20SJw=; b=kfbe5eFZvMwf59VKofcLNZKj9J
 hAUPwuNOg7k4LNMRv9Y0U4dDbVbTXiaWZKhgtZYzd97VCpwi7h2tispABXwhb4aogI5rnAb0EDiJS
 vToJOJhcDyymJ+JULdrEPs8GNs5jVJ54sjdqh8jYttbFOPzV/Vi7QpcIZm3YHhDipgZQ=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4IN-000000001In-0M1h for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:07:08 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so1674716f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388020; x=1794992820; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kMke+iqbLZh9m95BdyxI70ngBkQPytwCzF3ecl20SJw=;
 b=NIJmumGHZmnciT2H5rA18WH3qZIgcif5iiz7APtVgbmKcS/u6+ekmD4G32Sp1kdypD
 qI4BKoT9s2vOlazCDWYJ+4u5iLxsaGl0UyH6b0/+bxtolWySqUrk6XjfVdMMNMwuo2mQ
 SCmmhN79Qj/xUbcXqoR6dAgC4Bi6sSeOK3ZTKnPr9pwwO2PLELQ7Gxdgu/FaFjbx+aW1
 1XpYqStu09TT/4A51h9A9Ia9btSYSCHbKV9/hC49nlN3lL9RkmpPT8fZk/sBV9bme7eb
 2+p3nAQG3bZ5u5pQLtbqJow9k4sORB7ITgbLmYdD3attXIDOIC2lvC3rm21z2kDFqGjw
 lcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388020; x=1794992820;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kMke+iqbLZh9m95BdyxI70ngBkQPytwCzF3ecl20SJw=;
 b=HZkNgsE9T+Cl8xdUNQrpEoyClYZT3eppmZmFNbPzYdJRniAKFiEYtHPYOCjxdTczPx
 eMv/HLVZeZ8nykWPZWxP1aPT7vPCQIUdODqFR19lGSrXjnp197E4aqOpEvK46iPR/+za
 KAk7sSTis/XproLNsld7XJtDu4NNhna8dZWqMGN+THbb9lEi/KbqoozoWwpcMC0t6ah3
 Y8nBjHc2073aIemA8rvC/H9uH0B0f1oh75tAmVLGE124U82XsRR16HToDDCEEXYXY8ei
 RPu5wAjCsT3zNqzSCa17FZEGiMdlauZ7A4zHaFlFLf2W/nuCq/Mu413LNSlLeIwnXX84
 flxg==
X-Gm-Message-State: APuU4Z8Hs59J5P3vx3mMaPW2Xt2pTku+u63tL4sDRZQ33TqhP9036TRA
 i2GBC7WzMSbwCD7/yNaL7VUxI2w9yuXKpgLMgCK6wUuDhKmWbeuqtFrb2hKe2UNBq+gQb8p8/AF
 GyHv0rjFADg30RaCwR91u60U0M8Dd5BXYicb0shIwi/sOa8bkdo9zb1zbqZZR9VC3XQ9hYqpP00
 SPwQOw3Q==
X-Gm-Gg: AYBFou2XSHQ1Yo4mYY2+DnWF5cm7KCuFdq66eb5Wu+0cqzlKbAPcfG44lAfmqhWOEqx
 tzjZ2ENwQYJNEqi8ao0mUIXnZZfzYXJbCWznsCe9LQoWgPw5+EHWUhpoYTUBHCCClQ64Iv2y02g
 IIay3vUKEtyYDZh46vYNwLmf2uEDAW0e1NgX50vA/jLlNQiNTbFNWHXSRayoQjAGONA3IIWWqBJ
 2F7E8jnjH1baMbL/LxH8YIFD7soY4K2H1hQ9SUzc1noK57i3CutvYssAaxk3SWjYIwveIoGjDsT
 gZ70lHP9yTQGApm1kLaIFtw61DxZ5Cte+BgiAtP6P7svYZKo4q3aGfYpGo8M4rxbklFvfm9/4cA
 zrpzVfJFoJ4HJU20Dz3IsvUblLxoV+0LYxfdT5Udn/6EAsXHcw8wEAmTImgVYJow8hT/6oKWCBN
 T8qN65EAfrQZXeyOraJdjoRYVMQd7zrRffFawjCvy3Ese8rzWnGERm/qKZ0m9h2H04UGKo/+viy
 TxzWQ793pAikl5SgtdgZjaUxpt4i6YVurmkZR5qsptindLsp/3RSSVmusuws9t7GfaDS3MTEz6m
 jFsfir/IsREzePlPVcXmdgGp1ye8SwbXLAxN0kZJTxEVkPMKJkCX02NXce1e6D6uR4IDdhVUyFz
 ai8FUng8Fu0nvJXDPwPD+8GoxYa3oL007AmX55gl68lNkXCyyrz1nDrTVs6jh+VDiDiq+D6t8Wv
 +i+Wekp21/ytixUW0=
X-Received: by 2002:a05:6000:40dc:b0:48d:f470:6b3e with SMTP id
 ffacd0b85a97d-499c727123amr2940416f8f.13.1794388020452; 
 Wed, 11 Nov 2026 01:07:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm11741744f8f.47.2026.11.11.01.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:07:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:06:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: 2e800a1dd0418ad2290286c2154a9466036f6233
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9dc6ae9c8570794e0860a533ba9b042868168c96-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4IN-000000001In-0M1h
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8770946235550649743=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8770946235550649743==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OLe4Fa8joSE="; charset=UTF-8

--OLe4Fa8joSE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2162?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Antonio Qua=
rtulli


Change subject: openvpnserv: keep IPv6 name servers in NRPT exclud=
e rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: keep IPv6 name servers in NRPT exclude rules

GetNrptExcludeData()=
 read the IPv6 name servers in after the IPv4 list,
but the IPv4 size inclu=
des the terminating NUL=2E With both present, the
string ended at the IPv4 =
list and the IPv6 servers never made it into
GenericDNSServers=2E Join the =
lists by replacing that NUL with a
delimiter=2E

Both readers now start fro=
m an empty string: RegGetValueA() leaves the
buffer untouched when the valu=
e is missing, and a slot is reused after
an interface is skipped, so an int=
erface without name servers could
inherit those of the skipped one=2E They =
also return the length of the
list without trailing delimiters, instead of =
the registry value size,
which can include NUL padding=2E

Broken since 0f3=
b7d17 ("win: implement --dns option support with
NRPT")=2E

Change-Id: Ic60=
2b125d857f1beed4af8661f522d339bc9e972
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 29 =
insertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/62/2162/2

diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 81205d6=2E=2E3af70f1 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -2128,6 +2128,24 @@
 }
 
 /**
+ * Remove trailing delimiters from a name =
server list
+ *
+ * @param  addrs      NUL-terminated list of addresses
+ *=

+ * @return the size of the list in bytes, including the terminating NUL
+=
 */
+static DWORD
+TrimNameServers(PSTR addrs)
+{
+    size_t len =3D strle=
n(addrs);
+    while (len && (addrs[len - 1] =3D=3D ',' || addrs[len - 1] =
=3D=3D ' '))
+    {
+        addrs[--len] =3D '\0';
+    }
+    return (DWO=
RD)len + 1;
+}
+
+/**
  * Get DNS server IPv4 addresses of an interface
  *=

  * @param  itf_key    registry key of the IPv4 interface data
@@ -2140,6 =
+2158,7 @@
 static LSTATUS
 GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PD=
WORD size)
 {
+    addrs[0] =3D '\0';
     addrs[*size - 1] =3D '\0';
 
   =
  LSTATUS err;
@@ -2165,7 +2184,7 @@
 
     if (strchr(addrs, '=2E'))
     =
{
-        *size =3D s;
+        *size =3D TrimNameServers(addrs);
        =
 return NO_ERROR;
     }
 
@@ -2178,13 +2197,15 @@
  *
  * @param  itf_key =
   registry key of the IPv6 interface data
  * @param  addrs      pointer t=
o the buffer addresses are returned in
- * @param  size       pointer to th=
e size of the buffer
+ * @param  size       pointer to the size of the buff=
er, contains the
+ *                    size of the addresses on return
  *=

  * @return LSTATUS NO_ERROR on success, a Windows error code otherwise
  =
*/
 static LSTATUS
 GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD siz=
e)
 {
+    addrs[0] =3D '\0';
     addrs[*size - 1] =3D '\0';
 
     LSTATU=
S err;
@@ -2231,12 +2252,11 @@
             pos +=3D addr_len;
            =
 s -=3D (DWORD)addr_len;
         }
-        s =3D (DWORD)strlen(addrs) + 1=
;
     }
 
     if (strchr(addrs, ':'))
     {
-        *size =3D s;
+     =
   *size =3D TrimNameServers(addrs);
         return NO_ERROR;
     }
 
@@ =
-2563,6 +2583,11 @@
                               __func__, itf_guid, err)=
;
                 goto next_itf;
             }
+            if (v4_addrs_=
size && v6_addrs_size)
+            {
+                /* Join the lists: r=
eplace the v4 terminating NUL with a delimiter */
+                v6_addrs=
[-1] =3D ',';
+            }
         }
 
         if (v4_addrs_size || v6_=
addrs_size)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2162?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic6=
02b125d857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 2162
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio=
@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--OLe4Fa8joSE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2162?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Antonio Quartulli</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ope=
nvpnserv: keep IPv6 name servers in NRPT exclude rules<br><br>GetNrptExclud=
eData() read the IPv6 name servers in after the IPv4 list,<br>but the IPv4 =
size includes the terminating NUL=2E With both present, the<br>string ended=
 at the IPv4 list and the IPv6 servers never made it into<br>GenericDNSServ=
ers=2E Join the lists by replacing that NUL with a<br>delimiter=2E<br><br>B=
oth readers now start from an empty string: RegGetValueA() leaves the<br>bu=
ffer untouched when the value is missing, and a slot is reused after<br>an =
interface is skipped, so an interface without name servers could<br>inherit=
 those of the skipped one=2E They also return the length of the<br>list wit=
hout trailing delimiters, instead of the registry value size,<br>which can =
include NUL padding=2E<br><br>Broken since 0f3b7d17 (&quot;win: implement -=
-dns option support with<br>NRPT&quot;)=2E<br><br>Change-Id: Ic602b125d857f=
1beed4af8661f522d339bc9e972<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file chan=
ged, 29 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/2162/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2E=
c</span><br><span>index 81205d6=2E=2E3af70f1 100644</span><br><span>--- a/s=
rc/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/intera=
ctive=2Ec</span><br><span>@@ -2128,6 +2128,24 @@</span><br><span> }</span><=
br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Remove trailing delimiters from a name server list</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param  addrs      NUL-terminated list of a=
ddresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the size of the l=
ist in bytes, including the terminating NUL</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+TrimNameServers(PSTR addrs)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t len =3D strlen(addrs);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    while (len &amp;&amp; (addrs[len - 1] =3D=3D &#39;,&#39; || addrs[=
len - 1] =3D=3D &#39; &#39;))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    addrs[--len] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return (DWORD)len + 1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get D=
NS server IPv4 addresses of an interface</span><br><span>  *</span><br><spa=
n>  * @param  itf_key    registry key of the IPv4 interface data</span><br>=
<span>@@ -2140,6 +2158,7 @@</span><br><span> static LSTATUS</span><br><span=
> GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addrs[0] =3D=
 &#39;\0&#39;;</span><br><span>     addrs[*size - 1] =3D &#39;\0&#39;;</spa=
n><br><span> </span><br><span>     LSTATUS err;</span><br><span>@@ -2165,7 =
+2184,7 @@</span><br><span> </span><br><span>     if (strchr(addrs, &#39;=
=2E&#39;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        *size =3D s;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        *size =3D TrimNameServers(addrs);</span><br><span>    =
     return NO_ERROR;</span><br><span>     }</span><br><span> </span><br><s=
pan>@@ -2178,13 +2197,15 @@</span><br><span>  *</span><br><span>  * @param =
 itf_key    registry key of the IPv6 interface data</span><br><span>  * @pa=
ram  addrs      pointer to the buffer addresses are returned in</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param  size       pointer to =
the size of the buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param  size       pointer to the size of the buffer, contains the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                    =
size of the addresses on return</span><br><span>  *</span><br><span>  * @re=
turn LSTATUS NO_ERROR on success, a Windows error code otherwise</span><br>=
<span>  */</span><br><span> static LSTATUS</span><br><span> GetItfDnsServer=
sV6(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    addrs[0] =3D &#39;\0&#39;;</s=
pan><br><span>     addrs[*size - 1] =3D &#39;\0&#39;;</span><br><span> </sp=
an><br><span>     LSTATUS err;</span><br><span>@@ -2231,12 +2252,11 @@</spa=
n><br><span>             pos +=3D addr_len;</span><br><span>             s =
-=3D (DWORD)addr_len;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        s =3D (DWORD)strlen(addrs) + 1;</span><b=
r><span>     }</span><br><span> </span><br><span>     if (strchr(addrs, &#3=
9;:&#39;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        *size =3D s;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        *size =3D TrimNameServers(addrs);</span><br><span>    =
     return NO_ERROR;</span><br><span>     }</span><br><span> </span><br><s=
pan>@@ -2563,6 +2583,11 @@</span><br><span>                               _=
_func__, itf_guid, err);</span><br><span>                 goto next_itf;</s=
pan><br><span>             }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (v4_addrs_size &amp;&amp; v6_addrs_size)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                /* Join the lists: r=
eplace the v4 terminating NUL with a delimiter */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                v6_addrs[-1] =3D &#39;,&#39;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span>         }</span><br><span> </span><br><span>         if (v4_add=
rs_size || v6_addrs_size)</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail">change 2162</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic602=
b125d857f1beed4af8661f522d339bc9e972 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2162 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--OLe4Fa8joSE=--


--===============8770946235550649743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8770946235550649743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8770946235550649743==--

