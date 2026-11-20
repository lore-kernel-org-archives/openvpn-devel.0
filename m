Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F3606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Sp8Vk82o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gpalGrpF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JohrNT2F;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=b2l8Lmgu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NnmZR3nwTC1IMSXgtAuDOxLiFQLgcCLir1V3sEyUUak=; b=Sp8Vk82oQqkg+zs18Rp7rEWLsZ
	ML1545PE/APNnmwIj08bEhAL8LXM8jORwewHJlVm12nCXD+rgMdDHXVVu3Ts06AC01d3lsELzLaJY
	qymbsVOz/p2qZAWkI8SP64V64VA1dh9lVP1ffCiRFQrv8Qx7Q8kbyUf0Pg6d/NkpFDYk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUIA6-0000000057E-1u6p;
	Fri, 20 Nov 2026 06:31:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUIA5-00000000570-0rbC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=661sx9RlDBb7gbkmtWSFUvAYovw+7bfyD2QVD6Q5Z58=; b=gpalGrpFKyPQNhfQqBQOekQfXZ
 w9h4DzXedYBbrt4ZWGVzfBN9Y6TVR/K5R4gZVG4HIIQqJ8uR7rjhGDixRVAzmR530jIm1diEDI/UN
 wc7MvKSGdX603AufxzpKVb1gc5cRU+CUO7K3l3zYdGrHdG29bxze9mgj5fz7LOFuOR6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=661sx9RlDBb7gbkmtWSFUvAYovw+7bfyD2QVD6Q5Z58=; b=JohrNT2Fw88HDm95acf8Y0n6EC
 zEVS9+5IyN0BTT0bDsRsW5op70hB4KnmgQ8gOYAZjm4wvFFcFL97bCmrwkKuPqIK4uyrxo7UgdYXV
 gvZsPBQta7oiEhPDce0lynXxxKYS/X4/zMfd6XsquqTVRyrCq3qekigw22CX4TdEF1dI=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUIA2-0000000047j-3ZdP for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:31:53 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso3085855e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 22:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795156304; x=1795761104; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=661sx9RlDBb7gbkmtWSFUvAYovw+7bfyD2QVD6Q5Z58=;
 b=b2l8LmguVICf2aR6CqOuShwRVzDLmcswqneDV1e/Tl+Jv/g8eJsoFucGWYls2WD502
 g7xyqDFo3SpcbHanVQP78p7+e0fLJ8KZmAzaEc6YXaJbMkyAog0J2uLzL4gW2CqlOE6b
 t8LC4CXwRC+gaiheZ4z1CN3eIUlIjrTvvhauD3I3bHWzk9ErUyL/hwdelw/kiXpp2Wt/
 2fRG2WGSoO94e4sDZS/6ZMZTC+xQmv4csHhyQjw6ctlDTSGX+jTQC59CRdFtcW7a51do
 omyOkatDq4z3OPS9D9ip3qZdHoe2e5hUmPIo7qqmQqRDFlzG36G899ycHxsISvlniwR/
 g9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795156304; x=1795761104;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=661sx9RlDBb7gbkmtWSFUvAYovw+7bfyD2QVD6Q5Z58=;
 b=YUvAJywLtRQKcEgvBK9IkEUb9U8vbe2clKGWUguWIN/m/uaTM0TTxje3SRFJN3Aj5G
 X016eUWU0RTgF1EemeEru6tMBkA7io7Q8LEmohNaed1KLUkJYBQK07safpx2RxYercrj
 +FngHM4aih/944sgMcufR+Tzo9qX16fRxt5fOOleP9DcOOKEoDvYGIMcBLcAoqYPeDty
 S6vHRaVcdDzaPiGa2E1OEJrlFOLEd+XxOknH8WkMZh6IDKIOQ9BEiIXOo4dSNwkrM1XQ
 B8macP2QhqtKwhmQhWleMPLiKZIHASUWdGJEIq2R5F8Wa7CQoOkOa6yqhe6FZuYPTso3
 T6Ew==
X-Gm-Message-State: APuU4Z8h/zUgyfZp86RTCJfHxk0DilImdgDX8gVMV5wnr9UDdG2EwEZS
 MnLN+VcHFq+aQ6Y2njc+PNXgE+ge/CobXIUv80Mvhd52SqICSabOAluwHXZiFL3Ov4aHoNF+mex
 3rlPfkslmI7ZVhegziwNWfEmZq6Ct6K4uqjL5HiQXJLzPrQ6P8XiK1EuprxENzT1y6WLX7gODC3
 tia9Ge6Q==
