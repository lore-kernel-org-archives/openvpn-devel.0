Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0D606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gG9m/dgO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TPRDhLEq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R7Dpo9cO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TCh2MX71
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=GOlxw6fthipNadIWDh13hcxOPehVwVJm43v55flYaM4=; b=gG9m/dgOQtj4QxXusjC0FMEBtc
	6cte9cNEKEJLI27lwShGyhnb31MhxqhLddwZwq0mPifWZji3PTLVZ0ex6PDnsMYtYgduZVmorKVZi
	IxoWexJgb4kdGFbblx+Tog1kRlyk257lSw4waND8Zzj+1vFDt20JGG99EkxDbi1V3s3A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVE9V-000000005ok-1Ok2;
	Sun, 22 Nov 2026 20:27:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVE9U-000000005oe-2IaL
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 20:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=siITBuJm2jsJZRSLs4qbn7iXNCT49EYsjHypCRF97bY=; b=TPRDhLEqT3cCgl8tdLHUZIQv8t
 pRkRvEf0JU73WF8yhIaCVqrj1wFwQIzKZlL5809I5lXdagnAYPemVfKRTt7B4IjZbhlWEniEK9TGj
 MCsWIBwQpp9EINq1ZtdUjHExwbT97obyQL472Ui9CFohvUrcxfRJCKf2cbpQoLYA7Ems=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=siITBuJm2jsJZRSLs4qbn7iXNCT49EYsjHypCRF97bY=; b=R7Dpo9cOQd5rDti5LerHbYNzN9
 2I1jQl4Fg4XFj3jz169wsNNhUuUAcLIrCll1ycxeqogTC+ydMS0tpfSi2KF4gHHZmRuPF8jmKEkdh
 5h2b3E02YJnIxILMC0/JCYdKWAHUqkaahXItwodlyq3uTfXzE/Zf+p61L6lPbr0vxaaw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVE9T-000000005kj-3McI for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 20:27:08 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so32012665e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 12:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795379221; x=1795984021; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=siITBuJm2jsJZRSLs4qbn7iXNCT49EYsjHypCRF97bY=;
 b=TCh2MX71+KTGOL624nVBOEMJffg2Ln1SSWOw6cBZFhCKb7gdApIMqloAKz/oabjjqw
 V5CQUgD4pBbrEQcPVPJILV9oG/NvcoAo6v40fsQYPMaptxrHF5EPH8apqv9nZxEVNb80
 5GkNWf5y9yibTkNZRwfDwhDpH5gMDQU+YK0R3572ZQFp36hLap26ytL8rbM7cNggLguF
 tFZ06RyV6TvWSFXVSYrDkkdlKkguzk2jyBrmRBVsMI6K/t7OJWUv6M+CvRqneLXXCvAX
 vb8BhLjfzWcMNWsnKfCBG8HOCwvBBFgL+QGHwQRTahEK2WmWmBobl9GCJRdSJx8ewlMi
 uClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795379221; x=1795984021;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=siITBuJm2jsJZRSLs4qbn7iXNCT49EYsjHypCRF97bY=;
 b=TZ9NC0t1glmgCBCkSyNiZ8oizaF/P2Wvpltf4T1b5KeYUNXx9dgQKb8vt3NJN/9UNm
 1Qk2Bw6ntYre5UbWqFm3M0QJ11jXK2nAQUh3FJgtj4D6167KC2OT1YgLp1lmih3MEmdD
 edLRLrKI9/AeNzjgZUQzUFjwf1SKX95tyn6jaRJQcsMw6fJSO5q01/Zpdriw4nTsZr2B
 ZaD6IeBq58gZMF19mF0vPJNVC3TKdHjUzjY5cJVzsj7TZNydugCs33GB4tmAaBgr77SB
 kfR/fdLLxW3IJ4hODCZc+RGhgXfnOq/mIZq4W6ECrXyMSbISOr1j+Ly5voCRR3q42bC1
 sexw==
X-Gm-Message-State: APuU4Z8vKmREj8c9YaIDKkhmHIPYyI/x1U8HRahPmao9U+d2LLG5NQHE
 /jfZ8d023e24yyPGWlWs0u1Dw6wxHgG7/ATbYdE7XDHKDahFrAUlhJKGj6vXgDt1vHK0nKLC1+e
 CJGMI5yi/hPDnXWlTVyS8sdhl/ZyoWnB+uEL+NGWS6yLr4sFoevVdtbcWJEEnIAzgPaZo
X-Gm-Gg: AZFdTZc27OII4uFjhVBnajoEKOg0WnlbAR4/0DkuC35IMvg4WfqIZyxXVi8OL7KbwJl
 Swp5CQYAueAkP/8wd5joYS40scs3Iob6SukD0sMoxWtXEem7DTObyDsiEVjWvvFvda6XxUGyD3x
 JflG3igkDymzlik+1jz7EpZWBOzYafIyBj3eIRHVh2JOQhZT41xoiIQ9Nn2QZGZBO1PKbwYQgFY
 gr0vtinLQt/TucQRmwth+aLhdDX6i7mrI+sC0WRDdmocE+Cthz6NpS/NCdwbDmdveIroobn80Qd
 rFHfWAvnNBsu7anWxH3GdOG44UoBMwhrovGkprMRM+jl4NV9AbN5biWCnY4kRbAOVFo7qvG408B
 +mOEVB/ZwETxhxRJg85PzEWsK3KTrOJfbkR4fuzEdyqlYnl/RfW1lUSmLLJZdXNbFmGPlCQXTyX
 L4/7B7XOeFKfaWfUi76Q6BNTk8dgB46uepXi8p0BazFvtzUEtQz01RrsfDNJuYWciQxMSsv/wx7
 m990R5micmz6hcILvXUO5jWmzCbdwg6ElhuL7KDhWquF5Eifij7H2raHygPaSIp8P5CjmqExwXn
 prHhIVoWDOPAdbwSzICXSLP3BPrn5U+S0C2E7OYjrRBFFY1SXeG5hOjgmDVJJEGMwssRBiamo9D
 HTGOMC6J20SOqF215XOHrQzIMu59ueqlsdmzLgKoTu5UbkIORN6TObmhx37kvcBduvkc01pM+rn
 Kx1944uSAUrWpuEKQNKD0z5Jt5cglD6oLfCRVj
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr215064525e9.5.1795379221054; 
 Sun, 22 Nov 2026 12:27:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm339953295e9.6.2026.11.22.12.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 12:27:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 20:27:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I74eca236465190ab55db289b98e432757c61a4a3
