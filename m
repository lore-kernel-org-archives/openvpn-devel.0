Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEA8CD8C8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=opOdyFkGgaRZFM2qMwPgulocwbxnUWfB2XlyqZ0sAJY=; b=bfOs8mZFvc37+XkS8Y4SMOryXY
	Brm6C7Reb2rlFcEOIy9N8JsLEIn0eIZHmEujhVYhDBpH66eg132IAdXGF7Rv5WrISv/Fibu1pMFAU
	eQzkbsMObKgkvdhz2bByPLhaBjHIJs2Sy2OPEHtHdd1XhQ8/HZcmrIU/90eLRZAXAcwg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGhi-0004Kn-5C;
	Sun, 07 Jun 2026 16:50:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWGhh-0004Kh-AX
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 16:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hYpbmoQ9aaAKAwt8Y8RvdtorWRgjizceq/t0469q+yg=; b=RC70eMQdCjU2PS+V0U5baJ+vGo
 hwxveupMMuAfzsvOthbinI64ltwEhQ8KQpS/SH+vNHqwZ8QaXS0JkyYgqKWX/35cfC8coYtC5Q6Bv
 fApuWiLRMVHii/mXnsY50wmhaNpMehxs0Q7B3OhU0JKXY7r+9Zvm8ICbawFuiytV+/Fs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hYpbmoQ9aaAKAwt8Y8RvdtorWRgjizceq/t0469q+yg=; b=K
 OKoEeZmBfhJzlxqKisWjxX0iqjKFIe/7TsX0d2H7BxnjT8IqERMfhlVapkeyaC/EVE9PZsiTlRVvR
 w5+4DUNRvO5615XbnMLpypZBW//28Vjxn9m1u3aPbzPdI7OJjzgjVmNAY0EE0J85Pori2V6fUopeG
 6UdKpTIT89gC3XwE=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWGhf-0008VR-QM for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 16:50:29 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490b4e1ade7so38047855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 07 Jun 2026 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780851017; x=1781455817; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYpbmoQ9aaAKAwt8Y8RvdtorWRgjizceq/t0469q+yg=;
 b=hFmJi6ih4JYhiWQ10aV/9SXMFhZWblD+4bUVzwb6DzJjIMJmFUDBfXtZ1jCvOtiN4+
 YxbBXCRkmL49kEXGidjBBJJ25nFHxRirqEwdJztnEgkegX2zTKLSG/vxUpc9dZEJS8Qk
 PxzZcVXsNe4BRwxvk5XpQPzz0uodgQ/p+XA8PiCJZFU0tZezwUEn+djCCrmm7xouDw+/
 qoycSNrIZGzbhZXwX5EKZmz+PQswbP+Q3q01p0/bI01HjfNuFcQBq4/Srqupm4JKtHdD
 bKYq9ilORiEWt71loNXHC1xLW1z8ZMcRLBVBhrFeJ/yEXqVaCxpyj+/ad/KRNFgvFIIX
 A8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780851017; x=1781455817;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYpbmoQ9aaAKAwt8Y8RvdtorWRgjizceq/t0469q+yg=;
 b=jibgEMbvvpasMX/ixvyIMUqcZARCKw7yRVV+NF/4/etVAC1slUTq3pqsolL1hGge7e
 XBcvVT6I1ZALxHzNnDv45vzldnqTw8RmenAG/QSXaaQGCBa00EvPbWEyIPXwSdE33j/T
 MsIHG5eOb3hBjPjSVwArRydc7herlngqz2ThbWksyepC9Jcq2EkhyT4a7z1A9ehPrD5M
 pck9bFbj4wrKJaJKTe1ekQRLRuyif6y2k7Yd+b2Dkwj7hvJa8vobcT8jUp8x8RPwWXjg
 0Vs1Enrq1/mBcz4UdvcFibXNxz1YWJL2R2dSIlmF33LsbB48Zk8ZvGZQIVDPGy9BEgE8
 FowQ==
X-Gm-Message-State: AOJu0YxFRIrr360kO9bP15W6/TR/02vxcZbDNcFrAuF4llZm7CwRGjQY
 atMBBwjgi/eedPpgGYeu9+uoF4gGslOivAw8gnm2E0oYBAnHENRL76db6e/FtlN/8RMWcN9K/jn
 Camd5OSOzQXg0ZcOURCB0rNGdzB6Xs2+dx+9Lz5815Bk9xXa2AZlNhKR5UhW4xB4MBbxJ9y+IEp
 /2cRUrng==
