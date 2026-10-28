Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBD606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iatt8QpN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aZ24Ezr2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DHuoOO/c;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VlI+4AHD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=48t1V0D4X9FvQoLjOTGESv2FuLCt1W6JiiAD0IwnJkk=; b=iatt8QpNeOCFnomPfu3jq7JBUB
	zbJLK+R1GInnKHggr/fDnTryvBJprEUCAZpJlWSYG/80bBmQgVF6TGLR6ylGx8IXXAWmj4XybW7Zq
	xbL13C+rRAb821oMGqvcTEXQr5uw+q5z3y5Unfsoicg1c4MO9B6g7cTesEy6SkNVMxEY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM2az-0000000053T-0FEm;
	Wed, 28 Oct 2026 12:17:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM2af-0000000053A-2SAt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BnG7ampxrKunBmfGQVSMWs8qwC4Ufi3XROLQjq0bV6k=; b=aZ24Ezr2qHdsIs2GrdV2ZV67HP
 wr0NhCgTa3p3wXoCIkZvd0Jx6laYsD37lolGwkrEvriT+2K7dqUh2qy+RbHDuQn5IqLfWwA+Huxa2
 /NGlhnj6n1BFWnKwiyOjIo/UyMGgaVJuw1bRA+g2CsjhYCaFGCkJOKZO6LgLHjoLaAZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BnG7ampxrKunBmfGQVSMWs8qwC4Ufi3XROLQjq0bV6k=; b=DHuoOO/ceJz1Nfn+NKs6tub+GX
 v1VwY74ksL60u73zL/44tJrBFPoi8KAQprQhl3MKdpGpWk479A242y4cFUms7DTXCFQEULsBKVXhy
 pN69uZNGLlbye2WXC1A6zASJuRRLlvWK9za0p+v4S18lZOgfQMPPn5kpVNY9hjoR9iHs=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM2aX-000000006Jz-44ji for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:17:08 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so10942245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 05:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793189819; x=1793794619; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BnG7ampxrKunBmfGQVSMWs8qwC4Ufi3XROLQjq0bV6k=;
 b=VlI+4AHDXIyO965btKj+5SQgC4jHzeHOBZA0AQQPgcYNfjFmK1pGqjE+M1BXRlYBFt
 CTbBGO8kGEZPydyFtF7LXkuXFxCyRsBLj77SSN27oCJyOKz++/smkUqfwIJ3bZsI9kom
 CPO80tVHN28jof394/hciMeHsQgsl8YkGAxXIR34c76MNroRGovkh+iBoIZ0IGr1MrNr
 IS/VPNHs3zc5vrJJzGPbNKj2Q19oU1j/Gc7y8B3qxa3rgwgJh8euAL0zBUS9cuhbpiPg
 aI+P4WD40oCkOEN4kCDH8FupDSsLOKDJ3VnnYROs0AEhUik4+heAcyfzVqkSQBBcaq7R
 9Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189819; x=1793794619;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BnG7ampxrKunBmfGQVSMWs8qwC4Ufi3XROLQjq0bV6k=;
 b=qvd1RW9JH/XaNePy2ygfErFIJ+a7eDDObypO38NKLRAxsI8GFNA7nqhvyRBiU9xyyO
 6L+EUTC1u7r+PcCmcweKoR0K4SrA+1MjkNsllnZzWwJAd6yISitzHrkMZiTuK+6ti74h
 4/tUZpuNBpyi03n3nalCPJVSrxyZ6lXWwL1FncZhbwi5HwcPI9MbWRSc4oJwBpd/3GDs
 oeDgNodDn1v09BIs1SukFyfruK9rT2ZtF3rSDZkZT1szbUFQH44s1iWgJgWjWO2n4E5c
 5/w7VTTxsfxk2y5pvqYHP8EYY+uq8kJ9rqgvj5orIua+8Gq8lXXENn+lyJImyWCFZpDw
 8V/g==
X-Gm-Message-State: AFq9FYIB8RhF0QkZhel9SI8vDPg6/CWJijMdR8RiXvq1qO6cWVoOeEz9
 3/LDeEdIBOhkgzX97/9Y/19Vvsk3wSUTxP/oRp0eP9niEwuGSdAK45Wb9tPdG7ZGutRCrZBlP//
 Aer3JyheMyMlFAcU479OhJZ2/pHt0KmS5v4Vb4+CW8ZIf6yp4GIB0KUp3mN6bTw8dXR6X
