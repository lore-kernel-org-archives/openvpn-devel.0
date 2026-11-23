Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D31606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hfF/05Xn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZmX9dWLO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b1iTOP6P;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aC4f5Z0O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3uXQIsF7D2GyHpFEWi3IZzUNNcUxdSW0A2AsUmhMpQc=; b=hfF/05XnOP4rlYyZUYgJzPPj/y
	XXMpWFpwHALMVhkRpwPoFDBMPpNjr8vqSrBrD0kDeMgAey1qcYalPwq4Y8f6b4TfpOnSCeLeembtX
	k/ilmn4JfWsFNp2hZWOaE6OBlnk2nuJq2nyci13+Ouk3pLq+g1jrK+Tlnuo858bexBp0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY4u-000000007WA-1tbD;
	Mon, 23 Nov 2026 17:43:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVY4s-000000007W3-3ryc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t09M3r3VjO1lEX3PYkr015ICzwNmdWkNENXUDrf3vao=; b=ZmX9dWLObY3yrkCBkVjroDwBtV
 qz5T/CILhNQG1uLXQW0PKkKmcDBzyIIetfvUGinsRwAkIVgMVRyQIQKyDbUUTfa5nL+S9opZBUFv5
 j2VczBHnX7z+y9xTGA/2L4WOFnMtCgdRgcdabRXYNA6IGLSPN5cCjsmKwqupp+6jHsi8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t09M3r3VjO1lEX3PYkr015ICzwNmdWkNENXUDrf3vao=; b=b1iTOP6PsVrYj25rnD+ikaklbV
 i1vgXKdUtJuAGtyg3gxhI38NJItdYI6a9bmuEdc84KqyTXEZ1GmBAM9VkW0bFQJJZSlk5iBxieZ6/
 iA3d7S17EFd2HM3Jgqxy805CU+xf+cPWn3ULlfgQrzbwJPZETQQcwCRCPUhVAB5kSrXE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVY4r-0000000029A-1GFO for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:42 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so6889215e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795455815; x=1796060615; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t09M3r3VjO1lEX3PYkr015ICzwNmdWkNENXUDrf3vao=;
 b=aC4f5Z0OMi+81rH9YNy6QXmMQJ+m+MRyq7Yezu7Vcm9z+Zn5Fb0gXt+lJkNa7437Bl
 YuMIFJsmCYkjmVbXmN380PbTvWw035iBTV/KHDZr+LLZOWPF16mMx6bfF2Z1J9FD3Pdu
 EAF/F8mVAyFFD7rdLFyqo4QmxIGEN1S7sc+J/GDfSMPkghEmH73S3LW/ZZZxFoNer9sh
 DHcIVf5t3seauXK2PfeO//ekqRCIEyZXzPkw11Kp0VAMvfx8S9T0Y0UvG3opX623oGjz
 qJagLxQwlcnPU7g9+ONGNVapS+0KUh3oNn5jTLYmEBSbr++PVAnklT0StPLN9bdJleJN
 wekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455815; x=1796060615;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t09M3r3VjO1lEX3PYkr015ICzwNmdWkNENXUDrf3vao=;
 b=IlUX40zG64BxAd2ESlssKOEl9sDdmMFJZ9M20bfxFd3KSMlJ0NVXMQlE+n7vfdMwpe
 HK/GoNOjwPS6CP/VrqQhyopfzMSZN32WPxcI1H57hmWGzOAwjgx9jaUHTfwlVrgxCkr7
 locE/utzGEz9bdhJB5Djrpwk04Dh2/ll4x3/SSWKvBmHEv6x5oYnTzRnuZa5Ir4JUG/2
 dTSZ0ecy4O/73+c8LMYDktp+eEfPtWMm02AGDssXz0syVpkwMQ4hj19+NOztyXlQFaFe
 PvYqqnb1Lz8XFFpBA6n3TFA/8qVqSfq9YtH6ag6FROGTWo1lM0chrR3hVvgUSw8lGEQX
 eCbA==
X-Gm-Message-State: APuU4Z8Fp4JcjQLK1fqmXF6raUjmhquHT4sMxa5K5LW/udqHSDGRIf90
 LMFcSpma/R2WLXcIk9GFPtMFpP8npFHgZL27hkDM1Cyk+3Y0vvVUlS33NM56e7kaAYUrbk+DcKd
 m85Fc9asb0ZypLDi6e9z64ZTTrXdZRUdsylilWx+mSNlvy55wDL8ATNWKqym3+rPMmgoIxTPmAJ
 /uzNCltA==