X-Gerrit-Change-Number: 2240
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2240?usp=email>
X-Gerrit-Commit: e192ade857772d5540e3ced8b69caae02a94be08
References: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc5MjE4MDAwLkk3NGVjYTIzNjQ2NTE5MGFiNTVkYjI4OWI5OGU0MzI3NTdjNjFhNGEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <48498e2c540c422ae84a75da6f722f0357db730e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVE9T-000000005kj-3McI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: drop duplicate
 remote address check in tls_pre_decrypt()
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
Content-Type: multipart/mixed; boundary="===============1779113854176616941=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1779113854176616941==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="72eh89SMS/g="; charset=UTF-8

--72eh89SMS/g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2240?usp=3Demail

to review the following change=2E
=


Change subject: ssl: drop duplicate remote address check in tls_pre_decry=
pt()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: dr=
op duplicate remote address check in tls_pre_decrypt()

The existing-sessio=
n branch already rejects a packet whose source
doesn't match ks->remote_add=
r, and key_state_soft_reset() keeps that
address, so the later check never =
fails=2E new_link is always false in
that branch=2E

Change-Id: I74eca23646=
5190ab55db289b98e432757c61a4a3
Signed-off-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file changed, 1 insertion(+), 8 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/40/2240/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index=
 d5ae13d=2E=2Ee4a39b2 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ss=
l=2Ec
@@ -4003,7 +4003,7 @@
         /*
          * Verify remote IP addres=
s
          */
-        if (!new_link && !link_socket_actual_match(&ks->rem=
ote_addr, from))
+        if (!link_socket_actual_match(&ks->remote_addr, f=
rom))
         {
             msg(D_TLS_ERRORS, "TLS Error: Received contro=
l packet from unexpected IP addr: %s",
                 print_link_socket_a=
ctual(from, &gc));
@@ -4105,13 +4105,6 @@
         ks->remote_addr =3D *fro=
m;
         ++multi->n_sessions;
     }
-    else if (!link_socket_actual_m=
atch(&ks->remote_addr, from))
-    {
-        msg(D_TLS_ERRORS,
-          =
  "TLS Error: Existing session control channel packet from unknown IP addre=
ss: %s",
-            print_link_socket_actual(from, &gc));
-        goto e=
rror;
-    }
 
     /*
      * Should we do a retransmit of all unacknowled=
ged packets in

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2240?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7=
4eca236465190ab55db289b98e432757c61a4a3
Gerrit-Change-Number: 2240
Gerrit-P=
atchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>

--72eh89SMS/g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl: drop duplicate remote address check in tls_pre_dec=
rypt()<br><br>The existing-session branch already rejects a packet whose so=
urce<br>doesn&#39;t match ks-&gt;remote_addr, and key_state_soft_reset() ke=
eps that<br>address, so the later check never fails=2E new_link is always f=
alse in<br>that branch=2E<br><br>Change-Id: I74eca236465190ab55db289b98e432=
757c61a4a3<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 1 insertion(+), 8 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/40/2240/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec</span><br><span>index d5ae13d=2E=2Ee4a39b2 100644</sp=
an><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ss=
l=2Ec</span><br><span>@@ -4003,7 +4003,7 @@</span><br><span>         /*</sp=
an><br><span>          * Verify remote IP address</span><br><span>         =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!new_l=
ink &amp;&amp; !link_socket_actual_match(&amp;ks-&gt;remote_addr, from))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!link_sock=
et_actual_match(&amp;ks-&gt;remote_addr, from))</span><br><span>         {<=
/span><br><span>             msg(D_TLS_ERRORS, &quot;TLS Error: Received co=
ntrol packet from unexpected IP addr: %s&quot;,</span><br><span>           =
      print_link_socket_actual(from, &amp;gc));</span><br><span>@@ -4105,13=
 +4105,6 @@</span><br><span>         ks-&gt;remote_addr =3D *from;</span><b=
r><span>         ++multi-&gt;n_sessions;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (!link_socket_actual_=
match(&amp;ks-&gt;remote_addr, from))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            &quot;TLS Error: Existing session control channel packet fr=
om unknown IP address: %s&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            print_link_socket_actual(from, &amp;gc));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        goto error;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br>=
<span>     /*</span><br><span>      * Should we do a retransmit of all unac=
knowledged packets in</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail">change 2240</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74eca236465=
190ab55db289b98e432757c61a4a3 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2240 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--72eh89SMS/g=--


--===============1779113854176616941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1779113854176616941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1779113854176616941==--

