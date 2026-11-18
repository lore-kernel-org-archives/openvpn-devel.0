Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5C60A3817
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=je2HZ5T9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dELr87OU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Opm8piyF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hVkJvFdW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HehhMUTFAFmnUXJYCQrDeuh6CKbRozl+Mhki4zzPBdk=; b=je2HZ5T9S1a4nMF4edkYfNn3Ii
	sKuBhrnJWysQHDqy7wtW3w1FAu8FQZMthPruFs8IDbFyiOkEAhvhk8P4yuw1mSCDXJQa+sofTsSmw
	j3nEKnVI/lda4VRkliTJ4K3TJFCm/nDF2Q9YlYrRMvREgjew/ja3lF8OEhU6wL5md114=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiMl-000000001pg-1VZM;
	Wed, 18 Nov 2026 16:18:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTiMk-000000001pY-1tNc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PFFxnHQPDd35l6w+a0HguumTCJ80RZbwS++56LvIbxc=; b=dELr87OU1DX2RuN9D9L8kz3D1X
 1bbDM1ao5t6r+ogi0EVjs/doih4iuG3BWTVSl0nWT1CUrC/DoeYYjW7GuGiK3vqxOt9vn633k3uXZ
 X6L6p9uYgRpCY6y/LPXJszGF8atQB3F0dbEaK6qouyROEHDhqQx3UGb9Hyt+m4ku6kWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PFFxnHQPDd35l6w+a0HguumTCJ80RZbwS++56LvIbxc=; b=Opm8piyFrz5x2z2M1Oyvxkxsi8
 8SkxkFeoRW8dGTBnR5ejhlJJuBfA7IAHxBhi0z6/s7puxF/WOln587d6quOfyPnEn/HE3ZF5qqdDF
 B1eHUmdvSaZ+FS+BdPowsOEMMCCCPONK0/uiLXCMs4gv75N/KViYhOiaIQVNw0FD+sJk=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTiMi-000000005fV-3M9W for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:18:34 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so11477635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795018706; x=1795623506; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PFFxnHQPDd35l6w+a0HguumTCJ80RZbwS++56LvIbxc=;
 b=hVkJvFdWahMb4TTNEClOJqEMpYqhDmHS2hQs6k6gUGcnV3f+l0cy6bJULZcSRngcVg
 l5//GHTiBS1opvrUgx8WY65znsl0kxA9Cm1/5kiV5U1lGAHQyI7wIXaASDAZKBNkcH3K
 u0vKpviQYchVRs6ytOkZYBRxeEd1+IjyedS+DNsHO+lrPw+cGpSykygOtjJhQ5sItLri
 KtTlJX7WLbM+OcNtSU4ye1n/POUJbb5AMYK7CsJLx6V6nnVLSCqa1D58T1jO0OAQUwoh
 EHRmNgjDahv4+qJU6JqJWYDfyFFYyXNOrtMKqziQZhqOibDoQxp+XO1+qbruuIUJh1lR
 DGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018706; x=1795623506;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PFFxnHQPDd35l6w+a0HguumTCJ80RZbwS++56LvIbxc=;
 b=Rwm+DgDA2k8t6zA2tsJZvvIAwdjgHGwKFJboLqS5pTj2d/+y0xKwVcNeLtMemoiQY9
 RCvDiEbBg7dMBaQ6K1or+dM5PCNNunHM5wtRXm2cMRYxnAWLrWeOVci/MqPVNo0WTLdd
 3QZuR9c7vLjxIT04lfvChh/NAzxzJyhecNSIxdf6G8qe8aLwxFZVT4kC/1QIrOmvk6rG
 vhvuNTPYE5kmvvX0OMcpI71N9YYqF9G7Qyod2d5qmU+mJE+vI2Lm4znFQTdP49OV6a3i
 xOlNcH3HmYw90+ApDUx6joJL07khzo/5KcUhWwN92641LDFv60V2AMGalVuYtUjt43WQ
 lESg==
