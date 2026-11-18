Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A4606A33F
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m4o5yREd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nHuGw0BF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BaJu92aW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LdCCZb6A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9QjZm1kqE/h0D7/Wi0FQ6U9E8oFOXhfzfmBod2mxVF4=; b=m4o5yREdxIPzvc14bHTvnqhsWU
	hrh0n+mP2FdYLER9/YmonQLkyPlDbcjwl9aoJ+5KJ3jCa6CyGVJKxteGBB6D13FARFb9nYw8/D8i1
	I7q39Ch1ADPBO8iFXXvYAHFvn3OA0b1woo1EeqAC83HkOsRPqD14z9RJ+hxBRbGFaIh4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThRc-000000006JJ-1vuY;
	Wed, 18 Nov 2026 15:19:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xThRb-000000006JD-0Jpd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/+AEeiataLDyBr/UvAXY8ktU2oK9XJ8dNllRdSSRQO0=; b=nHuGw0BFgI9Drt0hNRqdKhFcdn
 eFuZY4jraunB/9WbLQryu21TlYZILzf6Y6f+WQdWJyWqzAv2shRZ06TJ+mEdybnss9SKHOcqe7237
 inUSI7GfQhDesaNx9xOcXBf+QNOZpw729q3h0B0Be5Egh5Sqw6aS6Y75HS4d6bTjoQHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/+AEeiataLDyBr/UvAXY8ktU2oK9XJ8dNllRdSSRQO0=; b=BaJu92aW8+XqCuxWDxuLAmyfBz
 +z641ncNcXQXkbPkldBEfdN0YzQ/bXoOuZoFO+4EjrdSgXTtfr2obMqD+rvZnZ0g0iw1gN9t5+RpO
 qZfCpG3FyekmrP/6K+gnZ92ODFAXiyibK3UFCd+BncvNvBey+iLycSNAR1VhxpRmx7oM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThRZ-0000000048s-0f2V for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:19:31 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so11780075e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795015162; x=1795619962; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/+AEeiataLDyBr/UvAXY8ktU2oK9XJ8dNllRdSSRQO0=;
 b=LdCCZb6A9Mvew0eNifQ255UH8b+Ftfchjf8okCKl5/qbKH9c3e589J8aahriqSF84f
 5g7cRBtZ+/xAJSH4ulkY4fgRHCvu9s2cHV/pbnkzCZTV6uizUylDhwuYogVF82dp1baA
 xm1olmw1kkaRJO3wmveTgijhDSxBlgexuY4XfT830urx0c5vJ5A4gC3fL6lG3sMDS8at
 ypP24bd9v9d1/oh5CzgNyzlPtJdzdVH7rIwZiL8vmZzLdvKk5FJJ738v10mbDexzFJDD
 dRROl427NzSw+a7Rm9XsuddZVHiFvZdfW4CC9Z2t5/hmXjF/21kzNgVqDjXEWk/jGrda
 /xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015162; x=1795619962;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/+AEeiataLDyBr/UvAXY8ktU2oK9XJ8dNllRdSSRQO0=;
 b=1B9f+85K5v4c6M4eleFTWsEQ2qQoSXk7P6zDztY2stVZ4YwaOxeXxGfnYl1zWu8F1F
 LSsMD6svpaqtSnf4zFYfzkax8aC/U0mTCSeUdnnpRZo4O0GKV9OGrPu00mhkPP/JrJKo
 C07VoIzIRVRuG45DGGd5QQSAN2h6G1M7xu/R86SgYQo6IBAeB7scY73LqUTcgm74ToH3
 vZkr4ay2dy5RyIq4MvKZbsM8U4+jStrmd6TeGPXx+/TR5vV5GwgTVzGt5xMFXafo4Hes
 NEXofud5K6dJt8yXG1pwyIBVuNFGYHspSbae1RmxiYrxjDn4ZF9KWObPlJgukxCL/8rQ
 70OA==
X-Gm-Message-State: APuU4Z+yU3g6/OIOPgNtyfvH6EL24uv8vjdrJb1AHa/SGv+kBWKF4W7f
 k+JiFzYdbOkrewDxciOQcMu+2R8099eP6JEjrXomJvM+yl58D+vOyXnm9LV8B+N9mSguOid/NMu
 +UB5SUmQ3NRPX+HOibu5aM5hAuIUF65C6pw6SkJ4kyMOI+GD2pKWz/g2UpltxH5L+vUpz
