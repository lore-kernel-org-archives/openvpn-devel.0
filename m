Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7471606C3F1
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pu0kc8PO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JvZTfvyG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AV6wOMT/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=f8c9T6Ts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pxjlBJp7pNuiPgZkFGjfYuzGCV2zadIckMhGqNvw9ks=; b=Pu0kc8POISUQkZyJAcGpBN6Q7X
	hiSYSCt8+f+hiHWgisdEZgAoUsl8MHgrsNc5+VXGE7Te7X82jlP1o/Hk6++x0HLRM2MhHB7Sfpi63
	S+7h4zwUDalGuzHG7sOFKcKQQyZ9lpm8gRq3tEUuspvnUbQpe05ptO06Hqzzl2n3lAHE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtHy-000000007sP-2OHM;
	Mon, 02 Nov 2026 14:45:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtHx-000000007sE-2Jph
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RtpfWAmnma/O56VebWKuPkP+Fe0qQ6lcE8KIcTnnW1s=; b=JvZTfvyGiXt5Zoe6VfhoVFEXaD
 D071MyEwZgLOoK/Ch6vzY0t+Z7EH8A9S9hpoPekO+BBUX8vjdofw3m9OTnjMw2zN2CuSNn0GmsvCN
 gCl/sYMCrmjI8CBSZz5LksfW4rW3+xMFhPEr8AWop4ecqpA7v+MoeEjYMNKCMGAxUofs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RtpfWAmnma/O56VebWKuPkP+Fe0qQ6lcE8KIcTnnW1s=; b=AV6wOMT/E8IX2VOGM2mzLmnCyW
 e3OrpeSUB1fLD7j72+kdArEse62uNSIpYgqnaTVqEtLVRDi/+0OWf1jlbGDgZoh1Zc8it3J4vCcoE
 8lsBflN/MUoF0mcUAicOU669In7uL/W31exao8DHcshxPRWMweTXNeza+eyave7M+efs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtHv-0000000028a-49ym for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:33 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e04773687so892999f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793630725; x=1794235525; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RtpfWAmnma/O56VebWKuPkP+Fe0qQ6lcE8KIcTnnW1s=;
 b=f8c9T6TsJjeTMs0aSdRXQiqn9GtDnqjeHjYY1xs2+OfaGfp7coi66GDSqFeNP+4Mps
 mXLoPOiGaHx0oTK+qzIBt6YUUjZRQHv2Rl9jatiN2KsZrZvX5GkqdKremctVSFhCYkun
 K0wWM97SXDHNbgmiT8I2FAmk8jd+arsf6alPNR0V3YoeLQxLejTmW0iM++DNidny3Paw
 X4dgr+EbP5NMIPQ0l872aoC5YD55AjlRCdkhvdt0Vl59gxMN2jxLJlEHivNG8bFLiOzc
 1Ns/jfebbuRbl6TdZEg9ZVqozMbLT+912dlVaajyR+GhXue4+mpeul6zouUqQC/5Bscf
 48dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630725; x=1794235525;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RtpfWAmnma/O56VebWKuPkP+Fe0qQ6lcE8KIcTnnW1s=;
 b=WprLG3KlAQCKZm8oVtn+KqbR0m6XBc7iS+2BruD264TlmI4s/Nf58LzeepgMX+r+TS
 +YgZg4Hj9IllXgZUmyUg2OQAITeOMc5Bw6oleSmI60OFK87Q/5l/fM+Mo2s+4C/fMf7W
 jcMRQTsMjpEPCtRguH8RJlAHKxWNSXXOJjjAauK/nt+ZjDv69wUKmljrLJAXJazsKI5Z
 Lktn0E29GOks5IQfSTzvQjS8ANjE2NJIzCoPxWEWQAm71lELVlBab3sLXFapixhnGr6M
 9Qf1wb9I1DBJvHVeRci9I36rfjfbWuPgDa7tgbx8xfIfnhhfcU1kSqMCbkwOOGFIMjmw
 vqpQ==
X-Gm-Message-State: AFq9FYLK3JwzDes3uvbsytwOZr5yAKSqOMuUCs8rcynI7JgF+hyCbOYh
 YRYNCstUDu+aBVn7dCWqP+yT9DIYc9T2VyJub7US9WDZFb8IUc8/i6fMv7Dnd7gICIBUM9xL/g8
 I643gVex3DYx2kvW738ZOp/OIFmE//iLb0L8KxW3U4kFvj/T56amtoW+f8XNR87uvukMPnN7KXa
 5V2YVE/Q==
X-Gm-Gg: AYBFou3kHEqshYR++2MS0/bSvdtSBl2RykGsd1pyGdSoDt8Ffnu5cANSRTyG0Dyrrbw
 s1ypfdRGQx9KN4qbo/oGVdaJFsGuRT2Dj1zg11rcg19AwmwJ9e5YTp3hrltTL4c2rAc8Qozc8OU
 7eooRWWfS5gsJFIzVlBcp2kgHxlK8ER44e9unOhD9TWi9dAULHLXhGRuSvEEQNN81V+8RadKvFd
 HaCRUJySdHT8rzLQsL+3wRbsOZ+FghqTSceYdp/l6VCar7OZJxBHdASbF7o4Ik1q6ldHYk5yycP
 xeE3S4nNT6RIjrU2LlRxAJE/QocuUi0+/pxvInJ0KkVfXABu9HNKjfd6K4z/CXLxnmfDtM5v9VK
 5ucLYEwJyWJm9ax/dX/Ri4BWZqiouvElH/F5rX7qRRgeePphqupk1WkfQ7G8sC9XBbw7iUKhxkp
 pBfSoyyaPkF74gTDVivXB2K2zeSpA1mXlFjf7xszwsejh1QbR3O7haUjV0szn4RBZ1OWhgDwD4k
 iQbakl/AbNfSYbdbFV7mV+6jrRaaC5s4uVMCIkkZMyYifvhvd1lV0vjWSWOhFbdbhVgfyIymeBD
 Qgdodu+Y5RmCC9seDFI9ybK5PmvvzmNunSeyKEVR6B3bv3Sjv43Rd9PHwAYfDiIZQxJOm59OkdN
 yh/N8VXt7hXeQbQRyrPa3bbQqVkrPTX8ne4iDPgTXv7/e+t+lwQYkDIFhJB5lwyOBoKFrnjivVW
 QLhhOMgaV6FCWVrA==
