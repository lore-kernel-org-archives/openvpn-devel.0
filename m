Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019E606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dRWLhQUr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TqZw8nXB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RAgy60T4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KS2EM6tY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=GFwBHWRp27mN//SZbNy/lI7lUlMydQVuuX8Az0NAop0=; b=dRWLhQUrB8E35EJCU/wTLmayO1
	5qoq2+waZHKYxqJJe+VNbCeX9rm0D80fm5z0dweOShEDLKVfHb4V73o25DbXyaUdfHLdxWyG6yigW
	fpd272CItDNfZ1rkgVo9hrSu6pRgYB2s1xpDa2oYO/b+TULojaINUrHEJyQjv8E1WnMs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaDZ-000000006GX-2Gzb;
	Wed, 04 Nov 2026 12:35:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaDX-000000006GQ-48Zz
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1fpJ7dKIOZ92wOKa8uMmmVJNgUimvZf6T5PlmPWW6nE=; b=TqZw8nXBr9kbvmFAPUgnfEpW2X
 3Oulmm70hBqgWhmzha9P6q+WWrNvMDhp0uMNga8thzFZejw5YU6IxyPAZ2vRb7ohl59RxufnDSRi+
 dLdHO02CLtNVhZjPIipuvQHP4cPrNVAkg0xS2l0C7nb81i29a2rn2AVXTdqlB2i/L7b0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1fpJ7dKIOZ92wOKa8uMmmVJNgUimvZf6T5PlmPWW6nE=; b=RAgy60T467xlh3MEzXUJQkeQFo
 PU/8qHVjZ6s0euKb+sD3AC1xioDZUlRRxo1TqehvE2xU9H8jXSIWrphmrrF6x98OvT9LoLfBLJBli
 zveXPpkzX3nr8g9yH1dtki6OIEeZ8qhYv98Xpd4+0DWwYcaeeafJycS07GqVNblzgxkg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaDW-000000002Vb-1yrP for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:35:51 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so5680815e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793795744; x=1794400544; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1fpJ7dKIOZ92wOKa8uMmmVJNgUimvZf6T5PlmPWW6nE=;
 b=KS2EM6tYdX1qj7OhS+gccEcw+0XC/CRbptpKn2WD/J4DNl6vBtgqXtJYbJajDoIh/t
 pgypQko9DHYyCMg4inyvmF/4/QakmwwkvKfSuO41iC0csVxI39ukD7ucn+IELxDwhKSe
 nWYRHwnpGch11a3ULIu+il4ERmriNeAvLdXs25NAvPS1DNkS4zvr4dW/FWfCdRZ+XLXD
 FHEq2CrxttNpTuVq0elC9KpA769Hf/qNdGGvUaEA2eY2yxLo0m74SoY7Qh30eNWPq/ku
 x63qBRqgk+mAeCeTryjsXqS+ubi+hjpcSqhzjNTsUXFnjj2FClB4op99FZw/IwisC4h7
 5aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795744; x=1794400544;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1fpJ7dKIOZ92wOKa8uMmmVJNgUimvZf6T5PlmPWW6nE=;
 b=z8iBL2Z4gjk9GtawoBNAFsnBjK7AeBMTqXoLqpEXALkbUq3fXUTOyD9z/19X0uw+AA
 JvsLATFB7oAj3+NSj/Vvp5uAB+p0hcge+hhmsPU3lz/8mRp/QB4330jZxIc4bA5a6LKy
 bz0M6ECJ+uBH1X0ogfIQm6Sxu+w1ssAp4a4pSjctAAVyqlI92WEsqqq6CuODJ+XwxNMO
 fuFNWCgaeEK2LZM4YUIySMhOjy1WEeiP/8hwOex74+xqSpLZqcTG4V1NZB6MkX4UkDPt
 cdqCF4JfCCppkDYW932tumMk1xDXVHUzQ0BxMD8R0sPXWjyXFzQxmM5zjWRWj230iE/p
 ZViw==
X-Gm-Message-State: APuU4Z9bR5s6JBZU9nxOpb2NpLqzg5p4moHCZDWmQVIn4sgUgdjvGnI6
 h7h2l5itu51EosW8ueBcoA9FtLVSOOrgSig4riigyv6lEEypl12NZ0PPe4Ixn+vL8eiknbhfG3A
 zDewNdf9HcBLN2tAZlUiLOZ3lbrQ+afYUHxUCGBpICs0S63qRAgxxPrNY8hkZocsJuEnm6A3TVB
 XT3fLVYA==
