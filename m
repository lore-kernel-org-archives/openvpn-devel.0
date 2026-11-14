Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBB606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T8ZivVej;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MSCpdkPu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ckLQjdDA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QfWk8a6E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WwwGnaL0oGLYuSOfLt5OhN2aZje+13cmH3mOs74vuHI=; b=T8ZivVejqj1jSoRP8eceIooHxU
	u/xh68biWimDWf4kZfuFmcDgqTJyp5tC5Z9HumDBv9IZ3zUUxmTgxL+jqoGH3aPL+UtB6N2s5LY3Z
	r/CyvtINn6efBO1JD9Rxwfk0AAD9tcgsXJ6gaNgEIpkDhS98tlPmhsNGlKZ8O0P5XlzI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGN6-000000006ZI-3T4W;
	Sat, 14 Nov 2026 16:12:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGN5-000000006Z9-4Ats
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0TbgKSSkuDoiKRYweIldbpCi3dos+M11r0JYn2pGV9M=; b=MSCpdkPu1ftN45xFNkWDqZ4csU
 ipkGoiJLSVpI4Kjwr/L6b2mdT1XOtFjTdRu/ASzPbnqI56v84KFI+842GmBhNHUP4SzhXuwzmdv3m
 TdJA+xqK7d+mjNtCVk2b5rcskl9vkUVmJqxFosK3RXi4kdFp5YLOVmiJtYgK9qbYiWW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0TbgKSSkuDoiKRYweIldbpCi3dos+M11r0JYn2pGV9M=; b=ckLQjdDARu3QvET6s4x/x3UeYk
 aeHotrW4586Tog5FELC77qTum/Er5KM0Iykajh7jzi37vAQWkLKZTip32Qf4Ay0lT/Xh03ZzvDn3b
 LiA+bjR96tcsxQnpL5awb1wq6E/b70QAQ1fxTgjOwSU0NU2TNfbjyLphf9/1vdhCYiD4=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGN5-000000000sN-1Cwz for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:12:55 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso1549093f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672769; x=1795277569; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0TbgKSSkuDoiKRYweIldbpCi3dos+M11r0JYn2pGV9M=;
 b=QfWk8a6ElG9M7IEtzAAsL4YhO0UlZdUWmKQWcJewVXkWA39bzz8ced//CYf+K4rgj2
 E5oz7fEY9RKllKVCawe9rQ5QqiuEhC8I7w/40xkcCrH/f7DS06gsFmEjjqu9U65B3VtW
 +kTgD/b/Nms6fAYOePAYOlqFWP8XVWHRVtcMRESrCvR5ht2t3ZKxwpctjNfU6zBAWKXG
 siJd8cFdt4tpFfsjmCRgjQaax5+6xXcq1DMdLw/rOanOIrpqvpiDR3sIhcm/JQV5oMMk
 cKhEHo3adopraGN2zdk/Yh/Cit3tK926GgfkzXRcj0Y+jDHcYl0/o3rU5gsqoc2BRNXT
 xShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672769; x=1795277569;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0TbgKSSkuDoiKRYweIldbpCi3dos+M11r0JYn2pGV9M=;
 b=PqkTZXU765pRx6rBQJruqkrO/tX/HDBdkvxi1b6hDJetkdwIniEeI4ihYaxZjevxjd
 mvgDHvtxoVRVOzSDyuiaeDtWdbWZONiiQZzmEwoRZFtIqS86d7HajU+70yTEcmOOZDNp
 oP32WZt2IWD2ap+kQ9veawZ8120Fn88w2Fu26zm2XyIbGnxeFfCqGUzqfIQnREzjauSE
 RORoJTFC3JPW914wz6h8MMndeZycE2tQKcv5jkG2LMjlg1zdEI9tT5vopOsrCUpEdf+C
 TA2bAMAAhRdnxqNnqO/mt94YwV8UfVvXUec+WwqCgxzp/q75AI0MyIJ0CrkrthiiiHTL
 GHag==
X-Gm-Message-State: APuU4Z8A7/D7biGXl65Ki9dIUVueJKi0+SZIGODo6i/k17AwaKmDsQTB
 DrUIu1K8BVvI5PEYVzXIt1j8VYk6kFPr2qa/XOgT7U9rUtGpF4rrVhlDrP5Sandqy4XNSVyFHr9
 ylbjViu5F/GB758T2TTnKNH8ZzVTBenrn+bi/v5IhhxXF6liOmSPh6tMaBlvMaSSXeKk31CMfdn
 IfbrmWSw==
