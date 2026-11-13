Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DED606B191
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jPptTQSY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DPSnUWU5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W/ls5NB5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CiLfDP1B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jbbnZBXYHvSi2yNYnqeDg20ox/wuyvUpjrHxLj0zL8A=; b=jPptTQSYTWduMkMp+e/dXqmjQb
	bWFCRc2DVRKgcelC4PV7aUqIok/XHa0Ur/h/5PjINKw3CE2GmlK39/0N0IPGvT3g5RckfXmx8epCP
	F+RwFst2PkqTc6j7z5Z1GepCu2LySJpKbGIZugO3PBlyVHx3UqasYDLuhQnUlx/2g55o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRrjk-000000004Y9-3mt8;
	Fri, 13 Nov 2026 13:54:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRrjj-000000004Y2-0kP9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 13:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gaTWPsMMDOq+ZULmNKFywMjrLtKUU91ZVh8YtGm/xeM=; b=DPSnUWU5BFurpI9x6KxoGVWS6o
 BiW5AKCeDP8KBoZNCQZpEOD+PWpjTw2nbijoS8xTYNIRDN8nxuxSAwHp3v8A4Ydq55H9yI6mCZQGj
 40sI0rPiQ9Qt04OnM3RrVDmWy8/KS/EKruVhlud1jZnM7rVfKVIrcZDoxXDBa1sgGdMM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gaTWPsMMDOq+ZULmNKFywMjrLtKUU91ZVh8YtGm/xeM=; b=W/ls5NB5cJb7BbtyTvfHIJ5k5H
 77iz1bf9RszLkoy1+nZM0GMpo5n4Brjm1fJLH3iqYXq1JLXg7usi+Fl2w+ilNmLaprSs+OCLli0bO
 5NkNPz0UIz7h5ibUHxtAf0SlWRX7hNNFnZjA0igGhnjJJo/zMZE0DsxmIohTYu8d5FUQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRrjf-000000005Yw-1F5v for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 13:54:39 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so6783365e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 05:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794578069; x=1795182869; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gaTWPsMMDOq+ZULmNKFywMjrLtKUU91ZVh8YtGm/xeM=;
 b=CiLfDP1BfEkWqr4Z2lk/Je8L29TeOZP6NT7MaGU26nYfX31QvbZXn4zvRI2sIEg1Th
 KqIGAD2FR/xWbPijEsvMNttWCTwaxm1uBt0s8DPSa6WesXUGdUqkxa89LPwTSOc63i6/
 XzNXaxTGq1yLNuq7Ac/3VUoED8BV4jZcNMPbMgsxMNqnXE/rrwhQmvMUtqOeSnfrkCDl
 THqInFYkRiFSXgvBapK40AbOa47cZ6FGSCBvV7suXIOuLBIxXyo00qKOaLwpgpnn8rXb
 S70hKzcGdy+cVAAozbGoKtY6AdS5uO+jJ3614YiLOeJVBUtqLLneAWVLiXPFTR8Z8kj9
 rqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794578069; x=1795182869;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gaTWPsMMDOq+ZULmNKFywMjrLtKUU91ZVh8YtGm/xeM=;
 b=ccxmYr3xJJihKp3wbvXDJ2ytawdwwi7ocQhkuIitn41euEPUg0u95BVM9SG+dLkFBQ
 maXTVH6ZQpzSbB0JPPAdy37Ga8uez+p8vpd1Dh2mGk0CsRisv2fozsDH8J2eru+Vfxe4
 +7bkFwTis2sDCI/o9goenuiWXsC9SIRXhpRFPPmWa0Jvs+6W8DDQlZdMRfH0W+GT1vJe
 8hR6cYuj2dlzIFnxuYK/70rbtASgWgdGEJ3xtd0FDO+KCGspIwo0IH70m5pUPehnaRbH
 CYSlTzmw3ooynQyzN8K2Wvwoxg8Si3/FZnXX2WAlabEho4hicoNxvy6avjPmkp+mkxHM
 EyKA==
X-Gm-Message-State: APuU4Z/G3W3DO+NflUdCfzfiCcf+nOs1zBPhVOOQTJV/Vm2D2IJ82LDG
 0CR4SoNoFVlB5wHxHFNLdo+C58lMKQjtwNGB5u4THj1QgwRTg1lIOjUm1WD4okWO9IMjMibLwp9
 wfNXyXOnrPr/BPSXb7irrR9lcwkf6ZFk6Js4vZjA+zoR927ZtxsORvMuAZVV4EjYfzrZ5
