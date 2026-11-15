Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD391606A31F
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PMiVghlN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fHAcPX+C;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Mc+kcIUR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XO9S5m6x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TSH3jAEVkylZSXyYICFLse9hAe/tZjaCrHbhossYLaQ=; b=PMiVghlNb8kQYWHhGPoZLFylBR
	k+YnQluX9+G36eUB1L3wxzfM7Sq0YY7/G/xDatTqsITklIc++ksWTzR+yBnvtB+1af3/gsK6R11/t
	EJFGGGWzKguOk8GaKKL38S6ii1qNgoqsfsUc6+fFSrP+6E/XO76gCvizIdKMtSObijaU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSazH-0000000031W-2S3U;
	Sun, 15 Nov 2026 14:13:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSazF-0000000031Q-4AOj
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ho2Q7MU8NXd/2PF/GTpmbLH5jY+tIkif/YNBjdBNsgQ=; b=fHAcPX+C14ZhhyHQQPx7EwywfX
 eAnlTLSMV1mRzl8Zx/r1zWwOOG1Rtrk2G44kQODe0HGzRJVC52ljxO5cX9kJW+M8nQCMu1yDPVDay
 vZZrwyswTb0NeiSWEHcS8/soTXQ0M1Hzk7572dIf9FKMNBNtSLCIxme7kuGy4SN3yABw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ho2Q7MU8NXd/2PF/GTpmbLH5jY+tIkif/YNBjdBNsgQ=; b=Mc+kcIURyJrsxjZe7oTUjKIuou
 WiEURB0ahP7HptsOnAVF00WAgAGrpVCzxiq4WBJL0BnWH+feQdRgq/5RoZNnkKSg/jkuPFeCPIU9B
 F3n5u0Q5KoC6TLzc7pNPRF18INWwRl1Hh0ievOSS9K2ZR4qqT3UXmxJ7ZjiMWVsIax7A=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSazE-000000000kr-0MYh for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:13:41 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso5428665e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794752013; x=1795356813; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ho2Q7MU8NXd/2PF/GTpmbLH5jY+tIkif/YNBjdBNsgQ=;
 b=XO9S5m6xBuTo4xX0dTXs7uctFr6uy1mfRjaTxEx6DfX02P0sXb3Y8LeAduT1dRdlij
 9fVjCOgauaTlFS/LDFxGkWuYU9+M7/OMNSn7LLhuAzaRNe6BSjFD9ly4FuxbT3eW858e
 o59rH372+CM1W9FP800Xwyw3F506KpyEQNixOEcg1z1IutTytIf2+5aZBhB6FHXMPbCE
 a2dLfxaUPAy6GTPzwE9qNWbZkpmm9a2IPexiPuaI1jWeZSIcUVkSfY6/2T4ldCdrjYNi
 Qf6eFUPNLPdycI+WAZz8xlfAEoThRAwbxISUS1kDPao8xQZ7ZKF2jZBNKC9zfTUK0BWW
 UCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794752013; x=1795356813;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ho2Q7MU8NXd/2PF/GTpmbLH5jY+tIkif/YNBjdBNsgQ=;
 b=RDd1enz5DLH0BMo0/KY3jW6Y4HQo8RZ2RWzRIIbr/qg7CZ3J6D6IGqN6LYqoY4skId
 Kp53Ne3bwsvHUv6GYXpXaUBMLULgxgyKIRUWLQw2VLEXlQNLagJofQ3LXkmWot1din4J
 PBL6DzOGGjjoJo7ZCR7KJRAtVkxZTVeMLzg7kBnQGljd/3NCygVZciKort5N5mHQaHMA
 qAS3yA9gBz9GR881Ub9RKCweU6uNn3u847/gv3mJkv9W6z37dhUoafY8mfk5Hrv/BX4C
 Y3U22A9MYo7EMeceDM+s2i9wZD6ZDVKHAu+6CV8EkPi3CYjwKuYMMotHM/sotPj3nLy7
 X/QA==
X-Gm-Message-State: APuU4Z/uXD90scmI5S7w1wo5IGRwmNsRZyqWrlH52eoVDJQJpuGiLCsq
 24ACKZ88K0D4mbZOiwaGdBCtRIqqTxS+dUS723DVYgVCpD0o/jBoyM15W06+TVO8KOir15qx7sr
 bwhc7ptdO1/cPGDDJbxN4b0VFhnbNGIx4fZ/nLRRBBWz/hUx3EJCG4XMsfPrp/AupgrCiqhVa60
 K4uHCXzw==
X-Gm-Gg: AYBFou3GdVh1B6PkGkHhdI3G82J+PLgHJKYjP2XPhekmxVzuJhJ8EL/0y2Quwi/99OF
 qgkhkzyrQx0XahLTlUKMt4wb1xyfHX4C2hvpDR97cpRNy3BlSadpMyFB0meCqYu17oIr0Ns/FMh
 7KWtLSTNyknlXJAmgoq+uJN3M/2gBtViydkNhW7I959BBezioIZ+v/00hI6MovSle3T9onkceaY
 VeZ1CmlfkDlP2PIQrN0NTsma5iXYmKqCHcC7SJngrEIHOTORgpnPyvQfGthMGiQEy+Tp3Yy1WFT
 4J97PKsEIlzyzzJAXdZQmCiiAruD4v2HGw+8WGSkKQ2z5T231kYs+lA+GWc2X83wJU3FgcbxvF7
 lS5OvMt+Yw1oOPi30WyGvcxFtGi/7maMmv3rQ4iwkO4ikW2QbRlJ00LZTkDEnjHllJqORmwVLT2
 3u/LR4EaA+vDr324BkT5YRvw/wjjeZg/41ysc5RUk54/twT0tmvRZB3kfFZlbY7aIW1KQn/qyh4
 uSQDuitJftZw+Qf0CT5PatLnuPA8Jgz5B19ET9iQvZJecwwyZC8tMYfNWIhp289jA5DrNYh2kQ4
 enkvrpN+Bdkk2ODneZYSmC7o8gRSaxd6e1pDL1T+ahg93uT2CGZwCpEQCpQILiWxl4hYG2TiY/e
 8+N3AAsfYm2DRROXVT39tQ7f6O0jPcebm/hgzn+sEKWQ0uEM/MoHTMFPXlt8w+sPj4gEJsjwVAI
 R3kzbmyrwk3LQv3JTu
