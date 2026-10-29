Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E253C606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Omws5C/t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FAf7Dzqp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O7+rjQsD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MCETNUUj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0ABbTzbB01CjmFjEwgZNaWyZcIepR+FRGt1XWd1IF3c=; b=Omws5C/t8YGio1S1Y/uNMNT5ia
	0SvTkoVtv6k2+FJ16usnLH4/XylXMmqoBiOeaQOlLA1lIqAr8a5M6z0x6lc1w90Ui3FKult9ri0T8
	3VO2OEUW2PHCNiYbHSKkBIbwj9v24dS9dZD1xe7SaUvkhfIjYFItvTFRvkJl3zr91rsw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTjF-000000001Ti-0CVj;
	Thu, 29 Oct 2026 17:15:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTjD-000000001Tc-3K3n
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:15:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9wZ0eNS9PSbOXpEP8RtMD2XkGpWz5yi0eGA9W0p88Y=; b=FAf7DzqpPYzQLLs+Te4CPOx7ap
 PNKjaDLQTGRA/CLttxTRib4CCSlR2W9mL0x9Areod71Q0MnavphNA5sfyWerrVWG674qDXVRxobEX
 68RKVj8/YhxpAkujvW/AciN1ivHkS+lyu7XKny0W07NfLXf/DGtY9cFsNi/pOX1QyL1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9wZ0eNS9PSbOXpEP8RtMD2XkGpWz5yi0eGA9W0p88Y=; b=O7+rjQsD11G1SqKCdhyAcfNQps
 mrsOAlWJz95sVcE8x8vMGSIT+n4TT6cHRAKXwxeHd85U6KM2ZP1RMmscJuWlFd4LX13EDDeZpQcEH
 tQtDKIiB0BxikQZQeb9NioEOkN2vybx0D/kB3UcJ3jqJzAPXtKhL8nxbJVIeoPh+vN78=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTj8-000000000nL-3KsV for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:15:51 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1640165f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793294140; x=1793898940; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S9wZ0eNS9PSbOXpEP8RtMD2XkGpWz5yi0eGA9W0p88Y=;
 b=MCETNUUjmf8uyE7RQEJ6Z6MdWAw1et3VESZ/FEsg6uAlxrVjWGggnnyAD3umST3UUj
 ua5e9y23m1v9Rl1BF8DXePOLpr1/aTSTM12t9tLQhsz6xbRecB1nJeSfYmMP59Mzn9B8
 sFUeGLafIomHommuLBemSjWQ44mCAuFyYZcQryxJ4YrHOmOWoR7jMVTV0MlE3wDv+lbA
 5ehKYpznU57NPwZaJ3MWfM/Z7ye+3SlGLJ8DiYjgdmC3gr9/oRPBl87Wtv1mJi2Fi056
 ecmJ0vfhZ1R8xlihMW0vPj/Q4aQ8ukTuxGIZQSeSj31FTvgNI8H44b1mRg0g0w2zmfWI
 M2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294140; x=1793898940;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S9wZ0eNS9PSbOXpEP8RtMD2XkGpWz5yi0eGA9W0p88Y=;
 b=em+DRUfys+5kmHFSd7IF+SXV0bCmmYHupumeJdvEsvX/o1bZCA1NvcJoiGgFMUpRcn
 g5Pp/R+4lbyWGj6LeJiObNlcVmt9caM8h2KJAVw7IFK6Qb3FyD55PP/4seNvHcntpDuP
 mk2DtiFjnmYSUoHfDmRiN0G1Wt9V/GcQ1dEvAA2a9KGUVxOu/oq8fiFgu6gguAltFCll
 JgygaK9GzdKVSKolAzVfCMZMfdGR3SlcSWbXDi6cm9uFr38iuU+gw5zqYaQRYo8uwtwE
 JLX2XRuBI7gxx3hsFWxOvVwIqjzDr3yuSZcul8eD02x7n/1qqZ4Q737xmjL4Nu2IuKTl
 MAxQ==
X-Gm-Message-State: AFq9FYJsDBtZ2iPm7cVqGDu7mH/gESVc0NqrQseVBxxSLNXPY4QVy0mp
 WHj3OPcAQdCM43n3Pra6szGep8saRSMBaDhL63WPZ1zSG/ULc7lXjoR4pwSEJnB/rjFOuBIC5ES
 KCxdERzK3vNyvkm3Q/IWRqbBu5L1IIIIkjvuGCpWzjdwwTEj2VfH+e55tIT+CXg2srSWsEHHw6F
 w6kt6pyA==
