Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C89606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LiAMhgb0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VPiU1U8I;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hh6/bTrq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cj5eijPt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HbzerEm+JlLg6aVsTurUUHIupJ2TXyhibknodKdLGpM=; b=LiAMhgb0zGiJYKZgF6yHieQEBx
	g6NvoHQ9S7Z1wyfceg8vJq2KVgyuGKBSTfzaKdvQUxXEfwl2RW/nO/C7c5L1sicJZL4soHiagfUuu
	iXa1BmPoQkowp/bk6M1GNewMt4GBSINbNyyBUWVFcmZ41SY9rGWwKA0QDInm176f8NEs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVoq8-000000006GB-2ZbO;
	Tue, 24 Nov 2026 11:37:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVoq7-000000006G4-2oAh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G50oFknJgFUyRpZcgfhLRgUFtjMt8FgwvZatAVbFGRg=; b=VPiU1U8IpJQm5d76BGNdGO3qaV
 k8sgB5YdyXb/wx2oqiuE5xOiuWxor8Ks+2FAET/SumXlMcMCoEXYc68T08E5tx40d/beM+LZ5Ry91
 Q/H5JcW4Ly7zz3dvMs0IcGmm8OKNWYvuWbLcenNOXgcVS9csU62DayENZqWfPVeXOTdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G50oFknJgFUyRpZcgfhLRgUFtjMt8FgwvZatAVbFGRg=; b=Hh6/bTrqDlLN8ZFwIHeHQY3wfP
 43wSMPQTRW03BXssG9El1lPImh+aft3LpVNzsakcTFeIt9jIy+xlRIcWbhTpqWImTW8EDLsjtkAkW
 KowH1Bl8Gb+XRnJMRe0ZCjypjdBRUFhZc9yjMV0yHY8y/L/JSwWBrcz20/pl5FVpnh1I=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVoq4-000000008Jg-4A5B for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:37:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so36509135e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795520246; x=1796125046; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G50oFknJgFUyRpZcgfhLRgUFtjMt8FgwvZatAVbFGRg=;
 b=cj5eijPtFz/0cK+sAoEvzPD3ZMulV3i7TiT4vRGHRKw8/sVia+znqYTuxI3w/1wsiE
 9Oz/VxjZDkhlmIygFu9qvQ2Bo+jZ6mUUy9Roef4278hpZPebYvqTnlZ0bMelC5IO5CR7
 JXx/HSH6VxHr06w0HB1xhMmcKGCfTQgwV1jdHRF163chZ902b3jRCC181D1WVNvbA7n9
 WCjd96DQQVnONuBexE6cKCikrLJ7cwVWGidHv0F0MtFP+6JtG1tFDOv/MGvQJv2jnoGJ
 Ve70tAawIzxdBgDQH27CBXIYF0sk8ut3AZONQRqRr0PSvYb/4h9zkXUNrY/hkxorzp/C
 8deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520246; x=1796125046;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G50oFknJgFUyRpZcgfhLRgUFtjMt8FgwvZatAVbFGRg=;
 b=LOXZbMrdkdWJf5O+3PiypJB1+T+IoSy7mHsWz/HMrai90ixCOUyp4Q05Hej5ZnmmRF
 Jq7NMnKnhEdByjrK1/Oc6cge867IHPQk2Cr4Hr5c9PNwX1OaURaxdk/HFNVVi7IP5QLE
 YrCm462hNeHeOt/KgqkEQe0btPXUmLAJOpDnzSZona8X8tAwDpkl0ozYyL3VnExbimuF
 2ypnm2kXIhUixXaaMcP+LX1BQecJikmE6p2wE8QFWuouR/vcx00FqJOm1QhFze3ls7vu
 JEbxY9dOHwsRPxcF4LsIGQaxan4Jbl7z5ZlIhmMEbHmyUv4koDzZw2xpZvTKlsRBhpie
 ZGCg==
