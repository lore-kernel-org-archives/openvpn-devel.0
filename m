Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C6606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i5feAspx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lf67EPTR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mww311QT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LfQiUmDp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=piDRG2v4Np6kSRC580BkAkt68a18vBt1exUY14XDEp0=; b=i5feAspx+nDnOUbudIlvy0M3Xa
	+KZmUjfiSibdkpNAUAmiJlRw3Fx2n1OvUhrYJDqmlA7W1V3ZSkxoBS34C59pB+s9Mf2Eu1WmvcmcI
	ufh+jSuIvAb4ydYEo2X9kHtTAhYaqczaIQ2M4+n7JZ1Vo9ZvjiFX2Xy+wd4EAyNSLRjU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM6GE-000000003a2-27p1;
	Wed, 28 Oct 2026 16:12:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM6GD-000000003Zv-0pFI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:12:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=67pBM2IPZyL4JOPg56BU6HgqRUXOeXdfU/VL2MhpBnE=; b=lf67EPTRWfZ65PyQkBXs4seOWf
 q2K9BLQUsHZT0rq5LiZTn97vu0wBAjbSbPi6xoU5vwSNLDwBcUjyuXNaRo6MdAUqsODlKVuOZfARw
 BPngKoqahEmrmaPViBD69q5QAqVZwcBq5QWy+kbx75Ka6vBOAII6CzP+k5uGHoc/Gu4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=67pBM2IPZyL4JOPg56BU6HgqRUXOeXdfU/VL2MhpBnE=; b=mww311QTE/zBsvPZez2Jpi9MbY
 7pG4X6HnNdMBliMevs2XeKTUNYPpENdxu5mqQjNGfXpP8XIe/5vHiR8bp2gDH83cmEJAI4G2Xl9Y1
 dhVBJB9E5TFZSZWVUEU1X8fu+X2Kz1pakG3w0lmwJGf/cQOmrJLq+6Cs5LJDnI4tQOwM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM6GC-000000004Zl-1lt0 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:12:21 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so8770185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793203934; x=1793808734; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=67pBM2IPZyL4JOPg56BU6HgqRUXOeXdfU/VL2MhpBnE=;
 b=LfQiUmDpo37hJCCaN3NINofLT3xQJ1xB/v4IeL5DvTIxxPG4aL6fBhE7qlhAfH71Xv
 G3rcBJuJlyDrOe1wAoy2OuHzZnliqJj25Rp/nN5BPnQQ57pqF1NUYedUKXbG8pXbaqNT
 MFaK+rWDK5q0NPwno04LRXLwTLOvAtEJuy2+1t0omlnjn8Rn1mbcn4OIfg5e1Rc3WfKQ
 hjNFYqaf3GBV1JNm1eXXWi82FyCxRri3o/67z6uYoXt//GwfYhOWBa1o3xZl9+qRQSWU
 y8yAa6zPOItBtFG+blSTXtBIuX3MB5L1+jk80P4zNK3y3kAzmaps0hgNXyo+F/eAY9kU
 1qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203934; x=1793808734;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=67pBM2IPZyL4JOPg56BU6HgqRUXOeXdfU/VL2MhpBnE=;
 b=yxHrijQ5a92MeSZzl0VgSOnAxmZ3oRmsZ+R1/K4lMBWU2dABurUqM/GbNIVnmGmp+m
 L5mXmwcAt3w+NZz81HnN8MPLg0MieHbCJqtgjSa/3qX3DFdMN+GXB05zx1GrwjSF3z7n
 g/VadY/3PNWs9GMMo3Zc+i5lshAHs433hh6k0if/GAmdkYt9kFt6vUgadMfNw/98hdx7
 ffVg2fFQzNs+y4Vh3sz45uJjDJq1M7JmuK9gbgJJcQY1MrODJyJGr8wmqUSCZB+HWvQ2
 cuBYo36x05uMDnoirZImKGxjRA8iz0knFgyKCXF4DbkzVtCGsCc+j/2fquZBvEV+WeVl
 ulLw==
X-Gm-Message-State: AFq9FYKwVrzhZoOPYNZOR5dbCcnjr78nSs+X+He7bSfhyBo7H0BXlloz
 0xlK9ukmF/m39w7d3I6MQuP8fVmW/dHIxBmkT3lZ7Cclee/r9AWqIFV4Oj2FXjboMYzyq8r77MM
 y35MYLUNpeSuesScc+D6Kvgm7VDG9mmVdRmHYUIzHhWcAaU9WI4xzYVsTMCT+djGLfhGFII4uCh
 Jd3Cm0Gw==