X-Gm-Gg: AYBFou2e1eK7L64RhkdCwOiCtLFbgbHrqGuxAhgZVaOteYadvoyD1TtaBDsLPFccYXI
 jLwIV6I8U+aZLEPigBT2R/nt256X67TglmR4FJo0cAxLoy04Vqx3fAhLf3iuo2P/lkTJ1vpnBu1
 3YI77f6wlRcu7aD++L4C3ScX26+br/SztTxjM7hxz/fpbaUZDm14Iq2BkuuDbV+szsr5VU2O02d
 07ErjZpymGSsyIlbzh2x8p/ypcGGV5A3vZHMgJ10OnTwjGrtNML7Af2Kle8eRueWpov/Iv3DX1o
 8GXcH4XyVxQ3h1fr6MptheqrC0+43WjcAJvPdvzEqXky+25fQ0HeF5/Niv8yi2x29UiapE/4V10
 bewNYM2cWvTJpbFmXjYWu/ALVZ1kW6Ydq0NNU8OCG+WVhvcWXGCs5MMmlTDKBdSFolxmdht983L
 ZnDD02k23IynoP8Afr0urXLgzyOsKCE+8Mt6WAPUOYyO3yuqsdfu6lu6ZziC/9BNrlgFxHQRJT0
 20jC5YP0Up146bjyLIJQ9E554qSsegytNiOI8wIGld12Kged4TLc1fpy48MjXYStYVNFTQJuohJ
 5nnlczpUsE2HfA/cKXCrSg+R0GJkUeSA1mCElxkLSseoEVXX/GF7KxmX9iNpTRYgIgPmKfLJBUR
 KTL3gQonOinjjqV6Ar1A5zhsX1eg4eqyH5MZlnEEvTuKbSzVrr55T7U3NoT6cNVr3BCituXKJ8U
 6bso9rrjmdCVpSNxI=
X-Received: by 2002:a05:600c:1c02:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4bb559f329bmr64917335e9.2.1794578068454; 
 Fri, 13 Nov 2026 05:54:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e294420sm148627695e9.9.2026.11.13.05.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:54:27 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 13:54:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0705cff831cbd18686721dffbe5960976e3489da
X-Gerrit-Change-Number: 2173
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2173?usp=email>
X-Gerrit-Commit: c720d24931f9a06276cf841a0c8832b80dce48b7
In-Reply-To: <gerrit.1794387287000.I0705cff831cbd18686721dffbe5960976e3489da@gerrit.openvpn.net>
References: <gerrit.1794387287000.I0705cff831cbd18686721dffbe5960976e3489da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg3Mjg3MDAwLkkwNzA1Y2ZmODMxY2JkMTg2ODY3MjFkZmZiZTU5NjA5NzZlMzQ4OWRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <87a1cc7c8b413f6ce3c5f5c3a665b059e4994933-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRrjf-000000005Yw-1F5v
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tun_afunix: reap the
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
Content-Type: multipart/mixed; boundary="===============1084455528043352208=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1084455528043352208==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M6KWP7Fm3Ak="; charset=UTF-8

--M6KWP7Fm3Ak=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2173?usp=3Demail

to look at the new patch set (#=
3)=2E


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

Add openvpn_stop_=
child() next to openvpn_waitpid_check()=2E It waits up
to a second for the =
child to exit, then SIGKILLs it and waits up to
another second=2E It doesn'=
t wait when SIGINT can't be delivered, e=2Eg=2E to
a child started before -=
-user dropped privileges=2E

openvpn_waitpid_check() now returns false and =
logs why when waitpid()
fails, as documented, instead of reporting a proces=
s that isn't our
child as running=2E A clean exit is no longer logged as an=
 error status=2E

Change-Id: I0705cff831cbd18686721dffbe5960976e3489da
Sign=
ed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/run_co=
mmand=2Ec
M src/openvpn/run_command=2Eh
M src/openvpn/tun_afunix=2Ec
3 file=
s changed, 60 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/73/2173/3

diff --git a/src/openvpn/r=
un_command=2Ec b/src/openvpn/run_command=2Ec
index 0e36dad=2E=2Edb25792 100=
644
--- a/src/openvpn/run_command=2Ec
+++ b/src/openvpn/run_command=2Ec
@@ =
-115,10 +115,15 @@
     }
     int status;
     pid_t pidret =3D waitpid(pi=
d, &status, WNOHANG);
-    if (pidret !=3D pid)
+    if (pidret =3D=3D 0)
 =
    {
         return true;
     }
