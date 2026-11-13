Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD7606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TVjQ1V+v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y8k8ycFF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ROdDB5Ff;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cyqZkLh8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4Hd+s4P1NQ5epIzPZncOEEOQ9o5xaDSYZ2gRpJUSS44=; b=TVjQ1V+v2LG9QeW9jn0fj5fD2Y
	tHoUlGnZH731V7azq0aqwgJ3xkbTLIsmU5M/wHWYMUeR6ALIYnBi4eh7rlsNZOh1+C/WarOWT9VmP
	AzNnmZMVJ0QKXmUbA2t6Ue6fBPKUt7VOiNR9BFuDW+hGgzT28Wr3JaZ2n//GIsC0hNYI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRui8-0000000020n-20LY;
	Fri, 13 Nov 2026 17:05:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRui6-0000000020Y-3SCJ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TTn6A5HBuPpXwB2w6tHiEY7Q06kL0Wuayrfd+FGKCfQ=; b=Y8k8ycFFi1Z/rFaefflYyle8+E
 sBrhw2o6J/At06jxrbB8rU88ed1ENBQuiQPmw9riitaFITBTb//YVdSXjffgdfH6A5EGIMRD5lGCv
 DtRcnO9Iqj+gWKDnC8BFSV7R99rHUfyAMsiEFqqRpf78UmNrvwOWBYr0uHTGyH6FetiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TTn6A5HBuPpXwB2w6tHiEY7Q06kL0Wuayrfd+FGKCfQ=; b=ROdDB5FfnKrBoNiQG1iBSC9QbH
 HOfTlJ97d6xK8i+6uhuTgNs+2KxlxC+vGzkqh7dLqtRsD88Ma0Y8ituZlaaMUSfM3RuGz6g218gt/
 o+J6yo7p+Wbk4SAhAF1p9J2VVj01P4tLvwDvIG6Ggq1XRKSI0dcBFSJgVlvfK/wf46Uk=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRui5-000000007SS-0FdY for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:05:10 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so534433f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794589502; x=1795194302; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TTn6A5HBuPpXwB2w6tHiEY7Q06kL0Wuayrfd+FGKCfQ=;
 b=cyqZkLh8AXLfJKVTQU6b7YRneDD50YxIyt4WLh+tXTx5IqngSLCYyy0Z+bT0g2uXyY
 i/HcFr4Pph0oQTuO575g1DNcYWs9KS6gOoUnAbVX6IwKeRMvgROUd1VQx7VD9cwCHMr1
 pvfeLE5jbwy63joedC30Td67h+jIijjiIexCJ+kE/90p522WWWFplqV76DG2nOyrDuqK
 F6lEZQgU1/sXWeLtGWv/R2rJsy8Ck2t/2eqE265i1opToGfR9wpEns5dNMWSOEPJUC97
 pQVAw+G3KkWJMKQNDsS+nF0kJxYd4qvMWplsi9qDNfwUt7yKaZYRKwGGT9xDTse4PtYl
 j48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589502; x=1795194302;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TTn6A5HBuPpXwB2w6tHiEY7Q06kL0Wuayrfd+FGKCfQ=;
 b=Xj8IB2TK9K7+AGtKotW51WTf1K9uBlZTQ01oi3ZOYvsq334jn4BiECB0xsjRQghMff
 U31VE9bCaSXQUlOSCEDVkyM6TnbQOHUb6WTCrFRoqe++M21WkpOFmS8kMRtN4ju55SKP
 hkN0YIr/u7eB0BO73Ay2EjG4bfDIrOLeHuX8zndXgTaGKneD6WFTwWyBoyPZa1qlmAHb
 YqXpSlqo7Br2bjDULbWGo7Bp90RdxEQClZxsLIPbW2eaNKfFMp3B2Sd2Jwl9EaFqONfU
 EiWJlNMi8XLgBDKMIPdaTa3il0LMfEZbgpqpquRNEDNptI7qUL7Wgy/Mt5u14xNbpE5b
 wOzA==
X-Gm-Message-State: APuU4Z/uygiQLHx3DjFeyJJJxwhO9+irlUd7wzsc0L4ya4lpg1xHdEhj
 x+uD9BbRDcsUY/7S2fYGSfre4qyIEyDMS47+KBYEXyOwt6fhBO6A0LjPiHRRvT4LZb28HLt73uy
 9mBBD4G9gPC/Ir+s7Dz6GxK3bWsqDRPfF0bVUQ1JaGW3m37XB4CxJ9SsdGmyQYyrr1XP5
