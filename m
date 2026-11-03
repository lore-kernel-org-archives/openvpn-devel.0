Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2E606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fbEpo83b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j047rB1o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VwLaPwqr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DF807V4c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mQeRmWU8/jffnaMcpRJPFRXT1UuVFl2tXYH+/JGSTMw=; b=fbEpo83b99XdvHQBRdEcJjaRUr
	V651LAt/0vBVbmsLWYL89zKzG2CyFezla0MQcbY80d8+QYUJNZKLqh50cmPv2BJRogIA51t859ojV
	KXk/f9/ELM5pajyUCSJd6af4U7UjgCIzrzgf/tlwH5Low+OVWhkK/McKJAqyiIli46Rg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKmS-000000001l0-0xib;
	Tue, 03 Nov 2026 20:06:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKmQ-000000001kn-49U3
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 20:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=97DWGnMzWG3yJJWPAq3qawWsyu3zYfoYINgAObBsdZc=; b=j047rB1oj/V7jv69fk2D7qIoNA
 pT8Jaq5DYCjG1rq/OqEVhN16Z7zLuaXX6uF3IVZcQxZK3Ty3vQL0FOfQDYSf6Vwq251Hr6UlwAtMp
 Id4wJokPTt40bzOdL508pldYsAdumQUFNxPt2+Qkdxaolsoq1XXqkaZebdtAOS9RoWlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=97DWGnMzWG3yJJWPAq3qawWsyu3zYfoYINgAObBsdZc=; b=VwLaPwqr69UhT1WO7uwnTCr+os
 onQegy+xCBRX8Y+SfchXnwq9u4p/KppWu6Y/ne61hRhehRHWtCRIz9wmKNG8XNt+mkVO26HssfalR
 4363T5n96sg6Gu8kSYpywl2QIFzQTnGOphIa2uBOj/NV8EFdIza0uvyKCK7OlmAakf04=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKmP-0000000076Q-2XQz for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 20:06:50 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2657785f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793736403; x=1794341203; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=97DWGnMzWG3yJJWPAq3qawWsyu3zYfoYINgAObBsdZc=;
 b=DF807V4cvZk3tarBWqGLkUUw0CWP5FtF0MdVJUNIqP4v0gHS0AtX4Gl0XztffljxqT
 mEAqWPHdQybrY6xfL/DT76T6GGvTB6QHNfxrrd+ibxVqNsj1rWNYCMrgPWBHi5h4DxYG
 leXFqH3mVSk4ZtItZBn/g/DT9K8RgTaUU0xj3ASOMVWcXQJXaWMgzDhl+CHu3EopoQgZ
 pVoBVadZMaL3gH1gMWFzQ4h+urvlHjYTg4VSHaeTAVjQIG0BF2t/AOqodzDDxSJe+ZHx
 smGVAky1kMSFyK2IWsRTg8IZYTdn2SHlPmB66/bYWumd6VHhuj0DFCur61s/saXD7QuK
 ek+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793736403; x=1794341203;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=97DWGnMzWG3yJJWPAq3qawWsyu3zYfoYINgAObBsdZc=;
 b=0Z9/s2bL3jdg6QzCWedW29h1/PXSfBeXJiGP2FnK99BGL0AvtkjmNA3O8xwbk8PZps
 S1DTIp4huuExXxj1V+7+j3m8Y1jedVBP+eTdFryoWI/xBqy77jnFx4iG3CssK9MGgtzZ
 vSqNLOsSbZxzXbKuAksRe1gE/8F3NYltyFm92Dl9EKvO5m5a/ZFBiVesrG8S3vElarcY
 L/IjKx3Y+Id4azFu9xblY7HQI9epyd48TM/wdq8m6EUs0s8O3CqE7qiiymnuDeEkiyJG
 uJVvzu57/XkWqsqBTKCRZCsYKCFVd751akkT0fy4lKZAocAxxgNCGFQvGKS6jOSuK6MG
 yihg==
X-Forwarded-Encrypted: i=1;
 AKwUvBym5fv5pjDzxrQVQyxhplzjXX8r80T3JEdUXcYrfxeZrOwBuDdHXO/u8PDwTXMRJhrVRu5bkc/v3kkGY30e@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/8jvFrDAVvLXCKS66MpGlSGtSQWWdRibw3mcIa5z0q4XZydKvk
 VckC9x/swW0shUXau9nz65BuM4ZvCrp5tC1vNPysu+xCo+JnRSJnUe8w+uD8uavi+qj9VNKzS5w
 pnAERRdkm0q5SELFie/QLzxMV68efDt1vzjftrIraoF+4tKKBlTELc95ENyDYK6faapKHUTJedM
 pwWanNCA==
