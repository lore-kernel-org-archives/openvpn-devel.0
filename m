Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFFE606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RIraH1p/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EYMSoar/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gRJjv558;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NJJeWrry
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0ojQLP8Y1gyAkoYvXA3XqGlMo9RDVFdIIL4HD+igmd4=; b=RIraH1p/LoCGvDjEIPpcQ3Imdn
	V7abUH0qBpWaDak5bPsTdbmrHYxYnInFjBdPW1GpwjyMba/IAusNEN/lj3zECO8/Npw38HokOa9cy
	b49Q+/O/jXgBsCLJdl2EjBWfi2Bg6O17SPZQDEMOMOgNwQJfq3BGvNWpWuyJeJhZHhhE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYqi-000000004yl-04wo;
	Thu, 12 Nov 2026 17:44:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYqg-000000004yW-0JIn
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:44:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KzFIUpyaJCOaEQ+WRQ+nUzSY+2YZvVgV26N5KZ9hbWg=; b=EYMSoar/eeE4Nzk5Qp1pyAnL6u
 GdfvgQeTfXHbdsk0WrSPmqW+aqolaV0/oRgOrk+9MniLgd7iHm7Wsq/jwPQ+p57MrTEzLPd0CNM8u
 utzwQzTMe0/jSE43eo4X3FMXBttKzTpZA8l+azgpJ6JoE4cdyYdqWBBiRct6BUiGjG2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KzFIUpyaJCOaEQ+WRQ+nUzSY+2YZvVgV26N5KZ9hbWg=; b=gRJjv558OQN4OIgEAFrg2jC7i0
 d8+28oIbjpvxar02p2abM+TTehjgmqw/KQ+TERnWXulOFrBg0LkkVqMKfCqppe1z2OJ5b5nmSMdme
 U1WYi0NaL9BsuRcKOdzPytGCG+LgjdPKy36AMC8zN4P6J4PLEOggeNHSt9iaZN8ogTP4=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYqe-000000003s3-1AE7 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:44:33 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso6573f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794505466; x=1795110266; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KzFIUpyaJCOaEQ+WRQ+nUzSY+2YZvVgV26N5KZ9hbWg=;
 b=NJJeWrryKvR0LeJ2gqX13U5roWAHK63MisaHa0hmVrEWi7oL5e2c+oW8tMwZlDSYY1
 QBFyUCMzpW5fQx7q3XVbzlsuA5TicfsnqKujB0uqWT47f9BGRdyeBtQIm8lW/7yXt/io
 81YvpQv/s12v0PvSmi7xRa69duAFRieBLV2nu8GBZUrMwgnJqDsPb4IdC3OxCxan3ecx
 8Xibv3CrBA2f9qi9agbOuyxhmSSFgwVARCwQF3k5jLcPyWc1zmPuuH7ttrIey0ix1fMY
 WOJ4eAYxTfpIv6jUQKG6y+G4QyGgjrTzsUpQIGkGqgRTlw+TsbLrSzoTiDMrw3p+NG1k
 ygDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505466; x=1795110266;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KzFIUpyaJCOaEQ+WRQ+nUzSY+2YZvVgV26N5KZ9hbWg=;
 b=CsbEvOZ/LuuUZN7kmeQ5eJMH4QMGU0/3O15bkw0ME7TGjhlwfd+Q+C5jDXySeu1mgQ
 f1/ghu82WRCVxJT6DV+8Q6V2WyQN81YCUqpqGnmI0/iaxmHwIsVzjSf3VhHqnkp+96Ki
 DqJNi1qMrQ3nhsGmqTh5Rkw2taxg/Smr0X0jFkxnxw1J4ZdW2nKRQFOPr5fKtfPB+5So
 V6cDPt8b2DnVOIJ3UxWvRBhBdrf0KOVX4COpA+ri+ZK1RPbI/IW8/CmGSVO68sn+V4Wt
 6/pjRgXom8JAYcXzz0kjRLh+GFWjQVhXRcjNc5312UWPge/xIIn5+HK5S/G8pN0Atp1c
 bLvw==
