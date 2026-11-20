Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28185606A32C
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=k3c7YxZv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ub8Dqs+L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QEInqj3D;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KuhRz6+o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=QO8J4J+hdaNaZsJdR/4O4LU8NJNSoPx8dJmoSe0u7jI=; b=k3c7YxZvpsyVXurLG7o5WlVQxK
	gCpcTnhAnnLXDzoFpUxwtG+wzJM3U2RH+fTXPruEqM4P6kqcRHIk1Xs2p+uB5DvPWOzDb7K0JNxBE
	sVk3am9uL5FfSYLSTUfIapsqBbAh+J1rF5G4glGzQlRhMJ90ORXWnz2MZ0ZZ2JZscMDI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUR6w-000000000DY-1y0W;
	Fri, 20 Nov 2026 16:05:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUR6t-000000000DQ-3VBy
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:05:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PV6ZeiAhoGM9RZV7dzizEiqeteCd2tSNkaaD4hfs7mM=; b=Ub8Dqs+Ln9bilRWAQvvHYGwfn0
 yuRqmsle9x+gUK4WYLvOGvsNm+f/DDwIx7GzB088GWK0YisXla2hepPcoscmrXk2wCScB9wqGjTFF
 MGhayDicZqAfUibeF6ssHy1SZjebUVk8m8p3rQV3Nhs41MFpb+m5EScOmlFMFMJpF5gA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PV6ZeiAhoGM9RZV7dzizEiqeteCd2tSNkaaD4hfs7mM=; b=QEInqj3Dp6j9/5b+pMSU0+cTmg
 cTfkIa0hFBghcDdZZSuWFz4cIAuZj6DNdUkmgniL43mo/DcJOqpeGihxcxyCyAZ8XsIoZWrWj8zfX
 M9wXZ3hUI/0QbxAaUiw7f7HEf/wy73A7I6oq3zE/K5As0l5ZMoy1wC2skWINxIE35oNM=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUR6r-000000004Kn-3s3d for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:05:11 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso7876925e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795190703; x=1795795503; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PV6ZeiAhoGM9RZV7dzizEiqeteCd2tSNkaaD4hfs7mM=;
 b=KuhRz6+o1lexf1pzJzqXk9+8u1tFgfCW3p3HKnNWKdWokanuyT0niMebaviH1Rv9pR
 pSpriGTpc+xCcv5WMNWLEJRoWc9ffuEhLEPimtrDQXqtn9IRtlfmTGIxMz6BSMhX7PEt
 xzekZsi9PmRq+PeTYMDrP06uxjBTvkpKAiIGnTLCDbTKqg1huaabLUuPvPIA5rf35Hgg
 LLzq6UaGSABm+BLeFt29b+DUiNcNg3NABBoJWtiRbzqeM8iwVU53Y2Mu+9BTFdST7Srb
 3qhP5047PICJ6gVN+T39tQfEj7o1tXzdto8Uc/0a3q2jISfoWlyd+uWP4K0fzLwcdlCQ
 NpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190703; x=1795795503;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PV6ZeiAhoGM9RZV7dzizEiqeteCd2tSNkaaD4hfs7mM=;
 b=CEYfB2QikzFgQN4vLmQ8w7YwI9rSLBQBuhND4YE08lb5y2XnSfht+eGoUCMIe0RYaT
 ofokR73myNcymId8okIruCbPfLUiL5O2iAq1NOdX+ufunhpIQC+M2IrBVezqvs7AHT/t
 x9vgZ/2vP8KMOncYhDsVLfCzzFwtDgdSGpN2n6WqN2vtBPanI07bm0Lqr+NiDRaaPPka
 k6qmvegb+aduwdqEFPLf/Hsa5PW2hTrHjufIg2AeH4P2WSDWbyPqNKX4VAKgU9zY6vjB
 Fj9ceypfro88/iXeUHH9XPa7eNzYdo6wDJ+GagWiIFj89jdJk0hTr+w+IY+ByYG568eY
 8BUw==
