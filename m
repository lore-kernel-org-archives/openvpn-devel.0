Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D175606A32F
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kZiTu05i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KkoJzjfv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DggptQ+P;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CscubTeI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1CD3b+z5eAH3TmAcHdt9nmQHXEXQcM4Hnmh+/DUvhpc=; b=kZiTu05icb0wGza0GL0nuncbTK
	evHjmFKbNI+BtmypgHNJhfF5x/eRM1k4WptL+KX65CabrDct/8ZchbjQzRP4d1dNQGobJFUAqGggd
	LVj7dSBct8SMBA/7ups5/uW2UfyE/ZwMj2N3FeJyAp1Vle/MixCTqHhDwik+cCNImkvE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzi0-000000002oB-3QJN;
	Mon, 02 Nov 2026 21:36:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzi0-000000002o2-1GDi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ev9fuIQZawlPEMAZ+STReE2ySx+shPPQHycrhekplto=; b=KkoJzjfvfK5otH2EypH0vX3O/P
 t7+KfJ1zxykFVb60kmlfW6xYSaI4NkRWXb18rR6lC/j9mxdMJdITIR+zcNlRrtz0bD0VIS7pCNj9i
 +4nHCsm5UJ0XVjhcEoCqr5tMhUYdD5Vvi29ZVozMcVQz/uedY2VQDJYKQ3FbUaAEMWgg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ev9fuIQZawlPEMAZ+STReE2ySx+shPPQHycrhekplto=; b=DggptQ+PmO9JSYNq7UnrYXDhtb
 9Ot3F+KCcvNAL7d4/ZG5LpVczUSbFm+nxxDBjWK906bXDCDkN++gpwXnqGPMbbDkfZQEKucSGLnuX
 3M1i2MOf726pBDTRG6q46Yyn7wCZOL0yZFIXJrOBfrPiNPIGcZQ0pp8Y7LwxLQQIxJmk=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzhz-000000005oV-2Xr5 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:36:52 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso1389537f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793655405; x=1794260205; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ev9fuIQZawlPEMAZ+STReE2ySx+shPPQHycrhekplto=;
 b=CscubTeIb8RjASVXohefFvQ2tMJskt4JGvBp6dDKqF6MAJaXVVjOu6CNzCr+cwD/60
 1Xs4S4QVcH36kddNZis563XTOfQzcpVt+sKXdnLfXLCcEx6rtUTeR881M+H8z8YDa/ZY
 CARRKAk2odV1JXmxkzXDAVBkU2Sq55lpDmzXsyUE3LSyQ4Q0XHKTA9W8Hyy8hAV5ol3Q
 RUWARWeUSr9Ei25wzdAAGvA6LOqL53cwFWt6sbCERJAD4CRZumzEhxJ07p9SEYfOUPHc
 NJeCF8px5KrhpSt7yms3CFqH/u70pAWlTgJoqoOU+ycKQcztdx19/zIU1hCPQm+XvlbR
 ON9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793655405; x=1794260205;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ev9fuIQZawlPEMAZ+STReE2ySx+shPPQHycrhekplto=;
 b=rrq7zzCpSQfNiEflvdXsdsbnad5WoECxIIA/jaNOumQRkmrYX5+GuWeA6bE8omqMmV
 URPB5f7wFzfMto7k+r0941b5y2UxxlqBgl6MoO+EEb0NF39Q1LdGksbZqlwaq9LDs6w8
 ztTW6JP/3fBPAq1tFKQ13X8wEvNfhoJZR0t7D+VB5nuJa+yFFK/Myjp2l1g4XBuaKifO
 4El2rmIvoqBJfXckOkhQkV3c4XAzz8Ga66AeuKLYXE6gaPv4PypT6Fs378yw+rGXfO9j
 0K8w0O622CZ1yYt7Dw1LngOQwTmyUpnHKyBgaRHECpW9UY41Yb6fe64pHkCwL9g6eRrq
 0q8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwju6VPj4QYmRhg0XxII/GItAH3rTyhU4IVXjGhNbrsvh2mjLONFUiScB4oI89Wvz14EHmsViP0eDh32zNI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+IeDto4xTAL+H083NN44sQfmc5ePVHeO+ZKHDPkRJUBD7Kr+lK
 1whknYN4VQLvBhjs0/B/7FwP4MfHPXgmCGxdOhMDQ9yYQ3J0XFlrLJ77KTBD5TX9VsOpWP+BGcf
 u8NHZqVZNtislRIi3bAivgS43s5f2tHAO2wn6BmDIK430k66JrLnr19jUnkYaMqs9BYYj
X-Gm-Gg: AYBFou27J6beNkNWYSU0cgpik0HsC+eu0zL7wCqU7bAzKY2QzW9ScIU2cU20zKVrfMC
 /EGVybHNenSsCBXzZ1dxlYAwVrZnZi/KPYaZUUIir+6g2soYCdgIi6cyTLdH+SNo3Vg9oDBtniA
 DrG57WPgVgzz/OEZqvwsuqqukM7GcNnVt6EP/7eezpZBs5nMXK1kN33mT7Vt2efP58ahR2fNURM
 nDq29iyqRsIpTEadVeXvTNFaRlBBXQNlBl/M7uErLRZtHcvZPcEg1ssElgQMj1lICBUvf60bRJG
 OFtJ5NCOe+gV8RX0bUa1W6wrID82tzIGR8hRd0AWfGfyZGwAJEvwvJ1y1LmA+pK4UNKhOJVffRi
 zbUszF6FrAJKTXriHuIF4UP9fIz++rry7nqUfDR9+dye0Gvo6vvi4aFyFZ4tCx0U93OLNUoLEfZ
 1R1T9I6aeuYzsAVSc5PvxU+RfukgIijU1amgcd0ce+4vY8/enqYy4Jr87ToOgSVm1KlfWSddPKk
 kgfd/iSLSMKVJA3RTEOAKNZNs4xh0vJbumd2e+HBQokfEG4CY40pTo4dVg8Ze/WLeMhut2oS5Tx
 QTtE68SUU9jsrBjZxntkyBVqkiGlGx/oiPPgkRxX0QC0P6Jw7Tpop+fIipAOBA4+TbLrmWh3pxn
 4ao/0MuUc1hiTyT03O9fTzzz3yUOx36qoP01rIoLt98+uQ7nLFgFPhjdtNapx6eQymoWd4fr1Gh
 l5X90MqyFiQyEjoow=
