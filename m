Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366F606A32F
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pw9S/B3y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nOnfrRMi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZH0j6VAV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FH3ie4Mp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=imymJc6/r2FPE2b8GpW6Lc2e2N6eboAAZKfGZQlCW00=; b=Pw9S/B3yYAM5yk42KMohDmOmuY
	vAj254bIjP5/sHXSQ75QRCCDM6HMq//k/WxIPB4xShy/ghwYDRrOowbwA5s6jN7OP6gybxEtnooTk
	Yrf+ZxQSqpCWrJoo/tusR2Gr721IG2Atjnksa3XBYubwaw6ijp2JvwxywnlfeU7FBZJQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoOP-000000000qt-1TyM;
	Mon, 02 Nov 2026 09:31:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNoO9-000000000qb-2yF8
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:31:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KnoK9WFHzkIOkGACIPusU0pR9ZOso4R07dLjZfDugjE=; b=nOnfrRMiVGTuseLzs47GhLALzE
 ZWsb1osRoKa0ejS5Fh0nB8ejm99l1cOm6PU8XvEHAtIxQ4Vj7oIpEzW3ksBrezXn43KMZHxr72nNQ
 IBjMlj8BUe/5KSaE5i+R2IThb7BJgrcX7OjsgpzxnARkJaNTOlOxtB01RSTpUWM+s0N4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KnoK9WFHzkIOkGACIPusU0pR9ZOso4R07dLjZfDugjE=; b=ZH0j6VAVKbavybAQ0wy62AX/a/
 3s0AZeVOpy8kC+2PTZjvz/zmAFzU7eTr5QRWPVxd4LimRTFJ3quLgJ4b22TMERxXoDW6ylixDpT/1
 TM/+2RAkdBuw81qgvbbnyTFIFsyeXQxEvgXsoqitZtbW5fsL14uMqJuzFPxkKZDCM4Dc=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNoO7-000000001li-3sQE for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:31:37 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c445c95d553so363603766b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 01:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793611889; x=1794216689; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KnoK9WFHzkIOkGACIPusU0pR9ZOso4R07dLjZfDugjE=;
 b=FH3ie4MpTNiZRW802UlfRUxGkm3kKkdUwYQey8GtxnNR+1fPsljj6zodI+4akB1cIH
 XYiBC2RATwm8AzLQ020rsOjXH2d2SoaXwpThM2pGaoHwm0LDRh4U9ECk4PIIdWg034Bu
 /GUqxrNViLVzZrZo67o+wcelWrHPJdIFedrjB3KPIZWh92pBy/QBY2VCPGHfsNX+ZjCi
 bTKZM6QdQB9n1RtVuG5BJwivfl07BzkGtokLP3OAm+YOMJ27Km0EFMv6jwBkLnPqudkf
 2YWJNyk+4GHm+9sC0XR8n3cHFu30u7cAjDVCXV6SPJV5Q1rI+yArtJmna3AjCLxfTEyL
 fsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793611889; x=1794216689;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KnoK9WFHzkIOkGACIPusU0pR9ZOso4R07dLjZfDugjE=;
 b=D8T/BeXv7x3xO+FA9207oxT8qz6tEUR4FDnNX7iba4FkIWaizEJ515uBNyfHO0nfLW
 UuCHtflga0lh2rqoVLz/Q9TWaDAio3uJT6CdZ6Xd5HmWWyx2Xn55VwW4X2bh9ZMk7Ugq
 3h7CyLuptiOJwE+pNOp8G6yIXLHTS4m6u6RA1KKEnK5ULd6ycRKQ4GuO1yHOkDAbkBUb
 y3VhGnQntLoqiWCsx3bHxokgqffGl4FcDHpUsC8K1fp0Mqjt++Mlo5tUrcNppZNIh+bf
 qr+4gyYpql3CBSZBZ0vPe8xG8V+PZjjH/YO/0vItVcPt4Z78MYTFU4SJKAW34wl0dbHP
 +B+A==
X-Gm-Message-State: AFq9FYJkJr2eGQ/AWvnNLJn9nR6KDGx2ujutBABciVbeZj5Fgt6+p1W3
 TKdWw/UZ93u6GMkgULNrY7rvLkejjjpBzdlckcjX3xHAydt2t92dsbNeSAmxQQWMqtG2gwbVHTa
 5Xs8p6jf2pwHiD7NNMfAddQx/dcZIdXfk5JRYqZsQ9dQamB5jjdhKIkWrsxSBuErwE2UH
