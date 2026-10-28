Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFD606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BMyd7kEy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ev7gsP/O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SwB9gJtP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O/llyT0a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EE03GXkiK8QCsnXTn2YVMghTANBSCS/RGe+AK4RpODQ=; b=BMyd7kEy0GFTZVyoEb1YQGGReG
	zqObTdVCHDwtTs6NIcM/TL/YGHz3B4RFKvtgk1a+VvmqHZpjXh5MBczozlPQuwEwfQOEohbEnXptL
	A1ZcMQmoiJp44kTjx9edqbXlZePQ1iB+ho5WDtXr06h5Sgx4HAgyRQ3AGMLauEYAiwCE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8QL-000000006Z5-2Mvc;
	Wed, 28 Oct 2026 18:30:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8QJ-000000006Y6-3jRM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EBSNmvU2gUxWMrc1m2KvySWSh7gCb7+Tc12fym8SJ0U=; b=ev7gsP/Oij+L41xG133hhVoA4a
 XNYKLFToIIpk+9r1RLBeqeePt2LPZwemj3sis2r2lsd2mSpvYPDDKtGRy70LGNgHvScAz04IUHW2l
 o6Jj4J+DkJq/nUYVd8AgOOeGTLGKhKWNXbTLWDWDM/RPk8mDW5r+UigoWeM2VXQ8HR7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EBSNmvU2gUxWMrc1m2KvySWSh7gCb7+Tc12fym8SJ0U=; b=SwB9gJtPCLSn5YBzgmEpxr1FMS
 1+43SYdzkA5hNDVUn3hQkjayXe0gpGJsvNgZ9z6CmvuE7LkVHeBfmbrrfAxrbzHQoF4NLkkuisr/d
 DehqQ1pmGq/jGzXTNniz668X+Hv4gOsJ60csNCNXx/T/NFQnkb/JItDduGWg7WpxHRo8=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8Po-000000000mo-3XrH for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:30:26 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1724127f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793212218; x=1793817018; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EBSNmvU2gUxWMrc1m2KvySWSh7gCb7+Tc12fym8SJ0U=;
 b=O/llyT0a9CmrZr9MQSzFCJLhOs4pXm3m1GqQuopQ9y0wHN0228tYI3JxkO1WAFoUn2
 osAk7EpS2dQQD8LQkuXbOcIK6RVs3JcdEMPq55KwOkI3zGNrNI5bHtWt9cJt8be2RtQV
 KIEJWYEe6vMPEEG3RI1Mw2O6VT8H2ATjzrJyyOCtH31leEdYe8mkyhfiP7Xlj0KzYQg5
 +z6h7HrB6ut8JWYqYh40NJLwzxrwzHEylaHHQud96GbGBnvHnuBkD2vsMymJwRxhl6+H
 2bfl+KKAnIUaTdQo+dbXSCf5ex8rHfebPUfqs0t1KS5Edgg7z30+0q796mlbbklZ9M1l
 QQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212218; x=1793817018;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EBSNmvU2gUxWMrc1m2KvySWSh7gCb7+Tc12fym8SJ0U=;
 b=s0MLHMsT/pcmIrBTgxITMxqelxC91cnri9Q8o/1li5a6kBjwN5rFujhj0d0vW0k4QB
 M+RJPbzL+juGAdedylhPIhLIf9bea/w12po6Ckc5q+oGrqySuoS9sz5gjMGFEzs4SJbE
 /HZsqL8jCtMEy/QZ9ylaKWIrU3YQRGkS/TKtrrXGWOtgGxjcQidrN8ajAsmpBpeR6HS0
 sbqjNRO5uK/6rzT9I8nHiyBDfCoImZ1YLMU9xgQYcIMsjgKaYMuMfpK/kbG6XUJPvSfs
 6bomOWCH6unC09FXMstP5xaC291AVhsPc03L4Yxbp5iE0sv24hRlbf+xNTAC/TTBtb40
 pHqA==
X-Gm-Message-State: AFq9FYLQgLDvb3Q4akw9D4a2hztyLZTZ8Z5aLnEyl/Oxvd+977mC2Z98
 qe+qwgzLblvYUaxxpcq5MIReDHsiA9A17xnzvqfua/YvzkHd7e8qW4WwoIL1hVD/PUGlTnOzrkz
 Ys+Km5MUkqHSkVXW3FzbGbNGtOe51VmihGOXmlyNLMKeZ5zWsPv8y1YChmQ+902tNvq73