+    if (pidret !=3D pid)
+    {
+      =
  msg(msglevel | M_ERRNO, "%scannot wait for external program", msg_prefix)=
;
+        return false;
+    }
 
     if (WIFEXITED(status))
     {
@@ -12=
8,6 +133,10 @@
         {
             msg(msglevel, "%scould not execute e=
xternal program (exit code 127)", msg_prefix);
         }
+        else if =
(exitcode =3D=3D 0)
+        {
+            msg(msglevel, "%sexternal progr=
am exited", msg_prefix);
+        }
         else
         {
             m=
sg(msglevel, "%sexternal program exited with error status: %d", msg_prefix,=
 exitcode);
@@ -140,6 +149,44 @@
 
     return false;
 }
+
+/* Returns true=
 if the child was reaped (or is gone) within ms milliseconds=2E */
+static =
bool
+wait_for_child_exit(pid_t pid, const char *msg_prefix, unsigned int m=
s)
+{
+    for (unsigned int waited =3D 0; openvpn_waitpid_check(pid, msg_p=
refix, D_CLOSE); waited +=3D 10)
+    {
+        if (waited >=3D ms)
+     =
   {
+            return false;
+        }
+        platform_sleep_millisec=
onds(10);
+    }
+    return true;
+}
+
+void
+openvpn_stop_child(pid_t pid=
, const char *msg_prefix)
+{
+    if (kill(pid, SIGINT) !=3D 0)
+    {
+   =
     msg(M_WARN | M_ERRNO, "%scannot stop child process %d", msg_prefix, (i=
nt)pid);
+        return;
+    }
+
+    if (wait_for_child_exit(pid, msg_pr=
efix, 1000))
+    {
+        return;
+    }
+
+    msg(M_WARN, "%schild pro=
cess %d did not exit on SIGINT, killing it", msg_prefix, (int)pid);
+    ki=
ll(pid, SIGKILL);
+
+    if (!wait_for_child_exit(pid, msg_prefix, 1000))
+=
    {
+        msg(M_WARN, "%scannot reap child process %d", msg_prefix, (i=
nt)pid);
+    }
+}
 #endif /* ifndef WIN32 */
 
 bool
diff --git a/src/open=
vpn/run_command=2Eh b/src/openvpn/run_command=2Eh
index e11b6a1=2E=2Ec1f1f4=
c 100644
--- a/src/openvpn/run_command=2Eh
+++ b/src/openvpn/run_command=2E=
h
@@ -79,6 +79,17 @@
  */
 bool openvpn_waitpid_check(pid_t pid, const char=
 *msg_prefix, msglvl_t msglevel);
 
+/**
+ * Stops and reaps a process star=
ted with \c S_NOWAITPID: sends SIGINT,
+ * then SIGKILL if it hasn't exited=
 after a second, and gives up after
+ * another second=2E Doesn't wait if S=
IGINT can't be delivered, e=2Eg=2E to a
+ * process started before --user d=
ropped privileges=2E
+ *
+ * @param pid            pid of the process to be=
 stopped
+ * @param msg_prefix     prefix of the messages to be printed
+ *=
/
+void openvpn_stop_child(pid_t pid, const char *msg_prefix);
+
 #endif
 
=
 /**
diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
i=
ndex 79d706a=2E=2Eb4daf9d 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src=
/openvpn/tun_afunix=2Ec
@@ -138,7 +138,7 @@
      * ourselves by accident *=
/
     if (tt->afunix=2Echildprocess)
     {
-        kill(tt->afunix=2Echi=
ldprocess, SIGINT);
+        openvpn_stop_child(tt->afunix=2Echildprocess, =
"AF_UNIX tun: ");
     }
 
     free(tt->actual_name);

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I0705cff831cbd18686721dffbe5960976e=
3489da
Gerrit-Change-Number: 2173
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--M6KWP7Fm3Ak=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">tun_afunix: reap the child process on close<br><br>close_tun_afun=
ix() sent SIGINT to the child but never waited for it,<br>leaving a zombie =
on every restart=2E<br><br>Add openvpn_stop_child() next to openvpn_waitpid=
_check()=2E It waits up<br>to a second for the child to exit, then SIGKILLs=
 it and waits up to<br>another second=2E It doesn&#39;t wait when SIGINT ca=
n&#39;t be delivered, e=2Eg=2E to<br>a child started before --user dropped =
privileges=2E<br><br>openvpn_waitpid_check() now returns false and logs why=
 when waitpid()<br>fails, as documented, instead of reporting a process tha=
t isn&#39;t our<br>child as running=2E A clean exit is no longer logged as =
an error status=2E<br><br>Change-Id: I0705cff831cbd18686721dffbe5960976e348=
9da<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<=
br>M src/openvpn/run_command=2Ec<br>M src/openvpn/run_command=2Eh<br>M src/=
openvpn/tun_afunix=2Ec<br>3 files changed, 60 insertions(+), 2 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/73/2173/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/run_command=2E=
c b/src/openvpn/run_command=2Ec</span><br><span>index 0e36dad=2E=2Edb25792 =
100644</span><br><span>--- a/src/openvpn/run_command=2Ec</span><br><span>++=
+ b/src/openvpn/run_command=2Ec</span><br><span>@@ -115,10 +115,15 @@</span=
><br><span>     }</span><br><span>     int status;</span><br><span>     pid=
_t pidret =3D waitpid(pid, &amp;status, WNOHANG);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (pidret !=3D pid)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (pidret =3D=3D 0)</span><br><span>=
     {</span><br><span>         return true;</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pidret !=3D pid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel | M_ERRNO, &quo=
t;%scannot wait for external program&quot;, msg_prefix);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     if (WIFEXITED(status))</span><br><span>     {</span><br><span>@@ -=
128,6 +133,10 @@</span><br><span>         {</span><br><span>             ms=
g(msglevel, &quot;%scould not execute external program (exit code 127)&quot=
;, msg_prefix);</span><br><span>         }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        else if (exitcode =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;%sexternal pro=
gram exited&quot;, msg_prefix);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span>         else</span><br><span>       =
  {</span><br><span>             msg(msglevel, &quot;%sexternal program exi=
ted with error status: %d&quot;, msg_prefix, exitcode);</span><br><span>@@ =
-140,6 +149,44 @@</span><br><span> </span><br><span>     return false;</spa=
n><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Returns true if the c=
hild was reaped (or is gone) within ms milliseconds=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+wait_for_child_exit(pid_t pid, const char *ms=
g_prefix, unsigned int ms)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (un=
signed int waited =3D 0; openvpn_waitpid_check(pid, msg_prefix, D_CLOSE); w=
aited +=3D 10)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (waited =
&gt;=3D ms)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        platform_sleep=
_milliseconds(10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+openvpn_stop_child(pid_t pid, const char *msg_prefix)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (kill(pid, SIGINT) !=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%scannot stop chil=
d process %d&quot;, msg_prefix, (int)pid);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (wait_f=
or_child_exit(pid, msg_prefix, 1000))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;%schild pro=
cess %d did not exit on SIGINT, killing it&quot;, msg_prefix, (int)pid);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    kill(pid, SIGKILL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!wait_for_child_exit(pid, msg=
_prefix, 1000))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN=
, &quot;%scannot reap child process %d&quot;, msg_prefix, (int)pid);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* ifndef WIN3=
2 */</span><br><span> </span><br><span> bool</span><br><span>diff --git a/s=
rc/openvpn/run_command=2Eh b/src/openvpn/run_command=2Eh</span><br><span>in=
dex e11b6a1=2E=2Ec1f1f4c 100644</span><br><span>--- a/src/openvpn/run_comma=
nd=2Eh</span><br><span>+++ b/src/openvpn/run_command=2Eh</span><br><span>@@=
 -79,6 +79,17 @@</span><br><span>  */</span><br><span> bool openvpn_waitpid=
_check(pid_t pid, const char *msg_prefix, msglvl_t msglevel);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Stops and reaps a process st=
arted with \c S_NOWAITPID: sends SIGINT,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * then SIGKILL if it hasn&#39;t exited after a second=
, and gives up after</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * another second=2E Doesn&#39;t wait if SIGINT can&#39;t be delivered, e=
=2Eg=2E to a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * proc=
ess started before --user dropped privileges=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param pid            pid of the process to be stopped</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msg_prefix     p=
refix of the messages to be printed</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void openvpn_stop_child(pid_t pid, const char *msg_prefix);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif</span><br>=
<span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/tun_a=
funix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index 79d706a=2E=2Eb=
4daf9d 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</span><br><s=
pan>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -138,7 +138,7 @@</s=
pan><br><span>      * ourselves by accident */</span><br><span>     if (tt-=
&gt;afunix=2Echildprocess)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        kill(tt-&gt;afunix=2Echildprocess, SIGI=
NT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn=
_stop_child(tt-&gt;afunix=2Echildprocess, &quot;AF_UNIX tun: &quot;);</span=
><br><span>     }</span><br><span> </span><br><span>     free(tt-&gt;actual=
_name);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2173?usp=3Demail">change 2173</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I0705cff831cbd18686721d=
ffbe5960976e3489da </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2173 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--M6KWP7Fm3Ak=--


--===============1084455528043352208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1084455528043352208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1084455528043352208==--