X-Gm-Gg: AYBFou2oa/hlB/6TVtRETnfxQxSTrY+m5MZfStepWUhvNVXcieF/cHjRc42MuZJHRJT
 PVEOAHhz2gLv0cdtscPfewB9RuKdWLfImdMvo/bd1xcNVIhq8FY0eFg1CPbjBtxHn9woMi3Xppm
 WgQNgY4QqiSlFeIxya/LHI2s51gtlbUjSVcwqJaGp9V/Ii1BR8NmGqsv0nEESAPwpF7L31ke29b
 SDTDVLeKHJ4gILSjJ2KziW82a4o5TAKxfdFJhXPCVz6n4ybcJw+5HR6QZclQvJpmAQ+kJqsdCBb
 8Cftm1/yl2NxuYO8/AmOC9mZrtikYDGsAkLDZHjlzaFWV/QbcRE8e0lw3Ha9OzxX2SQGP0hvZRX
 f5+5jkkLbbc+t2V1+6blPuDIYNLY3+ZTaCgx1IvEy+81CqUkC22pBxfaun5VQV2WoxWyAfPYDqu
 Tcdq6u3VOEQ7fVHKnBqGPyNc3fJF0tijV7ZAzHwEAXibl04HlU1FKZ047aSfoixowbGPebTn/tX
 VQq0/ioioOftaIOXJrt90PZYYbRFPcM7EpEC+21mvOTUsjyvxbRM+LmE0rjqqSg9ED5+6F8bngt
 oXuy+eeT1XgdNSom5TiFr2vpjSufkXmLqZnqNPB+iqA+VBcI5zUj19Xd0w4kfjGvt9LayHGmloQ
 vcXo/cQuiCbSM5klMaLBqvqNiC5gqnH07zkSK4r+NyKiUMAIWfZwZ1eIXGFWW03H2//diVm7XT4
 Z+6LoqdaggdL5mdDwV
X-Received: by 2002:a05:600c:609a:b0:4a2:9cda:57cb with SMTP id
 5b1f17b1804b1-4a963ffb29amr128541705e9.1.1793294139962; 
 Thu, 29 Oct 2026 10:15:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm2791755e9.1.2026.10.29.10.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:15:39 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:15:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: dc13e66916ad88e447dcf317327bffee66495dc7
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d42cd6745f0f4545fc1b433f7669002c0c1ec038-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMTj8-000000000nL-3KsV
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
Content-Type: multipart/mixed; boundary="===============1292287449830103272=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1292287449830103272==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bIihWoNazrw="; charset=UTF-8

--bIihWoNazrw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello R=C4=83zvan Co=
jocaru, 

I'd like you to reexamine a change=2E Please visit

    https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail

to look at the new patc=
h set (#4)=2E

The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E


Change subject: Mark buffer invalid with username =
mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Mark buffer invalid with username mismatch in server side =
float

Commit d42a9912c1 introduced a check to ensure that also the usernam=
e
is identical for floats and not only the certificate=2E This check did
no=
t mark the buffer as invalid in those cases like the certificate
check=2E

=
Reported-by: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/issues/1137

=
GitHub: closes OpenVPN/openvpn#1137
Change-Id: Ide5a3064e51d4a22f914e76c1d8=
165fdd4d005f4
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/op=
envpn/multi=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2058/4

diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 79e6bae=2E=2E0553=
05d 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3169=
,6 +3169,7 @@
         {
             msg(D_MULTI_LOW, "Disallow float/conn=
ect to an address taken by another client %s",
                 multi_insta=
nce_string(ex_mi, false, &gc));
+            mi->context=2Ec2=2Ebuf=2Elen =
=3D 0;
             goto done;
         }
     }

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4=

Gerrit-Change-Number: 2058
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--bIihWoNazrw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Arne Schwabe <strong>uploaded=
 patch set #4</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Change</a></p><p>The chang=
e is no longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</=
p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">Mark buffer invalid with username mismatch in server side f=
loat<br><br>Commit d42a9912c1 introduced a check to ensure that also the us=
ername<br>is identical for floats and not only the certificate=2E This chec=
k did<br>not mark the buffer as invalid in those cases like the certificate=
<br>check=2E<br><br>Reported-by: QiuYiati on https://github=2Ecom/OpenVPN/o=
penvpn/issues/1137<br><br>GitHub: closes OpenVPN/openvpn#1137<br>Change-Id:=
 Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4<br>Signed-off-by: Arne Schwabe &=
lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file chang=
ed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2058/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index=
 79e6bae=2E=2E055305d 100644</span><br><span>--- a/src/openvpn/multi=2Ec</s=
pan><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3169,6 +3169,=
7 @@</span><br><span>         {</span><br><span>             msg(D_MULTI_LO=
W, &quot;Disallow float/connect to an address taken by another client %s&qu=
ot;,</span><br><span>                 multi_instance_string(ex_mi, false, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>             goto =
done;</span><br><span>         }</span><br><span>     }</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?u=
sp=3Demail">change 2058</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2058?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2058 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>

</body></html>
--bIihWoNazrw=--


--===============1292287449830103272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1292287449830103272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1292287449830103272==--