X-Gm-Gg: AYBFou10CNEGjQQ7BN+euvfX0h3F+mGY88ksBXhpnuQHE/QjWsqwzdmcFKgxifMp1eJ
 lF4cp733/APBnu9S8pem1ZxHrw4iCAFe23ApSIsD9KXmgYzec7f1ILVi4S7ZUGQawgBJkLz1aq6
 4JpQUvfizZI4DDcsfIAghcFY3HB+dlnyOzhq2oCguwhZ2A9oWzg91UpTRyxbS+lEQpf2dqwUTeo
 xVKeDVBHKgVQtPDKONcS4EM8ZrqlxNXwEMZzC/sJOhpXmo50Oux6710dbtcSB0YYwJOhhWc5RpW
 hcLkByjH0RdAqmGyMpTWbMA55IKreeVIwJYhw6z+tfkFBCrKOnikX7Mx17gUvvoQS09e3rZKwTV
 xn0daVWFU5tn7OWdj8Z4dH4KzrQZ2mAeOPQHh0HTSd02xyxa4nwcR9R2pCLpPUJ8C6RsQGYWwF0
 403Voc+jItOYcljeyyToV+40DOoBLJ9QjzpmPePT+SjlGgBlLE1943qFl2v651Zl6H9DbBKSBVn
 KWETRsDkXbgIYtZptoXQXMnOEEgx+S9LdjaTOd05UYG+PA4xgovzNMabp5PTsrOiCWDOc9frnHL
 ycyqHD8lPIGnXO/KgM+5M4+pa5Lfvs5sLuMc2ZwWXOR2mBKsgTv+rY/wrFfAX+yyxiPHrpY52lh
 FtjLVoNpuhztquSaW1NQO5Vj8YVT1P2iQM69//A5Om4aDRWlORcOU2STX9lcVyi3lWDK1Vd4gQ7
 aZzIxWG3o9alGsiHw=
X-Received: by 2002:a05:6000:2501:b0:48d:fd4b:cdd6 with SMTP id
 ffacd0b85a97d-48e6e2ff708mr32638888f8f.25.1793736402855; 
 Tue, 03 Nov 2026 12:06:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcca7cfedsm351648f8f.38.2026.11.03.12.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:06:42 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 20:06:41 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: d6770048b77488747e40f67058e821c6ea13337f
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 20:06:41 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd468b93158964e253b65a6da5857fa9021d0b4b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKmP-0000000076Q-2XQz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8337855914385741061=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8337855914385741061==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vke2Xz3tOm4="; charset=UTF-8

--Vke2Xz3tOm4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-2

(2 comments)

=
File src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
991/comment/c8ad4698_1a71b5f2?usp=3Demail :
PS2, Line 211:     "--rps-off  =
     : Do not automatically enable Receive Packet Steering on DCO interface=
s=2E\n"
how about keeping the same format as --disable-dco? therefore --dis=
able-rps?
Otherwise we're going to mix and match all kind of negations=2E

=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/b439b16d_0881d2bc?=
usp=3Demail :
PS2, Line 4468:     else if (streq(p[0], "rps-off") && !p[1])=

and shouldn't the new option only live in the linux ifdef?



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3=
c94099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSet: 2
Gerrit-Owner: Ralf =
Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 03 Nov 2026 20:06:41 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Vke2Xz3tOm4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></=
p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1991/comment/c8ad4698_1a71b5f2?usp=3Demail">Patch Set #2=
, Line 211:</a> <code style=3D"font-family:monospace,monospace">    &quot;-=
-rps-off       : Do not automatically enable Receive Packet Steering on DCO=
 interfaces=2E\n&quot;</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">how about keeping the same format as --di=
sable-dco? therefore --disable-rps?<br>Otherwise we&#39;re going to mix and=
 match all kind of negations=2E</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1991/comment/b439b16d_0881d2bc?usp=3Demail">Patch Se=
t #2, Line 4468:</a> <code style=3D"font-family:monospace,monospace">    el=
se if (streq(p[0], &quot;rps-off&quot;) &amp;&amp; !p[1])</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">and sh=
ouldn&#39;t the new option only live in the linux ifdef?</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1991?usp=3Demail">change 1991</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1991 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Tue, 03 Nov 2026 20:06:41 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: Yes </div>

</body></html>
--Vke2Xz3tOm4=--


--===============8337855914385741061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8337855914385741061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8337855914385741061==--

