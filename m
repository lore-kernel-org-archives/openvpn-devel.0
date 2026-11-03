Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A285606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=knSnKFQf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=exDuKr4W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L1k9jjAG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QKK7JCMF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=6FK93lQCwPsZ1YVtyTqkv57SGSkbwyvWvT9oH1XAjJo=; b=knSnKFQfCyffTNf5AcLZX5YFoN
	n6AYagBYSxeU3z7WIVLDCQAklfXWSrEfXcSukJphNNysq2QAnWdfXQgbrZcxNWc/MhY9C/eEtIP5r
	tu0ufu5k5SZYhHyXBQL7/pheQTQSwUUtU39pUITJr30BPJxGVIs5OG4H6pJ7bT9617y8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xONbD-000000000ax-1bKu;
	Tue, 03 Nov 2026 23:07:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xONbB-000000000al-3kzK
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2K6VCMk3IZYLcaIsCsDseUp99sM+oe2j6s/bIju51fs=; b=exDuKr4WS+hlxIOrXuI9c44cgB
 k2IxMsz2hSRNbRq4hPVX7gu9BuwhyXvN7MkRSnQyS/dhFBRwDwl41A31llad1zCOxrEQgI9yOowNK
 oN8+8pLc4e5zQHS82UF5lCXgk1zTpb/4ekc08SXJnPcxbUc/DvQcXsnCRdgbfPmFAYdw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2K6VCMk3IZYLcaIsCsDseUp99sM+oe2j6s/bIju51fs=; b=L1k9jjAG/Z0rV5SjtcS1Wu75W/
 kssB6NtIkli0sCP4AEWLAkZ6hVyaRrMqn+Q68G3Wyjsa3d+pPDEGjPe25iAkXhnAPLsc3nb/sQuxu
 78z7nCscKW1xtRyFPPyCJSylApMEyKdsDDX/m5UFvoBFnDre8+fb6O7f5vXB8nn7WuEc=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xONbB-0000000010L-0d1q for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:25 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so229815e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793747238; x=1794352038; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2K6VCMk3IZYLcaIsCsDseUp99sM+oe2j6s/bIju51fs=;
 b=QKK7JCMFmsaQyfL/AIrYWqbQ0ffajrzg9LW1xCejVTHpzCpu59XMXd4E6ng+apIL3T
 cXZ60iHO4yBs75WmOfbv+Sb97tR70V2B9uCX/T1FEnx65N8CVYZWDLXjz3Sk3CETfoaz
 4oqmJvH82zT2e/Rkc6mrGNkoelfpRJLrGiJSsc/MsnTpSbMrtwLmwG+X05HOC2RB7RPA
 O8Q2ijbjD6pBl2fu2b7b0ah2IYHVOejV0vgFnDXwgSJUzQ+KBAQoVzW7qFK0Yso6iljs
 k5/dOY9lASTbBBXjezJDG6fqE8qZave6XFV0bJqDyDVqxk5e/iBzgeLS3sXYivadZ5RK
 l8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747238; x=1794352038;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2K6VCMk3IZYLcaIsCsDseUp99sM+oe2j6s/bIju51fs=;
 b=qfGjV6Bb0iFrweiXTyeUMTlwr02KbryEPj23wtAAi7GsOLSC0GhjJyMu2xBOjJtQwe
 hK1EiuMfaATohhVzDCD0zkw4Mx9NyBI8vtoELCdmH4aDaIcOyldzHcgNrXDT2g1ZzC9i
 BGexbO6bFmgJKrGFlWelhAWHUemcGLGLd8WhlO/5uqOhcxpQZMUzkVqoKQX2WFUE0sCa
 plaJR/IDboXVaV4SqUr9wLLpyTR1wZ4KZsBLLRLB6UUBkfG3t784bLLxoEG2TAsakCCi
 WdVVjzwd8qQ5dWxI33eU8bfAkqrtoUJMG6AlYfyfVMG5+/aSOPDpgX5RvGSi8CiJCe8s
 AFHg==
