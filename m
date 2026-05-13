Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034A1CD37B6
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nT7iO0iU6ZZ/ovnMTSXKLsOH4SKb+AddYhzlCWTqzzk=; b=N6wfFekvwyH7SW4BzlBLbLDEIs
	JR1T74jFxWkcdCEYFYArUgT8SzWfgdlqqqtDNt90ceEAqTYuNUc7ux8Kqf0oS/PSnjUjB+23D8x2V
	rB68mrJn64m8ajcmWV+4m/dGlxwbHW6Euqg98Ip8D610A95QP9fU9G7UwXHRZ8VC7TMw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5hH-0006AR-5H;
	Wed, 13 May 2026 09:16:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wN5gt-00069l-O5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:15:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SZZJ7dxMAD3fTF9GOk5G0FWQ6JSiOhVQ1NmsdOQNZhc=; b=UDSxibG0N0l8h1ozynGEzyFPio
 WiUNujDSXmGNQQXU8M+SXZKB/z/Y8VxyrLofqmjPejEyf0aj4imqFbDRlkOg8k2qx+3+Uon5VlJVg
 aE9LOPpJwMeqKtWPTK4ddWnfvXRjKjoiAXTe4JfoV869B2Z63g46UnTPP1/Ner53S9c8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SZZJ7dxMAD3fTF9GOk5G0FWQ6JSiOhVQ1NmsdOQNZhc=; b=b
 OcmEktEs70UquZplonyL2XGaGLo7/IJgCHTNnhaSWK0ZJ2kWr3mW/vAKJfEmTToefFLTdpdQSkOwo
 zy2Nuy3CMq8bpKn0o4MIpcocJNTWrzu1qiY6idqyQzqgbi312y9uB8LtQVsboiLPchBT0dnaQ6Bb3
 sNUvPYCWFD3/WbKI=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN5gi-0003hm-Op for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:15:33 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso74600265e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778663722; x=1779268522; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZZJ7dxMAD3fTF9GOk5G0FWQ6JSiOhVQ1NmsdOQNZhc=;
 b=M5YjVNJ4Fno0pGIfjbL5DWkcTESYeOxIpW7/ftJYqSQZCIWXHmnAy9MLdB8nyWth+9
 LiXXwBcZc82cC/5MdMafQtbWJFc/pF0NxznHBKRFFlmPngKR39ffx2gCxyB4+fYRvCQd
 6tNevPZ+1w8w/pzT6DU3gyM1N4rNGTnGgZHelhII774+tnR/n0biPZ/jh380xlzbxgVp
 9x/sSf9cuvx0l6C0HkY66hHtS0gdPOuypGpJykfslM7XpSIMtBnNNFZBAv5wxNMick6a
 ztNQkT3SIX1qrQ6XgDa8G7gUE+eNGruhemak1euD/SuvqsOaGgwFSsfyAOvvOOWl7hco
 kogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778663722; x=1779268522;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZZJ7dxMAD3fTF9GOk5G0FWQ6JSiOhVQ1NmsdOQNZhc=;
 b=PJnS/xNt5AhqeI2Xz8+yWMXsUj1k6jEH0edVBvm2L/LBRbIW9piUOOLH44duuD7m/9
 I5x4OKXUwZbywYTxMnfZ3E2kiTowg7pkYWsDEpJ5g/nk1It9AzXJaDX+2chP1LLRti2v
 gwY+ZSIBqDrzMpY9o/g6WV0He+W07gzTR6KIw0oMx9HCDaDPbmRV8mnJVOvmMBybq/CX
 QnDl23KjOMhwjKJ5HIXxDFdFw59BXKEWPBgof9AH1sfV5iVi1off9do0pktWQMB/cbBy
 ktRLv7xBLVtb5sPoNgcfRmHSXT7VfgevpL+w0bqHmBK3dP0GXQ4UkWD6t7GyR7PTMJej
 wOFA==
X-Gm-Message-State: AOJu0YxruF8coaxYOhbCrsVaWwkKd76jY8H4e0xBOQ+Ho0DIf/tu51zT
 kQhlHZZeuLwuonC899JPEQSmZcSE54Yl+Kc22MT3gKGVLnHso0hj7ctqcTOP6MjHrkz4zEfGQG4
 bB6a/ySuY+iMcZKOUXOVSKdjwKXmAGLrBFQXQvQkKMHROno02TftwzLKuDwgY4me7GglO0HxGQ9
 900aJ2pQ==
