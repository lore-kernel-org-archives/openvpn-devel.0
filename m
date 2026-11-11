Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E283606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CE9Ki0oX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=diA7VG2G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=diGxCgaJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=THPrQZtt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RZ0pFNu33kBJdBUVtz8pA10sxiS+NtgEf3YBPLYsXUg=; b=CE9Ki0oXyoPH505+dplSRoglzv
	M0LECq5irf6MiWWG6Z9pEKr0NDH9EVleZguTVvxab6EJmGvKROKMUGym51QzXsZJbvDRVUNpifbci
	ufHT8FpfDmtijrYssxdKPXxBobHF7h6cR6+Z062lEZYyfix6E4lguTL6WXtyABPbIGw4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRByQ-00000000821-2rwf;
	Wed, 11 Nov 2026 17:19:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRByP-0000000081c-1Q0G
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:19:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GLz85PtUTbwG4PrnWx166p2Nc7lvdfivncQlq2oxb4s=; b=diA7VG2GJqQZr/7sTzmPsbHfth
 bvzZRJ8hUDrTbvDsob3oIbjlSA5YE7Q9paRpfPhbCQ/y0MvRA4UDf50YLZBTu1fDiNq7y0EbbvzW+
 QTqt4QUbCA7TU94EXknTnWMRwdSpHbUW6aD7hwi4mq1l/l/49A+YpNvxCEH18hEFE6MY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GLz85PtUTbwG4PrnWx166p2Nc7lvdfivncQlq2oxb4s=; b=diGxCgaJEb33yoPq49iM/XqTzd
 q6mYghnZxhKsHj5J3ninpCbs25zyQaIfxQn3uIVb8mekAeCU0CVqGBoRoJIDrWRzGJAwV878tIQJs
 hcRW4sFI3+W2gj0x3zCF3iPbVJ4Jq1dbDGp7pO0y9meNTv7nhnM4p2gYVaz07GlpDxKk=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRByO-00000000620-13Qx for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:19:00 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so28955165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794417534; x=1795022334; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GLz85PtUTbwG4PrnWx166p2Nc7lvdfivncQlq2oxb4s=;
 b=THPrQZttuy258z/meWLVeNcs/z7myIj0OtL5+EHjPCIVlnfLFFXXPvqOJqp7Zmqi7i
 iYKmihEariJLluztqRuVAuQ/YavnW5DhtZcFbytEdauDRHdJnJ9LuEtXNgvQTf3Tov+K
 DWl0YCC6L8MryFlLz91hzXRYjm9fSRKSB+Z+rrgd/NYR+zH55SXOuWgDG/DUo6bs4vTA
 qTwNKb/muwCiuH0KOGTvMSBiPXMz6KCp1KRrh2PQAdeWY1eeE50VIBX+V25+q0cnXt+Z
 zlt88L7pH1vFMvc1Bx8ikMvPWa9eK7kGnKxpUsuA0VbDj6vj+PraYOzQ6CPeHV3bZumR
 gDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417534; x=1795022334;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GLz85PtUTbwG4PrnWx166p2Nc7lvdfivncQlq2oxb4s=;
 b=wV2md5ZPlp87Et6Hcqs43/BHJDyjmOsK1uLTGsA4V7c53nvCkI0hsPtbEOAciwvq3t
 GJUXooRmmldNpovx20ftyGN+O5mCBDwI0mZuXSywcsx+u2I+/G6UtvKjl3YwGGwknFCK
 bCqVGes1F5dsbn7TEKTJ0GqwnqMgeGw6lBFW7ORVflBn8HVOSXa0apW2/TEvBssIaQcg
 M9MGZl5f4njhkY8pG6yQKmX6Am7kIDQpv4lroQKsxXeAorzccErOVNknfE1BtKCqSFFj
 peguWOf9XcQEcPAZTXAjLBxbZa5G/CQ+ZBg4iuiY5JjJUIjUldPuvLXycmTRDc5Hoq+l
 1SlA==
