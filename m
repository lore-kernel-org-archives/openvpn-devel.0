Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5833606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ckv6Bm8M;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JPXbSWti;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IxOaYQRc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XxRfk26Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xp92vFYGJfmthXu0YaBlqdX2w6NCdWfw3+tKJ6uc+0c=; b=Ckv6Bm8MFm/JN47fxOUDgthuTJ
	JcKFpzvUebFUMO8k58aC94aOibgdHeKHRKxHMjSqP8nF2FmVMHEQXNTGm8jL46dNa4P01kEyXsv6q
	ukn1rMCNM5N8FYQodLhua4KaFnTbBfhBw5b63bTOnoo+ZZWLWcdoUYZnOlW1KoW4XX4U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzi2-000000007HK-2M2P;
	Mon, 02 Nov 2026 21:36:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzi0-000000007HC-1DIB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lqeTRODzSIccC9WcjLH2rbCHFxuKgrGFBXBmcbvRCE=; b=JPXbSWtieiXuiD+s4e52C/LBdP
 q8b5biCxsUE0YIb/oeg03mpspDsqFWtVj3IUG2Oe5RZtvrSw28pN7HL6PIHbEHZ00BdVYQ3kfUuE/
 79PhcIJthys0GZJf91vfkl2dpzhDk8pB37UM2ePpgoe8DOmptqFlQ8sqIp/Ze1T/rQXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lqeTRODzSIccC9WcjLH2rbCHFxuKgrGFBXBmcbvRCE=; b=IxOaYQRc06LSc8MiEQebNelArg
 SEPlh8tyHp8ACo1Pm5Py/5tKw6PNqw9DcQg/SqtYFPMdNzTPoG43qcGKZxEaIvMKAmxgH38ACTsEN
 gKckq7uldBqVTnb+HDiTGrguktQuj8lvwNbjF5QYsIIjtdf6TH3pQPvphHBoRdTaRREw=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzhy-000000006AX-3Rsk for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:36:52 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so33915595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793655404; x=1794260204; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7lqeTRODzSIccC9WcjLH2rbCHFxuKgrGFBXBmcbvRCE=;
 b=XxRfk26QzGbrNZ4q22vz0Z8DmE8l5qY3XYq99Jen9ah3lxJx8SqIpKEB4ggTwDcXfg
 gc4AHXHNQ+6wYH2M7h7l9Xe3zwyFWsGpWeIfej/uewni60SVjztHA3sY+Si+p2gt9nhM
 fWMacH0LUa3tNYiFU5YQE/rEgkuQhdKMBfWEGzrEsQz9R2w7ITi+beZvFjbTexEofkqn
 5221Gv0Gl61DKOxyIgk3xe5ncmT3MANKyIr2vZ52REgTo1ddbrqqXRfusg/l/xY4yd6Y
 UGZgqJNrQGC29HYFhX5wmKOtJgUCojzIZp9XXoh/xx/8KvLZfYL/vjhtGocCzHMHrgRZ
 OHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793655404; x=1794260204;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7lqeTRODzSIccC9WcjLH2rbCHFxuKgrGFBXBmcbvRCE=;
 b=cKgeRn138plV2QZsuaMYvBhaVMuPsJhpgiXNK7yCPe4n2MqIkBgeswPpZuVrCZPX6P
 Aae2divr6icdhuUJN1MyUw9DPm7xtjMMl/T3bZUFoDezeqrPe7PmNAl1itxLymD7lJcZ
 Lr6e387su2PwDdx0GQDdnnQaEY82S7Am/5jBX9xf05RgyZk8dEMofW5ugQ8c5sMIJukC
 R1pnvpmweBIrgjkXYuEJ9ix4D+3Y+ISf0QZqGFWS8io3vlKa+0bvfYwgAP2DrAb8lj5h
 bS4A6ICFYm3jRCXjyGPgkcWTJgxDDp+lUoExmEBC6aSIOfBwVlfcGJiizhuU7bFtgOzh
 vkwg==
X-Gm-Message-State: AFq9FYI9GrJ0M3FKCrFvNqnawDzeu/XnF25axLssZTJutW3I6XKRcIUM
 3pyzTtxBXATJKurrsPNEqlhefAs34ujzbSTObx/evn4t5w2GZdmtgS1dsSkfAMasyvLEv59Qlrc
 53NyPmYJBWMWswK96SwLVQ3inH0O69HJU9jM01uWSLir4W3FSi5mR1boNnXYAY/ILe1R+
