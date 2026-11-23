Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1F606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iMEYL9ev;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SeiPUshC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fIOS1Pfv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bnigj90V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=boXES8G+KeexBlTloTto+hX0syiB0a9xQmkFeHdL++g=; b=iMEYL9ev3ssp+mLJptGy9B3qlY
	0cbuJ09CGLJYgMRaAjWY2TpMxRDgd5prAboCd2S3f4m3fvYTed4xS1jWABwhHa5t8eD0ML3SHPb0h
	tGF61tD3vQQGYmAh5h/f0ssnu33/1lkuu1gUEzVLGrcdc7rXOLD9iYrFm1YbCKzS0F+U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVRNp-000000003BM-0dEI;
	Mon, 23 Nov 2026 10:34:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVRNo-000000003BG-16Vw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 10:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ByAS0qNVr4qo6XKXAvxRgS8k1mPBgtH3MMDBtzDXzFg=; b=SeiPUshCCeVn/g0NarJjJTj3rW
 GAMTBnh+QteY7t0bGl2YdWDc5T5j3HTVEjgQb7cJfndPV52YTgW93CcLk1FevnZHMWXhB+aEfPuIQ
 7NADZ8aQILgL58OCnR8DDr+ZhuEEXMhv88rQf4vfhQ1uT9mzlD604EN/2h++aDGkJ+Rc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ByAS0qNVr4qo6XKXAvxRgS8k1mPBgtH3MMDBtzDXzFg=; b=fIOS1PfvelDnMAJjNXeUVys+HR
 ZR2WuyfcRHc22CoZCEQllN5Gw7WB6oYyNEmAjn/DphinofyCL+LbCqkzGzJDtp65DqvgVu2cgVu3G
 NmEgreDFyJup5y57RDmip+zfQ7LUqb8GBrbqKTmw3up/GwOtecHr68WD4f4jVKyYD434=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVRNk-000000004pO-0IpT for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 10:34:48 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so28230165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 02:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795430077; x=1796034877; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ByAS0qNVr4qo6XKXAvxRgS8k1mPBgtH3MMDBtzDXzFg=;
 b=Bnigj90VHY/E3YsrMOZq4jsk78UnYmhRTnMXMYtYkINpIKWTJa+jaPkLYLBRHR3nwJ
 9gfxCMyIiX4Yws3bdRKzrhTbgr13+YpI8ka5tOQAUm1EqaRRRHOl8oScWHxROz1lmdLU
 0iuHAoIh9QRjlnsQM3EXP4TzcLQLcXuLx6FkhG2CqdnqC0hLp2nhHxmNB34nI0WfpZ47
 vzNc15UmsZ6QfnEePS2L3mRSbpje0zTudVtfG28irt44qJ6bOzDX6HdVjewor6DigKkL
 9UHVqdXF/Dd8MicIh3qIubJbHeTCILb1219+94PQEklxMEIAW7oRJv+vfbh+cdrAp4Nr
 pPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795430077; x=1796034877;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ByAS0qNVr4qo6XKXAvxRgS8k1mPBgtH3MMDBtzDXzFg=;
 b=tQo/XUOo0IvcyIe6XSOP9OGxiVruBE3aQZQ3LM4G1H6mSxZm7JwoLgnWDyuAV9rK1e
 hDNa62jyxNaY28puO6oHzcY8le7wM8PPZyKT6ZDVyS2wzwoet4WSssSGyWdyo4RqZM9e
 xj2AE1TU76BVrY0HqkDVw2LVqBUJkuLS62RGgAfst0s/8ZvHZOo9MDBhOR6whcI5/37O
 aHZY2DuGZznSjt2tlYn1kK0TeyElriMKOBpB2VHz8QjvkQxD/ri8PZtS2rIcWxxZ683x
 uO8d+dWNUGE2BmBzYLq3AS8UpsCaJuVWv3degSNsmaMura1Wg9lSWUPfX/kBm1OQunRZ
 4NXg==
X-Gm-Message-State: APuU4Z8UNg42MWHdwZ/hakl0pBWPN6x03tNd13kwtgL0rI63seYgNtbs
 0x273xdFRKwQTu9+IJNiXfqVlH3GqUIzS8Yfo8tuDQO8hpZdahF8Q/TZ4pKe9o2HdPHXoBOyCaS
 ZAxFfDca1rAuW0zYLVPrKAOfSRAq83ar4Z3wBG8/d/ZePg4XjkBkwq/OX0uO8fvUsswnukEeS1w
 /oZ8Va1Q==
