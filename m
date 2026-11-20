Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF0606A32A
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dGqV+U8r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kuI62r12;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B6zRHKVI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dSNW7xVY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=1oDFS0jLNlrnr/iMpKH6tGzKji4/gWXm8j4vSMMhIwY=; b=dGqV+U8rcRbiHLqvr0ud5KQmA8
	pnlohmN5eli5/JQg5X4sm/Yv/oLUEKCoHpcecJQnUlNmfLLwM0ELw/WSAOls4e7wbzSuhAEosJZFo
	GXccFBdni2adNVyZNKzsWCfH7GZ2VFs1bIDzthFAhKH3MwOSn6qQHfmMnsmMkcqZAGG4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMVg-000000002IR-2BLZ;
	Fri, 20 Nov 2026 11:10:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMVf-000000002IJ-2zET
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 11:10:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R9+DeusvXtC8DMz/sHgoPMcCygxKO3O8vYikkN/v2FY=; b=kuI62r12YyfzKKaL5Al7vPU5CW
 /wmdcvXk2hUiY+5eCe8QzZkMsFSXU8jbvTHZIODdhOd2KBLnCja97zXw+JzKHwIUBHB206a7LYa2h
 jCf60coGqymutWsnILg2XOM4n10Qcaoo1YQ5PckXVYWCr9jjOCzpsMaxUc+oWqN4ZLrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R9+DeusvXtC8DMz/sHgoPMcCygxKO3O8vYikkN/v2FY=; b=B6zRHKVI/ptZKDVep3IBk6fAWp
 etwaEJ3oaiQMaBAHd+kLfa83waovgDFTP/E//fnSzobHgxuT2dbejBe7b910SW2361E8KU2mX3jjv
 k4osgpRc/xeWQSUZj+wSd3YA6KzzSTzplHMGp7D7DlfZwYiMdWNTtmTC+9Gz5EiJ0Sng=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMVe-000000004rF-10cR for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 11:10:27 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso17420765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795173020; x=1795777820; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R9+DeusvXtC8DMz/sHgoPMcCygxKO3O8vYikkN/v2FY=;
 b=dSNW7xVYJDf3oVhBaj8GA84R/O16L94AgEpKpQu1F3o85si3ie0dtXI/pvDCSKKM4E
 sk03WWYAKT8DXjdvRksb7aFQdAv4GqWQDhP1GgrAmkx6QDsASuEhdL4ZoIqtYCNWAtTJ
 kkgK1BRd+WS3zmU0l1w7LMDHrCaFk5+paZEP79MlhiQHWXiXVZarIOq96gTowhMdfYfv
 iZkKk7lXqS7pprY9ti3cHkpTnsQSRwEstDR2FTo8LHU2QV6TyvRqEUvivB6Y+MQs4SpN
 FO8/vDNmhcktGFnp13MRG7o4Tgvgxfomlc9q2A5i+/oDMOXjPLK9jTqVcwMCnkG0Ihmy
 3Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173020; x=1795777820;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9+DeusvXtC8DMz/sHgoPMcCygxKO3O8vYikkN/v2FY=;
 b=PZx1+NdMK4L5mMm2x8Uw7QW6UvdgoBxjrbba2A8GlAAbuTl7DmqLtSfquUYaoZ5hiB
 OBc8bUcFQ//9rafiBba69mOsq19f1GKlUYyC5C8JwGpiAztp6/AvGTktfU0gec97EY2n
 HYjKorWR9SxkIpfYtUpoPZJLBRaHsowkvt5JQ7rmsXDwviXa4R0cOz/ZAK5GoN3Fn5o4
 Y9Y/whwKe7BQ5VIjZVC9HpkFLqQn5dyQWoc6gISM2y2SMD62rI6XAUDOMarsBfbAzwWO
 lmDk9IuS72ZXJfKBNicVeaGagqeIZXTRwhjl6ZmPLZ/+xCy2oCnjsgeapuAgMTeKbS/M
 LOLA==
X-Gm-Message-State: APuU4Z/gZXrCPNMeCx6lVmBlRKMskq48BT2mflyKFSg74PtVhJweB8R3
 NF392W9CPyQUTtnmJ6SuydrZnUKTWmzmH3SAXEpIrj/BC+OXEiaOLPEdhPWwTeqAbVrUhGI4Sny
 rykr85nKQVVzQQoFVrbp32RLURfSRz6IhrwHAqOCdDMmsr8f5occvXKbdVtjojwknry01Dun6/x
 /bmWgJ0Q==
