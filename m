Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C3C531F8
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BiXv3JGdk0a2QfX8S3JE2BnM2/LteA88sWMkuJoNF74=; b=SHmZGjgBdZ7Km47KqymZTpaYE3
	ejl6VRFSLuLeDOje7EtKMA2s1hDmkXi/k6si0DoulKnx3At5NADiyVyk9DHQUTavri/T0o8v5mRHA
	enVAGX2IJpaCnhCUYSQQKAJCXn0nBIA66DqBJzyCQRA4ZHmABDb0+XxPcncE0KfzX4JY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmw2f-0002SB-7O;
	Thu, 23 Jul 2026 16:12:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmw2d-0002Rr-56
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/TUieZoYq6ETw8loQfPiCPfor0BP0OEKe7gRZ4F/AnQ=; b=R9RQedQAkuJ+FLX3w1Bg2U2y4I
 rd28RLKuLGuQJzRyLq0qiBGQJoVzi56xxmjY0vyJskauFAXjzKrSCupsNqZGabEDp3X8/V4n2eOjK
 3uPjsQWbRZGMUldThR8Ud6VshaXBFrE5vbj5Vs3rX9+pLmMESAn7To7Dt2c2qnLi/RNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/TUieZoYq6ETw8loQfPiCPfor0BP0OEKe7gRZ4F/AnQ=; b=c
 +GfQi2hHAFB/qRCneCiEcXIXFqNz1T6JXU0sMD6l1BXm3gJzLYdMIH7FNK/BSv2osjJoH096og4LR
 p3UUvBiQRE/EWVq4MVxgQCfsx2EY3Qg3dbVrGILo00CRrUdPRTnxH+Cq4As7ufcqfvK6srvc0sLzo
 mUzm71txE8bbcrsM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmw2Y-0002vQ-2H for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:12:56 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so7326775e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784823167; x=1785427967; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/TUieZoYq6ETw8loQfPiCPfor0BP0OEKe7gRZ4F/AnQ=;
 b=guV+PrgcfDLKtsyr3XTpcTqtL+sAYVkQMYqIsVPmqYC8IBhSuzEIR+utguJQ3fesQ8
 UGUNRUqfIhLV69sYjjl0jzaOJhS+pmlaYxbtVm5g/6yhe0tPXbGDWziAbOGqoIxqWrgj
 YQ5i3oZwadZYdBBYmCUgWETLuhsySm6D/96oqq0LX+mBJ8zlnsjQ3g8IsxvtIWt/Jl+D
 C3uX/ON511kLdnjLkWY9Chgs8YJK87pnNKIzB+vOJ5h0wC3NZlZfFIzqt5lZod/obA5q
 SxhbVeKu5NQPiqn1fuq/jUGLUYZVXM34iqYLRDYDKDCfo/GCiKz6pgwXo5Vqbg27+Rpq
 87tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784823167; x=1785427967;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/TUieZoYq6ETw8loQfPiCPfor0BP0OEKe7gRZ4F/AnQ=;
 b=Nh/6AVGSMcWpkOWeUk3+6D3XrhUsyA+GHsbczBk3ogIItGSMxFgI2gvk2mBktML90z
 Y6IOzM0cfnMMsdj1mO+q6Ef9ilZkguc8Id0qLlrxiNjR8LXKOKQ4y1uKX86AzBTYCh8U
 YqprcRNCvW6BLbj/12UJu2wZLp3NaYMVIYAn9FQtjHPO1XuDpaend0QPMpdtX80RI0TF
 wMCK2UsWz1gtbfPUyiLaouKj9u7PjNp3AWfgXcRqVQAZh6W1lM+kPe9RMfWG/bjEIKcI
 px0A84VdEoxe+OYjEsZNhSnsxGVVeUH+nhQCaJTUz/fnHY+SGnpsyzesXVBbnTP7L5D0
 ZD/A==
X-Gm-Message-State: AOJu0Yy9zhOvEIaGnlT/TnmmoIuPEIvNRYwm0GcBLfbc/6tv38VF0Lyq
 SUL3Aon8lMEi32G4TRnNzpdDqPrGj6j7fQWhvtQD6m80LIYm4hqN3jXje5xH2rizxvoidICHC1g
 EwyvfDYVUqFyohLAf2rYudlIrDFnSGe7ORgXxOQ0qYPjsAszB7L0yhG/luVuYC4x+0OCn9GMHa4
 91KVcC7w==
