Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72E606A328
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SoBiHEvB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nDf1kH8S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h5zzRmKX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c3c42KIt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6wYZDJa82LKObkYfn5/b+XM0rMsTAstJYeNSWN95Cmo=; b=SoBiHEvBkFgYfKB2h1m5HG1Az3
	YbWka0E43SJQS03mkad+AA9s4CfHIKBwbVdFeRpOY2FXCHXeeoCLo5j/zf1f7UK3Nf9Cws1D4OMsI
	AKorahAJf0WOTGjAK+uyt9OnvbgDatENIHaxBuANvT9ywUnBIwcsMlFDQYh160Zt12bQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHw8-000000008O0-3epN;
	Tue, 03 Nov 2026 17:04:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHw7-000000008Np-1etI
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:04:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BkFv8RUyWZW/0NLmNyDtighIUvFf/MWi1QQxKVMaWPc=; b=nDf1kH8SUCqJml04XJjCpORB18
 wEk5CYqnWB/LQ8COrOQ9gZbxa/jLZyuqfkm2NHroXnUWjqOHU1w8pmHYm/CndlR3kw8KJOf54rbww
 JaUVzLxJe1eOyrr4mO3VG2S4Bkf4L6dvk0rRVIbl6UGsgywMYUD3ogZYjp8C6Wy78M18=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BkFv8RUyWZW/0NLmNyDtighIUvFf/MWi1QQxKVMaWPc=; b=h5zzRmKXIZ77z3RTnJ8q+UQD5E
 T5r/E6j4Y5XJXDddbEyX2FTGQw9WCR9dZNvqMLvZsN6kXXQPe5ekKVFS38/1SfHgza88MHEzlp5Ew
 0OQak9H6/ofAxpXI2bX0Jy4Nh4Hl2vmoYfSnncXZa0veChITZgVPxvwSNIwg1Aq1IccI=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHw5-000000002P0-3DUU for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:04:39 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so639350f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793725471; x=1794330271; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BkFv8RUyWZW/0NLmNyDtighIUvFf/MWi1QQxKVMaWPc=;
 b=c3c42KIt9C8F4HVuo0n6H+XYrwhF5Z5PBTijj/9YCA1mAzoiUL2qHNSRGcbCUPhyM0
 FAzH7z7uPjHurIK39JW3/yM0FPJxhrobmwofxOPcw96C2llReRhHAdRzwxeijbzTQ7xI
 apUnzhYP1a7PiC3d+hMnAEQiAaWVhGT4hxQF8vgJygJztgOLamfuZLQgKeS9ysE+mkyV
 QiD7EqXgH7oBuQLISMKMhafSZEhAmnkxEMlme1CTKIf7S+oeWs5+4KxpZmcuQxXLdrQ9
 6H3DTzxHYcMpheLw8zXwUe1tJdR/rRgeFhhQwNGVtFeuD7i534njehA0C7ynCxnNSnYX
 FVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793725471; x=1794330271;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BkFv8RUyWZW/0NLmNyDtighIUvFf/MWi1QQxKVMaWPc=;
 b=0ztAf5uDC/RMOE2NxBsM6Sc2QwCcProx18ZCmBJXQY0RxAflkgd/NzjGmw9Mcm/HnK
 6jYDV177TwkEfLwXnfaxyECpBBKRybGt3SkhA08LCs9ub0AuEFSuoAagPBZalp6WpPgZ
 YMHF3BoNQPdgKFQqmM93p7KpR5BO02/UXunh+Dgzevj3s6o2D57sG98Uh7OpgVQk1DwR
 a94SnY6hyAkhaYMN/jTdUS/GzYeR0+HQQf3iI5rlcZxIrAVkf2GUqBZQUX4ruKy365Aw
 5fA9bIgS4lQ1/q+uvZBtf0DqnQ4BdeAeth8fA+DVJ/qshn1ALgI37LP10XzARooODR0z
 Ry8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGeoGM7wqseQawgzYRsURch7SuuhRb7rLnEJvoTv/LtCImPz3fRWH9xnr4sE4QV9UVhHmjThbr180kPrFl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/yXdDkpGHtyS90y9zeWDzccLr1iVipHib3m8rUZEWvbdqgzTFg
 8xuBG8PuHdhXgndfuF/SxO+EROW11ers7kFQB9Rk+vskujTXwHnXZaiQryisRp1vliu9duTruNe
 mig5kFtH2nMC8Gf0gT80AD0rNiUAuqhcpNsyryXC5Hh5FjuuuHwu5xpiieFojuizY+5UPNYRWeV
 wSx9NMQA==
X-Gm-Gg: AYBFou0PIKiGyPfoHfCfBkLOu7FqN/xtLZcNrGexmkIHYxkB0uoUbxMMiSRNHPNJvc/
 NBhXDvNoEpCioAxkw05fD1GsThFUBxd82hrCEEyxUy6j+wOgyJe2D5ZOuBeQHKRrWmaZCIQ4zJ3
 DpjTZWi9mV5z0r/snkzqQMzPgwqL5F1VHNzroeiesVDtG07ksnDnbXvaNPukZt2dWs+/KcJiTgi
 MCrS415C2FFNM7vqKvwZYmxs7f92xsinYok4qk/4/fsx0PBYE4zn2zDPK9JTnQz9f6lMSpswaiI
 wOnDhig7GlwIPYNXRMSNbieMIz8yzK1iTDcfyAK/gK7EdTOxVc1WjkDUjS9sPFTMSWnSGv/rWqp
 VR2bUK7tKJsUUZNT+2tJwwah8raDIKkpevhM8ma1mpq4NTqzelqC1iTfsErKyfrxa4WLx5HmPTQ
 Ju/j7wS4QcXPbKvujwlqDhP5Tzpb4sytqtzoCknemijK9q7Eg7cH4WnYizusVUYhG0VoLo78CZK
 VUQ386+J8O0rv1v7v6NYSUGmnWyd1IdncbcPauOVdugl4OedjHBMJLar70BtZw50TDBLcPUe5qH
 xrwyw5H9kpWtOEJzKCQh2j0rK490F0id1GfEQoWt9+u+YJezV8wGN5gQ+kaFm38tXvwd/egiENi
 vwjGzXq4ZaXpv80aoVO0TPvO2TSw/JsjMg+7uVeqPImU6h8ZYaihYTt7bYsfi76ltdyrgjwlSSR
 Ia8n6wg3NVVY7OgA==