X-Gm-Gg: AZFdTZf9o56unMqtNM9UrmwCzYUwG32jEbzqXTDrKPUONyTnRd7/XdLlkorGP3pjSA8
 7QUpZa9W2mCJY/XCdhkbKUK2WDO9tQKGpipS+uQjs3XoWd59u5nN8ZY0LwyNdhykAXGE3wY5RC5
 WRq0pRgV2SAoS1XeApn8hyjQO4PglLGFwW1aS8fc/WNN33TBNBKmmiItoZblaGsmAW8Uijrr1b8
 q+ZFkeJDbsUYTBcl4Ve9aF/VAYT6yoyGMz3yk0jv76mzHzN+C62duGvCWNW2jLwUGZpJKvV5P6s
 4yTbhP3lnJiDACoTa8OucUfTXDfy2leZ+zsAclyea8AvYDrE/BwvzT7Uec16Wblvb85xu7Cj5zC
 QMF6dFycvJ+9agM+UgPdwkxJbTmtxRBJKwGJ5gKxhEkpBSBqWOWv79WvxjiIPnWwnNh0BEvdwA/
 hy0fGNqBU/sXzsM/xdRUZbyyY+f4IUMeC5qWkLeGT5Sq0P+p5et0kDgZ9G8HrW9wUrh6W/nl5do
 T6M2NfOwdRqMI9Fr7R6AY+su0iqHjtDGh3Fwy4Rczk6YC2okAosQsc2hxBcCfjJI8/QdG9l/hrf
 hjqsv2IhXDdtO4GZFZXiCCNyyWnQGU4KVmojwRw7unsxnYZuR8gZ7lIoryVBO812clKud97w2bE
 TCXSD5cOIindyfjq+TyKANuaKFzeD/8k83HuRrQcaaWueYVCbRL1XGk4pU1QA3xFj52FeLP+52B
 xkgdspXu/O+gu4Ty0=
X-Received: by 2002:a05:600c:8287:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4bb887e064dmr236073935e9.1.1795430076333; 
 Mon, 23 Nov 2026 02:34:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm401254705e9.11.2026.11.23.02.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:34:36 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 10:34:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2326
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2326?usp=email>
X-Gerrit-Commit: efa25f6851eba8a7900478f14942f8f015054603
References: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMwMDc0MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd10d2c219f21ba07bc7de55ab5319d2fc998384-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVRNk-000000004pO-0IpT
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: socket: check
 the address family in addrlist_match()
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
Content-Type: multipart/mixed; boundary="===============7200496144681499437=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7200496144681499437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vSnFEcZgE88="; charset=UTF-8

--vSnFEcZgE88=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2326?usp=3Demail

to review the following change=2E
=


Change subject: socket: check the address family in addrlist_match()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: check th=
e address family in addrlist_match()

addrlist_match() cast each remote lis=
t entry to the peer's address
family without checking ai_family=2E With a d=
ual-stack remote list, an
IPv6 peer compared against an IPv4 entry read pas=
t the end of its
sockaddr_in, and 0=2E0=2E0=2E0 matched any IPv6 entry=2E S=
kip entries of the
other family, as addrlist_port_match() already does=2E

=
Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
(cherry picked from co=
mmit 756d140aca1958f71a701b4179e2e59fd3d86ead)
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
---
M src/openvpn/socket=2Eh
1 file changed, 4 i=
nsertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/26/2326/1

diff --git a/src/openvpn/socket=2Eh b/sr=
c/openvpn/socket=2Eh
index 47083ad=2E=2E80f09a3 100644
--- a/src/openvpn/so=
cket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -736,6 +736,10 @@
     const struc=
t addrinfo *curele;
     for (curele =3D addrlist; curele; curele =3D curel=
e->ai_next)
     {
+        if (a1->addr=2Esa=2Esa_family !=3D curele->ai_f=
amily)
+        {
+            continue;
+        }
         switch (a1->ad=
dr=2Esa=2Esa_family)
         {
             case AF_INET:

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvp=
n
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adf=
e7f8e22b86e274a
Gerrit-Change-Number: 2326
Gerrit-PatchSet: 1
Gerrit-Owner:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--vSnFEcZgE88=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">socket: check the address family in addrlist_match()<br=
><br>addrlist_match() cast each remote list entry to the peer&#39;s address=
<br>family without checking ai_family=2E With a dual-stack remote list, an<=
br>IPv6 peer compared against an IPv4 entry read past the end of its<br>soc=
kaddr_in, and 0=2E0=2E0=2E0 matched any IPv6 entry=2E Skip entries of the<b=
r>other family, as addrlist_port_match() already does=2E<br><br>Change-Id: =
Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a<br>(cherry picked from commit 756=
d140aca1958f71a701b4179e2e59fd3d86ead)<br>Signed-off-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/socket=2Eh<br>1 file ch=
anged, 4 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/2326/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span=
>index 47083ad=2E=2E80f09a3 100644</span><br><span>--- a/src/openvpn/socket=
=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -736,6=
 +736,10 @@</span><br><span>     const struct addrinfo *curele;</span><br><=
span>     for (curele =3D addrlist; curele; curele =3D curele-&gt;ai_next)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (a1-&gt;addr=2Esa=2Esa_family !=3D curele-&gt;ai_family)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>      =
   switch (a1-&gt;addr=2Esa=2Esa_family)</span><br><span>         {</span><=
br><span>             case AF_INET:</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=3Demail">change 2=
326</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2326 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bod=
y></html>
--vSnFEcZgE88=--


--===============7200496144681499437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7200496144681499437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7200496144681499437==--

