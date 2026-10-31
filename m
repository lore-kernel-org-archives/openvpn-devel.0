Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8B606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aurEUSId;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IFki5IEO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cW5HlYJZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=N4rEthak
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=4aALys/SQIzv79XE53Do920FsFmCskKSh7a7k7TsrX8=; b=aurEUSIdtDT/dub1xO9jLAHLci
	CR188JOZTPBOw8QXSm5PAbnWBWPh5M5nZpUW89yBNVbwRBDaCXyndjM/oHMTR4lUY4742Cfb6JGVJ
	4yOk4Aquu9w281qmj9ao8NDa8JomeroWaH4lpuOyUawe3a6rQ5wJM/ELu4Nakp9ePs8E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8Og-00000000789-1GyP;
	Sat, 31 Oct 2026 12:41:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8Of-0000000077z-10B1
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ELdlcYCcygDDHR2C4Ye14o1vOrqzFDqnW5aJL653RTg=; b=IFki5IEOddrorCHp4ZvcKMAC1c
 6zrwQN0FQhbxb5UnSKtYvLoKFlJfau+6t+X2rT+bRDNGKxB1z+FaaRz5xG3m9MnGZkgrSfHHoMC+b
 5JMLL79AGGbw+khK51xWXrC9ivEsWQj1qyp8+pxKCDdiTuY5kJC0s6KMHutQVaqY1z2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ELdlcYCcygDDHR2C4Ye14o1vOrqzFDqnW5aJL653RTg=; b=cW5HlYJZHykhnlIE+0hcp5TdW5
 L5y9qVzshiH/vqvD3sMS30wtE8tpsECFhEbLh38ufk908xaESSxlXTDXtTvcI2Z3YOHnGninTvoap
 qqnN6Ihgr3+ScT3AIowyt40i1KGq2H8SeA3aPF2GgzjxYNo7sQBSWzI24GorWOlp+EHw=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8Od-000000003Pq-42lr for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:41:21 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso10751585e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793450473; x=1794055273; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ELdlcYCcygDDHR2C4Ye14o1vOrqzFDqnW5aJL653RTg=;
 b=N4rEthakwbbVbg8Tz4Zcr5t1vE2wpuv+eagyauqEmlThvyNz+qAszEdH5MChbHbEoG
 x8C/U+DW42s/6lB00KpMYnUeCbanqbPv1nCIFNP5Wakfb6zpnyLcx2ancQxV6/H9/jq4
 EMltvXrzQlddGsmZHBjiXtoJTVSSsX85H2ox9HzvMtRD7lTrMOrM9kIy9DLkP1O4dwpG
 L0qg0vL9z8QtOvV4+xC3k1S1bEINsBTyj0rdS9muc1YD+ZD3XbHyFjbUW3oG7oqWdzQM
 hRlHGYU7bU+TQ2JGiTU/SyWWCAJcMcrkRRJe9huzHFJCLW8fT1tpxC615G4Cx18adUUq
 kIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793450473; x=1794055273;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ELdlcYCcygDDHR2C4Ye14o1vOrqzFDqnW5aJL653RTg=;
 b=acjt4YLMDuQAm9F2nv3WpzfGG65iNiK/fgr0Gyl+DEDn8OCt+aA+T1QjplkFBAvpZP
 xiFRgv3Gd2pd+3VTZ3uNe2eN9ge66wkq3hUd1pns1ysJevRiVR+KTCtrkCNQ7HVJHXka
 6DmIopIiuHgbL93aRVgpixyUz5SzFIlUg4HvwxavntgjXkYJGjJDw2+eFxndisi5wnLf
 GTzYzYR32OYjTMcMtGD+9wUD61w21KxXEKBnN3tyWgxMjJJCSuvWY8tAfJgr7N7zzpAN
 gQ1BZXR1jbF3VKENAWZBnQVroBte2ShrlmowNLT1f0j3059kDPXik9bmSEDzKuYTa25K
 CvWw==
X-Gm-Message-State: AFq9FYITxnQahChjff2iN+9LJP7LP8XEeNvPx9srF8EwVl29gnmZZ6fn
 0ZsepXTXjHpJE39chyKDwWcwsDvvQBf5xcIKa4VIB9n7BNxVyqdhrt0D4BsPqEZntsKRqCwBvUa
 xuP3AFejow0cHXTUGH8/Lef2J1B1p/HO0R4nDAEUo4PZ5VNCBokzpBPiRaR4VEwFUgDNmjYKs+y
 XkWr72qA==
X-Gm-Gg: AYBFou0FRbSiIUoLmAeEiEg905Jsg1/A6k3rpEZJfOsfisfozG49BFyDlkqdQdfENkv
 rBh9L+waGjn9ONcPj+8DY4WuiNFSGy+HFqLYdnMiYGdknYyrtSTDDry0g/CECEhTN+AAHf1ydfs
 oziDTkszxtdve+qF5gntFq+BqzzgCyuiLuumM57+gqlSXA4dSaBvqzQEexKk/lWyMYgNS23LrIf
 mslHGOrqkOK3J4udWOs6oBW9hm77e1ZMkdDmAwG52ohiutt0NO90irx2NT56b6SaAxWwkBHYk5Z
 AxRuLnS5XMf9oSTNBNmsUPWCm8CNCpOem6pAmcck9dpBgcq+C4HKQZonC4GrVOr15XhAeRvU3z9
 Oer71z8WgrIW9k+YzXq+dYg1OBEu/3mE2v5Ebx7gSL4T9pHdxUkvmkeix8YGfBeG0WsKiPPMDNY
 1qQoFM6PLYa2GqQVi1KcqPzO1pTuSYFhdI19zW5WoNtLzvl6h3BVynD5bSQxS48aJjq9LmgNSoS
 jqJ38MtyKqhvrJhR7vZlqYluWoDe6pZ5WbR3g+dgEUq+3yjI4+6YnKCl1SWxxCLIIU4AJXZiFc9
 fb5DFFaJK8msKoExoi0OOXy4nH6qIU2fbebjih5wOl9um/fnXHTHAsLBZUyHida0VITgxqNiFZ4
 IV17NxsWTwoQViVNQu5B4J0qO4/kticZLTF7breNO0cGe3QyqSb0Du4HPVRx4NIsImfC/tsWTxH
 RIqV7E4ZqCaymFn5g=
