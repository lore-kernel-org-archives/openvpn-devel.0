Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287C4C982EA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJoqgxbIuWA/QnjBU7mNRFTtyuS9pIRnLkH8yB6WH2Y=; b=cRRWABvtQzLzq5P4AzWsDf8ngi
	5KebJMi6CRs7V70mQfR5p5YcfHYFNLPBb/KMSOWdtD4e4uPJLdCXoeUReFPljuG07ZzGhFSRNjozx
	v34V7Wb6Z07hHDaz/iJAWgi8YhKEa7qo7RsnQdLOSsCkziK6I9TAyRSPmKso+4ydCUg4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9JJt-00010Y-8L;
	Wed, 23 Sep 2026 09:31:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9JJo-00010K-QY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:31:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HIeMLX8/O4nfMRFia7RtbVPQEBoUkE+N31RUgqlkIh0=; b=DuFwFd4qwNJYqJ+3CNFLQ0MN2I
 PuEqY0n4Y9SOCCEyeD3ujne7Ro74c2aHk36s2ZD7rKni3o0ibCpsEPeCYY6Y+RpU2EACeKrT2evLr
 DbKgUL1rFBGSRBptJU1G5NdjAKFX1vAjKPIi7xSHo+ZpIyb3iTTKg5lJ7jpyg9Oy5Vos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HIeMLX8/O4nfMRFia7RtbVPQEBoUkE+N31RUgqlkIh0=; b=m
 GY9SUcJO88xyF+gpCUqUVpbbg1cP2d1Y0NQJ04ko5e3zjK2oV9Z+nag6L0KQ8T8JjZSjXGzjhWTpE
 PTz7uO+v+83L1fETcoq8JFHG8PQPUFrChWZJvwrUUiKukNBXSO9gg/3IZzxxT1kdRh+AUDDB+8Bbe
 P7DzQTx2itxsbrco=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9JJn-0004m9-Dv for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:31:12 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso4321585e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790155865; x=1790760665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HIeMLX8/O4nfMRFia7RtbVPQEBoUkE+N31RUgqlkIh0=;
 b=TiPlG+eM06LT/ZyYFiPaSvXM263vzZiBqCfFSDa3aIDKGxwzf9SCUAOn0PFNr+YZ52
 +cMiDDBOGtzHW4A7E2ExQ12OXzCAddS8Z7h4VfQchd7OrcjgFGb6kMqKx7KGbZSZ0QTT
 r41/ZtbcoKwKBJZKI521+cC6yJVGa1+tYIjU5OWhwOzBnpTfuwAFcqe0fkP601VpKgim
 oNK21E8sXwL5MElFXtyA5NRyMDkUwk0YF8fC1/Ygwz2EqUBfXzl7aXrUub2t3gbYWi65
 12gIDaburpDpY6whwO89+Bz/MB6rm/oYsWWmFSHLG6qvLQOdliTuFfHAyO5dAqDjl1Zj
 eZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790155865; x=1790760665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HIeMLX8/O4nfMRFia7RtbVPQEBoUkE+N31RUgqlkIh0=;
 b=Nwj6SzRx5HEiKn8ukG1nAL6bfnImYIGPAJV2Q4g/G4xFS5L+IVUPwy9PpjOuQJAsIH
 9PRmQg5yz8CG0Pz8FlYd5nPeu1LIjmDFkYOQsDt/6kau56Kp/qCo4IYvhCsVDm3JXETh
 eR4j2XiPOZY6vftvoYZi/Au1qD8wcyB/cG8VQiVGbG7klEB5Gm5Sm86Yl3omLQB55yP5
 gava7YiWsAHJ/qb7TI+HWjhUX88EEY5+XXmAMkZeuikTD8V3+C14I2BklwrQ+xbRVPej
 NLgopOPHxC1OApr+hJEtUfxYiwSpzL3hLjfk4OeWjaze4u9t7+mIgSSqWGSeKl8evfao
 nJmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhM4CjPPyjhVAyInK5kGVHKmIyJQw3PpmQdacXTEbD8gJqnXr9NzXSIivSrvL3lZO7zNKzylL+vHsCElcV@lists.sourceforge.net
X-Gm-Message-State: AFuF++ml/2GmcyygMTZng22Qi9y9S/El35gXvGLj4mJL6A9pj3pummF/
 SE174T+u8OLygJ2kZ9g0otDWdJUzZIqYNI/mkncfdvIjeqZze80smqDyfO7pE60Vclf+uUmnY6l
 YiHoJispNUmwENEG/3gVQiH0XV9YtkuChrckPT7fLm/jWv3i0COCbzAktREWllSBQSRlowF7sqE
 6FgGjTag==
X-Gm-Gg: AYBFou0KjKB6q9JVGhx9xhIr3rBfqQFgv/fpjGctl6J5vVuosGsYwy1gCIHOTUlg11s
 2NbUGcIi/1wN7+C49MoVbZLBxqKHi/HNzRGSoMOCiTZCz5CW60bfSFdhmASfzkU9cZqh/jAqYys
 qjArp/ExJxlsCrSa/qFwmlVINh53dI6jQRItsK3z2vvUC9peINRd+hgVW912Acj+adFsDI/S8td
 4eyXcENc2FhnHKKTKwWcJhHuRJiN2odlALP55vy/pBq0dkyPXxu+pMJoW4oHkcwaANa58v3d4/I
 ytFY3ymzFlYlTwDJa2/ztkxh1FaG/6vAbwY72nXu3Fn3lxkbaXgZ9Bo5wpd/aDE/PpnlYBb0zPb
 h69Oj3xQ5IWgiT9dLXRtsb8VLU8X874TJZJroddsRKEStnxxhunhabeYtt5ethol86VM0uXUhDg
 SEyafHRB6OgmWLFXkL8P24VwS9r3V/XAdj9YyCx/lw40nhntpRDeNoVgp/gm4c7asBTlsinzNtH
 FHZxgRMeWN6WMDbEzJHdtiZvLlkpiSTUck0s0BFIF6BqXCvDiawGk0UyEqh6Eja5C5TSFwnlFR1
 jHbPw4mTw2cSBiY5EC/6aUHGjfUHsnMI24LPDALgzqkqcExvdlWySJT32bwx+vxQpREKIEc=
X-Received: by 2002:a05:600c:3148:b0:49e:602a:b4ec with SMTP id
 5b1f17b1804b1-49fdf0fd0ddmr25184945e9.8.1790155863400; 
 Wed, 23 Sep 2026 02:31:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1893d5sm75060805e9.4.2026.09.23.02.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:31:03 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 09:31:01 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 7b7c45c521bf9a21daec4b56a934967b6259ea6b
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 09:31:01 +0000
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab0e466b2ba9d0eb887897601e1badfd114378da-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9JJn-0004m9-Dv
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: advertise a
 connect_lifetime in the probe reply
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6152648080475215244=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6152648080475215244==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m62M4R1/C2s="; charset=UTF-8

--m62M4R1/C2s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1768?usp=3Demail )

Change subject: oob: advertise a connect_life=
time in the probe reply
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 25: Code-Review+1


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerrit-Chang=
e-Number: 1768
Gerrit-PatchSet: 25
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Wed, 23 Sep 2026 09:31:01 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--m62M4R1/C2s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>ralf_lici has posted comm=
ents on this change by stipa=2E</p><p>Patch set 25:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1768?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6c2246f9d9c0a50529=
2ee8d879f714901ffae </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Wed, 23 Sep 2026 09:31:01 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: Yes </div>

</body></html>
--m62M4R1/C2s=--


--===============6152648080475215244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6152648080475215244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6152648080475215244==--

