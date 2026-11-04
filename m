Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD66606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NdykAWPy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lbJ8MzvT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LhbYjZau;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bbar1eeU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fX6AaJONtVozkcffVr7IguWvj2Hf2n5fvAk8W808Ybw=; b=NdykAWPygnCMrbtctx1JipVeZY
	591ChJgcmZ87yWeKNfTo90330Vy54q1kGOUEQuok2HYUdMqrZ/Z+5nyq6KS07oWug8rTFkzzOjqEY
	nGZXU/RmughbkBIOk/laBgeUzAjye/AyKYN4Wv8PWAxrdGHTNtyp/P6HYO8e8N8Gy4sc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYdM-000000005a6-2mOH;
	Wed, 04 Nov 2026 10:54:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYdK-000000005Zr-3V3q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:54:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3oRYZragQ3o02Ox9uNgU2g6958GBuOnY45j4SEletnk=; b=lbJ8MzvTZDCduTIuoIWQiSEJkx
 O5LPH64PpNkvA1EJ7x3Q12Vi59AaXRtJeFfVaMBZKm2UvbE4NawdskPyRGDCDQ2MLJFKf0+r07keR
 abqiu0Q7LzLZS+oZxk2955pCD4awd1nuzf38jiWDHaKxjNe5wPLqLA/f2F20GDP1QYdY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3oRYZragQ3o02Ox9uNgU2g6958GBuOnY45j4SEletnk=; b=LhbYjZauOTO0NM4/ZErSy8FgWN
 f5k5Y4hW/VWycXG6cuL3sB/YC3k/358ry2IYU0DBhW4eH9ZEuV7LqoASKNsWo6vuFoMMQTZF+GdtT
 rnvzPtUF8mNnM8XrWCeYon5BicfXOFRputnDnJH/F7AmFsSH2aPS72o1y7YWWJDOJkCg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYdJ-000000008M5-3xqr for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:54:22 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so5648495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 02:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793789655; x=1794394455; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3oRYZragQ3o02Ox9uNgU2g6958GBuOnY45j4SEletnk=;
 b=Bbar1eeURprjcrjpjVMrUTiTMlFnpvfKxBg3h2VtF/IhLU+ts3iYPXuCo8K0z5Emie
 tYk7/5Df64Q0rWPOixhnPtRPfZyhgAGH2YSHKhexCQcJP5xltJiRhvAfwY9tOaIWEvfF
 ab43qlEZAS+moTs43DzlfiCcURbSafw31HE01jbkh4PjP+M/tcgJ13Yu+Wf4Jiz9RYH7
 KZXXwlvzfprlwkCmQSW7mHxFUYyjLqtmjhsYd1KQusrATLHlqRzE1r0P3oDs5HZN5zVA
 WmEekYSpJQfBJt92aqKohC3dkZHYtno2rNcd6o8Ao/yIMY7SsReH/obxT6uGgKjNF6N3
 AwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789655; x=1794394455;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3oRYZragQ3o02Ox9uNgU2g6958GBuOnY45j4SEletnk=;
 b=hP3O6esbq+dxBsqMjAGyajRK1CRJ9dqs2zXsrn7M9mI24ESLZ+qpKw4JDQ++KSqE/s
 6YyOtJyUO2aLWl7DIuplnaqjzdS7m7ejMUUq0k3WXALUjmW03Krhxps0H13Ig3xM6ooB
 xGHUXduGqsYNqkn8aQNQ6p38i7GnM/CnFvmLO9oRIbQWLozVULfwxEMVjrl7C2zDGzYX
 mmXPjmdWL9U2ldCJqC9d90jszG08FJkQv7BQ4s2eRFKSd/U6uPUJKJms3QulzSCSsriS
 NoxVyfz0FivPk/EjMQ/Xw5G2AuoAhDUWJ62qTyG5/QJP4bq+FwlODRDXhNYT+u0bRvuc
 2blQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu6B8rd0Fhk1YPsqTu+sSfknEjfulbmCvRkhFZxRnL4BdEofg5wLCKj01xhDS0sxxdTfJ5/+jBniBkJw5s@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+WZ1fi/45F9qAzNDJADvtp3dbzJELLm4TBc5i1F3mt7T25/lzv
 xYqxLiq4e98Eld0YiKcTXBJSXgCDWKoIgkFeJ0lXzNiRid3KrUIgiqu/A00M+Ae7KH3euwwd2jY
 bJm5lTlEbwsBKsk48dV+4UcxXZw5oIwnwFIiA1NUVw9fkaef9gbI1hFzmYDJhGFA9Q8zVRhqlx0
 WjW+koEw==
