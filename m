Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B543606A328
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ccR8C1IP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MNFo86QD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Twfia7NL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=P9geb4Ql
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=eikaYXUkYGDCF8h7/QDFU+B0GDvkY4uVb1+dejti1FI=; b=ccR8C1IPlvvkmFX0YefUpcr5Hn
	o6umFInum5ZJhp62X2o35XeE2IMbsu2eyuj6NlPBP47aMJAQHkoiclmk3xwF54YAyMEawe91SYNIW
	r8+Ai3sYk45LHYU0dNagmPYcBfipP7soo3FF1m+fyfNTFcaTs76MmPlN3A9HvHCEpVcI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xONbG-000000005qy-2YVI;
	Tue, 03 Nov 2026 23:07:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xONbE-000000005qr-2zQ0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hCyvIFawL5DxzhRLJw+iU4Q/7nu1Da4I1/MyQUE9vA8=; b=MNFo86QDFnQpYTFSymjnAwvviz
 QYrn6WWzyNtnzjMBy1a0tzUcnJH5SGHAhRVYpv+xkzmLt07cwf3/gX3RaZETp5h4bIEptqfPnDU/o
 47iD1A6hLikyWePDQm4EgPHcDUWPCIqOc1oiunx392tTf5+KHByZaX6uj0JD0sjB6x6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hCyvIFawL5DxzhRLJw+iU4Q/7nu1Da4I1/MyQUE9vA8=; b=Twfia7NL307wP4FMdFTzk2z9NP
 nEsfp5rargvI9apuDso9ypK4jQSmV190dQxHDOCZ0jnPrUTRNf27Tup70Lo+Zh69pc7L/3LqxIn9a
 JhtqJGNtGZgIsrDyz5na/u8VsCcnIdzSHkYhN17U8IHK0v5feY/jz4jp5K8X7nyBomMo=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xONbC-000000002sG-3MiS for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:28 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so127535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 15:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793747240; x=1794352040; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hCyvIFawL5DxzhRLJw+iU4Q/7nu1Da4I1/MyQUE9vA8=;
 b=P9geb4QlKq+miwLBcfRBg8ANYA5xvijgUfGmo2I2oJ0UzlIvAUnyrdUBX/IUZayrdk
 RtXQEOm4mt78DS9Y77BQ0yUZh2kKEcM6+V5te/594XUQLDCnqbVbW8jK+ioh/7XEpgtU
 DBj5mmRgg/rtjrNY4xBhisOaW5ez61yvnAAKj5Udr1+euxo3dPg446aDwbr6KVFjboBt
 bYYPK0TB9KYX4Z/LvaR8qA1ereC1qJ3nEVorGD8+RwipM6cVwL3MRUbz+oM+JsXOAY90
 XdHamS7LX2ZtQmXL5Y2W8jxsBJFbsbt2Oi5Ny0I2xKn9vyw8a60aS8akXNm46LSdm7TN
 jAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747240; x=1794352040;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hCyvIFawL5DxzhRLJw+iU4Q/7nu1Da4I1/MyQUE9vA8=;
 b=wpvBKOQ31oh3aIegthipPYaNd+ZyNqi0eur1GhlqPm41KZifNAHhBn/beifcdCcF1x
 RIo6RWqYls4/dX9NQjtBn86wW0iM8TqZbAEqhPy0UTtUj4efyKfUI+ufEvX2qpQM0d8v
 7Uv60Ad3cHDikQejtUVZ+KDyxWNmSS+xtKiUvmG8voSg0n9PiXgjN0jJbFWvtXi1XKl8
 soUBm/iMPqo1UTFFewFFBZ9jpc/YXFGSOgP/+zfjrrqyk9M51u3BvMbwXPHLtpxsX/R9
 Br4jFy84uvORauPRz4yM5gmoLwRA2elYN2XpzA6TT/QrbNZkXnyW3mvzB+oOrjDdbopc
 Lezw==
X-Gm-Message-State: APuU4Z/4OFxpyYxDsn5WoOth7Ot+8qzp7ZMmNlzIZktXrJTCAet8TWAg
 UnDdnxTsx8bfIyKNG7y5tYJPhun4lWm2MzNTFU1I3ayvRqAV3oqKeydWy7I9SgutZytBc14ElWX
 ZfPHcddinC3ASuDP6wYv4jRG9hO+iFl4dOL2CVKo4J8e8hblu4ZKa9j4TEs1g1J75TS34
