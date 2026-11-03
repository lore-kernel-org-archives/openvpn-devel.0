Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA587606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=adkMq67T;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DRxRCTu8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eeSfWLX6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TKtEzKgi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZHsfobMwguxlQ+iczY7ghFs+PkEc8fZ+1ZboPdtwtaw=; b=adkMq67TKsHKOysKsXW20gpaiG
	5gK2Ot2PKreJPUkHYjm5Sa+aGoVTh17lL6iY1SK3FyJXzNYHX4mYnOcTdC3ZC3mFAf8XEytq9d2jB
	zL78pCYouJUnA267gWUHAUI+uqJvMDhVHPFCpZIoAy11KxKjUJNWi0Q+DTzof6ISpQ/M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHw8-000000001P1-1o1m;
	Tue, 03 Nov 2026 17:04:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHw7-000000001Ou-0UXI
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:04:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qB+9oXt2AorlxdiTxIvpbp+5WAhGx62EuIhAiDpv2FY=; b=DRxRCTu8CzFwTtDRcmhVaa+Bmu
 qXiZ/IwFAMSEvix7ZRN8Pqp88sfaZT1shFRwM0xG5LKg3UaANu7FrPX0UO4ZIdJ56r0eRJAbWxJwF
 xIi533LlxwWU3E3cG3xD4rdHvzf0uG/2Z7xsPBMEuwt6YD325ceCk88d9RAwt0+fd4kM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qB+9oXt2AorlxdiTxIvpbp+5WAhGx62EuIhAiDpv2FY=; b=eeSfWLX6ljWhuPZwA+m40+vwNv
 q0D0q6UWnu8oYhpQSD+nCbyzM9BIeijjp7J02L+ClOAE1jgur3oF9pGNOC+e1fQmK0GPWVJdXM0NQ
 nY++OuT3Cp82BFcwcC8ZbpvdNfaiIMhjjrs3LYjeAx/tIdU3yiWhSparf3MUF3aa15hM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHw5-000000000fQ-0cpl for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:04:39 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so34047765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793725470; x=1794330270; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qB+9oXt2AorlxdiTxIvpbp+5WAhGx62EuIhAiDpv2FY=;
 b=TKtEzKgiipqiwVvtif/o6tAPGJuGQfbB6dgepwoCHiiocYz7crU/iJXkdr4B4vKoJJ
 lm0v7Mu3+GZv959NAUxDuGUwyp6TWPj6NL1v3NuZPI0nZz/EiMJLErspUEkjqMJkSy8b
 oNaoS9zr70Ot6HMZlItjI4ZCXfJ8CZD8UbYEpjAzlXHLHEYYLrK8TQHT43nv5qi/9qWF
 KgX6X16LudaqzzV3JaOA4yeqq4FRpOzyYmD0hVs5C9xuHe1x5GGBH564UoUztJU/V4J1
 d29zEBtnno36D5lc0qhmanbp/GIuyZRKRGKriCB+Tp3qCheeMl3PAu/y1uLBNDDZW3zE
 v9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793725470; x=1794330270;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qB+9oXt2AorlxdiTxIvpbp+5WAhGx62EuIhAiDpv2FY=;
 b=L8qe1VnWDWkc2soWgQ9D8OSQHf69bxrv8PRTPnBIje70H1kCVRctXXwgYvHUA4Y3gC
 CdE5DwQcG97N5W8Bl0oOH/HC/WeHPQFG0SOn23u3RdNQYb6FjBAQGNEqG09qzJAhjN6V
 k0HUOaQhiiLljqGdfjWlomymAnb4m541OJvB7PaTrGo5Q6qhbp4ZFaKcOuLTAfWXsqog
 15AzR6dX0WgXF3ak7kt3vuclBz9K4kFKwH7uT0/OuLC9mYat5xUQI+BDLirp8TGSha6S
 ZAMjXm4NlBh+DTYfSOx4oTJpxcygv63qdfRo0zYN0EM5T3zOpWGQoQHMvWJH39a2yl0U
 sDbA==
X-Gm-Message-State: APuU4Z/inBuD4JwIRIJf+6TwLRabQhMbhZD0JK5FG6UMSSqj3R8YJ6K8
 Z+suBScRO8yDbyHv4SNazvStRbi4tLUPyyctFuCxmBnVSjzEd3Evq7yzk4qp2iIt5ofsP2TxLEo
 swNJp5/E9DVKiGXjGp2rYP8++sRgmoVodbTfQMAJ8E/94BXafE0n8leRhQ8wV0DzzpOqmFPWKET
 Ubs7j/mQ==
X-Gm-Gg: AYBFou2K/HMNlMB49k9CKrtHigf1YecAwYWvx6eF40QcBJeIIKGqqmFJcneGfJyNgR0
 t4XnB7G7J6XtBl0GC+PxM/GpK/jTJTGODpTjXYE+wHs4XzRnVdktnmEcg91Lgkv3OK1jY3BnHgQ
 fwX4qNM6nLD0zp9trkNDkX9c0+2DRU1bGcJlQFv+TWK8BSm4/kdT8yGtsILbnVaAr2KgkkMg7qX
 WWyLHfd0ATopc3JIGgS4KS58BBfo6JFbzH7vklNCrB/MP1jGKEsZCXVfcb9EdMxVYRsNinrYu4y
 rtwWz8+eJWRCja/GwOHPAii4Ck/b8Xr7STZgTRd4kbgyCJRqZi0kCfFS5TIJVJX3ZLZuJ4Mduab
 3ZvV+av4bJCSCoXzixOclybAFEvWf+EPizkkFFR/dXxEroPNC6QQ9btEJL8GDeacq34Q3EmEORf
 HuLDdjLlRuW9FR8rV5qvKFL1brvXQot3UIAF2ruwD9SLIfpBjvIpymU/PjD57hwZIvVIB/gOm20
 ZTEjA8hVBtfTuL9ZrRkoTWiMVuuxM5YCHixPxfHPBg4valBldW5nzD7t0YdH+Z72QoUMvmxiCek
 tPbHd32gxKPlSvr7uI1gpNlmSqDhCF/4IGYI2RkA1t4dCfgV7WCbD4pabCbeY0QJzElzf1T/JqW
 A8RWq0St/RPqLYI6nVp+Ni/ARC8tD/ayciqmU6TOspMwCpaTwgVPajiK4lqDQHCryFh8J6YewGC
 +cyj5KE9laY8plfA==
