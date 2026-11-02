Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBE606A32F
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Eq9+7/dA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lZRyER/V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XWxPA5Ee;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ep7ROshQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JEIl7NMBolkKalN5dyGsQG+qOc6tUH5yX+yY7Sx8iY8=; b=Eq9+7/dA6BF9uhDrNOZdUuwlEx
	2+RLITGeuuzswh4zxyLfSefi/2TeDKBmo91xlrNMh7BrMnkV4xYch7Lqhx1UtX13TkBmTMmybG6ij
	kss6pEjgXh5/cZ6rEGRUh93MkWntkF+3ZbZYxQpjJnSie7zLOAzFOpQVsvi974cuDGp4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzwO-000000003AD-1isB;
	Mon, 02 Nov 2026 21:51:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzwN-000000003A7-3IrF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WjE+O6p5hLRybbBo5G3I8WYrEjJN2x3MgL+Tw0kOBOE=; b=lZRyER/Vv1BcIRUqJVmid08XeO
 gk/FMbh4D8X+MpzUzfLWyHc8CNGh95eZ5Bx3WBYuXlkg+sWAcHkvUuIYW3lokVAfSRXv1OnFx43gm
 c/zhErWJHl6A2dmVawzn4bBnSGyQ9AQUheYYR0wC4NmnMeIr6sjuzDJARR036DfuHUfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WjE+O6p5hLRybbBo5G3I8WYrEjJN2x3MgL+Tw0kOBOE=; b=XWxPA5Ee8gUBbFGErOKtl2XAg0
 RsgmBE62qfzeQDgjqy1pr/KYixQHnKrU2AJpho87Snr7ytzSkplp6lOjjtMUVUPdTmi36ZXz7a0Vc
 QSOjwntaBEGMyPwkysb7nMZ0IDbLf4RsvWuQndbtgdnxp/PShfrcOkzbL3frMPEwtvac=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzwL-000000006Z0-3Dbe for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:43 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so23358335e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793656295; x=1794261095; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WjE+O6p5hLRybbBo5G3I8WYrEjJN2x3MgL+Tw0kOBOE=;
 b=ep7ROshQyMKzJZQIVZLGofwqQRI1o5275zPVWcNzXf3lQflN0WjnLj2hLw7iqM0hpi
 v4mXbbot6PUoeFKVoVEgJPDMSRPYYP0CZVQPB1VGIFP3sGg0wYwo6mKGCDp18PHxj33L
 icOACZd/GzANws+6sVtRYv0Ig2xd8GfjHCGV0VOAVWPopgkiN+UY3pKVo4zYBj4wwdv/
 s8+tJ/RlpY36iFDb5NgigBhu+ZDP5IxvbYpM0xuCSTZ+vSb0sbUWI2Z1X+eTIfmXJNS5
 HT+YiK8UQxECYoGX/XbjJKDEifQWu9df59XM+VfofViehrp4lBRpGwhZ65Y4jpc+Novl
 6Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793656295; x=1794261095;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WjE+O6p5hLRybbBo5G3I8WYrEjJN2x3MgL+Tw0kOBOE=;
 b=pC7C6dFnULwA0aRhCEdX03XwgtMX9w6Rjh0rD2DJPytp3r2hXmbAJUc62iylSsQOly
 qzAa9Dwe8ZDjkpbSALdUyMb+cmeL60Qcmf/INcODBhqWWj+K1y/YuUBxui6CtO3kccGo
 1VZYNQW9rWlpsxszxQaxBQuyWQ8vDCLogBby9Uaz563c/h74wamPMs0bcDHe4ALa6oCJ
 SvmqcVWuOFdh+f2hAT4fsZAsqeWvRmo/XVfk11mYcZbQriHDNNbFY19ZRCANZQ6GkYje
 74ZJPNbH/7FZiiTKhiGsHLBhhR2f5ZKrenR8vbKpaGrQdBAFtklKKJB27HtjM+Dh6D7p
 yIEQ==
X-Gm-Message-State: AFq9FYJ5uOjD0nvlifTtCxj1g8j2yWyKFdWbUxPPQDUJrRcO7RmrBdDr
 D+3OyQ9bhGISIPeNbKRzgXiwEdnhYkjkHzAmEIoRu6dpeinXRLLNxRE17uh5TkiPSSDBFHXlC5f
 C07Ybsxhjws98s/gm27Bso7s4NfzsBoblRwj3F/puoCcjZEOX6ulGT08UwvrksJL8eRkyYZp4IE
 3aQLZBAQ==
