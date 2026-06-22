Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41510CDB477
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o10H0E8c9+snZ0CmhjzpvHtYk9fQg/TA8S0ylWm9bxs=; b=kesNncLW7/g3IKNI9mKNUOdIYT
	48x7aAADjPqyRftQy5OfSt9PIN1rCzwZ2XqvxcKq9+F/fuEHOBmqNAPSHgPyNIGjjcs49538rlKn3
	1xMts51e/VBIakVqpBQCxcDFbDNe0Sds0qbMw0YnrdRq6n6YErylRIcXw7UFesVxHsac=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgcd-0006A8-E3;
	Mon, 22 Jun 2026 15:31:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgcc-0006A1-CL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gAK6McEl7GDby3/Z9PkoC4KX1g7uiJwqdPKaSQtVdgI=; b=YXq0k0uoH9L9eghNcc7I4iTbAp
 WgMuHxGtsQ/hrhBYcJMG5/sIP7i7o7lmcL0VTIVwGfONdIZMQzh5Ez0Rk7lBd4RLA15N0HE6Mkoid
 sQeN14PQsCIBx1BVw+D/gEWLKxdm0GPGEnC9Lh90c+eAHx93Gidb7rnPf7wTMoqJZ/tk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gAK6McEl7GDby3/Z9PkoC4KX1g7uiJwqdPKaSQtVdgI=; b=F
 m4JxhymtoMnsh7l8G+QoWfg6CHkkETvbk5tqlzWmAD5YlbmMx5TKpGh+3rl7rovMzaTwru3bKukxw
 zfUwZVQBXZT2GfQ5sz2WhLIuGuCPII8gtPZQzzrD9uX1C6a3XVEYH12ISEAJr/o8bbU25EnCJWAln
 VCCaICwU8LEl8+fs=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgca-0007ni-B8 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:38 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2730364f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142285; x=1782747085; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gAK6McEl7GDby3/Z9PkoC4KX1g7uiJwqdPKaSQtVdgI=;
 b=O7c3b77divqGS5KbF0M3y49AxCsr9ldq6fT0XPEsRtufvt9KVQbRzzktq9NqL1A4sA
 hAq7ddmafUpsqQ9ZaJASaJm+hG3DEFyiakPsCm4Jxewe7mf5GqNLKP6I/i1w8kAKviZA
 DtUIj3KZDlj8e6NK58BOn92Zs9GCa0/bo/tg7DsP13fBpDHbyRw78IGOIpE8U2tZ5Qmc
 W1Mf5KVPiLQ1SM7uXu1LN7HElRlkP080AxWuIT/8E9bSQWfWAFbS0BPyTz8GOlgtrI/5
 YklNktZRAmy4APdXA32F2ngDBNsCi5/lUtsHpvIBGZPOLiPguJA4mmibSNp4BSfW3F/2
 cTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142285; x=1782747085;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gAK6McEl7GDby3/Z9PkoC4KX1g7uiJwqdPKaSQtVdgI=;
 b=Y+sFzEjedHYRmKV/ZCk2VvqyZnX7jivPcejQjqj8M68RsU1FI5ybj/82w96LBVSwpX
 Z27m0kwJDxPSE5KeNWwikGv68EW8+3BtI+rjn5jEX+PwnVKfCtJv82AQ7O+5aMWHpcML
 saLVrOyY0RHw4QmWOK7fvLS23+rMOMHSBjp/iWRwlnvdEcCiQaQbZ1+GgS6JvvVxGeXg
 4PnwTMfSN52xrzIgCZpuwKwzS98Ti802ylI/iuVnS+waN0ibHnOTiy5JDp7Ixe0eviNj
 I+XAN8ql3msfPSIvWEErXGKW7zFGwHGcUq9Op3fvTdXqglLXIinAA4KXezDIV71cmnZF
 u7Lw==
X-Gm-Message-State: AOJu0Yz4UOw5JLpl6IbYj6KwHSyXuBz0ZY/bceknU2328aeueBwrgDCt
 bpeGNKwmuMZ3xfOn/y6pWMetyjNAFRVpikloSzeP/ccD5EIaRpfjaPfQadQwQqseqa1L0N0rdhd
 IL/I0bffaK2tU0ESIMio6ZNQLZxc8u5Udvnxil/+cPWEGc+yfE2ondmlko4n2rvMxvDhu9SG3oB
 UApEbKUw==
