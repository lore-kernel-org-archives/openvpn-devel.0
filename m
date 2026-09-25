Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E25FC9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTaxG8yxYnXwndXr/Ssk3AZTdTgxNztYqQrqcqXDl2g=; b=EH+6Ajd+KxLgkOds5CEiZ8zdoC
	+ZHFz/4yHUh4R69JqEVUi/sqwHFZJTGzGnbkIDlmOZK8EifsoMFDnz2brh77XVPFB51/WmEzGGIiI
	R7qhJPrmPQyolQDtdEp91CptGD3zLLMjKHSYq4hWj/jkG0vw8mIb/x86MNieB0S7xtdQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA7bH-0001cW-W5;
	Fri, 25 Sep 2026 15:12:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA7bH-0001cP-Fi
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fm+dZpModB+RU/Ul22Vnk4czCoETHAvmdJtZxsN7Oew=; b=edno85Ki6UAMjuESvstcK7dTlJ
 RspdVJjpU6YAf+s8hzdmg8CltXcndGvnCrgSuTO9Sdu66ttZAPTSDc50CKAdIldN4Jcx3W82HPjVl
 JP2mv0UjXpy5CIadNbi0oIFVJg4DPn/a6daB9mKPR5zY7ZFb/Oxov/fLuw+yjbji+F8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fm+dZpModB+RU/Ul22Vnk4czCoETHAvmdJtZxsN7Oew=; b=K
 pj71enl11/SaEEBMOXj+Ab+RY7+Jhmde8A599CUy3MrjmqsxhY5j3bGjHgqaiRiRK0Kjofx4qr/n8
 EaOAjOo+jjzlqktBl02Z0NJI/2+SjPWYz+/Ff7fVERVVHcvc/kJV6UZWqCoqrU/wccUHIRx9P4X9S
 DX1fMOl5JhB8zvYY=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA7bC-0008Sn-Ce for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:12:36 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso7196435e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790349144; x=1790953944; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fm+dZpModB+RU/Ul22Vnk4czCoETHAvmdJtZxsN7Oew=;
 b=f1kUm98aRhmbinHctR4MZKZAc4HE2MuN4EwQPfuzif4+qpn5ngn2MxWxdnWZi6DmqX
 6FzgYm7n6rYMTJbaen5hDM9UFn0Jho3lh++54P4nD5H+VPsC+JZ39vIcGGipXF0tHPAv
 USi+MzXXtw+P25ZljdhvD86vK15YdyRwjYgisdgJ5L6KGMAlYYqJ2AsG4/84nJQBdHZ+
 hAhSvQEaruJhCaEibVs1mbNXrU8rt6K/KHVKyV6joxCZxW56O4Lr9oyUpL+LKAVEj6Li
 /o75uPcAHaVsGen8pku5ZupHKtVFIjdgb1hhIbGjpXgLaU2rR5Z7DJ2YNmVBri/IF6BP
 rl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790349144; x=1790953944;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fm+dZpModB+RU/Ul22Vnk4czCoETHAvmdJtZxsN7Oew=;
 b=LUuPDVOc8RmNNWPoWlQEOad7XTNmFBJCE7znKWER9o2c7QXHM+37m37aVbrEvytgdW
 eN8HrBgCIAJQDRPAh/1FFCqtlAuYNT9KkEr70oQxYXb0jFpxDcLP/HwMgrAxS+2kZbOn
 n1UaHw73yyg5ECFb0B/LJCPkJJYIHd0HZOAUrrPcufadO0Q5qNgwpUTTja1MJbHjFPAg
 ATWoUz7ayHQZzgjAd6JtUB/uHPvAGYWzls0N/1RXd657ab+VW95tMEX8ukjO37xoAn7M
 BWI4rGl5RiGmOP5/38YGXSahzQn5pWuhoomOTlE0qmmEPmIzzYS9QNwtv2GkLwKog555
 3VbQ==
X-Gm-Message-State: AFuF++naX/kjMw6Jz8LmUt8pj+9CoWB8PobGuhNWttgJN6xh0TtBSJjR
 335WprSqmobPzxo2dTXKOZIcmN+icOPAmiOmDpeQgROWxdAj3vvvluDyXvMqLtlm/nlLxrvkRWz
 yaG68ltn7jzBy1dRMbPOQsMfO5hYVwmV61ydPV3vvJvjiWZ/svQBAhumkrUYDpg5SHvQnIBqSaB
 vVkBPiKw==
