Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B35606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MlWqcXlX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I08eti9D;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hqOBV2bf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FAIvkBlb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FoCyUu3VgSOhPdOsBb38cRh40BOussNk1XRicl0V4sA=; b=MlWqcXlXfeFjDb5UTw7qze9IqU
	WkPTaL0s38CesPm32ISzZZ+yk9APLWtLqjMdFE87lshPv0GgN+KQqybmkOStmdLkZLEG5V1+lkHIb
	6iRkExLsT3qEuWMPZDqip9nQ4lf09XaLPjmXJWKrI4BX9G6XJ6foIfhUrn8axIZr9E+4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX2UB-000000006mk-0da3;
	Fri, 27 Nov 2026 20:23:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX2U9-000000006mY-0JKQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DYDIBWNf5WHVYPE7aRue62jqN+T8AnvcOMw7jjL1BMU=; b=I08eti9DlAjVtoYyk9TQAuWwkN
 WjV7k13r+8Ai6sDCdLt3ToPUTVD84FXfUTjBAnFwBtBtlv3oq86aWyCiaMa+V8IXDJ5PTMuBRn1H0
 WP/2JLPkflqVP6wSgWAt08KV2WmnMXpsHNNjvxW1rn/5h3EarlrOZGrY1PJMoUIwnFPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DYDIBWNf5WHVYPE7aRue62jqN+T8AnvcOMw7jjL1BMU=; b=hqOBV2bfGXr7dtMEj6SO01RJit
 Yy8e6feK8634PFaOBeobwqWqB6mwMOLeoq6hf9ZKH/imZVUfgu6ng97tGq9g0krAup90RIU3QQq7l
 EIH0sMfgJSHGe7bBZnfXxFs/JLB+hs3oL3yeaO4Syw5CxSMFpMVqFEWEbddWqsCpUiwU=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX2U7-0000000028I-2dRH for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:23:56 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4acb44dcd7bso7602987f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795811029; x=1796415829; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DYDIBWNf5WHVYPE7aRue62jqN+T8AnvcOMw7jjL1BMU=;
 b=FAIvkBlbTBy50zUEJyqUCQ7KEVOa9ncgMXDwmXBb/vc61rCyxvs9xbm7EY+zCGWPnu
 vlaLZpa+7ZFJpZQ+oJjZ12AcRVWNNp8bHIY+JO+TABiVsZCWm32EsjoM6pVVU1GXVsTM
 9EJ0i6Btxr2IIfqkSOw8m067zJgx5G00+cvPdw8PpFIfvR8QZIZ5oc1gzOUQbvY+XOPn
 aVQEu6prHddkSpE/GUohTWIzi7EuGxe2msArjPWx7NThR3fdNKZR9SOQ0hMO2FSo8XjG
 fQIWbD6TO/FJR6SXHfLPeMYd5wCKsBsQPRR1ad3KRLNNg0rYAMEpJexRlGUod373uMIG
 w8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811029; x=1796415829;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DYDIBWNf5WHVYPE7aRue62jqN+T8AnvcOMw7jjL1BMU=;
 b=oRrwcc4iyzCppGfHJddnGizfoME3AnuAQE4rwPJaIXrtNLCewKvk5mjXrgmvNH0zlZ
 JFNGMUflGAOBQ/lVVG35JyzbECpsul7K754xNIq1a5IcvVe9Q0SBr2E3+HA6mYPlYgGr
 n8WE0XubutDkZHHGFUmNWaf8hCw/z6Zd9xaQfATgF1GUYGPCb2MfyTDhIbMnbP9GTzoB
 tKiPy8kyi4hufZTFfHdSpCDGKCYHrVH0C5PiQG2aegRCCMIixefim8c4INT0h4hobxcH
 c7xVWpEIP6ANINnvW+dMM85PO7sDCliZQHJVBJ3NnRWWqAmuYQtX/5R9uwOTpym9GihY
 f6XA==
X-Gm-Message-State: APuU4Z9l6stm3l9o5tgiQ3/qnYBHpBlaPRzIgtCnjUDldzQc9B7Oi/AN
 Q6VUyzPIC9j50yjGx2nQP3/lMTPr8MhpeWBAJkznzojZLUzEp1RSh0qcNd/7gwYAwwVEqGePP8Y
 gAU0tBPnu+u8YlE863GwwvQYWXmgYCM+GaRvQJkNlauBpzJKhgO7MqP0BPA6KUfAmCmFh
