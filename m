Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74A606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jkjVw7Hu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XKWN8A+W;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WHDD+qU/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FbvaEY2W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BzLtNq3fPGelJnYGwMJOfccp+XOU8Yq2irPWDFHF8g8=; b=jkjVw7HugRT20MxtOhTk21K/Bl
	oMJBbU+SduKYYqIC7cjVqXRWbDWA5yxzUPMBTf4JN5rh97kTqowMZWaSAl/TnOThe6ffYsvJIGjKQ
	6s5S5mz+ZWC9Amvsa1iFMsmlM67KhyD90yju049NAOkPVLAbWtrivOsJzgbbuCXAiRts=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGN7-000000003eT-2Pqm;
	Sat, 14 Nov 2026 16:12:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGN6-000000003eN-30Eh
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2410MvSmGT7AVwzd7YR4WzAyFRcGz3t9guKizvT4reQ=; b=XKWN8A+WCtLCp9MJ1Wu3GF3sie
 zEJtnW3s8+FcYga8bQMrE8KbRgTyBoynpXBpfotVHPw348HmJ4gpOkmc7v6+bbuw4EgAnPua92ayn
 To+/KgLFAnwW/7lPMZwt3Ca8kGC9AqKXcdbNnINSicOKsQtuoabwxXKnR9UOYaFRk5Dc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2410MvSmGT7AVwzd7YR4WzAyFRcGz3t9guKizvT4reQ=; b=WHDD+qU/HgatHLsMPJNnKQ9zem
 ZSLITv81KAC++rXnKiMOua/vkMd7N3u2FZSJjxDmbaapDI06IH+ui+gu43PTWReglLwzBMbJpewJr
 DvkAt+a/PCtE/mb/ttcwR6OV5GfvRCHCW+HqJVr5uCJbqyD4VRWyjD5nESeKD9PJ/6Bg=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGN6-000000001Zm-0CRe for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:12:56 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso1549096f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672769; x=1795277569; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2410MvSmGT7AVwzd7YR4WzAyFRcGz3t9guKizvT4reQ=;
 b=FbvaEY2WmJCLXeBK5yWTSAhmleZjM0veFc2/Dsby1LnKiBonpeTjPBHJ2/6h89XE5b
 y3vh2FtK6RrxJ2k9MVF2XpNQVLr61Y55zQZ1QszgZBGGlswW+rr+k4Wy4ZWOnvJI7xPH
 35qrcd9yKJDgt8cf4oQkFmNsHsTKcWdPSqH6AIThMujUeNu1oVLSR4PMPBJsYm8ZVZG4
 M5y2gdM68SWj07iGBq6Dcd5AyAelFltEmFTWaDpRY7ue9kSmoaVbVlGeuIZJDQlnrMip
 FVx+M7T2EIGRuoWRTUeZbJSl1f4g3WbkTvG3G6ce0w8BxxjJEG+8HPYZDWCj5KgKMLi6
 Eo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672769; x=1795277569;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2410MvSmGT7AVwzd7YR4WzAyFRcGz3t9guKizvT4reQ=;
 b=ggh7wpMw9d5fLTSI2qPrNTDzqwNSfH13dakJ/BLE6nKPwJuGTIt4Ie2Q6CasJf9L+O
 BqEaJ2KsIYRyGNs8BSb5Ciy+9+hHbw+nrCfdvJTtMIeBjJk5H88v4Ld+njwYsXu5XOTV
 JIIjgrSNiPEba9vXNNWhYjRkXlx60PnDMNQyXBi9x5LjFimFCEZ0gcZJUa4dUVKTRh8B
 bSYPdUc/xOWw9CLkVOi1/2gmhnuzWVNBx8jBN/a8vIDfQi2Rf8SwgIoVrE2zYN6shZ+T
 GgUhaw1dblwMF/dN2Wv3uWNg2rtz6wcrLu1c3MS1W5+WFuIhwWosb5sSkkB+FmCd46lx
 n/DA==
X-Forwarded-Encrypted: i=1;
 AL+hErFZPeSZ+bXh9HgVheRmJzC2L96GZMt2zSmDPqqv1FvbpowbNa5HQjNSc0p3Ddvy0+G4aLjiQpDzk8XF6x33@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8dVTELLQJfovup90z1Wd1T2Y0SYvPcWkBPwLuQyHIcj/mi20dL
 thNZKC9TN4W946QYsZAG167hjVGXX8eecAAKsHUxdFkT8oZFr3SKjzyheAldzWq15ihGjOrpCPo
 DymlUU3GE41+Kr8+gA1MYIQDumjUuohGHAh7nu8ljLmPH9P1en9R8Gw8A97lTMiYo4Cs9
