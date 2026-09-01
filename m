Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C267FC624D2
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e17pLiO0WRNyEJZXJ9V616VytX9Lfaa9hbZm6sfw2eE=; b=HgOduwvd6C3xt+ngIffoMcn0E7
	Bsw9LSoSgYOLFGLj9d5B8bToa47hlWFGrYLcW2OA6pLg5nuMxoT03MkU6rc/EYIN7kljP2sXpuN+I
	S9syAAoyC/+50JLy4G3nAKItHoRNHpFiynAWk+yuQu4MtSUt7pRLIQtsp7M7ZQCam6o0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1NrI-0005zr-H4;
	Tue, 01 Sep 2026 12:45:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1NrH-0005zb-F9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QaShxVC9vU6IAq72nPrG+Zhm3biA0LGxy2xIr/aVG5Y=; b=YcvJHA5CMJ3tvixvqAY5cmDLzl
 i1MCcV2WAuRgeudKfwIOzw07erf/jlAPkj1snPr0RBN/KvIIXOOL0MGH6mS+va7BlLz1j56i/OO42
 6Cs8lmygT5tjkwqD+take0QjTID6veZhtfrYwFqT0IlslVGrPyHAp3qpgSGmBZnP7DeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QaShxVC9vU6IAq72nPrG+Zhm3biA0LGxy2xIr/aVG5Y=; b=O
 slu/U8iEWkucopDn3VE1TGtPkejKmE/3LZJoCqky6peYp+pjPZjJRGcgN9Qd7G6Yqwl4okVFgE3wY
 nI2HTNEeBayQzq2QVoC3j9a7HY2Jh4TNVRepggntnWJ0zjMkwU9qjfWeBeki07AzCf+KRj+slxvSy
 pew4x1pv4xyVNJQc=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1NrG-00084G-Qg for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:45:00 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4843c41f35bso655329f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788266692; x=1788871492; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QaShxVC9vU6IAq72nPrG+Zhm3biA0LGxy2xIr/aVG5Y=;
 b=dudE8DYiXw85AkynpsQ8rNQ7j2683IqEDvfQ4fdh5rFpExZaULsbICF/1+WwltVKrL
 aUinx6Fh02Sa7F4F2aVJOKJkRfs2o8NkcZSkozpBt2mOrnRiC5KWRwDkCbjPFise9TCE
 i3Xvk6P7q7mftWIXboaLhatv5Y1Dt283907cHkFDhyMhZeNxLgyWpPbeSHO2oJktcN6F
 ZfRigaf0wuuZuxs/deOxBJz3iOBvXNkCph64umO9f30oWzCI1zIzNV6Q386RIXCU4dVH
 r/T+NjTlh0MDJ7QffxDDRRPy1BVMXdnulH3UEW9YkGi0s0l5LFBbCCgphKOCE51GEfJx
 Nm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788266692; x=1788871492;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QaShxVC9vU6IAq72nPrG+Zhm3biA0LGxy2xIr/aVG5Y=;
 b=NakOSp0XX4cBxH/uY2HhQAjf1h3EqN0AgTzmnVKdf+JmONH9lAWj5U0ZdmcnSQqU4d
 AuM8bOL+5cdE+Wh1TQyjYVQmwl5cRfMcWRaOhIi718CtuscWh7Z7rxIIFUOJQ7aXzYjX
 QbmHYLrwlquSpCZDmu9BQUvvKQN8VMLgYq+B+/r+17Oaui71RIq5jY4uB7Rnx2DXRiiX
 qIAXgHf+HGf7vEquDwTcOK+b1Lo0FGCAj8I4+cMZQFPOFqKelDWGyh3LRKi+bFxd5PXJ
 AlT6ANZ2sDP5Bo6QFQyPTW5gxs9TbrZzpzXcJJxB8dsCXPpp8c/0RClXQY6SyWOvSGQ5
 vKJg==
X-Gm-Message-State: AFuF++m8KfytKl3dgiBk6byPrfy1LcwLHXlysQbZmHf2VCjKXdKtMlso
 pN+4s+IeJQAveC/NbgCCkI5arYxWJYDSY4rB1/M6DVztpvRZwUGX8YXw1RoR/yfxoNefgFNDnho
 bEvz6CYoRQ48rJPLA9SkMx9SaeH45epVZWDyHMgz0rx+4LqxNZJVRQUalTJ0H1CwfCi/NUPHdKc
 bJbuF45A==
X-Gm-Gg: AYBFou2IPo3dwzD9iqdL+mYw3H30s476WC6tr0syA/ShXdghWLyJlZDtGb1WO68Gd8U
 jb4tqj5uKYxR7fFi8Upr17zlropQs1r8UAmVCd9mAyxKOBr1Uya7ANXtf8iFgnyAfx9kfq6e7Kn
 O0Lg3LlV8jFXLqN7o7rlwUrSkZ2oEDm+fy3KhjSVIA5TtNSxfwuWawbbyBPSSpXqJIrM04ApcCC
 lgDBk0gXj/IZhfout9SbUceC4hXIMhE4T/HqHaMBOHy9GAwSkPwVthCNho5Tft1DuxKfh4Nw4GG
 t741FVvxp0akWcvpc+BRlk/0MxZwaVljPQudQ2NSYEeuqTiqfu9aeAAI6MT6bBYGe0Fyx4oTebV
 20v9oRnPUPg2LlhDihoX0g5xfPtLuIbdRjnPhB8YUWl8f05xvjA50ufUIuMW7GjfK97XVZFxNC4
 4A6fFEuMFDbZ+0Utj6Lugt/Bn2znWHGFmZ5Sz02BGkn23b3s6QnqRBigYehPK2w8bR+b/KT2q8P
 N+6MhgD5DLMElvAVyQylLK6Z5JV5wa1cmdWV8ccDtrfKLv+O5AxgdZjbEKtWCdroOFvp45m/YUc
 L9EXjiFjqOLqZLHa1xSLGUnxHPqYEVqSvtz0iIHo6zctt9TFzLM=