X-Gm-Gg: AYBFou2p339mq4UgegN2jYQTPJl32jesazteqYkV8C01UF6C4AlSdnmZ5XIy0mSGAkZ
 70B7hZiI2LLjvlO7lWdaFwN8PDUntMCl/7ptVRsmhbFtmNrmDUU1wFPOz83X5M/tbWK6YrZM8jO
 P9l+SPahXyauKULQGQSD5nwh0nJ5bntprfTb9LfzogQCazKn8BlvkDM82cqjKqQjXt2ZemYLtQq
 i+eAxKn4pqpkjr1jIy/eTFDIlS/txdNA73uOreeRgMmcrY9lWlOFExgpeiyv+3Gpz69mM2MkfSH
 dJmbVkRw70J0hqIZFvd3hZpK0O5Xu6DV0S35PeT4H8Z9c8pE7F5m+/LRlPreofgUzN4ewC6x73x
 HA35tsJf9byJcINmcpOt1PhwAD8F88mhSPFleXWvSffkpjnS+XO5Pw1xGwVnK+fE/eXHFYkn+Cf
 1FkT0AU/tOpWvxfjzn0wzJsCcBl2yTfQ1+BV1LaewBRpCdBHHUQ2oWwCRpF4ke+J6F0TOhXaaIE
 /RLs31KTh53DPTlNNJhlLPzUUfDvhAJvxPOfYcX9abppxpOe/6rTKuXr7Rf7YMuqRuVtIWVE/NI
 LOlESjArEySB5fqqPFCEAC1Uiz3nBMBtKr18/QbzGfPMl23UhvLRQglFg0x9+706SW2ZADiU/H8
 RHvx/FqZ7w+q/OYIYg8hPu6FmYRnR/o0GxOQEPjmghHZqNI51ZZpFaSt9Gixh6gnNz4DA216fuQ
 6omOezWYs+Zvqa0CI=
X-Received: by 2002:a05:6000:29ce:b0:48c:72fc:3644 with SMTP id
 ffacd0b85a97d-48e64ba5a74mr613550f8f.22.1793212217663; 
 Wed, 28 Oct 2026 11:30:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm28162200f8f.7.2026.10.28.11.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:30:17 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:30:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
X-Gerrit-Change-Number: 2064
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2064?usp=email>
X-Gerrit-Commit: 77f133502273c61ab3be90774f23d3ab9f03b754
In-Reply-To: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjAzOTMxMDAwLklhZDUxYjJmMzFlNDIxNWM1OGUxNjBjYzYyMzk4MzYwMTVlYTRkM2NmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80c65695bdca89add59cf0de4c950fd436e500b6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM8Po-000000000mo-3XrH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Track number of
 assigned peer ids and use it for max-clients check
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7878594167111084865=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7878594167111084865==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7TcgMCms55U="; charset=UTF-8

--7TcgMCms55U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Hello R=C4=
=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

   =
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail

