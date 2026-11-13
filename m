Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0D606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jauniMX2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dO+MpcBh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MbrTSUZj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FOW3fHqX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UrEKx8pXsUbHQ5N4/Zl7GqBPs2PobZllrddhcJfwAJU=; b=jauniMX2hyc/HGBkPkZOOA47sP
	r47q1gm/AZ+majNjdrKv20rR7/euy9MNEH3MepR9rQxDA2fc2PWue48+b90ErFrFx/YjNnBKxp32z
	H7SohXtThiBtd3FvK24wIhSMSik5UAtjbP67eDupsfJ7ClLOGVGoB8Bq43+RIS4wyl6Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRqbV-000000005Wn-3WRG;
	Fri, 13 Nov 2026 12:42:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRqbU-000000005Wg-34ih
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 12:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+nqgyTCz2tHe3J9Yx3ywcdGgxtc+vlzahZbsf649odg=; b=dO+MpcBhk7H0k55J7pC4GTsNQV
 MS+02P93IReDABAEfhooaU4ErsvvcQbSdQmJ/pulkWiV4pS2yTqyJUEVcykTnR3lak4F6u6sX4FjO
 1levdLAM/s9dilBkELedSyqFv/J3VRmQIMJ4fPzhrnUeW1LwWyV4HeUHlxUdoXWyOA6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+nqgyTCz2tHe3J9Yx3ywcdGgxtc+vlzahZbsf649odg=; b=MbrTSUZjyg8v8IxfubGwiw8cIZ
 YbUKZ6nbSfqFkD+rltoAvENIL8Aqy1+1lrDeEXxE6npnif505NZujp9mdlNzB0P7u/VFh/UUpQrdD
 w+gx+C87SAjqyp/SaZqyyAryU3qiLc5ZFUN6oRS+qVPP0Fxy4Do2b+cQ8S3Zz3fIZXQo=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRqbS-000000001B5-3jb2 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 12:42:04 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so419785f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 04:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794573716; x=1795178516; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+nqgyTCz2tHe3J9Yx3ywcdGgxtc+vlzahZbsf649odg=;
 b=FOW3fHqXtTUxwmnBWSXnJRxfrw3OqtHtovXtaJToLUGusnlT3eFK5Lbm1kw0vAJQpO
 fEgXSFfqvfnTgr5W6ZNoj7oVdyXA1xW0CSxPWA+FtjaND+Gy89mnDxBko849rImNeKfg
 nu2qGf1EfNsh8vPc5a/8t55Z6mT+g+tRxm6ODrYMBqfFx5Q+HB7S6i+v3jJM4QMG04MQ
 DuB9almtVnzsYRkuhUr1npB5vpqx0SpuASztvVUR9aL9SLemU9V34iWuymra/bvSwNtX
 SxWyL3pLhgavTsAJMjExXTbHB600fkpGuglARw4GTavmDM2WoC378vvPCMjvAxZxEGLo
 x+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794573716; x=1795178516;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+nqgyTCz2tHe3J9Yx3ywcdGgxtc+vlzahZbsf649odg=;
 b=SUrH1ehPQwVT+2UazU4XMt9jpL6ggIaQfGnsZy2o480+Fu64jeZmEy1abrISXALCBz
 9wjfNQyE+3TvcZh2jAMB9s7QXL/vu5AKYuwE0fEj054EEoWonH21APboDDOKG8yQPyWx
 9h3Qzd5Wf0cPv081T57ikgcKGKBZONMwHOGKaNxE/N+Ei28AzM1wL3fYkDWJBZ1TTkPf
 AzWdN4tkLNaRjLqvLjQUfzPfGHoZOKNgF5rEvLG3Ku40TOw+mRQ5NUFgGW9Zogm2uXF6
 mme2aCodrwZkcpGuaX3qoEM69xVQwdbSpLzhTcnBjc5QYLF9AxiXlOHFpW+PvmoqHew2
 UUSQ==
X-Gm-Message-State: APuU4Z+06nlEcrtzzLo3lp27oz4G2+XaQqN7XEsZ9yViEn1xuNAqRHgW
 EGjTalZyd83WmjOxaLQWmPmHV/m1S/4BQ1+4JUDZnNLI9ErYTiQt1dDKsni+i21uO2GptmFovpf
 TbKRVrH/eWwwVk5fguv63bRYloy8Yervg36uWZjN95AdOLfs7fWoSYY5ojts5JP5GtTVL