X-Gm-Gg: AYBFou20rtsFU9HJhLLesoMRuNCgapIAB0XPYgb8ckPwYUXJAcE1Sa2Deqx00GgbKHO
 9NRVuQaG1EKNE9olqiTEq7URERkIj4aXHvBv9gyt2xLKV93ouM25Q5oJtm6Pn+59/nGXU8EQxfM
 Tn628DWyIbdFNPRn+gCl7RTP6QEJRj2QkG9AcVZCSBFZjlDSh3M2ov96eS93k5PjXWyQCu49Xot
 nGyqODtZ60y1Vdqlz/fU+7aWxH0GSNtp6bdast1Cn5aYgGlxGafs7TwzW+syLEgB0GJGTYp5isd
 3aCrCuhqnWweuudZsV1zuHDUvnZPciC5gbhElAxUdsV6VUw/vFSfiPkT8SAyMn2YpITKziNVJ65
 RvZoH2K119ktWq9Rkb53bJaUdlcuvr7V65luitKb91y4lrGz3P7dQhjVUXjPhyLy19oKfktosbR
 zK4e3DBiRF/h/NfzTCUC2bGaqpoJPA0YRT7bLk1f8cgirYHYzovmhS389qB24Cf0niwgQIRXZIJ
 Vyg8OKl3NFo9pEUnfnDo7EXIwQjY5JKzwUkjnAK3XPSagcW22CDC3vIoU9pYPXGIGNmiQJrWsB6
 bfKSUN5uE292usjlj7CEW00dVflXbRuLGMeeHQlRFgBe/aou3c82ICVF63oLFP0VUbSGymfWvSg
 6EEMt3yT4NNc6IYx9Dk7I7QecShomUJBiiefpRx7wUxfP2MmYTNOqI5LkUn/kyGhyszq7Xg4Fxc
 iTu2oKhMll2K+S/+YBTbrH38apA6tTuNBLZ2rP2A==
X-Received: by 2002:a05:600c:8b72:b0:4a6:eca1:7d5c with SMTP id
 5b1f17b1804b1-4a9676d428amr44074075e9.32.1793189819147; 
 Wed, 28 Oct 2026 05:16:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f5311bdsm49940515e9.5.2026.10.28.05.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 05:16:58 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 12:16:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: 23c43e0e52e1fdc5a2da32e7453d977ab48a1d65
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f35df660a97a2f327370c89e3a4047c3329a124-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM2aX-000000006Jz-44ji
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1132048065000186570=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1132048065000186570==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qvAQdOLHa+E="; charset=UTF-8

--qvAQdOLHa+E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Pleas=
e visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail

t=
o look at the new patch set (#2)=2E

The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: Ma=
rk buffer invalid with username mismatch in server side float
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Mark buffer invalid with =
username mismatch in server side float

Commit d42a9912c1 introduced a chec=
k to ensure that also the username
is identical for floats and not only the=
 certificate=2E This check did
not mark the buffer as invalid in those case=
s like the certificate
check=2E

Reported-by: QiuYiati on https://github=2E=
com/OpenVPN/openvpn/issues/1137

GitHub: closes OpenVPN/openvpn#1137
Change=
-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
Signed-off-by: Arne Schwabe =
<arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 1 insertio=
n(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/58/2058/2

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/=
multi=2Ec
index e302a81=2E=2Ecaee3ff 100644
--- a/src/openvpn/multi=2Ec
+++=
 b/src/openvpn/multi=2Ec
@@ -3172,6 +3172,7 @@
         {
             msg(=
D_MULTI_LOW, "Disallow float/connect to an address taken by another client =
%s",
                 multi_instance_string(ex_mi, false, &gc));
+         =
   mi->context=2Ec2=2Ebuf=2Elen =3D 0;
             goto done;
         }
 =
    }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide5a3064=
e51d4a22f914e76c1d8165fdd4d005f4
Gerrit-Change-Number: 2058
Gerrit-PatchSet=
: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>

--qvAQdOLHa+E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Arne Sc=
hwabe <strong>uploaded patch set #2</strong> to this change=2E</p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Mark buffer invalid with us=
ername mismatch in server side float<br><br>Commit d42a9912c1 introduced a =
check to ensure that also the username<br>is identical for floats and not o=
nly the certificate=2E This check did<br>not mark the buffer as invalid in =
those cases like the certificate<br>check=2E<br><br>Reported-by: QiuYiati o=
n https://github=2Ecom/OpenVPN/openvpn/issues/1137<br><br>GitHub: closes Op=
enVPN/openvpn#1137<br>Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4<=
br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/o=
penvpn/multi=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/58/2058/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec</span><br><span>index e302a81=2E=2Ecaee3ff 100644</span><br><spa=
n>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</=
span><br><span>@@ -3172,6 +3172,7 @@</span><br><span>         {</span><br><=
span>             msg(D_MULTI_LOW, &quot;Disallow float/connect to an addre=
ss taken by another client %s&quot;,</span><br><span>                 multi=
_instance_string(ex_mi, false, &amp;gc));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</s=
pan><br><span>             goto done;</span><br><span>         }</span><br>=
<span>     }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2058?usp=3Demail">change 2058</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ide5a3064e51d4a22f=
914e76c1d8165fdd4d005f4 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2058 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body>=
</html>
--qvAQdOLHa+E=--


--===============1132048065000186570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1132048065000186570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1132048065000186570==--