X-Gm-Gg: AYBFou3OGdWnkUJ4babrcDl40iCjfZVA8i2xQ+rEQz5lCT2NAugoySwJbUBjCthrS47
 KSGI6KHS1cgEkRudqMbNcW2U5weVQq2EfqqsEFmTY3PlBgrZzmGSLLVPNiUV2AAGfc4cgrmy+HJ
 pM4QFoeohopwLsXwKv3Rq2UPmEC5UyeaX8eLWNL4Aye5qH2RQ+h7XvOCZ2eML+wfXcwlcuSKjbE
 VuUCRTCXHwsAuDDW6ny5/SiECpLGRjDOD+X5PZsDKG9Eykpa3w0Pj4pGFOdj8vKtOtK6SAzGOFG
 XXlEaNKuw+h4vSPph8rdXnDM/lE9w5+1Ds3vWm8IeSIuwuJVh37KWApwHPgNyeae+GYiOhRRB2U
 iB2/cq3vZD72eQxmCKDs12p5uuf05zRHE/T8TBRiLAEjBNCEC0t2gJZG/OBKQvJSEIVNT+/aoi1
 6xGW7JLftBL99Orl+7zLjOp11cj8yekskkOqMkUpPcagg2M1ZV3Ziz80BmJhUW7eA60qOmvX+Du
 02cN42G/xIWwsX7NnZ3qOvl/uV8YOqu1EqlJAgG7dzJU28+D5ZAWq35g+3ctdu3IwXlYSdAnRfp
 u7WJmMQHz9X8t2F1wf0pRLc78Lfbc2mkzHaNwrfOT7LugCGXGyAys4fj9NvIS4Ahi25sbk9Iv25
 KUko7B/bhQqr1RfLIqxzA2z4Y6HaevcODFDgwhkpQfAhLfmJBIGYrEdp10AuVpyOHcUVGefOi68
 1YJvIkv6oNHoZzJ7rPXhOZFoQztQL5Wh0IgfnZ
X-Received: by 2002:a05:600c:3113:b0:4bb:693e:4c8e with SMTP id
 5b1f17b1804b1-4bb88816a53mr40884605e9.21.1795156304015; 
 Thu, 19 Nov 2026 22:31:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm128571155e9.13.2026.11.19.22.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:31:43 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 06:31:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: 0e3a261b6529acbf08aa3f1e929b384efe62d63b
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46991e9387ee23b1045175698291c36e4f752692-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUIA2-0000000047j-3ZdP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_freebsd:
 fix route command and return value details
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4411686194835486008=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4411686194835486008==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Au+UJAafBYk="; charset=UTF-8

--Au+UJAafBYk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2153?usp=3Demail

to look at the new patch set (#3)=2E

The following appr=
ovals got outdated and were removed:
Code-Review-1 by Gert Doering


Change=
 subject: networking_freebsd: fix route command and return value details
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking_fr=
eebsd: fix route command and return value details

- Return -1 on failure, =
as networking=2Eh documents, instead of 1=2E
- Add the interface as scope t=
o link-local IPv6 gateways=2E
- Use "delete" and "-inet6", as route=2Ec doe=
s=2E DragonFly's route(8)
  has no "del" or "-6"=2E

All current callers (D=
CO iroutes) ignore the return value=2E

Change-Id: I3e6043178935fdd05e6ea78=
c411dac5decb7ac64
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
--=
-
M src/openvpn/networking_freebsd=2Ec
1 file changed, 18 insertions(+), 18=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/53/2153/3

diff --git a/src/openvpn/networking_freebsd=2Ec b/src/op=
envpn/networking_freebsd=2Ec
index 8ba6326=2E=2E141f4bd 100644
--- a/src/op=
envpn/networking_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -2=
4,18 +24,16 @@
      * if not, install "connected" route to interface
     =
 * (needed to make 'ifconfig-push IPs outside server subnet' work)
      */=

+    argv_printf(&argv, "%s %s -net %s/%d", ROUTE_PATH, op,
+             =
   inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen);
     if (gw)
=
     {
         _gw =3D ntohl(*gw);
-        argv_printf(&argv, "%s %s -net=
 %s/%d %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET, &_dst, =
buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET, &_g=
w, buf2, sizeof(buf2)));
+        argv_printf_cat(&argv, "%s", inet_ntop(AF=
_INET, &_gw, buf2, sizeof(buf2)));
     }
     else
     {
-        argv_pr=
intf(&argv, "%s %s -net %s/%d -iface %s", ROUTE_PATH, op,
-                =
    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-            =
        iface);
+        argv_printf_cat(&argv, "-iface %s", iface);
     }=

     /* without -fib, route(8) uses the FIB of the process */
     if (tab=
le >=3D 0)
@@ -48,7 +46,7 @@
 
     argv_free(&argv);
 
