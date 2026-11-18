Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA2606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X1sDu2c5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W4F1p8QS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OutmnH5x;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xu4WQk3y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Ka+Sn8aLE2/ZP4VbhJm1ViJ8jLpsvnm2xLDIKQwyNcA=; b=X1sDu2c5DkX6/vexGiiiTebcAN
	FC6Jq9aHn5Ty/X84k0z4pwhndljPt3KPxnuCQWHkKDb76t543bk4w6YK+DLqYmB9J1M0XCPcdLjP7
	n/y8VNq+GwSCG1Wr0rY16WUYshwyR8iSU4LzLkZytFbvguNdpvSMDXxRuYezlWvS/cNE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTcU2-000000006ux-0p2D;
	Wed, 18 Nov 2026 10:01:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTcU0-000000006up-2eFR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 10:01:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eiLonog0KrprKygWDLRIkqnVYilTS7AfPaQ0aAsC61E=; b=W4F1p8QSkgfGod1kL4D3kKAUBM
 jcvUzpKx5Mw6OP8WHsJRRFjC0QLnjpvKQG0UfaUuJO5HyDARKFvDvw6Rq/kIeG/Lz2RU1364ImO43
 Cl5zTPcJkJke9WawE4LmeM5TCMviqCMOZX5vApfVZl5tL828f+QxkRfHG6fSCPzeFicY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eiLonog0KrprKygWDLRIkqnVYilTS7AfPaQ0aAsC61E=; b=OutmnH5xXoLTZvj/3J/gnMaHzQ
 ezBvE0+dd5/of8yurO6zv+T7PbcE/IlurOSwP29BBOQ8HYdqTKRLNSHdCuCIQBuRMQ2iXQJ5zcYOr
 Gl4KhdvNYh71z9QqRaJAQXreUuboSZ3NFQhr/jEtMx1uAlju0QyQWG7NhqXLVJxWBlnk=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTcTx-0000000032G-247u for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 10:01:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so6694795e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 02:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794996091; x=1795600891; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eiLonog0KrprKygWDLRIkqnVYilTS7AfPaQ0aAsC61E=;
 b=Xu4WQk3ypln30HroHikpRG8TJzYsTuaJiRxjnzEGCIgOUADBDusG5OJMwpCe3wJ+fv
 BviLhH5dGSQ4RtYLcD0fEfvkcvL+OYDfB4Qn3zzV5DrkjdsVxEZ/5GSVf3/8wfOAz+r7
 ob9MyDSOziGjC7RKEMmw6ZBhq+pQ16NWGGCvwk5Tx20Td5+Mk6rPkLyg8IZdmwRiL5wE
 syIiYHxnhQoFZT+t360GNQIFWadm6zQyN2mdwxMc2hNciLIV07lwSyEWVrJ02CP4H66M
 n0QmIsKIZFocG827Tc3Zq7k7N450bC5dZ0JMQ7SQI9inWJXtR1FCxR1q1j27BMXTYClB
 3uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794996091; x=1795600891;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eiLonog0KrprKygWDLRIkqnVYilTS7AfPaQ0aAsC61E=;
 b=plsBPDNMRKcKANGO/i55Pqln4x3RzFEcy5KAneASO4CkBa84eEftOHecR2s0zzbRsi
 l4gxOOHzg2IqCOXbmRPLUGDz9svBkUfmyCM9mhi1t0xIslTzfQNOmG/9cYzkd8Nk/kiv
 lU+GVzzm9/Sd/+qxfo/TCGDH7aDcgAbEWLSCBGlq9gAonx4OnubV7FU1qTHRyUVbdoQD
 9qsUkVHcswe/mEtLNz1t438UdbtvuG9X6oo16eBw7mq8VEIgoFvFJ0pWpSaZjhA0RVPw
 C15dw2GH2ocMsbLckJe63jIVa0goAq7khEzmnLIEOvSohBp7zFVzR4rzMZHISy7yKxTW
 +OEw==
X-Gm-Message-State: APuU4Z/UdwR8hMw/E+jUdT9UPr0Vvcc9EWxEeqgZrjL3EkggSlnv3PmN
 6Jx6rwElxustx1YKkJwRnPouuWfuOfdFKfqyPBQUqE10eB/xy3APR2p+YFR24qBL2oAK3qWDLCX
 ePiNTgLrhiwabahqduXSJbuE5estXW78uGfrVnaXsUmysM67EODvC2BRN8kdH/OwHr2aAmzcv8V
 5SjUgh4g==