X-Gm-Gg: AYBFou35okk6qH5aLliNQbmXkArb88UW/DFpMiYPRGVup8CeNgz+2aKnhWwGXnjlU6x
 x+zxJFAI8/tyDGjq6Hdv45S4JD+6SSui1LV9ahuGzUWJzlejmCtUQk8W9Yvfw7Zj/hvitGhU6yJ
 Eb2TRIjrjxsMRtA6BCieJrmSeE9e79Aj+HyATNJWyShlWzSJ6TaUZM9KJwnrD7eTVHEtWuARE03
 3r7K5BkYpey0z4JYRN3ujj5L3nPc5Umn3CyVsMQS2gU/sKIGaKAxK9ZB7/XGQrcF1LfXWKYn9Zu
 Y4hKgMulicwYwr6fRQvtM1gYVVavCtJIJq2LQ6bew6cZYXazXlBo8hebMgfU5A1g7f5A2wKvtcj
 YnK0oVdZW0oUm1soFqoRrlAoCiyEF/JN4RV6Z9k2dGzMdpJxaEn38Gs8Md3+5thG5dqzeoCItgq
 dR7IIPyeP0L0jSMxSMzIcuD9PStOTB2GYNbakW0mGWKqb9KH8SdKJqq5HT2/Od10T+Yvn1sMrxe
 D4gHQuNX6tbl2DknMmjJ8BEDFLaCEy7Grnxr99g91ckRNtpQqvM+dxyzmjOBpe/Xl1WnDsPUyCA
 qae6y1gMWbP1Ln4h6wSiNiqblZ7NZrYDzJkNYGDOJQnFQOK/ZMqMzjrWL3syqN6h+SEDpfnE+iM
 YUtFgFfiTRvVFzUJNUm7fcjCWT2WcFPL2nWNaVGDlL6lMItC5YvCkhT8+y9qUGJ9eeuxqPKBs4k
 q94GODv9jLfoijIFY=
X-Received: by 2002:a05:600c:6989:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a9640f38bcmr68836285e9.1.1793203933619; 
 Wed, 28 Oct 2026 09:12:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f05f168sm43242475e9.4.2026.10.28.09.12.13
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:12:13 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 16:12:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
X-Gerrit-Change-Number: 2064
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2064?usp=email>
X-Gerrit-Commit: f332dfdec52be14670fd45c63c66ea0d9f1e19c0
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjAzOTMxMDAwLklhZDUxYjJmMzFlNDIxNWM1OGUxNjBjYzYyMzk4MzYwMTVlYTRkM2NmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c6625d8620f56d1708cf99fada77f32ff9171d9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM6GC-000000004Zl-1lt0
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4919637646189491542=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4919637646189491542==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ztzTtCuV3eU="; charset=UTF-8

--ztzTtCuV3eU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2064?usp=3Demail )


Change subject: Track number of =
assigned peer ids and use it for max-clients check
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Track number of assigned peer ids and=
 use it for max-clients check

In the past we used the real address hash as=
 proxy for the number
of connected clients=2E TCP connections do not really=
 need
this and we might remove adding them to this hash in the future and
U=
DP connections only really this later in the connection establishment
and t=
hen only for peers that are of capable of DATA_V2=2E

Instead have a simple=
 counter that is kept up to date when a peer id
is assigned and freed=2E Th=
is also allows this to be decoupled from
the real addresses hash=2E

Report=
ed-by: Ar-maan05 https://github=2Ecom/OpenVPN/openvpn/issues/1127
Github: C=
loses OpenVPN/openvpn#1127
Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4=
d3cf
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/mul=
ti=2Ec
M src/openvpn/multi=2Eh
2 files changed, 7 insertions(+), 1 deletion=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/6=
4/2064/1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index =
e302a81=2E=2E82757f4 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/m=
ulti=2Ec
@@ -621,6 +621,8 @@
             {
                 m->max_peerid-=
-;
             }
+
+            m->assigned_peer_ids--;
         }
 
     =
    schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -74=
9,7 +751,7 @@
 
     mi->context=2Ec2=2Etls_multi->multi_state =3D CAS_NOT_=
CONNECTED;
 
