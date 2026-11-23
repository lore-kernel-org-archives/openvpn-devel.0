Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC38606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SV7CsXJP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GC3yk2UU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=alqN1C87;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dm3QfE2u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Mb+p01xwRXLHdrtogaEm+5yH1PHZxeMabJ42a0L8ps8=; b=SV7CsXJPcnCVc/hWMoMRDm+AYH
	87N+s9v3JV1nmToQxz3GAjq9V7mxfDlLg+o5nU+5vSDtVK3V30VVkP/UDlTmEpLJ0OCTXYNAD+mOu
	w2eOIVpHkGEC0wESIjT4QCqNdAiv7+Q/jSC83Ay7A+bSordVETRy/MswOm1sfyYp4mQ0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVRxT-000000004EY-05rx;
	Mon, 23 Nov 2026 11:11:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVRxS-000000004ER-00Zj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BdYnsKREoAdxmnX+HWANf52cErrPFAZnTJSEVWbShdA=; b=GC3yk2UUMpZTPqoyUSFreJUjvc
 WAkPfU0L/JTfk7gHhzFn5PPiDrRlv7YtVIg/+EkwG8s3xXQjrLg44c80ZCrGs0MGfGQRWELKsodSS
 C16ad9UpNdktrVIXwoluJKv0A0IzqdXu/VVN7OLr27ZJSrDIUwoYJN8gVd6/Ge8HTAwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BdYnsKREoAdxmnX+HWANf52cErrPFAZnTJSEVWbShdA=; b=alqN1C87+ryTr7de4wPcmGByXA
 Rnf2hHQPJJN9bmPiV/rAvnHVnKsK5A7VRkYUt8ucsn3KmwSoaBJbJUYM4leZonD8YCXDkbSTk6S4S
 gEYRXwtR0X1e8kWCuEcDUM2aVUQ8zIfqZFhDrSYv0wT8En6BCWs1mcEkCP9dhzsBXeOI=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVRxQ-0000000065W-1pIj for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:11:37 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1812117f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 03:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795432290; x=1796037090; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BdYnsKREoAdxmnX+HWANf52cErrPFAZnTJSEVWbShdA=;
 b=dm3QfE2ufrpVtM+l+rApAgTQtnPGl6E+r5AU3GH0qKyy5cS0NIj5GJnitW9zKzDhea
 951AOokJC3bh9SZTd6XWyt/7+Bl1HXkX+aTMmJ4IxH4jZJWNNZzNpIuLTEbIUu5cbLBU
 oH86gDujP8fKbVbQcDtemoWtGzMSJ9CAn+x3AUSqfEuieZY6abMBIXTxOrD291XbXG6Q
 efYn0/uF+vjnoK2+fo22j4xU/+Ap7m9+0HNETgNAnotGEiB5h3D/wd1iWJW0JuV0VQzZ
 vHm533T71wmtxjohqO7jFv5/Y9mEZK6jqrkyJOuZn3rwwfOH5wFs42N5S6Sq31ijLTSM
 BvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795432290; x=1796037090;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BdYnsKREoAdxmnX+HWANf52cErrPFAZnTJSEVWbShdA=;
 b=IzHz2duNL4Q8KZ1jQ0OndAfFiuC2K2sj51jZPyXQUwNUVSb12YsV/sxWPja79gHFok
 IxPsoeleetQq4CXCQAUlWNe0KfuonEtCuXAvG+tkSwEQoSPPYOQkkl/2i9bNHFAX3M6k
 mfHW4Nu4rLWlOnCzExc3GhNKpzYIjbFMDy6VmteG0S57O1KHuQxIvv1rzhoQKY884wUf
 XMbRGYDtYnrt6HuFO3aIHRhGhQlzBS5xao35P8j8stNr5e3LUIMUcyUSzTK31oWWJoPx
 FzDhs8LwSmVkDAvHmOD4kGqOzlT9JLPvEgwmsM5iy80yle/ltHU+jE4Shg8iFEZK8jT6
 V98Q==
X-Gm-Message-State: APuU4Z+pqCsPZH+j02qaKtZqhLW8hOKb3qOv8Ba1WhaQMce74z041dAD
 IUHwyAkruw2S62pMaf4pVK/fYq0xd/jMSbidLP6EFP+nnIRDplnHqLi93dZBgHMIWCyXtefxwCX
 co+ji74t0FnUlONTsjow/ixkWGB+aSyBmRvRh4fAmpdnQ2SFMOu96v5xuim5crRscQoaeDWRZRH
 /WEHwuog==
X-Gm-Gg: AZFdTZcMVTLIiYLsX07Tp4yVjivuzz/aR151ta1V0u7WI9OEomDm8AG00qvPL4CQHn0
 w1T2Rkv/Ac3j2KADTUx9hdBRk2EMLm2Sb+0apPPKDwUtNnEB3zAVp6o1aeMGsulNaq8iNhw1BPa
 5JcqMkKi5WH5ajlb47zCjz1qNFhAzKjRs6WUcPGLJ/+CbfSbWgZNQGmP7pLM7Z5d//mQ29ukgd8
 +i2c33rT0kxOjHBDmtXk8gxtXbH7m0pMNl0dxy6FJcTEt2ryOX7kbwee95qiJfnZiY9Drzr9kq6
 fqO69uNZDEKbk+a0Lq3Egt33s6DAKDAMSlZobWpPCi6+S919nSrT7Rb7M2z3EoxdCLmVDSSopJp
 XHJv9jnYyTwnWixCnXBRWN3STH9lQZw1gb/Vwzr3QVHSfrKHiqGoIeZ6E8m2waaCTOZwlQyZLzU
 uBx0Sip00HFCsdy45e8b26AVcE9KFfOGOuEhQS3aSdS0D3cVXRp8kWd6MiUixIDctvBEBjgp8Hx
 Aegr0th5vvAziaYza6sCrAvEO2x2fAy9ppAjc+lx6iWaXYgf7bPvdi+agNpEI3XfNWMy+faleKq
 sN+Ss+hFR6CwckJIBEeSB96RsDFtOCuIQgVM7/TLDfcpdohJ+198nKn0+alc0XBtoZ898COuZux
 0MzdsqJl4WKJuzQI85ne99taUvEQ2OM5PQzZqvl6aTnl4RHD9AULK7qu52axuqw3w7SZwWin8u/
 IOfGDi65gxxdmo9K4=