X-Gm-Gg: AYBFou0WAPcEZESSJ60u0Cgnb1lf1SeQBN7mI63VjtPzrgxS4Y+WXU6jbWor3+/nETl
 Ouzf9GgjUgIU24+em39BdutNsovFz1C9hDf6MOyuE9E3dLvnGMLOtpKx4hRk3tUou0WTZbEhXB5
 yvGv2PEUDT23U677vFzaQcp9sc3hIitrnnmu5W2vg/viL1zsdIWnkHirMYuFONHUP7ICfsVZb5g
 rEhyFNxrWrjXdL2JyFZohdbh/bYtlQsBgmBnLyzN3meccX7a78cmvrEqLxGkWpmbJAkunw+C4nP
 xqyC/2BsZOzTO837fen7E6A2/tdlPucBwQ+rBc71JRdM9kpBJ7P8G0BFmdc/AMRgWrAxpwZdC0m
 LUG1IPpdBj7oIxEBew7+nscFZhIZ/UOukdPrUtbXDE4u9/ZQdX6WAvuc/5Y8rEKf6MwFUiii1zW
 ZL0j759B3jaWuzpuxHWpJK14LI6VhKz8V2Mdz5VxSobG8dAbqhuw+l3/c9M9tgfIxi57Q/zLDMx
 NHzOmEsZ0mJzoUWrtMa6u6jkZlbMoC4dA3tKvqNgMgeBlJiUgcYnCsbX43XH7qPxvS42XqW8Ihs
 QjnSrp6qX1Tt8LVSJV4VUQvMvywwIv/E1dy/XkA01XAOIQRcUBQUJs0b5s+RwWfB8JKHx4z+imn
 f4/wfEKgPl0sByku91DM6M8G0/XKi4US+gy/NocomoNwaJY2OcKqTUcwuHD0aaE6uO2jKIdyWfJ
 PQn8Am8zTHqA10rlvi
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr63353955e9.5.1795173019315; 
 Fri, 20 Nov 2026 03:10:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88f1391csm52161075e9.3.2026.11.20.03.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:19 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 11:10:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7
X-Gerrit-Change-Number: 2227
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2227?usp=email>
X-Gerrit-Commit: 9ac51f010824b69f8cd6c48cfa9a400f9d777965
References: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTczMDE3MDAwLkkxZDUxNmIxYWNlZTNlZGMyYTY5YzY3MGQ2MmY0OWUzY2QzNGQ2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d968446013f46e634fc4a437814ff6a2f7311a9d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMVe-000000004rF-10cR
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: route:
 initialize the table of block-local routes
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
Content-Type: multipart/mixed; boundary="===============6872369416813744496=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6872369416813744496==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bCHvxlB5mpo="; charset=UTF-8

--bCHvxlB5mpo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2227?usp=3Demail

to review the following change=2E
=


Change subject: route: initialize the table of block-local routes
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: initialize t=
he table of block-local routes

add_block_local_item() allocates the routes=
 without clearing them and
left table_id unset, so the routes went to a gar=
bage table=2E Use 0, the
default table, like the other internal routes=2E

=
Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7
Signed-off-by: Razvan =
Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/route=2Ec
1 file changed=
, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/27/2227/1

diff --git a/src/openvpn/route=2Ec b=
/src/openvpn/route=2Ec
index 4dfdd5f=2E=2E5b1d012 100644
--- a/src/openvpn/=
route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -557,6 +557,7 @@
         /* split=
 a route into two smaller blocking routes, and direct them to target */
   =
      l2 =3D ((~gateway->netmask) + 1) >> 1;
         r1->flags =3D RT_DEFI=
NED;
+        r1->table_id =3D 0;
         r1->gateway =3D target;
        =
 r1->network =3D gateway->addr & gateway->netmask;
         r1->netmask =3D=
 ~(l2 - 1);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2227?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id=
: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7
Gerrit-Change-Number: 2227
Gerr=
it-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>

--bCHvxlB5mpo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: initialize the table of block-local routes<br><b=
r>add_block_local_item() allocates the routes without clearing them and<br>=
left table_id unset, so the routes went to a garbage table=2E Use 0, the<br=
>default table, like the other internal routes=2E<br><br>Change-Id: I1d516b=
1acee3edc2a69c670d62f49e3cd34d6dc7<br>Signed-off-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed=
, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/2227/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index=
 4dfdd5f=2E=2E5b1d012 100644</span><br><span>--- a/src/openvpn/route=2Ec</s=
pan><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -557,6 +557,7 =
@@</span><br><span>         /* split a route into two smaller blocking rout=
es, and direct them to target */</span><br><span>         l2 =3D ((~gateway=
-&gt;netmask) + 1) &gt;&gt; 1;</span><br><span>         r1-&gt;flags =3D RT=
_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r1=
-&gt;table_id =3D 0;</span><br><span>         r1-&gt;gateway =3D target;</s=
pan><br><span>         r1-&gt;network =3D gateway-&gt;addr &amp; gateway-&g=
t;netmask;</span><br><span>         r1-&gt;netmask =3D ~(l2 - 1);</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2227?usp=3Demail">change 2227</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2227?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34=
d6dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2227 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>

</body></html>
--bCHvxlB5mpo=--


--===============6872369416813744496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6872369416813744496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6872369416813744496==--

