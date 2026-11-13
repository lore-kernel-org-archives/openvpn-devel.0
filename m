Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C845606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BtC0rOFx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aLBqbVhg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lrN+vE98;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EGr8GPY9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9QFryKsmtN8x6FKs6KrPGRW434GW+lnL1kQknoNxwsM=; b=BtC0rOFxBYIxvvh2AlqQyT/N/W
	Y8t268k1kTUIWIvm/tNpL0x3+15Lwnt07zUnMcp3gTJB+E9j/d+F/drk0rfHqfhfrvkxaPsulcsYQ
	9YTh5Bbq7vMNcTu9RVRISffpNZF+OwiQkzjAt5etm5jawp76VGkICryHdwafHVsX+r1I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRoMT-000000008I1-3H7r;
	Fri, 13 Nov 2026 10:18:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRoMS-000000008Hv-1m1t
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WyFRvTvwUTaC8IHEw1r2zppWbWdsPKuD5GUL9GsxMBo=; b=aLBqbVhgPIxKiatJENAq1UjdUL
 FxLoVGJRSZapnY7YggkkX89A9GoSgZ3CQwCCyUD/4AwF25YkRcAMKUUWyUCEtzTgobelbPAmtsy0u
 uR4Hmvv1JMIVrxzEU4xjK3Bv+HUXeXgD1QkRrrM9C0lli+XFtrZ7t49zt/w/iRQy7/BI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WyFRvTvwUTaC8IHEw1r2zppWbWdsPKuD5GUL9GsxMBo=; b=lrN+vE981VrpJ0ko+7asEXkSBr
 rRNzdM0DQAg/EKIi14RPXM4Ng2lZthr9KrTW6MITfykWLXUqlfnBBhNKnmC3kBT9RdKt9bWsH64sk
 7g8TOBbgn57B2iriTBGxCwrXm3dkNjMsHWpqC6fmcbkSU5xo+BzCKR7AfdCQuaRGDB6U=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRoMO-0000000063p-49GQ for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:18:22 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so300957f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 02:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794565094; x=1795169894; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WyFRvTvwUTaC8IHEw1r2zppWbWdsPKuD5GUL9GsxMBo=;
 b=EGr8GPY91J63uEsa/Z+XxWgHjm+VGi5pBoeEl8obRIyAwGjpTuQl9tHRhHvnzzkezH
 /wCksuAgtyAlhLAZ/dtF22HUulfY55k7fPH9ZWPTGhoqJMG0NC1QStTlpddXtOscr5wg
 22BdaNEZWmyjUm9IagyqeSpDs0KhfkSPmLVZh0sYwnFYft49O2dwr+fnDHYwWfnw6hI1
 WHLXFEaBb/mt9uxZeWDyOOgo0iyhE6ut2EnE/zMJ3ESoiB23WQwxF+Srj94QBcgFntE8
 RatDPeRMNiJS3NGEn8fAhiWDilGEE5NWMfflJrXL1NdfsaWHq+lPoa6nU81j5UE87Ooz
 K1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794565094; x=1795169894;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WyFRvTvwUTaC8IHEw1r2zppWbWdsPKuD5GUL9GsxMBo=;
 b=szrVadcUzhtpsxizlKHVJUqfEYM2NkBQzhMwEUrMJkO64qSLxWsIjhDdbn4k0iO5/h
 3fbMJUtf0AaV2YeVn1HAHKZfyY12b3ZIveWwMGFiD2vKdQH7/eclau0pBKSJEI+4EJDC
 A/8wE9bPMUv6+w+EtCy9n19UnluOAOrb6aUOlmZPROPDFIpUHDZ90e4u1DyGRpa5lKQ5
 A+1TylJOkiEatclV5z20KZxQ9RRNqy+4QRz2RKMGnE4bgrv26NfodHjWwWg4ARV31JNb
 wHjwXN6gyu13Ty9yZPPJgIBQKV7IsbrPOFnB+8oy52W/p2sIRr3Pev91/VJehpGKegUr
 r4Uw==
X-Gm-Message-State: APuU4Z+gqKFMGwCz2bxomj2jo8H1N2Q0m1pUp6QnsBFhhcRFgRhzjGt0
 3kqSDLsVIvPAHAg1puuTqo4prQYNJWa9N9x2Sdr/Oxvd/DjQ/A1PyE2+952Nv4IO2ldMCYxz4da
 /mTZcYG251822ffqCmqrG0To0mVvQZlw/21kgTxMrmD26kiral6mkb+CgvoXvzyg09mq3
X-Gm-Gg: AYBFou1KGr8Of/NmugGokKVdz3re9Z+hqcU9yIVey23gIcUxCleYCgYaLI5mPWe7J06
 9psuXGIIHL9ZhinndAsHoCgprA/JsN/0b580davSA7BWi+HR3RCSWoxpe9hZbMXVi/GaDDt3OyY
 HK/48890/NDR3aFqv0tEOP5qGrs6mBwOOx4NIefXA0JpIkQDIhUKbvm0aSED7Cca0Yh/hnSxy5P
 yHGta3AwpF5jwtYpmf5PqQjTc4eF2ybchDVBjuwy1REcWpBF8DqPV5AJhp4ymQ1QoSrmHp7TouQ
 BhkzSafn1mSjr9aUhVmrxDuvGQaGfpV0OnUbMaOP4P4FLn/V1XjkWoc8RFJtY/yvbWh4wC1pCwE
 /jpDsoDfOjLU+KN2FBVdzxeQsn3NSBge0FJ6P9DVmknS3HpGmBebqv8xg33RpzeCyjU7uFUoR1t
 RD+My9NDd6PodrU+lL1Eyg+Jpsr4k2JkIyeY91JGaXbLVv84rZHKKxDg4nrq4lIG7XjZ9B7TaQ7
 woNpTleFevmU5gyLJxjKpeBZM8iiZ3YEVEFKd+YhBdnX8N378fSsy13FVWCOvgWqAVH2FoWhunH
 JM4kHVfADKoOFdtG1YuUHVf4kbu/4h4FgIxvKKRjyThK4t8knbUq0+dKHkJ67AHyqhAGdYBH30N
 f/QtVeFHGF7mvM7EqXQUrpYTk1hGUzolLtOpvJBVN2gHiQngu493a/+kbhduUDKYQy4IV9jpASn
 lqLryAxg+44UURtkA=