X-Gm-Gg: AZFdTZf17DSFDxQjLej3x0Ba3wcfHE/FkhkBzCxJuHXGF9NlLYSg3IOWuyZUKXmi6Xp
 G1CI+OBkZqUvD4SguezD5I1Y5Bw8TR4sy8x1IDGfqDyguUmOLDERZvDR6Btk/Qd9ipHU6J0gq2j
 L4hbNyn5DD69SQ+lTbPv6T+9UW7OUF07ydeRuPho1Du2puQF7SLFINPcoJ8tKWURi/ru1Er5LPa
 GctsGjxccta1rriscw7O1lD6CwWbCDCkaIob3cQ89CeaMO6yBmIb6eBDHXrRgdqLL+ao9vwr0h6
 tyghlOyQllefBsftLrwHB9ZUtlVycnrWEhPJ7r0KzkQekkhvAyalZqvmcpMo2w5+MYQ4N8nCUs8
 KcSJwrZ5vHWtznkhGFCILiLgwMUGP3II9GxtZs55PlbfVWcKaTPZzDjQtrQgJLxjbp1LwVk5cW2
 RpeLgH0WPK6ySUWIa5z8nGykSh1itWZxkZ55dn0sWus8Ttn3MntfNhiNTtOQ7ND4zPoqLnU2Iwq
 ScYym7pvql7ueJ7HFXwcr4KD9rN+wuI3Qb9xMjELfQVmUvXw0kPxZy2KzJYBEjM1LyeZo6ndhru
 Q3vyTriw3CB51E3FB7AIGuTd/52HBsDzkbwOMtJ9Hsq6PRFVEIXdgxuWW+OjJbQYCnluqBc6PL3
 3VWXyFgqwCVz0WVZq1qchhUGfuotmDgvFCMcrvWkupuAOJ1kEJ75eRK6DwHnobM+QzGnn7WY52h
 +T3GUGb2XZyiHbyI5r
X-Received: by 2002:a05:6000:4607:b0:48e:69ff:ba36 with SMTP id
 ffacd0b85a97d-4abb2fc3fcbmr46992208f8f.28.1795811028654; 
 Fri, 27 Nov 2026 12:23:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c4353d6sm47262456f8f.56.2026.11.27.12.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:23:48 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 20:23:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7
X-Gerrit-Change-Number: 2181
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2181?usp=email>
X-Gerrit-Commit: 537906c2ff7caa7ba20483dc4a59adfb5f9ab27c
In-Reply-To: <gerrit.1794489937000.Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7@gerrit.openvpn.net>
References: <gerrit.1794489937000.Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg5OTM3MDAwLklhZTY1NjkzZjQ5ZjQzYTY2YmY2ZjU4YmJlZmE3YzMzNjE4ZWJjNGE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c91ca3d53b13c1fd8a86d35aa00f59b868a0afc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX2U7-0000000028I-2dRH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: resolve: store the
 address family in --preresolve cache entries
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0042909794456175036=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0042909794456175036==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AifBFfp5F78="; charset=UTF-8

--AifBFfp5F78=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2181?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: resolve: store the addres=
s family in --preresolve cache entries
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

resolve: store the address family in --preresolve=
 cache entries

get_cached_dns_entry() matches on ai_family, which do_prere=
solve_host()
never set=2E Any lookup with an explicit family missed the cac=
he, so each
restart resolved again and appended duplicate cache entries=2E
=

Configs with an explicit address family now reuse the preresolved
addresse=
s across reconnects, as documented, instead of resolving again
each time=2E=


Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7
Signed-off-by: Razva=
n Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181
Message=
-Id: <20261126115908=2E7374-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42012=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/reso=
lve=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/2181/3

diff --git a/sr=
c/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec
index 544e5ea=2E=2E77918e3 =
100644
--- a/src/openvpn/resolve=2Ec
+++ b/src/openvpn/resolve=2Ec
@@ -548,=
6 +548,7 @@
         ph->ai =3D ai;
         ph->hostname =3D hostname;
   =
      ph->servname =3D servname;
+        ph->ai_family =3D af;
         ph=
->flags =3D flags & GETADDR_CACHE_MASK;
 
         if (!c->c1=2Edns_cache)
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae65693f49f43a=
66bf6f58bbefa7c33618ebc4a7
Gerrit-Change-Number: 2181
Gerrit-PatchSet: 3
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--AifBFfp5F78=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2181?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">res=
olve: store the address family in --preresolve cache entries<br><br>get_cac=
hed_dns_entry() matches on ai_family, which do_preresolve_host()<br>never s=
et=2E Any lookup with an explicit family missed the cache, so each<br>resta=
rt resolved again and appended duplicate cache entries=2E<br><br>Configs wi=
th an explicit address family now reuse the preresolved<br>addresses across=
 reconnects, as documented, instead of resolving again<br>each time=2E<br><=
br>Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7<br>Signed-off-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;=
lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2181<br>Message-Id: &lt;20261126115908=2E7374-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg42012=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/resolve=2Ec<br>1 file changed, =
1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/2181/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec</span><br><span>ind=
ex 544e5ea=2E=2E77918e3 100644</span><br><span>--- a/src/openvpn/resolve=2E=
c</span><br><span>+++ b/src/openvpn/resolve=2Ec</span><br><span>@@ -548,6 +=
548,7 @@</span><br><span>         ph-&gt;ai =3D ai;</span><br><span>       =
  ph-&gt;hostname =3D hostname;</span><br><span>         ph-&gt;servname =
=3D servname;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ph-&gt;ai_family =3D af;</span><br><span>         ph-&gt;flags =3D flags =
&amp; GETADDR_CACHE_MASK;</span><br><span> </span><br><span>         if (!c=
-&gt;c1=2Edns_cache)</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3Demail">change 2181</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae65693f49=
f43a66bf6f58bbefa7c33618ebc4a7 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2181 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--AifBFfp5F78=--


--===============0042909794456175036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0042909794456175036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0042909794456175036==--

