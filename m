Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC7606A336
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b1K1TJuW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XmWDeEiS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EHGirVc3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SKKtOeSl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nzCtLAdRHLSb40Tlyln/h94/bW10tyADI/mmcIUFP+Y=; b=b1K1TJuW0no+HYjFEkDaz7MkvZ
	WvMJH2ow0xMVPq+NzV4TG5nZVJFEhnq6KDki04hdpN5eeNPrdJ4aQ/yCJJbBvggSc+ADCHcGYaNA+
	VBwrzsKnLkgT492Ykhk5NwF2EX3ClRni8pw3c3UWnYF0iq8YJGhU69zsvUd2M9dKqzGI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVQgc-000000006mD-0dSo;
	Mon, 23 Nov 2026 09:50:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVQgZ-000000006kz-1Nwv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bt8J4xCR/l0CSu7tlEwB/pT9N6avqbbK1XtY8OZfh6E=; b=XmWDeEiSGQ+0Je//DkAyIiJZvG
 mymA7Sk4u4uFvka7WHQuXZka4XFpsAO+FK/0FR5OQIDWVIOOb5GsW51DQci1c2riNzY0bzAT4j6j9
 NSh/v5jzOysO7CRfVFlaEuoao2u8S3I+ycP28KV5TiLSoLWmYcUhdIbSRx3ijRHQ31Vs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bt8J4xCR/l0CSu7tlEwB/pT9N6avqbbK1XtY8OZfh6E=; b=EHGirVc3AsL7DtNFmPpkjS6dap
 6TVviG2oMg15SYWo35vuN9oYfSN34p/qaHJ28UX/T7tuLE2M1Lfs/5v12BYVZ7aFH0eVZifiHz8iL
 dppYyOPqruMyA5BgSiRIlJR+2rqlFuyxS5NzRFHPX8yL3g3/QOmvX61vDmkeEo2XkZJg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVQgF-000000003nJ-0LA4 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 09:49:47 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so1578605e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795427380; x=1796032180; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bt8J4xCR/l0CSu7tlEwB/pT9N6avqbbK1XtY8OZfh6E=;
 b=SKKtOeSlw7SeFLo2gHyYaNOoR7I1bZElVKWWh5fFy10milOD/jt0TOrzTPt2iesJo6
 oGGsgsaCRR/adosWe3NMA1kb+73VksyKQEfIyXB2+TFS/ZjNmfXrk8uTr7JT7nkJjZmZ
 UveoGOBoWCWHB9/L4NgJ85n+deDUg099PPmZpuKEyQvYtMzL3wD5abTsqYhliJdFocHk
 OpW48lfmJaAnPey002k92xP5aegVfD1pGJ7tZ5/bLL9W3kOzMSzPQIy9FcWlwtF9Ap58
 XwuL6bELHy2CjJhDo48eWWoht1mkyMoABH31vEerpLrqRPs3AHFsBvywLF9z09LUwRZY
 yNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795427380; x=1796032180;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Bt8J4xCR/l0CSu7tlEwB/pT9N6avqbbK1XtY8OZfh6E=;
 b=IM1lyxXhbguOVhsYAlsZdbk1I4OZtXsISR47BJ8FvY1WaL9BlBECuWZ6erG7eLfi6k
 XV7XU9CRrA5HirxRTWooNGr/aSCHzwMSaDntdbN6i6N1L/UB384Ty9ak6FAIpe5JakFR
 5lXeOgtCMCaOdx4z513eRhdWchdGtjJq9pIfTOOsDNNm6pbR1phjPf116AZki73QztTz
 SwocKg5Z6C91XhwCWltlm3ZsMq0Kih6yJiv6eGabwKBDbRkPj7M/JCiRA+WCYMekyEb4
 AKSPYHszjei8yMMRvCVt8YNWoDJ1HIadBbKXuN6iSAddBu2OgeE2s9DQXVuzuq4El32S
 Ts9A==
X-Gm-Message-State: APuU4Z83E05nHx7LQh1DRynJxMo6EBkCBv7hLnX3IHYcBHx3gFUVbWoe
 Og7ITZYDjf9QSNcPVPPIXGgBnF3VvSyHRJbOYsOUktyBfNd5Ky8MSteJg4OrEcQAX9UOI/asgst
 jc0pHjL468jLZlP4Fob3Jt9SZIeAxGWq0E+6OVVKTavoNC+N18eVmIooEq9AbiIn+xA6imUcBLN
 uaoPHNkA==
