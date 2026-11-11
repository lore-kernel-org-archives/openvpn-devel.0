Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1973606A331
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V5zEOr0L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MC3GKz1q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hnN3AZtN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O2SJvPAY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bPUad/D8IEE8cWKJZ4M6uHH/g9y1cOcKmJVXcdrZEQU=; b=V5zEOr0LgAoSE3Hem2QQH9QzyZ
	zbOr4KJ9RVqMD74pzUbJjLlczFPazt+UNYyKTNmwswCKKeFJa+V28vWubM0xFF+jldyziNfHtSmO0
	a7urT887NRSVqrBLedrZC42r53taB13Wa+KA3qZJxbuOw/ZSpRWlZ9uf4Cn4VcLIUt24=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Wx-000000003c2-1Bbs;
	Wed, 11 Nov 2026 09:22:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4Wv-000000003bS-48kD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:22:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WRgkYVYygt9UmEIu0mPn/2/KScfk40KiKcKSP1hdX0s=; b=MC3GKz1qqc4mSLaBdRcQwD6WMo
 cq5xEPInqbMt46qkOrjBrzZpVWAZhTyzSYRvAurXVSPJ7BbNaPqIXoNMA+VKSa1Dlzx8QytASdsQu
 AMmvRBalG58duchsofATJ06lNEB1XIT2vv5t6Ez7SzdMDEOPKoaHVZLbFRHti8Vyhkiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WRgkYVYygt9UmEIu0mPn/2/KScfk40KiKcKSP1hdX0s=; b=hnN3AZtNtobMyxbA+0ziC8e9gF
 VpZHe1tJpMsABm+FzJtY8KAYdM8fh8eBGnNzSx6AKCY1zS8Tuud2AaIQ1ksseHzlmBvaHdMP4myhe
 wA0KKmzEIPsFGsBS7+DrOEWHMR8sPq/KoHhHlTk3n89UHKH6uQIAvkaV+AXO2ZpnHDcY=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4Wu-0000000028b-1q5G for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:22:09 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so17463325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388922; x=1794993722; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WRgkYVYygt9UmEIu0mPn/2/KScfk40KiKcKSP1hdX0s=;
 b=O2SJvPAYprMgxT7X7zpn1wEJAJlr9zRNMNWZstMRXPQ0+OjyUZLIUyaPEmG88Odrgu
 6KWn2IqGem45Vrn++ytwp3Ly+1AVGlX6TbeVc2EiXLwPb5RnsavzPVNYEaSkqPGZcpDr
 P4/fQAa9L8xIHNkOns+ED2lMWl/0dS2pzBxORVyeHNH5S39TbU3l6dVbIOnKipEOo+z2
 GMh6d+mXj1nplJexLHEhs/Vat6ShqKk1MJmEmQPzzgSivT66PWmxYZh4nRrVm0/OLZAJ
 uK2kcvVxjfq/DSd6iWilXhI4N6lrEL1iEslNOshLPJ9LfXwq96VmfmO/toyBx7yaxIgt
 r4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388922; x=1794993722;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WRgkYVYygt9UmEIu0mPn/2/KScfk40KiKcKSP1hdX0s=;
 b=smjTkbe0e6Fp/SqyOmVZzPVFoszBccUaYtuNm9dpQ5/vFvyLmd3NpBskAXpzImqnLN
 g0LECaT9lH6xqQTT2Ku+NECCBInbllFAo5mZr2RyoZJNnadom8ekvEO8vZg4Lxu4tSrB
 WpUIP2DJdyAQQfA8opBlX5ac83FBz9zpxLBRpcUg/uHWk1vGoJDw5zkPip4yax2hmu1+
 J4eN+3s52LHj0BKPfBvt/VppMjS/5D+2Sk3pSd2SpXY0RJARwX2DTzo4PFViBeVgAxN9
 9KIHVIHZGqSo1GfN73eHh7Xxe1FPV4fv78j2zSHXsZi+4JFmlnVrRkIEsy9OuMPUK4fB
 czag==
X-Gm-Message-State: APuU4Z8vvQFXMQ07uSzGwK6OkAakQRass/Yb5spvR7UpP+xakmIFHez+
 SpOHTEk+sAZL+lvNx1hoWauJMpXGXh5cBbML0ysjTyDUL1bm5lAvtO9+KGhIWD1WQy87+4dQrjG
 I5wZ4Nf836Gg/hRBp0IiOjIDtstCV5g/H7fFvbeQFrIiSm2etaEXSCMo8fmH/NdG43Wn7p5iPot
 j4gai78Q==