X-Gm-Gg: AYBFou1ss9/Pmp4Prpy2TnzBRT3Y/3VaK6CsoSGYouAODkTBf8z/5jMuIIsDnZMeVMy
 PfNIK3+/kXtEv+D/WwNg/qj7Z6WYor9CjOfcty1Rg1fptKiW7lVFoVzGS8HZ2FRRKU6AWQwAoiK
 yg5SAvpFxJOr6LqWBxF07a9EyGmBlceW4GU/+uj/5HlrfRcMUCyg47/20UYhhvLlzA1Md8faFQY
 NlNVCTEv8X4phYf8agwXzWrlX8MiyvAnWZ24LbAUwcVeHnwJCOhnsYg706JlxBRjCWisBfSoV40
 fkDesucMGPFcuM7sWEfoA2Qh+uPXimv9iYdlb/A0OHAGrN35hIKw8YJaQd7UayKbpoKsNaSeu81
 BBXtL3ngg0rIp/6fP8DBZD8r+BQazQncyPG2Txkm2fUh/Hp3K/pipfyCccije+G3J7h3o99ik1z
 GOtW+T1jG0ziXKqPaDsP2S2px8Rc4AaYIlbnYF0QPunYX99x6TGythMkSMKrg/jL3odfPX35s9v
 aloonfgKewAb3+QeXQZsHE+CyLjfboPMjAO4RrTqwnazG6lWL6tWZpWt3nnWCdOLezgz59E64Bf
 A3A+yqy6I6+R29k96DRrAXYL4LxVsg6YPICfSH/HLO9RYgmCq9B6SesOqFD3G2qKWIxX2ZZijuF
 LXn6UFVT+HF/F7ZimzhMTPZi58RlBUFfG1Ojx69aYarfqZb4zK/+7c1cVlGEbUsgRNbFwxECnPh
 V157TEz9igcMo1nHo=
X-Received: by 2002:a05:6000:26c7:b0:48c:69bd:e971 with SMTP id
 ffacd0b85a97d-49c71e3e23dmr5500401f8f.16.1794573716012; 
 Fri, 13 Nov 2026 04:41:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608d10b2sm7700172f8f.44.2026.11.13.04.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 04:41:55 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 12:41:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0705cff831cbd18686721dffbe5960976e3489da
X-Gerrit-Change-Number: 2173
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2173?usp=email>
X-Gerrit-Commit: 4ad58c89a30bc5c11262ce5837ad8ff0560b9951
In-Reply-To: <gerrit.1794387287000.I0705cff831cbd18686721dffbe5960976e3489da@gerrit.openvpn.net>
References: <gerrit.1794387287000.I0705cff831cbd18686721dffbe5960976e3489da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg3Mjg3MDAwLkkwNzA1Y2ZmODMxY2JkMTg2ODY3MjFkZmZiZTU5NjA5NzZlMzQ4OWRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1dd937974adfbc67645009e6882e34ea7795cbcb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRqbS-000000001B5-3jb2
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun_afunix: reap the
 child process on close
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
Content-Type: multipart/mixed; boundary="===============2174306333703854173=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2174306333703854173==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/5tR8lwwDM8="; charset=UTF-8

--/5tR8lwwDM8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2173?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: tun_afunix: reap the child process on close
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun_afunix: reap th=
e child process on close

close_tun_afunix() sent SIGINT to the child but n=
ever waited for it,
leaving a zombie on every restart=2E

Poll for up to a =
second for it to exit, then SIGKILL it and poll for
another second=2E Don't=
 wait when SIGINT can't be delivered: a child
started before --user dropped=
 privileges would block close forever=2E

Change-Id: I0705cff831cbd18686721=
dffbe5960976e3489da
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
=
---
M src/openvpn/tun_afunix=2Ec
1 file changed, 37 insertions(+), 1 deleti=
on(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
73/2173/2

diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=
=2Ec
index 79d706a=2E=2Ecea1db1 100644
--- a/src/openvpn/tun_afunix=2Ec
+++=
 b/src/openvpn/tun_afunix=2Ec
@@ -125,6 +125,42 @@
     gc_free(&gc);
 }
 
