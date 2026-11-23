Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4C606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Du9ZNiun;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hJr1Juqs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Rw8rMTgn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S9gQByNW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zQ0NYlDzXLXBibiNrRUj7atAJMme5cuey2b1b1mrkSg=; b=Du9ZNiunCu8Rj13fro4f6ULDsp
	shq/HQwRK9ApV6mhkB+vfwdpbVgtN4R+/fzX03HruABdY96XJgHHpdosL06qaLREoHqGc51viYdGz
	Yztreoi4xq1BAfEECUi+NhAeDv0oAamOaP3QVrotuq6b/NcIWoHKM0avFEtHOkOnFLg4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY7d-000000000hx-413N;
	Mon, 23 Nov 2026 17:46:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVY7b-000000000hp-1D54
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:46:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qBzosyv37m3ZxHX+v6vuxm45qdF9zd14aOqZpo+BKts=; b=hJr1JuqsiOr7Zm9DjTBKvEhETN
 JfFgQsvtWb4ynZRyCSrKVPS9Eq8oPUFNTmb88wnvGcRWgvcCE1gkKc4w9gDlUtg/u/pCkHMNTJAyc
 xNoljO1x0uOJx2e7WmKj3Vx1KTfxlDKWRjCNA8URipzyY1fmDmGIacHH34mi26oX0DB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qBzosyv37m3ZxHX+v6vuxm45qdF9zd14aOqZpo+BKts=; b=Rw8rMTgnp8zBXSb6/eJUmYj6VG
 gTYHv9Xs0gD/PX1TSWnzlLwJLGV7gG1FjJ/N3lnDVLDvO0/rWlZKl/lU6T7Ht5s32xb+6/R7/fiaA
 Iw4AaPRpaA8lx9++R+HWkY3OZLbu2Lhsg0OlO10/rsCvymLdakdZJTukVcgu/kkuVvK0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVY7Y-000000002Dy-22cN for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:46:31 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so34851135e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795455982; x=1796060782; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qBzosyv37m3ZxHX+v6vuxm45qdF9zd14aOqZpo+BKts=;
 b=S9gQByNWW1AYSUsxEKSSgDAUvaSzUZgHD4X+/GftnctvQwcRPsRrcXov+6v9aaJ+cR
 lsqKo5NCER9AtBx++hGbNWYlcWpLxV3/XEk2Z9bEycaS0iEmSYlkqpt3HE1U8Bclo+7N
 IYyIP4hs3SD1FQaJR5F8KTvB8V4ub2/XeVFs9BiTcyV628wIiqVxGmwWj8uqECQGKKxi
 XJzSRogylXTQBzEKeDYNBF4zmw+nNfCPedV7pcfLFF/OBFUnnifcyf+MSsHVtPEop6U1
 zgHw2RZ+sWOzvzuxdZ7oTz4WEKOGavJ0S5wjURqq75q9XeoWfsjx1GRL6DBPQk10jEKQ
 oFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455982; x=1796060782;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qBzosyv37m3ZxHX+v6vuxm45qdF9zd14aOqZpo+BKts=;
 b=YayQjh8tBv9utbVtW6yheo7VXwSrsSDF99xs4dK7JLc6NOCSBF/Ezwyg+40mYLVcAM
 ywlc5D7GKJs/49t31+43lnxrc1vkc2C5gkxw5vUaITM9XLvQ2tF/n5mBAZOogxDneqgH
 2fvrH1hLjX+u1LRVBMYAlrrlZq90sBcK2EROKUJmJ7e/W8VrEOcHROZ0MH3gVN9Y59Au
 Ehx6NmLghzxLDZknvA9LeU3cOA9MK0r3C0YZWXhCx57hJwSzshdCQfYeJARVhXhJCwwh
 2zUs+S9MBptml7BsCDskOQfxgjXoJjxq7/MGaUPHsl310kRNApmxI8K462Z1UFxBUrWF
 BYWg==
X-Forwarded-Encrypted: i=1;
 AL+hErHIhRxb8TcnH9p9GPzJ4WXXkcx2OXVRQ0BvK+GOlu2wTQmDN1QjrgMndASMHPktd4KpqWEp+XPPmDP0Ypeh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/2uZvdY4C3mxNJPQlq4/BRqwWnn0zLMXhr3cf30GJDyGth1itM
 zNb+CzYOMQJUTvHCXHmr62f70HM2/CXnU1gQrxIj+Euz9eyQuq+i+aldvkarkVde2UAjeptmWPR
 i1w/5rCu0ieOyruqlfBD+Ji241NUmV1K38IqOnr3dodCbu9uhUo20yMNlxlXvP9pK4MKs
