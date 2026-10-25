Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A48606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z0JFXkak;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KpyO9e8m;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=C4C4+zot;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=alQ7lsLJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=BfPFF2snf6NGlBiQ4lmMj+ADj7Ls8lFjHfhQvyKX994=; b=Z0JFXkaks/4PAiOhsrFVYQxlc9
	24/ln+0cAUWegb/IB4A4M2YORIP96qUlqvrOq7nSa+Va2hBvyqnUZq+SRGlj8H0mUOPxgRFwzHhrc
	HR23Jq+2s+10+Kywcj3ZoEMrMyubJFh94fzhXbjGBUqb0HozV9kvSOBWY7Uj2bHrBeZI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL6Cn-000000000f4-2Q0C;
	Sun, 25 Oct 2026 21:56:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL6Cl-000000000el-2ZXm
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 21:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qp36a8RGpvTaDQYVp5ObgqNnepzDKPsLnqtVQABq/IE=; b=KpyO9e8mScuPKENDGeBX18r2me
 EhhxFz4q7f5tzwSe/A2r5jJfa1s0kP9HBWiehXXblpcbHiEjDvxkqd0VQWb1e3EjyBcNxBfLozM2/
 HWQka2EzYX2xM4DBhvi9FcR5rHndqEeN6K3Q8qlwk4w+JRmbQGsaaspKQpZ9HmPiKimQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qp36a8RGpvTaDQYVp5ObgqNnepzDKPsLnqtVQABq/IE=; b=C4C4+zotvpk4s+QcXWerxM0CGz
 x8lpc1IpA5FGMT8HmkURxPTH85WNWDRGG9AEAd9Fy74O2YnJC1v+VT6RRHk0SNQIaviPzLDSIccd2
 FD34VfwhRkvbh4Q4k3evNBv25XfcsbDlSGUpZM8f2iyYL+M9QvxCYYhh9GiNIxF7q4AE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL6Ck-000000003Se-43L4 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 21:56:39 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso22293805e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792965392; x=1793570192; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qp36a8RGpvTaDQYVp5ObgqNnepzDKPsLnqtVQABq/IE=;
 b=alQ7lsLJ75iQ8jIn5ePigct7FAxFEK7YiTlnfTFBZ6UJaRT6CgOkvjDyHDfp0fzDpH
 L4MF6+27gC35Lmfw9CeOx//yS0yu6c3C5+X8eH3jaNZD2zP+HmP+7OSVu0xeDRdI0Pa3
 7Nq3m+J093WLAZyv5SEes+pp4jVuP6GJwfCFlTsGLN2VlZpiGfOD9fEk5g51ihYXqw1p
 OQOpNS0u0kL57Gb718FU8nlnCqDyPMhSslwGi9s6uolvWFr6ButJLPkJ5lDsDse9DeRK
 dvIMR4dWFklvsfAWB/+Nsyi/8oNH0ZHcS12254ep2qYbbw2zZjnIbNJXKVlhO5SHmgWZ
 ElVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792965392; x=1793570192;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qp36a8RGpvTaDQYVp5ObgqNnepzDKPsLnqtVQABq/IE=;
 b=Ks9o/4GXjeFbXpWs1gL0ryAB+cj5Gvhroweu4jQx91Uw80h/tfKtwCEmWk6JClajBC
 aQYb743agVIAsdp00+KDocyMvEKHb+9mjQoI5Via3YEwMMXovLFwWQdf4JXftrh/tAUm
 0ZMvGOkQD4qVkt6IEJRDZlT/JYGMpHC0RPIGgQr5GJn+PSMqXkmt1EE46FXnBQO8zUpB
 NQsJQwL5MNF3jrEsZwLEnCJkBsJ4VEQTMio7AO7NlTO1hVM6PZ/wFJf8+ynrC6x/0q7z
 fI2UD7hDXn491UD0mDJ75oSOEQNRLHzrgcTmf/kN2KiTirPqJE0lAyjlOnZAvOuC8YxS
 UoWQ==
X-Gm-Message-State: AFq9FYJJlbwW5IYvV7vgIdN/fXwX1nA/Jf3jaozRU6FbdVvRPX1m5qzN
 U/sXiuVEE3/YVslnqljzaGjXP06KxK0lyTdOjTFt5xOniiW8VRgebgXOeosVZUR4XtSTwG76OOD
 cBtjT+ag26pod9cx2OjLHw15CaRKnamClGtOFcZIsP+lTwLg5BJfNtO+TvCKWjgBXhPTDbbT4zF
 KwrJypiw==
X-Gm-Gg: AYBFou2o5gHK2gsFFtFrK3z/EvUVdqMrHn7S8ts+MixaliRjHlyKx1LCrNQNtlzLix4
 7XuKo+gWA5Hp3X527PYOGmaNY1gi+E8etfm71OfWcItvQhsfqm2KmFVAF+PXbrtBnXiy7/EEqUL
 FUPU618kpsZ+B98kO8z1xMJQzQTWy+py3OVbhK/h8a4KTTybZH0Odf0Dkb715cSVO6oOjALEdXk
 YLyBxHpMvlYsPrNjOTVsAzpHkz1RBQo6gZ/1tjYxlb1uvcMzUFRYQViuMulX7fKbxJCCYoqivHt
 rKH2eu0TwmC21cS9rnxDymZOlo2sOg+0WW8UuaEuVsy7VOJn1TRvSW1i9hMixo/CxBAT4p7vBaY
 Pwnsd6RB5hgMT3keWZDwB/+dgocmbmv8X0+h80c37DSYGUvApjFP6WE/Syow4ov0SGiDCwY+VM/
 LcI8MC1tTK52YBOFtRwnMQ2FLjaF8SYUuXvyopksCaT3LtHyu6dYgtGwUkss8xvyKknxoem3836
 WItMmqij13IxzM9aGR+Du2cq/VU/fgSWwIIpPUQ16S5Zk6ubrYyfXkQkvQNZlLT8oIDFh0TY2Il
 fhEJ86DwoLDD3ANtU5pO1RZluKtLOYeh3/1aKo6GQsTTA3XugC3TID7pfPbqozLkuQp2ss22lbM
 OKB3hbloPEq0plL6OnCHNU8k0lmuxcapSixhmnn/23Q==