X-Received: by 2002:a5d:5f03:0:b0:491:e062:383d with SMTP id
 ffacd0b85a97d-49c7390fb5emr4094306f8f.57.1794565094156; 
 Fri, 13 Nov 2026 02:18:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1968sm4184139f8f.10.2026.11.13.02.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 02:18:13 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 10:18:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c
X-Gerrit-Change-Number: 2167
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2167?usp=email>
X-Gerrit-Commit: c034bee07fecf24cb1e1574d5904f67874a5b022
In-Reply-To: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
References: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIwMTk3MDAwLkk1YTgyN2Y0YzZkMTY5NDIwNTA0YTQ4ZTEzZWU2ZWIyODA1M2RiYzRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9baba940afae764ee6c771d1042ef107b35156fd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRoMO-0000000063p-49GQ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: drop dead
 code in inherit_context_child()
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
Content-Type: multipart/mixed; boundary="===============7523792655711754860=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7523792655711754860==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Musxe0akq+U="; charset=UTF-8

--Musxe0akq+U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2167?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: init: drop dead code=
 in inherit_context_child()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

init: drop dead code in inherit_context_child()

The ciphe=
rname/authname copies are overwritten by the
dest->options =3D src->options=
 assignment that follows, and the
trailing IS_SIG() return is a no-op=2E

C=
hange-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c
Signed-off-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167
Mess=
age-Id: <20261110150100=2E17824-1-gert@greenie=2Emuc=2Ede>
URL: https://lor=
e=2Ekernel=2Eorg/openvpn-devel/20261110150100=2E17824-1-gert@greenie=2Emuc=
=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openv=
pn/init=2Ec
1 file changed, 0 insertions(+), 7 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/2167/2

diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index aef2f14=2E=2E25521f3 1=
00644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -4737,9 +473=
7,6 @@
     dest->c1=2Eks=2Etls_wrap_key =3D src->c1=2Eks=2Etls_wrap_key;
 =
    dest->c1=2Eks=2Etls_auth_key_type =3D src->c1=2Eks=2Etls_auth_key_type;=

     dest->c1=2Eks=2Etls_crypt_v2_server_key =3D src->c1=2Eks=2Etls_crypt_=
v2_server_key;
-    /* inherit pre-NCP ciphers */
-    dest->options=2Eciph=
ername =3D src->options=2Eciphername;
-    dest->options=2Eauthname =3D src=
->options=2Eauthname;
 
     /* inherit auth-token */
     dest->c1=2Eks=2E=
auth_token_key =3D src->c1=2Eks=2Eauth_token_key;
@@ -4796,10 +4793,6 @@
  =
   }
 
     init_instance(dest, src->c2=2Ees, CC_NO_CLOSE | CC_USR1_TO_HUP)=
;
-    if (IS_SIG(dest))
-    {
-        return;
-    }
 }
 
 void

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a827f4c6d169420504a48=
e13ee6eb28053dbc4c
Gerrit-Change-Number: 2167
Gerrit-PatchSet: 2
Gerrit-Own=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--Musxe0akq+U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2167?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">init: drop dead code in inherit_context_child()<br><br>The ciphername/a=
uthname copies are overwritten by the<br>dest-&gt;options =3D src-&gt;optio=
ns assignment that follows, and the<br>trailing IS_SIG() return is a no-op=
=2E<br><br>Change-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2167<br>Message-Id: &lt;20261110150100=2E17824-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel=
/20261110150100=2E17824-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>1=
 file changed, 0 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/2167/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><=
span>index aef2f14=2E=2E25521f3 100644</span><br><span>--- a/src/openvpn/in=
it=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4737,=
9 +4737,6 @@</span><br><span>     dest-&gt;c1=2Eks=2Etls_wrap_key =3D src-&=
gt;c1=2Eks=2Etls_wrap_key;</span><br><span>     dest-&gt;c1=2Eks=2Etls_auth=
_key_type =3D src-&gt;c1=2Eks=2Etls_auth_key_type;</span><br><span>     des=
t-&gt;c1=2Eks=2Etls_crypt_v2_server_key =3D src-&gt;c1=2Eks=2Etls_crypt_v2_=
server_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* inh=
erit pre-NCP ciphers */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    dest-&gt;options=2Eciphername =3D src-&gt;options=2Eciphername;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;options=2Eauth=
name =3D src-&gt;options=2Eauthname;</span><br><span> </span><br><span>    =
 /* inherit auth-token */</span><br><span>     dest-&gt;c1=2Eks=2Eauth_toke=
n_key =3D src-&gt;c1=2Eks=2Eauth_token_key;</span><br><span>@@ -4796,10 +47=
93,6 @@</span><br><span>     }</span><br><span> </span><br><span>     init_=
instance(dest, src-&gt;c2=2Ees, CC_NO_CLOSE | CC_USR1_TO_HUP);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(dest))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2167?usp=3Demail">change 2167</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a827f4c6d169420504a48=
e13ee6eb28053dbc4c </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2167 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--Musxe0akq+U=--


--===============7523792655711754860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7523792655711754860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7523792655711754860==--