X-Gm-Gg: AYBFou1HOftAQGljZnWWnKN2rGFXtbqkGfHBD4y3EX/w6/xbgVLw9YnuIx1fhmyqwJ/
 qUzR4EzB/Bo7ms6ReRWrSiCOazlmIwPaJi2999zCNENPe7gJXAe9Wu38x47gr+PP1sz1Gnya+m1
 R0XgG/afHxYIH/5HwguxXCT+oguiJfpKoRHfUoHBBCFw6r9d0DoS+zg8VF6VdIBDO4OaN9QmCu7
 G2Qa2xvS1l/p1ft6ZhEVOsXHGYGTMyALRMeALD4CV87u6SuBlmE0GUF74J8oTAkyLPo7t3HiiPU
 mN7ll2hEXvGU4De9S1r+cW/sY7o9dz5ucQ4EFO12Wz207rvvvLg1FnAdksCPCue9C+zHXPPyKZp
 csWCDOlZiv0q6hZyHFZro+aHEys83hjz6krdFoFupH5XLq1dCZ2fhGH0LXV2xfPV2GFXkxeo1vz
 egM17+XfIv7WI8HaiqW4JjCB+aGnft0IP9a8rS1CYffkuAKx76SAk03h9zk1Ej2Zpwhhq7JMV58
 8aZp+ajS1AOoS0i7RHrjkJjUCcSRv6gxV3y/M7R0JxKkdAB2qwh/G9LinUQGQZI8jvjh53t+kfN
 zNKDEKQ7br/07AOSAwJ9NQtNneXhIN3lePoPXWa50BQ8C6CBTX37CEoz/W7m3YbxPG6t/oTgdCV
 ZbNPeKz1MFRHtTPgs5IU/3gidnNNz+r+UvQ0NHTfpIEnuZ07QHL1M/E1iZCK28roM+tFDOCVKwk
 b33YBwbMwmQPY6fA==
X-Received: by 2002:a05:600c:3510:b0:4a1:dec1:4e1 with SMTP id
 5b1f17b1804b1-4ac1765d674mr364340905e9.22.1793789655271; 
 Wed, 04 Nov 2026 02:54:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20521sm3106538f8f.53.2026.11.04.02.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:54:14 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 10:54:13 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
X-Gerrit-Change-Number: 2123
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2123?usp=email>
X-Gerrit-Commit: 851d474992c7c69b240fc166d87ad71fb17f8da5
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 10:54:13 +0000
In-Reply-To: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
References: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MzgwMDAwLkk4NzljZDBmZTliMWZhYmIzNTBlMWM0NTU4ODYzNDgwMDY0ZDQ1OTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4ca2de84c59345412c87323dcfe97c89ea6b708d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOYdJ-000000008M5-3xqr
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: remove
 unused max() and gc from BSD get_default_gateway()
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
Content-Type: multipart/mixed; boundary="===============1107255887056806258=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1107255887056806258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rbxq5c93XMg="; charset=UTF-8

--rbxq5c93XMg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=3Demail )

Change=
 subject: route: remove unused max() and gc from BSD get_default_gateway()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2123?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87=
9cd0fe9b1fabb350e1c4558863480064d45903
Gerrit-Change-Number: 2123
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Wed, 04 Nov 2026 10:54:13 +0000
Gerrit-HasComments: No
=
Gerrit-Has-Labels: Yes

--rbxq5c93XMg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=
=3Demail">change 2123</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2123?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2123 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 10:54:13 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--rbxq5c93XMg=--


--===============1107255887056806258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1107255887056806258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1107255887056806258==--