X-Gm-Gg: AYBFou2v+EAmBgFd3Q7Yy91S1sYJuTuO7tsYk71pKvid2fpcPQjBxyvW0ZI9hIWzj62
 UFCVFMnWfa7cuWhSYuottpUsB7BjQ2hETMrZVB8+hVv5DcMxfv88Br2rfnMIPbtG3m/TO+lx4km
 kJMjy6C7IGQftpCXArfARBPdBDSwsLXYiJQ2Qrkxy2BuDA5Pt1c5B8D3wWnbP8IIJM1n2vLAyxb
 w0y+DJXTg1cTZjmCFB2Dlh2BLK3XuHXXWG7Rw52Ww4K1TlY+w8rTog18D1YNImObsbVsIaze+kI
 PJVe6ZdudV2kx0nrA1JR/+krh0XRP1N5cX/Xc6GH+pTJH98FnTMy+AS4wEUUf6W1ogF9Md5UR4a
 htkH+4Pe8sGQ5PHhEVEEFCFxcaPpT+FD9dwBfurnFSiL6qzZLBhAndtgXP0cp/P3H2xKLWCvtxf
 u1tYKo6cXsZw+AocDEtT4UQ11JrJv/Ebz/zjelKKIAzCMJ8aqWizwLLUJBsZ6wsQGNCFePTNwRR
 KedKAleE+yppZb1N7WAK5RMGxFsz/Eey8oxBPRQhAs+tPJNGz20FUAc028DU9t+leauJpqs0a0L
 oeppwFGRUpRHnXrlL+0ezx6ypgiT83WAdYuYWjFGwAPXD1JBcqTWkhudIyrF5Go7zdgr5bLxUtu
 mfc+esHIWOA3SOG19LFfrq2AREJsaUAUwuOf+YgfqMaDqIYbw+pgGAyL9zLiVuZPb4O2QyzNEmJ
 B7WKQoqmUlIX5ImnzWvZKb/fxktWgmAcrbdQa+
X-Received: by 2002:a05:600c:608e:b0:4b0:b9ff:1e7c with SMTP id
 5b1f17b1804b1-4ba093805a8mr30654505e9.15.1794388921759; 
 Wed, 11 Nov 2026 01:22:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fdac9csm193094365e9.0.2026.11.11.01.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:22:01 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:21:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: c4d3d47750d4359fe2726370f3a69c3558932737
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <618521bbc73018ff9bf44c91f9d92d66597a77b9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4Wu-0000000028b-1q5G
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
Content-Type: multipart/mixed; boundary="===============0960845292250976142=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0960845292250976142==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fegcz5M/akg="; charset=UTF-8

--fegcz5M/akg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2162?usp=3Demail