X-Gm-Message-State: APuU4Z9409CJOwHeYruuy0c5258C0mMxAg9Ij+Iz0eM0NzKP/FOiPiTe
 MOJLzerZqlUZ39eFIi+zWiWpj6gYBd4IuWUP2QBGasOBpvZixOdMXSfbGWEIdTeIyQ3JzipYU6u
 2nHTf4eHzODvZtplB9tH9IJZJF3BmabtKy90L2paE4WIJBphJqhvrJSz9N7xZhPYH9iFb
X-Gm-Gg: AYBFou2ED/JY4Libw/cVJSqEt1Ft9nNaUJVIh4wCte8VqQ1xeXt0BEKg3acmlIx0mO/
 1IaVPUwyvS9Uq9AmlMC1t+h1sYhIhRPHScZ8kMz/tGhaQ5pMoP7DXNp5D7HrPqCQNBsJLr9NS5o
 HvXlotNZm9UQVKfpc7Jz6YISq17wuk93dwTchoUmgS/2gWfE+mC6xrwAvmEMxrBx3e66A1Tf0Tw
 uqzFqTcmm+w5wUgVo92TS6BTaBr23spxjDFDcZMEZVQElMRM3y01BXN63u5sR0DReP6Je12JwhP
 sNXY2hhH56jy60ezPkFCuArPoCqO4byB1/nsZTjIGKALf5FF2WqVzB2I2V9dL/tmfKAZv+pDApg
 AIp8+D7bNuiTDzvTZHhhddlArchd+iyQgt4acNQ2XTBD6FDvNUUg/6SL5n/uRc1kol6N/mYx9yN
 qrYJBUC1KgTzaspZw22p0wHaJLGV3NNU+mjYp6IPJ/ZWpuIs5jmWtMjxuNQ7JK0vVBs5L4WS6gZ
 Hn61PzM3KDkTNTcgfVREUkyeRHS566UYFn+LJxuto+O3P4ojrs+XU6CuRwD1CqCTjIKiUyWE1WY
 2JOCvm1bZmD9r8agqgqTw3ZRN/66RFDpNJxgaZDAHhpcunDOHfgj8ATnufpkP7hJxhLjUsg+/WY
 Q94Y3K4qMYJcz6fcMJAMTLsQ2Hk+5//+RF9NgHQZXZ6AqRk8ZsmqVecWFPakyyOzSEsHpseevhZ
 c+RTOWJSZjq1CPHe0=
X-Received: by 2002:a05:6000:26c8:b0:491:ed89:a38f with SMTP id
 ffacd0b85a97d-49c73631471mr168623f8f.23.1794505465514; 
 Thu, 12 Nov 2026 09:44:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm397634f8f.27.2026.11.12.09.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:44:25 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:44:23 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: b81201a9c5f58370555f91a78d696969f8f21965
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2fffbac892b6e45abaa01d72c4fd0884b44b652d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYqe-000000003s3-1AE7
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8315626334055373015=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8315626334055373015==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z8Av2YRVIBQ="; charset=UTF-8

--Z8Av2YRVIBQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2162?usp=3Demail