X-Gm-Gg: AYBFou2APMos5DwMSBkv7rEH4nH5U0Nqxzp7v2tWxNSyZeCOl+6d6LgatOJcmJCQXWT
 lWxhGVPY5cglkdEtjLny7I4CPEzccqQE6KPmz5cHhPAcEs9Ydn+w5H9Q+wOQVlymtGu8ap9UDqJ
 Y/oWE7OPbcCBokvDom+IYv9ZuLOH4EWkCmXdeSJPi942yrwJikLr7xPOMRvBJEXm0JadmeNIfrr
 zlKOgdILyGfsCQnLfUe5GJw9GOCro7dlSwQV+I64Xo+OQXWf8G/8RCK57iD8t4x0nZ18tgZvVug
 OgFE+7gWMrVPjZpZ5U2c/HbdA0EjEbILzumLwxDxgmeoUjPIUZGXNTXRfHWhR0bM4s1q7+QjsaC
 iqnqgBI9vK0mdOYwJvPau42BGDKT2LM1CZzhX/W2QP9qfnD79cNRn46HOjCiCGj8s6GPx3b4v6a
 8mLvsVLRDglU/8nsrqDR4hQeTcE/BxFGUhTbOHWe60C7eDgBgSIL7SeFQ1CpMCxyxx1wm/1JZNH
 4iSTR2GwkdsKuf3bIM35VTqE7gKi7+rDt9K4u11mOodMq6jmElOfd1VBuU6WlTZrMzWRHQSd+Kk
 9hf5r2mjMRJ70gzIGbfTmPPqpVpN+0bT72boZT3Yd5oUXz/BUTAryd4Om9/fWuU9kL+fpvLiQOt
 HDmPKTdYAMYVMyhR5AWAXT2oHfvJi9oOc5Rf0LnisiSfl7byEk8mYcunntSykxMyL90tVQ12s2E
 F8S6J+5OQ5Y/p/djU=
X-Received: by 2002:a05:600c:3e05:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4bb7da03dfemr34535525e9.11.1794996090622; 
 Wed, 18 Nov 2026 02:01:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2ac6e0sm60940635e9.8.2026.11.18.02.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 02:01:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 10:01:27 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I399411e328c7d4db4d2033500cafc0479ef0d65f
X-Gerrit-Change-Number: 2218
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2218?usp=email>
X-Gerrit-Commit: 606f1e47cd6e491d614e8ba7fa12847754491bf5
References: <gerrit.1794996086000.I399411e328c7d4db4d2033500cafc0479ef0d65f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTk2MDg2MDAwLkkzOTk0MTFlMzI4YzdkNGRiNGQyMDMzNTAwY2FmYzA0NzllZjBkNjVmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d91bd9855e2d9d82f4dcd4760b19443e249ed189-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTcTx-0000000032G-247u
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: occ: apply the
 --mtu-test size steps again
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
Content-Type: multipart/mixed; boundary="===============8612998354962108306=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8612998354962108306==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lX2TeJbJ5P4="; charset=UTF-8

--lX2TeJbJ5P4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2218?usp=3Demail

to review the following change=2E
=


Change subject: occ: apply the --mtu-test size steps again
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

occ: apply the --mtu-test=
 size steps again

Since fb76954a, check_send_occ_load_test_dowork() ignore=
s the delta of
each mtu_load_test_sequence entry, so every probe has the fu=
ll size=2E
When those are dropped, the test reports the size of the largest=
 other
packet instead of the largest probe that got through=2E Add the delt=
a
back=2E

Change-Id: I399411e328c7d4db4d2033500cafc0479ef0d65f
Signed-off-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/occ=2Ec
1 fil=
e changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/18/2218/1

diff --git a/src/openvpn/occ=
=2Ec b/src/openvpn/occ=2Ec
index 38685f5=2E=2E86b3a83 100644
--- a/src/open=
vpn/occ=2Ec
+++ b/src/openvpn/occ=2Ec
@@ -202,7 +202,7 @@
             size=
_t header_size =3D
                 frame_calculate_protocol_header_size(&c=
->c1=2Eks=2Ekey_type, &c->options, false);
 
-            c->c2=2Eocc_mtu_l=
oad_size =3D payload_size + header_size;
+            c->c2=2Eocc_mtu_load_=
size =3D (int)(payload_size + header_size) + entry->delta;
         }
     =
    else
         {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2218?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I399411e328c7d4db4d2033500cafc0479ef0d65f
Gerrit-Change-Number: 2218
Ger=
rit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>

--lX2TeJbJ5P4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2218?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">occ: apply the --mtu-test size steps again<br><br>Since=
 fb76954a, check_send_occ_load_test_dowork() ignores the delta of<br>each m=
tu_load_test_sequence entry, so every probe has the full size=2E<br>When th=
ose are dropped, the test reports the size of the largest other<br>packet i=
nstead of the largest probe that got through=2E Add the delta<br>back=2E<br=
><br>Change-Id: I399411e328c7d4db4d2033500cafc0479ef0d65f<br>Signed-off-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/occ=
=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2=
218/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec</span>=
<br><span>index 38685f5=2E=2E86b3a83 100644</span><br><span>--- a/src/openv=
pn/occ=2Ec</span><br><span>+++ b/src/openvpn/occ=2Ec</span><br><span>@@ -20=
2,7 +202,7 @@</span><br><span>             size_t header_size =3D</span><br=
><span>                 frame_calculate_protocol_header_size(&amp;c-&gt;c1=
=2Eks=2Ekey_type, &amp;c-&gt;options, false);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2=2Eocc_mtu_lo=
ad_size =3D payload_size + header_size;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            c-&gt;c2=2Eocc_mtu_load_size =3D (int)(payl=
oad_size + header_size) + entry-&gt;delta;</span><br><span>         }</span=
><br><span>         else</span><br><span>         {</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2218?usp=
=3Demail">change 2218</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2218?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I399411e328c7d4db4d2033500cafc0479ef0d65f </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2218 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--lX2TeJbJ5P4=--


--===============8612998354962108306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8612998354962108306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8612998354962108306==--

