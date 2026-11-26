Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB61606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VSeEdvpe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LyLdEVrV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IpisYKpL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VzGwcYtc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=XXcUNDGkrxxem+InK37uFsljI4zLp+a+NCGPE2ZnShw=; b=VSeEdvpeFD5Z1Xi1EpTrOOyvlV
	fJiS6C/8IK7+Y7VGy+YQ0FfMHADGm87EsZgA7x9Cdd+VpyEs3X1KCiyWiHhDexa3Yvov/aXcw37qW
	G2YDccJN4SQ7sRVwRvJK9KAMNrCcoP/uo7L7WO6GOvy/ujfRrkNmC8JtFiCB686B82Es=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWag2-0000000020X-46ft;
	Thu, 26 Nov 2026 14:42:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWag1-0000000020P-3gES
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S0YRnBBgYq5emoqNE7PcThsC+cDK/+76qcss+meq6/o=; b=LyLdEVrV8lnrXuGDqBP8K9ZOPY
 HQw7ICaSGWCxVoX6Hteow8+QPFoZH58SHToheB7XJ3odhmE+pm6tFxcdyhvq+/R5eez2Puwi9cWjn
 MkQd0F3ADHH/9d+2i750hsgK/IXXCOWkA7pS4jbT2leepyfesWPRmZmFIFjAco/M863Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S0YRnBBgYq5emoqNE7PcThsC+cDK/+76qcss+meq6/o=; b=IpisYKpLLYka9FmT5I8Qg09JHL
 +dzYYHSBKe1cbQJoHWhT3X1mk+7VIKFwtvOq4LDv78Dfzpqsx/CSWEyd8xkSpEbvcO0dkLtq+imEq
 ICx2LdG3KdmdrEc4Rwc8+XbHclQ2Gl7AlVX9g6VrTD6oCpZtQ79vYetXyJ+MdW94Hm0M=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWag0-000000001tZ-0hfN for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:42:21 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so4758699f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 06:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795704133; x=1796308933; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S0YRnBBgYq5emoqNE7PcThsC+cDK/+76qcss+meq6/o=;
 b=VzGwcYtcCBgLokcjW9+iHk98/SvVHkBeE/6FWYG3aOd18FtxOn+EDcORJWU06tdp8W
 aO2ajDkglJ4+sO3/7q+VuwhAPP2DtcNw3WwWhfio+D5qucMOqJdU3SR5KNe+aSFtaGsy
 74dslB2zRu7CXWPosgcWGj0kokuUBK8RttkRXp2nKh/O5TCkrhVAGMF7CH2TO+sNYeBB
 k2ABOJZlu/x7hYaArOp634vSl38VL4k3NyMN3DjA7/K8qwlfkQGs98HWe6nQeFg58sVf
 yDY/5Bz3eOThHbaBVwS8tFzs1grsNxXymMGMhM21EzeYTwjr8DooJkr/E30rUINo7glh
 XHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704133; x=1796308933;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S0YRnBBgYq5emoqNE7PcThsC+cDK/+76qcss+meq6/o=;
 b=pl1xGDcslcHeUSB1SF9+VhixaHJJUBJRA3SNq9GCZX+BpYRURNGZfTFPWTcRjgToG+
 ryzM5oIgXBp9PAfqTkYQ7B4VWP7cNCnOns0FFB6bCHghytkafL9xcBbd/AGZfCLpsNXy
 MKn/2v+PWSh3OqW233z3dnIYnC3xBPPtc1FTN65EX9S28e1wcp2eLd21gjen7mCommYK
 /jLJj3Nju7FpZ2ZyyxGKAGMLnBbsaQrVphxdyTMuazf7dXq/UN7JRylfZaK0GYg5KDDM
 n3m9Z1c5/VT6outJKNR9tr6OSfA/tgM/fwAN+pgT2+3sa07dMo/8Q3EbJ7yUzWGeARFF
 In5g==
X-Gm-Message-State: APuU4Z9KbkL+gERbRbyNCEw/KhqG2kfa57V4zmk2worNB9xQVt7119NZ
 JjUVn2G7hnYk4hixl1l7XHhFyDZOunDOdhAhc12XI3Aj2Hu+7mHS02JnYJhtdCdLBXVkw7AWGlg
 loIT7pJHE9qjhAc3LKL/uz2V2jDDQpzAJZoSJ3B2QcGbvl2581r62wNx8HWPzx8WEuh3X4rwxUN
 B8V9jbbQ==