X-Gm-Gg: Acq92OFXq8KPPJtlBY1BypBdEOKtyIhq98TxuLY+sitYX1LzNlaJhIUKFew69bhLGGb
 MWIZLDxb4a7eN1MI2DeMj8iqaf7Ljmrs8WPZZ3xTI/6OJoReNOdZ/UsmroLUA2BiJMkp/fPYGKp
 OBg1SvPBjCCF8ESY1wV1Y+FePttLKE2gzVtgOadEXV6t5RlsJ84+E3QTh3LLrBE3IdpFfPvFB4+
 1MWUXOIKWogYjoi1SYx/ihYxn4mt4Hd8In907gK3zjsa/1sErISjPIYM+KYAqnyLuMm1QOQnbp5
 9YM/+MToUkAusAJFhSPzIri49zkMtpFnDJfS3f+vNfBxBOnK6/iXZMWXsFCXexjFwGNe526Vb1H
 0FQDxwatT4V8eJjHYTj85mwAp+VnkuEbXEpr284zosfRm3fQaGL8DGQccxgCWmpMqFSSUxq6m9+
 yqFIsLvu10HBEJRrkKU5PwJvA6qCgO2NoCpszDVq9YkBFDkVQtTQyUA3VNoi/+5gT6B5xblxyCH
 05mCqA7ST9u94wxEAHqfOjiemXN+viix9hHj+7iRt8lh9sLAEufOMqffqzDzb3/S+bsE9gE1pd4
 46LCKLrR4P1QyA==
X-Received: by 2002:a05:600c:5248:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48fce9e146cmr26614405e9.20.1778663721502; 
 Wed, 13 May 2026 02:15:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d74536sm62107095e9.15.2026.05.13.02.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 02:15:20 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 09:15:18 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
X-Gerrit-Change-Number: 1676
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1676?usp=email>
X-Gerrit-Commit: b887872524d6fc481c23bfac20c3f5d117547eba
In-Reply-To: <gerrit.1778239616000.I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2@gerrit.openvpn.net>
References: <gerrit.1778239616000.I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkwOWViYmY2ZjM1NTVkZDY4Y2U4ZDc1YmZhODQ0ZWNhYzUxOGEwY2YyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a00412c9269e472733eb0640876502732d8d1381-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wN5gi-0003hm-Op
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pool: Fix a
 potential NULL pointer de-reference in test code
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7149975047357557751=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7149975047357557751==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PoahMfKw4Vc="; charset=UTF-8

--PoahMfKw4Vc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1676?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: pool: Fix a potential NULL pointer de-reference =
in test code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


pool: Fix a potential NULL pointer de-reference in test code

Identified =
by cppcheck=2E Probably has been a long time
since that code has been compi=
led, though=2E

Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
Signed=
-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1676
Message-Id: <20260508153156=2E13575-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg36865=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/pool=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/1676/=
3

diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 15004c0=
=2E=2Eff74e7c 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
=
@@ -757,7 +757,7 @@
             break;
         }
         msg(M_INFO | M_=
NOPREFIX, "IFCONFIG_POOL TEST pass 1: l=3D%s r=3D%s cn=3D%s",
-            =
print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn);
+    =
        print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn=
 ? cn : "[NULL]");
         array[i] =3D h;
     }
 
@@ -793,7 +793,7 @@
  =
           break;
         }
         msg(M_INFO | M_NOPREFIX, "IFCONFIG_PO=
OL TEST pass 3: l=3D%s r=3D%s cn=3D%s",
-            print_in_addr_t(local,=
 0, &gc), print_in_addr_t(remote, 0, &gc), cn);
+            print_in_addr_=
t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn ? cn : "[NULL]");
   =
      array[i] =3D h;
     }
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1676?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
Gerrit-Change-Numb=
er: 1676
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--PoahMfKw4Vc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1676?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">pool: Fix a potential NULL=
 pointer de-reference in test code<br><br>Identified by cppcheck=2E Probabl=
y has been a long time<br>since that code has been compiled, though=2E<br><=
br>Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1676<br>Message-Id: &lt;20260508153156=2E13575-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg36865=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/pool=2Ec<br>1 file chang=
ed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/1676/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index =
15004c0=2E=2Eff74e7c 100644</span><br><span>--- a/src/openvpn/pool=2Ec</spa=
n><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -757,7 +757,7 @@<=
/span><br><span>             break;</span><br><span>         }</span><br><s=
pan>         msg(M_INFO | M_NOPREFIX, &quot;IFCONFIG_POOL TEST pass 1: l=3D=
%s r=3D%s cn=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            print_in_addr_t(local, 0, &amp;gc), print_in_addr_t(remote, =
0, &amp;gc), cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          print_in_addr_t(local, 0, &amp;gc), print_in_addr_t(remote, 0, &a=
mp;gc), cn ? cn : &quot;[NULL]&quot;);</span><br><span>         array[i] =
=3D h;</span><br><span>     }</span><br><span> </span><br><span>@@ -793,7 +=
793,7 @@</span><br><span>             break;</span><br><span>         }</sp=
an><br><span>         msg(M_INFO | M_NOPREFIX, &quot;IFCONFIG_POOL TEST pas=
s 3: l=3D%s r=3D%s cn=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            print_in_addr_t(local, 0, &amp;gc), print_in_addr_t=
(remote, 0, &amp;gc), cn);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            print_in_addr_t(local, 0, &amp;gc), print_in_addr_t(remo=
te, 0, &amp;gc), cn ? cn : &quot;[NULL]&quot;);</span><br><span>         ar=
ray[i] =3D h;</span><br><span>     }</span><br><span> </span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1676?usp=3Demail">change 1676</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1676?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac51=
8a0cf2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1676 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--PoahMfKw4Vc=--


--===============7149975047357557751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7149975047357557751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7149975047357557751==--