X-Gm-Gg: AYBFou1UMDZrW18zkIynS/bXC7pLT38Mm5B8o40LZ2HYtO4u5y6tY1vBfaBNkEQp3Mj
 fQKkBIyc6Y4lT6Fhew1BpKsBlm4BETuftilZ6hE+azopfjeDOs9GubyKSIfKO4p+9yOidn5cE/k
 drk35LukSkpoVgRWE6YCSqsq5z76v6I+lKS6vsAT9D6NLHKCNNlKfI9TQ3FraxXM9DXPXtlyhjF
 JOk4+GtGEzGVv2UILIitHdD/SqKUm3gqCVKb18UAEgr+dnAUpIKkhiwWIs96E4ZhP1R+1ArSrNf
 40eRGd3ayEoymxaNqKWhdvZCCIDZ0nAhJzavdutI1nbBfUXczcCpkxxK/keI7iHvbzn5b0JS7en
 7QvHMUXSoElLZA9LwjIoW6xHHlane6KF3XtCSzXLX4pvK0kBdlOBkEzRD4c7P/S9XZSK8oYFPcu
 9fRdTTm07EuHt4N9CwXiiPzq+LVmxgaAR1gyF3ZZR/ZuxsCehn09t5VBjquatv40U/QaLWbjhnz
 UwT9hc5oG+L8G6Xw8bGEwDMPHaorJpS7GEZOaVxL2NcWQSuDolPbG8BWweluYIzU/V02sX7e+Ou
 sR4gH4e8ePkh0Wf8RnUqxkrpfxgZnPHFGVwuGVg2RWAJuW03Z1c8dngF0L57m6fWqD7sC4RICIt
 QXA6HUGVGI9jgsWcRoYpKSIYk+Dfrnz/xSL0J79gShxWVGwTIon4ZwHNfBxY43kHhsUuRfYcR3m
 iK//rUD/5jBxs2x83GXtTKYwFemDbLG/H0PQjs
X-Received: by 2002:a05:6000:40ce:b0:48e:824:f0b9 with SMTP id
 ffacd0b85a97d-49c72ab084cmr13291560f8f.45.1794672768495; 
 Sat, 14 Nov 2026 08:12:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608d10b2sm19837692f8f.44.2026.11.14.08.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:12:48 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:12:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
X-Gerrit-Change-Number: 2116
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2116?usp=email>
X-Gerrit-Commit: e1d9286b69eb9c59b2926d1ff996b7af4d28d317
In-Reply-To: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
References: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2MjU2MDAwLkk0MjdiZDllZjhiNDkwM2NiYzEzODZkM2RjZWYxYjY4YTQ2MGI0NGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <357f549afc6e4759782dffa09f9369e7c98ea5e4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGN5-000000000sN-1Cwz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: fix
 "cr-response" typo in unsupported command error
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
Content-Type: multipart/mixed; boundary="===============5920378709569145194=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5920378709569145194==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MpvtjHYWURs="; charset=UTF-8

--MpvtjHYWURs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2116?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: manage: fix "cr-resp=
onse" typo in unsupported command error
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: fix "cr-response" typo in unsupported =
command error

Broken since caf1b903 ("Use a template for 'unsupported mana=
gement
commands' error")=2E

Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a46=
0b44c8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2116
Message-Id: <20261104122047=2E15606-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg40747=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 1 insertion(+), 1=
 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/16/2116/2

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec
index 1760c90=2E=2Eb8a0408 100644
--- a/src/openvpn/manage=2Ec
+++ b/s=
rc/openvpn/manage=2Ec
@@ -895,7 +895,7 @@
     }
     else
     {
-        =
man_command_unsupported("cr-repsonse");
+        man_command_unsupported("c=
r-response");
     }
 }
 #ifdef ENABLE_PKCS11

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
Ge=
rrit-Change-Number: 2116
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--MpvtjHYWURs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2116?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: fix &quot;cr-response&quot; typo in unsupported command error<b=
r><br>Broken since caf1b903 (&quot;Use a template for &#39;unsupported mana=
gement<br>commands&#39; error&quot;)=2E<br><br>Change-Id: I427bd9ef8b4903cb=
c1386d3dcef1b68a460b44c8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116<br>Message=
-Id: &lt;20261104122047=2E15606-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4074=
7=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/manage=2Ec<br>1 file changed, 1 insertion(+), 1 deleti=
on(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/16/2116/2</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2E=
c b/src/openvpn/manage=2Ec</span><br><span>index 1760c90=2E=2Eb8a0408 10064=
4</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/op=
envpn/manage=2Ec</span><br><span>@@ -895,7 +895,7 @@</span><br><span>     }=
</span><br><span>     else</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        man_command_unsupported(&quot;cr-repson=
se&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
an_command_unsupported(&quot;cr-response&quot;);</span><br><span>     }</sp=
an><br><span> }</span><br><span> #ifdef ENABLE_PKCS11</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=
=3Demail">change 2116</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2116?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2116 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--MpvtjHYWURs=--


--===============5920378709569145194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5920378709569145194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5920378709569145194==--

