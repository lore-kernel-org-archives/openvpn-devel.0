Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB22CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYh3/EaXaQsDMlAkoOCCVNnm/s4G0kt4rlYIHKBUb0g=; b=j0SJpBelGhvR1elYkh58m/C2ic
	YojkYBFCfOVyU9Nmn2jQysMjD/y6jeBNoJaUhdJ7FWUOl1wDxHrV4+aSewSgjci3Jo1OM32Zjl/DY
	E3ySQxzvS1zIloQji4oU4VATlYOKbujAe77eSOxFlvWJdjlN6MSsyc+2NHXhXBAhTy2E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBzuQ-0003rE-R5;
	Wed, 30 Sep 2026 19:24:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBzuO-0003r8-Rx
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 19:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vl+91xwuZX285YQSH7092YRxdAjwQb8Ksm92jmmK3PQ=; b=TTOWxebmkgKGIdz24taqIxKAIV
 nneoR8zmoC/93J6LAKNOIy5wUEDSrHtLIciErSP41MLpqX8WJHwFS5aMvsi5xXakTIdJWnf5BDcIw
 PWVzxrm5PqF/3fdhmB/5EJbrjVa1ZW3DlpURvrKviJA1bbAR7F4I+4VK2AuYH0sb48Jc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vl+91xwuZX285YQSH7092YRxdAjwQb8Ksm92jmmK3PQ=; b=d
 lEDg5cwz0vdVasALHH11XDMsJ3b6L6fR4VDgoOIG9Ndtwu2xgRv7LfnmFV1XmdK8iAglmMq5bp0Nx
 qrIG9p5xRY1SaO0ekK07VQCSeL84XSVyhVfa458KmgKM+4ePELtkzI6BJbM/crewxpcgzmCQDtO3d
 AFZ8rGAoKLOO5G2o=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBzuI-0005Lw-QL for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 19:24:02 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b00a0ac65so681470f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790796232; x=1791401032; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vl+91xwuZX285YQSH7092YRxdAjwQb8Ksm92jmmK3PQ=;
 b=QXd9O2qPqtI6Cvypl5zlwYov+xlZdZGUs5uBwJ5fsUs+zO+bXltUCIg+ljH7d1NAO0
 B1Qu06FBBR6l/GA4ooPVn0C74tERgCDYF2jNR4NgVHjw+mS6iQ59qp3/qHiRAH85jB1v
 onuNE7Jz50eXfo9mD1yVWO2Wb4MgFPA+mMfsG7BcwTcNYntV78oqVw+WvsQSyTiQv/L3
 7YJOA6Ub+7sbipoY+lgTw8ltz8+tI86tYu8RP3t/UKmm8kexFxihOh10/8Srsk/oG40f
 BZHL5gm8AxrP3zSH/ExYt0xP2TjUpgGoOfryaFouzOpOOnnWBIyRSV7CJz3B4KMEZZ27
 3qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790796232; x=1791401032;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vl+91xwuZX285YQSH7092YRxdAjwQb8Ksm92jmmK3PQ=;
 b=R5U8RxBeAjCJeEHd5PHanRyotv5dO5Cate+zZOHpJrqm7GYgYnyfRm86HJEuzqKQPW
 tad15+lG5OeHO3fDuMMpu+quh/S4ajck66LIeFbMEGwoPi+8L0pEMRWf5ovK9++S2IEY
 /3Y+2oFewrovUMWGNMTXZ7O22ij9sisWeWMi3rRb0DXi/+EvD1Fpl1Ebo7366W4w0dEQ
 Zi+FxvlbIqFSjRzabQh3kUwdxspM3UZxFQHKlOgW7oWiHugqajaiL5bjHcCwHTGpalKX
 y+MqFtqKnotPcGwqiclY013MAqbRdX/R68no0F834LdvizRMy5lfX6t/WvDnxWnHzzkD
 7F6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUHygT3/4QFjGbCkjo1WAKgEeqyyJH4r+fO07/zoeSQHpWXznQqariGePI9j8zKjsmH2tuGHwTGUusKkCJ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLURjWHqf9y7bife/15j03SEsXmnfDOvy/HBd6iIwX8aSWFUJdK
 zb6QrIhfUUYK0IKgIcNQCPsE8/myv1bFXwnVj9p6YrX06qRk8t9rLxdsQegjyt7Bts70coOD/kB
 4f9QaqSVvXTquaBqVCDQwBM1t7n86rv93IhCJZJw1vaich5sisk8Ip4+r4Weq13fNj68H
