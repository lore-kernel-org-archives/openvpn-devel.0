Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D3606A326
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A8N6URa1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X7EogKQk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PveBveyC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=N3p2T13g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=QlJHrG8arlO0+FNoFi1g/420goC6Kx9gV6WDzcXuRCI=; b=A8N6URa10E+xmHmF/TgFpsttvH
	zXKe7KmYZVQVQUfyPqsVZdEd+V/78WpoddGsIGyC401OmhoCp5hYGfUU+fet3takweP9kNV4/UXKB
	a3h2W/nsrb1bkoYYBhRr0VqRbf/kd88qgI5y6yb2nTPdaros8rE+aGNqQ6m146QNxxNk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQhrW-000000007Sr-45Du;
	Tue, 10 Nov 2026 09:09:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQhrV-000000007Qs-35Os
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1rcX14RPyQ0rvqKT/87oyZ53wSoMYtahVwYHulmmMbA=; b=X7EogKQkc43tXSBS4DgADaW5rs
 Zo3JZlXzI9ALyL6oEnddDcjCS1PfaGpC9WNVHgviveMEwHnsl/kSHLd2cgHU5aJPwcra1acexDyNH
 Q4SnY/wBORk6wco5TpS+6E8q9Fviy1LoQZsHx0/gVYTcHkNo1ZqzNVntVdPa9B4p0jSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1rcX14RPyQ0rvqKT/87oyZ53wSoMYtahVwYHulmmMbA=; b=PveBveyCs8pI1//Ct9d/R2f1UB
 a6qiwePpVYISg03gdHHQJ2YXmcixQUfJM+r9zlb01B/Z8mpJHrqQSnlKOxNtUVxhKJ5gel7kAbz7y
 MxNNYgWwG+bTcgI3JHih+OXfbi0fuNrSVFybZz3YL31OSLVWGotgJ61iRij7i91yuOwI=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQhrT-000000000of-4BBs for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:09:53 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so137106f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794301785; x=1794906585; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1rcX14RPyQ0rvqKT/87oyZ53wSoMYtahVwYHulmmMbA=;
 b=N3p2T13gJ242PQDQdLeHL3XUgds059F/rV/ZSu7CNjMtjUB6rfwXYA4EBe29wCbNGc
 vARYOzDfqWdY+kC2jgeVMSODRqPm1L/GA9ezxmPABahD1F1AfhsnRD8M3ae2WomZoFoy
 tWJ53kJsMS3Nn3R7h7ie5V326pyd+Pwd4FFJO4FC+t63Dfz5QyoScBmJBnSxZI8yIzsS
 OxYe9CQ2+Ig107DIy02oP0oGh6+0/GIcABTP8VxgR9RUhrbQq/uFNWpY2076YzcmzGsT
 wyMJ8TjJtnd2fz+RSLANcNdVJCfQB7Jg4j9G+2Wemyp5MIU+DUakPCLZit5E+SCvHpXA
 zfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794301785; x=1794906585;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1rcX14RPyQ0rvqKT/87oyZ53wSoMYtahVwYHulmmMbA=;
 b=faq+rYsdRUZKjCAAxgky3fvEemS3kEbH1/jmrtWDztdVTvvB8KGBMdotH8Z3Hltbd/
 9BK0R5Rj/RNNKFU74/T9mhmOWwzll/U+2McRj5JfpXJYzIUDjnOc4i6dIh+brE6IYJz9
 odswlxaQIekPuHQKF/h/hYLYurOv5HqFLEUCMZgp5sui2osuW71sREyKE8ZoJXnKHDfL
 x+U637WzX7mgSCxFKfjb9vk0oP1cPH3u704KrvoB0j4NiwUejywRUF3kCvRmfJ3zBfF/
 RlnZEi1/wBZsRSI5yFHk5UDvJkg8uVzHf/qSMiYp1aRDR2a61bxuz4x5C5M1SoOYHrki
 2RZw==
X-Gm-Message-State: APuU4Z90HivZt0K6Hd+2fdYK5sBo/KBZZhxhsBBgQ3dn/1AC6nopVaZx
 qCfW5NC+Ov+qfqlBAeUDQA2iu+rBlqPDrqAN3Boy4NWzUjRkl3llCo9QiuJdZH2lfoNU96ui6FH
 8F9qxa+5fHR+mtAUCyyPkR+TyJJnIsmWzybgMSm1/0EENwzrfb5QCxWJpoW8n5A7EhmewsFmW5z
 /3L7/duA==