X-Gm-Gg: AYBFou3SsZsCnwkQOUr1LYXu+hlQWmwtorLHNZWZNYpPVSidMnXqzWuxhJqO+AXEifJ
 ADpAsOE5FoUXGwWMMCbDuP1dsQO6f2l0UHO7kXxyo0zbMZj9bhEAFSZUPCQHS1qxDCih+IHgu1P
 Afuy+Tcio0am2w5/2JogiVEcNgd/8vOLuAZTL6RjHpTnLIhVr/WLKmrNQNa1KoJkxI9e1pvjp73
 iAI4LPaRWjbiZGy5EUovF1kwTXB3jQOQObMdPeDmKRgfCdwhwfpSxooKl4gpZQoNKzaButGTU1d
 CdC3yHQQHq5sneclq7oXXd3V0xuh9vg/TynN60OJGhqYyMaJDp3Jd/JFeOj2s8WXqdwv7h5BGy4
 iWh5w4L22OBUljI9hsao6FMJRWN+dppxPiWWvWjmvH8Ax3gGwQ4cy86h/SC5GtmIgI6bveYepM3
 uCkvx/sSGZ9Hp0PTJ/9CT0G2HsIV7kHK+h/3t6vVvwrIJ83+MeygZ74k228u+hynxwB5W05m1eE
 I4J2YHVjPyReEXnFbl8Gnc6Ob7jVvU6HLXGC8ZOUvseotawrugrgE/83H7ixdT28MpjoWYir3j3
 PAIgNYk1beJovGsEoVX5IO+59cdM0NsPfx/rLK64EY6h4bT0u0OTZL4QiQHSZ/2APdrygJ/bTr9
 YxHOa8C1zdrNVGkyJvcWykgzDQPq7piEmBQmMacITWBcRKoWGxcO8JATzXHj4V5Wmwv198lklul
 SuB0hI/6KJPh9O/g==
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4ac169d7e39mr328251645e9.5.1793747240147; 
 Tue, 03 Nov 2026 15:07:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b437864e3fsm7720285e9.0.2026.11.03.15.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:07:19 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 23:07:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I24744f5bc1b036e8abb9c1ec3cca13124aead441
X-Gerrit-Change-Number: 2115
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2115?usp=email>
X-Gerrit-Commit: 7ceecf8dbb42704ac7a32d60cb3f63b7315975c1
References: <gerrit.1793747232000.I24744f5bc1b036e8abb9c1ec3cca13124aead441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLkkyNDc0NGY1YmMxYjAzNmU4YWJiOWMxZWMzY2NhMTMxMjRhZWFkNDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbe272926d99f65a8335e60e130f301811a95b8f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xONbC-000000002sG-3MiS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: let
 workers clean up when stopping on error
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
Content-Type: multipart/mixed; boundary="===============7578916968401036121=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7578916968401036121==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U4gy0yf91Hs="; charset=UTF-8

--U4gy0yf91Hs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2115?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: let workers clean up when stopping on error
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: =
let workers clean up when stopping on error

If ConnectNamedPipe() or WaitF=
orMultipleObjects() failed, the service
stopped without waiting for its wor=
ker threads, so routes and DNS
settings of running connections were left be=
hind=2E The service also
reported a wrong exit code=2E

Signal the workers =
and wait for them like on a regular stop, and
report the actual error=2E

C=
hange-Id: I24744f5bc1b036e8abb9c1ec3cca13124aead441
Signed-off-by: Heiko Hu=
nd <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv/interactive=2Ec
1 f=
ile changed, 16 insertions(+), 5 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/15/2115/1

diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 37e8667=2E=2E=
2def870 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/=
interactive=2Ec
@@ -4077,7 +4077,7 @@
             }
             else if (=
connect_error !=3D ERROR_IO_PENDING)
             {
-                MsgToE=
ventLog(M_SYSERR, L"Could not connect pipe");
+                error =3D Ms=
gToEventLog(M_SYSERR, L"Could not connect pipe");
                 break;
 =
            }
         }
@@ -4146,10 +4146,7 @@
             CancelIo(pipe)=