X-Gm-Gg: AYBFou2zLLssIye9DlUFvn5b2DC4BajxMDjQj9w1mq6wlzIuCcYD3msW0LnfeiaEt0V
 spF45Vhi59bsZgwTmyebj8hEnQGYIFsiWfMpHSg4CqCu+w/KWt5mBvhhRSNBXom/gO+/6s41kSA
 KwMfKND2MvakWgAk5tazKjWZOz39t2VFQ9MC6/Bodu9ETyaA/+VgjcVqzOILvE+AGruyKvnxKn9
 ACI8dB4QX6QH6q7UJiWFYCXp9bxTyLzdjENQn1ONCvF/DGLC6iiWQ4RcApO8ImWSkRgo7b5JlUT
 8Pls9euO+sdf8M7iku5jvZe+mfI3NMlo6Gxdc/mIm+h1KqlamQw03NoI16hs2c/EtcYWU07gmNC
 MvxRmP9hD7PzaEi7VLNLLeWxZ2eQWP4NzX5TQLE6qJIDKZp/Tm4uudVEVc6jq91aMErMV/huMXs
 uLLR6PVfvCFr7LdaxIsSRFbiZ045+Da9re8lftZ+v5wx/LhsBWjrwM34h3wkiOc2foE2+yc9sgh
 Cj93ALCoG1vWsxi48t+fqB9NbmWaq8Ygff88wv+bGK7x4RcQ1XueBFWNxX5OfVXoIinej/wuu/s
 j31MRpki9lEIUN81hKaxzP5TV8xT6alSSYREBZ9c8WVyRIZyRBeEa/aTKPdXNOQ53zwzdV0=
X-Received: by 2002:a05:6000:26c8:b0:488:8cf8:14 with SMTP id
 ffacd0b85a97d-48b049b2971mr3313362f8f.0.1790796231759; 
 Wed, 30 Sep 2026 12:23:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff95esm1218999f8f.12.2026.09.30.12.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 12:23:51 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 19:23:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 2bcda4dcca45f2ff779b0aa30ae989696ccd01d3
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 19:23:48 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f2d247fe1f65704b89258d94950564f8c6f72ea-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBzuI-0005Lw-QL
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2984250050218861694=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2984250050218861694==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PY/QycXRZZQ="; charset=UTF-8

--PY/QycXRZZQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi =
session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 31:

(9 comments)

Patch looks good overall!

One que=
stion before this lands: the lookup key is now attacker-chosen and cleartex=
t: the session id is in the plaintext header even with --tls-crypt=2E Reach=
ing another client's instance previously needed IP:port spoofing, now it ne=
eds only observing the session id=2E With --tls-auth the HMAC key is shared=
, so a hostile client can forge packets into a victim's tls_multi=2E Probab=
ly not new in effect, but the precondition changes=2E Can you add this part=
 to the commit message?

Rest of the comments below

Commit Message:

PS31:=
 
TCP behaviour changes here and isn't mentioned - see mtcp=2Ec=2E

"does n=
ot make it really easier to exhaust all pending session": the ceiling is un=
changed (connect-freq-initial), but the per-source-port bound is gone - one=
 IP:port can now hold unlimited pending sessions=2E Worth making it explici=
t, I think


File doc/man-sections/advanced-options=2Erst:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/c344cd34_caab9864?usp=3Demail :
P=
S31, Line 40:   By default, all three tables are sized at 4 times ``--max-c=
lients`` buckets=2E
Stray blank line=2E Also comma after "If specified"=2E
=


File src/openvpn/mtcp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/7fc483cc_dc233b69?usp=3Demail :
PS31, Line 63:                 "M=
ULTI TCP: new incoming client address matches existing client address -- ne=
w client takes precedence");
This changes TCP semantics: a new connection m=
atching a stale instance used to win unconditionally, now it needs matching=
 cert+username or it's rejected=2E Same outcome for the usual reconnect cas=
e, but it should be in the commit message or a separate patch=2E