X-Gm-Gg: AYBFou3UFeJvb4x+wA7d+2Q1qsLrLJHWrMU4t00tngdMnO/LhkUxcdzvPouPUmPlxqj
 Nx9NCmQvyVZ1Wh5TXlTuaC5dZLXdM/WcYf5IUuYwkbmf9FEzgkCxJgtSvFQAOIHJrn7gjP6wzBX
 B+vpGBRIz14DdAXMuXW2DA5UQKxWskC+dugPu5In3E/8ctYtoo+qxZ3PiC5i/KolVvTtIPxh25d
 QsneC4HEQAyWOKA6wevFRYSyVo6hCKpjB3EwO1wsxUwPcS7TGFHRHv4wep/vJ2zJ6BXJImHyP0w
 nfcmLe41fb/3IfOCEB8+p3UBvdfmpxObeLkLp2/3YUH7hkUIV9DbPBU7yXS0kZOyoNpCcdtdgD7
 ZT4HV6Lv1qmjtgpVv53XVZNl98VvRTmXTNFFjSbyP7uO6zieqAMIBkwuXtaMNG8T3NlaHLMqpwF
 VHFAIedZV/9ivBmWygojFe24xUizCajVtWTfPUKNdmISj5ukzOUVxmGNIZbpyyO7YZltEp6ImSM
 f5BFbsdzAKFzC150k2Rmf+/A3MdlLO3iFQEakdv6cS7WtmbeO4dJDDjtiWGyLNop7dq0m1+9UUX
 BYoo8Nh0bt3CHFte/rlEv+4GP3cjKbumluc/fgexRMNw2eqk/c5wlIS/SJK2Ckmnn08T4ab0JiU
 EirZdo3FgWMqol+/PGRpKyUkcBqHREXrE3c6tuRqB3AfVWREfmwEqhBG77+HiN7WXPGvO0AqDnC
 VOzHtaI4ZWVxRfJc4=
X-Received: by 2002:a05:6000:2204:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-49827de78dcmr4329306f8f.0.1794301785206; 
 Tue, 10 Nov 2026 01:09:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365ccbccsm3806647f8f.44.2026.11.10.01.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 01:09:44 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 09:09:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 092ca65bdb0605e88656d822621a8ceb3b5eb15d
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5243c8df257ba8fa33591381726bbd44255990b0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQhrT-000000000of-4BBs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: only
 remove search domains that were added
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3183672179043462604=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3183672179043462604==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t+VT+ft7GXM="; charset=UTF-8

--t+VT+ft7GXM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2161?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: only remove search domains that were added
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: =
only remove search domains that were added

When AddDnsSearchDomains() fail=
ed, SetDnsSearchDomains() still called
RemoveDnsSearchDomains() with the ne=
w domains, which removes matching
domains already in the search list, e=2Eg=
=2E ones configured before the
VPN connected=2E Only remove them if they we=
re added and recording the
undo data failed=2E

Broken since ae90cbad ("dns=
: support multiple domains without DHCP")=2E

Change-Id: I7ffae4da3b2952184=
4a31d234fe6a9dd08954cf4
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 6 insertions(+), =
3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/61/2161/1

diff --git a/src/openvpnserv/interactive=2Ec b/src/ope=
nvpnserv/interactive=2Ec
index 81205d6=2E=2E4575b93 100644
--- a/src/openvp=
nserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -1823,10 +18=
23,13 @@
         strncpy_s(undo_data->itf_name, sizeof(undo_data->itf_name=
), itf_name, _TRUNCATE);
         undo_data->domains =3D wide_domains;
 
- =
       if (AddDnsSearchDomains(list_key, have_list, wide_domains) =3D=3D FA=
LSE
-            || AddListItem(&(*lists)[undo_domains], undo_data) !=3D NO=
_ERROR)
+        const BOOL added =3D AddDnsSearchDomains(list_key, have_li=
st, wide_domains);
+        if (!added || AddListItem(&(*lists)[undo_domain=
s], undo_data) !=3D NO_ERROR)
         {
-            RemoveDnsSearchDomain=
s(list_key, wide_domains);
+            if (added)
+            {
+        =
        RemoveDnsSearchDomains(list_key, wide_domains);
+            }
    =
         free(wide_domains);
             free(undo_data);
             und=
o_data =3D NULL;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2161?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I7ffae4da3b29521844a31d234fe6a9dd08954cf4
Gerrit-Change-Number: 2161
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>

--t+VT+ft7GXM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: only remove search domains that were added=
<br><br>When AddDnsSearchDomains() failed, SetDnsSearchDomains() still call=
ed<br>RemoveDnsSearchDomains() with the new domains, which removes matching=
<br>domains already in the search list, e=2Eg=2E ones configured before the=
<br>VPN connected=2E Only remove them if they were added and recording the<=
br>undo data failed=2E<br><br>Broken since ae90cbad (&quot;dns: support mul=
tiple domains without DHCP&quot;)=2E<br><br>Change-Id: I7ffae4da3b29521844a=
31d234fe6a9dd08954cf4<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 6=
 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/2161/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>index 81205d6=2E=2E4575b93 100644</span><br><span>--- a/src/op=
envpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=
=2Ec</span><br><span>@@ -1823,10 +1823,13 @@</span><br><span>         strnc=
py_s(undo_data-&gt;itf_name, sizeof(undo_data-&gt;itf_name), itf_name, _TRU=
NCATE);</span><br><span>         undo_data-&gt;domains =3D wide_domains;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (AddDnsSearchDomains(list_key, have_list, wide_domains) =3D=3D FALSE</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || AddListI=
tem(&amp;(*lists)[undo_domains], undo_data) !=3D NO_ERROR)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const BOOL added =3D AddDnsS=
earchDomains(list_key, have_list, wide_domains);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!added || AddListItem(&amp;(*lists=
)[undo_domains], undo_data) !=3D NO_ERROR)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            RemoveDnsSearch=
Domains(list_key, wide_domains);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (added)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                RemoveDnsSearchDomains(list_key, wide_domains);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span>             free(wide_domains);</span><br><span>             free=
(undo_data);</span><br><span>             undo_data =3D NULL;</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2161?usp=3Demail">change 2161</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2161?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newc=
hange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 2161 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--t+VT+ft7GXM=--


--===============3183672179043462604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3183672179043462604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3183672179043462604==--

