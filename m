Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBB606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K6qBh5v/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DuExvvLK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IB3Usg2F;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AArz19ii
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k4MeInnlk2y6OOKNU7jLLueeMuPuPeRH3pw9Hj2SHmE=; b=K6qBh5v/vIZVPE2A9nHk1rZHhh
	jJ3Uma+i7owo6J3M+wH9JnpAJICslFMhWVrcwNIaNFH4uAgfIOCI14Dsumr88rzH8GBmlr44/vbyF
	OQ/kHcFtDiTZdnBcoJQ13OMsTbz99daivGDHzgW9L80L53FL1nt/LzVKSniPrbMAZBjo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUErG-000000004SO-0OhB;
	Fri, 20 Nov 2026 03:00:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUErE-000000004SG-0dOm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 03:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yY6pp55jVdXMpTUtXWaWZm2K2+U2RJEBoLnAMjn6eCI=; b=DuExvvLKzKw0PVNsSGazuNmiJD
 PqY3zl5D1Rt9dI1Q3mgSfPfi8cIQtP5UMbtuElgAC7nY6aLwI5ULuXgSJt+KWMScn8YnCRpFDfseP
 CKYIxCLKKqXeVK/6cvUEpMdlowgaKmHxPT8ba38j5BsXyw24Ma2swOYkTPk14IniaMJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yY6pp55jVdXMpTUtXWaWZm2K2+U2RJEBoLnAMjn6eCI=; b=IB3Usg2FjmqsW1Jm2i93Fwzwat
 IRiLSjcEvxU5Pcdiv4lvbKXSs9H/iCo2oCb0g4Piq4b8w5MBBZC9EAhjlMkLuri/9m/lcRmssKQFl
 erq2vmYeVjghc14kO0mrf/VuafcT0BcxBxrTnT9yWHQlIQcvVOtEvNbkJJJoB2QYov9E=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUErB-000000001cm-2qo9 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 03:00:12 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso4618055e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 19:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795143603; x=1795748403; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yY6pp55jVdXMpTUtXWaWZm2K2+U2RJEBoLnAMjn6eCI=;
 b=AArz19iiVmhFBZcK6gdd5kYYEIZOEGrNjg9f47pIHmb7pkqeipeskMbtRrwKMKnSL3
 slMunfO1afyHre1BsEA0L1KlqkcaRUlCe/76bLf1xUXA1iCJVB2YN5Vcmtkp9Bmm0FW6
 6mOjf2bvXTOk6q/sia3hYvT9ZKEK1br5ZPOCkSdkXFA8+2s2Es62Dyvs0R8kk1YEs+Hh
 QTeyoW0ZrjROAR9wxRRyrpL0xOBKmUy1Qidr0AjXPWeC8KDaDQh9b41g5zhU70GYqmFB
 jVtgtHtQNUOpD92DdF9F+94B+1PPFVz1fdQdKTi8dL03ACtbcsi6A3vl1A/RuHEBnGyk
 zQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795143603; x=1795748403;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yY6pp55jVdXMpTUtXWaWZm2K2+U2RJEBoLnAMjn6eCI=;
 b=jZHAKzN2egj6BKJOXWcORYWgBBQ/wQeLgGlw8JxLZDMNsyNh1DSiWlRGcnRzvfpcH/
 fzCJWCJkjc92Bu2/4CFj3lcWhZ6G9Y0z+fiCAE8omgJALWsGYtKcDdhjo0smuiB1si+k
 /YlmbavqAyuj/oTLV2qWqrIpYf5alvvX8q8vLVRu75vyjRGBBzjEj4TD7+QlJID5dpSa
 7ELdkUKH2+CyUkMYd39HmbHeKkSTr8bEX1Dd0jQXtvUA96JQ4KPKYSiQER4MhTmJiczB
 OEcybgXU0nPOsqev+BR3aI22+FKdFfOeoqRW9RvC8He7gLp+0MtYL5H80tcMn/h4phbH
 vsYg==