X-Received: by 2002:a05:600c:8518:b0:4a1:a49e:a925 with SMTP id
 5b1f17b1804b1-4a35acebf0bmr87009975e9.35.1792965392246; 
 Sun, 25 Oct 2026 14:56:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm146294535e9.0.2026.10.25.14.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 14:56:31 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 21:56:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee
X-Gerrit-Change-Number: 2032
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2032?usp=email>
X-Gerrit-Commit: 734db16a8afd2de4703886fcf966d22ce4741b24
References: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTY1Mzg4MDAwLkk2MmQ5NWRhZDIxODkxMzUxYTE2Y2Q2YmU0MzA2MzQwNmEwMjRhY2VlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de1e19ac5c138b0c3158dcc9c85bb56cda0b36ed-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xL6Ck-000000003Se-43L4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: release the
 session-id hash reference on shutdown
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3739900154199168610=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3739900154199168610==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f0MVQb1rkoM="; charset=UTF-8

--f0MVQb1rkoM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2032?usp=3Demail

to review the following change=2E
=


Change subject: multi: release the session-id hash reference on shutdown
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: releas=
e the session-id hash reference on shutdown

multi_hash_sid_add() takes a r=
eference on the multi_instance, but
multi_close_instance() only drops it vi=
a multi_hash_sid_remove() when
not shutting down=2E On shutdown hash_free()=
 then frees the table without
releasing the reference, so every instance st=
ill connected when the
server stops is leaked (reported by LeakSanitizer, w=
hich also turns the
exit code into 1)=2E

Remove the instance from the sess=
ion-id hash regardless of shutdown=2E
Unlike the other tables handled in th=
at block, this one holds a
reference=2E

Fixes: 66f8cdb9 ("Add lookup of mu=
lti session by session id")
Change-Id: I62d95dad21891351a16cd6be43063406a02=
4acee
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/=
openvpn/multi=2Ec
1 file changed, 7 insertions(+), 6 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/2032/1

dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2E=
813b79c 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -=
584,6 +584,13 @@
         m->earliest_wakeup =3D NULL;
     }
 
+    /* The=
 sid hash holds a reference on the instance: drop it on shutdown
+     * to=
o, otherwise the instance is never freed */
+    if (session_id_defined(&mi=
->sid_hashed_value))
+    {
+        multi_hash_sid_remove(m, &mi->sid_hash=
ed_value);
+    }
+
     if (!shutdown)
     {
         if (mi->did_real_ha=
sh)
@@ -605,12 +612,6 @@
         }
 #endif
 
-
-        if (session_id_def=
ined(&mi->sid_hashed_value))
-        {
-            multi_hash_sid_remove(=
m, &mi->sid_hashed_value);
-        }
-
         if (mi->context=2Ec2=2Etls=
_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
             m->instances[m=
i->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee=

Gerrit-Change-Number: 2032
Gerrit-PatchSet: 1
Gerrit-Owner: Antonio Quartu=
lli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--f0MVQb1rkoM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">multi: release the session-id hash reference on shutdown<b=
r><br>multi_hash_sid_add() takes a reference on the multi_instance, but<br>=
multi_close_instance() only drops it via multi_hash_sid_remove() when<br>no=
t shutting down=2E On shutdown hash_free() then frees the table without<br>=
releasing the reference, so every instance still connected when the<br>serv=
er stops is leaked (reported by LeakSanitizer, which also turns the<br>exit=
 code into 1)=2E<br><br>Remove the instance from the session-id hash regard=
less of shutdown=2E<br>Unlike the other tables handled in that block, this =
one holds a<br>reference=2E<br><br>Fixes: 66f8cdb9 (&quot;Add lookup of mul=
ti session by session id&quot;)<br>Change-Id: I62d95dad21891351a16cd6be4306=
3406a024acee<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Eco=
m&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 7 insertions(+),=
 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/32/2032/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=2E813b=
79c 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ =
b/src/openvpn/multi=2Ec</span><br><span>@@ -584,6 +584,13 @@</span><br><spa=
n>         m-&gt;earliest_wakeup =3D NULL;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The =
sid hash holds a reference on the instance: drop it on shutdown</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * too, otherwise the insta=
nce is never freed */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        multi_hash_sid_remove(m, &amp;mi-&gt;sid_=
hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   if (!shutdown)</span><br><span>     {</span><br><span>         if (mi-&g=
t;did_real_hash)</span><br><span>@@ -605,12 +612,6 @@</span><br><span>     =
    }</span><br><span> #endif</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            multi_hash_sid_remove(m, &amp;=
mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D M=
AX_PEER_ID)</span><br><span>         {</span><br><span>             m-&gt;i=
nstances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2032?usp=3Demail">change 2032</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2032?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </di=
v>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 2032 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>

</body></html>
--f0MVQb1rkoM=--


--===============3739900154199168610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3739900154199168610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3739900154199168610==--