-    return (!statu=
s);
+    return status ? 0 : -1;
 }
 
 static int
@@ -64,30 +62,32 @@
     =
 * if not, install "connected" route to interface
      * (needed to make '=
ifconfig-push IPs outside server subnet' work)
      */
-    if (gw)
+    a=
rgv_printf(&argv, "%s %s -inet6 %s/%d", ROUTE_PATH, op,
+                in=
et_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen);
+    if (gw && ifac=
e && IN6_IS_ADDR_LINKLOCAL(gw))
     {
-        argv_printf(&argv, "%s -6 %=
s -net %s/%d %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET6, =
dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET=
6, gw, buf2, sizeof(buf2)));
+        /* a link-local gateway needs the int=
erface as scope */
+        argv_printf_cat(&argv, "%s%%%s", inet_ntop(AF_I=
NET6, gw, buf2, sizeof(buf2)), iface);
+    }
+    else if (gw)
+    {
+   =
     argv_printf_cat(&argv, "%s", inet_ntop(AF_INET6, gw, buf2, sizeof(buf2=
)));
     }
     else
     {
-        argv_printf(&argv, "%s -6 %s -net %s/=
%d -iface %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET6, dst=
, buf1, sizeof(buf1)), prefixlen,
-                    iface);
+        arg=
v_printf_cat(&argv, "-iface %s", iface);
     }
     if (table >=3D 0)
    =
 {
         argv_printf_cat(&argv, "-fib %d", table);
     }
 
-
     argv_=
msg(M_INFO, &argv);
     bool status =3D openvpn_execve_check(&argv, NULL, =
0, "ERROR: FreeBSD route command failed");
 
     argv_free(&argv);
 
-    =
return (!status);
+    return status ? 0 : -1;
 }
 
 int
@@ -108,14 +108,14=
 @@
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, i=
nt prefixlen, const in_addr_t *gw,
                  const char *iface, int=
 table, int metric)
 {
-    return net_route_v4("del", dst, prefixlen, gw, =
iface, table, metric);
+    return net_route_v4("delete", dst, prefixlen, g=
w, iface, table, metric);
 }
 
 int
 net_route_v6_del(const openvpn_net_ctx=
_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const=
 struct in6_addr *gw, const char *iface, int table, int metric)
 {
-    ret=
urn net_route_v6("del", dst, prefixlen, gw, iface, table, metric);
+    ret=
urn net_route_v6("delete", dst, prefixlen, gw, iface, table, metric);
 }
 
=
 #endif /* if defined(TARGET_FREEBSD) */

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
Gerrit-=
Change-Number: 2153
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=
=2Emuc=2Ede>