X-Gm-Gg: AZFdTZdl0JbLhIuzFuB+lcuZfrm3X3/c7LGaJ3GoYVfNWaa/yHtL9yKsKXpqlVvWb4W
 qnlQLVNZNVn38sJG1BanN8fHTLjrrRiD6dvDMsyf7HKIMjzNh2ZSVN7ZRcaA+L4cxlkoaPjHulv
 HI4IvFulpe/o0zfmazq6RqZzwRTgobt6v94qRbrPcNyjpHJN/bpHFxu7+nW4SCFw+lObUuhLTB+
 nSB/AvAcU2U4X4SbFObdAJKZP6aMOHwn1yWPkjZXCkCc5TWNfdjdEyU/g1w6a3Atq+DVTDi4OgR
 xnUT2PC+qJirexOA/HWzKPfkVMzhQ2rQCwEoRTp2baT2UGbeNn9PIqgKhlo2hAB5vdNv2Abx8e5
 /3+rJ/tDnz655JVkNMGtEPATWrYzysTlgtIJedpNFuCW8QhSLzHtjcSgxnJvUKYOWWnIw6HLDkG
 T+ldNLyyL9Cr/jqhEgFUO6FBlq63YESMTLyVM/zZl75w0p6U4dObhrHHlXDNtDZkTT3UFim4pjE
 UIeBwm4GI4Xpth1vdDWSGPVB8RzgmvGufuaXPVf8xHzjukdIOA32VmPpREtL3P7aXvuLAAC6J48
 dcPHL6XtLvCcGTs/qShoorsTdK1N/B5cHrorTXfVn9/xcPPnAsQ6gVS5rmcu9+JFrYcouoe+emb
 S4KHBQdmkXwImNM18HgvPFN8TBK7CggHhPfuR0jhweNuc9Gezv4g1PkRz+sE57cMtKglfSFN0u7
 HOk/wcJUzFSwJaF6U=
X-Received: by 2002:a05:600c:1c28:b0:4bb:867b:f0f0 with SMTP id
 5b1f17b1804b1-4bb88810708mr491924985e9.15.1795704133259; 
 Thu, 26 Nov 2026 06:42:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm589107875e9.15.2026.11.26.06.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:42:12 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 14:42:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id795de7dfe1324fb00660b6f8a9043732aa3e84c
X-Gerrit-Change-Number: 2356
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2356?usp=email>
X-Gerrit-Commit: 754217363400b9d113f6e91425994d82be6eea82
References: <gerrit.1795704131000.Id795de7dfe1324fb00660b6f8a9043732aa3e84c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzA0MTMxMDAwLklkNzk1ZGU3ZGZlMTMyNGZiMDA2NjBiNmY4YTkwNDM3MzJhYTNlODRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7fa8c48d8cc9af2096c286f2aad2c20da364f1ff-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWag0-000000001tZ-0hfN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: report
 pipe creation errors where they happen
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
Content-Type: multipart/mixed; boundary="===============1103896211130546778=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1103896211130546778==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sq+5oDnllVc="; charset=UTF-8

--sq+5oDnllVc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2356?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: report pipe creation errors where they happe=
n
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnser=
v: report pipe creation errors where they happen

Log failures to create or=
 disconnect the first pipe instance with
their own messages, instead of fal=
ling through to the generic one=2E
This makes a pipe name already in use di=
stinguishable, and logs
the error before CloseHandleEx() can clobber it=2E
=

Change-Id: Id795de7dfe1324fb00660b6f8a9043732aa3e84c
Signed-off-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
1 f=
ile changed, 13 insertions(+), 14 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/2356/1

diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 1cb191a=2E=
=2Ea381fa1 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -4066,35 +4066,34 @@
     swprintf(pipe_name, _counto=
f(pipe_name), L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\service",
             =
 service_instance);
 
+    HANDLE pipe =3D INVALID_HANDLE_VALUE;
+
     sta=