X-Gm-Gg: AYBFou0ieC1iSXT+4lrDP24wV0MIlAFEwzTYIUpf4yCVuTubOSiGFBtvcB3r/mQkRaF
 YEmER9pTmzHIqmEvDpmT5pCm224eVVhjy7UTQOhvmuyefG6QEu/6DfOdAvQbFiU6B1L57Qwt2Lm
 vFfU3mutohstkDFcREK/wLsQYkHth0MFsfwsVGNjJemr9JPx2hFPQ5ZdMiAZ06pM2KDy4560bB6
 hV4k1fpKDDp8NR9ReJdznqav1N2hIXeEn8rt97A9XELdKBgKaNO3Ym8ADssq9TRKKXDLqQSLToq
 t5iba0/OVYQHRj7Mek2+dk7FDwJMm3QrOT9YLgvOmw6hxSVnWXQQ1Hl79dAoyeAn/p7gWknL31E
 a42/bhouZy9M4rVLhqjtbe9/RzaALojdcUsNBnDWEQ5stiyFGxYrT0GJeAwfpjHkFVYkLfOHCF1
 mbtIW78IogqfTZtYUDcYp7EnfdG6fzdvwdr9d6K0I5QG2BOZ6PSGm0np/K+Lc1ZnYizVxtQLGT+
 8ZbJGZqC0Q2nXD7+Z7+9bSLRRPJBX/rNTuRHenNU3G94PVAG1EAg6w/XBp7cpF3AzfaUsQhFV2X
 W1b6XN1Mkok0NiyISpBooqLJMidpGk5VHASP0KYfHlhsrqaDTCdanY1t4sVhcqZbjThs4wUCeQT
 8XlWCKNMzb94uABfi1ArlZunmCD2FvTWXLRWC9oIYoSsVsSStWMyWuTrEdJ+rcqyX36o++yIole
 COX6nq9PLAoALYTw==
X-Received: by 2002:a05:600c:19d2:b0:4a6:4d6b:a840 with SMTP id
 5b1f17b1804b1-4ac1932a12fmr362931825e9.31.1793795743653; 
 Wed, 04 Nov 2026 04:35:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43da9825bsm51141205e9.15.2026.11.04.04.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:35:42 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:35:42 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469
X-Gerrit-Change-Number: 2131
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2131?usp=email>
X-Gerrit-Commit: 32420c1ef430271f1630212b65d50f59b74149d8
References: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk1NzQxMDAwLklmOTAzZGM1ODIzODU4MGVjMDY4MGYyZDRjOTA4YjFmOTQ5YTI3NDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e2f2e598a347518a2defac5297e3c3f6aa15d63-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOaDW-000000002Vb-1yrP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: use
 setenv_int_i()/setenv_str_i() for indexed route env variables
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0057276921276627132=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0057276921276627132==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9mhZ5apRgsA="; charset=UTF-8

--9mhZ5apRgsA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2131?usp=3Demail

to review the following change=2E
=


Change subject: route: use setenv_int_i()/setenv_str_i() for indexed rout=
e env variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

route: use setenv_int_i()/setenv_str_i() for indexed route env variabl=
es

setenv_route() and setenv_route_ipv6() built the route_metric_N and
rou=
te_ipv6_*_N names by hand=2E Use the env_set helpers instead=2E The
resulti=
ng variable names are unchanged=2E

Change-Id: If903dc58238580ec0680f2d4c90=
8b1f949a27469
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M =
src/openvpn/route=2Ec
1 file changed, 4 insertions(+), 15 deletions(-)



 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2131/1=


diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 53550c4=
=2E=2E6386960 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -1317,7 +1317,6 @@
 static void
 setenv_route(struct env_set *es, cons=
t struct route_ipv4 *r, int i)
 {
-    struct gc_arena gc =3D gc_new();
   =
  if (r->flags & RT_DEFINED)
     {
         setenv_route_addr(es, "network=
", r->network, i);
@@ -1326,12 +1325,9 @@
 
         if (r->flags & RT_METR=
IC_DEFINED)
         {
-            struct buffer name =3D alloc_buf_gc(256=
, &gc);
-            buf_printf(&name, "route_metric_%d", i);
-            =
setenv_int(es, BSTR(&name), r->metric);
+            setenv_int_i(es, "rout=
e_metric", r->metric, i);
         }
     }
-    gc_free(&gc);
 }
 
 void
@=
@ -1351,22 +1347,15 @@
     struct gc_arena gc =3D gc_new();
     if (r6->f=
lags & RT_DEFINED)
     {
-        struct buffer name1 =3D alloc_buf_gc(256=
, &gc);
         struct buffer val =3D alloc_buf_gc(256, &gc);
-        str=
uct buffer name2 =3D alloc_buf_gc(256, &gc);
 
-        buf_printf(&name1, =
"route_ipv6_network_%d", i);
         buf_printf(&val, "%s/%u", print_in6_a=
ddr(r6->network, 0, &gc), r6->netbits);
-        setenv_str(es, BSTR(&name1=
), BSTR(&val));
-
-        buf_printf(&name2, "route_ipv6_gateway_%d", i);
=
-        setenv_str(es, BSTR(&name2), print_in6_addr(r6->gateway, 0, &gc));=

+        setenv_str_i(es, "route_ipv6_network", BSTR(&val), i);
+        s=
etenv_str_i(es, "route_ipv6_gateway", print_in6_addr(r6->gateway, 0, &gc), =
i);
 
         if (r6->flags & RT_METRIC_DEFINED)
         {
-            s=
truct buffer name3 =3D alloc_buf_gc(256, &gc);
-            buf_printf(&nam=
e3, "route_ipv6_metric_%d", i);
-            setenv_int(es, BSTR(&name3), r=
6->metric);
+            setenv_int_i(es, "route_ipv6_metric", r6->metric, =
i);
         }
     }
     gc_free(&gc);

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469
Gerrit-Ch=
ange-Number: 2131
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--9mhZ5apRgsA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: use setenv_int_i()/setenv_str_i() for indexed ro=
ute env variables<br><br>setenv_route() and setenv_route_ipv6() built the r=
oute_metric_N and<br>route_ipv6_*_N names by hand=2E Use the env_set helper=
s instead=2E The<br>resulting variable names are unchanged=2E<br><br>Change=
-Id: If903dc58238580ec0680f2d4c908b1f949a27469<br>Signed-off-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 =
file changed, 4 insertions(+), 15 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2131/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br=
><span>index 53550c4=2E=2E6386960 100644</span><br><span>--- a/src/openvpn/=
route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1=
317,7 +1317,6 @@</span><br><span> static void</span><br><span> setenv_route=
(struct env_set *es, const struct route_ipv4 *r, int i)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc=
 =3D gc_new();</span><br><span>     if (r-&gt;flags &amp; RT_DEFINED)</span=
><br><span>     {</span><br><span>         setenv_route_addr(es, &quot;netw=
ork&quot;, r-&gt;network, i);</span><br><span>@@ -1326,12 +1325,9 @@</span>=
<br><span> </span><br><span>         if (r-&gt;flags &amp; RT_METRIC_DEFINE=
D)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            struct buffer name =3D alloc_buf_gc(256, &amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&am=
p;name, &quot;route_metric_%d&quot;, i);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            setenv_int(es, BSTR(&amp;name), r-&gt;metric=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            seten=
v_int_i(es, &quot;route_metric&quot;, r-&gt;metric, i);</span><br><span>   =
      }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span>@@ -1351,22 +1347,15 @@</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>     if (r6-&gt;flags &am=
p; RT_DEFINED)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct buffer name1 =3D alloc_buf_gc(256, &amp;gc);=
</span><br><span>         struct buffer val =3D alloc_buf_gc(256, &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer=
 name2 =3D alloc_buf_gc(256, &amp;gc);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;name1, &quot;rou=
te_ipv6_network_%d&quot;, i);</span><br><span>         buf_printf(&amp;val,=
 &quot;%s/%u&quot;, print_in6_addr(r6-&gt;network, 0, &amp;gc), r6-&gt;netb=
its);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_s=
tr(es, BSTR(&amp;name1), BSTR(&amp;val));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       buf_printf(&amp;name2, &quot;route_ipv6_gateway_%d&quot;, i);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_str(es, BSTR(=
&amp;name2), print_in6_addr(r6-&gt;gateway, 0, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;route_=
ipv6_network&quot;, BSTR(&amp;val), i);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        setenv_str_i(es, &quot;route_ipv6_gateway&quot;=
, print_in6_addr(r6-&gt;gateway, 0, &amp;gc), i);</span><br><span> </span><=
br><span>         if (r6-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  struct buffer name3 =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;name3, &quot;ro=
ute_ipv6_metric_%d&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            setenv_int(es, BSTR(&amp;name3), r6-&gt;metric);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_int_i(e=
s, &quot;route_ipv6_metric&quot;, r6-&gt;metric, i);</span><br><span>      =
   }</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2131?usp=3Demail">change 2131</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2131?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </di=
v>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469 =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 2131 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>

</body></html>
--9mhZ5apRgsA=--


--===============0057276921276627132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0057276921276627132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0057276921276627132==--

