Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1224FC98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kG3s97pOpsL4oCR4YXIgvOP/6uETaZa0NJxWQVUV5pA=; b=dFqMRbAgAsDW0T
	U/n4fZa8I2QTdmw/9XHPza/08w/EoW4OzjzAb64ISknskmMLK9O6RJouSaKFNrkGqitZUfAO5ii/h
	OYZjXRVYJJzgaP5JsFxGCd2Y3omRUcSFpS8zkWSbNLKXK9UivMNUQQVMXOrmSaNj2MZtZ3iVIt4Hl
	pLM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA6Lk-0006vd-I3;
	Fri, 25 Sep 2026 13:52:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA6Lj-0006vU-GB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VShaR/AtM/kd2Q5ZrLax80KP4cmJZ/hm5QEF3HhEIEQ=; b=HSRxS5CFRnzrtpyu+s9fq8N5Ev
 WhdvVJdIKWEoMSRUx5uIPq2c8Tiq4JlttskQPYyCJtkLcmqyWJDZN1wy0OIUzXj4n0ZaC8V14iazc
 5xD2czTP64VWd2JaduGrNM7aGu+X46VIljJknx2tCG6NGRGB6vK6SXyBvtT4XbFV8spQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VShaR/AtM/kd2Q5ZrLax80KP4cmJZ/hm5QEF3HhEIEQ=; b=c
 gsXM/F4k0FgHuvlGetZ8HFYEifb0Fia6gZlZ2Qvtg04u8FeC53d75//WR/cg7DLGC0Pzx2AsibR5I
 UMHJuixWf8O4IByEnZc3tjhbWzm3jr4F9tQm87nkqQZcwbkWH2tzhu+cGR8JjRnVpGZFoFTSZafrP
 h1FXWxED025OPCXc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA6Lh-0006eJ-M0 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:52:27 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so10248875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790344339; x=1790949139; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VShaR/AtM/kd2Q5ZrLax80KP4cmJZ/hm5QEF3HhEIEQ=;
 b=Tgd+Z/XJcux2x2v3ZYwZvp5H5oJN+cAQ8/dPq3lUlJhZrkpacrAvY8z1LM4ibPNLFs
 EXPVfxnEp8soqXFrf0HqnKmlWZcLzS4B8ypVys/jaQHsd2AD0pSj7FK1d1XB8KPTO1Ip
 IGMRcw3jsXAkh2yLOGnitL9WhWFzN1TyrhIpMyfmDO2MzcrW8pX8NtFSJdsQ5eVKcXAZ
 0wEQU0uMYFn1vHl3i6+rAvm5uAQ6LsPqINJlhVOgEF2OGtqB/1K+9UMiBHZvvaZ5GLBX
 fT4770YuLCah9UIl3Mjz/A0MGOs0AM2WZzFCb4Ft/EDfpYH18b1pObxlVzQ1UShifvAL
 uHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790344339; x=1790949139;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VShaR/AtM/kd2Q5ZrLax80KP4cmJZ/hm5QEF3HhEIEQ=;
 b=imemuQ9DZzLubXczD4/rG4rRNyJ7CxOmW8H/qfuCXwrXXGpAaDWczuGgt+8aAkaMtK
 R4ATpsX8LKOsrw68wXnbieZmM7SSpcjqMxD16bVL5TMrh+B95BVakWClt731PKGPsnju
 rs6xCVY95njUm5RQPSgU84GnMBu4ytO/4QHsgnJVOxIB0E6fdNeaSYqdmjNygIavdad4
 Apvex5DigRUQ3sMuAtCq/ReNlysCOoBOpy+lCyquIeFbPZ6UBwplPUyuMaskdrhIcV/q
 PxqYDkjK8MbJl77XBBJSMS422ELUv+64aaFE508HVa024quQvsbIO61QGaN+azie8VaD
 QSkw==
X-Gm-Message-State: AFuF++nePiNX47N8Uy6OUWG6qiD4vm5UWX1Hi+VUnxp33UXUwD61EXGJ
 i7Hg+gCwNPEikQgetanL+FuOv1ojxD45GhcQs/ZRSnpt7JIX/0YaaOwXRvNrm6HYI8LvRfniV7v
 khqr42bfM16TmnAdZGOkkp1+J20DDRGl8FwEjxnaFyq6sI3UgJmiNSVp/LWu9xmrfBrFIcmEfmJ
 SN3DoUVA==
X-Gm-Gg: AYBFou2mS+K8q4yW6MuCrhy3l+2tB9dXTs3yIAUEOu7hlxu63s4x3RZe9VbaxDNwJ1V
 PjrHuVoOJTSVeDDXmUdmUxyjfOoHqu4uw2IlfX4bmu+/SzgvHF/mLTyYrtF0j9XwF8hCFzSYqwM
 bal+YkpY+JrptMR0CLCzAeKiMQi0C/e0sS5G/sT8HgTR/5frQlsZ3Pmb9zpDuZ8VCWVEl/b4B2K
 SxymDTl3X00sGj21LE2cmv0YzybmLmEniG9wT/xKG+jszVDPs1QpxqB36UV2cM+AlyC+BS+dkxe
 UI/TTt13ukhFOmH/2TqKva2DAD7d+M5R1n2CSkmHaTePdEGYHIHedRpJmLSzec0t8cJk8q+dynd
 8UcTeG3aPU/Uhyhr5IfosXfV+jRbQt4iDm2P2Xn0HZ+0fiTlBwR36DNYcPxoPt8lBY3McjMn8Fw
 165EuOti8ltY6a2kFMayLcknYHgtndQhzmnaec/TSPxgOuRAQ6AZbEidFwT7cFcRXDlTxUsr2qD
 FpaCTHhiyavVRYx7KpcepMQidsODLZ3IQ8iWyKphkh0j33BBKQnGqPsoTJn94DMIkf3jun/2cWv
 0lG5+qM3haNQb/AnixDTx3ADDpfQI73Jbl15LXo1DDgzeCD5jx7O/02AqobD