X-Gm-Gg: AZFdTZeMFV5UjtKSIvbaGWIenCtojGNNzUh4tLiVw+jnni9mqZrh7/jkirSJO47AAYf
 bMM4sClG3Yf0h/6/elUgr6fg97027ITXUNSN2wnmYsXVm4QlkIIQqsRI6JTAJDmNQuvnQBlSCDg
 Qdfhg3r4dDVBK8gcthOxNJlhNZ+hNSfYy6NEZ54Ha1+aB83Y7nSFtXDiQHM7Qy35JtjxwhcpynK
 KNegCw8wD3doYoqi9PriqIrFTHkrPBBiiZ5cCMT7ShV5Q6ST2TH8xc+AUuz0pK+d4fqkimVsNb9
 qbNuPRAjnNM4KrBTWX/aHTIem6oZF5viHnj841pgfL8po2t4z51TtPK7APHG0S73YL8/ZB20Tfb
 6+ZTL6YEe4MAIBrsYiMvkWr9yDQU89YURzXc7dmHH0xaKdiDd8hdCenUxaVwpLxZuY1Guoicci6
 aXDrcRMKYntHMokvcSQCVwDvzB0F8v3worRZ2ms/3azXgKpAnNyj/kkZ+UOsCg0s2egtDtI1jai
 yElAWDo7ZJ8OncNL1BHjrMOugx121p6TQq7P3MaWIs2cDxX8RKzU6jHBwtTYNZLlfh/nIv1foVD
 71rwI/7XMqRjdvbt7Nybuyq5vyNB1nsvhRymwt5gEdcifvRRmrAszE68p5Kb295BNM1OsucXTJx
 O/tkivYvwRhXEn1BTxpbceFTdq9AIWJ58hlGabKNGk1TG7ylVrihSZ940K1do5Q//e38TxtBRb+
 bCUi2IVRM868vXQ/A=
X-Received: by 2002:a05:600c:470a:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4bb8893071fmr253487215e9.24.1795455981851; 
 Mon, 23 Nov 2026 09:46:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm681066925e9.4.2026.11.23.09.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:46:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:46:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb
X-Gerrit-Change-Number: 2329
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2329?usp=email>
X-Gerrit-Commit: 8aa208ae714a19708e3c7264409f0cf51bf0f3b3
In-Reply-To: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
References: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQzMzk5MDAwLkliYWI1ZTMyOWQzODY2NTFiYTBkZDBlMmY0ZjliYzYxYzM1N2NkZWJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c7b3ee27c87a88c87605f99e02fbd604633c56ea-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVY7Y-000000002Dy-22cN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop unused
 is_ip_packet_valid()
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
Content-Type: multipart/mixed; boundary="===============0050284092213743427=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0050284092213743427==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3VT7qE16oFY="; charset=UTF-8

--3VT7qE16oFY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2329?usp=3Demail )

Change subject: tun: drop unused is_ip_pack=
et_valid()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t=
un: drop unused is_ip_packet_valid()

Its last caller went away with Wintun=
 support in ad7a6945
("win: remove Wintun support")=2E

Change-Id: Ibab5e32=
9d386651ba0dd0e2f4f9bc61c357cdebb
Signed-off-by: Razvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329
Message-Id: <20261123141837=
=2E2675-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg41829=2Ehtml
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/tun=2Eh
1 file changed, =
0 insertions(+), 27 deletions(-)




diff --git a/src/openvpn/tun=2Eh b/src=
/openvpn/tun=2Eh
index 61fe943=2E=2Ed8680c6 100644
--- a/src/openvpn/tun=2E=
h
+++ b/src/openvpn/tun=2Eh
@@ -502,33 +502,6 @@
 int tun_write_win32(struc=
t tuntap *tt, const struct buffer *buf);
 
 static inline bool
-is_ip_packe=
t_valid(const struct buffer *buf)
-{
-    const struct openvpn_iphdr *ih =
=3D (const struct openvpn_iphdr *)CBPTR(buf);
-
-    if (OPENVPN_IPH_GET_VE=
R(ih->version_len) =3D=3D 4)
-    {
-        if (BLENZ(buf) < sizeof(struct=
 openvpn_iphdr))
-        {
-            return false;
-        }
-    }
- =
   else if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 6)
-    {
-        =
if (BLENZ(buf) < sizeof(struct openvpn_ipv6hdr))
-        {
-            re=
turn false;
-        }
-    }
-    else
-    {
-        return false;
-    =
}
-
-    return true;
-}
-
-static inline bool
 tuntap_is_dco_win(const str=
uct tuntap *tt)
 {
     return tt && tt->backend_driver =3D=3D DRIVER_DCO;
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibab5e329d386651ba0d=
d0e2f4f9bc61c357cdebb
Gerrit-Change-Number: 2329
Gerrit-PatchSet: 2
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--3VT7qE16oFY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2329?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tun: drop unused is_ip_packet_vali=
d()<br><br>Its last caller went away with Wintun support in ad7a6945<br>(&q=
uot;win: remove Wintun support&quot;)=2E<br><br>Change-Id: Ibab5e329d386651=
ba0dd0e2f4f9bc61c357cdebb<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329<br>Message-Id:=
 &lt;20261123141837=2E2675-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41829=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M src/openvpn/tun=2Eh<br>1 file changed, 0 insertions(+), 27 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</s=
pan><br><span>index 61fe943=2E=2Ed8680c6 100644</span><br><span>--- a/src/o=
penvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@@=
 -502,33 +502,6 @@</span><br><span> int tun_write_win32(struct tuntap *tt, =
const struct buffer *buf);</span><br><span> </span><br><span> static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-is_ip_packet_val=
id(const struct buffer *buf)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const str=
uct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)CBPTR(buf);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =
=3D=3D 4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLENZ(buf) &lt; =
sizeof(struct openvpn_iphdr))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (OPENVPN_IPH_GET=
_VER(ih-&gt;version_len) =3D=3D 6)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (BLENZ(buf) &lt; sizeof(struct openvpn_ipv6hdr))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            return false;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span> tu=
ntap_is_dco_win(const struct tuntap *tt)</span><br><span> {</span><br><span=
>     return tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2329?usp=3Demail">change 2329</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2329?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 2329 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"=
> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>

</body></html>
--3VT7qE16oFY=--


--===============0050284092213743427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0050284092213743427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0050284092213743427==--