X-Gm-Gg: AYBFou2sVFNX9BbExsCy1tjOvkJtAeff9F+wQBnKn/B0w9QFOOOTzbAIrCeXbIuyJ8E
 53Y1cMFdhQv+QZo9O+RNpdEEgE9BbMKloMf7tzqKsitpA2fl9BlihS9iJqGN7GLslftmMlPrtNd
 xc712azm8IC/zA2ZqjooDfCeMTZ5VT4MbN2tiK6WMGlJJinvjCW2QsZ7IPlgNZETHhJKePgn1+i
 xzAKjVRtMsQ/zePFhWqdenojYVdLnbhqZ7VSZGYt6+UQ7DEMCmlp8jQbA3VfD/96xFZfGI9g7ea
 zqLaqCTQrXGSVO6BYaCdm9fVA7tWKXNqR4Z1C4/EVDGhbNuM2DLdjLV5Cxjm5PPOQsd0ZxBzyLY
 2zWTrMADzbeuvupLXumn11aMNIwfH/urE1psvucLJCO0np5NCtpEfMMFoq0YX3rJVSabPp9GStS
 0H8fwZBWKg/WByoevMq1qa0qEDcIElXTHSvRGMxFpdjz/Hy30NwBVuk3z+j3AuJ39KFBhYzPe47
 aD6KzhDjo+jCqzx3vwyU0O0XLPMR5b07pN1HX9H7o0HW8CPyblpd2u1as+u/TEyQiXItkpWPkH1
 3r53GY18qZlp0pRNsIFTeiFcxEuSS5JiMpfgGedB9UGf8cEGb+LsAymvsWBth90zJzTqfGI=
X-Received: by 2002:a05:600c:1389:b0:49f:dcc8:c735 with SMTP id
 5b1f17b1804b1-49fe66f4c7dmr101629575e9.18.1790349143547; 
 Fri, 25 Sep 2026 08:12:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm108481345e9.0.2026.09.25.08.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:12:22 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 15:12:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 62781dc17328af91c589e6aa2b3c276188e2383a
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a8faf4885f0075d0b2c5a2d2a7eb54d1b50de78-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA7bC-0008Sn-Ce
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
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org,
 antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0523354463893456789=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0523354463893456789==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aylbMIprKW4="; charset=UTF-8

--aylbMIprKW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello ordex,=
 plaisthos, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail

to look at the new p=
atch set (#2)=2E


Change subject: dco: stop fetching peer stats during cli=
ent disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


dco: stop fetching peer stats during client disconnect

The disconnect pa=
th asks DCO for a fresh peer dump after the multi
instance has already been=
 removed from the peer-id lookup table=2E For
kernel-initiated disconnects,=
 the peer has also already been deleted by
the time its notification is pro=
cessed=2E The reply therefore cannot
update the disconnecting instance=2E

=
Moreover, each disconnect dumps all surviving peers, causing avoidable
netl=
ink traffic and repeated work when many clients disconnect at once=2E

Duri=
ng shutdown or restart, fetch a single final peer snapshot before
closing a=
ny instances, while all peers can still be mapped to their
userspace contex=
ts=2E

For individual disconnects, use the cached counters directly=2E Kern=
els
that provide a final statistics snapshot in the deletion notification
c=
an update them before the disconnect environment is prepared=2E

Change-Id:=
 Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Signed-off-by: Ralf Lici <ralf@m=
andelbit=2Ecom>
---
M dev-tools/cppcheck-suppression
M src/openvpn/multi=2E=
c
2 files changed, 14 insertions(+), 16 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1952/2

diff --git a/dev-=
tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 299d7a3=
=2E=2E38ca062 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/c=
ppcheck-suppression
@@ -26,7 +26,7 @@
 # FP: posix=2Ecfg claims suseconds_t=
 is unsigned for some reason
 unsignedLessThanZero:src/openvpn/otime=2Eh:14=
8
 # IGN: multi code does weird things with pointers to local variables=2E=
=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4242
+autoVariables:src/openvpn=
/multi=2Ec:4240
 autoVariables:src/openvpn/multi_io=2Ec:324
 # IGN: the cod=
e header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBitma=
skCheck:src/openvpn/mudp=2Ec
diff --git a/src/openvpn/multi=2Ec b/src/openv=
pn/multi=2Ec
index 3e72b92=2E=2Eb7085dc 100644
--- a/src/openvpn/multi=2Ec
=
+++ b/src/openvpn/multi=2Ec
@@ -496,37 +496,29 @@
 }
 
 static void
