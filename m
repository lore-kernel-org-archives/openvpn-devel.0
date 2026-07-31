Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BF8C55167
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ae+ugjP1goyJGKLmjutpQDcCb21Qz+mhkfaE8yjenPE=; b=jgIEEB/bGvfyjUSi/BUXdke8cR
	nHslvVHwFH1b6MqzgalqqGy05/CnkWfhE9PnzHJHPawpSCmEG26cRxTaXyP7e2nTG1Uu/qQ7BLnA1
	bKmiiPwJqUgWZoAeLO1zLy2+sBk4R0H+5NYQ1Xf0jFYuBj76W+86j6DGEZPhTkP/1Zzg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpk8D-0005Mz-D5;
	Fri, 31 Jul 2026 10:06:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpk8B-0005Mq-AW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bNufXrNhgodpdM+ZaPj7HklQdnxu0mx/1/y4yhq0iQU=; b=dR+HzbtA7m6f/GmzpVkY/EDbZz
 B8Hz+Ai0P/cWf6paZGV5PgpMd39mtTDTzuJg8H3LLATj5DO9pfjTXEQ8BVtkArRcvCVJWfGER4+7W
 u/u7IxRApyqyNc8RFWSRcAWkV/vYQfkWxWtpFuJQYV53Of9fS75xbllnSi2F7SNd2T30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bNufXrNhgodpdM+ZaPj7HklQdnxu0mx/1/y4yhq0iQU=; b=j
 63G2CP4dyblt5v26Yu5+rku/stW97JM0hyIzp3f/QXKhzp4Id167/rgGnc3RUoMpa8nhyMaYgABIA
 fjwoj7gsZRm78T8OTWzfhUR0HygyhtBHIRo1RVznDNITbBmW6xSk8L4Q84Idd6H+YkpcE9XY9kHB8
 A1Qt6EY2AUQsozD4=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpk86-0003yf-ER for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:06:15 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-472326ca506so552230f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 31 Jul 2026 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785492368; x=1786097168; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bNufXrNhgodpdM+ZaPj7HklQdnxu0mx/1/y4yhq0iQU=;
 b=cii90LJurUPVZRk04p00gVGa6pYZAvwWv+19UM3qS3Nb2YCm08vtWabU8w+Fns9sa+
 h4ntp7VQ835T9gwj5pvUD9AMBI4LReVRRciwtF3TIDAGKQ+OUxtHL+IxzU1+XwaOdbRL
 DELpc8TRO26oIBKW3rO3LlThiIIuz/N4NE99/zz3jiUAxLxepa5uAzSVD5FUuVJkW0l7
 gxOVER/l+Y7+bt1IxgUw23J8vb+5Q/jNUZkxpKn5+TwqKvENUed6YdujXl1qZzT6NWsq
 BwfB7TdeKAvk+Y7+xaBPNzppxPt3/nJiNg2X1UMKqtV4IR0OaBHeMv5reDrB0g4SJi7j
 4TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785492368; x=1786097168;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bNufXrNhgodpdM+ZaPj7HklQdnxu0mx/1/y4yhq0iQU=;
 b=KqbdOa2WsttmMNbEYXDyq6TblJhDH2lrD1ggrHpi8gBVp8f7KvhSOqQzoTLe1pJcTJ
 cjTrULb6pDt2XpBhS4BskXxJr5kavUhDBkO07LSb9DZuIPCqVwhKB6eZX17007JhcWoK
 fEhWn4btCm9ws9bbcbDqG4xLdF1jYeDBrHGstN0NxhMxPS7rKAlly/i2MF3N5HOUWcOF
 WdEqeJFEWQ8a1vxVd5T+Rmq1h/OH6GZ/gHHMVNRPpjOocEYD4FXM+XpwAGZj7c+hx1xY
 R2d0rbz6CdFpcNt+Ip8WTCNSSB/Z9OoJpZtWC6G8+OpFOG+FdxD5QC7Nec9KiQvVHUgG
 On1w==
X-Gm-Message-State: AOJu0Yw/tQXF01IRAw9MGYbkhSO/+LNTlCtyh9usY8ZEND5UWKn7yReo
 JVf2mYMxjYDmIybXKUewhBBCOT0P5Q+u3yZVoVCJaiQCm7Y3ProNMe91uSM49S1pUhgvXOiA6Zx
 nsju82OTuxZPuxN1C3kpfXK1KnhOyX+FSP2nISsUV+ANRySTTqHFzOE4tOWZ6pHQlqact
