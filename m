Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D8BC61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=S2392Zj5I7ymOour9gcRqf3T/UsnO2zIv/Vg21KkY40=; b=ZTUiNAamq0J/Jo
	GLWU2qatp5tloYmZg7q8KDsjfbgCg4GGV8fnKupQmm1dgRBQygGhyOiBnQ9Mpg2FSqz0PEZgjCJ3q
	//ewVk79e28Kv16RtJ2XfPsjuXqquqZctSUIMPRfaeXk8Pqh3M9n3C7iTAI/0H530vj1VQilhZ7wV
	LOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1S5E-00044h-JJ;
	Tue, 01 Sep 2026 17:15:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1S5D-00044b-Ob
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:15:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=znYAvkTbLSFn8T7fx/nno3iy+ZCWcPUgo5r7LXSmXIw=; b=CKasU31QJ11y6ojIvViWr3tHrJ
 m4U8saR0Ti57oF8dD1FU+8b+agRqCO2wpNS/467tX+ULm/Q0SNjDbxuDog2MkumknBAvllUnU1+l+
 b83PP/9kx+kD6I/2WL30+OpsGTp+zFKrYBvrShA1sJ+hb4g7+Qh0M2QxekKSb0gbdF0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=znYAvkTbLSFn8T7fx/nno3iy+ZCWcPUgo5r7LXSmXIw=; b=n
 J3qq/K3Y5qN38h57bBo4WLvPrThMCwN5KcaYbGWyS+YX2tykjYHUUVQNEOwqKrX8Ppr6G7teSuLon
 do16Cji47mjWUzav/Lcjd2aA8sBwy6Pb76XD9TADhedayocThL0QmDaK4bYoMZEnIyCsLOO5xPwfq
 9roqO13OJdChqAQc=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1S5D-0007lD-Jk for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:15:40 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48431648f33so1036847f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788282933; x=1788887733; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=znYAvkTbLSFn8T7fx/nno3iy+ZCWcPUgo5r7LXSmXIw=;
 b=EMn5pj00SCOOYywrisGDS88SypY3xdJrRxcnN0zE/M6JdpJivtr3xXkWrJGil4vrsa
 26gTHaicsymqdO7p5awMepCzX4HjBbeMqp6Ny+PTVeQcgRrfFsqQxkm99MRhBtP8L6kq
 1R25MCJCnSmP4Kvmdr6EJSlVhq/b87XqtqWa0bFRL/JnskdH91AVRPj6f0BUqe9Xb+LM
 XypT3VAQmQ4msAEm9vDl2E0X+3O4dE5t6QZ4JLWp20MOcX8kNQNjSrY1DTMVUVxcGde7
 pElu6k7He7cslj2IqKrhX60YerXNHOgUTyiuYFSS+UZ91JZ5no8zVG3qUlD/oczrkBOC
 iajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282933; x=1788887733;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=znYAvkTbLSFn8T7fx/nno3iy+ZCWcPUgo5r7LXSmXIw=;
 b=qDYD/rqLbZDWdT+4Tvq114IMScgnHPOFJGBUbUbwzZDDdpbJ6YmqneXKqIPeYy71gV
 eOc0sfznT/Z1E0wckG5QqmnZEtI34J1jSHpwysQZG4fCDHkDOrvbISHcmbAn2sumyfCW
 WvAMz6dHd7HvJznVASQ88nn3NEpgAJCOBO5ZNuQ1g5Ezt7hGOg53GZ6YEjU9RNzp5dZ4
 FtRxYLnUnPp6zLIk4nrP8ovOmoW9ytoN0JeqP+hB50Z8MsCOuxOIrgK4rRdRmP9qfGzd
 yBblFggTRUCREEJStlnoIZL8Z/EE+CD7iNfay7EBeAFQVloIi4OUZr0k6j3VeJMMBtrg
 YV3w==
X-Gm-Message-State: AFuF++mBd8Kb5AVDjc4s0arj3Rr4pYqa51/qK15rMBDADXI4mj2At8VC
 Yepz/lxePZtDYNBzbtHgNnU/QDeYB6HXHp/VAxIY8si0o2yPksHhNllnRr50g650fELsRHWJljI
 Vd1VD5csorSHR8ijdzGc9rmPx1Ff7QKBg1KruroU8Di7786NttAsCKRUc4/IKXt034WRyVpFacQ
 F3l6cHWw==