X-Gm-Gg: AfdE7cmsBEryTg+FgsbQux265VSlUa6ydYn8V00zKa3LymX/hPiCknPAusUv8mbwsrj
 rZVLEZEywHoqO6pNASt43yq3eozvq5dotgv7WVMdm3YoGfmGA21QYQuhC3mNRDqUL4wHeyekIAl
 wuMC8gGno6gHpGIQh7+2NPtil+YJ9RVlppy4YuSvySyNPV46YYBpGKDJmWrLnwj/kwBtClh895o
 O5Y2lsjLuYY+wXYS0euVwaPTW/L2Qz9nHR5iO2kdqjz5fxRWRNNnuO461zb4L9dgABHWp2XtRY2
 S5mBHjiUJXdVjHvGoe7LfVXzCX5L9Ienn/tFx3aNEEoLnVGa0gddHD4HRNO/wPqrItAqiCCDNHq
 lkYFeueeyXDsyRw5XAEvEHB7UHW+o4BSN4EDhPBXicWtWuj1iNLQ4GUyhJAi4aXxcA6sFVYW4vD
 OUORZnO4UUznpPPePxoaiPi4OfXqw1Br5UL8aWoZ66g1AwsvrQ3lqT51eVFTazp3OrPWpCcBgeN
 AXYmidrbBioAD/edQ9Q4zxoXwGLAQ39QQ26UIp8RB2nfEm2sSVAT7hAd6WdGcCBnQOduP125xiu
 Gcg=
X-Received: by 2002:a05:600d:6451:20b0:492:3fb1:e9b8 with SMTP id
 5b1f17b1804b1-4923fb1f003mr180706165e9.12.1782142284958; 
 Mon, 22 Jun 2026 08:31:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm216193645e9.1.2026.06.22.08.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:31:24 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:31:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: c257cc89966792bed1d61c4c2c098d8ac8e09afe
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bbdc36a44e621175a9d56072debc01eca5a6e317-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgca-0007ni-B8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
Content-Type: multipart/mixed; boundary="===============6736132011102549992=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6736132011102549992==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/sEWUiYa64c="; charset=UTF-8

--/sEWUiYa64c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1725?usp=3Demail