X-Gm-Gg: AR+sD10WIIBbArn3U1ik76I2MggetVPoYxdV6ZgFSltk0wrXezbw/aJDQUFQpvRQ46r
 GpQo10xIRyb5njiVZTAHUWrlffjUJoga7zpMCsNIuaHiiyEwdagPnlHoZmH8xZPv3UD5UnCRBhY
 BPXzZ3kLLcdU8TyVXhx3ZPLJNCBA6dTlxZfDORnRa3kM9m6VWRqjzwhTyRVL4i9d/43vBAUByCM
 Shv0WVGbdq+gCfamIl8HIh7ub4cvH8nU4DMVQSTar3T86OJbENouqjaAtQvdPp2eJ9KUrnXRdL0
 rU989PK1XdJuiX7Ve6u5rtkNRA8wkuULHYkYz2xz7XFr4rMK8pn6ryiaPSkaZIVz4XYF1c5NyVi
 HPnPRKd2ubQnP+eICHMGKz4IeveQ7twDvFN0VQNmElvkUgAG7nhjyauUlZk7rohsCbhE6e2axLz
 eN7H572ShpKQiq/C8cqz4yP3RDwuup8XqaZ0B3V1twDVboe8/cIsRJVC492cr5Wq0atSEreW57g
 FBMUg5IsrFXXb/hwRXbxZkRgYfEXn9vFoo4SNSlgvN0+80Y6danmd6JIBqLjuZXGIkp62Zu/aSL
 Y7h9abgLa0GmoKKGbCT0vjT+npSwYZnGxZPmf91WvV2tiuvPIa8=
X-Received: by 2002:a05:6000:240a:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-47fd2ab7af3mr3280017f8f.2.1785492367588; 
 Fri, 31 Jul 2026 03:06:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1756sm3022682f8f.4.2026.07.31.03.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 03:06:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 31 Jul 2026 10:06:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
X-Gerrit-Change-Number: 777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/777?usp=email>
X-Gerrit-Commit: d9ae1f0fa43f8ac2551f048f90f37a110a9ecaa4
In-Reply-To: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
References: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzI4MDI1NzQ5MDAwLkk3ZTVhYzliNGE4NTk0MjUxYzNiNWM0NjU1ZjlkNzRiMDIxOTUwMDk4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <615ee924da5679f7736bedfaaf2b2ab52e11651f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpk86-0003yf-ER
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null: run
 server processes with 'ulimit -t 300'
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2116080632585804968=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2116080632585804968==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="35Iq5iQZdSY="; charset=UTF-8

--35Iq5iQZdSY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Plea=
se visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail

to=
 look at the new patch set (#3)=2E

The following approvals got outdated an=
d were removed:
Code-Review+2 by plaisthos


Change subject: t_server_null:=
 run server processes with 'ulimit -t 300'
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_server_null: run server processes with 'u=
limit -t 300'

"ulimit -t" will hard limit the usable CPU time for any proc=
ess started
to the specified number of seconds=2E  So if we have a stuck-an=
d-looping
server process (which was observed frequently) this will make sur=
e
the situation will fix itself eventually=2E

Change-Id: I7e5ac9b4a8594251=
c3b5c4655f9d74b021950098
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2E=
de>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/777
Message-Id: <20260730204642=2E27250=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg38088=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M tests/t_server_null_server=2Esh
1 file chan=
ged, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/77/777/3

diff --git a/tests/t_server_null_s=
erver=2Esh b/tests/t_server_null_server=2Esh
index 65b7d56=2E=2Ee1775f0 100=
755
--- a/tests/t_server_null_server=2Esh
+++ b/tests/t_server_null_server=
=2Esh
@@ -11,6 +11,10 @@
     # Allow reading this file even umask values a=
re strict
     touch "$log"
 
+    # limit CPU time of processes to "5 minu=
tes"
+    # (so a stuck-and-looping process will auto-terminate)
+    ulimi=
t -t 300
+
     # Try to launch the server
     $RUN_SUDO "${server_exec}" =
\
                $server_conf \

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/777?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
Gerrit-Change-Numb=
er: 777
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--35Iq5iQZdSY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail">View Change</a></p><p>The fo=
llowing approvals got outdated and were removed:
Code-Review+2 by plaisthos=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">t_server_null: run server processes with &#39;ulimit -t 3=
00&#39;<br><br>&quot;ulimit -t&quot; will hard limit the usable CPU time fo=
r any process started<br>to the specified number of seconds=2E  So if we ha=
ve a stuck-and-looping<br>server process (which was observed frequently) th=
is will make sure<br>the situation will fix itself eventually=2E<br><br>Cha=
nge-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/777<br>Message-Id: &lt;20260730204642=2E27250-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38088=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M tests/t_server_null_server=2Esh<br>1 file c=
hanged, 4 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/777/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/tests/t_server_null_server=2Esh b/tests/t_server_null_server=2E=
sh</span><br><span>index 65b7d56=2E=2Ee1775f0 100755</span><br><span>--- a/=
tests/t_server_null_server=2Esh</span><br><span>+++ b/tests/t_server_null_s=
erver=2Esh</span><br><span>@@ -11,6 +11,10 @@</span><br><span>     # Allow =
reading this file even umask values are strict</span><br><span>     touch &=
quot;$log&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    # limit CPU time of processes to &quot;5 minutes&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    # (so a stuck-and-=
looping process will auto-terminate)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ulimit -t 300</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     # Try to launch the server</span><br><=
span>     $RUN_SUDO &quot;${server_exec}&quot; \</span><br><span>          =
      $server_conf \</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail">change 7=
77</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I7e5ac9b4a8594251c3b5c4655f9d74b021950098 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 777 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--35Iq5iQZdSY=--


--===============2116080632585804968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2116080632585804968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2116080632585804968==--

