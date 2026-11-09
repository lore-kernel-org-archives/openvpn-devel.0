Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333F606A330
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fluS+0EC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fLgjtBYK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=esLba+vL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SEhGjbC7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VxzpazRr4VIZGkW4vqnUtA86nYpK6mg8AupxzFd4+bQ=; b=fluS+0ECNel2GDM16+DdDfBeBg
	6Efhlx8aKSHQdaESKlqvvmT7/fvr4jZY+dKirxlWDr73KmchoCvwmGJMqee0iahRHufao2dTmy8jz
	GD46PPqKqvLLZD8LkNAYBfBK/veEdFVpUIif02u97qhmDMReAbIGIxCBWUf49tLvBl9A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQOD2-00000000348-3X4s;
	Mon, 09 Nov 2026 12:10:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQOD1-0000000033w-1agi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1WiIxkBn+ev5suEprZ+CgeOkyotunNT5ZsCDMIYAFrY=; b=fLgjtBYKrCIbN87e1ma+DPx7It
 awm7NCY7qMzKorkS8kFP/LPZ6zP4kNHF7QBv7QVGLa2pWkJRMNZod+302+mKpBulveItsxxELHNXv
 FczHOFEolJVq2QPzmVM2NFOnqsHKwwUoyse25aqnDFGNT66nttCecM03LD6C9L0hpK7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1WiIxkBn+ev5suEprZ+CgeOkyotunNT5ZsCDMIYAFrY=; b=esLba+vLet54JGz+4JWHWy28+1
 rF12OijwGquzo6Ms7P3osIl/0uMuPERLa9trQkkggdxmzo7Yhg1KmyP4onx3HIsrIrVmgb5y9HBEY
 rkfoA9uobDoizkucBNhRH42kNyXwPzpFK3WoOhNfhXLW/YQ5KPm8frDxkH/4+/h2vg+o=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQOCz-000000005rp-471b for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:10:47 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so5490845e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 04:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794226239; x=1794831039; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1WiIxkBn+ev5suEprZ+CgeOkyotunNT5ZsCDMIYAFrY=;
 b=SEhGjbC7r6GThCsmf2rCsg5MyDgQxn0nohLUnfDCqPxABDC9Xt1YjQRqctSjB8se3H
 SCtdQpO4BRaMaBSMmCiLK3cCcROQR/dU2ItFyCAszEGj6YchpZ4eN0wxwMge/pKFOksl
 w5LMlhQ3799lpSvvQmyb4B0FHptsd7aZ1+YKzUOK7YWYcONIHpeIdQgKdlD0nCyiDA2F
 j1g29zlcFP81PjegJ1sZYQSlQJF9ruq+ZmKJXRdMiZAnFaCFpetNse0D8GWAteWiO2Nj
 YptavdzUrsSFuJuhqxe/RGlT+DMjNVpYe+/nQARh0BgofDGV2KGyoIXSwLuhPUejQkT6
 +F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794226239; x=1794831039;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1WiIxkBn+ev5suEprZ+CgeOkyotunNT5ZsCDMIYAFrY=;
 b=PRLfhNYtJ2N7MORYLCXeY8og7UNOl/oBncYUltD/JnozqkYjTSKBIyfSU+S84JYOyD
 BW79yCF3gVCXImOJfo1+cSLlWG9RMEmMr+Atz4TuaUz6vg+8ot6MCVkQMGhR+/gm9j6b
 OHM4bU1otS8YUNLyDfHBFfKhF54tLUAGgIR3ZPHtbmDbuLHohn3/CKo70FIFs1aMSiQH
 GjVScgsTjQLJN3uHyCXKyXNCd+TsfqiOMrdwQ0aeJiMcvlEGAYBCd8JRpJNdrGCWn3FD
 MqN58KhvASp+L51PK+xLd0vqv/YYJAIkcDptRN91BuYzMrBOxYdQBkhjKKSmrFZiQewV
 TadA==
X-Gm-Message-State: APuU4Z94EMJaNAMO20MgFR7DrmtdnllwyWHbdk1U2th3CCZ834NpuewB
 eLo16WAv0lJUbWYVvbqqjQ/XUCyDWGXdysjSHvfDYwXu8GTc8VH4DxiR330OGKos/6aAw3S87lg
 BH4sIEMuQvnPQEJ3gbIvbW3htiKrmzdxPfLr1kgIMcngQD91/qs7iZxX/EFlTCb+ULvM9