to look at the new patch set (#2=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Extract multi_get_instance_real_udp_real =
method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extr=
act multi_get_instance_real_udp_real method

This is just a small refactori=
ng to make the code a little bit
better organised=2E

Change-Id: I37ade55d7=
674c68dd98cf4dfde35c4ad42e20d39
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/mudp=2Ec
1 file changed, 25 insertions(+), 8 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/25/1725/2

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
inde=
x a91d11b=2E=2Ee8d8128 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/=
mudp=2Ec
@@ -198,7 +198,6 @@
 handle_connection_attempt(struct multi_contex=
t *m,
                           struct link_socket *sock,
                =
           struct mroute_addr *real,
-                          const uint6=
4_t hv,
                           struct hash_bucket *bucket)
 {
     stru=
ct hash *hash =3D m->hash;
@@ -229,6 +228,7 @@
             mi =3D multi_cr=
eate_instance(m, real, sock);
             if (mi)
             {
+        =
        const uint64_t hv =3D hash_value(hash, real);
                 hash=
_add_fast(hash, bucket, &mi->real, hv, mi);
                 mi->did_real_h=
ash =3D true;
                 multi_assign_peer_id(m, mi);
@@ -258,6 +258,=
28 @@
 }
 
 /**
+ * Looks up an multi instance by its real address (IP and =
port)
+ * @param m     multi context
+ * @param real  Address to look up
+ =
* @return      instance matching the NULL otherwise
+ */
+struct multi_inst=
ance *
+multi_get_instance_real_udp_real(struct multi_context *m, struct mr=
oute_addr *real)
+{
+    struct hash *hash =3D m->hash;
+    struct hash_el=
ement *he;
+    const uint64_t hv =3D hash_value(hash, real);
+    struct h=
ash_bucket *bucket =3D hash_bucket(hash, hv);
+    he =3D hash_lookup_fast(=
hash, bucket, real, hv);
+    if (he)
+    {
+        return he->value;
+  =
  }
+    return NULL;
+}
+
+
+/**
  * Get a client instance based on real a=
ddress=2E  If
  * the instance doesn't exist, create it while
  * maintaini=
ng real address hash table atomicity=2E
@@ -273,7 +295,6 @@
 
     if (mrou=
te_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->=
top=2Ec2=2Ebuf=2Elen > 0)
     {
-        struct hash_element *he;
        =
 const uint64_t hv =3D hash_value(hash, &real);
         struct hash_bucket=
 *bucket =3D hash_bucket(hash, hv);
         uint8_t *ptr =3D BPTR(&m->top=
=2Ec2=2Ebuf);
@@ -310,17 +331,13 @@
         }
         if (!v2 || peer_id_=
disabled)
         {
-            he =3D hash_lookup_fast(hash, bucket, &re=
al, hv);
-            if (he)
-            {
-                mi =3D (struc=
t multi_instance *)he->value;
-            }
+            mi =3D multi_get_=
instance_real_udp_real(m, &real);
         }
 
         /* we have no exist=
ing multi instance for this connection */
         if (!mi)
         {
-   =
         mi =3D handle_connection_attempt(m, sock, &real, hv, bucket);
+   =
         mi =3D handle_connection_attempt(m, sock, &real, bucket);
        =
 }
 
 #ifdef ENABLE_DEBUG

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number: 17=
25
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>

--/sEWUiYa64c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Extract multi_get_instance_real_udp_real method<br><br>This i=
s just a small refactoring to make the code a little bit<br>better organise=
d=2E<br><br>Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39<br>Signed-=
off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mud=
p=2Ec<br>1 file changed, 25 insertions(+), 8 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
25/1725/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec<=
/span><br><span>index a91d11b=2E=2Ee8d8128 100644</span><br><span>--- a/src=
/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><spa=
n>@@ -198,7 +198,6 @@</span><br><span> handle_connection_attempt(struct mul=
ti_context *m,</span><br><span>                           struct link_socke=
t *sock,</span><br><span>                           struct mroute_addr *rea=
l,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
       const uint64_t hv,</span><br><span>                           struct=
 hash_bucket *bucket)</span><br><span> {</span><br><span>     struct hash *=
hash =3D m-&gt;hash;</span><br><span>@@ -229,6 +228,7 @@</span><br><span>  =
           mi =3D multi_create_instance(m, real, sock);</span><br><span>   =
          if (mi)</span><br><span>             {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                const uint64_t hv =3D hash_val=
ue(hash, real);</span><br><span>                 hash_add_fast(hash, bucket=
, &amp;mi-&gt;real, hv, mi);</span><br><span>                 mi-&gt;did_re=
al_hash =3D true;</span><br><span>                 multi_assign_peer_id(m, =
mi);</span><br><span>@@ -258,6 +258,28 @@</span><br><span> }</span><br><spa=
n> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Looks up an multi instance by its real address (IP and port)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m     multi cont=
ext</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param real  =
Address to look up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return      instance matching the NULL otherwise</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+multi_get_instance_real_udp_real(struct multi_context=
 *m, struct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct hash_element *he;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(hash, real);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    he =3D hash_lookup_fast(hash, bucket, real, hv);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return he-&gt;value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get a client in=
stance based on real address=2E  If</span><br><span>  * the instance doesn&=
#39;t exist, create it while</span><br><span>  * maintaining real address h=
ash table atomicity=2E</span><br><span>@@ -273,7 +295,6 @@</span><br><span>=
 </span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;=
m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &=
gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct hash_element *he;</span><br><span>         const uin=
t64_t hv =3D hash_value(hash, &amp;real);</span><br><span>         struct h=
ash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>         uint=
8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -310,17 +3=
31,13 @@</span><br><span>         }</span><br><span>         if (!v2 || pee=
r_id_disabled)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            he =3D hash_lookup_fast(hash, bucket, &amp;=
real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi =
=3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mi =3D multi_get_instance_real_udp_real(m, &amp;=
real);</span><br><span>         }</span><br><span> </span><br><span>       =
  /* we have no existing multi instance for this connection */</span><br><s=
pan>         if (!mi)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            mi =3D handle_connection_attempt(m, =
sock, &amp;real, hv, bucket);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            mi =3D handle_connection_attempt(m, sock, &amp;real, =
bucket);</span><br><span>         }</span><br><span> </span><br><span> #ifd=
ef ENABLE_DEBUG</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
37ade55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1725 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--/sEWUiYa64c=--


--===============6736132011102549992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6736132011102549992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6736132011102549992==--