X-Received: by 2002:a05:600c:5306:b0:4a2:14af:1ead with SMTP id
 5b1f17b1804b1-4ac183d2093mr241054695e9.25.1793630725199; 
 Mon, 02 Nov 2026 06:45:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm322327935e9.12.2026.11.02.06.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:45:24 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:45:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
X-Gerrit-Change-Number: 2086
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2086?usp=email>
X-Gerrit-Commit: dffd045eee875bb8db1cd04bb7ed95b498a3f427
In-Reply-To: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
References: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MzM2MDAwLkk3M2NlYmNiNzY0OWU3YzJiZmRkMjlmZWU5NTViMTkyZjE0M2E1YWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d7f76c418627afb77d75e99c13622e9197578f1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNtHv-0000000028a-49ym
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0976048923064421527=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0976048923064421527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0mpYynStmUc="; charset=UTF-8

--0mpYynStmUc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, Gert Doering, 

I'd like you to reexamine a change=2E=
 Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Dem=
ail

to look at the new patch set (#2)=2E

The change is no longer submitta=
ble: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: route:=
 print net_gateway info instead of unset rgi/rgi6
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: print net_gateway info instead=
 of unset rgi/rgi6

init_route_list() and init_route_ipv6_list() print rgi/=
rgi6 before
they are filled, so ROUTE_GATEWAY/ROUTE6_GATEWAY were never log=
ged=2E
Print ngi/ngi6, which the surrounding block checks and exports=2E

B=
roken since 2777cdd3 ("route: handle default gateway (net_gateway)
and next=
hop towards VPN server separately")=2E

Change-Id: I73cebcb7649e7c2bfdd29fe=
e955b192f143a5ab9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
--=
-
M src/openvpn/route=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/2086=
/2

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 0bce96=
6=2E=2E7a475a6 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=
=2Ec
@@ -619,7 +619,7 @@
     {
         setenv_route_addr(es, "net_gateway=
", rl->ngi=2Egateway=2Eaddr, -1);
 #ifndef ENABLE_SMALL
-        print_defa=
ult_gateway(D_ROUTE, &rl->rgi, NULL);
+        print_default_gateway(D_ROUT=
E, &rl->ngi, NULL);
 #endif
     }
     else
@@ -770,7 +770,7 @@
     {
   =
      setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6=2Egateway=
=2Eaddr_ipv6, 0, &gc));
 #ifndef ENABLE_SMALL
-        print_default_gatewa=
y(D_ROUTE, NULL, &rl6->rgi6);
+        print_default_gateway(D_ROUTE, NULL,=
 &rl6->ngi6);
 #endif
     }
     else

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
Gerrit-=
Change-Number: 2086
Gerrit-PatchSet: 2
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

--0mpYynStmUc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83=
zvan Cojocaru <strong>uploaded patch set #2</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail">V=
iew Change</a></p><p>The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">route: print net_gateway info=
 instead of unset rgi/rgi6<br><br>init_route_list() and init_route_ipv6_lis=
t() print rgi/rgi6 before<br>they are filled, so ROUTE_GATEWAY/ROUTE6_GATEW=
AY were never logged=2E<br>Print ngi/ngi6, which the surrounding block chec=
ks and exports=2E<br><br>Broken since 2777cdd3 (&quot;route: handle default=
 gateway (net_gateway)<br>and nexthop towards VPN server separately&quot;)=
=2E<br><br>Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvp=
n/route=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/86/2086/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/rou=
te=2Ec</span><br><span>index 0bce966=2E=2E7a475a6 100644</span><br><span>--=
- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span=
><br><span>@@ -619,7 +619,7 @@</span><br><span>     {</span><br><span>     =
    setenv_route_addr(es, &quot;net_gateway&quot;, rl-&gt;ngi=2Egateway=2Ea=
ddr, -1);</span><br><span> #ifndef ENABLE_SMALL</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        print_default_gateway(D_ROUTE, &amp;rl-&g=
t;rgi, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  print_default_gateway(D_ROUTE, &amp;rl-&gt;ngi, NULL);</span><br><span> #=
endif</span><br><span>     }</span><br><span>     else</span><br><span>@@ -=
770,7 +770,7 @@</span><br><span>     {</span><br><span>         setenv_str(=
es, &quot;net_gateway_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6=2Egateway=2Ea=
ddr_ipv6, 0, &amp;gc));</span><br><span> #ifndef ENABLE_SMALL</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        print_default_gateway(D_ROU=
TE, NULL, &amp;rl6-&gt;rgi6);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        print_default_gateway(D_ROUTE, NULL, &amp;rl6-&gt;ngi6);<=
/span><br><span> #endif</span><br><span>     }</span><br><span>     else</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2086?usp=3Demail">change 2086</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2086?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f1=
43a5ab9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2086 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=

</body></html>
--0mpYynStmUc=--


--===============0976048923064421527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0976048923064421527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0976048923064421527==--