X-Received: by 2002:a05:600c:8b6a:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4ac17e10acemr108579385e9.29.1793450473335; 
 Sat, 31 Oct 2026 05:41:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm198604965e9.3.2026.10.31.05.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:41:13 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 12:41:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: c8572113a1bc19f64d5e09a9e1d362e87611c823
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <49b4167ed69d8c0fa7608f5659de0597b3db20fe-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xN8Od-000000003Pq-42lr
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: port-share: do not
 follow symlinks when writing journal file
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8647936141582887240=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8647936141582887240==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="621SBP7IHnI="; charset=UTF-8

--621SBP7IHnI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2074?usp=3Demail

to review the following change=2E
=


Change subject: port-share: do not follow symlinks when writing journal f=
ile
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

port-sh=
are: do not follow symlinks when writing journal file

journal_add() create=
s <journal dir>/<local ip:port> with
O_CREAT | O_TRUNC and writes the remot=
e client's address into it=2E
The name is predictable (the proxy connection=
's ephemeral local port)
and the write is triggered by any TCP client sendi=
ng non-OpenVPN data
to the shared port=2E Anyone who can create entries in =
the journal
directory can therefore plant symlinks and have the port-share =
process,
which runs as root unless --user is used, truncate and overwrite a=
n
arbitrary file with the client address=2E

The journal file is always a r=
egular file that we create ourselves, so
refuse to follow a symlink when op=
ening it=2E

Github: closes OpenVPN/openvpn#1124
Change-Id: I70ebdadd660e41=
b40ed53f4238be6885f0a7bb8b
Signed-off-by: Naveed Khan <dxbnaveed=2Ek@gmail=
=2Ecom>
---
M src/openvpn/ps=2Ec
1 file changed, 2 insertions(+), 1 deletio=
n(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
74/2074/1

diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 03c6f=
48=2E=2Ef730036 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@=
 -341,7 +341,8 @@
         check_malloc_return(jfn);
         snprintf(jfn,=
 fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_PROXY_DEBUG, "PORT SHA=
RE PROXY: client origin %s -> %s", jfn, f);
-        int fd =3D platform_op=
en(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
+      =
  int fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY | O_NOFOLLOW,
=
+                               S_IRUSR | S_IWUSR | S_IRGRP);
         if (=
fd !=3D -1)
         {
             ssize_t write_len =3D strlen(f);

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70ebdadd660e41b40ed53f=
4238be6885f0a7bb8b
Gerrit-Change-Number: 2074
Gerrit-PatchSet: 1
Gerrit-Own=
er: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>

--621SBP7IHnI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering would like Arne =
Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">port-share: do not follow symlinks when writing journal file<br=
><br>journal_add() creates &lt;journal dir&gt;/&lt;local ip:port&gt; with<b=
r>O_CREAT | O_TRUNC and writes the remote client&#39;s address into it=2E<b=
r>The name is predictable (the proxy connection&#39;s ephemeral local port)=
<br>and the write is triggered by any TCP client sending non-OpenVPN data<b=
r>to the shared port=2E Anyone who can create entries in the journal<br>dir=
ectory can therefore plant symlinks and have the port-share process,<br>whi=
ch runs as root unless --user is used, truncate and overwrite an<br>arbitra=
ry file with the client address=2E<br><br>The journal file is always a regu=
lar file that we create ourselves, so<br>refuse to follow a symlink when op=
ening it=2E<br><br>Github: closes OpenVPN/openvpn#1124<br>Change-Id: I70ebd=
add660e41b40ed53f4238be6885f0a7bb8b<br>Signed-off-by: Naveed Khan &lt;dxbna=
veed=2Ek@gmail=2Ecom&gt;<br>---<br>M src/openvpn/ps=2Ec<br>1 file changed, =
2 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/2074/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 03c6f48=
=2E=2Ef730036 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><sp=
an>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -341,7 +341,8 @@</span><br><=
span>         check_malloc_return(jfn);</span><br><span>         snprintf(j=
fn, fnlen, &quot;%s/%s&quot;, journal_dir, t);</span><br><span>         dms=
g(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: client origin %s -&gt; %s&quot;=
, jfn, f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int=
 fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR =
| S_IRGRP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
int fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY | O_NOFOLLOW,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
         S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span>         if (fd !=3D=
 -1)</span><br><span>         {</span><br><span>             ssize_t write_=
len =3D strlen(f);</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">change 2074</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70ebdadd660e41=
b40ed53f4238be6885f0a7bb8b </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2074 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--621SBP7IHnI=--


--===============8647936141582887240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8647936141582887240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8647936141582887240==--