X-Received: by 2002:a05:600c:8483:b0:4bb:605d:8e92 with SMTP id
 5b1f17b1804b1-4bb605d90f1mr102434655e9.32.1794752013112; 
 Sun, 15 Nov 2026 06:13:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c81a63b1csm15878501f8f.4.2026.11.15.06.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 06:13:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 14:13:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
X-Gerrit-Change-Number: 2125
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2125?usp=email>
X-Gerrit-Commit: 5bd4216b44b523efad1af3176dad40ecabbcfe14
In-Reply-To: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
References: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5OTAwMDAwLkk0MDA1OWViOWFmODQ1YTUwNzBlYmI4Y2FmZjc0MWIwNzk0NjMyZGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3556508a6636c315fe53354b5209f18a8607acd4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSazE-000000000kr-0MYh
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: drop unused
 input parameter of management_query_multiline()
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
Content-Type: multipart/mixed; boundary="===============4960577693690514531=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4960577693690514531==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bb/PVfFw+Z0="; charset=UTF-8

--bb/PVfFw+Z0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2125?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Frank Lichtenheld


Chang=
e subject: manage: drop unused input parameter of management_query_multilin=
e()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage:=
 drop unused input parameter of management_query_multiline()

The parameter=
 has never been used since the function was added in
39e3d336 ("Mac OS X Ke=
ychain management client")=2E Its callers read the
input list themselves=2E=


Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
Signed-off-by: Razva=
n Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125
M=
essage-Id: <20261104124859=2E18417-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40679=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/manage=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/2125/2

diff -=
-git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index b8a0408=2E=2Ec=
a0a7dd 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ =
-3856,7 +3856,7 @@
 
 static int
 management_query_multiline(struct managem=
ent *man, const char *b64_data, const char *prompt,
-                      =
     const char *cmd, int *state, struct buffer_list **input)
+            =
               const char *cmd, int *state)
 {
     struct gc_arena gc =3D =
gc_new();
     int ret =3D 0;
@@ -3940,7 +3940,7 @@
     int ok;
     char =
*result =3D NULL;
 
-    ok =3D management_query_multiline(man, b64_data, p=
rompt, cmd, state, input);
+    ok =3D management_query_multiline(man, b64_=
data, prompt, cmd, state);
     if (ok && buffer_list_defined(*input))
    =
 {
         buffer_list_aggregate_separator(*input, 10000, "\n");
@@ -3967,=
7 +3967,7 @@
 {
     char *result =3D NULL;
 
-    const int ok =3D managem=
ent_query_multiline(man, b64_data, prompt, cmd, state, input);
+    const i=
nt ok =3D management_query_multiline(man, b64_data, prompt, cmd, state);
  =
   if (ok && buffer_list_defined(*input))
     {
         buffer_list_aggre=
gate(*input, 2048);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2125?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I40059eb9af845a5070ebb8caff741b0794632de2
Gerrit-Change-Number: 2125
G=
errit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--bb/PVfFw+Z0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2125?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Fr=
ank Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">manage: drop unused input parameter of man=
agement_query_multiline()<br><br>The parameter has never been used since th=
e function was added in<br>39e3d336 (&quot;Mac OS X Keychain management cli=
ent&quot;)=2E Its callers read the<br>input list themselves=2E<br><br>Chang=
e-Id: I40059eb9af845a5070ebb8caff741b0794632de2<br>Signed-off-by: Razvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2125<br>Message-Id: &lt;20261104124859=2E18417-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40679=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 3=
 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/2125/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index=
 b8a0408=2E=2Eca0a7dd 100644</span><br><span>--- a/src/openvpn/manage=2Ec</=
span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3856,7 +385=
6,7 @@</span><br><span> </span><br><span> static int</span><br><span> manag=
ement_query_multiline(struct management *man, const char *b64_data, const c=
har *prompt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                  const char *cmd, int *state, struct buffer_list **input)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       const char *cmd, int *state)</span><br><span> {</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>     int ret =3D 0;</span=
><br><span>@@ -3940,7 +3940,7 @@</span><br><span>     int ok;</span><br><sp=
an>     char *result =3D NULL;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ok =3D management_query_multiline(man, b64_d=
ata, prompt, cmd, state, input);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ok =3D management_query_multiline(man, b64_data, prompt, c=
md, state);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*inp=
ut))</span><br><span>     {</span><br><span>         buffer_list_aggregate_=
separator(*input, 10000, &quot;\n&quot;);</span><br><span>@@ -3967,7 +3967,=
7 @@</span><br><span> {</span><br><span>     char *result =3D NULL;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const i=
nt ok =3D management_query_multiline(man, b64_data, prompt, cmd, state, inp=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int o=
k =3D management_query_multiline(man, b64_data, prompt, cmd, state);</span>=
<br><span>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><sp=
an>     {</span><br><span>         buffer_list_aggregate(*input, 2048);</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2125?usp=3Demail">change 2125</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2125?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794=
632de2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2125 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--bb/PVfFw+Z0=--


--===============4960577693690514531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4960577693690514531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4960577693690514531==--