X-Gm-Gg: AR+sD105J9/4281KS4b4GHbTpuJ/uj6bLI+iwlJzasxGR2fn1gHLeVBthqL/kEAr7Xb
 9TzhTFU1FtqSKmWBQlepOvWzl6Ekmdh1keJL0BlxJar6A8HyZHz/XkzxG5mW8uSDQRDICN1OdDs
 xtTo68+bKUr9ZrCsCkHZT4LuFSkEu/RxMis6C2rFq9GJoFWYNcbcKNrgDDTJg52bDZ7V3dUqtod
 CKdUzjIZeLU7jcyzFi7CPLJJE/mPVpmMeO9QPi1BbvzyvaTDkZxwj7N4qBuHZAK2cJnnhkd1xKT
 3xZLf6D+Ksi2PJpecgAKfyPfsZ6LRYq0TLS1sPn4i39xZweQzG2Vp3IOggkm7grFwB26mL0g61G
 WmyycWGiVmAJauuYSl3udTHIJYYoPyjX9q4/HJdKvS1fsH43E4FzuI7CTbubb05ElaAJCms3d7q
 NGjOywAKr0kpYUKqWXLqnUbrtEx9oTIy9YCBfcjOydgLgNpLZsViK4NFvLvDRVLM1DpBeMlMHAI
 DiHkqjXkaGAND9pl9VizoQXWiUyyxyWayVY+5Ibwrjou0e5InwDas4T+AI6OpklQIKG7A13VrVW
 TgBEHUqQJ9qn854ZhYzhcG6LnWnkaWo7sQbAXMHWCeD0daXh6ss=
X-Received: by 2002:a05:600c:1f84:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49cdd410a3dmr81341845e9.3.1788282932697; 
 Tue, 01 Sep 2026 10:15:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce464aa32sm1843205e9.5.2026.09.01.10.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:15:32 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 17:15:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
X-Gerrit-Change-Number: 1890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1890?usp=email>
X-Gerrit-Commit: f83c387ef655c26fe18c0867cc338d609940d99e
References: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyOTMwMDAwLkk3MDI4Mjk4NWE3ZThlNDZhZGQ5MmIyMjc3Njc0Y2JjYTZiY2UzOWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e421208c89c187c8530255e822e34de3b815724c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1S5D-0007lD-Jk
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tapctl: prevent
 binary planting with netsh
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3584658264823972178=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3584658264823972178==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uNS//MEY9jI="; charset=UTF-8

--uNS//MEY9jI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1890?usp=3Demail

to review the following change=2E
=


Change subject: tapctl: prevent binary planting with netsh
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tapctl: prevent binary pl=
anting with netsh

Provide a application name to CreateProcess(), so that i=
t doesn't try to
locate an executable - somewhere=2E Instead construct the =
full path to
netsh=2Eexe in the system dir and pass that to the function in=
stead of NULL=2E

Discovered and reported by BreachX Zero Day Labs, using T=
yphon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

Reported-by: V=
ivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Parikh <vivek=2E=
parikh@breachx=2Eai>
Github: OpenVPN/openvpn-private-issues#164
CVE: 2026-8=
4226
Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
Signed-off-by: He=
iko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/tapctl/tap=2Ec
1 file cha=
nged, 16 insertions(+), 11 deletions(-)



  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/90/1890/1

diff --git a/src/tapctl/tap=
=2Ec b/src/tapctl/tap=2Ec
index 1d94988=2E=2E769df6c 100644
--- a/src/tapct=
l/tap=2Ec
+++ b/src/tapctl/tap=2Ec
@@ -921,32 +921,38 @@
                  =
                   bEnable ? enable_device : disable_device, pbRebootRequir=
ed);
 }
 
-/* stripped version of ExecCommand in interactive=2Ec */
 static=
 DWORD
-ExecCommand(const WCHAR *cmdline)
+ExecNetsh(PWSTR cmdline)
 {
    =
 DWORD exit_code;
     STARTUPINFOW si;
     PROCESS_INFORMATION pi;
     D=
WORD proc_flags =3D CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT;
-    WCH=
AR *cmdline_dup =3D NULL;
 
     ZeroMemory(&si, sizeof(si));
     ZeroMemo=
ry(&pi, sizeof(pi));
-
     si=2Ecb =3D sizeof(si);
 
-    /* CreateProcess=
 needs a modifiable cmdline: make a copy */
-    cmdline_dup =3D _wcsdup(cm=
dline);
-    if (cmdline_dup
-        && CreateProcessW(NULL, cmdline_dup, =
NULL, NULL, FALSE, proc_flags, NULL, NULL, &si, &pi))
+    WCHAR appName[MA=
X_PATH];
+    WCHAR netsh_exe[] =3D L"\\netsh=2Eexe";
+    UINT sysdir_len =
=3D GetSystemDirectoryW(appName, _countof(appName));
+    if (sysdir_len =
=3D=3D 0)
+    {
+        wcscpy_s(appName, _countof(appName), L"C:\\Window=
s\\system32");
+    }
+    else if (sysdir_len + _countof(netsh_exe) > _cou=
ntof(appName))
+    {
+        return ERROR_INSUFFICIENT_BUFFER;
+    }
+  =
  wcscat_s(appName, _countof(appName), netsh_exe);
+
+    if (CreateProcess=
W(appName, cmdline, NULL, NULL, FALSE, proc_flags, NULL, NULL, &si, &pi))
 =
    {
         WaitForSingleObject(pi=2EhProcess, INFINITE);
         if (!=
GetExitCodeProcess(pi=2EhProcess, &exit_code))
         {
             exit=
_code =3D GetLastError();
         }
-
         CloseHandle(pi=2EhProcess);=

         CloseHandle(pi=2EhThread);
     }
@@ -955,7 +961,6 @@
         ex=
it_code =3D GetLastError();
     }
 
-    free(cmdline_dup);
     return ex=
it_code;
 }
 