;
             if (error =3D=3D WAIT_FAILED)
             {
-              =
  MsgToEventLog(M_SYSERR, L"WaitForMultipleObjects failed");
-             =
   SetEvent(exit_event);
-                /* Give some time for worker thre=
ads to exit and then terminate */
-                Sleep(1000);
+          =
      error =3D MsgToEventLog(M_SYSERR, L"WaitForMultipleObjects failed");
=
                 break;
             }
             if (!threads)
@@ -4168,=
6 +4165,20 @@
         }
     }
 
+    /* Let worker threads undo their cha=
nges before stopping */
+    if (threads)
+    {
+        status=2EdwCurren=
tState =3D SERVICE_STOP_PENDING;
+        ReportStatusToSCMgr(service, &sta=
tus);
+        SetEvent(exit_event);
+        /* handles[0] is io_event, th=
e rest are the worker threads */
+        if (WaitForMultipleObjects(handle=
_count - 1, handles + 1, TRUE, INFINITE) =3D=3D WAIT_FAILED)
+        {
+  =
          Sleep(5000); /* if we can't wait, give some time */
+        }
+ =
   }
+    CloseHandleEx(&pipe);
+
 out:
     FreeWaitHandles(handles);
    =
 CloseHandleEx(&io_event);

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2115?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I24744f5bc1b036e8abb9c1ec3cca13124aead441
Gerrit-Change-Number: 2=
115
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>

--U4gy0yf91Hs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2115?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: let workers clean up when stopping on error<br><br>I=
f ConnectNamedPipe() or WaitForMultipleObjects() failed, the service<br>sto=
pped without waiting for its worker threads, so routes and DNS<br>settings =
of running connections were left behind=2E The service also<br>reported a w=
rong exit code=2E<br><br>Signal the workers and wait for them like on a reg=
ular stop, and<br>report the actual error=2E<br><br>Change-Id: I24744f5bc1b=
036e8abb9c1ec3cca13124aead441<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2E=
eigentlich=2Enet&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file =
changed, 16 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/2115/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactiv=
e=2Ec</span><br><span>index 37e8667=2E=2E2def870 100644</span><br><span>---=
 a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/in=
teractive=2Ec</span><br><span>@@ -4077,7 +4077,7 @@</span><br><span>       =
      }</span><br><span>             else if (connect_error !=3D ERROR_IO_P=
ENDING)</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                MsgToEventLog(M_SYSERR, L&quot;Could not c=
onnect pipe&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                error =3D MsgToEventLog(M_SYSERR, L&quot;Could not connect =
pipe&quot;);</span><br><span>                 break;</span><br><span>      =
       }</span><br><span>         }</span><br><span>@@ -4146,10 +4146,7 @@<=
/span><br><span>             CancelIo(pipe);</span><br><span>             i=
f (error =3D=3D WAIT_FAILED)</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                MsgToEventLog(M_SYSER=
R, L&quot;WaitForMultipleObjects failed&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                SetEvent(exit_event);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                /* Give some time=
 for worker threads to exit and then terminate */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                Sleep(1000);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                error =3D MsgToEventLo=
g(M_SYSERR, L&quot;WaitForMultipleObjects failed&quot;);</span><br><span>  =
               break;</span><br><span>             }</span><br><span>      =
       if (!threads)</span><br><span>@@ -4168,6 +4165,20 @@</span><br><span=
>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Let worker threads undo their chan=
ges before stopping */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (threads)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status=
=2EdwCurrentState =3D SERVICE_STOP_PENDING;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ReportStatusToSCMgr(service, &amp;status);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetEvent(exi=
t_event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 handles[0] is io_event, the rest are the worker threads */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (WaitForMultipleObjects(=
handle_count - 1, handles + 1, TRUE, INFINITE) =3D=3D WAIT_FAILED)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            Sleep(5000); /* if we can&=
#39;t wait, give some time */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CloseHandl=
eEx(&amp;pipe);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> out:</span><br><span>     FreeWaitHandles(handles);</span><br=
><span>     CloseHandleEx(&amp;io_event);</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2115?usp=3Demail">ch=
ange 2115</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2115=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I24744f5bc1b036e8abb9c1ec3cca13124aead441 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2115 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko =
Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--U4gy0yf91Hs=--


--===============7578916968401036121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7578916968401036121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7578916968401036121==--