X-Forwarded-Encrypted: i=1;
 AL+hErHfnIzCJfnaNuJBQhvmK8F3pNHITPZWdx9+HN1wtM0zTBoAx/11gqo1OHta+XSY/bb6bj6RWOeHOQn2VAnD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9gcmntV6qwET2PVdbY78J14/7ag6FAzg0tgVQy5+d767jVeHNZ
 r+Fd81lKcnrmh/hScwg4rzrpDLj5dx/en3Bnb2ttGd5pnh3lc4XhOHn+sbhQPLm405+GYLgByer
 0zw4uwKk0gSjLxocR7kx5tSiTWBNXx+4hTjmqsmZ4tiiDhagTm6EL3NBjJOBGS/KuOhqN
X-Gm-Gg: AZFdTZe3el+ei7MedpisjI15SVAjhE7awePmf+K2CH2yfH0ZmdZTsHvtGW3qgPQy6rq
 BuJhelcSJ4J5zZp8IqsN8WYGgIYLvkFCmo2vfDO6hP7aZO3NGSU0XSQKYCOiJ81yyStf9yPdqBq
 wJ17pCqP/ezsDpPvkvGP/FvRnZT7zjCz+2flxGnDKwYN/8tEzyP96ssBNheR3JEk4SPNLLqxajJ
 kU/uaKazeZq6aHpIguafW85K7SQVz3c8ztLoWZ8SdUW3qx3tZJDvyvq65r6771foxAON8pN5oMl
 YGdBy43Ymw3y8zE5iJ/Ueh+pHEykEz51Nljz/xqepUpqeyEVHZTx99q/SWi7dkaAsdY7jjFreIM
 y5EvctnffyfCqRDBKoyK7R2FBR6kMDNMgp5TD7E+PG+/OHZ/FljQTnJyt/HUJP3AGp5Yzhm7aZm
 V2ykC+/ZEOmy6MDl5bfpMMbyh6AWXU7vcaTlhE0mRraMlKTtdFgdLbqfteDSGCwiKraq2L/a0fk
 4K8q7DeI4keD3cByH5Xh2ZaiN8ytvNLJeE+gnY9MrJvDiocX0Ww7v0eCU/W1+zBgZh8Ie7hOU25
 Qz+GIggZu4yw6Tcp74DbwzVFOVyjrPqVzIQxLafQdt7CX7dR/f2fbHHSRPmu+7ZqDe9hbZ/jo4B
 YMB9eTz5Klzu6R7Jckw/zkqW6du7gUyT7iniwFRT4Qu0pC7X08L3Sbq5Vol6eFa/NQ3eSGSLSjz
 zkRm6VfRZjqxhLisI=
X-Received: by 2002:a05:600c:64c8:b0:4bb:68e5:b952 with SMTP id
 5b1f17b1804b1-4bb88819be1mr275713755e9.16.1795520246230; 
 Tue, 24 Nov 2026 03:37:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm415672145e9.10.2026.11.24.03.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:37:25 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 11:37:25 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
X-Gerrit-Change-Number: 2327
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2327?usp=email>
X-Gerrit-Commit: d170885f8c278c142c1cd0cd47ee97c3e236bc36
In-Reply-To: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
References: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMyMjg4MDAwLklkZDRkNzFkMDJiYWZlY2U3NDg3MWE4Yjg4YjFjMTJkMDNkNTg1NDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eaae86c369dd6013ccbbffedb252dbcb659a960-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVoq4-000000008Jg-4A5B
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: check
 the address family in addr_match() and addr_port_m...
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
Content-Type: multipart/mixed; boundary="===============0547255915365328297=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0547255915365328297==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MMRCgUizP94="; charset=UTF-8

--MMRCgUizP94=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2327?usp=3Demail )

Change subject: socket_util: check the addr=
ess family in addr_match() and addr_port_match()
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket_util: check the address family=
 in addr_match() and addr_port_match()