X-Gm-Message-State: APuU4Z9wBmzALCzSr+7CSJqTo7BkFeieyB0HLmRC8sNtu3f1kCTmufUF
 3Dg8KwM2nEtiO1mgFdgrwHkoV4dwM9Y7C7f2okfy7MeQ092nLqNtlKVS4jbNfbYzrYwgH2OIS+3
 1UbSwqzUehtryUjQufVKZYvAcAQWNMkUX7AhPw4nx+xn/s4PdIkAzbnlNK7nWXpojlI5P
X-Gm-Gg: AYBFou0LmJY6C7PB/QG7e2CeMpRugipYuop0F/es3be/rKJjw4nDfiLkEvOKE/qR3k6
 8VVCUoELnHRDv9rBgyWvBVopDDWN6acFb6axc0SBUfj1iQ5YSeM8rI5ahrqsqFhEbBDZjb9S/Ub
 yXhdrIEkdepNL62SI+9JXOyu3eJpcM88aVaZPzfuu3TcXWr77hO/1yREd7UCFcuxi3NMnwnWAhv
 Yy5XHoBwn800fEJ/B+xLjQlGrZn0zMkwXMBadAAeGQF3GCRBtRLdBbit6iyLMYN77DacU+mIzqH
 oFXPLQb3l+neqBVYV376xV2rjIoxWgzRE/MbbBBdwqyY1jNURcbg16l2Ez9OY9dR4uAwgw8VH2d
 Cv8ucg4f5wHiqRtd9teXMLfoCfuRUR6kPf+9WhB5LIItLhCDNX3AX+XfpjfiBGJyEGj7dI6GoFE
 Rh7eb/coImhs4jQkgKdq7b2yC9OKiFB/WD8bLFZM7Yc4VT9jgzrlSYrKWsQMtB8hXi/4bglF0Yz
 6y/7iTSJq+l6v9Bs9Xc6DLNWQH1nxy1/tFr3TY6lX0xk4VL/fyx7nb/BkuKe+I9SEeU4nVbsM6R
 qZ/vO3C22XUVabuc8FQ7YSJUKdwS1dLvIGc6rSu+TWNHiukZ9GSpIe4lEPGLThA1vru0mqwYYpj
 EwSChOIGGk8kY2gi0u0gmpqcTLhcGP1b7373yXR+80KJ1X66w+cAUScpyd/F8XLNQqlrxWYjLYK
 /Bg0AAs6bfrcF4n8M=
X-Received: by 2002:a05:600c:4e92:b0:4bb:6a2d:b440 with SMTP id
 5b1f17b1804b1-4bb7d6d1df0mr66737535e9.2.1795018705996; 
 Wed, 18 Nov 2026 08:18:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d29c622sm79864395e9.3.2026.11.18.08.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:18:25 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 16:18:24 +0000
To: chesain <cvanteddu1@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e
X-Gerrit-Change-Number: 1338
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1338?usp=email>
X-Gerrit-Commit: 34b4d05091c2a1bd7ad203a0c12e963c01dedddf
In-Reply-To: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
References: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYyMDI2MDM0MDAwLklmYjRlOWQ3OWMxNjczMzdmYjc4MGI1MzE0MWQwODBhYmY1NWYzZjVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6493bb5c452cd69c5ffd1a66554215113351b36b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTiMi-000000005fV-3M9W
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: CONTRIBUTING:
 add Gerrit option + links
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, cvanteddu1@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3017510325553125243=="
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3017510325553125243==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RSSrf5s4Ntk="; charset=UTF-8

--RSSrf5s4Ntk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by chesain=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=3D=
email )

The following approvals got outdated and were removed:
Code-Review=
+2 by Yuriy Darnobyt


Change subject: CONTRIBUTING: add Gerrit option + li=
nks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

CONTRIB=
UTING: add Gerrit option + links

- Add Gerrit as an alternative review pat=
h

- Add links: signup, web UI, best practices

- Final patches still go to=
 openvpn-devel

Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e
Signed=
-off-by: chesain <cvanteddu1@gmail=2Ecom>
Acked-by: Yuriy Darnobyt <yura=2E=
uddr@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/13=
38
Refs: openvpn/openvpn#845
Link: https://github=2Ecom/OpenVPN/openvpn/iss=
ues/845
Message-Id: <20261118150332=2E13954-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://lore=2Ekernel=2Eorg/openvpn-devel/20261118150332=2E13954-1-gert@gr=
eenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M CONTRIBUTING=2Erst
1 file changed, 7 insertions(+), 0 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/1338/3