X-Forwarded-Encrypted: i=1;
 AL+hErHLH5SKWHCrIrfsy5uPTJBdq5aTp3xNVyaG1tWtFKdhlbqkuooRcS1nfbLQD/F5VfUnwxMlqaadPV90LiGm@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MnKUSK7gcy4xR8ebJxLSULSNTNOwKU2rWy8atsFOJPIUFs2E7
 Cu5UgLnPxDYfkwYdjOUVMzb5qLaS5g3iTsbFOvmE7zmRlumfLjs+u7Z5cgHLZZUm+8E9BGWJFty
 JUWOvOj0kjGyInc/xqx6rEqNGUytgYIVTGf753N11VBwqouI+9VMxk0LXLw2YmHFTBxTthY7dqT
 Hid2yaig==
X-Gm-Gg: AYBFou24TcU2LnsoL339aC07e+IGP+RF31qbqnwX0ssk3GjRQOhAwz19uoMbIPDM2jT
 L0qYEhM7/dLWTaIkQHQCwQOO5mX4JFyMa3myKVB5ROy/LWw9/bkgHUwB7AibtZjqFw2AuN5WQoA
 T3N8T275ZhW+olVf41MF0WUeY7uynn5x/oLkrQC/pWAxbif/wzf4HAU1hYlp9jjsMRpx8msEOSB
 z4UnwoymCdHQS+audXvrMQXHa/zTbj7X7ghDNxzWsVcJfD2ZNKUZdUx0I9+YVe1RPkuPS4VrVI8
 fZbf0fXyn7DLbgroEO4YKNON68uqUVxkLgtBw7sjQ241stv22FvCtJm1vGQYbRLm3IFhJMgORaw
 42jZzpRBPlXrQqFGdlvrEii4D03oVGRkW4ryq+8XwAsJzRSLSYav2digJrZZFQ5xhV3DNK890Ya
 4c4nzlPxbb0Thk6ZgRorqWcP+6F07M9lp9BRIHlBlArLjIhUSDfeb2Qa1YrvQKluWX9+AtZ2YnE
 VTQ1JcMxKKwVFBQJLUmMe9yGEhXIn/kgtXTMYR1djjLap3MSOeP2CO9kIzwGKl40w22U+pevTeT
 ud7xJyrkMXeKAqC+VW4sWE4iea+WPJp3LOamSHm44FBeMRvNciyq0H6V9Y7GvD7JQmQeLUr9EbX
 +vbsQzPXayQ3xauZEYWTfzeij3P9t258bFl2pMpWtfiUSATwj9YD/CyBIrTGpVYoXy2EbItrDBk
 uuH9EAv9y2pEA17HY=
X-Received: by 2002:a05:600d:4121:b0:4ba:6d8:dfa8 with SMTP id
 5b1f17b1804b1-4ba09392a12mr50878825e9.33.1794417533446; 
 Wed, 11 Nov 2026 09:18:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba09517bc7sm49234025e9.3.2026.11.11.09.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:18:53 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 17:18:50 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 19f2ddf9de29e73f657ea877c51e3418c71ff33d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 17:18:50 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0fd84c002c282aab3566260a9b37921ef50e1ec8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRByO-00000000620-13Qx
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4231374115462302733=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4231374115462302733==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="z++xbmGOI58="; charset=UTF-8

--z++xbmGOI58=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 5:

(1 comment)

Patchset:

PS4: 
> Changing `packet_id_size()` and `tls_c=
rypt_buf_overhead()` to `unsigned int` adds warnings in caller [=E2=80=A6]
=
Yeah, I'm aware=2E I'm trying to collect some changes for review while also=
 not testing the whole code with -Wsign-conversion, yet=2E It is a trade-of=
f=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17=
ff80a5cb8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 5=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Wed, 11 Nov 2026 17:18:50 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>

--z++xbmGOI58=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2158?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Changing `packet_id_size()` and `tls_crypt_buf_overhead()` to `unsigned=
 int` adds warnings in caller [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah, I&#39;m aw=
are=2E I&#39;m trying to collect some changes for review while also not tes=
ting the whole code with -Wsign-conversion, yet=2E It is a trade-off=2E</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2158?usp=3Demail">change 2158</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d=
1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2158=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 20=
26 17:18:50 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>

</body></html>
--z++xbmGOI58=--


--===============4231374115462302733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4231374115462302733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4231374115462302733==--

