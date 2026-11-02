Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2E606A337
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KbmAYCou;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CxpCsCtL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jzekhgkl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ccogB6d6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=q2xic+YDCRfeGYXgHGJhhWWxnQgiacj+3GEnpEp4zas=; b=KbmAYCou9LChFFeAL+cfA7frMf
	qQin/FrsVq5yong5KNCGwNRtp+PhMMGmd9ukSJ3fVVm8rzsfQDQFJe22sZH+cVWhOw5K48LpMp0n4
	vzUw7M+T+82tCPARShv9wQrCPTkpJio8BylbyQ5TRcnJRNVIdRMgcgjo2tEEl4YoeW+0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNwAC-000000005U2-0CmW;
	Mon, 02 Nov 2026 17:49:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNwAA-000000005Tv-2HQG
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W58fTz6Cw44VNFUW06D7briMf/2joJg8YXtynpIGJvk=; b=CxpCsCtL1oluTPg4QAp0AkRvp+
 c2D/aSIr2DarhtdVvw9z+3Sm8bz6Q8E8YXVPwgclSDJB72MRCuOtoySvUxFI48c8CI35kVvDYL16Y
 7I1VDldaHZvp97oz6Tlo7S99IpKge0DStsrMqwljmzC+a9P1S02nS14uJ7vfSxSnAO38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W58fTz6Cw44VNFUW06D7briMf/2joJg8YXtynpIGJvk=; b=jzekhgklzwxm5Nfcr+7VV1RBFk
 PCseLl2wckKISIweke3UtYdkqV6ujS1Ol1sV1QIagO1jqpFYaFH2fvxxmV7HbRNMv08OYPylwCuJn
 uci9oebGmdNUSl/8FkebvHtj3aRPDsP9wEZflb144UA/zXudu2mLzvONWsu64XCH9jy4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNwA8-000000007Ge-3lz3 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:49:42 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so25434155e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793641774; x=1794246574; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W58fTz6Cw44VNFUW06D7briMf/2joJg8YXtynpIGJvk=;
 b=ccogB6d6hng2PAUuH+qnrZmnRcgC4Hs4HQIGBHES146Dx71OM17OefboKxIrfcpzIn
 Aw0zDpz3s5ltA4AvIDvERQqaCAo+whxCg5sJSI3zqGl/Jfcv8yjCmIHsj7EVQ6X8x1Mw
 hUaW7qU5jAMO+YF8azcQjrw+tb7Rs/5wVs5CuTKqEV/Yt5/aZX8n49aoxZNLUd8K/mpN
 AZ17QxH5C/8s8QQPrIKFOP5dYX7XJpsoz9NCpOPMMPXkYnvkb/l70QdsTLrE2tdwSkj3
 UcdKi6VoDo5NhPF/Dt25zioqaBtyMM4wLtm9GIuKyISvYMqHfxdlpGDZTVINgo6reMdu
 3AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793641774; x=1794246574;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W58fTz6Cw44VNFUW06D7briMf/2joJg8YXtynpIGJvk=;
 b=VA+wSopoPyPJ8Q7Y/6uIP2HHL0djUf42E8aW38FA+y5m3v0CX1pRWe8fMN80YxZvqo
 EYTu+mqOVwF/DKsOOVsv95zcON3rRaZ3JuBXeK85sbaCDPj7AjFxwZqQgsuEs9KxD1qL
 bkdbCviACwKuT3JKagCASuZtUZFsW9nsz9Lf3D16wn618Mp9VHPWOsdvbauZeUdHP58p
 o/WRvMIR3/b+wCZuc8dyfZdB6iCjeDkmS0YMJvDGTA1WBHUsfqyIC9vogcuYyQNlrB4U
 NHiPWI47eSGrWc6LpntzE1Ncr7ww7G0YpKAxfddHHrJK6vlpXJLXWgMqms9wafA+QydA
 szvQ==
