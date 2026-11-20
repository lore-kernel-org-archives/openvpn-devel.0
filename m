Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E8606A32C
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ae8b9TPN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JifZW4/w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HtPAI+vu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=elZVt9tU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=btt6bYYWQ2qvH5V++CpoVDECqI1h5ZYhCg1MACRIX8c=; b=Ae8b9TPN5TfLsxHEhlFhMNEy09
	tJuamxK6IavrCFBuMg52BVRO2oz0oWcIenm8YB5J35EZyJdiqV+qGXZ7F8+ac0VEi255lqxL2dsx1
	2b5L/ebWtpFfQBh7A9Zwj8fW/p/ZnwC4p5U07M7RLvKebkEsXp/DVvjiGfcnd1R1hEIc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xURGo-000000007jW-2OIV;
	Fri, 20 Nov 2026 16:15:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xURGn-000000007jE-0v8B
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:15:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NKwtIKEs/wygX+AZr9jt9ZbeO7s6j+dHSbONBsKNlOw=; b=JifZW4/wOCf2kGt+mG+Gyr9A6f
 jJtoTsR7c2Z4DOvNCxLGSxb9yLEE7jA+syNuFkF33/og94iFJIMvCbPVXx+ZHf9g949ZDutsrS/wS
 yXRoMO9NreVM2pku5XhNItyZtiIIUB1+HBYPGGNCfYSIdWOXEIsVt5HWFZHMsOtfTNXM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NKwtIKEs/wygX+AZr9jt9ZbeO7s6j+dHSbONBsKNlOw=; b=HtPAI+vu0zth+3VZjTq2Jlle3u
 sy+gJIr5jufFwoVKM581K1jYJpbMxI/FClUuOrcVfj3EL4Owlsj8D0POwatjxeJjxyL5NN7x8NVt5
 i0ikG++9uNUOkrtFRk7NFlR1u5MP5A/bnIFJCBmyFsPs9uDZk3PXRPnduMkgftdQMzxc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xURGj-000000004bs-1gjk for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:15:25 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so10765255e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795191315; x=1795796115; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NKwtIKEs/wygX+AZr9jt9ZbeO7s6j+dHSbONBsKNlOw=;
 b=elZVt9tU7ZpcKEF0/5liBpBnCi3YSO8f5QPy6U6NE+FvKC9Q2uWClum2MyxNZIFed5
 98gR6JdzjVYCMEfhw1U7IJOPKlMnVzgm1SSv5YOoz6hCew2WiZCthQvltxL5eE/GZcv5
 4yh0ElYC3gtr8yLuP31q7npxwgGgOgCB7YuowNOqUJsgFY1qQlgcLdwqg57Bv04qyMB7
 WaXiy8PA+ZAoQIM/RmYdsEJeomAabQavFBi3nKpZ2WfADEJ8y5GHcnZD6xmK5EwqkFka
 lTqlouSefwiLQ2lz+5qZhaPlO4J/5KXlgWE8vb48+Ib9TGcXVwF9r+eTP0QsZMS2gAMn
 xaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795191315; x=1795796115;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NKwtIKEs/wygX+AZr9jt9ZbeO7s6j+dHSbONBsKNlOw=;
 b=kL0ja9lei6YhULO08gHjAcsv6NHdQ8/GG8+VxJxG/a0Re4qL9JOWgWo8PZhI1o3ut/
 iA1MrhUaEWkbcBzE724+SmgXuItt/3J8XSbjWHaMePZEZNyjrZxm4sKqA7nwcBH1ylpf
 sqpr7vZ12UD6oWRQ2sDA3RFzAN/tsuY+ic8yyn3EchMtthAsAZJqnqHSY7yHZhEPvlBY
 OujoeBD7c/23aBSeDF+asRwDTDTBVu4hI9bqaw3ncbNVjIfBKpUa8yT7CuocYf1s2poW
 8/V8NXa+9l5LVJp+BlcPA3K5ehFhPI/6xst4jXVLkhbHRlTlOQ/Sg6cRKgF3t5u3oGwu
 gDJA==