File src=
/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/=
33118e5a_9b01b355?usp=3Demail :
PS31, Line 329:     /* Copy buffer, to a tm=
p buffer, so that reading the sesison does not
s/sesison/session/


http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/142e99fb_d7ceff30?usp=3Dema=
il :
PS31, Line 335:     (void)op;
`buf_advance(&tmp, 1)` instead - `op` is=
 only read to skip it=2E


File src/openvpn/multi=2Ec:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727/comment/8f666c11_5c3af584?usp=3Demail :
PS31, L=
ine 437:         if (mi->context=2Ec2=2Etls_multi)
Unrelated change: droppi=
ng the DCO guard puts `rx-peer-id=3DN` on every instance log line=2E Log-on=
ly (status and management don't use this), but noisier for everyone - own c=
ommit?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/276a1303_ad=
63138b?usp=3Demail :
PS31, Line 2473: multi_check_dest_addr_allowed(struct =
multi_context *m, struct multi_instance *mi, struct mroute_addr *real);
For=
ward decl 700 lines from the definition - move the definition up instead?

=

File src/openvpn/sid_hash=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1727/comment/d232c564_7886b01b?usp=3Demail :
PS31, Line 25: #include "sessi=
on_id=2Eh"
Missing include guard=2E Double inclusion fails with `redefiniti=
on of 'multi_hash_sid_add'`=2E Works today only because each of the three c=
allers includes it once=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727=
/comment/f6a39389_12cf2385?usp=3Demail :
PS31, Line 31: multi_hash_sid_add(=
struct multi_context *m, struct session_id *sid,
`sid` can be const=2E



-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59ecd119331b198792ad=
1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-PatchSet: 31
Gerrit-Ow=
ner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 30 Sep 2026 19:23:48 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--PY/QycXRZZQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>ordex has posted c=
omments on this change by plaisthos=2E</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Patch looks good overall!</p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">On=
e question before this lands: the lookup key is now attacker-chosen and cle=
artext: the session id is in the plaintext header even with --tls-crypt=2E =
Reaching another client&#39;s instance previously needed IP:port spoofing, =
now it needs only observing the session id=2E With --tls-auth the HMAC key =
is shared, so a hostile client can forge packets into a victim&#39;s tls_mu=
lti=2E Probably not new in effect, but the precondition changes=2E Can you =
add this part to the commit message?</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Rest of the comments below</p><p><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View =
Change</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1727/comment/a4bbc704_852bd51a?usp=3Demail">Patch Set #31:</a> <=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">TCP behaviour changes here and isn&#39;t mentioned - see mtcp=2Ec=2E</p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">&quot;does not make it really easier to exhaust all pending session&quot;=
: the ceiling is unchanged (connect-freq-initial), but the per-source-port =
bound is gone - one IP:port can now hold unlimited pending sessions=2E Wort=
h making it explicit, I think</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File doc/man-sections/advanced-options=2Erst:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1727/comment/c344cd34_caab9864?usp=3Demail">Patch Set #31, Lin=
e 40:</a> <code style=3D"font-family:monospace,monospace">  By default, all=
 three tables are sized at 4 times ``--max-clients`` buckets=2E</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Stray blank line=2E Also comma after &quot;If specified&quot;=2E</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mtcp=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/7fc483cc_dc233b69?usp=3Demail">Pa=
tch Set #31, Line 63:</a> <code style=3D"font-family:monospace,monospace"> =
               &quot;MULTI TCP: new incoming client address matches existin=
g client address -- new client takes precedence&quot;);</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This ch=
anges TCP semantics: a new connection matching a stale instance used to win=
 unconditionally, now it needs matching cert+username or it&#39;s rejected=
=2E Same outcome for the usual reconnect case, but it should be in the comm=
it message or a separate patch=2E</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
27/comment/33118e5a_9b01b355?usp=3Demail">Patch Set #31, Line 329:</a> <cod=
e style=3D"font-family:monospace,monospace">    /* Copy buffer, to a tmp bu=
ffer, so that reading the sesison does not</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">s/sesison/session/</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment=
/142e99fb_d7ceff30?usp=3Demail">Patch Set #31, Line 335:</a> <code style=3D=
"font-family:monospace,monospace">    (void)op;</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">`buf_advance(&am=
p;tmp, 1)` instead - `op` is only read to skip it=2E</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727/comment/8f666c11_5c3af584?usp=3Demail">Patch Set #3=
1, Line 437:</a> <code style=3D"font-family:monospace,monospace">        if=
 (mi-&gt;context=2Ec2=2Etls_multi)</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Unrelated change: dropping th=
e DCO guard puts `rx-peer-id=3DN` on every instance log line=2E Log-only (s=
tatus and management don&#39;t use this), but noisier for everyone - own co=
mmit?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727=
/comment/276a1303_ad63138b?usp=3Demail">Patch Set #31, Line 2473:</a> <code=
 style=3D"font-family:monospace,monospace">multi_check_dest_addr_allowed(st=
ruct multi_context *m, struct multi_instance *mi, struct mroute_addr *real)=
;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Forward decl 700 lines from the definition - move the definiti=
on up instead?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/d232=
c564_7886b01b?usp=3Demail">Patch Set #31, Line 25:</a> <code style=3D"font-=
family:monospace,monospace">#include &quot;session_id=2Eh&quot;</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Missing include guard=2E Double inclusion fails with `redefinition of &#39;=
multi_hash_sid_add&#39;`=2E Works today only because each of the three call=
ers includes it once=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727/comment/f6a39389_12cf2385?usp=3Demail">Patch Set #31, Li=
ne 31:</a> <code style=3D"font-family:monospace,monospace">multi_hash_sid_a=
dd(struct multi_context *m, struct session_id *sid,</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`sid` can be=
 const=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792a=
d1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 31 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Wed, 30 Sep 2026 19:23:48 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--PY/QycXRZZQ=--


--===============2984250050218861694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2984250050218861694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2984250050218861694==--