X-Gm-Message-State: AFq9FYLx9yBcGId1tikm73wiPktEf2qOo1zeIvpcMU3dCcL7+FIVYhJM
 15TqYPR1qr4IgxKi3GZQ8zS5VfCMfuACuxoSbFTZqO9pNKwwE9ua7t2FvW+XCqMrP1A9fOAzA7i
 EYKSOncw9d6/i3oc2j/EqKLN2/zt9P+8oCAPAP5WMASkiLTpC1KE1Ll3gXqQHk9ZrihVev17cQA
 CwysDE1A==
X-Gm-Gg: AYBFou3BGWVPuQxDQ+aNFE7u2j5ZduTWQWz9KP+7pBdLiwDfYXWZcx9ysP2AiMoyznm
 7k+/05/d3K+KRgO2zN8nIohIunTMaSMQtHGXWnD4hDOtbbZayOMeCuQPGsDmEpoNslJUzfM5+uS
 wJYr1vzZT46nKGwemZ6NVUEbYNL0VMeeZQnpAHzpXom+OJxNc4c97Num5cNFOLIDt6SgBYUKXRe
 AetjXYYm25wTGjAYniO+Xto6g8DzDBSNPbwkOMI14YHV37q+Hpf3LwPNDDm1Y/r2MGNUA5b1f7z
 7bSLt3O22kbUJmves3Nk0iOzMfE29Sq4ONmMxQ/ZC56T3z4aUQpfyZ23jMQ466h5UaeGB3BKZFQ
 1GrD24U5a8SFBLQaiQSzfLaEprVF+2P7SmUA66jnr/9eMXQ1+JvjCPQxpYMr6ZGvj2RPiZjsBzs
 zYggRlNl9jTb6MrSk+aPELrolorE96tmige1LzJW/qq3SPiGMMHQelj8PGd7HOvVlpg6g+Id7F5
 nOf5ipSdMiHoEFwRoinxlqBMfI1nZFqlZqb6lz7FnwhyXjFTURebOZdmUeia9hr0OYYvpt09Xaj
 yB+duOVWozOI6lhmqEIC0FFODcwQsamE5zMIoD9DtKc14DiReqhJOxix+Oj0s3VFGxl0DBHSqRx
 fCNtOLCJmlsuV0YcvOrDyaKFYU+sLnJ3R9iEAYrhkUTzbKcWjq41KcKozq1zmJaQb7c6eoFpgG/
 kweEF9Liv2aFTTogNI5ZkdWfIC84sg+zfcQe4=
X-Received: by 2002:a05:600c:6087:b0:4a1:fe26:24f0 with SMTP id
 5b1f17b1804b1-4ac1765ce52mr239458245e9.20.1793641774136; 
 Mon, 02 Nov 2026 09:49:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm3829705e9.13.2026.11.02.09.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:49:33 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 17:49:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iecdf8c79b2a3aabf26476c7a36c4b132fcef9e45
X-Gerrit-Change-Number: 2095
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2095?usp=email>
X-Gerrit-Commit: d3e3900951a7d03dec08f0378248e606fd8830a5
References: <gerrit.1793641772000.Iecdf8c79b2a3aabf26476c7a36c4b132fcef9e45@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjQxNzcyMDAwLkllY2RmOGM3OWIyYTNhYWJmMjY0NzZjN2EzNmM0YjEzMmZjZWY5ZTQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <94b973b38f015420311e88e1565c15521732475e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNwA8-000000007Ge-3lz3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: simplify
 management_callback_send_cc_message()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1463207407104359445=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1463207407104359445==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fN1qrGcGfLs="; charset=UTF-8

--fN1qrGcGfLs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2095?usp=3Demail

to review the following change=2E
=


Change subject: init: simplify management_callback_send_cc_message()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: simplify m=
anagement_callback_send_cc_message()

buf_printf() already fails when the o=
utput does not fit, so size the
buffer to PUSH_BUNDLE_SIZE and drop the sep=
arate length calculation
and its second parameters check=2E The size limit =
is unchanged=2E