tic HANDLE blocker =3D INVALID_HANDLE_VALUE;
     if (blocker =3D=3D INVALI=
D_HANDLE_VALUE)
     {
         blocker =3D CreateNamedPipe(pipe_name, flag=
s | FILE_FLAG_FIRST_PIPE_INSTANCE, mode,
                                  =
 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
-        if (blocker !=3D I=
NVALID_HANDLE_VALUE && !DisconnectNamedPipe(blocker))
+        if (blocker =
=3D=3D INVALID_HANDLE_VALUE)
         {
-            DWORD error =3D GetLas=
tError();
+            MsgToEventLog(M_SYSERR, L"Could not create first ins=
tance of named pipe");
+            goto out;
+        }
+        if (!Disc=
onnectNamedPipe(blocker))
+        {
+            MsgToEventLog(M_SYSERR, L=
"Could not disconnect first instance of named pipe");
             CloseHan=
dleEx(&blocker);
-            SetLastError(error);
+            goto out;
 =
        }
     }
 
-    /* Without the first instance, fail and try again w=
ith the next call */
-    HANDLE pipe =3D INVALID_HANDLE_VALUE;
-    if (bl=
ocker !=3D INVALID_HANDLE_VALUE)
-    {
-        pipe =3D CreateNamedPipe(p=
ipe_name, flags, mode, PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
-          =
                     &sa);
-    }
-
-    LocalFree(sd);
-
+    pipe =3D Cre=
ateNamedPipe(pipe_name, flags, mode, PIPE_UNLIMITED_INSTANCES, 1024, 1024, =
0, &sa);
     if (pipe =3D=3D INVALID_HANDLE_VALUE)
     {
         MsgToEv=
entLog(M_SYSERR, L"Could not create named pipe");
-        return INVALID_H=
ANDLE_VALUE;
     }
 
+out:
+    LocalFree(sd);
     return pipe;
 }
 

-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2356?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id795de7dfe1324fb0066=
0b6f8a9043732aa3e84c
Gerrit-Change-Number: 2356
Gerrit-PatchSet: 1
Gerrit-O=
wner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>

--sq+5oDnllVc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2356?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: report pipe creation errors where they hap=
pen<br><br>Log failures to create or disconnect the first pipe instance wit=
h<br>their own messages, instead of falling through to the generic one=2E<b=
r>This makes a pipe name already in use distinguishable, and logs<br>the er=
ror before CloseHandleEx() can clobber it=2E<br><br>Change-Id: Id795de7dfe1=
324fb00660b6f8a9043732aa3e84c<br>Signed-off-by: Razvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file ch=
anged, 13 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/2356/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=
=2Ec</span><br><span>index 1cb191a=2E=2Ea381fa1 100644</span><br><span>--- =
a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/int=
eractive=2Ec</span><br><span>@@ -4066,35 +4066,34 @@</span><br><span>     s=
wprintf(pipe_name, _countof(pipe_name), L&quot;\\\\=2E\\pipe\\&quot; _L(PAC=
KAGE) L&quot;%ls\\service&quot;,</span><br><span>              service_inst=
ance);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    HANDLE pipe =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     static HANDLE blocker =3D =
INVALID_HANDLE_VALUE;</span><br><span>     if (blocker =3D=3D INVALID_HANDL=
E_VALUE)</span><br><span>     {</span><br><span>         blocker =3D Create=
NamedPipe(pipe_name, flags | FILE_FLAG_FIRST_PIPE_INSTANCE, mode,</span><br=
><span>                                   PIPE_UNLIMITED_INSTANCES, 1024, 1=
024, 0, &amp;sa);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (blocker !=3D INVALID_HANDLE_VALUE &amp;&amp; !DisconnectNamedPipe(b=
locker))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(blocker =3D=3D INVALID_HANDLE_VALUE)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            DWORD error =3D GetL=
astError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    MsgToEventLog(M_SYSERR, L&quot;Could not create first instance of named=
 pipe&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!D=
isconnectNamedPipe(blocker))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           MsgToEventLog(M_SYSERR, L&quot;Could not disconnect first instan=
ce of named pipe&quot;);</span><br><span>             CloseHandleEx(&amp;bl=
ocker);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Se=
tLastError(error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           goto out;</span><br><span>         }</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* W=
ithout the first instance, fail and try again with the next call */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE pipe =3D INVALID_H=
ANDLE_VALUE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (b=
locker !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    pipe =3D CreateNamedPipe(pipe_name, flags, mode, PIPE_UNLIMITED_INSTANC=
ES, 1024, 1024, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                            &amp;sa);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LocalFree(sd);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    pipe =3D CreateNamedPipe(pipe_name, f=
lags, mode, PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &amp;sa);</span><br><s=
pan>     if (pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><span>     {</span=
><br><span>         MsgToEventLog(M_SYSERR, L&quot;Could not create named p=
ipe&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn INVALID_HANDLE_VALUE;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    LocalFree(sd);</span><br><span>     r=
eturn pipe;</span><br><span> }</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2356?usp=3Demail">change 2356</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2356?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id=
795de7dfe1324fb00660b6f8a9043732aa3e84c </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2356 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--sq+5oDnllVc=--


--===============1103896211130546778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1103896211130546778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1103896211130546778==--