@@ -1013,7 +1018,7 @@
 
     free(szOldName);
 
-    dwResult=
 =3D ExecCommand(szCmdLine);
+    dwResult =3D ExecNetsh(szCmdLine);
     f=
ree(szCmdLine);
 
     if (dwResult !=3D ERROR_SUCCESS)

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I70282985a7e8e46add92b2277674cbca6bce3=
9c1
Gerrit-Change-Number: 1890
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert=
@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>

--uNS//MEY9jI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>cron2 would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">tapctl: prevent binary planting with netsh<br><br>Provide a applicatio=
n name to CreateProcess(), so that it doesn&#39;t try to<br>locate an execu=
table - somewhere=2E Instead construct the full path to<br>netsh=2Eexe in t=
he system dir and pass that to the function instead of NULL=2E<br><br>Disco=
vered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E<br>C=
ontributing Researcher: Vivek Parikh=2E<br><br>Reported-by: Vivek Parikh &l=
t;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Parikh &lt;vivek=2Epa=
rikh@breachx=2Eai&gt;<br>Github: OpenVPN/openvpn-private-issues#164<br>CVE:=
 2026-84226<br>Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1<br>Sign=
ed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/=
tapctl/tap=2Ec<br>1 file changed, 16 insertions(+), 11 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/90/1890/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/ta=
p=2Ec</span><br><span>index 1d94988=2E=2E769df6c 100644</span><br><span>---=
 a/src/tapctl/tap=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</span><br><s=
pan>@@ -921,32 +921,38 @@</span><br><span>                                 =
    bEnable ? enable_device : disable_device, pbRebootRequired);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/* stripped version of ExecCommand in interactive=2Ec */</span><br><sp=
an> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ExecC=
ommand(const WCHAR *cmdline)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ExecNetsh(PWSTR cmdline)</span><br><span> {</span><br><span>     D=
WORD exit_code;</span><br><span>     STARTUPINFOW si;</span><br><span>     =
PROCESS_INFORMATION pi;</span><br><span>     DWORD proc_flags =3D CREATE_NO=
_WINDOW | CREATE_UNICODE_ENVIRONMENT;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    WCHAR *cmdline_dup =3D NULL;</span><br><span> </span><b=
r><span>     ZeroMemory(&amp;si, sizeof(si));</span><br><span>     ZeroMemo=
ry(&amp;pi, sizeof(pi));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     si=2Ecb =3D sizeof(si);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* CreateProcess needs a m=
odifiable cmdline: make a copy */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    cmdline_dup =3D _wcsdup(cmdline);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (cmdline_dup</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        &amp;&amp; CreateProcessW(NULL, cmdline_d=
up, NULL, NULL, FALSE, proc_flags, NULL, NULL, &amp;si, &amp;pi))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR appName[MAX_PATH];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR netsh_exe[=
] =3D L&quot;\\netsh=2Eexe&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    UINT sysdir_len =3D GetSystemDirectoryW(appName, _countof=
(appName));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
sysdir_len =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wcscp=
y_s(appName, _countof(appName), L&quot;C:\\Windows\\system32&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (sysdir_len + _countof(netsh=
_exe) &gt; _countof(appName))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return ERROR_INSUFFICIENT_BUFFER;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    wcscat_s(appName, _countof(appName), netsh_exe);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (CreateProcessW(appName, cmdline, NULL, NULL, FALS=
E, proc_flags, NULL, NULL, &amp;si, &amp;pi))</span><br><span>     {</span>=
<br><span>         WaitForSingleObject(pi=2EhProcess, INFINITE);</span><br>=
<span>         if (!GetExitCodeProcess(pi=2EhProcess, &amp;exit_code))</spa=
n><br><span>         {</span><br><span>             exit_code =3D GetLastEr=
ror();</span><br><span>         }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>         CloseHandle(pi=2EhProcess);</span><br=
><span>         CloseHandle(pi=2EhThread);</span><br><span>     }</span><br=
><span>@@ -955,7 +961,6 @@</span><br><span>         exit_code =3D GetLastEr=
ror();</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    free(cmdline_dup);</span><br><span>     retur=
n exit_code;</span><br><span> }</span><br><span> </span><br><span>@@ -1013,=
7 +1018,7 @@</span><br><span> </span><br><span>     free(szOldName);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dwResu=
lt =3D ExecCommand(szCmdLine);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dwResult =3D ExecNetsh(szCmdLine);</span><br><span>     free=
(szCmdLine);</span><br><span> </span><br><span>     if (dwResult !=3D ERROR=
_SUCCESS)</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail">change 1890</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:n=
one"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Br=
anch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7028298=
5a7e8e46add92b2277674cbca6bce39c1 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 1890 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk =
&lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>

</body></html>
--uNS//MEY9jI=--


--===============3584658264823972178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3584658264823972178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3584658264823972178==--