X-Received: by 2002:a05:600c:3b9c:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-49fe66dfdf8mr126596595e9.23.1790344338880; 
 Fri, 25 Sep 2026 06:52:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef6186a6sm54199095e9.4.2026.09.25.06.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:52:18 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 13:52:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 5655c770a96630ceb381007087759de61afc87ae
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b3d64c44ee9a06e0a904dcf49f2e49c459f28e96-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA6Lh-0006eJ-M0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5584795838767122203=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5584795838767122203==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c3m/NMybEtg="; charset=UTF-8

--c3m/NMybEtg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1952?usp=3Demail

to review the following change=2E


Chang=
e subject: dco: stop fetching peer stats during client disconnect
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: stop fetching pee=
r stats during client disconnect

The disconnect path asks DCO for a fresh =
peer dump after the multi
instance has already been removed from the peer-i=
d lookup table=2E For
kernel-initiated disconnects, the peer has also alrea=
dy been deleted by
the time its notification is processed=2E The reply ther=
efore cannot
update the disconnecting instance=2E

Moreover, each disconnec=
t dumps all surviving peers, causing avoidable
netlink traffic and repeated=
 work when many clients disconnect at once=2E

Use the cached counters dire=
ctly=2E Kernels that provide a final
statistics snapshot in the deletion no=
tification can update them before
the disconnect environment is prepared=2E=


Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Signed-off-by: Ralf =
Lici <ralf@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
1 file changed, 2 i=
nsertions(+), 10 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/52/1952/1

diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec
index 3e72b92=2E=2Ef303826 100644
--- a/src/openvpn/mul=
ti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -496,16 +496,8 @@
 }
 
 static void
-=
setenv_stats(struct multi_context *m, struct context *c)
+setenv_stats(stru=
ct context *c)
 {
-    if (dco_enabled(&m->top=2Eoptions))
-    {
-        =
if (dco_get_peer_stats_multi(&m->top=2Ec1=2Etuntap->dco, false) < 0)
-     =
   {
-            return;
-        }
-    }
-
     setenv_counter(c->c2=2Ee=
s, "bytes_received", c->c2=2Elink_read_bytes + c->c2=2Edco_read_bytes);
   =
  setenv_counter(c->c2=2Ees, "bytes_sent", c->c2=2Elink_write_bytes + c->c2=
=2Edco_write_bytes);
 }
@@ -517,7 +509,7 @@
     setenv_trusted(mi->context=
=2Ec2=2Ees, get_link_socket_info(&mi->context));
 
     /* setenv stats */
=
-    setenv_stats(m, &mi->context);
+    setenv_stats(&mi->context);
 
    =
 /* setenv connection duration */
     setenv_long_long(mi->context=2Ec2=2E=
es, "time_duration", now - mi->created);

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Gerrit-Cha=
nge-Number: 1952
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--c3m/NMybEtg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1952?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">dco: stop fetching peer stats during client disconnect<br><br>The disco=
nnect path asks DCO for a fresh peer dump after the multi<br>instance has a=
lready been removed from the peer-id lookup table=2E For<br>kernel-initiate=
d disconnects, the peer has also already been deleted by<br>the time its no=
tification is processed=2E The reply therefore cannot<br>update the disconn=
ecting instance=2E<br><br>Moreover, each disconnect dumps all surviving pee=
rs, causing avoidable<br>netlink traffic and repeated work when many client=
s disconnect at once=2E<br><br>Use the cached counters directly=2E Kernels =
that provide a final<br>statistics snapshot in the deletion notification ca=
n update them before<br>the disconnect environment is prepared=2E<br><br>Ch=
ange-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de<br>Signed-off-by: Ralf L=
ici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 fil=
e changed, 2 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1952/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><s=
pan>index 3e72b92=2E=2Ef303826 100644</span><br><span>--- a/src/openvpn/mul=
ti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -496,=
16 +496,8 @@</span><br><span> }</span><br><span> </span><br><span> static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_stats(struc=
t multi_context *m, struct context *c)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+setenv_stats(struct context *c)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(&amp;m-=
&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_ge=
t_peer_stats_multi(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, false) &lt; 0)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>     setenv_counter(c-&gt;c2=2Ees, &quot;bytes_rec=
eived&quot;, c-&gt;c2=2Elink_read_bytes + c-&gt;c2=2Edco_read_bytes);</span=
><br><span>     setenv_counter(c-&gt;c2=2Ees, &quot;bytes_sent&quot;, c-&gt=
;c2=2Elink_write_bytes + c-&gt;c2=2Edco_write_bytes);</span><br><span> }</s=
pan><br><span>@@ -517,7 +509,7 @@</span><br><span>     setenv_trusted(mi-&g=
t;context=2Ec2=2Ees, get_link_socket_info(&amp;mi-&gt;context));</span><br>=
<span> </span><br><span>     /* setenv stats */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    setenv_stats(m, &amp;mi-&gt;context);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_stats(&amp;mi-&g=
t;context);</span><br><span> </span><br><span>     /* setenv connection dur=
ation */</span><br><span>     setenv_long_long(mi-&gt;context=2Ec2=2Ees, &q=
uot;time_duration&quot;, now - mi-&gt;created);</span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demai=
l">change 1952</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
52?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1952 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf=
_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--c3m/NMybEtg=--


--===============5584795838767122203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5584795838767122203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5584795838767122203==--