X-Received: by 2002:a05:6000:2085:b0:49c:192f:cf20 with SMTP id
 ffacd0b85a97d-4abacfea524mr21205885f8f.6.1795432289711; 
 Mon, 23 Nov 2026 03:11:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa397asm22094980f8f.48.2026.11.23.03.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 03:11:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 11:11:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
X-Gerrit-Change-Number: 2327
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2327?usp=email>
X-Gerrit-Commit: c2ffdae589ccd66ffbab9722dc77d67177009c49
References: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMyMjg4MDAwLklkZDRkNzFkMDJiYWZlY2U3NDg3MWE4Yjg4YjFjMTJkMDNkNTg1NDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1dd22fb591d49965da1687729cea85b15edfea91-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVRxQ-0000000065W-1pIj
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: check
 the address family in addr_match() and addr_port_m...
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
Content-Type: multipart/mixed; boundary="===============8132665020244214543=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8132665020244214543==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q5RNeOjQX9o="; charset=UTF-8

--Q5RNeOjQX9o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2327?usp=3Demail

to review the following change=2E
=


Change subject: socket_util: check the address family in addr_match() and=
 addr_port_match()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

socket_util: check the address family in addr_match() and addr_port=
_match()

Both read a2 as if it had a1's address family=2E The arguments ar=
e
openvpn_sockaddr unions, so the reads stay in bounds, but a mixed pair
co=
mpared an IPv4 address against sin6_flowinfo, or an IPv6 address
against si=
n_zero and the bytes after it=2E Mixed pairs reach
link_socket_actual_match=
() when a client floats between an IPv4 and an
IPv6 --local=2E Return no ma=
tch for a different family, as
addrlist_match() does=2E

Change-Id: Idd4d71=
d02bafece74871a8b88b1c12d03d58540f
Signed-off-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
---
M src/openvpn/socket_util=2Eh
1 file changed, 8 insertio=
ns(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/27/2327/1

diff --git a/src/openvpn/socket_util=2Eh b/src/=
openvpn/socket_util=2Eh
index e85f6fe=2E=2Ea7821df 100644
--- a/src/openvpn=
/socket_util=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -294,6 +294,10 @@
 st=
atic inline bool
 addr_match(const struct openvpn_sockaddr *a1, const struc=
t openvpn_sockaddr *a2)
 {
+    if (a1->addr=2Esa=2Esa_family !=3D a2->addr=
=2Esa=2Esa_family)
+    {
+        return false;
+    }
     switch (a1->ad=
dr=2Esa=2Esa_family)
     {
         case AF_INET:
@@ -381,6 +385,10 @@
 st=
atic inline bool
 addr_port_match(const struct openvpn_sockaddr *a1, const =
struct openvpn_sockaddr *a2)
 {
+    if (a1->addr=2Esa=2Esa_family !=3D a2-=
>addr=2Esa=2Esa_family)
+    {
+        return false;
+    }
     switch (a=
1->addr=2Esa=2Esa_family)
     {
         case AF_INET:

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d5=
8540f
Gerrit-Change-Number: 2327
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Q5RNeOjQX9o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">socket_util: check the address family in addr_match() a=
nd addr_port_match()<br><br>Both read a2 as if it had a1&#39;s address fami=
ly=2E The arguments are<br>openvpn_sockaddr unions, so the reads stay in bo=
unds, but a mixed pair<br>compared an IPv4 address against sin6_flowinfo, o=
r an IPv6 address<br>against sin_zero and the bytes after it=2E Mixed pairs=
 reach<br>link_socket_actual_match() when a client floats between an IPv4 a=
nd an<br>IPv6 --local=2E Return no match for a different family, as<br>addr=
list_match() does=2E<br><br>Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d5=
8540f<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>--=
-<br>M src/openvpn/socket_util=2Eh<br>1 file changed, 8 insertions(+), 0 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/27/2327/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/sock=
et_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index e85f6fe=2E=
=2Ea7821df 100644</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><=
br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -294,6 +294,1=
0 @@</span><br><span> static inline bool</span><br><span> addr_match(const =
struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)</span><br><=
span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (a1-&=
gt;addr=2Esa=2Esa_family !=3D a2-&gt;addr=2Esa=2Esa_family)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span>     switch (a1-&gt;addr=
=2Esa=2Esa_family)</span><br><span>     {</span><br><span>         case AF_=
INET:</span><br><span>@@ -381,6 +385,10 @@</span><br><span> static inline b=
ool</span><br><span> addr_port_match(const struct openvpn_sockaddr *a1, con=
st struct openvpn_sockaddr *a2)</span><br><span> {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (a1-&gt;addr=2Esa=2Esa_family !=3D a2=
-&gt;addr=2Esa=2Esa_family)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     switch (a1-&gt;addr=2Esa=2Esa_family)</span><br><spa=
n>     {</span><br><span>         case AF_INET:</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Dema=
il">change 2327</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2327?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2327 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--Q5RNeOjQX9o=--


--===============8132665020244214543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8132665020244214543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8132665020244214543==--