Both read a2 as if it had a1's addr=
ess family=2E The arguments are
openvpn_sockaddr unions, so the reads stay =
in bounds, but a mixed pair
compared an IPv4 address against sin6_flowinfo,=
 or an IPv6 address
against sin_zero and the bytes after it=2E Mixed pairs =
reach
link_socket_actual_match() when a client floats between an IPv4 and a=
n
IPv6 --local=2E Return no match for a different family, as
addrlist_match=
() does=2E

Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
Signed-off=
-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2327
Message-Id: <20261123140843=2E1436-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg41832=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
src/openvpn/socket_util=2Eh
1 file changed, 8 insertions(+), 0 deletions(-)=





diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh=

index e85f6fe=2E=2Ea7821df 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/=
src/openvpn/socket_util=2Eh
@@ -294,6 +294,10 @@
 static inline bool
 addr_=
match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)=

 {
+    if (a1->addr=2Esa=2Esa_family !=3D a2->addr=2Esa=2Esa_family)
+   =
 {
+        return false;
+    }
     switch (a1->addr=2Esa=2Esa_family)
  =
   {
         case AF_INET:
@@ -381,6 +385,10 @@
 static inline bool
 addr_=
port_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr=
 *a2)
 {
+    if (a1->addr=2Esa=2Esa_family !=3D a2->addr=2Esa=2Esa_family)=

+    {
+        return false;
+    }
     switch (a1->addr=2Esa=2Esa_famil=
y)
     {
         case AF_INET:

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2327?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
Gerrit-Change-Number=
: 2327
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--MMRCgUizP94=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2327?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">socket_util: check the address fam=
ily in addr_match() and addr_port_match()<br><br>Both read a2 as if it had =
a1&#39;s address family=2E The arguments are<br>openvpn_sockaddr unions, so=
 the reads stay in bounds, but a mixed pair<br>compared an IPv4 address aga=
inst sin6_flowinfo, or an IPv6 address<br>against sin_zero and the bytes af=
ter it=2E Mixed pairs reach<br>link_socket_actual_match() when a client flo=
ats between an IPv4 and an<br>IPv6 --local=2E Return no match for a differe=
nt family, as<br>addrlist_match() does=2E<br><br>Change-Id: Idd4d71d02bafec=
e74871a8b88b1c12d03d58540f<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327<br>Messa=
ge-Id: &lt;20261123140843=2E1436-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg418=
32=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/socket_util=2Eh<br>1 file changed, 8 insertions(+), 0=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket_util=2Eh b/s=
rc/openvpn/socket_util=2Eh</span><br><span>index e85f6fe=2E=2Ea7821df 10064=
4</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/s=
rc/openvpn/socket_util=2Eh</span><br><span>@@ -294,6 +294,10 @@</span><br><=
span> static inline bool</span><br><span> addr_match(const struct openvpn_s=
ockaddr *a1, const struct openvpn_sockaddr *a2)</span><br><span> {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (a1-&gt;addr=2Esa=2Es=
a_family !=3D a2-&gt;addr=2Esa=2Esa_family)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span>     switch (a1-&gt;addr=2Esa=2Esa_family=
)</span><br><span>     {</span><br><span>         case AF_INET:</span><br><=
span>@@ -381,6 +385,10 @@</span><br><span> static inline bool</span><br><sp=
an> addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn=
_sockaddr *a2)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (a1-&gt;addr=2Esa=2Esa_family !=3D a2-&gt;addr=2Esa=2E=
sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
>     switch (a1-&gt;addr=2Esa=2Esa_family)</span><br><span>     {</span><b=
r><span>         case AF_INET:</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Demail">change 2327</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idd4d=
71d02bafece74871a8b88b1c12d03d58540f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2327 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--MMRCgUizP94=--


--===============0547255915365328297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0547255915365328297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0547255915365328297==--