=
+/* Waits a second for the child to exit on SIGINT, then SIGKILLs it and gi=
ves
+ * up after another second=2E A child started before --user dropped pr=
ivileges
+ * can't be signalled and is left running=2E */
+static void
+tun=
_afunix_stop_child(pid_t pid)
+{
+    const char *msgprefix =3D "AF_UNIX tu=
n: ";
+
+    if (kill(pid, SIGINT) !=3D 0)
+    {
+        msg(M_WARN | M_E=
RRNO, "%scannot stop child process %d", msgprefix, (int)pid);
+        retu=
rn;
+    }
+
+    for (int i =3D 0;; i++)
+    {
+        /* exited and rea=
ped, or not our child any more */
+        if (waitpid(pid, NULL, WNOHANG) =
!=3D 0)
+        {
+            return;
+        }
+        if (i =3D=3D 20=
0)
+        {
+            msg(M_WARN, "%scannot reap child process %d", ms=
gprefix, (int)pid);
+            return;
+        }
+        if (i =3D=3D 1=
00)
+        {
+            msg(M_WARN, "%schild process %d did not exit on=
 SIGINT, killing it", msgprefix,
+                (int)pid);
+            k=
ill(pid, SIGKILL);
+        }
+        platform_sleep_milliseconds(10);
+  =
  }
+}
+
 void
 close_tun_afunix(struct tuntap *tt)
 {
@@ -138,7 +174,7 @@
=
      * ourselves by accident */
     if (tt->afunix=2Echildprocess)
     {=

-        kill(tt->afunix=2Echildprocess, SIGINT);
+        tun_afunix_stop=
_child(tt->afunix=2Echildprocess);
     }
 
     free(tt->actual_name);

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0705cff831cbd1868=
6721dffbe5960976e3489da
Gerrit-Change-Number: 2173
Gerrit-PatchSet: 2
Gerri=
t-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>

--/5tR8lwwDM8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">tun_afunix: reap the child process on close<br><br>close_tun_afun=
ix() sent SIGINT to the child but never waited for it,<br>leaving a zombie =
on every restart=2E<br><br>Poll for up to a second for it to exit, then SIG=
KILL it and poll for<br>another second=2E Don&#39;t wait when SIGINT can&#3=
9;t be delivered: a child<br>started before --user dropped privileges would=
 block close forever=2E<br><br>Change-Id: I0705cff831cbd18686721dffbe596097=
6e3489da<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>---<br>M src/openvpn/tun_afunix=2Ec<br>1 file changed, 37 insertions(+), 1=
 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/73/2173/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tu=
n_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index 79d706a=2E=
=2Ecea1db1 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</span><b=
r><span>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -125,6 +125,42 =
@@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Waits a secon=
d for the child to exit on SIGINT, then SIGKILLs it and gives</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * up after another second=2E A c=
hild started before --user dropped privileges</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * can&#39;t be signalled and is left running=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_stop_child(pid=
_t pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char *msgprefix =3D =
&quot;AF_UNIX tun: &quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (kill=
(pid, SIGINT) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_WARN | M_ERRNO, &quot;%scannot stop child process %d&quot;, msgprefix, (i=
nt)pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (int i =3D 0;; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* exited and reaped, or not our child any mor=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (wai=
tpid(pid, NULL, WNOHANG) !=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (i =3D=3D 200)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(M_WARN, &quot;%scannot reap child process %d&quot;, msgprefix, (int)pi=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i =3D=3D 100)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;=
%schild process %d did not exit on SIGINT, killing it&quot;, msgprefix,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                (int)pi=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            kill=
(pid, SIGKILL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        platfo=
rm_sleep_milliseconds(10);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</s=
pan><br><span> close_tun_afunix(struct tuntap *tt)</span><br><span> {</span=
><br><span>@@ -138,7 +174,7 @@</span><br><span>      * ourselves by acciden=
t */</span><br><span>     if (tt-&gt;afunix=2Echildprocess)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        kill(t=
t-&gt;afunix=2Echildprocess, SIGINT);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        tun_afunix_stop_child(tt-&gt;afunix=2Echildproces=
s);</span><br><span>     }</span><br><span> </span><br><span>     free(tt-&=
gt;actual_name);</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demail">change 2173</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0705cff831cb=
d18686721dffbe5960976e3489da </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2173 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--/5tR8lwwDM8=--


--===============2174306333703854173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2174306333703854173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2174306333703854173==--

