Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CD606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AmJQzDLm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ca7Gb8SB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dW87m7y9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TmXnC8U8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jeI+DQs3Ur+Q/TuzHRgtMd8KxsWTYni5METC4BYQTvU=; b=AmJQzDLmHqMGLyKRRZkpfDPeuy
	3aahvzonuG/VYQ9l0GcJWb3hBtGY0UsOxyHQqfM/OJBKxZaINeygQbDOAsdqnteu8v6ZD7GgsnZA7
	HBz/+RXKt8VwU2SErw85pIBETC+haG26q+bqBmTBN3KIN735gMUSsww+2n50scaHvUKA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWG6u-000000007wC-1p35;
	Wed, 25 Nov 2026 16:44:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWG6s-000000007w6-1vJq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d+mmejFyNgEvMt44i0Ev3ighLNLU3T3b+m5hoTgHH+g=; b=Ca7Gb8SBF9OdbqmVo4utsjYkVl
 nPnILsQ/ju/iS20zidrtxen3u6v3qFdbQ2lHDMMzFL3hHCP3mkV/fiwtBYtyNc4l3co82aw79loCs
 loYYvp5peGKtSdXRMNtUGyw4c4czKqqYLGe03kPlgNt9VI7miNgGmuzNaV1TU1CUv0Rw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d+mmejFyNgEvMt44i0Ev3ighLNLU3T3b+m5hoTgHH+g=; b=dW87m7y9J2k+QLqWaxuurIftZP
 CqD/TjSvrdGaFrG4rl4767nRnfl2UzA7F04O5zNVVyIovnnkV+/PPjzFfvyp5HZdchFrDQdQVvXAR
 Utn/b/3TY03jrxAmBbYUlwKJyi1vmGK0AaMoE06OiA0oq4DdiIDvt2S7NBEkuwvz2UZ0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWG6q-000000007Uu-2PyX for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:42 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so64877835e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795625074; x=1796229874; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d+mmejFyNgEvMt44i0Ev3ighLNLU3T3b+m5hoTgHH+g=;
 b=TmXnC8U8LHUXd8Z/CfLeajG6c8GP/R8Uub50Q1pljEK5m4U+TpLOrCX2sFJMDHh8mw
 u8bL/ty5HILuqtxOtZuZPAK6BR8O8Q4oCxHDSJzpgWtg4LnNtvgvOgHoWP/lV1cZXO/l
 d0HamupUpbfjll3RmB27k/iBNGUh7S58gCD7aNSCe7/S74CG870p0cPCV2E+oZu9uoPW
 zeetUfMMssoKTDSAtmutohurLTPVdJfCQgKvxJGfDFt2kn0GcdJkXDSKYS1SehT4iuOF
 e8G4Y0GHJPH986JkRm8FWoVp17lJ1N/hnvbiKcjVP6WODrMYi6kG4AN2UC8/C005i+0y
 bNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795625074; x=1796229874;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d+mmejFyNgEvMt44i0Ev3ighLNLU3T3b+m5hoTgHH+g=;
 b=yNe9cORmop3LgnklQblMTDE+72Gj3BGcSzQdDE64SMkgSz6oHEc5ElH5Ih4Em2wUDR
 FLqSYinxItY90U4q+rjDkpS6otRre3HpfHmoK8JH9/uyzeDDeJbz0KARhtHHparXoUR9
 gvEBeHfXvwGbCQAsWBshEWrICJFohrDZv9ENwexm1G5HgAeR3i5tXfjqueR7p1GMcouK
 ZeLRwRHKPQDESArTFERA86DF7pRom3ndcW77oZMWGsKi4gIzBaL+IFgv/OwrZ3TpDcg5
 CehN2+0Wj9RjLLGbcmsAOZktgRpP4z1Cwd2zBo1cvv7XR7wPvC1aBcyeu3yQarhT/LBG
 FcLw==
X-Gm-Message-State: APuU4Z86OSMCi2q9j5Vll5PkXS/hc616/PEE23z/E0pE+mo6oOTMfVI8
 LRRCS5mCQ5X8DFksTqCzKZmqYrS8aYB0YYJgNM2Tp0I4xwzktNNHCriExB+LBLeQJuEzNm6Mt5L
 c6UPKk+HGEdUb+wRa9dRDz7vrzjIgFGmolodgSO0emQK2Ak5OhQyysFLFo2DLYvPRZD1E