X-Gm-Gg: AZFdTZeb9mCTFbLZn2XQ3pQ/LyVa2EQ0x1O3r+wwEQRWLSez0K7EvWEefBwaeniHIBp
 ear9jD28oLGxiswGii+WoCHIMTTBRLBIp6Dz1Czry+eO1Vdy2klcAYZ9apHa9Xm0275gBkjPAeN
 edsa5+y9qlFHAxdwPm09ft7upH9/F2wTN02JgZ5pfG1jVayaizaghsrMEYDzyqpPccOA1UeKX+t
 O8B3ZsTV7GekPaDMOH9rWjUDNWfSawoTM4739Fu3BP5PDhg8FU84pClT6OXw8aXsJkQ/+lCArPr
 +qOQTV8n4jBohQe4Stwg4USZ4lS4c9GoivwJQHxhNEV3WHg4BOyLFGun7MoPVIPd4lRMz8fdAxN
 XWocD5rhAHkY0RVlzdSlSLkeEfQJJtb2a1IM8cNmsPZ8EItbRvbji1Do4O7XiSGD0pZgaNk9Rj5
 hbLcKBL8Alcj0nkruJ1sf12h8PLWyRCb5E69io/XM22f06VUAFiUuLwnL8oWa8C9XkXAMOkx4cr
 VSNJXbbG0MsxN5R/FqGSMwzcm1tLJ/b55XhwGq+fQ8kf4vgEQsoaVHCYxkuWN/1y9WMcaFVxldV
 jKh8cM4w3GOq0I78ukySrIFmbIFkuOdvROIJ1XrpaK6BLT4GNp+NpHD6HfNrF9alTrNTJKH+Slg
 qTWTT+ImsY3JQENNdHT+d+AfL95xYhOVcCC0VeeGlakr06B9n2X24I20SUHkSfLNxInglQQfHei
 JKhzC4Gp+qJFdNow4=
X-Received: by 2002:a05:600c:a4b:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4bb88806292mr258858835e9.15.1795455814447; 
 Mon, 23 Nov 2026 09:43:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9066f6e6sm149064325e9.3.2026.11.23.09.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:43:34 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:43:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2326
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2326?usp=email>
X-Gerrit-Commit: 3256f39106ad04d744f8db6633e42b616891a242
In-Reply-To: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMwMDc0MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c36a13b50f7e2c7bb5c74e0aa9e297bd1ef4fdba-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVY4r-0000000029A-1GFO
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6786757762146157356=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6786757762146157356==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zL9cWVjXxUk="; charset=UTF-8

--zL9cWVjXxUk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2326?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: socket: check the address=
 family in addrlist_match()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

socket: check the address family in addrlist_match()

addr=
list_match() cast each remote list entry to the peer's address
family witho=
ut checking ai_family=2E With a dual-stack remote list, an
IPv6 peer compar=
ed against an IPv4 entry read past the end of its
sockaddr_in, and 0=2E0=2E=
0=2E0 matched any IPv6 entry=2E Skip entries of the
other family, as addrli=
st_port_match() already does=2E

Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e=
22b86e274a
(cherry picked from commit 756d140aca1958f71a701b4179e2e59fd3d86=
ead)
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2326
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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/26/2326/2

diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
=
index 47083ad=2E=2E80f09a3 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/op=
envpn/socket=2Eh
@@ -736,6 +736,10 @@
     const struct addrinfo *curele;
 =
    for (curele =3D addrlist; curele; curele =3D curele->ai_next)
     {
+ =
       if (a1->addr=2Esa=2Esa_family !=3D curele->ai_family)
+        {
+  =
          continue;
+        }
         switch (a1->addr=2Esa=2Esa_family)
=
         {
             case AF_INET:

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2326?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: re=
lease/2=2E6
Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Ger=
rit-Change-Number: 2326
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--zL9cWVjXxUk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2326?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">soc=
ket: check the address family in addrlist_match()<br><br>addrlist_match() c=
ast each remote list entry to the peer&#39;s address<br>family without chec=
king ai_family=2E With a dual-stack remote list, an<br>IPv6 peer compared a=
gainst an IPv4 entry read past the end of its<br>sockaddr_in, and 0=2E0=2E0=
=2E0 matched any IPv6 entry=2E Skip entries of the<br>other family, as addr=
list_port_match() already does=2E<br><br>Change-Id: Ic3efcdb7bc4e60a81b9292=
adfe7f8e22b86e274a<br>(cherry picked from commit 756d140aca1958f71a701b4179=
e2e59fd3d86ead)<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326<br>Message-Id: &lt;20261=
123112558=2E15625-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41809=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/socket=2Eh<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/26/2326/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/socket=2Eh b/src/open=
vpn/socket=2Eh</span><br><span>index 47083ad=2E=2E80f09a3 100644</span><br>=
<span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=
=2Eh</span><br><span>@@ -736,6 +736,10 @@</span><br><span>     const struct=
 addrinfo *curele;</span><br><span>     for (curele =3D addrlist; curele; c=
urele =3D curele-&gt;ai_next)</span><br><span>     {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (a1-&gt;addr=2Esa=2Esa_family =
!=3D curele-&gt;ai_family)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span>         switch (a1-&gt;addr=2Esa=2Esa_family)</sp=
an><br><span>         {</span><br><span>             case AF_INET:</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2326?usp=3Demail">change 2326</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2326?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22=
b86e274a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2326 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--zL9cWVjXxUk=--


--===============6786757762146157356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6786757762146157356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6786757762146157356==--

