Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB97606A31F
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HAfsvIgr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QfdmiE1i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kHmps6ce;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FcThIRYo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VQ7MaeQDijnuCrU98ubdtenbH4VhfFfVMSXcBVXlkpE=; b=HAfsvIgr17tU/M2CeIqwuUXIh9
	Q1aivVERFDITjkyuxwxCR0erSo9Ocq7YUG4P5SHtHmihujFhy77U7Wj3XGjAzI56OUg61edk0JzQQ
	cnlnWDWetFBG/dFg01/oozjeaA4h3MAQ5l7TaJeRG8J+jo+ZzghDXIUAmU1NwVoq4gAY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSazG-000000005Re-3ojf;
	Sun, 15 Nov 2026 14:13:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSazF-000000005RY-2bXP
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+S8EOiISUpSFyL0P5oAIEDqmoPTNllEpDXmxhrz2bHE=; b=QfdmiE1icN4ciYTYlssqJnIKyT
 9Dec/O9BXRXeahOLMAyW4qU9vooKYcUX9so6kBVcV/aRKeVCfwkHl8+7JeUyMAc3/W04AuXk1IMfp
 w0kSH2CvMnGFoFtYBivj/yt27rJVFrYH0bywGT4o7D02YCAGGjr/x24hEKQbs7fmD8WU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+S8EOiISUpSFyL0P5oAIEDqmoPTNllEpDXmxhrz2bHE=; b=kHmps6ceujZ1p33S6Tel4kfeXl
 J95Wy9ePZbQswt0ny0T62XqXqKLJD4fN/6cceA2U+MhUozJ/NSIwHCnmz6K1Ts6ubujmHKBd3tSkm
 0Z35K4kJwNliG3jFN44vHgy4sp6UkX99nfAauqXcQgnaEngsadiPD1jk44yE49Wn29iY=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSazE-000000001ru-3k3x for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:13:41 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so1102028f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794752014; x=1795356814; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+S8EOiISUpSFyL0P5oAIEDqmoPTNllEpDXmxhrz2bHE=;
 b=FcThIRYoOl07X2xxrkki2S7yqlP9p7/QJkLuI4+llJcH2pNJ51WymF4VnijISs16to
 SMtTTICFszgJAJyl8He+TpraYYznNnqzz/0Ngg0S681J0yTsTVykkYMelSmPPgx1kpiv
 woiTmhYHTzgunLHeTN5AzxfVX+3dUxcTRk+WldvoM/A6NFmUnnf/UNrluZMzYdKurnPF
 8M0zNXtJ8n3lR3DyKkLa5ewSTcz6CFJ5iHzEWtMLFNLUFzcsrt5K3yR65BWcFOdgvcuf
 PK9UuZXYrDI2j3OLsXvhVC3AJlS/BGbuuoUSa3Gn5nzNk8oQONjjqxHwwtKclw4iDy1H
 4vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794752014; x=1795356814;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+S8EOiISUpSFyL0P5oAIEDqmoPTNllEpDXmxhrz2bHE=;
 b=2Zw5+U7eI6P9sobzFcbDbF3aVn/sgEpr77oCceBe9w/s1CXtcQx3A+ERisT8zpoj2M
 obeGEO74dZwWKG08VKYdhWyby+fR5tPy6cqP5PgYf8ypxEYj6sTNnCFLVnEDADHQpaze
 0H4XVCa0JXR9dhewpSuVWcrz6/DpQVst2tQpc6CZGDd1VPTF12sI4UByu3ctkGY2aI0/
 kKJHtWHOoX6a0AVJS9Q1aT+TUtyR12U2aTqMfRKHant0r6T8o/zfyhNVPIsBdHQF/4yN
 nV6+8vwnwy6XHIFbDP/4V80SGVzMHbHx/PiVstk5ENxvsDmw+X+GhOt2btHZV1yBIu4n
 aawA==
X-Forwarded-Encrypted: i=1;
 AL+hErHWuBLUmVA9ztEdvow6roiRRx6A1H7ESsWBvCZDlpUCbW+nGf9aW97qRfzvA4+cgcNgAucJjEYet0uPfd/o@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Tdx7A1CobxobGWZH3kilfhsR8ugQgqHdUxxYszCDWDOIE9qfX
 Xlco3KyPlBWbHf7IK/09X68zG827QLJgyB4ZePWHi3NaZhuxFXIPqU/uZY27hMEbciMKHVzRIow
 UFGyEP6dcb+JN9VMfiAEmo+hESfqRnae/SJZbFxb3AY1ebnleIQ6mqOss0ItsFrSair8x
X-Gm-Gg: AYBFou1uUZAYpU6Ip8LFUb1pEOxv2fKpFHDGFa7OtegNZWiNeKZMWac5k3EHRwbG/Sb
 +KcY9Ok0ptUoqW82VhvMDx63T7NovmY27cdImJskLlK5r4H4rkKYs77JYlJk8gMBqnM8BIEFyf2
 xr4DVjNPljzfWXRt3gVgMQSCSgaFdXERKxUHzxMPlblMeAGj2/T4qhOuetNsry6pZ07RXOYnkRA
 C6WGHfVkQhv3veBh/Np6vFnPhHMcaehTueUciGrVteEQSMFw0+78W3XqP9cQvvPZDgJGbsu9iFB
 H484nGWDES2tuSqLRCl83draf1wHr2rodxr8XirOu5exZwp74NB2qnVgl/7WWlijybK0n1PNqV+
 obsK8J7Edj8lxphbSDZMLLVTmM5bvX+VUK+tN/mHWS5lalhBNINumLJeV6pMjnbiR325MOGMety
 tuxSYMSodqhw0/tPTE+A8I7+BEk0YBDWQ2WhRWHfBjmHJGIhnAGxGuLcbdsvgJDo0Y1vO3jBnZ6
 L8QUQMF+hiYEmcCPKua6X9KaNXFJxZ0JE3pmU/PQFra6eIs/695UYDXajlPNTz/IUPbEg1u1XDC
 w27Hp1LIM92u8Evxjg5H30Dd4A+30pQsD7/z14ukUo9Qwz6cGEpyh+zHC2eeRqRmUNpOCvyWEoB
 vNyY2EmPAFChqR/zqEipUIB2LDrrHuVb22GPPf5nerZmLxAr7H9lV6USB5JF6Y1ZNQonIKn2JpI
 /hfjV+Al9uxby2EBo=