X-Gm-Gg: AYBFou1crJ5WdbwLtlDJ4Fdg1DTis500fSZuJpVlsTUDkyLUHSYTe+PjNJOShXkHdNf
 y+LRuBsBIW2pmWU2b1Q8l0zEiyKNvpHlv8YKh9Vc2E3cKZnEG+WMHegPoxcGw6/Vkdo25E5oTjr
 SEwYYB+FNUnGMLvZwDDgH8g6rEWwGkhO6H7xD/V3+0yJI0v49MaaJBkYoO8hCHkUomY/1SwZTGs
 IAMb/GHg+SVYiIvo9FyygF/ssyMUxsWthPxyKnh+sIfExl7l9OTbvhwGnU0oWk3lyA+mGKgBIPJ
 h5TTWp67xVhyiA2IdPUVwN1nqOH9UTgqklMxXiPZXAfNCjVdbPvKJuEFjp7Nd03zrEAWSPU3Kb5
 fr2BAdfyQwni9NhPowWT7297X9xcFRGHcxutORudD3KL7kaBR8XWpxiioKZqrtbbKIpWvVcWanA
 fmlRpeDJmym1q6Ytfn8Xjr0QECa2zx7qAPtmDu9LSCx1cIgqf9lYLsqf/9ERwrkHIHpaAhpT1Bm
 KkZDmn8OziOyGyGL9L7+dXWBISW50+zXpgWGmmABrZF9en/R0AujmDSKjoiJ2jU6MtWBuHs1NQF
 qJxhE3B7681m9N3eQyd2hSeOUAM+VNc0bpryngs7/dzwXeZwsgJ53h9kI0zHSwyLxxOi88id+7d
 kR0d9GCMr7/0/41cnZDBNvYAN+9PvO/WaslzsK27lbM+aX3mjP9QmAHrVnIW3BTOojprl2i3Hj/
 +jW30Rt0z9vlG6xgM=
X-Received: by 2002:adf:e19e:0:b0:493:2eb8:e7fc with SMTP id
 ffacd0b85a97d-49c72ab0d22mr6772108f8f.42.1794589502183; 
 Fri, 13 Nov 2026 09:05:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm5651087f8f.27.2026.11.13.09.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:05:01 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 17:05:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
X-Gerrit-Change-Number: 2160
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2160?usp=email>
X-Gerrit-Commit: 26bb86bb2ccbc6280c159db19597e02e19e684fb
In-Reply-To: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
References: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwOTk2MDAwLklkZjM3OGJiNWFmMGIyYjRlOGQ3NDZlMjUyMTU5Yjc1NmU5NmMzN2ZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3315489d81f55f301fc594d905baeebc3731f1a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRui5-000000007SS-0FdY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: always
 free the domains in UndoDnsSearchDomains()
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3779821214384862028=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3779821214384862028==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7yb9WKcKI44="; charset=UTF-8

--7yb9WKcKI44=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2160?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by Heiko Hund


Change =
subject: openvpnserv: always free the domains in UndoDnsSearchDomains()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: alw=
ays free the domains in UndoDnsSearchDomains()

The domains string was only=
 freed when the search list key could be
opened=2E Free it unconditionally,=
 as the caller frees the undo data
right after=2E

Broken since ae90cbad ("=
dns: support multiple domains without DHCP")=2E

Change-Id: Idf378bb5af0b2b=
4e8d746e252159b756e96c37fb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Hei=
ko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2160
Message-Id: <20261112063912=2E24551-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41182=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 3 insert=
ions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/60/2160/2

diff --git a/src/openvpnserv/interactive=2Ec b=
/src/openvpnserv/interactive=2Ec
index 5d2abeb=2E=2Eda86e85 100644
--- a/sr=
c/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -175=
4,10 +1754,10 @@
         RemoveDnsSearchDomains(dns_searchlist_key, undo_d=
ata->domains);
         RegCloseKey(dns_searchlist_key);
         ApplyDnsS=
ettings(gpol);
-
-        free(undo_data->domains);
-        undo_data->dom=
ains =3D NULL;
     }
+
+    free(undo_data->domains);
+    undo_data->doma=
ins =3D NULL;
 }
 
 /**

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2160?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
Gerrit-Change-Number: 21=
60
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko=
 Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--7yb9WKcKI44=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2160?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Antonio Quartulli, Code-Review+2 =
by Heiko Hund</p><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">openvpnserv: always free the domains in Undo=
DnsSearchDomains()<br><br>The domains string was only freed when the search=
 list key could be<br>opened=2E Free it unconditionally, as the caller free=
s the undo data<br>right after=2E<br><br>Broken since ae90cbad (&quot;dns: =
support multiple domains without DHCP&quot;)=2E<br><br>Change-Id: Idf378bb5=
af0b2b4e8d746e252159b756e96c37fb<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160<br>Message-Id: =
&lt;20261112063912=2E24551-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41182=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M src/openvpnserv/interactive=2Ec<br>1 file changed, 3 insertions(+), 3 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/60/2160/2</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv=
/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 5d=
2abeb=2E=2Eda86e85 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -1754,10 +1754,10 @@</span><br><span>         RemoveDnsSearchDomains(dns=
_searchlist_key, undo_data-&gt;domains);</span><br><span>         RegCloseK=
ey(dns_searchlist_key);</span><br><span>         ApplyDnsSettings(gpol);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        free(undo_data-&gt;domains);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        undo_data-&gt;domain=
s =3D NULL;</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
free(undo_data-&gt;domains);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    undo_data-&gt;domains =3D NULL;</span><br><span> }</span><br><=
span> </span><br><span> /**</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail">change 2160</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id=
f378bb5af0b2b4e8d746e252159b756e96c37fb </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2160 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko Hun=
d &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--7yb9WKcKI44=--


--===============3779821214384862028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3779821214384862028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3779821214384862028==--

