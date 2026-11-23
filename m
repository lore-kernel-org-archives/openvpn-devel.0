Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D2606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jTBHZD9+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X4IqPhQ1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LCTIE0uE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Yu3eS5fF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Sy9NADCAwbOvgYqY40Og/ofwImzHwFwlVLiGMKzI4D8=; b=jTBHZD9+a23/3v6dMtdhmc/v11
	2jaUvHGpLQXD8AI+PZcd9MeK9rbrbFyVaMt7wnnwGyzXWjCN6cIXrmMH8UkY3qjcrvgWXRkNarePz
	KPPYvI5794bkWqEtl9e2XbKQoggR6EQrs6fCS3Bv6gusG2/hrJm9i4pVnbE3sYvOCamQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVQge-000000001Py-0YLy;
	Mon, 23 Nov 2026 09:50:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVQgZ-000000001OO-1Njg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wQVEmXc/E5ofD7MtzUNh/g/gODVBKA194hnQpkazirc=; b=X4IqPhQ1SLxNrgn2ae6dugpYy6
 QWod0SKFaKuZP0EsGB6FlMZF2dLyn7rde88msysBGUuuLc1eS3d63LUzlufoDwL8TIqoNovoaBm0F
 pAoOwThMzPfB/wd1OlMLx7jtH+ORXgcE3yd4FATBAlzlZxOBTsRV4uBYjmj5GTR989cg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wQVEmXc/E5ofD7MtzUNh/g/gODVBKA194hnQpkazirc=; b=LCTIE0uEZQXemP+BVi9AQt+HYV
 ul1Q99I8ro7tIpbPO9boiEUKIom9Bj5PWolNN0OCfXl7vkiqm7XJ0UMyDvr8Yx8/65LYGRyav0k7K
 A7Hi6ts9mwqob40wPeR/cQbAFiQ5NeKsl05OM4Pgfhp0+/3FgkO5qCVWNKIhrJF5JiZg=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVQgF-000000002zp-0iAs for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:49:49 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so19234305e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795427380; x=1796032180; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wQVEmXc/E5ofD7MtzUNh/g/gODVBKA194hnQpkazirc=;
 b=Yu3eS5fF2fkbxO1Wg+dJ2hcVUNub03DSdO3btof4N3zZgrLT94MZdlNgsU24YAlDxK
 l2F6yK1bqn2VF2NKF0TDKm3nfFcmqvevaeAsJAVWxV3v3J8XRywYl1XgCIN54lZej+34
 d44m8idi4gHn82xPTjscNrZiQ7aRXBIDV7pTpsafgfEJFu+0M30KREYWcv3JA+wd6i6T
 R7BvFm+RVRYzoJngfRZpnVpC5rO9hUVaYop2qgM2eElXYkvXUK8OgaYxpRgGK709A1Lb
 HoGdtuniIsL55/qm30aBacTvNJEjA2S30YrGtCALyiVgutBbSg+BEA0xiZGHNKfFWs9K
 aqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795427380; x=1796032180;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wQVEmXc/E5ofD7MtzUNh/g/gODVBKA194hnQpkazirc=;
 b=ArECXQ+TdIn2is9/hta/1CA9uVxpvstmFWj4Hb+6ImfNXb35sWp4Zj2uUes9TJk45Z
 Djtj9OKW5T7CvNSL4reGlMOaCNpLzHzDOlHRgKue9uruwl9+gQJQjYvSCRWQM4gYjjIV
 BFitUV882keUYcbAgFfVyrmqIF4CfdYaGL5U209N4/a4KIf2JnVTTU4Z9m/b5EcyCsFJ
 AjYlX0FszXh+qdQjbvHl/E6Q4a1ew3pqUKU6wNtpD28DohczOnrBQK2kK7l8Yr6mvVsY
 1Jrxhvj3v/Ha/rsz609hQkAqrrmVAh/lo6wWFMNK6r48R8vQ+JGeclT6Qd70QnHv2IrR
 u/nA==
X-Forwarded-Encrypted: i=1;
 AL+hErHv/2d2aRq79KCQ5sRsYuVPCtnrUefbjTFEdPH7o9AXRMkaCW79TMWxMDDyKi+qPC+aUNcHiKiGSUOPJKOQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z84G3w5JgmU8jK7sKE4nU14xasgeZk0qou2G3TDWbpaX909Sso7
 ++X8YbCe2YMFdNKGwSh/UMzyVIevZdHe+sGpivUoX0p7IbrnvXJ5+iQXs8fZZndUyy8edlorR/W
 7wW5oqIYofXz9S8S2v2wqpgeigNUlRTHxzFX2DVD4FtF7XR4Kh+mx7qNG3ITfXI+UR6N89RA2mm
 JsJuQs1g==