X-Gm-Gg: AZFdTZcHmiuq0VqCVia5u9Ylvtqs7Qrb3v1luAXKSJjDhG2nypKs+wBUs4rAsRrNQ3U
 yOAwZrJL99TzDh3Rw/qn8JDeScXJ0NRXsiDETVyJeLLdhlHlankA6HLlVmyZ066KBTOBAM3CaLP
 5YNm2DRDxTyTC/RtG5YSktAaEt6gKUG6qJxsS+R9j5galxraop2mIG1OBQ0VDCuMG6dIaP6MRLL
 NftrUCHhECVkI2CdTZvY2hDUkcII6CWr7Z48n+TFwr8FDAbkfDJEVMA1K0shS74PmS25guEIQs7
 Dh2kmLFYc9B9aMLW2DJX/oGHAnwp8RFihaxvE7sqoKV//b0knqC2ioDPWKyw+ompxg6zXDBEEwg
 Qpar/aWHxAaPSp+FscaHn1a0w5GQeEZSXyKuqsgLh6zzz+NUmM0ykXqDK4UjyoF0GOrUJlm+UWD
 QUeWqTa4s90q7uzuatiyyWhQx23RJWUVO7eY7io3t1Mx6jUzfF3wlGpPOR5WZpHGUIVzcVnzGcY
 J+j4c/itceDs/VzUIO0VEyOBkjtj8+mAOvYUHVmi3vkCisGZ5SDurXNrSVGRNKP6+ZfQPCOtdPD
 MANb9HTgdy/NglJOuIv3ULRnZH3UfnHiu2nLrGzzh6dKe4pPAJ983/dUyaXGq8G6bVM+OfePwxx
 joZUH21a2ixdRC4TCWVgyvcy2j369QyqYhR3JL34VimPlk/qX25UrXQWvtq2GzL2EwvxJozo3RR
 CbquvJ/5TOiaFvyR8=
X-Received: by 2002:a05:600c:4f50:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4bb888063f3mr271738975e9.16.1795427379601; 
 Mon, 23 Nov 2026 01:49:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9065744esm143249135e9.1.2026.11.23.01.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:49:39 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 09:49:38 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2215
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2215?usp=email>
X-Gerrit-Commit: 756d140aca1958f71a701b4179e2e59fd3d86ead
In-Reply-To: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwNjU3MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ae706f819fee6cb5a298775e79295342ec2cc86-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVQgF-000000003nJ-0LA4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: check
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6792531239865161646=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6792531239865161646==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BsnZWFK5/z0="; charset=UTF-8

--BsnZWFK5/z0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2215?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: socket_util: check t=
he address family in addrlist_match()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

socket_util: check the address family in addrlist=
_match()

addrlist_match() cast each remote list entry to the peer's addres=
s
family without checking ai_family=2E With a dual-stack remote list, an
IP=
v6 peer compared against an IPv4 entry read past the end of its
sockaddr_in=
, and 0=2E0=2E0=2E0 matched any IPv6 entry=2E Skip entries of the
other fam=
ily, as addrlist_port_match() already does=2E

Change-Id: Ic3efcdb7bc4e60a8=
1b9292adfe7f8e22b86e274a
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215
Message-Id: <20261118163009=2E2=
2733-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg41629=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/socket_util=2Eh
1 file chan=
ged, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/15/2215/3

diff --git a/src/openvpn/socket_u=
til=2Eh b/src/openvpn/socket_util=2Eh
index a1a61af=2E=2Ee85f6fe 100644
---=
 a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -312,6 =
+312,10 @@
     const struct addrinfo *curele;
     for (curele =3D addrlis=
t; curele; curele =3D curele->ai_next)
     {
+        if (a1->addr=2Esa=2E=
sa_family !=3D curele->ai_family)
+        {
+            continue;
+      =
  }
         switch (a1->addr=2Esa=2Esa_family)
         {
             cas=
e AF_INET:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
215?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic3e=
fcdb7bc4e60a81b9292adfe7f8e22b86e274a
Gerrit-Change-Number: 2215
Gerrit-Pat=
chSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--BsnZWFK5/z0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2215?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">socket_util: check the address family in addrlist_match()<br><br>addrli=
st_match() cast each remote list entry to the peer&#39;s address<br>family =
without checking ai_family=2E With a dual-stack remote list, an<br>IPv6 pee=
r compared against an IPv4 entry read past the end of its<br>sockaddr_in, a=
nd 0=2E0=2E0=2E0 matched any IPv6 entry=2E Skip entries of the<br>other fam=
ily, as addrlist_port_match() already does=2E<br><br>Change-Id: Ic3efcdb7bc=
4e60a81b9292adfe7f8e22b86e274a<br>Signed-off-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215<br>M=
essage-Id: &lt;20261118163009=2E22733-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg41629=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpn/socket_util=2Eh<br>1 file changed, 4 insertions(=
+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/15/2215/3</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index a1a=
61af=2E=2Ee85f6fe 100644</span><br><span>--- a/src/openvpn/socket_util=2Eh<=
/span><br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -312,6=
 +312,10 @@</span><br><span>     const struct addrinfo *curele;</span><br><=
span>     for (curele =3D addrlist; curele; curele =3D curele-&gt;ai_next)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (a1-&gt;addr=2Esa=2Esa_family !=3D curele-&gt;ai_family)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>      =
   switch (a1-&gt;addr=2Esa=2Esa_family)</span><br><span>         {</span><=
br><span>             case AF_INET:</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail">change 2=
215</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2215 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--BsnZWFK5/z0=--


--===============6792531239865161646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6792531239865161646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6792531239865161646==--