X-Received: by 2002:a05:600c:6095:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4ac182dc30fmr277268875e9.22.1793725470160; 
 Tue, 03 Nov 2026 09:04:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b72715sm25290984f8f.18.2026.11.03.09.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:04:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 17:04:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
X-Gerrit-Change-Number: 2086
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2086?usp=email>
X-Gerrit-Commit: 791eb227d912a77713245f33854bcfe84a2dcc9b
In-Reply-To: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
References: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MzM2MDAwLkk3M2NlYmNiNzY0OWU3YzJiZmRkMjlmZWU5NTViMTkyZjE0M2E1YWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42e70446ced95f8a8d1ac765042db231c4bfb8d2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHw5-000000000fQ-0cpl
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7929769924473964981=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7929769924473964981==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dyah+HUOzCY="; charset=UTF-8

--dyah+HUOzCY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2086?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: route: print net_gateway =
info instead of unset rgi/rgi6
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

route: print net_gateway info instead of unset rgi/rgi6=


init_route_list() and init_route_ipv6_list() print rgi/rgi6 before
they a=
re filled, so ROUTE_GATEWAY/ROUTE6_GATEWAY were never logged=2E
Print ngi/n=
gi6, which the surrounding block checks and exports=2E

Broken since 2777cd=
d3 ("route: handle default gateway (net_gateway)
and nexthop towards VPN se=
rver separately")=2E

Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
=
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2086
Message-Id: <20261102142000=2E30467-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg40495=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/route=2Ec
1 file changed, 2 insertions(+), 2 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/=
2086/3

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 15=
2d0d2=2E=2E53550c4 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -619,7 +619,7 @@
     {
         setenv_route_addr(es, "net_gatew=
ay", rl->ngi=2Egateway=2Eaddr, -1);
 #ifndef ENABLE_SMALL
-        print_de=
fault_gateway(D_ROUTE, &rl->rgi, NULL);
+        print_default_gateway(D_RO=
UTE, &rl->ngi, NULL);
 #endif
     }
     else
@@ -770,7 +770,7 @@
     {
 =
        setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6=2Egatew=
ay=2Eaddr_ipv6, 0, &gc));
 #ifndef ENABLE_SMALL
-        print_default_gate=
way(D_ROUTE, NULL, &rl6->rgi6);
+        print_default_gateway(D_ROUTE, NUL=
L, &rl6->ngi6);
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
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--dyah+HUOzCY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2086?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">rou=
te: print net_gateway info instead of unset rgi/rgi6<br><br>init_route_list=
() and init_route_ipv6_list() print rgi/rgi6 before<br>they are filled, so =
ROUTE_GATEWAY/ROUTE6_GATEWAY were never logged=2E<br>Print ngi/ngi6, which =
the surrounding block checks and exports=2E<br><br>Broken since 2777cdd3 (&=
quot;route: handle default gateway (net_gateway)<br>and nexthop towards VPN=
 server separately&quot;)=2E<br><br>Change-Id: I73cebcb7649e7c2bfdd29fee955=
b192f143a5ab9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086<br>Message-Id: &lt;2026110=
2142000=2E30467-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40495=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/ope=
nvpn/route=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/86/2086/3</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/=
route=2Ec</span><br><span>index 152d0d2=2E=2E53550c4 100644</span><br><span=
>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</s=
pan><br><span>@@ -619,7 +619,7 @@</span><br><span>     {</span><br><span>  =
       setenv_route_addr(es, &quot;net_gateway&quot;, rl-&gt;ngi=2Egateway=
=2Eaddr, -1);</span><br><span> #ifndef ENABLE_SMALL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        print_default_gateway(D_ROUTE, &amp=
;rl-&gt;rgi, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        print_default_gateway(D_ROUTE, &amp;rl-&gt;ngi, NULL);</span><br><s=
pan> #endif</span><br><span>     }</span><br><span>     else</span><br><spa=
n>@@ -770,7 +770,7 @@</span><br><span>     {</span><br><span>         seten=
v_str(es, &quot;net_gateway_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6=2Egatew=
ay=2Eaddr_ipv6, 0, &amp;gc));</span><br><span> #ifndef ENABLE_SMALL</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        print_default_gateway=
(D_ROUTE, NULL, &amp;rl6-&gt;rgi6);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        print_default_gateway(D_ROUTE, NULL, &amp;rl6-&gt;n=
gi6);</span><br><span> #endif</span><br><span>     }</span><br><span>     e=
lse</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2086?usp=3Demail">change 2086</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee=
955b192f143a5ab9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2086 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--dyah+HUOzCY=--


--===============7929769924473964981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7929769924473964981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7929769924473964981==--