X-Forwarded-Encrypted: i=1;
 AL+hErGHv4iBdcOzUjA2FGNP4yGSQc2lxjP8U6A+wgPf6Pc8srxQ3EwGFGjYvFDOiLacyWg8I5sT7s2IhUPf9sR9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/p3pSgM2nSs+tUmffWnF0dE8et6eiWvbGeUMePrS8LZzdir6lz
 l1ynPK9x1Z0/t8ztj/nACTI4wtePrZbZKkN08fNOaGkMHfTd+zhZAfZDd9p1Vjqr/3Bbzyz7RRq
 AzGX0Fnsmdcxc1fQ5KTN0msp9kTlFt4tlQeq3CzbodAJtUkNLWa7N8YQRy8d9jo+Vn8JP
X-Gm-Gg: AYBFou3ZkvNfqzxZUfvA2NKBc0YErlru0uPI0TlAtpdDsYDlKaI/UlWt+msBhJeCNvv
 vaCREL2pHeFlodPSgBzzTB6V6kAGXna+qbXiXM5p8KL7IEUzp+lEaCgM4PijUYQlLG0Qc3X0exj
 iK50/IT3aVMqU2WNT+aptnAY2f1KvUGp4ZAxJkIEQkQyiHyfRCfMA0iye2EGZhj6dxiK4O1UuGE
 FfrOYXrovcGsWMC67l9a47bIZdJhV2cvP9RGrw+lZWL42TVXBi92qKOc9//CDapI8G3JCdbCJU/
 D8S5sLfLLTia9bvSLb6YoVOkTxrT/Pk1xZ8634IRi4DUzxJq6TF1C35ROfPGVQTmXSqqCwq0umr
 kld8aZiN+LMBhsoQxdVJHnXzLvM/FVteM1OAhkLPxp+3K347KaKdefdbmOQv6X6accWKYojUa9k
 PyObfMAyJPCR1AJw0UqRdKl2blK+K3lwgi9+gDDMNLRKWUyJCkr/n80Dlsb0796arovDjDm9Vhv
 HlXEI9EVzgIhn+3Mym+EN9io3LNZkCvjBErYZW1HcAaWSGNBlU0NxhZwXK6gc9l11N+d0rIPGAr
 KAG7N6U6/rRAgx+Ql+CULQ7ae/YHRD84R94Q0yR3sTYHaC1zh/u/1h4Z4l+HAPF1KNEyib//uwJ
 p5gfOfGlZfCqk2dNYT6672HpiWhsSTUesHb6VP1pLiq0+tokHlHA59yUgHDR4cgWzcmEeSRkLU1
 6sERwVNLzKz11Cssg=
X-Received: by 2002:a05:600c:1911:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4bb8880a584mr32882585e9.13.1795143602943; 
 Thu, 19 Nov 2026 19:00:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm84468815e9.14.2026.11.19.19.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:00:02 -0800 (PST)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 03:00:01 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: dda90ce314178fc7e85df6a52ef4842fe1911b6a
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 03:00:01 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <13797395b48d972eeab53ebb9620f165ec4b097e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUErB-000000001cm-2qo9
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7202154487140679684=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7202154487140679684==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wG6fOC9xld8="; charset=UTF-8

--wG6fOC9xld8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici=2E

chugly has posted comments on this change by Lev St=
ipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail )

=
Change subject: control_msg: Add P_CONTROL_V2 and the probe request and rep=
ly TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 28: Code-Review+1

My earlier comments are all addressed=2E Built it=
 and ran the unit tests, all pass=2E Looks good to me=2E


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be3694373=
88268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 28
Gerrit-Owner: Lev Stip=
akov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: chugly <charlie=2Evigu=
e@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attentio=
n: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Fri, 20 Nov 2026 03:00:01 +0000
Gerrit-Has=
Comments: No
Gerrit-Has-Labels: Yes

--wG6fOC9xld8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici=2E </p>
<p>chugly has posted comments on this change by Lev Stipakov=2E=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">My earlier comments are all addressed=2E Built it and ran the unit tes=
ts, all pass=2E Looks good to me=2E</p><p>Patch set 28:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><ul style=3D=
"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c56=
03d622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 28 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Fri, 20 Nov 2026 03:00:01 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--wG6fOC9xld8=--


--===============7202154487140679684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7202154487140679684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7202154487140679684==--