-    if (hash_n_elements(m->hash) >=3D m->max_clients)
+    if=
 (m->assigned_peer_ids >=3D m->max_clients)
     {
         msg(D_MULTI_ERR=
ORS,
             "MULTI: new incoming connection would exceed maximum numb=
er of clients (%u)",
@@ -4219,6 +4221,8 @@
     {
         m->max_peerid =
=3D mi->context=2Ec2=2Etls_multi->rx_peer_id;
     }
+
+    m->assigned_pee=
r_ids++;
 }
 
 /**
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh
index 5db7147=2E=2Ecc7ccd3 100644
--- a/src/openvpn/multi=2Eh
+++ b/sr=
c/openvpn/multi=2Eh
@@ -174,6 +174,8 @@
     uint32_t max_peerid;          =
     /**< highest currently allocated peer-id
                             =
            * and maximum allocated/valid index in
                        =
                 * instances */
+    uint32_t assigned_peer_ids;        /**=
< Number of peer-ids that are
+                                        *   =
currently assigned */
     struct hash *hash;                 /**< VPN tunn=
el instances indexed by real
                                         *   a=
ddress of the remote peer=2E */
     struct hash *vhash;                /**=
< VPN tunnel instances indexed by

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2064?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
Gerrit-Change-Nu=
mber: 2064
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--ztzTtCuV3eU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Track number of assigned peer ids and use it for max-clients c=
heck<br><br>In the past we used the real address hash as proxy for the numb=
er<br>of connected clients=2E TCP connections do not really need<br>this an=
d we might remove adding them to this hash in the future and<br>UDP connect=
ions only really this later in the connection establishment<br>and then onl=
y for peers that are of capable of DATA_V2=2E<br><br>Instead have a simple =
counter that is kept up to date when a peer id<br>is assigned and freed=2E =
This also allows this to be decoupled from<br>the real addresses hash=2E<br=
><br>Reported-by: Ar-maan05 https://github=2Ecom/OpenVPN/openvpn/issues/112=
7<br>Github: Closes OpenVPN/openvpn#1127<br>Change-Id: Iad51b2f31e4215c58e1=
60cc6239836015ea4d3cf<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg=
&gt;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>2 file=
s changed, 7 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/2064/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><spa=
n>index e302a81=2E=2E82757f4 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -621,6 =
+621,8 @@</span><br><span>             {</span><br><span>                 m=
-&gt;max_peerid--;</span><br><span>             }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            m-&gt;assigned_peer_ids--;</span><br><span>         =
}</span><br><span> </span><br><span>         schedule_remove_entry(m-&gt;sc=
hedule, (struct schedule_entry *)mi);</span><br><span>@@ -749,7 +751,7 @@</=
span><br><span> </span><br><span>     mi-&gt;context=2Ec2=2Etls_multi-&gt;m=
ulti_state =3D CAS_NOT_CONNECTED;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (hash_n_elements(m-&gt;hash) &gt;=3D=
 m-&gt;max_clients)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (m-&gt;assigned_peer_ids &gt;=3D m-&gt;max_clients)</span><br><span>=
     {</span><br><span>         msg(D_MULTI_ERRORS,</span><br><span>       =
      &quot;MULTI: new incoming connection would exceed maximum number of c=
lients (%u)&quot;,</span><br><span>@@ -4219,6 +4221,8 @@</span><br><span>  =
   {</span><br><span>         m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etl=
s_multi-&gt;rx_peer_id;</span><br><span>     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    m-&gt;assigned_peer_ids++;</span><br><span> }</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/src/openvpn/multi=2Eh b/=
src/openvpn/multi=2Eh</span><br><span>index 5db7147=2E=2Ecc7ccd3 100644</sp=
an><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/=
multi=2Eh</span><br><span>@@ -174,6 +174,8 @@</span><br><span>     uint32_t=
 max_peerid;               /**&lt; highest currently allocated peer-id</spa=
n><br><span>                                         * and maximum allocate=
d/valid index in</span><br><span>                                         *=
 instances */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt32_t assigned_peer_ids;        /**&lt; Number of peer-ids that are</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
              *   currently assigned */</span><br><span>     struct hash *h=
ash;                 /**&lt; VPN tunnel instances indexed by real</span><br=
><span>                                         *   address of the remote p=
eer=2E */</span><br><span>     struct hash *vhash;                /**&lt; V=
PN tunnel instances indexed by</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">change 2064</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia=
d51b2f31e4215c58e160cc6239836015ea4d3cf </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2064 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--ztzTtCuV3eU=--


--===============4919637646189491542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4919637646189491542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4919637646189491542==--