X-Received: by 2002:a5d:5e81:0:b0:48d:f852:c66b with SMTP id
 ffacd0b85a97d-48e64cccf13mr42079765f8f.22.1793725470993; 
 Tue, 03 Nov 2026 09:04:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fbba47a32sm3133149f8f.1.2026.11.03.09.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:04:30 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 17:04:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
X-Gerrit-Change-Number: 2086
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2086?usp=email>
X-Gerrit-Commit: 791eb227d912a77713245f33854bcfe84a2dcc9b
In-Reply-To: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
References: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MzM2MDAwLkk3M2NlYmNiNzY0OWU3YzJiZmRkMjlmZWU5NTViMTkyZjE0M2E1YWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42e70446ced95f8a8d1ac765042db231c4bfb8d2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHw5-000000002P0-3DUU
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: print
 net_gateway info instead of unset rgi/rgi6
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
Content-Type: multipart/mixed; boundary="===============5846675358130852050=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5846675358130852050==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B+DTJp0kPr4="; charset=UTF-8

--B+DTJp0kPr4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2086?usp=3Demail )

Change subject: route: print net_gateway in=
fo instead of unset rgi/rgi6
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

route: print net_gateway info instead of unset rgi/rgi6

i=
nit_route_list() and init_route_ipv6_list() print rgi/rgi6 before
they are =
filled, so ROUTE_GATEWAY/ROUTE6_GATEWAY were never logged=2E
Print ngi/ngi6=
, which the surrounding block checks and exports=2E

Broken since 2777cdd3 =
("route: handle default gateway (net_gateway)
and nexthop towards VPN serve=
r separately")=2E

Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
Sig=
ned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2086
Message-Id: <20261102142000=2E30467-1-gert@greenie=2Emuc=2Ede>
U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg40495=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---=

M src/openvpn/route=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)


=


diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 152d0d2=
=2E=2E53550c4 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -619,7 +619,7 @@
     {
         setenv_route_addr(es, "net_gateway", =
rl->ngi=2Egateway=2Eaddr, -1);
 #ifndef ENABLE_SMALL
-        print_default=
_gateway(D_ROUTE, &rl->rgi, NULL);
+        print_default_gateway(D_ROUTE, =
&rl->ngi, NULL);
 #endif
     }
     else
@@ -770,7 +770,7 @@
     {
      =
   setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6=2Egateway=2E=
addr_ipv6, 0, &gc));
 #ifndef ENABLE_SMALL
-        print_default_gateway(D=
_ROUTE, NULL, &rl6->rgi6);
+        print_default_gateway(D_ROUTE, NULL, &r=
l6->ngi6);
 #endif
     }
     else

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2086?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
Gerrit-Change-Num=
ber: 2086
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--B+DTJp0kPr4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2086?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">route: print net_gateway info inst=
ead of unset rgi/rgi6<br><br>init_route_list() and init_route_ipv6_list() p=
rint rgi/rgi6 before<br>they are filled, so ROUTE_GATEWAY/ROUTE6_GATEWAY we=
re never logged=2E<br>Print ngi/ngi6, which the surrounding block checks an=
d exports=2E<br><br>Broken since 2777cdd3 (&quot;route: handle default gate=
way (net_gateway)<br>and nexthop towards VPN server separately&quot;)=2E<br=
><br>Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9<br>Signed-off-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2086<br>Message-Id: &lt;20261102142000=2E30467-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg40495=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file chang=
ed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 152d0d2=2E=2E535=
50c4 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++=
 b/src/openvpn/route=2Ec</span><br><span>@@ -619,7 +619,7 @@</span><br><spa=
n>     {</span><br><span>         setenv_route_addr(es, &quot;net_gateway&q=
uot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><br><span> #ifndef ENABLE_SMA=
LL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_defau=
lt_gateway(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        print_default_gateway(D_ROUTE, &amp;rl-&gt;=
ngi, NULL);</span><br><span> #endif</span><br><span>     }</span><br><span>=
     else</span><br><span>@@ -770,7 +770,7 @@</span><br><span>     {</span>=
<br><span>         setenv_str(es, &quot;net_gateway_ipv6&quot;, print_in6_a=
ddr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc));</span><br><span> #ifn=
def ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   print_default_gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        print_default_gateway(D_ROU=
TE, NULL, &amp;rl6-&gt;ngi6);</span><br><span> #endif</span><br><span>     =
}</span><br><span>     else</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail">change 2086</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73cebc=
b7649e7c2bfdd29fee955b192f143a5ab9 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2086 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--B+DTJp0kPr4=--


--===============5846675358130852050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5846675358130852050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5846675358130852050==--