X-Gm-Message-State: APuU4Z8KvWpZ0XJmuCRFWwpi31JMeUEHjKdyEwg2nJYvjEc1pkXGAHNT
 k/fiTRiBHpFJhh0HH1gLTjy7ncxuhwFknu4UiciemilQTp3sRZrxrsPJjmgwJxnoVRe5+PtvZ4B
 ABjVC7dkSr93aR+Zb6UK9J2xBlwDXxmn366zaWgHXQOjd2e2hUJLatNUUzuXo0q0y8bb6q2kkxU
 /XTgP5mQ==
X-Gm-Gg: AYBFou2cw4ryBE50aH4BIgTRdP8GALCbo6KQRwRBulEBIORsm8tn5fHd5qkdf7HN7Uv
 zeox6tfO0y56FZ6hw0tu0+JxpjC4w/KwZe5JJ2A/TxIdBs5lMq9siEvvzWvc3PvjmHGtgBE17UC
 5urE8ThEwMy4BDPOJzv2lZhQIOxDsQ811YoYe+5kLpYRQUhwMJ9EllUvIOf7n8hkcRYZUAD0bPJ
 NZQDft3xGSL6Vn6xfIEUbaCE7YZ9u3a2wQGPF9iqjPn5GJfK8qA7R9BUI0AiQS4lCg8RQAeCjNi
 LWo27D/u4DSuWEa+ZC4lGzNNvXWvI0yO9ZCk/xCJ+CGyji61t3C4OYY9W08isbJWg6ypdczRfew
 lnqsenLBSYN0uFfsVvN8p/GHYOXUWd6T+6rSNOlold44Gmkw9SYh8AEpFvNDa4x+nI4SLZO6i0V
 d6Q++eMjd3rIMK0dz0coWYx6Vhk0cs68/wHo6VC1OLFOozQGdsLHqviuPpaWa8JJeNUEFRTrWRX
 5op6UYvq3ujMeWo12f8/rxQiTe5MKw1dmVhe1VCupiVGl70TNqPOTJg0A1O9CBDVSmpRR7p4qmk
 kMwLQ9Guffm4ljZf4282CfNhAVXGB0DfWJ7svZmf8iFraR2EnTscCPbDgNRzEL7ltJEBuAtjYEJ
 SsVij2QYm8LWZfq3/iES6t/9Bt9arLlyCu6/6FRAA2vRk99Sbi0zFMSQVweHv2IYD8dxeDhZvxy
 ygX6AaueeNX0L3M3VV
X-Received: by 2002:a05:600c:848d:b0:4bb:52d8:73ef with SMTP id
 5b1f17b1804b1-4bb88940f1bmr81002905e9.34.1795191314686; 
 Fri, 20 Nov 2026 08:15:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e58ab3sm76847065e9.4.2026.11.20.08.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:15:14 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 16:15:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
X-Gerrit-Change-Number: 2231
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2231?usp=email>
X-Gerrit-Commit: ddb0c3e5ac790725e0c76f0adae8b65537ebbc01
In-Reply-To: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
References: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwNzAwMDAwLkllZDY1MjAyZDI2OWRlZGZhN2NlNjllNjJlZjY4ZDc3NWVjMGRhMzZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <016fa41229c81ff56d12603ecfd3d84616a569fa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xURGj-000000004bs-1gjk
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: use
 report_command_status() for client-deny, client-kill, pus...
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
Content-Type: multipart/mixed; boundary="===============0260582269113016411=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0260582269113016411==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i1R62b2Pc5c="; charset=UTF-8

--i1R62b2Pc5c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2231?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: manage: use report_command_status() for client-deny=
, client-kill, push-update
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

manage: use report_command_status() for client-deny, client-k=
ill, push-update

These printed the same SUCCESS/ERROR lines by hand=2E Out=
put is unchanged=2E

Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
S=
igned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/man=
age=2Ec
1 file changed, 3 insertions(+), 22 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2231/2