to look at th=
e new patch set (#2)=2E

The following approvals got outdated and were remo=
ved:
Code-Review+2 by R=C4=83zvan Cojocaru

The change is no longer submitt=
able: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Chan=
ge subject: Track number of assigned peer ids and use it for max-clients ch=
eck
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Track n=
umber of assigned peer ids and use it for max-clients check

In the past we=
 used the real address hash as proxy for the number
of connected clients=2E=
 TCP connections do not really need
this and we might remove adding them to=
 this hash map in the future=2E
UDP connections only need to be added to th=
is hash map in a later stage
of the connection process and then only for pe=
ers that do not support
DATA_V2=2E

Instead have a simple counter that is k=
ept up to date when a peer id
is assigned and freed=2E This also allows thi=
s to be decoupled from
the real addresses hash=2E

Reported-by: Ar-maan05 h=
ttps://github=2Ecom/OpenVPN/openvpn/issues/1127
Github: Closes OpenVPN/open=
vpn#1127
Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
Signed-off-by=
: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
M src/openv=
pn/multi=2Eh
2 files changed, 7 insertions(+), 1 deletion(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/2064/2

diff --gi=
t a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2E82757f=
4 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -621,6 =
+621,8 @@
             {
                 m->max_peerid--;
             }
+=

+            m->assigned_peer_ids--;
         }
 
         schedule_remove=
_entry(m->schedule, (struct schedule_entry *)mi);
@@ -749,7 +751,7 @@
 
   =
  mi->context=2Ec2=2Etls_multi->multi_state =3D CAS_NOT_CONNECTED;
 
-    i=
f (hash_n_elements(m->hash) >=3D m->max_clients)
+    if (m->assigned_peer_=
ids >=3D m->max_clients)
     {
         msg(D_MULTI_ERRORS,
             "=
MULTI: new incoming connection would exceed maximum number of clients (%u)"=
,
@@ -4219,6 +4221,8 @@
     {
         m->max_peerid =3D mi->context=2Ec2=
=2Etls_multi->rx_peer_id;
     }
+
+    m->assigned_peer_ids++;
 }
 
 /**
d=
iff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 5db7147=2E=
=2Ecc7ccd3 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@=
@ -174,6 +174,8 @@
     uint32_t max_peerid;               /**< highest cur=
rently allocated peer-id
                                         * and max=
imum allocated/valid index in
                                         * in=
stances */
+    uint32_t assigned_peer_ids;        /**< Number of peer-ids =
that are
+                                        *   currently assigned */=

     struct hash *hash;                 /**< VPN tunnel instances indexed =
by real
                                         *   address of the remote =
peer=2E */
     struct hash *vhash;                /**< VPN tunnel instance=
s indexed by

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2064?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia=
d51b2f31e4215c58e160cc6239836015ea4d3cf
Gerrit-Change-Number: 2064
Gerrit-P=
atchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>

--7TcgMCms55U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+2 by R=C4=
=83zvan Cojocaru</p><p>The change is no longer submittable: Code-Review and=
 checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Track numb=
er of assigned peer ids and use it for max-clients check<br><br>In the past=
 we used the real address hash as proxy for the number<br>of connected clie=
nts=2E TCP connections do not really need<br>this and we might remove addin=
g them to this hash map in the future=2E<br>UDP connections only need to be=
 added to this hash map in a later stage<br>of the connection process and t=
hen only for peers that do not support<br>DATA_V2=2E<br><br>Instead have a =
simple counter that is kept up to date when a peer id<br>is assigned and fr=
eed=2E This also allows this to be decoupled from<br>the real addresses has=
h=2E<br><br>Reported-by: Ar-maan05 https://github=2Ecom/OpenVPN/openvpn/iss=
ues/1127<br>Github: Closes OpenVPN/openvpn#1127<br>Change-Id: Iad51b2f31e42=
15c58e160cc6239836015ea4d3cf<br>Signed-off-by: Arne Schwabe &lt;arne@rfc254=
9=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br=
>2 files changed, 7 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/2064/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><=
br><span>index e302a81=2E=2E82757f4 100644</span><br><span>--- a/src/openvp=
n/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ =
-621,6 +621,8 @@</span><br><span>             {</span><br><span>           =
      m-&gt;max_peerid--;</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            m-&gt;assigned_peer_ids--;</span><br><span>  =
       }</span><br><span> </span><br><span>         schedule_remove_entry(m=
-&gt;schedule, (struct schedule_entry *)mi);</span><br><span>@@ -749,7 +751=
,7 @@</span><br><span> </span><br><span>     mi-&gt;context=2Ec2=2Etls_mult=
i-&gt;multi_state =3D CAS_NOT_CONNECTED;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (hash_n_elements(m-&gt;hash) &g=
t;=3D m-&gt;max_clients)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (m-&gt;assigned_peer_ids &gt;=3D m-&gt;max_clients)</span><br><=
span>     {</span><br><span>         msg(D_MULTI_ERRORS,</span><br><span>  =
           &quot;MULTI: new incoming connection would exceed maximum number=
 of clients (%u)&quot;,</span><br><span>@@ -4219,6 +4221,8 @@</span><br><sp=
an>     {</span><br><span>         m-&gt;max_peerid =3D mi-&gt;context=2Ec2=
=2Etls_multi-&gt;rx_peer_id;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    m-&gt;assigned_peer_ids++;</span><br><span> }</span><br>=
<span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/multi=
=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 5db7147=2E=2Ecc7ccd3 100=
644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/o=
penvpn/multi=2Eh</span><br><span>@@ -174,6 +174,8 @@</span><br><span>     u=
int32_t max_peerid;               /**&lt; highest currently allocated peer-=
id</span><br><span>                                         * and maximum a=
llocated/valid index in</span><br><span>                                   =
      * instances */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint32_t assigned_peer_ids;        /**&lt; Number of peer-ids that are=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                     *   currently assigned */</span><br><span>     struct =
hash *hash;                 /**&lt; VPN tunnel instances indexed by real</s=
pan><br><span>                                         *   address of the r=
emote peer=2E */</span><br><span>     struct hash *vhash;                /*=
*&lt; VPN tunnel instances indexed by</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">change=
 2064</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2064 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></=
html>
--7TcgMCms55U=--


--===============7878594167111084865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7878594167111084865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7878594167111084865==--