d=
iff --git a/CONTRIBUTING=2Erst b/CONTRIBUTING=2Erst
index 67baa4e=2E=2Ee7af=
eafe 100644
--- a/CONTRIBUTING=2Erst
+++ b/CONTRIBUTING=2Erst
@@ -8,6 +8,13=
 @@
 
 - https://lists=2Esourceforge=2Enet/lists/listinfo/openvpn-devel
 
+=
Alternatively, you can use Gerrit for code review:
+
+- Web UI: https://ger=
rit=2Eopenvpn=2Enet/
+- Best practices & account setup: https://community=
=2Eopenvpn=2Enet/Development/GerritBestPractices
+
+Note: final, approved p=
atches are still sent to the mailing list=2E
+
 While we do not merge GitHu=
b pull requests as-is, we do allow their use for code
 review purposes=2E A=
fter the patch has been ACKed (reviewed and accepted), it must
 be sent to =
the mailing list=2E This last step does not necessarily need to be done

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ifb4e9d79c1=
67337fb780b53141d080abf55f3f5e
Gerrit-Change-Number: 1338
Gerrit-PatchSet: =
3
Gerrit-Owner: chesain <cvanteddu1@gmail=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom=
>
Gerrit-Reviewer: chesain <cvanteddu1@gmail=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--RSSrf5s4Ntk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by ches=
ain=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by Yuriy Darnobyt</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">CONTRIBUTING:=
 add Gerrit option + links<br><br>- Add Gerrit as an alternative review pat=
h<br><br>- Add links: signup, web UI, best practices<br><br>- Final patches=
 still go to openvpn-devel<br><br>Change-Id: Ifb4e9d79c167337fb780b53141d08=
0abf55f3f5e<br>Signed-off-by: chesain &lt;cvanteddu1@gmail=2Ecom&gt;<br>Ack=
ed-by: Yuriy Darnobyt &lt;yura=2Euddr@gmail=2Ecom&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338<br>Refs: openvpn/openvpn#845<br>L=
ink: https://github=2Ecom/OpenVPN/openvpn/issues/845<br>Message-Id: &lt;202=
61118150332=2E13954-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Eke=
rnel=2Eorg/openvpn-devel/20261118150332=2E13954-1-gert@greenie=2Emuc=2Ede<b=
r>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M C=
ONTRIBUTING=2Erst<br>1 file changed, 7 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/38/1338/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/CONTRIBUTING=2Erst b/CONTRIBUTING=
=2Erst</span><br><span>index 67baa4e=2E=2Ee7afeafe 100644</span><br><span>-=
-- a/CONTRIBUTING=2Erst</span><br><span>+++ b/CONTRIBUTING=2Erst</span><br>=
<span>@@ -8,6 +8,13 @@</span><br><span> </span><br><span> - https://lists=
=2Esourceforge=2Enet/lists/listinfo/openvpn-devel</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Alternatively, you can use =
Gerrit for code review:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Web UI: https=
://gerrit=2Eopenvpn=2Enet/</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+- Best practices &amp; account setup: https://community=2Eopenvpn=2E=
net/Development/GerritBestPractices</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Not=
e: final, approved patches are still sent to the mailing list=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> While we do =
not merge GitHub pull requests as-is, we do allow their use for code</span>=
<br><span> review purposes=2E After the patch has been ACKed (reviewed and =
accepted), it must</span><br><span> be sent to the mailing list=2E This las=
t step does not necessarily need to be done</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=3Demail">=
change 1338</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/133=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none">=
 Gerrit-Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Number: 1338 </div>
<div style=3D"displ=
ay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Own=
er: chesain &lt;cvanteddu1@gmail=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Yuriy Darnobyt &lt;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: chesain &lt;cvanteddu1@gmail=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--RSSrf5s4Ntk=--


--===============3017510325553125243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3017510325553125243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3017510325553125243==--