diff --git a/=
src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 86c498e=2E=2Eab814d5 =
100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -1286,1=
4 +1286,7 @@
         {
             const bool status =3D (*man->persist=
=2Ecallback=2Eclient_auth)(
                 man->persist=2Ecallback=2Earg,=
 cid, kid, false, reason, client_reason, NULL);
-            if (status)
- =
           {
-                msg(M_CLIENT, "SUCCESS: client-deny command s=
ucceeded");
-            }
-            else
-            {
-              =
  msg(M_CLIENT, "ERROR: client-deny command failed");
-            }
+     =
       report_command_status(status, "client-deny");
         }
         el=
se
         {
@@ -1312,14 +1305,7 @@
         {
             const bool sta=
tus =3D
                 (*man->persist=2Ecallback=2Ekill_by_cid)(man->pers=
ist=2Ecallback=2Earg, cid, kill_msg);
-            if (status)
-           =
 {
-                msg(M_CLIENT, "SUCCESS: client-kill command succeeded")=
;
-            }
-            else
-            {
-                msg(M_CL=
IENT, "ERROR: client-kill command failed");
-            }
+            rep=
ort_command_status(status, "client-kill");
         }
         else
       =
  {
@@ -1523,12 +1509,7 @@
         status =3D (*man->persist=2Ecallback=2E=
push_update_by_cid)(man->persist=2Ecallback=2Earg, cid, p[2]);
     }
 
-  =
  if (status)
-    {
-        msg(M_CLIENT, "SUCCESS: push-update command s=
ucceeded");
-        return;
-    }
-    msg(M_CLIENT, "ERROR: push-update =
command failed");
+    report_command_status(status, "push-update");
 }
 
 =
static void

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2231?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ied=
65202d269dedfa7ce69e62ef68d775ec0da36c
Gerrit-Change-Number: 2231
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>

--i1R62b2Pc5c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">manage: use report_command_status() for client-deny, client-kill,=
 push-update<br><br>These printed the same SUCCESS/ERROR lines by hand=2E O=
utput is unchanged=2E<br><br>Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec=
0da36c<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>-=
--<br>M src/openvpn/manage=2Ec<br>1 file changed, 3 insertions(+), 22 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/31/2231/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 86c498e=2E=2Eab814d5 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -1286,14 +1286,7 @@</span><br><span>=
         {</span><br><span>             const bool status =3D (*man-&gt;per=
sist=2Ecallback=2Eclient_auth)(</span><br><span>                 man-&gt;pe=
rsist=2Ecallback=2Earg, cid, kid, false, reason, client_reason, NULL);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (status)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_CLIENT, &q=
uot;SUCCESS: client-deny command succeeded&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                msg(M_CLIENT, &quot;ERROR: client-deny command fail=
ed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            repor=
t_command_status(status, &quot;client-deny&quot;);</span><br><span>        =
 }</span><br><span>         else</span><br><span>         {</span><br><span=
>@@ -1312,14 +1305,7 @@</span><br><span>         {</span><br><span>        =
     const bool status =3D</span><br><span>                 (*man-&gt;persi=
st=2Ecallback=2Ekill_by_cid)(man-&gt;persist=2Ecallback=2Earg, cid, kill_ms=
g);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (st=
atus)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_CL=
IENT, &quot;SUCCESS: client-kill command succeeded&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                msg(M_CLIENT, &quot;ERROR: client-kill comm=
and failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   report_command_status(status, &quot;client-kill&quot;);</span><br><span>=
         }</span><br><span>         else</span><br><span>         {</span><=
br><span>@@ -1523,12 +1509,7 @@</span><br><span>         status =3D (*man-&=
gt;persist=2Ecallback=2Epush_update_by_cid)(man-&gt;persist=2Ecallback=2Ear=
g, cid, p[2]);</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (status)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_CLIENT, &quot;SUCCESS: push-update command succee=
ded&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_CLIENT, &quot;ERROR: p=
ush-update command failed&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    report_command_status(status, &quot;push-update&quot;);</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2231?usp=3Demail">change 2231</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2231?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2231 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--i1R62b2Pc5c=--


--===============0260582269113016411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0260582269113016411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0260582269113016411==--