X-Gm-Gg: AYBFou1mMYbjd9XU9HiP0k/ISFlUnGg9e/VNSV+iyH+zm3WkHenvirhhDSRHwPWQ0K6
 BnxUtqovswA4+KELHyLD+L543HCNmMKVvjNxl+x413AGhkql9JB/1d+usXDGlLQCIEaSIUqm2lJ
 4klvM+Gn3AX6/jW38S/wiImaFarUhxzXJLUQ4471pq0aWC+9lX7OYXgbq8PudD+fRscZb7pHkcg
 ZpEdiMEEHlDLk8gBIpN4JMwcHYbdwQix+Ff/rU5/GxZeKQGfdC/do5tpl+5IEXm8KMfE1cHeSxs
 29LjfhWKHejPInsMaDE9h2uhLtYUwlS4XfhzTz2hp5pRuVJpL+eEupEVNiIa9uBto/HiYMGtP84
 cu9B56SpAVd6xNnMv5llFKSlFuYoRk31d2Qfk1z0UTRJ0aXRQY2L7a+QsvOVtKUgxACapm3V8Yw
 xAziIFFVMRC0PTs66wK5X51WiANgQBtEYQKla5Mmh85RRk6qZCbzQ7tFoex8yTEJeiHpL3b0TW4
 +7bziVbbvFpvcVAPIlN4WZRHVXWSicaHIW5ZN56dhThrTYNgU/PmCsGK8lhYYe5J0i5qyWXxfyK
 uUm3x3s4u/IOqg8dDkS23WASHtiSzwOWY9wY/hLYkTPkLttrnzAfynJZKQo7Q52TAEXmwrLvvoZ
 EaCiWI2HiMLf6TspMfXgvjx8XQjl1hpNnWBRxWcsW5MovkJMz3O/KGG61w6lPThfsdcfS7L0sTz
 0uVGRBpm83fYRtxQ==
X-Received: by 2002:a17:906:99ca:b0:c31:c767:adfb with SMTP id
 a640c23a62f3a-c4ca7432ef7mr744631466b.0.1793611888795; 
 Mon, 02 Nov 2026 01:31:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm19515511f8f.30.2026.11.02.01.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:31:28 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 09:31:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: 68c131725ae43bf4138fe6b46f9bbe17cd1a26be
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6769f077f4eea6b4aa4bbe56fb3e76df998751f9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNoO7-000000001li-3sQE
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2783836824484774972=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2783836824484774972==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UkdFpTxKZuY="; charset=UTF-8

--UkdFpTxKZuY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2074?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: port-share: do not write journal file through symli=
nks or hardlinks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

port-share: do not write journal file through symlinks or hardlinks

j=
ournal_add() creates <journal dir>/<local ip:port> with
O_CREAT | O_TRUNC a=
nd writes the remote client's address into it=2E
The name is predictable (t=
he proxy connection's ephemeral local port)
and the write is triggered by a=
ny TCP client sending non-OpenVPN data
to the shared port=2E Anyone who can=
 create entries in the journal
directory can therefore plant symlinks or ha=
rdlinks and have the
port-share process, which runs as root unless --user i=
s used, truncate
and overwrite an arbitrary file with the client address=2E=


Create the journal file with O_EXCL | O_NOFOLLOW instead=2E Entries are
r=
emoved as soon as the proxied connection is closed, so an existing
entry is=
 either a leftover from a proxy process that exited without
cleaning up, or=
 something planted=2E Unlink it and retry the exclusive
create once, which =
keeps the old behavior of replacing stale entries=2E

Also document that th=
e journal directory must not be writable by other
users=2E

Github: closes =
OpenVPN/openvpn#1124
Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
S=
igned-off-by: Naveed Khan <dxbnaveed=2Ek@gmail=2Ecom>
---
M doc/man-section=
s/server-options=2Erst
M src/openvpn/ps=2Ec
2 files changed, 13 insertions(=
+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/74/2074/2

diff --git a/doc/man-sections/server-options=2Erst b=
/doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=2E7a09809 100644
--=
- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-opt=
ions=2Erst
@@ -489,6 +489,10 @@
   the origin of the connection=2E Each gen=
erated file will be automatically
   deleted when the proxied connection is=
 torn down=2E
 
+  The files in ``dir`` are created and removed with the pr=
ivileges of the
+  OpenVPN process, so ``dir`` must not be writable by any =
user other than
+  the one OpenVPN runs as=2E
+
   Not implemented on Windo=
ws=2E
 
 --push option
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec=

index 03c6f48=2E=2Ef8cfe1c5 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/open=
vpn/ps=2Ec
@@ -341,7 +341,15 @@
         check_malloc_return(jfn);
        =
 snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_PROXY_DE=
BUG, "PORT SHARE PROXY: client origin %s -> %s", jfn, f);
-        int fd =
=3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_=
IRGRP);
+        /* never write through a pre-existing symlink or hardlink =
*/
+        const int flags =3D O_CREAT | O_EXCL | O_WRONLY | O_NOFOLLOW;
+=
        int fd =3D platform_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);