X-Gm-Gg: AYBFou3d+L0WEfkxAL88pOmHuqqJPOt4/sYLLXn/blofz6pM+PQwk5HjFENdPmlaB0K
 bWp6F0o6I6CQzv8Hw9FPmKgkzo101CMvfnShk61ha723lWUJ434L9hlThRzhWFpjtTcO/xReQ6t
 yep7Rqjl5xH45FgoikiKWxAsGDRj3OStpuzUmuofcbnuleDhcJLq9dSRzNe/kNJhDp2yVecPMtZ
 HXV7TNxaVkK4AyJido6lmtdK6JjuveGyxP9ZQG2MH7EQFS7BEbYLiC/4/nwfw8NyeLRsQW6gItW
 bN2gQFxHt1IeNv7kd0WTVPTrdhDQ4gQ3dFNKu4z4v3lFDL2DkJOtqx2aYirCdYAzRqAXngcjemB
 8Whx4StYBpfL6xKQBli4V6GqT9OTSdT/nenavQz5cjo2rOIPicWYeba6NYcKxmLHIbogbLIr3mp
 71wE2Jj8JRTdLP5GsPz8Uro9LgiPGKkCPClY6KQQrvUt64oS/v29W6vyRTVjR+ojO2OmkTOi3z6
 21IRvGP9beEspP45XNUxAEcf5ZPeGAHkHCwa5giB0FeT/nzF8oD4F07iW2mojRdu22rfHHzHjwy
 OwlrbhklN1nO/bfplMMwsrfkaeieGC6ozvBtVdj5qg6H6GHQHCQbmb3mw1X741KJFuNSxWOSDPA
 MmxaLuAoP9dfKkmuqKyAwpaq6meAYyUMkIUxo6DEKijBQywMzzh1l8qeKLZDokDBBmkUm7Qp0BZ
 M9oEozBuydMoXci1s=
X-Received: by 2002:a05:6000:4911:b0:48e:4e00:b72f with SMTP id
 ffacd0b85a97d-49c71784fe5mr12167264f8f.32.1794672769256; 
 Sat, 14 Nov 2026 08:12:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b104sm12064734f8f.6.2026.11.14.08.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:12:48 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:12:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
X-Gerrit-Change-Number: 2116
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2116?usp=email>
X-Gerrit-Commit: e1d9286b69eb9c59b2926d1ff996b7af4d28d317
In-Reply-To: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
References: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2MjU2MDAwLkk0MjdiZDllZjhiNDkwM2NiYzEzODZkM2RjZWYxYjY4YTQ2MGI0NGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <357f549afc6e4759782dffa09f9369e7c98ea5e4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGN6-000000001Zm-0CRe
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1412686390517272655=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1412686390517272655==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ltTi+f4j4/U="; charset=UTF-8

--ltTi+f4j4/U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2116?usp=3Demail )

Change subject: manage: fix "cr-response" t=
ypo in unsupported command error
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

manage: fix "cr-response" typo in unsupported command e=
rror

Broken since caf1b903 ("Use a template for 'unsupported management
co=
mmands' error")=2E

Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
Si=
gned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2116
Message-Id: <20261104122047=2E15606-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40747=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 1 insertion(+), 1 delet=
ion(-)




diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
ind=
ex 1760c90=2E=2Eb8a0408 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openv=
pn/manage=2Ec
@@ -895,7 +895,7 @@
     }
     else
     {
-        man_comm=
and_unsupported("cr-repsonse");
+        man_command_unsupported("cr-respon=
se");
     }
 }
 #ifdef ENABLE_PKCS11

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2116?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
Gerrit-Change-N=
umber: 2116
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ltTi+f4j4/U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2116?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: fix &quot;cr-response&quot=
; typo in unsupported command error<br><br>Broken since caf1b903 (&quot;Use=
 a template for &#39;unsupported management<br>commands&#39; error&quot;)=
=2E<br><br>Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2116<br>Message-Id: &lt;20261104122047=2E15606-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40747=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1=
 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 1760c=
90=2E=2Eb8a0408 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><=
br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -895,7 +895,7 @@</=
span><br><span>     }</span><br><span>     else</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_command_unsupp=
orted(&quot;cr-repsonse&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        man_command_unsupported(&quot;cr-response&quot;);</span=
><br><span>     }</span><br><span> }</span><br><span> #ifdef ENABLE_PKCS11<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2116?usp=3Demail">change 2116</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460=
b44c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2116 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--ltTi+f4j4/U=--


--===============1412686390517272655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1412686390517272655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1412686390517272655==--