X-Gm-Message-State: APuU4Z8SFI8NiDOeM0nZoZRGBSpAVLMb/Vdc659CKBHIvzdOQC0eOEGb
 hviFZ0sdnY0rTkjUzErZnjq9elMvCJhzj9YfvwX6ZeP5FTM35DO786ictcXUmxSo9FR5yJpDaCi
 1/vLMpovTCKbiN9DW1sFB94cxYRoDxbD68Egugo7nSVQdWZPOi8itWIcJOA8dFsswP6WZ4DxYaD
 u2QOEH0w==
X-Gm-Gg: AYBFou3hvLebGPS5wee+z5XjL95IRNDlHExigN3fEBBkQnudKHkSUQfv9mFYqwLlSPz
 WNfAFBGxMm0dYCXGKZyhfsM5Mh7aFNnK7hUZl28kTbSC1uS3FdW2LDYXzNjHU2TEh07FEOAEe8K
 XVKxfRkr0lpmlMCK+/bblhOnnRvYjWlUn1fHfjQNessJ0Ex1QV+zO4prqvAl/RzqNOdz9MJUtIN
 bi0QesIefq9Qqbull68jqtVfR09IogolXCEjy1yndZaBNRBl9Bc9BOEZiPnq0zhXi90FLyPoXxc
 Np0BLLd0D4A4RmvaSihw1GUxZfBNT3jcMYNZSVqK/Afg+SfKHe8TU6A1Yd/tc13KHp0mSRFDGd7
 AMSSV8y6syiZczIwvO93yHJbPpM32pMO1qzfGDTp7p90J2ZqfNUF2E4AXIykGUqix2ukGAghXV3
 drm2NYtoLNlaGJ++7fZopmiZCNneq7+OGMdLGsawJC51u5YQZLDvvB2U98D3yJz5kBL81cYtU0B
 zZX/LVsmURr/K7hXp91TiYPtCcWykbyV3BYZ9YnAfDnsxaPQLcKZJd8Qih4H7T2bnbVLgxqQA74
 f1p155sJWLwyt1SmkLMItgbPHQetq4xkSBVTaSRzLcfg85NPWQyNzpoYoXa195nvJUGsEAkg/rV
 Y/ILV+invfYwXgrENhvV8k9Ra2ngg3g/A5/UmI4QG3U2+GOXnDQKgtoRSc8IQ/YrmHycLwyl6fw
 aExuNePnLKH8TkpA==
X-Received: by 2002:a05:600c:8588:b0:4b2:4b5e:8141 with SMTP id
 5b1f17b1804b1-4b24b5e8152mr87086965e9.9.1793747238340; 
 Tue, 03 Nov 2026 15:07:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm12265145e9.5.2026.11.03.15.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:07:18 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 23:07:17 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I056164a3016d62152dfcbd57f75d58534dda8fc8
X-Gerrit-Change-Number: 2113
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2113?usp=email>
X-Gerrit-Commit: 6038a204e82f30e1e1e50bcaa7b1161c21ab2976
References: <gerrit.1793747232000.I056164a3016d62152dfcbd57f75d58534dda8fc8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLkkwNTYxNjRhMzAxNmQ2MjE1MmRmY2JkNTdmNzVkNTg1MzRkZGE4ZmM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c46ead8a4718a4d36810ab98f96bb30fde963a8e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xONbB-0000000010L-0d1q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: report
 error if the pipe cannot be created on start
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5264834949692267797=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5264834949692267797==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wGxOe8i60RU="; charset=UTF-8

--wGxOe8i60RU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2113?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: report error if the pipe cannot be created o=
n start
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: report error if the pipe cannot be created on start

If the first =
pipe instance could not be created, the service stopped
with exit code 0, e=
=2Eg=2E when another process already owned the name=2E

Keep the error code=
 of CreateClientPipeInstance() intact, logging it
before LocalFree() may ch=
ange it, and use it as the exit code=2E

Change-Id: I056164a3016d62152dfcbd=
57f75d58534dda8fc8
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>=

