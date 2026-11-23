Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BF606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LByJHzO5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VX/v5hk/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XornGnQc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Tl5dt0Gg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xJQrGkOIjvdWEtw1NQfEcuVnVkdbLg6PXOOR4f4NPt8=; b=LByJHzO5N2UNJQlN344MAaTX4S
	mEzWAMEwRR4kAXB7q4+LJLgenqDK/Oyi0jG1doFiU7MEsBFZjtsxuFw6j2ZHIl0L5SRSLXl1MRKvO
	xj2p9GvXVQFPyQX2wj0x4LHuZUmVPKbtWxni+Mt22xhuDJkk6f/JpLxxAjLcQKKdW1ok=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY4t-000000000bj-41rY;
	Mon, 23 Nov 2026 17:43:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVY4s-000000000bb-3s0x
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Pr0XK3RrGY/CMZzpigMuku7uh/Acbj5AHL7fXDcVB8=; b=VX/v5hk/N+ZFumPlFTszDkwCmO
 0hCfbySkLDQDD+GRVATgtkLyKoofBSpbTqJmehubJoaEmekML/CO2eF14cdYoPifuVTQ249OHc90f
 a7HUV+ouzomAmAmxd3Do1XaI9akplA4tBDRt/qATO3Js6IPV2oENmejTVagwfeOYM0hk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Pr0XK3RrGY/CMZzpigMuku7uh/Acbj5AHL7fXDcVB8=; b=XornGnQccMBAVXrumOGKEddg7f
 IjAOcsLq+C4pXFvDGNojKxZWhfpmG2rRPXxZW6Vs/bU8Q5MphneQM9X+DFv6B34Yf8yGS57jdKxu9
 Z5oTYclKLmvuKy3ugw6AcOrDXIjH9jdzZprgofpLAZVYow3YXS2Gc/qi10PYHD03F+gc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVY4r-0000000029B-48Jv for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:42 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so6889265e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795455815; x=1796060615; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2Pr0XK3RrGY/CMZzpigMuku7uh/Acbj5AHL7fXDcVB8=;
 b=Tl5dt0GgE5qI6Migo1Lh13i6VUMiU57//uzrx6LtVcIBACKKtN8Vbvo49t5pq0xaLs
 Ez2ooTjBzSN10bejsiGwlneBQf31Gke31eevECnLvYHwwF/9FEFyv6s5CH8J/nfN9T4b
 10NFkvoc0TZZJQWEof/7a5hsVGpp+iHFzDYKpfu2lk3VLWe+LQUz45JS0BOB1Oc2UJDm
 SHprj7G8JBSsBzHLpAQ8+DGro5rGRumkyn8Kzxvxyhb/uI228UFiGeEA4hODKlcJEBJZ
 Ep/cYJx6hhXkg/PWGny7yAwHitkjhrTqAKhp+X55FKBc8KCJgHHqst9r5s/vRYX6On6s
 UyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455815; x=1796060615;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2Pr0XK3RrGY/CMZzpigMuku7uh/Acbj5AHL7fXDcVB8=;
 b=rRlPl98zd1qcaWnO5yGl4lX+youPQwn7qyPxVkC8KjJVw/yhQuSQHHl2cQE15ryLst
 VaL19B/f0O95Ene+Sdmx6noLZvv/FSKEi6o8uUhvnaS+fOdyzMXufc31RLPAEU31G7VK
 NxdlN+AZfCXuXzz/1blEeJLi79wfPQ0vmYdLp8lnxw+pP6Jkfl3BI9WdypCSh4IAjjsp
 hL8k2Fh4YtSlpv0JWNTCczauWQ5bMyjjOFPXEOgW7fekdOsOreFCy2HXbDSZLGSGpHRI
 O+amw+/r+IAHJr3PP1mVZ1GSfPeM0fbvmd6KeS4OQfMT+po2ErFMiZVffAhnzVpX0VFT
 SeKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFvAtlk1m6kShWck2NdY5s+tatDmDmc9B9ESjbzGoCZM7A17VeQzr4FaAmjyAMvygtNao58VLkVbH3s/HY5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Rb6G0Ob2LJ+5NXbRd7ywoKYRrhS23uiwk58VNBwTUEXe4s2oG
 FLmxfprO+gdNvdVZk2MOZi0hfoKoSq6854kP6O/9Azbrq0DbFhz7ZK18m4MDwrxuSJ0SnDapdCq
 WKZ0fmbIlQin79bfFQgeVV6Q9GZpGN/ZCYTALtxtOcuLzihUMmgDMmaflMOsdpesBaXBEM8yhfc
 dry/GIXA==
