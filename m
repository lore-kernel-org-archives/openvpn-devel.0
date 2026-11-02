Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4968606D807
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z2oRVXMw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gM9Fjn1b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gt3UR0xN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Nc+vpQ5E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ENkuTmpk/sIzu9BI2h6xcRk2VQ2agv23F3G2mDxbFkc=; b=Z2oRVXMwjy3V3WHRVtq6X19DQ5
	stRVjYs2Shvh9REBvemzK3o5aEiWrT71y1uN4lA+gPp/ys1K1UvFebeRTpveI8atGYWmqlgze6GIN
	c9LvZtSOZRQw02iGbFzJxU12qVQ9ZiGRHoSIhpKVdaF5V2oTrfjoeE+kmFjxUHw1ZbC8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNwZv-0000000052E-1uiW;
	Mon, 02 Nov 2026 18:16:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNwZu-0000000051u-0owY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 18:16:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wXSKCG6CnECQ1pMA1yeh4kzRrMtrc+27Iu/XlsmIKkA=; b=gM9Fjn1bxOTSfc08fE4uuuvvVd
 USkXFNEi/RsN4LHCE91KNI3t+uXvfNyTvmPk6H8jxFY9+5d5qamGL1e24jhOj6yl3B3Yw7S2acWLj
 B2oGJVi2GaXYgmqo4T7JgIjt1+9Ac+CiL0mw/QVRjxGX2W4nDtHQSHi8RTOUVk/L8l94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wXSKCG6CnECQ1pMA1yeh4kzRrMtrc+27Iu/XlsmIKkA=; b=gt3UR0xNgsr+cpCZlm8nSrHGNP
 kK8U4E48/T9ADdzdVTkAH72MQ+7ab2N0UORtGk+5u79KsRBd8hMC+VxrfjGWGGvGoELoLvufog2lt
 CQdd2d3AKmnZMFk/CKIlzz9VgPbNbTd92CW/Y8vqx38gjeXB245F8+ai6/U6ErNkzJJI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNwZe-000000008SB-0umf for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 18:16:03 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2037381f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 10:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793643356; x=1794248156; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wXSKCG6CnECQ1pMA1yeh4kzRrMtrc+27Iu/XlsmIKkA=;
 b=Nc+vpQ5E3YXRe804DPxUY+RBr1Ccrgi37IjRbsKLvMr/rFA8wOhdBlZ2eqHnzj/QJy
 7hGlZrFuj2FEKzdm9qcqrmVbp1iiSWjgTnNTBz0xK29NiCbMAZWbN7C7JOfNL8K1y6z5
 8aUep4Uzajf8nbPvgIqBPUFBL8grptlFMKxqfCf8coxssS7Z/HxQUjuedvKQMoO2XAgA
 Y7rTqpBT8lxAtGVUtSqcBJD0nLC7uIj2gt/vAKfGijjg1WEPd7hYcZ8Hi6NoQnuY4LTg
 OeHE1c8ee1hSMoMOZeLo2y/pgCFq0ud0RGVuNdNQojc5Q7QZFWHIFZztLslqvsUQdvxz
 w3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793643356; x=1794248156;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wXSKCG6CnECQ1pMA1yeh4kzRrMtrc+27Iu/XlsmIKkA=;
 b=rjwjYVKqN/LEJcNQHmYeBAh6lHiqEpap66R9xXPeN+TtIe5SlxvlmVIF2V/8zDepl7
 AntTe4EZzVotuYDLVaRjNiULzhm9UQBfP4DWOXonIAtRRyGyKdn8knzgmZMf7zbWOcym
 05CNExazsJRgWxOQvQCF2xoAdcGXfZVCc1LskjREBX1KyLJVJKyNLYlTPztWEvBX+26T
 CP+pTC7d8zLMntLGJRiWqYYWSj3NWaijaQFdRLn76apYxzLjtsJ/anRY5jCDzgpqBQCK
 W04+CWGJThokVwcKOJNZPGk1vQ9BXC1TEqRqWBT1bCzj/O41oGZToaqNvzGjcqnt7OFl
 nMGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLHk/mpElM9XvQVG81Zsvk+yWGS8+kTcQu+xWn5We2x06BtQ/dMlj93h68RpzFMGani2EKEPs0rqpQdPpQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/3utJ/wz0KC9CLkeQfwOgMVmyD450rJVMSSYfxHHnhvnykwPwU
 3K5iVnKnunPlL0B8fVOhnAO2cd9ZDe1azrHzrQ6hbbnwHl7Uct8aH9M6W7lQnFUQEby7Fk6sopl
 SNMmN6bC+JHaTZjEVuTtC1YLNcX2RXs2KEK7UjCSOC4I22RWN6ZQp+cvNnsgVurZtfJCa