X-Gm-Message-State: APuU4Z/iasC8uNvnesyCwVRapKnx2LIupgiT9nAgNhhFvyeKAblseEID
 apcZkl6znUo/yajxe+lL+z4MyWL6zR3b5izojK+tMc4ZSbNKUf5cUPKP+MRiqSc5L+mrJ0wnucb
 m2GzXBqWA71KA1izhSnG+DFg0sl4j5cRe6NFoX8YUeEoWJKnqb6SLdw/zFWwTcD8IEEb4
X-Gm-Gg: AYBFou1Ir5Yx40Wh5osQdNxa+QMt5L2gYTfUl5+aCQawLrsTbkP0vUoGmAt1Z60pXfU
 PqS0nzEct6SAwLn81wz8ZcemTEYXrvleuKX2ciPIkQEYYDopHDtUMxGjEl2OV95nVhrNO8AOod+
 JCzztlYNGZeqU/p5FeLa5VTyAo0+wwqyraH0xMKEbSuWmgw34r/4HXp3TgJnn+7isJVPPpDcGev
 QLs8VG/ilDurKEOnAj9udM6EWk61K23I0hbjf9uHqldG3YlmXzLaScYwEkPSleR/BA7yc1Kxz5L
 weuWkrLivOtVzIT6UXu77LCy6y/uEMph5/fWQM+LR7lPHadBGIptVKBSNZhqiZUHCSuiJb+LtkM
 pAPj8XXVX63NdyYlWpovnVk+fQuDIija97ojPTWfnNGqC4KBAVwe0z68OvxRSbkjJj9ulykeRt1
 BwVoobSuS1hn+WXF+U2z02hKJ3xTZxv0QXoIDItym9+jfdB2XRzkHAxhEPjds3tqxt4ADuOrIzC
 2t11iTfqpvsg2YFa+xfgtRCbAXVBelbOOqNmanMV7lr9ijZBId/8LO2U1Z+g3TNhqzPEVaMkPEu
 d/4svTcm2PIaa83FkRwCo1IEWftn0gBuRIX1tNUkAlQujauY9w704cFY87HCZ0C/tWhSvbLhvnW
 KB4s+Awk0sUZwQqXdKnO1cE9B+WsMdAHBUYbQG2hVbC/4tH6cyY9+7VIH38uSonaF73nJniRBCK
 KCCUu1E8g4XAkSafQ=
X-Received: by 2002:a05:600c:3555:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4bb8882907fmr81473775e9.34.1795190703192; 
 Fri, 20 Nov 2026 08:05:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm183994495e9.13.2026.11.20.08.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:05:02 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 16:05:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
X-Gerrit-Change-Number: 2231
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2231?usp=email>
X-Gerrit-Commit: 04234c52a55a032ae373518f00ff7cfca8d1ea02
References: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwNzAwMDAwLkllZDY1MjAyZDI2OWRlZGZhN2NlNjllNjJlZjY4ZDc3NWVjMGRhMzZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6120eb13def8a1ddb3339484f197c2760cd7f02d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUR6r-000000004Kn-3s3d
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
Content-Type: multipart/mixed; boundary="===============1833993914891777251=="
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1833993914891777251==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZwBjWJeQDPM="; charset=UTF-8

--ZwBjWJeQDPM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2231?usp=3Demail

to review the following change=2E
=


Change subject: manage: use report_command_status() for client-deny, clie=
nt-kill, push-update
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

manage: use report_command_status() for client-deny, client-kill, p=
ush-update

These printed the same SUCCESS/ERROR lines by hand=2E Output is=
 unchanged=2E

Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
---
M s=
rc/openvpn/manage=2Ec
1 file changed, 3 insertions(+), 22 deletions(-)



 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2231/1=


diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 86c498=
e=2E=2Eab814d5 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -1286,14 +1286,7 @@
         {
             const bool status =3D (=
*man->persist=2Ecallback=2Eclient_auth)(
                 man->persist=2Eca=
llback=2Earg, cid, kid, false, reason, client_reason, NULL);
-            i=
f (status)
-            {
-                msg(M_CLIENT, "SUCCESS: client-d=
eny command succeeded");
-            }
-            else
-            {
- =
               msg(M_CLIENT, "ERROR: client-deny command failed");
-       =
     }
+            report_command_status(status, "client-deny");
         =
}
         else
         {
@@ -1312,14 +1305,7 @@
         {
             c=
onst bool status =3D
                 (*man->persist=2Ecallback=2Ekill_by_c=
id)(man->persist=2Ecallback=2Earg, cid, kill_msg);
-            if (status)=

-            {
-                msg(M_CLIENT, "SUCCESS: client-kill comman=
d succeeded");
-            }
-            else
-            {
-           =
     msg(M_CLIENT, "ERROR: client-kill command failed");
-            }
+  =
          report_command_status(status, "client-kill");
         }
        =
 else
         {
@@ -1523,12 +1509,7 @@
         status =3D (*man->persist=
=2Ecallback=2Epush_update_by_cid)(man->persist=2Ecallback=2Earg, cid, p[2])=
;
     }
 
-    if (status)
-    {
-        msg(M_CLIENT, "SUCCESS: push-up=
date command succeeded");
-        return;
-    }
-    msg(M_CLIENT, "ERROR=
: push-update command failed");
+    report_command_status(status, "push-up=
date");
 }
 
 static void

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2231?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
Gerrit-Change-Number: 22=
31
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ZwBjWJeQDPM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: use report_command_status() for client-deny, cl=
ient-kill, push-update<br><br>These printed the same SUCCESS/ERROR lines by=
 hand=2E Output is unchanged=2E<br><br>Change-Id: Ied65202d269dedfa7ce69e62=
ef68d775ec0da36c<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 3 in=
sertions(+), 22 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2231/1</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 86c=
498e=2E=2Eab814d5 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span=
><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -1286,14 +1286,7=
 @@</span><br><span>         {</span><br><span>             const bool stat=
us =3D (*man-&gt;persist=2Ecallback=2Eclient_auth)(</span><br><span>       =
          man-&gt;persist=2Ecallback=2Earg, cid, kid, false, reason, client=
_reason, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    msg(M_CLIENT, &quot;SUCCESS: client-deny command succeeded&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                msg(M_CLIENT, &quot;ERROR: clie=
nt-deny command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            report_command_status(status, &quot;client-deny&quot;);</spa=
n><br><span>         }</span><br><span>         else</span><br><span>      =
   {</span><br><span>@@ -1312,14 +1305,7 @@</span><br><span>         {</spa=
n><br><span>             const bool status =3D</span><br><span>            =
     (*man-&gt;persist=2Ecallback=2Ekill_by_cid)(man-&gt;persist=2Ecallback=
=2Earg, cid, kill_msg);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (status)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            msg(M_CLIENT, &quot;SUCCESS: client-kill command succeeded&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                msg(M_CLIENT, &quot;ERR=
OR: client-kill command failed&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            report_command_status(status, &quot;client-kill&quot=
;);</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span>@@ -1523,12 +1509,7 @@</span><br><span>       =
  status =3D (*man-&gt;persist=2Ecallback=2Epush_update_by_cid)(man-&gt;per=
sist=2Ecallback=2Earg, cid, p[2]);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quot;SUCCESS: push-u=
pdate command succeeded&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_CL=
IENT, &quot;ERROR: push-update command failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    report_command_status(status, &quot;p=
ush-update&quot;);</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2231?usp=3Demail">change 2231</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: Ied65202d269dedfa7ce69e6=
2ef68d775ec0da36c </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 2231 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ZwBjWJeQDPM=--


--===============1833993914891777251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1833993914891777251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1833993914891777251==--