X-Received: by 2002:a05:6000:2885:b0:488:88ec:59c3 with SMTP id
 ffacd0b85a97d-48e6e2f2c14mr24205833f8f.14.1793655404902; 
 Mon, 02 Nov 2026 13:36:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c6e9sm21704536f8f.43.2026.11.02.13.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:36:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:36:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
X-Gerrit-Change-Number: 2091
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2091?usp=email>
X-Gerrit-Commit: 4a6c1db218c71a4c7a8346f7508242a315fb587d
In-Reply-To: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
References: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI1MDAxMDAwLkk3M2VmZTAwZmRkYmQ5MTk4OTc0ODljOTc1ZWM2NWVkNGI0NjI4Y2M4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e9328eb1b6e3a3e0de3dceb5487c87f11393525d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzhz-000000005oV-2Xr5
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: close first
 pipe if creating the second one fails
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3571963736330687986=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3571963736330687986==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gy4n3jEDpm0="; charset=UTF-8

--gy4n3jEDpm0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2091?usp=3Demail )

Change subject: dns: close first pipe if cr=
eating the second one fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

dns: close first pipe if creating the second one fails

ru=
n_updown_runner() leaked dns_pipe_fd when pipe(ack_pipe_fd) failed=2E

Brok=
en since 1dfe8729 ("dns: support running up/down command with
privsep")=2E
=

Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
Signed-off-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091
Me=
ssage-Id: <20261102170525=2E112032-1-frank@lichtenheld=2Ecom>
URL: https://=
lore=2Ekernel=2Eorg/openvpn-devel/20261102170525=2E112032-1-frank@lichtenhe=
ld=2Ecom
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpn/dns=2Ec
1 file changed, 8 insertions(+), 1 deletion(-)




diff --git=
 a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index e5ed1bc=2E=2Eabe30ed 100=
644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -608,11 +608,18 =
@@
 {
     int dns_pipe_fd[2];
     int ack_pipe_fd[2];
-    if (pipe(dns_p=
ipe_fd) !=3D 0 || pipe(ack_pipe_fd) !=3D 0)
+    if (pipe(dns_pipe_fd) !=3D=
 0)
     {
         msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to creat=
e pipes");
         return false;
     }
+    if (pipe(ack_pipe_fd) !=3D 0)=

+    {
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to create p=
ipes");
+        close(dns_pipe_fd[0]);
+        close(dns_pipe_fd[1]);
+  =
      return false;
+    }
     updown_runner->pid =3D fork();
     if (upd=
own_runner->pid =3D=3D -1)
     {

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2091?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
Gerrit-Change-Numbe=
r: 2091
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--gy4n3jEDpm0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2091?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">dns: close first pipe if creating =
the second one fails<br><br>run_updown_runner() leaked dns_pipe_fd when pip=
e(ack_pipe_fd) failed=2E<br><br>Broken since 1dfe8729 (&quot;dns: support r=
unning up/down command with<br>privsep&quot;)=2E<br><br>Change-Id: I73efe00=
fddbd919897489c975ec65ed4b4628cc8<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091<b=
r>Message-Id: &lt;20261102170525=2E112032-1-frank@lichtenheld=2Ecom&gt;<br>=
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261102170525=2E112032-1-fr=
ank@lichtenheld=2Ecom<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/dns=2Ec<br>1 file changed, 8 insertions(+=
), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/op=
envpn/dns=2Ec</span><br><span>index e5ed1bc=2E=2Eabe30ed 100644</span><br><=
span>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</s=
pan><br><span>@@ -608,11 +608,18 @@</span><br><span> {</span><br><span>    =
 int dns_pipe_fd[2];</span><br><span>     int ack_pipe_fd[2];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (pipe(dns_pipe_fd) !=3D 0 ||=
 pipe(ack_pipe_fd) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (pipe(dns_pipe_fd) !=3D 0)</span><br><span>     {</span><br><=
span>         msg(M_WARN | M_ERRNO, &quot;run_dns_up_down: unable to create=
 pipes&quot;);</span><br><span>         return false;</span><br><span>     =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pipe(ack_p=
ipe_fd) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN=
 | M_ERRNO, &quot;run_dns_up_down: unable to create pipes&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        close(dns_pipe_fd[0])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(dns_=
pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     updown_runner-&gt;pid =3D fork();</span><br><span>   =
  if (updown_runner-&gt;pid =3D=3D -1)</span><br><span>     {</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2091?usp=3Demail">change 2091</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2091?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merg=
ed </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2091 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--gy4n3jEDpm0=--


--===============3571963736330687986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3571963736330687986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3571963736330687986==--