to look at the new patch set (#4)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+2 by Antonio Qua=
rtulli

The change is no longer submittable: Code-Review and checks~ChecksS=
ubmitRule are unsatisfied now=2E


Change subject: openvpnserv: keep IPv6 n=
ame servers in NRPT exclude rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

openvpnserv: keep IPv6 name servers in NRPT exclude =
rules

GetNrptExcludeData() stored the IPv6 name servers after the IPv4 lis=
t,
but the IPv4 size includes the terminating NUL=2E With both present, the=

string ended at the IPv4 list and the IPv6 servers never made it into
Gene=
ricDNSServers=2E Join the lists by replacing that NUL with a
delimiter=2E

=
Both readers now start from an empty string: RegGetValueA() leaves the
buff=
er untouched when the value is missing, and a slot is reused after
an inter=
face is skipped, so an interface without name servers could
inherit those o=
f the skipped one=2E They also return the length of the
list without traili=
ng delimiters, instead of the registry value size,
which can include NUL pa=
dding=2E

Broken since 0f3b7d17 ("win: implement --dns option support with
=
NRPT")=2E

Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Signed-off-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interacti=
ve=2Ec
1 file changed, 29 insertions(+), 4 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/2162/4

diff --git a/s=
rc/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 8120=
5d6=2E=2E1b76003 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/ope=
nvpnserv/interactive=2Ec
@@ -2128,6 +2128,24 @@
 }
 
 /**
+ * Remove traili=
ng delimiters from a name server list
+ *
+ * @param  addrs      NUL-termin=
ated list of addresses
+ *
+ * @return the size of the list in bytes, inclu=
ding the terminating NUL
+ */
+static DWORD
+TrimNameServers(PSTR addrs)
+{=

+    size_t len =3D strlen(addrs);
+    while (len && (addrs[len - 1] =3D=
=3D ',' || addrs[len - 1] =3D=3D ' '))
+    {
+        addrs[--len] =3D '\0=
';
+    }
+    return (DWORD)len + 1;
+}
+
+/**
  * Get DNS server IPv4 add=
resses of an interface
  *
  * @param  itf_key    registry key of the IPv4 =
interface data
@@ -2140,6 +2158,7 @@
 static LSTATUS
 GetItfDnsServersV4(HK=
EY itf_key, PSTR addrs, PDWORD size)
 {
+    addrs[0] =3D '\0';
     addrs[=
*size - 1] =3D '\0';
 
     LSTATUS err;
@@ -2165,7 +2184,7 @@
 
     if (s=
trchr(addrs, '=2E'))
     {
-        *size =3D s;
+        *size =3D TrimNa=
meServers(addrs);
         return NO_ERROR;
     }
 
@@ -2178,13 +2197,15 @=
@
  *
  * @param  itf_key    registry key of the IPv6 interface data
  * @p=
aram  addrs      pointer to the buffer addresses are returned in
- * @param=
  size       pointer to the size of the buffer
+ * @param  size       point=
er to the size of the buffer, contains the
+ *                    size of t=
he addresses on return
  *
  * @return LSTATUS NO_ERROR on success, a Windo=
ws error code otherwise
  */
 static LSTATUS
 GetItfDnsServersV6(HKEY itf_k=
ey, PSTR addrs, PDWORD size)
 {
+    addrs[0] =3D '\0';
     addrs[*size - =
1] =3D '\0';
 
     LSTATUS err;
@@ -2231,12 +2252,11 @@
             pos +=
=3D addr_len;
             s -=3D (DWORD)addr_len;
         }
-        s =
=3D (DWORD)strlen(addrs) + 1;
     }
 
     if (strchr(addrs, ':'))
     {
=
-        *size =3D s;
+        *size =3D TrimNameServers(addrs);
         r=
eturn NO_ERROR;
     }
 
@@ -2563,6 +2583,11 @@
                           =
    __func__, itf_guid, err);
                 goto next_itf;
             =
}
+            if (v4_addrs_size && v6_addrs_size)
+            {
+        =
        /* Join the lists: replace the v4 terminating NUL with a delimiter =
*/
+                data[i]=2Eaddresses[v4_addrs_size - 1] =3D ',';
+      =
      }
         }
 
         if (v4_addrs_size || v6_addrs_size)

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic602b125d857f1beed4af86=
61f522d339bc9e972
Gerrit-Change-Number: 2162
Gerrit-PatchSet: 4
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Qu=
artulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>

--Z8Av2YRVIBQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #4</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2162?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by Antonio Quartulli</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">openvpnserv: keep IPv6 name servers in NRPT exc=
lude rules<br><br>GetNrptExcludeData() stored the IPv6 name servers after t=
he IPv4 list,<br>but the IPv4 size includes the terminating NUL=2E With bot=
h present, the<br>string ended at the IPv4 list and the IPv6 servers never =
made it into<br>GenericDNSServers=2E Join the lists by replacing that NUL w=
ith a<br>delimiter=2E<br><br>Both readers now start from an empty string: R=
egGetValueA() leaves the<br>buffer untouched when the value is missing, and=
 a slot is reused after<br>an interface is skipped, so an interface without=
 name servers could<br>inherit those of the skipped one=2E They also return=
 the length of the<br>list without trailing delimiters, instead of the regi=