X-Gm-Gg: AZFdTZcIMcRhqpmJZlIslAlcDKknizZnKMQF2qlgCCXTVR8h5lfRUfqXrH94l7jXfUi
 xyhMYPcW1C9hApZpiGHt53OJPKlfg1wpGHRwLq+NHhSz4rgEdy4K+AxCoh69U1vRqte9Jx5by2/
 3zk3bJh9rY1Xnsihgh2i/xflKHLP7bPf+XTJF+jovQM1oLXMQ3STPYZC+XELwdwvcixC7Al5rwq
 Cf5a2lC/GyS8ZARyIOcISljDsCfUvA6DBXQT3B/GHzNpnMO3KNGoMuwkcSFPXf9XauDdPcBIQMI
 /IwPSmhQkO09xQ89U/pN/apTJnzRE1MOS1X9Nc+YLRnFTbQXAAj2L3IVIkTl8jSmvx0NPDeOOFS
 cbs8WlkHikmFusULfglDyUTBVsTt26zQHmW5vQ6N+A5SGFkwY7NQ0x7gIduOIMuVJ0w6dLbsi+G
 BVq7NcNEg1Iuzdq/QhdCICs0L0VOmuaJz+gsWZqjj6t2ApJqwpNjRZELqB4K3wVFQEp/bGMUsag
 HVGi3AiTl7/oZ4lximI12dw9bI3I9U1eq7axMcESFiN4yDuf0I7pldD0QsbHNOFxwqwE8ednk/p
 hk9fCouSpsz8sfT1WWlxfAJ6lz0bbGHgX4dy/zsIVcbL4qgLHhdpFA6MHhaFAKOUvpHA2Oe2bdK
 eDpdIYFjNfqOc+a0eKs2xs48Qb47OLtG7Kk5uNzZt+7RiX8ntnIie18bu68JBfRWNg5i+L1/vlr
 tEwDNGtJl3nCoLSN8L1JZSzbvr6Bj2q7hffuQG
X-Received: by 2002:a05:600d:8402:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4bb88806287mr192014035e9.14.1795455815234; 
 Mon, 23 Nov 2026 09:43:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm23188959f8f.38.2026.11.23.09.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:43:34 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:43:34 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2326
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2326?usp=email>
X-Gerrit-Commit: 3256f39106ad04d744f8db6633e42b616891a242
In-Reply-To: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMwMDc0MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c36a13b50f7e2c7bb5c74e0aa9e297bd1ef4fdba-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVY4r-0000000029B-48Jv
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0745648598277504332=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0745648598277504332==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jBE/Cd5K2+w="; charset=UTF-8

--jBE/Cd5K2+w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2326?usp=3Demail )

Change subject: socket: check the address f=
amily in addrlist_match()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

socket: check the address family in addrlist_match()

addrlis=
t_match() cast each remote list entry to the peer's address
family without =
checking ai_family=2E With a dual-stack remote list, an
IPv6 peer compared =
against an IPv4 entry read past the end of its
sockaddr_in, and 0=2E0=2E0=
=2E0 matched any IPv6 entry=2E Skip entries of the
other family, as addrlis=
t_port_match() already does=2E

Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e2=
2b86e274a
(cherry picked from commit 756d140aca1958f71a701b4179e2e59fd3d86e=
ad)
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2326
Message-Id: <20261123112558=2E15625-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41809=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/socket=2Eh
1 file changed, 4 insertions(+), 0 dele=
tions(-)




diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
i=
ndex 47083ad=2E=2E80f09a3 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/ope=
nvpn/socket=2Eh
@@ -736,6 +736,10 @@
     const struct addrinfo *curele;
  =
   for (curele =3D addrlist; curele; curele =3D curele->ai_next)
     {
+  =
      if (a1->addr=2Esa=2Esa_family !=3D curele->ai_family)
+        {
+   =
         continue;
+        }
         switch (a1->addr=2Esa=2Esa_family)
 =
        {
             case AF_INET:

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2326?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/=
2=2E6
Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Gerrit-Ch=
ange-Number: 2326
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--jBE/Cd5K2+w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2326?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">socket: check the address family i=
n addrlist_match()<br><br>addrlist_match() cast each remote list entry to t=
he peer&#39;s address<br>family without checking ai_family=2E With a dual-s=
tack remote list, an<br>IPv6 peer compared against an IPv4 entry read past =
the end of its<br>sockaddr_in, and 0=2E0=2E0=2E0 matched any IPv6 entry=2E =
Skip entries of the<br>other family, as addrlist_port_match() already does=
=2E<br><br>Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a<br>(cherry =
picked from commit 756d140aca1958f71a701b4179e2e59fd3d86ead)<br>Signed-off-=
by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2326<br>Message-Id: &lt;20261123112558=2E15625-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg41809=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/socket=2Eh<br>1 file ch=
anged, 4 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 47083ad=2E=
=2E80f09a3 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><s=
pan>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -736,6 +736,10 @@</span=
><br><span>     const struct addrinfo *curele;</span><br><span>     for (cu=
rele =3D addrlist; curele; curele =3D curele-&gt;ai_next)</span><br><span> =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (a1=
-&gt;addr=2Esa=2Esa_family !=3D curele-&gt;ai_family)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span>         switch (a1-&gt=
;addr=2Esa=2Esa_family)</span><br><span>         {</span><br><span>        =
     case AF_INET:</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=3Demail">change 2326</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rele=
ase/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic3efcdb7bc=
4e60a81b9292adfe7f8e22b86e274a </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2326 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--jBE/Cd5K2+w=--


--===============0745648598277504332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0745648598277504332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0745648598277504332==--