X-Gm-Gg: AZFdTZfNtmbkCuIpNV+yPxLO7P/ACj7kORRjfKeuXo5A1kr+RTXOUSodCWgf1alPlQI
 KH3d2UaN4nHuql4ctX7OSe39Y6EzaDckTQtjwc8y1AXJR6D7tjcrSuzkkPzlFoEcBusRb4Gccwy
 yGKpMuwkUIFh6gm3JuKjJiolmCJXpFMawsBpUREaAgMWmUhi+qB9MHfNUHMDSJ3Q1zOJ0z3a9ac
 e5m+6aZoWsrb8M6lF9qYsGin6yyiPIejbd5uWWAQ6WVL3gw6q3KRJjJ5h1YuKfDxC0JVUPbiCmO
 Pa0sTDu82a81ViJwYUDEaZ7QrP+G99ai5KnJe6o80mQEDrZ777wJR9k6UgJZk71IpKnyo+7tQ/0
 7jiHndC3nu1pbGVE5gOSjatzUJZa6DBrBxIolWlC0/bRYukFaLXxIUGHtLldEwcc4h65EbuscB3
 t1BHs5feuUfvfFUGl4FIXW8p8EOjn5nEImgr9BXt0xS/HF85s8I0n6y29KrzQto/55USEPWFtLu
 maumJuvvrHIX27uEH6WxDZErrFbUqz57N5ZoG2ZjsN1ChzIjyWJI8g5N2TJCzqbRNdi/KdGhumT
 PW2AiTjntavi6/NXbqwjJqUGt9q10NUJLCfq41rDMqlEJ15yItwqdT/w713ogmaIQ0Qo6yJUYwO
 TCT46n4HTHPKmvvCKtXX4fq4J5W/2oKv1wBcDYVgK5D3cz2XRwkcXzs6KtXp6p8Fm5sTSYi9/Yr
 ahjTnvJbqo8QoYMqw=
X-Received: by 2002:a05:600c:5246:b0:4bb:6de4:2f7c with SMTP id
 5b1f17b1804b1-4bb8881c5bdmr385816005e9.20.1795625073893; 
 Wed, 25 Nov 2026 08:44:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm34316605f8f.47.2026.11.25.08.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:44:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:44:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
X-Gerrit-Change-Number: 2337
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2337?usp=email>
X-Gerrit-Commit: c73bdd7387f097c1ffb421456a21a923fcb01f8d
In-Reply-To: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
References: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTI5Nzg2MDAwLkljYjkxM2Q2ZTg5MDYwN2M3OWE0NWEwZTYzZTlhMWJhNDQxNTFlOGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5119f530de1d6d8eac64af28c15af4e6f8dc2c9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWG6q-000000007Uu-2PyX
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: list: drop
 redundant check in hash_iterator_next()
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
Content-Type: multipart/mixed; boundary="===============8322273801767619959=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8322273801767619959==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="irZu7DIscbw="; charset=UTF-8

--irZu7DIscbw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2337?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: list: drop redundant=
 check in hash_iterator_next()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

list: drop redundant check in hash_iterator_next()

hi-=
>elem is set from b->list, which was just checked to be non-NULL=2E

Change=
-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337
Message=
-Id: <20261124142352=2E20244-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41884=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lis=
t=2Ec
1 file changed, 3 insertions(+), 6 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2337/2

diff --git a/src=
/openvpn/list=2Ec b/src/openvpn/list=2Ec
index dcd59d7=2E=2E505be30 100644
=
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -294,12 +294,9 @@
=
             {
                 hash_iterator_lock(hi, b);
                =
 hi->elem =3D b->list;
-                if (hi->elem)
-                {
- =
                   ret =3D hi->elem;
-                    hash_iterator_adv=
ance(hi);
-                    break;
-                }
+                r=
et =3D hi->elem;
+                hash_iterator_advance(hi);
+             =
   break;
             }
         }
     }

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
Gerri=
t-Change-Number: 2337
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--irZu7DIscbw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2337?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">list: drop redundant check in hash_iterator_next()<br><br>hi-&gt;elem i=
s set from b-&gt;list, which was just checked to be non-NULL=2E<br><br>Chan=
ge-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2<br>Signed-off-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2337<br>Message-Id: &lt;20261124142352=2E20244-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg41884=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/list=2Ec<br>1 file changed, 3 =
insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2337/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index dcd59d=
7=2E=2E505be30 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br>=
<span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -294,12 +294,9 @@</span=
><br><span>             {</span><br><span>                 hash_iterator_lo=
ck(hi, b);</span><br><span>                 hi-&gt;elem =3D b-&gt;list;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (hi-&g=
t;elem)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  ret =3D hi-&gt;elem;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    hash_iterator_advance(hi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                ret =3D hi-&gt;elem;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                hash_iterato=
r_advance(hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           break;</span><br><span>             }</span><br><span>         }=
</span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Demail">change 2337</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:n=
one"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Br=
anch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icb913d6=
e890607c79a45a0e63e9a1ba44151e8e2 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 2337 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--irZu7DIscbw=--


--===============8322273801767619959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8322273801767619959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8322273801767619959==--