---
M src/openvpnserv/interactive=2Ec
1 file changed, 8 insertions(+), 4 d=
eletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/13/2113/1

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvp=
nserv/interactive=2Ec
index 5e4b555=2E=2Ebffc9da 100644
--- a/src/openvpnse=
rv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3832,7 +3832,9=
 @@
     if (!ConvertStringSecurityDescriptorToSecurityDescriptor(sddlStrin=
g, SDDL_REVISION_1, &sd,
                                                  =
            NULL))
     {
-        MsgToEventLog(M_SYSERR, L"ConvertStringS=
ecurityDescriptorToSecurityDescriptor failed=2E");
+        DWORD error =3D=

+            MsgToEventLog(M_SYSERR, L"ConvertStringSecurityDescriptorToSe=
curityDescriptor failed=2E");
+        SetLastError(error);
         return=
 INVALID_HANDLE_VALUE;
     }
 
@@ -3871,14 +3873,15 @@
                   =
             &sa);
     }
 
-    LocalFree(sd);
-
     if (pipe =3D=3D INVA=
LID_HANDLE_VALUE)
     {
-        MsgToEventLog(M_SYSERR, L"Could not creat=
e named pipe");
+        DWORD error =3D MsgToEventLog(M_SYSERR, L"Could no=
t create named pipe");
+        LocalFree(sd);
+        SetLastError(error)=
;
         return INVALID_HANDLE_VALUE;
     }
 
+    LocalFree(sd);
     r=
eturn pipe;
 }
 
@@ -4043,6 +4046,7 @@
     pipe =3D CreateClientPipeInstan=
ce();
     if (pipe =3D=3D INVALID_HANDLE_VALUE)
     {
+        error =3D =
GetLastError();
         goto out;
     }
 

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2113?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I056164a3016d62152dfcbd57f75d58534dda8fc8
Gerr=
it-Change-Number: 2113
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@o=
penvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--wGxOe8i60RU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2113?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: report error if the pipe cannot be created on start<=
br><br>If the first pipe instance could not be created, the service stopped=
<br>with exit code 0, e=2Eg=2E when another process already owned the name=
=2E<br><br>Keep the error code of CreateClientPipeInstance() intact, loggin=
g it<br>before LocalFree() may change it, and use it as the exit code=2E<br=
><br>Change-Id: I056164a3016d62152dfcbd57f75d58534dda8fc8<br>Signed-off-by:=
 Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpnser=
v/interactive=2Ec<br>1 file changed, 8 insertions(+), 4 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/13/2113/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b=
/src/openvpnserv/interactive=2Ec</span><br><span>index 5e4b555=2E=2Ebffc9da=
 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><sp=
an>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3832,7 +3832,9=
 @@</span><br><span>     if (!ConvertStringSecurityDescriptorToSecurityDesc=
riptor(sddlString, SDDL_REVISION_1, &amp;sd,</span><br><span>              =
                                                NULL))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventL=
og(M_SYSERR, L&quot;ConvertStringSecurityDescriptorToSecurityDescriptor fai=
led=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   DWORD error =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           MsgToEventLog(M_SYSERR, L&quot;ConvertStringSecurityDescriptorTo=
SecurityDescriptor failed=2E&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        SetLastError(error);</span><br><span>         retu=
rn INVALID_HANDLE_VALUE;</span><br><span>     }</span><br><span> </span><br=
><span>@@ -3871,14 +3873,15 @@</span><br><span>                            =
    &amp;sa);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    LocalFree(sd);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (pipe =3D=3D INVAL=
ID_HANDLE_VALUE)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;Could not create n=
amed pipe&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      DWORD error =3D MsgToEventLog(M_SYSERR, L&quot;Could not create named=
 pipe&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  LocalFree(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     SetLastError(error);</span><br><span>         return INVALID_HANDLE_VA=
LUE;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    LocalFree(sd);</span><br><span>     return pi=
pe;</span><br><span> }</span><br><span> </span><br><span>@@ -4043,6 +4046,7=
 @@</span><br><span>     pipe =3D CreateClientPipeInstance();</span><br><sp=
an>     if (pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        error =3D GetLastE=
rror();</span><br><span>         goto out;</span><br><span>     }</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2113?usp=3Demail">change 2113</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2113?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I056164a3016d62152dfcbd57f75d58534dda8fc8 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2113 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--wGxOe8i60RU=--


--===============5264834949692267797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5264834949692267797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5264834949692267797==--