X-Gm-Gg: AYBFou0PoVJY4rXERmZqE6ho2bGopfAJzZrYf1RT9S0pMbPmzdL2UCxt8QzzBVrNmoP
 LwNIJ/NerYEf31FRla+occVqEoQF9jiP5MOyLDHzWUksZCnvxQh9m7gIEUEpp2g9rOzhgItp/gf
 h5spI8Py23XuRMvoD2kT/xQgCqH29h+XVOxPvLLGbb3gU0UK3ymyUemaW3Y6C3hc0apxb91L8RE
 QCfNPQYEq3QdQum4VJu/+0td8fDXUhOtQtg8NynDQrvdOGiBs0DZoW7LO4imvUxAtm09OMoIk8l
 lK1lhpY3L1VtMrWKabPhtCsbm4qYz3h+MmKxzbdW8gslFY5q1AQIvSBEgUz33KmBvOqIof6FeP8
 zzGZo2BX+7SOsrE3cUSzDeDrTfzFmIJJjGqW3Z8szxuLXAEy3y7mrvLS23iRDPzxf7bquYRrVci
 eSNs9kWdp1rJ1+vuybeRNtZ5BRwlgXGIQMcKFU6KypPbvZGTt3Notx6/wmKVkYcV6bFY55a62DP
 klYQuvHHjF2CKHQ9wAcsyoCCDxxNisldEl1FdT5Qt2aq/hjtYjBrZCL6K7hr8b+nDfreFffQ49z
 iLyZ9lXdp5hRCgYwPU3vAFToEJowuYcrt3oKzOHXEtgF1QDxWBqnVHZsKGgQNOB0qDwayaL4wgE
 clyhuYtjG99KRzlEUOM7oBV49uzgVUUFYZcnNKGiPu//nSRxUjrV5Pj4i2JKrhNMZtOHTANxFR5
 FQrCdbmNJCLF8U+g==
X-Received: by 2002:a05:600c:3151:b0:4a6:b49f:9ae5 with SMTP id
 5b1f17b1804b1-4b963c92101mr74793565e9.34.1794226239188; 
 Mon, 09 Nov 2026 04:10:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90ee1de2esm128070375e9.5.2026.11.09.04.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:10:38 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 12:10:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b
X-Gerrit-Change-Number: 2094
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2094?usp=email>
X-Gerrit-Commit: 15b1cd44d3275e178091d809b58cf4fa3369eab7
In-Reply-To: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
References: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM3MzIxMDAwLklmYzEyZGFmZTk2MjFjYTAwZGMwMDIyYWQ0MjZhZmViY2YzOGZiYzNiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <615ef1398f9d35a55ce98b58edf51c44a6d4dfaf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQOCz-000000005rp-471b
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: use man
 argument in management_query_cert()
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
Content-Type: multipart/mixed; boundary="===============5473299732563655987=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5473299732563655987==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fVjvQuvd+hc="; charset=UTF-8

--fVjvQuvd+hc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2094?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: manage: use man argu=
ment in management_query_cert()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

manage: use man argument in management_query_cert()

It=
 passed the global management to
management_query_multiline_flatten_newline=
() while using its man
argument for the state and input buffers=2E No funct=
ional change, the
only caller passes the global=2E

Change-Id: Ifc12dafe962=
1ca00dc0022ad426afebcf38fbc3b
Signed-off-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094
Message-Id: <2026110217004=
1=2E110861-1-frank@lichtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg40455=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file cha=
nged, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/94/2094/2

diff --git a/src/openvpn/manag=
e=2Ec b/src/openvpn/manage=2Ec
index 58f63e6=2E=2Ed3b2e7c 100644
--- a/src/=
openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3998,8 +3998,8 @@
 
   =
  char *result;
     result =3D management_query_multiline_flatten_newline(=

-        management, NULL, (char *)buf_bptr(&buf_prompt), "certificate",
-=
        &man->connection=2Eext_cert_state, &man->connection=2Eext_cert_inpu=
t);
+        man, NULL, (char *)buf_bptr(&buf_prompt), "certificate", &man-=
>connection=2Eext_cert_state,
+        &man->connection=2Eext_cert_input);
=
     free_buf(&buf_prompt);
     return result;
 }

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc=
3b
Gerrit-Change-Number: 2094
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--fVjvQuvd+hc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2094?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: use man argument in management_query_cert()<br><br>It passed th=
e global management to<br>management_query_multiline_flatten_newline() whil=
e using its man<br>argument for the state and input buffers=2E No functiona=
l change, the<br>only caller passes the global=2E<br><br>Change-Id: Ifc12da=
fe9621ca00dc0022ad426afebcf38fbc3b<br>Signed-off-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094<=
br>Message-Id: &lt;20261102170041=2E110861-1-frank@lichtenheld=2Ecom&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40455=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 2 insertion=
s(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/94/2094/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 58f63e6=2E=
=2Ed3b2e7c 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3998,8 +3998,8 @@</spa=
n><br><span> </span><br><span>     char *result;</span><br><span>     resul=
t =3D management_query_multiline_flatten_newline(</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        management, NULL, (char *)buf_bptr(&amp=
;buf_prompt), &quot;certificate&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        &amp;man-&gt;connection=2Eext_cert_state, &amp;man=
-&gt;connection=2Eext_cert_input);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        man, NULL, (char *)buf_bptr(&amp;buf_prompt), &quot;=
certificate&quot;, &amp;man-&gt;connection=2Eext_cert_state,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        &amp;man-&gt;connection=2E=
ext_cert_input);</span><br><span>     free_buf(&amp;buf_prompt);</span><br>=
<span>     return result;</span><br><span> }</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Demail"=
>change 2094</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
94?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2094 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--fVjvQuvd+hc=--


--===============5473299732563655987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5473299732563655987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5473299732563655987==--