X-Received: by 2002:a05:6000:46cf:b0:484:44ec:2c3a with SMTP id
 ffacd0b85a97d-48444ec2e31mr5900024f8f.0.1788266691953; 
 Tue, 01 Sep 2026 05:44:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d3c792sm4569226f8f.14.2026.09.01.05.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 05:44:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 12:44:50 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
X-Gerrit-Change-Number: 1887
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1887?usp=email>
X-Gerrit-Commit: 4654317ddc50c450aa847114f5ab7845b201023b
In-Reply-To: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
References: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkk5ZWU0YjZkMWMyMWJlYzM4NzNkYzZhNDc0YmQ2NWQwNDNiNTM3MGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b8923e34f669a975586078357acf515b647ed99-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1NrG-00084G-Qg
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: pass
 correct NRPT domains size
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8433763322538796220=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8433763322538796220==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lBSzX1QQnsA="; charset=UTF-8

--lBSzX1QQnsA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, razvanc, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail
=

to look at the new patch set (#2)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by razvanc


Change subject: openvpnserv: =
pass correct NRPT domains size
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

openvpnserv: pass correct NRPT domains size

Previous c=
ode assumed that the input NRPT domains list consisted of
ASCII characters =
only=2E When IDNs were passed as UTF-8 the size of the
converted wide chara=
cter MULTI_SZ list was calculated wrong, leading to
extra data being read a=
nd stored in the Registry=2E

Discovered and reported by BreachX Zero Day L=
abs, using Typhon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

Re=
ported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Pari=
kh <vivek=2Eparikh@breachx=2Eai>
CVE: 2026-78221
Github: openvpn/openvpn-pr=
ivate-issues#162
Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
Signe=
d-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887
Message-Id: <202608=
31184721=2E3391-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38853=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=
=2Ec
1 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/1887/2

diff --git a/src/o=
penvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 36dfb8e=
=2E=2E0c6e23f 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvp=
nserv/interactive=2Ec
@@ -2735,11 +2735,13 @@
         dom_size =3D (DWORD)=
domains_len + 2; /* len + the trailing NULs */
 
         wide_domains =3D =
utf8to16_size(domains, dom_size);
-        dom_size *=3D sizeof(*wide_domai=
ns);
         if (!wide_domains)
         {
             return ERROR_OUTOF=
MEMORY;
         }
+        domains_len =3D wcslen(wide_domains);
+        =
dom_size =3D (DWORD)(domains_len + 2) * sizeof(*wide_domains);
+
         /=
* Make a MULTI_SZ from a comma separated list */
         for (size_t i =3D=
 0; i < domains_len; ++i)
         {

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1887?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
Gerrit-Change=
-Number: 1887
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2E=
de>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: d12fk <heiko@openvpn=2Enet>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--lBSzX1QQnsA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnserv: pass correct NRPT domains size<br><br>Previou=
s code assumed that the input NRPT domains list consisted of<br>ASCII chara=
cters only=2E When IDNs were passed as UTF-8 the size of the<br>converted w=
ide character MULTI_SZ list was calculated wrong, leading to<br>extra data =
being read and stored in the Registry=2E<br><br>Discovered and reported by =
BreachX Zero Day Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher=
: Vivek Parikh=2E<br><br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breac=
hx=2Eai&gt;<br>Tested-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<=
br>CVE: 2026-78221<br>Github: openvpn/openvpn-private-issues#162<br>Change-=
Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8<br>Signed-off-by: Heiko Hund =
&lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887<br>Message-Id=
: &lt;20260831184721=2E3391-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38853=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 3 insertions(+), 1 =
deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/87/1887/2</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv=
/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 36=
dfb8e=2E=2E0c6e23f 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -2735,11 +2735,13 @@</span><br><span>         dom_size =3D (DWORD)domain=
s_len + 2; /* len + the trailing NULs */</span><br><span> </span><br><span>=
         wide_domains =3D utf8to16_size(domains, dom_size);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        dom_size *=3D sizeof(*wide_do=
mains);</span><br><span>         if (!wide_domains)</span><br><span>       =
  {</span><br><span>             return ERROR_OUTOFMEMORY;</span><br><span>=
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
omains_len =3D wcslen(wide_domains);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        dom_size =3D (DWORD)(domains_len + 2) * sizeof(*wi=
de_domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         /* Make a MULTI_SZ from a comma separated list */</span>=
<br><span>         for (size_t i =3D 0; i &lt; domains_len; ++i)</span><br>=
<span>         {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail">change 1887=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
9ee4b6d1c21bec3873dc6a474bd65d043b5370c8 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1887 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@g=
reenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--lBSzX1QQnsA=--


--===============8433763322538796220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8433763322538796220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8433763322538796220==--