to look at the new patch set (#3)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+2 by Antonio Qua=
rtulli


Change subject: openvpnserv: keep IPv6 name servers in NRPT exclud=
e rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: keep IPv6 name servers in NRPT exclude rules

GetNrptExcludeData()=
 stored the IPv6 name servers after the IPv4 list,
but the IPv4 size includ=
es the terminating NUL=2E With both present, the
string ended at the IPv4 l=
ist and the IPv6 servers never made it into
GenericDNSServers=2E Join the l=
ists by replacing that NUL with a
delimiter=2E

Both readers now start from=
 an empty string: RegGetValueA() leaves the
buffer untouched when the value=
 is missing, and a slot is reused after
an interface is skipped, so an inte=
rface without name servers could
inherit those of the skipped one=2E They a=
lso return the length of the
list without trailing delimiters, instead of t=
he registry value size,
which can include NUL padding=2E

Broken since 0f3b=
7d17 ("win: implement --dns option support with
NRPT")=2E

Change-Id: Ic602=
b125d857f1beed4af8661f522d339bc9e972
Signed-off-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 29 i=
nsertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/62/2162/3

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
tchSet: 3
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

--fegcz5M/akg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #3</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2162?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by Antonio Quartulli</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ope=
nvpnserv: keep IPv6 name servers in NRPT exclude rules<br><br>GetNrptExclud=
eData() stored the IPv6 name servers after the IPv4 list,<br>but the IPv4 s=
ize includes the terminating NUL=2E With both present, the<br>string ended =
at the IPv4 list and the IPv6 servers never made it into<br>GenericDNSServe=
rs=2E Join the lists by replacing that NUL with a<br>delimiter=2E<br><br>Bo=
th readers now start from an empty string: RegGetValueA() leaves the<br>buf=
fer untouched when the value is missing, and a slot is reused after<br>an i=
nterface is skipped, so an interface without name servers could<br>inherit =
those of the skipped one=2E They also return the length of the<br>list with=
out trailing delimiters, instead of the registry value size,<br>which can i=
nclude NUL padding=2E<br><br>Broken since 0f3b7d17 (&quot;win: implement --=
dns option support with<br>NRPT&quot;)=2E<br><br>Change-Id: Ic602b125d857f1=
beed4af8661f522d339bc9e972<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file chang=
ed, 29 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/2162/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec=
</span><br><span>index 81205d6=2E=2E3af70f1 100644</span><br><span>--- a/sr=
c/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interac=
tive=2Ec</span><br><span>@@ -2128,6 +2128,24 @@</span><br><span> }</span><b=
r><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Remove trailing delimiters from a name server list</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param  addrs      NUL-terminated list of ad=
dresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the size of the li=
st in bytes, including the terminating NUL</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
TrimNameServers(PSTR addrs)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 len =3D strlen(addrs);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    while (len &amp;&amp; (addrs[len - 1] =3D=3D &#39;,&#39; || addrs[l=
en - 1] =3D=3D &#39; &#39;))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   addrs[--len] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return (DWORD)len + 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get DN=
S server IPv4 addresses of an interface</span><br><span>  *</span><br><span=
>  * @param  itf_key    registry key of the IPv4 interface data</span><br><=
span>@@ -2140,6 +2158,7 @@</span><br><span> static LSTATUS</span><br><span>=
 GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span>=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addrs[0] =3D =
&#39;\0&#39;;</span><br><span>     addrs[*size - 1] =3D &#39;\0&#39;;</span=
><br><span> </span><br><span>     LSTATUS err;</span><br><span>@@ -2165,7 +=
2184,7 @@</span><br><span> </span><br><span>     if (strchr(addrs, &#39;=2E=
&#39;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        *size =3D s;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        *size =3D TrimNameServers(addrs);</span><br><span>       =
  return NO_ERROR;</span><br><span>     }</span><br><span> </span><br><span=
>@@ -2178,13 +2197,15 @@</span><br><span>  *</span><br><span>  * @param  it=
f_key    registry key of the IPv6 interface data</span><br><span>  * @param=
  addrs      pointer to the buffer addresses are returned in</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param  size       pointer to the=
 size of the buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param  size       pointer to the size of the buffer, contains the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                    siz=
e of the addresses on return</span><br><span>  *</span><br><span>  * @retur=
n LSTATUS NO_ERROR on success, a Windows error code otherwise</span><br><sp=
an>  */</span><br><span> static LSTATUS</span><br><span> GetItfDnsServersV6=
(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    addrs[0] =3D &#39;\0&#39;;</span=
><br><span>     addrs[*size - 1] =3D &#39;\0&#39;;</span><br><span> </span>=
<br><span>     LSTATUS err;</span><br><span>@@ -2231,12 +2252,11 @@</span><=
br><span>             pos +=3D addr_len;</span><br><span>             s -=
=3D (DWORD)addr_len;</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        s =3D (DWORD)strlen(addrs) + 1;</span><br=
><span>     }</span><br><span> </span><br><span>     if (strchr(addrs, &#39=
;:&#39;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        *size =3D s;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        *size =3D TrimNameServers(addrs);</span><br><span>     =
    return NO_ERROR;</span><br><span>     }</span><br><span> </span><br><sp=
an>@@ -2563,6 +2583,11 @@</span><br><span>                               __=
func__, itf_guid, err);</span><br><span>                 goto next_itf;</sp=
an><br><span>             }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (v4_addrs_size &amp;&amp; v6_addrs_size)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                /* Join the lists: re=
place the v4 terminating NUL with a delimiter */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                v6_addrs[-1] =3D &#39;,&#39;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span>         }</span><br><span> </span><br><span>         if (v4_addr=
s_size || v6_addrs_size)</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail">change 2162</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
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
t: 3 </div>
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
--fegcz5M/akg=--


--===============0960845292250976142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0960845292250976142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0960845292250976142==--