Change-Id: Iecdf8c79b2a3aabf26476c7a36c4b132fcef9e45
Signe=
d-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/init=2E=
c
1 file changed, 5 insertions(+), 15 deletions(-)



  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/2095/1

diff --git a/src/o=
penvpn/init=2Ec b/src/openvpn/init=2Ec
index 6c87865=2E=2E035f7b6 100644
--=
- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -299,24 +299,14 @@
 =
management_callback_send_cc_message(void *arg, const char *command, const c=
har *parameters)
 {
     struct context *c =3D (struct context *)arg;
-    =
size_t len =3D strlen(command) + 1;
-    if (parameters)
-    {
-        le=
n +=3D 1 + strlen(parameters);
-    }
-    if (len > PUSH_BUNDLE_SIZE)
-   =
 {
-        return false;
-    }
-
     struct gc_arena gc =3D gc_new();
- =
   struct buffer buf =3D alloc_buf_gc(len, &gc);
-    ASSERT(buf_printf(&bu=
f, "%s", command));
-    if (parameters)
+    struct buffer buf =3D alloc_b=
uf_gc(PUSH_BUNDLE_SIZE, &gc);
+    bool status =3D false;
+
+    if (buf_pr=
intf(&buf, "%s", command) && (!parameters || buf_printf(&buf, ",%s", parame=
ters)))
     {
-        ASSERT(buf_printf(&buf, ",%s", parameters));
+     =
   status =3D send_control_channel_string(c, BSTR(&buf), D_PUSH);
     }
- =
   bool status =3D send_control_channel_string(c, BSTR(&buf), D_PUSH);
 
  =
   gc_free(&gc);
     return status;

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2095?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Iecdf8c79b2a3aabf26476c7a36c4b132fcef9e45
Gerrit-Change=
-Number: 2095
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--fN1qrGcGfLs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2095?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">init: simplify management_callback_send_cc_message()<br=
><br>buf_printf() already fails when the output does not fit, so size the<b=
r>buffer to PUSH_BUNDLE_SIZE and drop the separate length calculation<br>an=
d its second parameters check=2E The size limit is unchanged=2E<br><br>Chan=
ge-Id: Iecdf8c79b2a3aabf26476c7a36c4b132fcef9e45<br>Signed-off-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>1=
 file changed, 5 insertions(+), 15 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/2095/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br>=
<span>index 6c87865=2E=2E035f7b6 100644</span><br><span>--- a/src/openvpn/i=
nit=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -299,=
24 +299,14 @@</span><br><span> management_callback_send_cc_message(void *ar=
g, const char *command, const char *parameters)</span><br><span> {</span><b=
r><span>     struct context *c =3D (struct context *)arg;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D strlen(command) + 1;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (parameters)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        len +=3D 1 + strlen(parameters)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (len &gt; PUSH_BUNDLE_SIZE)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =
=3D alloc_buf_gc(len, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ASSERT(buf_printf(&amp;buf, &quot;%s&quot;, command));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (parameters)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(PUSH_BUNDLE_SIZE, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool status =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (buf_printf(&amp;buf, &quot;%s&quot;, command) &amp;&amp; (!p=
arameters || buf_printf(&amp;buf, &quot;,%s&quot;, parameters)))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        A=
SSERT(buf_printf(&amp;buf, &quot;,%s&quot;, parameters));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        status =3D send_control_chann=
el_string(c, BSTR(&amp;buf), D_PUSH);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bool status =3D send_control_cha=
nnel_string(c, BSTR(&amp;buf), D_PUSH);</span><br><span> </span><br><span> =
    gc_free(&amp;gc);</span><br><span>     return status;</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2095=
?usp=3Demail">change 2095</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2095?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Iecdf8c79b2a3aabf26476c7a36c4b132fcef9e45 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2095 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--fN1qrGcGfLs=--


--===============1463207407104359445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1463207407104359445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1463207407104359445==--