X-Gm-Gg: Acq92OEciwns7W19FqQ9s6F5pUdkukJkxbJy0vGb0tCuQNywC9aICcTciCgJfuP7Unj
 o7sZ2z4c40r1iDLJiRKPrQsyCvRp4mSpen0kX54Rq+uLvaE8VISZzKF4C+CFiGLkDaZIGZpyBh9
 b5CO7DAvAfqaAHqzx8WwNhH+RTK8G+e3yXwyzy9v0sd+fFsnYpVkTpQEqqxObVhrObGO/AJN0qq
 4FLTKhUo1U9btAXcr1B9zVhRMv1e8fD/hV6wfrlML/cmypoxcKKey87oTxRRXrMGNMjfVUWlYUQ
 dxi/pGLY7+aHBNXXqx+obpIocmAzy24hGCEkUUrk8QysLxZG9D2TMUSRtem2q3ixUg7iXp9VPzt
 8KqESMbsFDWQ0o3UlsGTrTMJ+dMi875hSGKBRJPR/gszMUWEpzM3emIihhStECM/oW2v1bEfBCZ
 Y9RJCt6SCZWdjKJXF6bmtu1E3uu/uqJ23Mf0iRQ1zmrx/nJhiQPbqircDrDnWN45ZdDH6rxQWEx
 5LjEUUGvMS8vDx/pI0eaLwpkQubrNvPsEUL3H4ruqrQs6NC1AVmR/fCvau5GIMglJy64/d3+kpB
 HYaB4VN2UrwJfVBpfYUifwN6
X-Received: by 2002:a05:600c:6096:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490c25c70cfmr196154095e9.11.1780851016438; 
 Sun, 07 Jun 2026 09:50:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d4891csm160340205e9.1.2026.06.07.09.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 09:50:15 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 7 Jun 2026 16:50:12 +0000
To: mrbff <marco@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
X-Gerrit-Change-Number: 1705
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1705?usp=email>
X-Gerrit-Commit: d66de4e0a461c8cc5fff5a00ec14b41dd27fc365
In-Reply-To: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
References: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5ODk2NjI1MDAwLkliNTZmYjUzZWMxYzBjMzBjOWFlY2JkMGNhNDQwZGUyYWZmYWQwNGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <086581ab05f09eb919831af5e1c7f940487b5c3b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWGhf-0008VR-QM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: allow
 passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6733740242434656111=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6733740242434656111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MtP0HobKNg0="; charset=UTF-8

--MtP0HobKNg0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 mrbff=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by cron=
2


Change subject: dco_linux: allow passing KEEPALIVE_TIMEOUT without KEEP=
ALIVE_INTERVAL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


dco_linux: allow passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL

De=
pends on: https://github=2Ecom/OpenVPN/ovpn-net-next/commit/67f453e3146a646=
ef5f811e5a85c610537d80521

Closes: https://github=2Ecom/OpenVPN/openvpn/iss=
ues/911

Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
Signed-off-by=
: Marco Baffo <marco@mandelbit=2Ecom>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705
Me=
ssage-Id: <20260605181053=2E3774-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37070=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
/ssl=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/1705/2

diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index d332359c=2E=2E0998bd6 10064=
4
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1623,9 +1623,9 @@=

 
     if (dco_enabled(options))
     {
-        /* dco_set_peer() must be=
 called if either keepalive or
-         * mssfix are set to update in-kern=
el config */
-        if (options->ping_send_timeout || frame->mss_fix)
+  =
      /* dco_set_peer() must be called if either keepalive, ping, ping-rest=
art,
+         * ping-exit or mssfix are set to update in-kernel config */
=
+        if (options->ping_send_timeout || options->ping_rec_timeout || fra=
me->mss_fix)
         {
             int ret =3D dco_set_peer(dco, multi->d=
co_peer_id, options->ping_send_timeout,
                                   =
 options->ping_rec_timeout, frame->mss_fix);

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
Gerri=
t-Change-Number: 1705
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@mandelb=
it=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>

--MtP0HobKNg0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by mrbff=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">dco_linux: allow passing KEEPALIV=
E_TIMEOUT without KEEPALIVE_INTERVAL<br><br>Depends on: https://github=2Eco=
m/OpenVPN/ovpn-net-next/commit/67f453e3146a646ef5f811e5a85c610537d80521<br>=
<br>Closes: https://github=2Ecom/OpenVPN/openvpn/issues/911<br><br>Change-I=
d: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5<br>Signed-off-by: Marco Baffo =
&lt;marco@mandelbit=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705=
<br>Message-Id: &lt;20260605181053=2E3774-1-gert@greenie=2Emuc=2Ede&gt;<br>=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg37070=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 3 insertions(+), =
3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/05/1705/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index d332359c=2E=2E0998bd6=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -1623,9 +1623,9 @@</span><br><span> </s=
pan><br><span>     if (dco_enabled(options))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* dco_set_peer() mus=
t be called if either keepalive or</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         * mssfix are set to update in-kernel config */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;ping=
_send_timeout || frame-&gt;mss_fix)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* dco_set_peer() must be called if either keepaliv=
e, ping, ping-restart,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * ping-exit or mssfix are set to update in-kernel config */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt=
;ping_send_timeout || options-&gt;ping_rec_timeout || frame-&gt;mss_fix)</s=
pan><br><span>         {</span><br><span>             int ret =3D dco_set_p=
eer(dco, multi-&gt;dco_peer_id, options-&gt;ping_send_timeout,</span><br><s=
pan>                                    options-&gt;ping_rec_timeout, frame=
-&gt;mss_fix);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail">change 1705=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
b56fb53ec1c0c30c9aecbd0ca440de2affad04b5 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1705 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--MtP0HobKNg0=--


--===============6733740242434656111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6733740242434656111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6733740242434656111==--