-setenv=
_stats(struct multi_context *m, struct context *c)
+setenv_stats(struct con=
text *c)
 {
-    if (dco_enabled(&m->top=2Eoptions))
-    {
-        if (dc=
o_get_peer_stats_multi(&m->top=2Ec1=2Etuntap->dco, false) < 0)
-        {
-=
            return;
-        }
-    }
-
     setenv_counter(c->c2=2Ees, "by=
tes_received", c->c2=2Elink_read_bytes + c->c2=2Edco_read_bytes);
     sete=
nv_counter(c->c2=2Ees, "bytes_sent", c->c2=2Elink_write_bytes + c->c2=2Edco=
_write_bytes);
 }
 
 static void
-multi_client_disconnect_setenv(struct mul=
ti_context *m, struct multi_instance *mi)
+multi_client_disconnect_setenv(s=
truct multi_instance *mi)
 {
     /* setenv client real IP address */
     =
setenv_trusted(mi->context=2Ec2=2Ees, get_link_socket_info(&mi->context));
=
 
     /* setenv stats */
-    setenv_stats(m, &mi->context);
+    setenv_s=
tats(&mi->context);
 
     /* setenv connection duration */
     setenv_lon=
g_long(mi->context=2Ec2=2Ees, "time_duration", now - mi->created);
 }
 
 st=
atic void
-multi_client_disconnect_script(struct multi_context *m, struct m=
ulti_instance *mi)
+multi_client_disconnect_script(struct multi_instance *m=
i)
 {
-    multi_client_disconnect_setenv(m, mi);
+    multi_client_disconn=
ect_setenv(mi);
 
     if (plugin_defined(mi->context=2Eplugins, OPENVPN_PL=
UGIN_CLIENT_DISCONNECT))
     {
@@ -634,7 +626,7 @@
 
     if (mi->context=
=2Ec2=2Etls_multi->multi_state >=3D CAS_CONNECT_DONE)
     {
-        multi=
_client_disconnect_script(m, mi);
+        multi_client_disconnect_script(m=
i);
     }
 
     close_context(&mi->context, SIGTERM, CC_GC_FREE);
@@ -659=
,6 +651,12 @@
 {
     if (m->hash)
     {
+        /* fetch final stats whi=
le all peers can still be mapped to their instances */
+        if (dco_ena=
bled(&m->top=2Eoptions))
+        {
+            dco_get_peer_stats_multi(&=
m->top=2Ec1=2Etuntap->dco, false);
+        }
+
         for (uint32_t i =
=3D 0; i <=3D m->max_peerid; i++)
         {
             struct multi_inst=
ance *mi =3D m->instances[i];
@@ -2750,7 +2748,7 @@
          * did not fai=
l */
         if (mi->context=2Ec2=2Etls_multi->multi_state =3D=3D CAS_PEND=
ING_DEFERRED_PARTIAL)
         {
-            multi_client_disconnect_scrip=
t(m, mi);
+            multi_client_disconnect_script(mi);
         }
 
   =
      mi->context=2Ec2=2Etls_multi->multi_state =3D CAS_FAILED;

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6f=
d1061247b05de
Gerrit-Change-Number: 1952
Gerrit-PatchSet: 2
Gerrit-Owner: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--aylbMIprKW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>ralf_lici <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">dco: stop fetching peer stats during client disconnect<br><br>The dis=
connect path asks DCO for a fresh peer dump after the multi<br>instance has=
 already been removed from the peer-id lookup table=2E For<br>kernel-initia=
ted disconnects, the peer has also already been deleted by<br>the time its =
notification is processed=2E The reply therefore cannot<br>update the disco=
nnecting instance=2E<br><br>Moreover, each disconnect dumps all surviving p=
eers, causing avoidable<br>netlink traffic and repeated work when many clie=
nts disconnect at once=2E<br><br>During shutdown or restart, fetch a single=
 final peer snapshot before<br>closing any instances, while all peers can s=
till be mapped to their<br>userspace contexts=2E<br><br>For individual disc=
onnects, use the cached counters directly=2E Kernels<br>that provide a fina=
l statistics snapshot in the deletion notification<br>can update them befor=
e the disconnect environment is prepared=2E<br><br>Change-Id: Ic535bb1f0da1=
739f87e9d6bef6fd1061247b05de<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=
=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M src/openvpn/mult=
i=2Ec<br>2 files changed, 14 insertions(+), 16 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/52/1952/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-tools=
/cppcheck-suppression</span><br><span>index 299d7a3=2E=2E38ca062 100644</sp=
an><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev=
-tools/cppcheck-suppression</span><br><span>@@ -26,7 +26,7 @@</span><br><sp=
an> # FP: posix=2Ecfg claims suseconds_t is unsigned for some reason</span>=
<br><span> unsignedLessThanZero:src/openvpn/otime=2Eh:148</span><br><span> =
# IGN: multi code does weird things with pointers to local variables=2E=2E=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/=
openvpn/multi=2Ec:4242</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+autoVariables:src/openvpn/multi=2Ec:4240</span><br><span> autoVariables:=
src/openvpn/multi_io=2Ec:324</span><br><span> # IGN: the code header =3D 0 =
| (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</span><br><span> b=
adBitmaskCheck:src/openvpn/mudp=2Ec</span><br><span>diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3e72b92=2E=2Eb708=
5dc 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ =
b/src/openvpn/multi=2Ec</span><br><span>@@ -496,37 +496,29 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-setenv_stats(struct multi_context *m, struc=
t context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv=
_stats(struct context *c)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (dco_get_peer_stats_multi(&amp;m=
-&gt;top=2Ec1=2Etuntap-&gt;dco, false) &lt; 0)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            return;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     setenv_counter(c-&gt;c2=2Ees, &quot;bytes_received&quot;, c-&gt;c2=2El=
ink_read_bytes + c-&gt;c2=2Edco_read_bytes);</span><br><span>     setenv_co=
unter(c-&gt;c2=2Ees, &quot;bytes_sent&quot;, c-&gt;c2=2Elink_write_bytes + =
c-&gt;c2=2Edco_write_bytes);</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mu=
lti_client_disconnect_setenv(struct multi_context *m, struct multi_instance=
 *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_d=
isconnect_setenv(struct multi_instance *mi)</span><br><span> {</span><br><s=
pan>     /* setenv client real IP address */</span><br><span>     setenv_tr=
usted(mi-&gt;context=2Ec2=2Ees, get_link_socket_info(&amp;mi-&gt;context));=
</span><br><span> </span><br><span>     /* setenv stats */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    setenv_stats(m, &amp;mi-&gt;contex=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_stats=
(&amp;mi-&gt;context);</span><br><span> </span><br><span>     /* setenv con=
nection duration */</span><br><span>     setenv_long_long(mi-&gt;context=2E=
c2=2Ees, &quot;time_duration&quot;, now - mi-&gt;created);</span><br><span>=
 }</span><br><span> </span><br><span> static void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-multi_client_disconnect_script(struct multi_con=
text *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+multi_client_disconnect_script(struct multi_instance *mi)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
multi_client_disconnect_setenv(m, mi);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    multi_client_disconnect_setenv(mi);</span><br><span>=
 </span><br><span>     if (plugin_defined(mi-&gt;context=2Eplugins, OPENVPN=
_PLUGIN_CLIENT_DISCONNECT))</span><br><span>     {</span><br><span>@@ -634,=
7 +626,7 @@</span><br><span> </span><br><span>     if (mi-&gt;context=2Ec2=
=2Etls_multi-&gt;multi_state &gt;=3D CAS_CONNECT_DONE)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_clien=
t_disconnect_script(m, mi);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        multi_client_disconnect_script(mi);</span><br><span>     }<=
/span><br><span> </span><br><span>     close_context(&amp;mi-&gt;context, S=
IGTERM, CC_GC_FREE);</span><br><span>@@ -659,6 +651,12 @@</span><br><span> =
{</span><br><span>     if (m-&gt;hash)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* fetch final stats whil=
e all peers can still be mapped to their instances */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;m-&gt;top=2E=
options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_get_=
peer_stats_multi(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         for (uint32_t i=
 =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span><br><span>         {</span><=
br><span>             struct multi_instance *mi =3D m-&gt;instances[i];</sp=
an><br><span>@@ -2750,7 +2748,7 @@</span><br><span>          * did not fail=
 */</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_=
state =3D=3D CAS_PENDING_DEFERRED_PARTIAL)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_client_di=
sconnect_script(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            multi_client_disconnect_script(mi);</span><br><span>       =
  }</span><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Etls_mu=
lti-&gt;multi_state =3D CAS_FAILED;</span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail">change 19=
52</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1952 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: r=
azvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--aylbMIprKW4=--


--===============0523354463893456789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0523354463893456789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0523354463893456789==--