X-Gm-Gg: AYBFou1f/bKHaCij95+eYiXKx9zQmT6u0YyJCrZPnAVtfPWwjwg6ZG3upL2pt0E9voe
 BcMpoVUsTBxF43VwBH1veeqZRHD4InNrrxMvAqjPjBO/a2eF4dxy0lnj08Uyg0/E6QNsgzR6E0p
 QN33K322kKQWY04di+RbkZT1x9TC8IIM9lPjzqQlNNChCwl1+/4EHxonqSf+kpQ63q2nFvwP3Fn
 DBDt+d56sQxPavZMDzWvWyITa96aIMrb6G960Bhi1b4he1GKYNsUunI4Ua62U0ruiwE8ZseYkqU
 XwIcXYPOZyBm+hHZuMnPnBOKOgC+epQ2nII8EvpBHxJXhuj/iupJhm8Ccu7ZYQOD4ZVMP/xXJEA
 QBB7g8QuZCFqk5NvOw9HJFHsAAXo2sBMV6r+8ReWf8aVnt0wBlMNxwN/NoBhz3m8ROxMPH6GSP1
 a5K5XiZlTZeNiXjh8ZUwrC52u/15xtxjfybSR4SWrJgbV2SmvtMLTcI9rO9DnnxexXoRwEAc2OZ
 qmY75fnKeVIfbuvOpH9IBbQX6ftHY5hXPBtAldez+CUzkISdRDVY6LGLaDuHTtFC6zrvlzuoM05
 wVp2R9XNRKMF4Q41HYS0pCyGgPYkkVZDgmZy271bhEW4ceP1uaQEx/uIcaoqSr2FCO45Nlij/nf
 v4PZqwSl0kQcrNDei+Ej30Y/2YdGnk79OtPxZX3MJHioUVtq0okN94s37i6Ktjo05a6PKnFT/19
 76G2xA2ebQk+nEtw==
X-Received: by 2002:a05:600c:34cf:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4ac150b38ebmr261737445e9.1.1793655404135; 
 Mon, 02 Nov 2026 13:36:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe885d91esm215360035e9.0.2026.11.02.13.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:36:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:36:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
X-Gerrit-Change-Number: 2091
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2091?usp=email>
X-Gerrit-Commit: 4a6c1db218c71a4c7a8346f7508242a315fb587d
In-Reply-To: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
References: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI1MDAxMDAwLkk3M2VmZTAwZmRkYmQ5MTk4OTc0ODljOTc1ZWM2NWVkNGI0NjI4Y2M4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e9328eb1b6e3a3e0de3dceb5487c87f11393525d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzhy-000000006AX-3Rsk
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8074838826865055161=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8074838826865055161==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VixQSlc5umU="; charset=UTF-8

--VixQSlc5umU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2091?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: dns: close first pip=
e if creating the second one fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

dns: close first pipe if creating the second one fai=
ls

run_updown_runner() leaked dns_pipe_fd when pipe(ack_pipe_fd) failed=2E=


Broken since 1dfe8729 ("dns: support running up/down command with
privsep=
")=2E

Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
Signed-off-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
091
Message-Id: <20261102170525=2E112032-1-frank@lichtenheld=2Ecom>
URL: ht=
tps://lore=2Ekernel=2Eorg/openvpn-devel/20261102170525=2E112032-1-frank@lic=
htenheld=2Ecom
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
src/openvpn/dns=2Ec
1 file changed, 8 insertions(+), 1 deletion(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/2091/3

dif=
f --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index e5ed1bc=2E=2Eabe3=
0ed 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -608,11 +=
608,18 @@
 {
     int dns_pipe_fd[2];
     int ack_pipe_fd[2];
-    if (pip=
e(dns_pipe_fd) !=3D 0 || pipe(ack_pipe_fd) !=3D 0)
+    if (pipe(dns_pipe_f=
d) !=3D 0)
     {
         msg(M_WARN | M_ERRNO, "run_dns_up_down: unable t=
o create pipes");
         return false;
     }
+    if (pipe(ack_pipe_fd) =
!=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to c=
reate pipes");
+        close(dns_pipe_fd[0]);
+        close(dns_pipe_fd[1=
]);
+        return false;
+    }
     updown_runner->pid =3D fork();
     =
if (updown_runner->pid =3D=3D -1)
     {

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2091?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
Gerrit-=
Change-Number: 2091
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--VixQSlc5umU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2091?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">dns: close first pipe if creating the second one fails<br><br>run_updow=
n_runner() leaked dns_pipe_fd when pipe(ack_pipe_fd) failed=2E<br><br>Broke=
n since 1dfe8729 (&quot;dns: support running up/down command with<br>privse=
p&quot;)=2E<br><br>Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8<br>=
Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2091<br>Message-Id: &lt;20261102170525=2E11=
2032-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://lore=2Ekernel=2Eorg/open=
vpn-devel/20261102170525=2E112032-1-frank@lichtenheld=2Ecom<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dns=
=2Ec<br>1 file changed, 8 insertions(+), 1 deletion(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/=
2091/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span=
><br><span>index e5ed1bc=2E=2Eabe30ed 100644</span><br><span>--- a/src/open=
vpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -6=
08,11 +608,18 @@</span><br><span> {</span><br><span>     int dns_pipe_fd[2]=
;</span><br><span>     int ack_pipe_fd[2];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (pipe(dns_pipe_fd) !=3D 0 || pipe(ack_pipe_fd) =
!=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pipe=
(dns_pipe_fd) !=3D 0)</span><br><span>     {</span><br><span>         msg(M=
_WARN | M_ERRNO, &quot;run_dns_up_down: unable to create pipes&quot;);</spa=
n><br><span>         return false;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (pipe(ack_pipe_fd) !=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;r=
un_dns_up_down: unable to create pipes&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        close(dns_pipe_fd[0]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        close(dns_pipe_fd[1]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>  =
   updown_runner-&gt;pid =3D fork();</span><br><span>     if (updown_runner=
-&gt;pid =3D=3D -1)</span><br><span>     {</span><br></pre><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091?usp=3Demail">c=
hange 2091</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2091 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--VixQSlc5umU=--


--===============8074838826865055161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8074838826865055161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8074838826865055161==--