X-Received: by 2002:a05:6000:2082:b0:48e:7470:9e98 with SMTP id
 ffacd0b85a97d-49c726dadb2mr18081927f8f.39.1794752014151; 
 Sun, 15 Nov 2026 06:13:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d223b21sm18509650f8f.2.2026.11.15.06.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 06:13:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 14:13:33 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
X-Gerrit-Change-Number: 2125
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2125?usp=email>
X-Gerrit-Commit: 5bd4216b44b523efad1af3176dad40ecabbcfe14
In-Reply-To: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
References: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5OTAwMDAwLkk0MDA1OWViOWFmODQ1YTUwNzBlYmI4Y2FmZjc0MWIwNzk0NjMyZGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3556508a6636c315fe53354b5209f18a8607acd4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSazE-000000001ru-3k3x
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3904592265555248852=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3904592265555248852==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1XxhMKFGzA4="; charset=UTF-8

--1XxhMKFGzA4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2125?usp=3Demail )

Change subject: manage: drop unused input p=
arameter of management_query_multiline()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: drop unused input parameter of managem=
ent_query_multiline()

The parameter has never been used since the function=
 was added in
39e3d336 ("Mac OS X Keychain management client")=2E Its calle=
rs read the
input list themselves=2E

Change-Id: I40059eb9af845a5070ebb8caf=
f741b0794632de2
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acke=
d-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2125
Message-Id: <20261104124859=2E18417-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg40679=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 3 inserti=
ons(+), 3 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec
index b8a0408=2E=2Eca0a7dd 100644
--- a/src/openvpn/manage=2Ec=

+++ b/src/openvpn/manage=2Ec
@@ -3856,7 +3856,7 @@
 
 static int
 manageme=
nt_query_multiline(struct management *man, const char *b64_data, const char=
 *prompt,
-                           const char *cmd, int *state, struct b=
uffer_list **input)
+                           const char *cmd, int *state=
)
 {
     struct gc_arena gc =3D gc_new();
     int ret =3D 0;
@@ -3940,7 +=
3940,7 @@
     int ok;
     char *result =3D NULL;
 
-    ok =3D management=
_query_multiline(man, b64_data, prompt, cmd, state, input);
+    ok =3D man=
agement_query_multiline(man, b64_data, prompt, cmd, state);
     if (ok && =
buffer_list_defined(*input))
     {
         buffer_list_aggregate_separato=
r(*input, 10000, "\n");
@@ -3967,7 +3967,7 @@
 {
     char *result =3D NULL=
;
 
-    const int ok =3D management_query_multiline(man, b64_data, prompt,=
 cmd, state, input);
+    const int ok =3D management_query_multiline(man, =
b64_data, prompt, cmd, state);
     if (ok && buffer_list_defined(*input))
=
     {
         buffer_list_aggregate(*input, 2048);

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
=
Gerrit-Change-Number: 2125
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--1XxhMKFGzA4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2125?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: drop unused input paramete=
r of management_query_multiline()<br><br>The parameter has never been used =
since the function was added in<br>39e3d336 (&quot;Mac OS X Keychain manage=
ment client&quot;)=2E Its callers read the<br>input list themselves=2E<br><=
br>Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2<br>Signed-off-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2125<br>Message-Id: &lt;20261104124859=2E18417-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg40679=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file ch=
anged, 3 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index b8a0408=2E=
=2Eca0a7dd 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3856,7 +3856,7 @@</spa=
n><br><span> </span><br><span> static int</span><br><span> management_query=
_multiline(struct management *man, const char *b64_data, const char *prompt=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
       const char *cmd, int *state, struct buffer_list **input)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                           cons=
t char *cmd, int *state)</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     int ret =3D 0;</span><br><span>=
@@ -3940,7 +3940,7 @@</span><br><span>     int ok;</span><br><span>     cha=
r *result =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    ok =3D management_query_multiline(man, b64_data, prompt=
, cmd, state, input);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ok =3D management_query_multiline(man, b64_data, prompt, cmd, state);=
</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*input))</span>=
<br><span>     {</span><br><span>         buffer_list_aggregate_separator(*=
input, 10000, &quot;\n&quot;);</span><br><span>@@ -3967,7 +3967,7 @@</span>=
<br><span> {</span><br><span>     char *result =3D NULL;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ok =3D m=
anagement_query_multiline(man, b64_data, prompt, cmd, state, input);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ok =3D manag=
ement_query_multiline(man, b64_data, prompt, cmd, state);</span><br><span> =
    if (ok &amp;&amp; buffer_list_defined(*input))</span><br><span>     {</=
span><br><span>         buffer_list_aggregate(*input, 2048);</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
125?usp=3Demail">change 2125</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2125?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merge=
d </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2125 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--1XxhMKFGzA4=--


--===============3904592265555248852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3904592265555248852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3904592265555248852==--