X-Gm-Gg: AYBFou3jERClb9+qY8k0D6eWjgmjPKuSlxPuTz7klOi04iJWvUPsXDZJoe98TD1W14z
 zwK1N4kZ0oLgvd2LOntsn8MIDCsPX/2pLYnsAjyaUs8BTJmyP096/G8+THimJYxHeIvTEjLJeJU
 psE5vCWZS0T+Pp5DzFKYWGNVzVLA9vl2o+Po/6Cngw9us5g7XrjiRty0PrOJ0SM65C+W7O7g8gt
 EXxYFyOgo6MdJKEuaegt5JThsZlhYeAU+kXtzH7g5QaesH963ApfLeI8Ff/gXjTF/DcpL6P9MPc
 d/eotDfgaFceg/OSYGZggbK5ELGjejW1pIma3/GY/BtkkPaD8mZJH7wgvn+0E6XtPLUlKp1toQL
 G6jSLBn3IWUtmpwP5bLKqIhPPPdyI81CeSslSuoEK2M3KRHzXvHm8pnUvKjlVcm0g0bpkHJq119
 7T5IOmdhjy/ZDbPuoWmbGdpD4QDekyUEG0SZCD3LrvQwILfdl+WheBmy3QRtCBFyrIAG+RkcUBo
 lZdtkWGZNNaGpJxsTjvqc9fPtvLr3OalWT7/wPHYqaM8Y9Lj4cHaDs+9gki1ZRc7sZ8xHF/dQdI
 hOdVIQGRfxS0tW3B7qUzzzvDxz5wF4iFiAvUfsDeUVRNl9Yo2dhClWMtyk0GWHgxSPzcLY6kXyo
 6raDce7Y0EUPqHaIzWerRBSoxgme9jU+94DscUEWwD1yu6EIbABNfcRuAE1lL7oY4XOgcIZFHP9
 CeMos0KmXHFqGDPw==
X-Received: by 2002:a05:600c:4708:b0:4a2:167a:c93b with SMTP id
 5b1f17b1804b1-4ac19234ad8mr258982305e9.30.1793656295113; 
 Mon, 02 Nov 2026 13:51:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm22438037f8f.35.2026.11.02.13.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:51:34 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:51:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: 24946176aed52c23c52c956df43fd052c232f652
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83f80f6500bee959d005b03d0d30da0d4e7b1802-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzwL-000000006Z0-3Dbe
Subject: [Openvpn-devel] [S] Change in openvpn[master]: port-share: do not
 write journal file through symlinks or hardlinks
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3871738418548249423=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3871738418548249423==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c6nQ0sM3v2c="; charset=UTF-8

--c6nQ0sM3v2c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a cha=
nge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?us=
p=3Demail