X-Gm-Gg: AR+sD11/odWB00gCfmA8KMra86wsxHnqhZIdGxQyd5iI80cPRyzJZg+1czramI/ikU0
 PvmJjOnu9OYYL3EunW8h93Q6D82wGyZY1/kKMiGLKB4BD6NnZHFJWLvZci9yP1mRiH8QlxRyY4G
 mZNyHlkefs7bBZM85JxMM4iYuuztcpFy/xk1Row5qIYLluD5+/1PO/P71Zsduou9SX+vGuO2HJT
 bcoTFPqec3Kcq+NMTcoc6kp5fWsU2TSXQQeQuuhUsjZFg+RXdTx14Sic1ktjxr0/VmWKEuaZoNT
 LyQjoMXoSlU2hH8FGUmVilk7P3D0Qgl63Aq/NaO8/4p8BiK0DYN2dUwQp6wY5RmJTJyDsrBlBkz
 Uz/YBDWnSOiI2O7opjmoT15TZyrfFlvPyV+RTpM7gzsjXGvkER3i5vp0JfT8Ta1fMcIBDKYmlCG
 e3iTQRUBPhczGnLksrL4VoZHZcNWiaeOygD7eqVkApLo3/bHKZqECet5ODIO+RBmYQzEiSh3qbt
 353XOIoOs1LBYr8Ap/DgiRDIUuY8csny7isZsrWwF+I6Fu+ZQy3lCkJ6lQ4ayL100yf
X-Received: by 2002:a05:600c:198a:b0:495:401d:9f4f with SMTP id
 5b1f17b1804b1-49573cd8a99mr39007385e9.25.1784823167339; 
 Thu, 23 Jul 2026 09:12:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afac1cbsm3149605e9.10.2026.07.23.09.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 09:12:47 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 16:12:37 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: 8a8dd68b0c47ebc421e31eb4fbb60311032019ea
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec0df95f2f2d48f7b9eafc10f0a2219df2991db2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmw2Y-0002vQ-2H
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add check that
 username is identical to multi float
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8533043909336964847=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8533043909336964847==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fnoVMOLpL7w="; charset=UTF-8

--fnoVMOLpL7w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1724?usp=3Demail

to look at the new patch set (#6)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Add check that username is identical to mult=
i float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add =
check that username is identical to multi float

This adds an additional sa=
fe guard for setups that do not use
client certificates=2E

Change-Id: Ie55=
2084638320b3bace76be2f589013f12af3c46
Signed-off-by: Arne Schwabe <arne@rfc=
2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 13 insertions(+), 1=
 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/24/1724/6

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index d47a09d=2E=2Ee6d8712 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/o=
penvpn/multi=2Ec
@@ -3115,6 +3115,18 @@
         goto done;
     }
 
+    /=
* do not allow if target address has a different username */
+    if (m1->l=
ocked_username || m2->locked_username)
+    {
+        if (!m1->locked_user=
name || !m2->locked_username
+            || strcmp(m1->locked_username, m2=
->locked_username) !=3D 0)
+        {
+            msg(D_MULTI_LOW, "Disall=
ow float to an address taken by another client %s",
+                multi_=
instance_string(ex_mi, false, &gc));
+            goto done;
+        }
+  =
  }
+
     /* It doesn't make sense to let a peer float to the address it a=
lready
      * has, so we disallow it=2E This can happen if a DCO netlink n=
otification
      * gets lost and we miss a floating step=2E
@@ -3131,7 +31=
43,7 @@
 
     msg(D_MULTI_LOW,
         "closing instance %s due to float =
collision with %s "
-        "using the same certificate",
+        "using =
the same certificate and username",
         multi_instance_string(ex_mi, f=
alse, &gc), multi_instance_string(mi, false, &gc));
     multi_close_instan=
ce(m, ex_mi, false);
     ret =3D true;

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Gerrit-C=
hange-Number: 1724
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--fnoVMOLpL7w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><p>The change is no=
 longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add check that username is identical to multi float<br><br>This ad=
ds an additional safe guard for setups that do not use<br>client certificat=
es=2E<br><br>Change-Id: Ie552084638320b3bace76be2f589013f12af3c46<br>Signed=
-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mu=
lti=2Ec<br>1 file changed, 13 insertions(+), 1 deletion(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/24/1724/6</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index d47a09d=2E=2Ee6d8712 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -3115,6 +3115,18 @@</span><br><span>         goto done;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* do not allow if target address has a different usernam=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&gt;=
locked_username || m2-&gt;locked_username)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!m1-&gt;locked_username || !m2-&gt;locked_username</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            || strcmp(m=
1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float =
to an address taken by another client %s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                multi_instance_string(ex_mi, fa=
lse, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* =
It doesn&#39;t make sense to let a peer float to the address it already</sp=
an><br><span>      * has, so we disallow it=2E This can happen if a DCO net=
link notification</span><br><span>      * gets lost and we miss a floating =
step=2E</span><br><span>@@ -3131,7 +3143,7 @@</span><br><span> </span><br><=
span>     msg(D_MULTI_LOW,</span><br><span>         &quot;closing instance =
%s due to float collision with %s &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        &quot;using the same certificate&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;using the same=
 certificate and username&quot;,</span><br><span>         multi_instance_st=
ring(ex_mi, false, &amp;gc), multi_instance_string(mi, false, &amp;gc));</s=
pan><br><span>     multi_close_instance(m, ex_mi, false);</span><br><span> =
    ret =3D true;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail">change 172=
4</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ie552084638320b3bace76be2f589013f12af3c46 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1724 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--fnoVMOLpL7w=--


--===============8533043909336964847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8533043909336964847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8533043909336964847==--