X-Gm-Gg: AZFdTZdVGYtXfnKmz4SWWXsSsOzY/xp87jAFBLkHOltg4KKGHTcFKZQsFUiuJgqtbbB
 NUSOeOjB23/OHJOAh7eUO7wuob3XiipfW2dfiqCqoeW/bb+RuSPqz0SkDBxugvMzaDlEERYWNwA
 htjeAsxkUfi3OxnR3WPYaMcT+Y+VXN6MzpGj2mEDbM0QCXTCUd/ClEiXDwQXO5EI4zzeVyALgqN
 NBVZSb0P+/Wcxluv6aeoEglJOU3FswLGwZNDLZ0X3YfrDaoPYOetZnEZUw1tt5CXXL6eCXS63pt
 +FgndcnkmkbSJactepedcg+9imbz2x8YUl1KQauNdWJ4KuxQ0xax5oMcHfakQIH+DZHgXGknvC0
 9zmyxM1CVPDgHuYkC77FwRv0g11uASEwvOAGM7O3+LNP4K2kFJ2nhDzPN61VtO8TEtwciLv+7i5
 VR2pG5qO91NVgS9oiuyi7N5mPlqmhpAqBgS1JbcLZhs26nfHYG9xAqmbJYho04gQwDqEQAgqvWz
 07ugMzg5RIk1gXBOdp+ab9pn/8OFXdS+rPU5tuTy2azKgqGJPuxIcyR6wpizqgDpS1dRLPycoAo
 Wqw6JZ01k50ozVGWCsXVeBRz+KoDd0R2aOHpl9HrZ+OG/E6IDQi/EmE82EpXBb/kArDiVQHapjH
 GYf4/mIjNKl4Orv80gS6XNpZa6/+mWAm1ZWNGCU8gQLdpQeWNIxVtINVtEXY424H4PDGg7Ggz6a
 HGSC26D8OJmo9ANH4=
X-Received: by 2002:a05:600c:1c1f:b0:4bb:6847:7943 with SMTP id
 5b1f17b1804b1-4bb88814510mr274776075e9.26.1795427380445; 
 Mon, 23 Nov 2026 01:49:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f0f1csm147556365e9.0.2026.11.23.01.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:49:40 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 09:49:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2215
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2215?usp=email>
X-Gerrit-Commit: 756d140aca1958f71a701b4179e2e59fd3d86ead
In-Reply-To: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwNjU3MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ae706f819fee6cb5a298775e79295342ec2cc86-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVQgF-000000002zp-0iAs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: check
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0046015217996207243=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0046015217996207243==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UvgfY6JSF4E="; charset=UTF-8

--UvgfY6JSF4E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2215?usp=3Demail )

Change subject: socket_util: check the addr=
ess family in addrlist_match()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

socket_util: check the address family in addrlist_match=
()

addrlist_match() cast each remote list entry to the peer's address
fami=
ly without checking ai_family=2E With a dual-stack remote list, an
IPv6 pee=
r compared against an IPv4 entry read past the end of its
sockaddr_in, and =
0=2E0=2E0=2E0 matched any IPv6 entry=2E Skip entries of the
other family, a=
s addrlist_port_match() already does=2E

Change-Id: Ic3efcdb7bc4e60a81b9292=
adfe7f8e22b86e274a
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
A=
cked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2215
Message-Id: <20261118163009=2E22733-1=
-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg41629=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M src/openvpn/socket_util=2Eh
1 file changed, 4=
 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/socket_util=2Eh=
 b/src/openvpn/socket_util=2Eh
index a1a61af=2E=2Ee85f6fe 100644
--- a/src/=
openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -312,6 +312,10=
 @@
     const struct addrinfo *curele;
     for (curele =3D addrlist; cure=
le; curele =3D curele->ai_next)
     {
+        if (a1->addr=2Esa=2Esa_fami=
ly !=3D curele->ai_family)
+        {
+            continue;
+        }
   =
      switch (a1->addr=2Esa=2Esa_family)
         {
             case AF_IN=
ET:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic3efcdb7bc4e60a=
81b9292adfe7f8e22b86e274a
Gerrit-Change-Number: 2215
Gerrit-PatchSet: 3
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--UvgfY6JSF4E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2215?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">socket_util: check the address fam=
ily in addrlist_match()<br><br>addrlist_match() cast each remote list entry=
 to the peer&#39;s address<br>family without checking ai_family=2E With a d=
ual-stack remote list, an<br>IPv6 peer compared against an IPv4 entry read =
past the end of its<br>sockaddr_in, and 0=2E0=2E0=2E0 matched any IPv6 entr=
y=2E Skip entries of the<br>other family, as addrlist_port_match() already =
does=2E<br><br>Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a<br>Sign=
ed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2215<br>Message-Id: &lt;20261118163009=2E22733=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41629=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/socket_uti=
l=2Eh<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br></pre>
<pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span=
><br><span>index a1a61af=2E=2Ee85f6fe 100644</span><br><span>--- a/src/open=
vpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</span=
><br><span>@@ -312,6 +312,10 @@</span><br><span>     const struct addrinfo =
*curele;</span><br><span>     for (curele =3D addrlist; curele; curele =3D =
curele-&gt;ai_next)</span><br><span>     {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (a1-&gt;addr=2Esa=2Esa_family !=3D curele=
-&gt;ai_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
ntinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span>         switch (a1-&gt;addr=2Esa=2Esa_family)</span><br><spa=
n>         {</span><br><span>             case AF_INET:</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?u=
sp=3Demail">change 2215</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2215?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2215 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--UvgfY6JSF4E=--


--===============0046015217996207243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0046015217996207243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0046015217996207243==--

