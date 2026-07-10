Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99287C43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 10 Jul 2026 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kX/2q92HyuExCk/R5IJkQdnHJ+OUiAkUeR1bfGGHe+k=; b=hoBIBha51l+gHBM/eox2T5ZQS8
	e7CvirmVKkRgwPOcEWfk6v5lCRRF7kfEEpLlIG1046DLpH28F/DeVgvG2JUzRoYJIPHOT6LTjw0el
	605bvZKbc+YzvFBQVDGomj4ET+4Q9ZaEDPe9RxGZh7GfYqtHqw0RwlEaYpS2+pTg94jY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wiCti-0000OG-Kn;
	Fri, 10 Jul 2026 15:12:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wiCth-0000O9-LZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 15:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NkCZajxDjxYxYGbF7liX1vkyTFxDHlHtZCO+rdcLCW8=; b=FDilwYEkPwL6ugB7PAEto1BLb9
 dpuGH/ULgyDqjsJwRNLLW71gfqiZfDYcJbrzBxQqsWZsWp8l2EMXtNujN5eigI23u86JcUhxYSt/d
 7SX5rDPWKDIFz4XX5FApZMxF4d0MN9PaQt3Ku8OXjVxigMskntMyQi//R8FLHc4t6EdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NkCZajxDjxYxYGbF7liX1vkyTFxDHlHtZCO+rdcLCW8=; b=T
 iJbQhfB/X2ab8DPaXwTKlvliQCItx0OTTAGz8NeBUu0ABF+5xy3q8aht23LqAVT8EImEnSApAHACg
 7Knt7+s91bnhbrM6RkHVdK3wkgiUduwU27fZWr5q1JntvE4T+30ldysghW4r+wlsfFZjhvCWvBtAz
 Djr4g+t3wLy6lGNI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wiCtg-0005PT-ND for openvpn-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 15:12:14 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493f45e20cdso5141845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 10 Jul 2026 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783696321; x=1784301121; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NkCZajxDjxYxYGbF7liX1vkyTFxDHlHtZCO+rdcLCW8=;
 b=b/kIbVzRikWztyu/sCTLFIuBREJt2RWFNdRlp4yTYPDhjir5j9GMoPpsAyCvMclU3x
 qqVnRuM3qhlZIryoVPBWqtmzq5C9YDAYs5X7qm4VS6O8U3MVEd4yKkr+mIw+mv5j7sTA
 QaEsPk9blBG3I7HO1xkJClN/Ku/90NHCYHVlQlNvPc+LwUGRpT93oO0EJ/anynis4jSa
 456PEwxx6HghBnQpjtKynGpamZjAudnvbAUXO9KZjcXqivypoPlJJeNdDiK5XF4Z//Sd
 6BFjQm8WB2hdlrSYK86pkN883JnFRYL1VswtWlGxEGjUz0e/3uGM8h2Awgn+KURxLKJC
 im/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696321; x=1784301121;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NkCZajxDjxYxYGbF7liX1vkyTFxDHlHtZCO+rdcLCW8=;
 b=JIByiBH0FWbv9VRy8JmnrHi60gix0ZZ0BBi0xRmLsDPdbNGO32L0/HtU+TgOGVOgJP
 BKWV5PzOjDxG1CWSkRtpMX997KhYmM/H2zzbglX0PG/6J7g3ZK2u5yBpbzqCkwXa0+4L
 9TNOgqYYlsnfLbyaOPA9npqiC5Gn4jlGG8QRaKC0QegtqftQjL2LHiYC/HUuXwFtZ9bN
 QgyalDTRCLyFjIurRPHR9pFZBcp32CKGtlt6Dw9Ah7St8tWigucSVT3sYFGk2bqSNwbz
 cuTpSYHyB3NHCWgxkb0p+jB1qGE1Hux0fvt5mg0m/St/BPJbVVm6mVVtzCH0GJ21VSqS
 b1Og==
X-Gm-Message-State: AOJu0YzlyMZyOJSCAw3FDCBsn/uGISS7hqeQamM6zwbMK9Lvoxfd6WiZ
 4mIzBkVasyoOzswE8EWbSFTJKBJIYCBRIzxsapasC464U6Hb1uhtuffNc43YWc/mdxdZ60cD+VI
 I730QntOr41SBi3D8/+hW2MFERS/VJWQv7QHbuRNgAKbbwY7IvBaHbl58O83xF2ceUoLr
X-Gm-Gg: AfdE7cmHSE6Gvy8bFfdzppu0eHy+HfMyLxm5SqQ36ATt5jxabWnG1aFNtzRdDx79OSI
 ShvOHYltfYTc/vflhp/WmMkvL+5nWYAo54Pj8z7OIaepne13uvmt/rjG3Exnro8YP4I416BEqeG
 ASJVtG+NPwmwbzYLFRsT0Qvl5GaaxZn8Zr034zfQDUbF7xZsCzqkw8yNUmDVqAUzj1TtXBJE4KW
 o1NcSvgVsR3ppzYwl+j+lmrQLpv0mtd2xB1HacelgXjvOuRAS3CWF2l8fo0EVMHWBH4kXpzMMsU
 cKRhgebary9K1lX6Q3Tkz6jv9TLJudWWCxICyNU7gt480mUrPGm/Jn0g8tDP1qMfjIfeovHsbi0
 9iZxYDnMpJGcUGFIZXpD3o98zyOBReJQXtuXFiFeRNTRP6mX83hFOM/GfsO5udQJk72DwL/7MFS
 XPNbnCucwVwMvHBYRgnqofuuoD/POdMqZYosSAaqKH7wwkDtjI60tUSm2aNQbMFIYJZXyrQfxV1
 Sn2MNVCE5SGu6Pkczp6AGaHP0pp8V2Sf0aNWn/Ohs3wRvJhv6NXCtbj6HihYdujQkddbePt1zQ0
 2mw=