--Au+UJAafBYk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #3</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review-1 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">networking_fr=
eebsd: fix route command and return value details<br><br>- Return -1 on fai=
lure, as networking=2Eh documents, instead of 1=2E<br>- Add the interface a=
s scope to link-local IPv6 gateways=2E<br>- Use &quot;delete&quot; and &quo=
t;-inet6&quot;, as route=2Ec does=2E DragonFly&#39;s route(8)<br>  has no &=
quot;del&quot; or &quot;-6&quot;=2E<br><br>All current callers (DCO iroutes=
) ignore the return value=2E<br><br>Change-Id: I3e6043178935fdd05e6ea78c411=
dac5decb7ac64<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>---<br>M src/openvpn/networking_freebsd=2Ec<br>1 file changed, 18 ins=
ertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/2153/3</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networking_freebsd=2Ec</s=
pan><br><span>index 8ba6326=2E=2E141f4bd 100644</span><br><span>--- a/src/o=
penvpn/networking_freebsd=2Ec</span><br><span>+++ b/src/openvpn/networking_=
freebsd=2Ec</span><br><span>@@ -24,18 +24,16 @@</span><br><span>      * if =
not, install &quot;connected&quot; route to interface</span><br><span>     =
 * (needed to make &#39;ifconfig-push IPs outside server subnet&#39; work)<=
/span><br><span>      */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    argv_printf(&amp;argv, &quot;%s %s -net %s/%d&quot;, ROUTE_PATH, o=
p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
net_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen);</span><br><sp=
an>     if (gw)</span><br><span>     {</span><br><span>         _gw =3D nto=
hl(*gw);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_=
printf(&amp;argv, &quot;%s %s -net %s/%d %s&quot;, ROUTE_PATH, op,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    inet_ntop(=
AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    inet_ntop(AF_INET, &amp=
;_gw, buf2, sizeof(buf2)));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        argv_printf_cat(&amp;argv, &quot;%s&quot;, inet_ntop(AF_INE=
T, &amp;_gw, buf2, sizeof(buf2)));</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        argv_printf(&amp;argv, &quot;%s %s -net %s/%d -iface %s&q=
uot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), pref=
ixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 argv_printf_cat(&amp;argv, &quot;-iface %s&quot;, iface);</span><br><span>=
     }</span><br><span>     /* without -fib, route(8) uses the FIB of the p=
rocess */</span><br><span>     if (table &gt;=3D 0)</span><br><span>@@ -48,=
7 +46,7 @@</span><br><span> </span><br><span>     argv_free(&amp;argv);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn (!status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn status ? 0 : -1;</span><br><span> }</span><br><span> </span><br><span=
> static int</span><br><span>@@ -64,30 +62,32 @@</span><br><span>      * if=
 not, install &quot;connected&quot; route to interface</span><br><span>    =
  * (needed to make &#39;ifconfig-push IPs outside server subnet&#39; work)=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (gw)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
argv_printf(&amp;argv, &quot;%s %s -inet6 %s/%d&quot;, ROUTE_PATH, op,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                inet_nto=
p(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (gw &amp;&amp; iface &amp;&amp; IN6_IS=
_ADDR_LINKLOCAL(gw))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s=
/%d %s&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), p=
refixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* a link-local gateway needs the=
 interface as scope */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        argv_printf_cat(&amp;argv, &quot;%s%%%s&quot;, inet_ntop(AF_INET=
6, gw, buf2, sizeof(buf2)), iface);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (gw)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_pr=
intf_cat(&amp;argv, &quot;%s&quot;, inet_ntop(AF_INET6, gw, buf2, sizeof(bu=
f2)));</span><br><span>     }</span><br><span>     else</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_print=
f(&amp;argv, &quot;%s -6 %s -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    inet_=
ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    iface);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, =
&quot;-iface %s&quot;, iface);</span><br><span>     }</span><br><span>     =
if (table &gt;=3D 0)</span><br><span>     {</span><br><span>         argv_p=
rintf_cat(&amp;argv, &quot;-fib %d&quot;, table);</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>     bool stat=
us =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route =
command failed&quot;);</span><br><span> </span><br><span>     argv_free(&am=
p;argv);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return (!status);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return status ? 0 : -1;</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span>@@ -108,14 +108,14 @@</span><br><span> ne=
t_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pref=
ixlen, const in_addr_t *gw,</span><br><span>                  const char *i=
face, int table, int metric)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return net_route_v4(&quot;del&quot;, dst, pre=
fixlen, gw, iface, table, metric);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return net_route_v4(&quot;delete&quot;, dst, prefixlen, =
gw, iface, table, metric);</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span> net_route_v6_del(const openvpn_net_ctx_t *ctx, c=
onst struct in6_addr *dst, int prefixlen,</span><br><span>                 =
 const struct in6_addr *gw, const char *iface, int table, int metric)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn net_route_v6(&quot;del&quot;, dst, prefixlen, gw, iface, table, metric);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_rout=
e_v6(&quot;delete&quot;, dst, prefixlen, gw, iface, table, metric);</span><=
br><span> }</span><br><span> </span><br><span> #endif /* if defined(TARGET_=
FREEBSD) */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2153?usp=3Demail">change 2153</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e6043178935fdd05=
e6ea78c411dac5decb7ac64 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2153 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--Au+UJAafBYk=--


--===============4411686194835486008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4411686194835486008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4411686194835486008==--