stry value size,<br>which can include NUL padding=2E<br><br>Broken since 0f=
3b7d17 (&quot;win: implement --dns option support with<br>NRPT&quot;)=2E<br=
><br>Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972<br>Signed-off-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpnserv/=
interactive=2Ec<br>1 file changed, 29 insertions(+), 4 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/62/2162/4</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/=
src/openvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=2E1b76003 =
100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><spa=
n>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2128,6 +2128,24=
 @@</span><br><span> }</span><br><span> </span><br><span> /**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Remove trailing delimiters fro=
m a name server list</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  addrs=
      NUL-terminated list of addresses</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return the size of the list in bytes, including the terminating NUL</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+TrimNameServers(PSTR addrs)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t len =3D strlen(addrs);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    while (len &amp;&amp; (addrs[len - 1=
] =3D=3D &#39;,&#39; || addrs[len - 1] =3D=3D &#39; &#39;))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        addrs[--len] =3D &#39;\0&#39;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return (DWORD)len + 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span>  * Get DNS server IPv4 addresses of an interface</spa=
n><br><span>  *</span><br><span>  * @param  itf_key    registry key of the =
IPv4 interface data</span><br><span>@@ -2140,6 +2158,7 @@</span><br><span> =
static LSTATUS</span><br><span> GetItfDnsServersV4(HKEY itf_key, PSTR addrs=
, PDWORD size)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    addrs[0] =3D &#39;\0&#39;;</span><br><span>     addrs[*si=
ze - 1] =3D &#39;\0&#39;;</span><br><span> </span><br><span>     LSTATUS er=
r;</span><br><span>@@ -2165,7 +2184,7 @@</span><br><span> </span><br><span>=
     if (strchr(addrs, &#39;=2E&#39;))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        *size =3D s;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        *size =3D TrimNameServers(=
addrs);</span><br><span>         return NO_ERROR;</span><br><span>     }</s=
pan><br><span> </span><br><span>@@ -2178,13 +2197,15 @@</span><br><span>  *=
</span><br><span>  * @param  itf_key    registry key of the IPv6 interface =
data</span><br><span>  * @param  addrs      pointer to the buffer addresses=
 are returned in</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram  size       pointer to the size of the buffer</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param  size       pointer to the size of=
 the buffer, contains the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *                    size of the addresses on return</span><br><span=
>  *</span><br><span>  * @return LSTATUS NO_ERROR on success, a Windows err=
or code otherwise</span><br><span>  */</span><br><span> static LSTATUS</spa=
n><br><span> GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ddrs[0] =3D &#39;\0&#39;;</span><br><span>     addrs[*size - 1] =3D &#39;\0=
&#39;;</span><br><span> </span><br><span>     LSTATUS err;</span><br><span>=
@@ -2231,12 +2252,11 @@</span><br><span>             pos +=3D addr_len;</sp=
an><br><span>             s -=3D (DWORD)addr_len;</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s =3D (DWORD=
)strlen(addrs) + 1;</span><br><span>     }</span><br><span> </span><br><spa=
n>     if (strchr(addrs, &#39;:&#39;))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        *size =3D s;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        *size =3D TrimNameServers(=
addrs);</span><br><span>         return NO_ERROR;</span><br><span>     }</s=
pan><br><span> </span><br><span>@@ -2563,6 +2583,11 @@</span><br><span>    =
                           __func__, itf_guid, err);</span><br><span>      =
           goto next_itf;</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (v4_addrs_size &amp;&am=
p; v6_addrs_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        /* Join the lists: replace the v4 terminating NUL with a delimiter =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                d=
ata[i]=2Eaddresses[v4_addrs_size - 1] =3D &#39;,&#39;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>         }=
</span><br><span> </span><br><span>         if (v4_addrs_size || v6_addrs_s=
ize)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2162?usp=3Demail">change 2162</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Ic602b125d857f1beed4af866=
1f522d339bc9e972 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2162 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlich=
=2Enet&gt; </div>
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
--Z8Av2YRVIBQ=--


--===============8315626334055373015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8315626334055373015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8315626334055373015==--