X-Gm-Gg: AZFdTZfTL0ir15JbKa6fhysr5Xl1zngDP8YNYer3XhZrVjIIfssAlVMIK771BY5dpzg
 TGvNA5+MgNpWx8os2a4l3b8r4ywHw0GVvKWGWl/fiMQ2m/eM0lM+ykYZhav7z/HSp7QK8xll8wO
 DjcTNNBJdvKZn6sQE8+OtsF5gZv2wi20ruerTpxWAs84NlJamW/g6soHW79uM+jBp0rKxygSyKC
 JRHpnsbTCU4R28MazMHtJOuSaivizyfAPGQzULQQjucFC/fp61bAjUhTqyk1/Q3Ea1mafR0szH6
 54IfhR4Zir2i8yuZPKurm0tT0oEl+BS3XwLgOb0lWqO1H/A5JOjeUJJCh0QFsr/BgMHNR3KCdR5
 Y5PqlW/TStYkjIqyNyCkeW2476WriemLmyUGPEMUoPo6LN+BggqZbEL+GtdeN99Q/9UMpVuyMX5
 w+L3zHcifm4xysmeH0OWhomODf7q8m7/BhYhF6mV2qKxZnS9M0YxNbYbbCJfCEl9yywHEf9x3V+
 VjBlh4CTSoPwyx0F7qv9yjNy7Vopn1kswC0tv6YJj2UF3P48D/273TJfxtQKGMH2er58uazgqKi
 uHaef1dIdQKUMMtT+6h5c4qOFpFAWt1kAxDLZQ+nCQbKwj0Vs//cunA+C6fFMbwD8TR9/cXkYHr
 jOyo3+C6sL2YFKzVCHUCEx/hvtSHpUToyynUVAp0r7u8qEYdQCHWbH8RROLcSifyuLx2cHrckvW
 2LBuNM/aMaPR7j0GY=
X-Received: by 2002:a05:6000:430b:b0:4a7:790c:4a34 with SMTP id
 ffacd0b85a97d-4a7790c4b13mr3421939f8f.20.1795015162328; 
 Wed, 18 Nov 2026 07:19:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c23bsm4690514f8f.12.2026.11.18.07.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:19:21 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:19:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2215
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2215?usp=email>
X-Gerrit-Commit: 59829ce2326634210b74e3f469387c0e429ee4a6
In-Reply-To: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwNjU3MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <20518c7c4c08d13f7a2e223c9946e69e30dc9640-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xThRZ-0000000048s-0f2V
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6351793453793565434=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6351793453793565434==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L68G5hWCTfU="; charset=UTF-8

--L68G5hWCTfU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2215?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Frank Licht=
enheld


Change subject: socket_util: check the address family in addrlist_=
match()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

sock=
et_util: check the address family in addrlist_match()

addrlist_match() cas=
t each remote list entry to the peer's address
family without checking ai_f=
amily=2E With a dual-stack remote list, an
IPv6 peer compared against an IP=
v4 entry read past the end of its
sockaddr_in, and 0=2E0=2E0=2E0 matched an=
y IPv6 entry=2E Skip entries of the
other family, as addrlist_port_match() =
already does=2E

Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Signe=
d-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/socket_=
util=2Eh
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/2215/2

diff --git a/=
src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index a1a61af=2E=
=2Ee85f6fe 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socke=
t_util=2Eh
@@ -312,6 +312,10 @@
     const struct addrinfo *curele;
     fo=
r (curele =3D addrlist; curele; curele =3D curele->ai_next)
     {
+       =
 if (a1->addr=2Esa=2Esa_family !=3D curele->ai_family)
+        {
+        =
    continue;
+        }
         switch (a1->addr=2Esa=2Esa_family)
      =
   {
             case AF_INET:

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2215?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Gerrit-Change-Nu=
mber: 2215
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>

--L68G5hWCTfU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2215?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">soc=
ket_util: check the address family in addrlist_match()<br><br>addrlist_matc=
h() cast each remote list entry to the peer&#39;s address<br>family without=
 checking ai_family=2E With a dual-stack remote list, an<br>IPv6 peer compa=
red against an IPv4 entry read past the end of its<br>sockaddr_in, and 0=2E=
0=2E0=2E0 matched any IPv6 entry=2E Skip entries of the<br>other family, as=
 addrlist_port_match() already does=2E<br><br>Change-Id: Ic3efcdb7bc4e60a81=
b9292adfe7f8e22b86e274a<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>---<br>M src/openvpn/socket_util=2Eh<br>1 file changed, 4 i=
nsertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/2215/2</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span=
>index a1a61af=2E=2Ee85f6fe 100644</span><br><span>--- a/src/openvpn/socket=
_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span=
>@@ -312,6 +312,10 @@</span><br><span>     const struct addrinfo *curele;</=
span><br><span>     for (curele =3D addrlist; curele; curele =3D curele-&gt=
;ai_next)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (a1-&gt;addr=2Esa=2Esa_family !=3D curele-&gt;ai_fa=
mily)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan>         switch (a1-&gt;addr=2Esa=2Esa_family)</span><br><span>        =
 {</span><br><span>             case AF_INET:</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail=
">change 2215</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
215?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2215 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--L68G5hWCTfU=--


--===============6351793453793565434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6351793453793565434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6351793453793565434==--