=
+        if (fd =3D=3D -1 && errno =3D=3D EEXIST)
+        {
+            /=
* stale entry, e=2Eg=2E left behind by a killed proxy process */
+         =
   unlink(jfn);
+            fd =3D platform_open(jfn, flags, S_IRUSR | S_I=
WUSR | S_IRGRP);
+        }
         if (fd !=3D -1)
         {
           =
  ssize_t write_len =3D strlen(f);

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2074?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
Gerrit-Change=
-Number: 2074
Gerrit-PatchSet: 2
Gerrit-Owner: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Gert Doering=
 <gert@greenie=2Emuc=2Ede>

--UkdFpTxKZuY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering=2E </p>
<p>Gert Doering <strong>uploaded=
 patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">port-share: do not write journal file through symlinks or hardlinks<br>=
<br>journal_add() creates &lt;journal dir&gt;/&lt;local ip:port&gt; with<br=
>O_CREAT | O_TRUNC and writes the remote client&#39;s address into it=2E<br=
>The name is predictable (the proxy connection&#39;s ephemeral local port)<=
br>and the write is triggered by any TCP client sending non-OpenVPN data<br=
>to the shared port=2E Anyone who can create entries in the journal<br>dire=
ctory can therefore plant symlinks or hardlinks and have the<br>port-share =
process, which runs as root unless --user is used, truncate<br>and overwrit=
e an arbitrary file with the client address=2E<br><br>Create the journal fi=
le with O_EXCL | O_NOFOLLOW instead=2E Entries are<br>removed as soon as th=
e proxied connection is closed, so an existing<br>entry is either a leftove=
r from a proxy process that exited without<br>cleaning up, or something pla=
nted=2E Unlink it and retry the exclusive<br>create once, which keeps the o=
ld behavior of replacing stale entries=2E<br><br>Also document that the jou=
rnal directory must not be writable by other<br>users=2E<br><br>Github: clo=
ses OpenVPN/openvpn#1124<br>Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a=
7bb8b<br>Signed-off-by: Naveed Khan &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>--=
-<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/ps=2Ec<br>2 f=
iles changed, 13 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/2074/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections=
/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2E7a09809 100644</sp=
an><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>++=
+ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -489,6 +489,10=
 @@</span><br><span>   the origin of the connection=2E Each generated file =
will be automatically</span><br><span>   deleted when the proxied connectio=
n is torn down=2E</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  The files in ``dir`` are created and removed with the pri=
vileges of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ope=
nVPN process, so ``dir`` must not be writable by any user other than</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  the one OpenVPN runs as=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>   Not implemented on Windows=2E</span><br><span> </span><br><span> --push=
 option</span><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2E=
c</span><br><span>index 03c6f48=2E=2Ef8cfe1c5 100644</span><br><span>--- a/=
src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span=
>@@ -341,7 +341,15 @@</span><br><span>         check_malloc_return(jfn);</s=
pan><br><span>         snprintf(jfn, fnlen, &quot;%s/%s&quot;, journal_dir,=
 t);</span><br><span>         dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY=
: client origin %s -&gt; %s&quot;, jfn, f);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int fd =3D platform_open(jfn, O_CREAT | O_TRU=
NC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* never write through a pre-existing syml=
ink or hardlink */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const int flags =3D O_CREAT | O_EXCL | O_WRONLY | O_NOFOLLOW;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int fd =3D platfor=
m_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (fd =3D=3D -1 &amp;&amp; errno =3D=
=3D EEXIST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* sta=
le entry, e=2Eg=2E left behind by a killed proxy process */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            unlink(jfn);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            fd =3D platform_op=
en(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         if (fd !=3D -1)=
</span><br><span>         {</span><br><span>             ssize_t write_len =
=3D strlen(f);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">change 2074</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70ebdadd660e41b=
40ed53f4238be6885f0a7bb8b </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2074 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--UkdFpTxKZuY=--


--===============2783836824484774972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2783836824484774972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2783836824484774972==--