X-Received: by 2002:a05:600d:8445:10b0:493:b89b:9a27 with SMTP id
 5b1f17b1804b1-493e68a0c32mr97551495e9.9.1783696320154; 
 Fri, 10 Jul 2026 08:12:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm68848345e9.10.2026.07.10.08.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:11:59 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 10 Jul 2026 15:11:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: c28a85bbd0eaa065ca92c77676e488c2e394a3a6
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <728051056969512b41b9b40aeb719950f4170d80-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wiCtg-0005PT-ND
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0726401639004018500=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0726401639004018500==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VwF/crLAGbs="; charset=UTF-8

--VwF/crLAGbs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, 

I'd like you to reexamine a change=2E Please visit

    http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail

to look at the new patch se=
t (#4)=2E

The following approvals got outdated and were removed:
Code-Revi=
ew+2 by plaisthos

The change is no longer submittable: Code-Review and che=
cks~ChecksSubmitRule are unsatisfied now=2E


Change subject: tls: reject i=
ncoming reneg request if primary key is not fully valid
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tls: reject incoming reneg requ=
est if primary key is not fully valid

Incoming P_CONTROL_SOFT_RESET_V1 can=
 arrive while the active key is not
yet fully valid for renegotiation=2E Th=
is includes the window where we are
still waiting for auth_deferred_expire =
(derived from handshake/reneg
timing), as well as cases where deferred or m=
id-session auth later
leaves the key non-authenticated even though state is=
 S_GENERATED_KEYS=2E

This patch keeps read_control_auth as the first gate,=
 then rejects the
incoming renegotiation requests unless the primary key is=
 KS_AUTH_TRUE
and auth_deferred_expire has passed=2E

The rejected request =
is not counted as a TLS error, since soft TLS
errors trigger an instance re=
start in TCP mode=2E

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
=
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M src/openvpn/ssl=2Ec
1=
 file changed, 15 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/1478/4

diff --git a/src/ope=
nvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 69d0e4e=2E=2E106dd1f 100644
--- a/=
src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3747,6 +3747,21 @@
      =
           goto error;
             }
 
+            /*
+             * Do =
not allow incoming renegotiation unless our primary key is
+             * =
fully authenticated and past the deferred-auth/transition gate=2E
+        =
     */
+            time_t auth_deferred_left =3D ks->auth_deferred_expire=
 - now;
+            if (ks->authenticated !=3D KS_AUTH_TRUE || auth_deferr=
ed_left > 0)
+            {
+                msg(D_TLS_ERRORS,
+           =
         "TLS: refusing premature incoming renegotiation request for key-id=
 %d: "
+                    "auth=3D%s, auth_deferred_expire in %d seconds"=
,
+                    ks->key_id, ks_auth_name(ks->authenticated),
+      =
              auth_deferred_left > 0 ? (int)auth_deferred_left : 0);
+     =
           goto done;
+            }
+
             key_state_soft_reset(se=
ssion);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESE=
T_V1 s=3D%d sid=3D%s", i,

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-Number: 14=
78
Gerrit-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelb=
it=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-A=
ttention: ralf_lici <ralf@mandelbit=2Ecom>

--VwF/crLAGbs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>ralf_lici <strong>upl=
oaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by plaistho=
s</p><p>The change is no longer submittable: Code-Review and checks~ChecksS=
ubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">tls: reject incoming rene=
g request if primary key is not fully valid<br><br>Incoming P_CONTROL_SOFT_=
RESET_V1 can arrive while the active key is not<br>yet fully valid for rene=
gotiation=2E This includes the window where we are<br>still waiting for aut=
h_deferred_expire (derived from handshake/reneg<br>timing), as well as case=
s where deferred or mid-session auth later<br>leaves the key non-authentica=
ted even though state is S_GENERATED_KEYS=2E<br><br>This patch keeps read_c=
ontrol_auth as the first gate, then rejects the<br>incoming renegotiation r=
equests unless the primary key is KS_AUTH_TRUE<br>and auth_deferred_expire =
has passed=2E<br><br>The rejected request is not counted as a TLS error, si=
nce soft TLS<br>errors trigger an instance restart in TCP mode=2E<br><br>Ch=
ange-Id: I704c560fa23c03237d0f8adc30908a617265a5a1<br>Signed-off-by: Ralf L=
ici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file =
changed, 15 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/1478/4</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>in=
dex 69d0e4e=2E=2E106dd1f 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</=
span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3747,6 +3747,2=
1 @@</span><br><span>                 goto error;</span><br><span>         =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            * Do not allow incoming renegotiation unless our primary key is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * full=
y authenticated and past the deferred-auth/transition gate=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            time_t auth_deferred_left=
 =3D ks-&gt;auth_deferred_expire - now;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (ks-&gt;authenticated !=3D KS_AUTH_TRUE =
|| auth_deferred_left &gt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    &quot;TLS: refusing premature incomin=
g renegotiation request for key-id %d: &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    &quot;auth=3D%s, auth_deferre=
d_expire in %d seconds&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    ks-&gt;key_id, ks_auth_name(ks-&gt;authentica=
ted),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      auth_deferred_left &gt; 0 ? (int)auth_deferred_left : 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                goto done;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             =
key_state_soft_reset(session);</span><br><span> </span><br><span>          =
   dmsg(D_TLS_DEBUG, &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=
=3D%s&quot;, i,</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">change 1478=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
704c560fa23c03237d0f8adc30908a617265a5a1 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1478 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></h=
tml>
--VwF/crLAGbs=--


--===============0726401639004018500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0726401639004018500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0726401639004018500==--