X-Gm-Gg: AYBFou3rXe5o1pgXGl4uldPBGiGxXsUpo/CRW4o53bKyHMvCEsydOWEnsEV+rVR8NdH
 eABDUYyLK9b4RZIObb0SkZhwdPus3kp8o0bsDfvi2Z3rPEkUABWRP8SRy6N7kK0bOjnZ2u6pyLO
 gpaKHhtHqLL204RA8pxvo5rkCH8CS92fmAjX/Vni38Pctt0Eg09IROCtbl24Sa4FSR41OZsF0yh
 nWsE8KzNyMOz8b+K1JslZpPZP/tAPNecodxE5LGYAOvXxipILqTh8UE80Qefl7olc/VF7qrg8LF
 JAvEDPaxBuGj0HcptbeZwvX/+0Mo4Kn2qFku6p0Y+USm7gJ++6DIVDNsjDFZGfq6fk2KB/dvm98
 A5N3ZEeUM80yh+IOwCuedcybiHG9olJ+Iz+0cd3rJGrpC7UCkDHFoSXOP5sgYeeitXkmVtTCZaB
 DZBxshhNIE3t7AsmTBnVt/IprXqQbtdckBZHOXQxu6fDvwsBMBwL8lCCBmEUgJiloZU4KL/GCuh
 Cf+C6MIcPHqYAXnmKAs6E909uUEZ1K4SeyHHdTqv5AUQnvUSeqTgynK2AQU/km3l+VI34t09N1X
 jndzId2ZpLdAS1Q5tRfF+aCHt7J3A6yJZ+jw9tRzWu4CqivJ5kNncWR4qCSjW6c97C02P5qo8MX
 4JmcvLfmqm1y6dZx+wsU7xKHjirjA/2tj7xYlPijE9eVen44aRhE0PFuhPljbVJoc8WDOfAf680
 UUqgFe3aun0HsWXQmJaLn9wFEyl7xKrWJ110o=
X-Received: by 2002:a5d:5d09:0:b0:48e:4835:de5f with SMTP id
 ffacd0b85a97d-48e6e4fcf2amr22366041f8f.47.1793643355530; 
 Mon, 02 Nov 2026 10:15:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7246fsm21524893f8f.19.2026.11.02.10.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 10:15:55 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 18:15:54 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
X-Gerrit-Change-Number: 2092
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2092?usp=email>
X-Gerrit-Commit: 97933ad9161fac59e4b738b226ad317ff23a3659
In-Reply-To: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
References: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI5OTY0MDAwLkk4MGI5OTY5ZjU1NWQ2NzBiYzEwMTYzNTMxOGQyNDVkMWIyZGU4ZWM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c281aa7e3f29f378556280d978fb40289acbde4c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNwZe-000000008SB-0umf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: free gc arena
 in windows_set_mtu()
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4894088672429636554=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4894088672429636554==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zYyQ9I/p/8U="; charset=UTF-8

--zYyQ9I/p/8U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2092?usp=3Demail )

Change subject: tun: free gc arena in windo=
ws_set_mtu()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


tun: free gc arena in windows_set_mtu()

The arena used for strerror_win3=
2() was never freed=2E Allocate it
only on the error path, where it is used=
=2E

Broken since 0213f80e ("Set the correct mtu on windows based systems")=
=2E

Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092
Me=
ssage-Id: <20261102144844=2E910-1-gert@greenie=2Emuc=2Ede>
URL: https://lor=
e=2Ekernel=2Eorg/openvpn-devel/20261102144844=2E910-1-gert@greenie=2Emuc=2E=
de
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
tun=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)




diff --git a/src=
/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index fdd13ae=2E=2E58f4750 100644
--=
- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -5203,7 +5203,6 @@
 wi=
ndows_set_mtu(const int iface_index, const short family, const int mtu)
 {
=
     DWORD err =3D 0;
-    struct gc_arena gc =3D gc_new();
     MIB_IPINTE=
RFACE_ROW ipiface;
     InitializeIpInterfaceEntry(&ipiface);
     const ch=
ar *family_name =3D (family =3D=3D AF_INET6) ? "IPv6" : "IPv4";
@@ -5228,8 =
+5227,10 @@
 
     if (err !=3D NO_ERROR)
     {
+        struct gc_arena g=
c =3D gc_new();
         msg(M_WARN, "TUN: Setting %s mtu failed: %s [statu=
s=3D%lu if_index=3D%d]", family_name,
             strerror_win32(err, &gc)=
, err, iface_index);
+        gc_free(&gc);
     }
     else
     {

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80b9969f555d670bc101635318=
d245d1b2de8ec5
Gerrit-Change-Number: 2092
Gerrit-PatchSet: 3
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--zYyQ9I/p/8U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2092?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tun: free gc arena in windows_set_=
mtu()<br><br>The arena used for strerror_win32() was never freed=2E Allocat=
e it<br>only on the error path, where it is used=2E<br><br>Broken since 021=
3f80e (&quot;Set the correct mtu on windows based systems&quot;)=2E<br><br>=
Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5<br>Signed-off-by: Razv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2092<br>Message-Id: &lt;20261102144844=2E910-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261102144844=
=2E910-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file changed, 2 i=
nsertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec</span><br><span>index fdd13ae=2E=2E58f4750 10064=
4</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openv=
pn/tun=2Ec</span><br><span>@@ -5203,7 +5203,6 @@</span><br><span> windows_s=
et_mtu(const int iface_index, const short family, const int mtu)</span><br>=
<span> {</span><br><span>     DWORD err =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><sp=
an>     MIB_IPINTERFACE_ROW ipiface;</span><br><span>     InitializeIpInter=
faceEntry(&amp;ipiface);</span><br><span>     const char *family_name =3D (=
family =3D=3D AF_INET6) ? &quot;IPv6&quot; : &quot;IPv4&quot;;</span><br><s=
pan>@@ -5228,8 +5227,10 @@</span><br><span> </span><br><span>     if (err !=
=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span> =
        msg(M_WARN, &quot;TUN: Setting %s mtu failed: %s [status=3D%lu if_i=
ndex=3D%d]&quot;, family_name,</span><br><span>             strerror_win32(=
err, &amp;gc), err, iface_index);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gc_free(&amp;gc);</span><br><span>     }</span><br><s=
pan>     else</span><br><span>     {</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail">change =
2092</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I80b9969f555d670bc101635318d245d1b2de8ec5 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2092 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--zYyQ9I/p/8U=--


--===============4894088672429636554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4894088672429636554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4894088672429636554==--