to look at the new patch set (#3)=2E

The following approvals go=
t outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru


Change=
 subject: port-share: do not write journal file through symlinks or hardlin=
ks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

port-share=
: do not write journal file through symlinks or hardlinks

journal_add() cr=
eates <journal dir>/<local ip:port> with
O_CREAT | O_TRUNC and writes the r=
emote client's address into it=2E
The name is predictable (the proxy connec=
tion's ephemeral local port)
and the write is triggered by any TCP client s=
ending non-OpenVPN data
to the shared port=2E Anyone who can create entries=
 in the journal
directory can therefore plant symlinks or hardlinks and hav=
e the
port-share process, which runs as root unless --user is used, truncat=
e
and overwrite an arbitrary file with the client address=2E

Create the jo=
urnal file with O_EXCL | O_NOFOLLOW instead=2E Entries are
removed as soon =
as the proxied connection is closed, so an existing
entry is either a lefto=
ver from a proxy process that exited without
cleaning up, or something plan=
ted=2E Unlink it and retry the exclusive
create once, which keeps the old b=
ehavior of replacing stale entries=2E

Also document that the journal direc=
tory must not be writable by other
users=2E

Github: closes OpenVPN/openvpn=
#1124
Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
Signed-off-by: N=
aveed Khan <dxbnaveed=2Ek@gmail=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074
M=
essage-Id: <20261102093834=2E29593-1-gert@greenie=2Emuc=2Ede>
URL: https://=
lore=2Ekernel=2Eorg/openvpn-devel/20261102093834=2E29593-1-gert@greenie=2Em=
uc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man=
-sections/server-options=2Erst
M src/openvpn/ps=2Ec
2 files changed, 13 ins=
ertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/74/2074/3

diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=2E7a09809 1=
00644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/se=
rver-options=2Erst
@@ -489,6 +489,10 @@
   the origin of the connection=2E =
Each generated file will be automatically
   deleted when the proxied conne=
ction is torn down=2E
 
+  The files in ``dir`` are created and removed wit=
h the privileges of the
+  OpenVPN process, so ``dir`` must not be writable=
 by any user other than
+  the one OpenVPN runs as=2E
+
   Not implemented =
on Windows=2E
 
 --push option
diff --git a/src/openvpn/ps=2Ec b/src/openvp=
n/ps=2Ec
index 03c6f48=2E=2Ef8cfe1c5 100644
--- a/src/openvpn/ps=2Ec
+++ b/=
src/openvpn/ps=2Ec
@@ -341,7 +341,15 @@
         check_malloc_return(jfn);
=
         snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_=
PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s", jfn, f);
-        =
int fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWU=
SR | S_IRGRP);
+        /* never write through a pre-existing symlink or ha=
rdlink */
+        const int flags =3D O_CREAT | O_EXCL | O_WRONLY | O_NOFO=
LLOW;
+        int fd =3D platform_open(jfn, flags, S_IRUSR | S_IWUSR | S_I=
RGRP);
+        if (fd =3D=3D -1 && errno =3D=3D EEXIST)
+        {
+      =
      /* stale entry, e=2Eg=2E left behind by a killed proxy process */
+  =
          unlink(jfn);
+            fd =3D platform_open(jfn, flags, S_IRUS=
R | S_IWUSR | S_IRGRP);
+        }
         if (fd !=3D -1)
         {
    =
         ssize_t write_len =3D strlen(f);

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
Gerrit=
-Change-Number: 2074
Gerrit-PatchSet: 3
Gerrit-Owner: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--c6nQ0sM3v2c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Change</a></p>=
<p>The following approvals got outdated and were removed:
Code-Review+2 by =
R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">port-share: do not write journal file=
 through symlinks or hardlinks<br><br>journal_add() creates &lt;journal dir=
&gt;/&lt;local ip:port&gt; with<br>O_CREAT | O_TRUNC and writes the remote =
client&#39;s address into it=2E<br>The name is predictable (the proxy conne=
ction&#39;s ephemeral local port)<br>and the write is triggered by any TCP =
client sending non-OpenVPN data<br>to the shared port=2E Anyone who can cre=
ate entries in the journal<br>directory can therefore plant symlinks or har=
dlinks and have the<br>port-share process, which runs as root unless --user=
 is used, truncate<br>and overwrite an arbitrary file with the client addre=
ss=2E<br><br>Create the journal file with O_EXCL | O_NOFOLLOW instead=2E En=
tries are<br>removed as soon as the proxied connection is closed, so an exi=
sting<br>entry is either a leftover from a proxy process that exited withou=
t<br>cleaning up, or something planted=2E Unlink it and retry the exclusive=
<br>create once, which keeps the old behavior of replacing stale entries=2E=
<br><br>Also document that the journal directory must not be writable by ot=
her<br>users=2E<br><br>Github: closes OpenVPN/openvpn#1124<br>Change-Id: I7=
0ebdadd660e41b40ed53f4238be6885f0a7bb8b<br>Signed-off-by: Naveed Khan &lt;d=
xbnaveed=2Ek@gmail=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074=
<br>Message-Id: &lt;20261102093834=2E29593-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261102093834=2E29593-1-ge=
rt@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/openvp=
n/ps=2Ec<br>2 files changed, 13 insertions(+), 1 deletion(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/74/2074/3</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=2Erst b/d=
oc/man-sections/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2E7a0=
9809 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</sp=
an><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@@=
 -489,6 +489,10 @@</span><br><span>   the origin of the connection=2E Each =
generated file will be automatically</span><br><span>   deleted when the pr=
oxied connection is torn down=2E</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  The files in ``dir`` are created and remov=
ed with the privileges of the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  OpenVPN process, so ``dir`` must not be writable by any user ot=
her than</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the one O=
penVPN runs as=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>   Not implemented on Windows=2E</span><br><span> </span><br=
><span> --push option</span><br><span>diff --git a/src/openvpn/ps=2Ec b/src=
/openvpn/ps=2Ec</span><br><span>index 03c6f48=2E=2Ef8cfe1c5 100644</span><b=
r><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</=
span><br><span>@@ -341,7 +341,15 @@</span><br><span>         check_malloc_r=
eturn(jfn);</span><br><span>         snprintf(jfn, fnlen, &quot;%s/%s&quot;=
, journal_dir, t);</span><br><span>         dmsg(D_PS_PROXY_DEBUG, &quot;PO=
RT SHARE PROXY: client origin %s -&gt; %s&quot;, jfn, f);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int fd =3D platform_open(jfn, O=
_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* never write through a pre=
-existing symlink or hardlink */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const int flags =3D O_CREAT | O_EXCL | O_WRONLY | O_NO=
FOLLOW;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int =
fd =3D platform_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (fd =3D=3D -1 &amp;&a=
mp; errno =3D=3D EEXIST)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* stale entry, e=2Eg=2E left behind by a killed proxy process */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            unlink(jfn=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fd =
=3D platform_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         =
if (fd !=3D -1)</span><br><span>         {</span><br><span>             ssi=
ze_t write_len =3D strlen(f);</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">change 2074</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I70ebdadd660e41b40ed53f4238be6885f0a7bb8b </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2074 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--c6nQ0sM3v2c=--


--===============3871738418548249423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3871738418548249423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3871738418548249423==--

