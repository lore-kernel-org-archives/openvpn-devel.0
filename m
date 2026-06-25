Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE3CCDE000
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=naTfSvH048dE05RCXFikQZk+r6r8XVPDu+8/j3LO4lc=; b=LzBDhoAPqZwc13z759pQ0yxbME
	ABHoMlFiWCN1niQKMhXRyocvbvfOgKzdfROzWeeVHLOv8nfsIZzzHt0mXYYXp/SiG1ebt8PxGsLmG
	Ayhig53mu4vbgPisKDF58yThVIO5L6GeNejBjZxReriBx+AhiPypIskHm0c6+7xZSGJY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckGt-0004Fj-Bk;
	Thu, 25 Jun 2026 13:37:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckGs-0004Fc-HT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/x2w+sBMwM0Xkd7Y3baPF5tnfWz/NlCxFsFc19nMOF8=; b=CpJGK76NF9uKLPzdC3KF9pp6pF
 V1JDXBhSOBY2/RWtAooF9piKbCyxWpWehT3PPswPB8Ij9QS5/CZqD0y+gpKuqZsoMUn0g6ImkhxOg
 objJkD8n3nq7xthoEm7KeUaB9cTjoeyoL6NKDmTrezY0Jxk7kSmhhbC2po4kmUsKBFLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/x2w+sBMwM0Xkd7Y3baPF5tnfWz/NlCxFsFc19nMOF8=; b=U
 p2c9v7QE0ZS8nZ+JeBU926t41qPHKKrn+waJdJkXevo8pVA+ckzyLLZnLQbxqzqi+MU114IMYRD75
 eXrLf90f12xD4daE6JnUqoFck1WDRo78pVKp/8wL7EH04DjDlgHdejGe+tyBBF/uyNUXyMQ5RJE96
 UF3g2QDbStKAUsVE=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckGr-0001IG-1Y for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:35 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-46db3c9a9e0so551815f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394642; x=1782999442; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/x2w+sBMwM0Xkd7Y3baPF5tnfWz/NlCxFsFc19nMOF8=;
 b=D8fCeZCIWANrpV4Iysb2rvkjqdWSlS6BWpYKS4j19tVpz6MO5EeCW0EbYrM6kWDfBN
 t4Bn7iFuflBIit7aCGaUd2RZVEkDq1LcojkXo/Rt1zG7mmxzj51dIVQYEwmB3zDXiZgp
 u5EBigJfKpvU5IXt8mWNJLV0woEUJVmTVJZSLipNfiUVsociBidxR4wVXSVIlrqN9F9k
 EePrRHoYCaLB20HOpiOHeJBXMOudGfjftVCVB28Fv1xI38XiWOrX9EoIS20ZSsXeesZb
 JYaS9k2Bh7f1JfpOA2kkiK3HmQh7HDTmt3/Yo9RuVjRhM9+2/nKGtuv429Zs65f9wqYV
 NQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394642; x=1782999442;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/x2w+sBMwM0Xkd7Y3baPF5tnfWz/NlCxFsFc19nMOF8=;
 b=mV7t0YQUXPIEIaBYi86DHUAbBpcCC+H47IEvl1ugSw30FDXQGHrHfZMIYT5RfuZmEH
 gthCSmG34pQadXLV8IZYdtosZEmelR2hXQE0WdnT+nvHmDh0x6lPgu+fNev3yjwdkZlG
 Pz10naimosRAS99NS7WAok2ipJ969qftD91LJOHSsNAP6amOocni3+Bpv2fDGSCGh7hA
 AdA7ZMJrGAjyxc6eMxUmD9VMYkQTfPeYJreGIs0yJA6OgTb373gP1FEFqgFy/f3fU301
 2LdjCTft66evraPrJ+7jA2vp/iQONOGWHzCdCntTuSNMUtyMVVfUYK3NN+JGnk+LXZTq
 EgSw==
X-Gm-Message-State: AOJu0YwD/C1QTOXmISrNN8NEmzvJ8suGvFDcINZ8hTP8AE34O5uQFNjM
 UG5CZ4u8WP87AT/H9ffn2XPa+QN29rwynmCDazX6wSpfkrTzbgOlCw2vQQp9aQ3TVfjvmWgDaNG
 HunMkVxTXrsCYXzNgRJvdS1O61jObOe99YERlf17LL27+9InKQZIBiIr9VO61VzzySWQSKUHOpI
 g7bhUDqA==
X-Gm-Gg: AfdE7cl1cYogUEw3VUpDIOoh2nX7UssfqTfgEsrBw4d42P4s4iUH21gRdqw+4rRI7kz
 8uarFE9Ko/mXl0+tlld7EiiNQUn/+czqYYLoZR/LiN+dnpnUH5rZFQtsPioklyjvs630obxRjhR
 4PUtE9/xDUw3HckQt0fxIqfM9YhOeBuU3wVcLCe2MrI42x1PiMIabADTcrLiIW16/uwLq70MHGE
 QsCHR7LuPrh+rXahzwvSZOmWumujajHp9s3lw0ioq/IGruvTJ86Goe9rH8jlQdBOJBmUdWSYxqT
 xUnoSi+BRrbWnoJodAsPAb8kf0nU0rqCkv0AWN7GeZaMrZCElSbvvL6PUHHc3UychpT9Lry0C2Y
 O81KUYXeUFgYTujkTiZ5QX0k0MkucnLzrMKyr/GcPnWuFF87CvXeeygl4JyvdQ06wQWCLDFMxF6
 evVp+JO4+/nogzJPbnM+dw0SJ0fgFHSswKGj7CTQslZ77dqLXspuamWw10NR8SJoqdUjeKfMJPB
 7msBiYIWSrKAHoyMwN9N0oIJ0LdAZE/3Net1AeEXAnaHFhML1aAo/5PiN2NRC5+WbPm9r2mWrut
 nnw=
X-Received: by 2002:a05:6000:430b:b0:461:a1e7:28d2 with SMTP id
 ffacd0b85a97d-46dc0e0370fmr3663404f8f.15.1782394641723; 
 Thu, 25 Jun 2026 06:37:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9f240c3dsm14297793f8f.35.2026.06.25.06.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 02696a6a2bd8999aa0d98b52d9eeaa314fc4843d
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54d6517f58d31a1d4363c3fbcc20d7eddf6c2b3e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckGr-0001IG-1Y
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
Content-Type: multipart/mixed; boundary="===============6963194862677294446=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6963194862677294446==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NKlnRzIPo7g="; charset=UTF-8

--NKlnRzIPo7g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1725?usp=3Demail

to look at the new patch set (#3=
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
es/25/1725/3

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
inde=
x 7d4fee1=2E=2Ee867ffe 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/=
mudp=2Ec
@@ -205,7 +205,6 @@
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
@@ -236,6 +235,7 @@
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
@@ -265,6 +265,=
28 @@
 }
 
 /**
+ * Looks up an multi instance by its real address (IP and =
port)
+ * @param m     multi context
+ * @param real  Address to look up
+ =
* @return      instance matching the address, NULL otherwise
+ */
+static s=
truct multi_instance *
+multi_get_instance_udp_real(struct multi_context *m=
, struct mroute_addr *real)
+{
+    struct hash *hash =3D m->hash;
+    str=
uct hash_element *he;
+    const uint64_t hv =3D hash_value(hash, real);
+ =
   struct hash_bucket *bucket =3D hash_bucket(hash, hv);
+    he =3D hash_l=
ookup_fast(hash, bucket, real, hv);
+    if (he)
+    {
+        return he-=
>value;
+    }
+    return NULL;
+}
+
+
+/**
  * Get a client instance base=
d on real address=2E  If
  * the instance doesn't exist, create it while
  =
* maintaining real address hash table atomicity=2E
@@ -280,7 +302,6 @@
 
  =
   if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, t=
rue) && m->top=2Ec2=2Ebuf=2Elen > 0)
     {
-        struct hash_element *h=
e;
         const uint64_t hv =3D hash_value(hash, &real);
         struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);
         uint8_t *ptr =3D BP=
TR(&m->top=2Ec2=2Ebuf);
@@ -317,17 +338,13 @@
         }
         if (!v2 |=
| peer_id_disabled)
         {
-            he =3D hash_lookup_fast(hash, b=
ucket, &real, hv);
-            if (he)
-            {
-                mi =
=3D (struct multi_instance *)he->value;
-            }
+            mi =3D =
multi_get_instance_udp_real(m, &real);
         }
 
         /* we have no =
existing multi instance for this connection */
         if (!mi)
         {=

-            mi =3D handle_connection_attempt(m, sock, &real, hv, bucket);=

+            mi =3D handle_connection_attempt(m, sock, &real, bucket);
   =
      }
 
 #ifdef ENABLE_DEBUG

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Numb=
er: 1725
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>

--NKlnRzIPo7g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
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
25/1725/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec<=
/span><br><span>index 7d4fee1=2E=2Ee867ffe 100644</span><br><span>--- a/src=
/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><spa=
n>@@ -205,7 +205,6 @@</span><br><span> handle_connection_attempt(struct mul=
ti_context *m,</span><br><span>                           struct link_socke=
t *sock,</span><br><span>                           struct mroute_addr *rea=
l,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
       const uint64_t hv,</span><br><span>                           struct=
 hash_bucket *bucket)</span><br><span> {</span><br><span>     struct hash *=
hash =3D m-&gt;hash;</span><br><span>@@ -236,6 +235,7 @@</span><br><span>  =
           mi =3D multi_create_instance(m, real, sock);</span><br><span>   =
          if (mi)</span><br><span>             {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                const uint64_t hv =3D hash_val=
ue(hash, real);</span><br><span>                 hash_add_fast(hash, bucket=
, &amp;mi-&gt;real, hv, mi);</span><br><span>                 mi-&gt;did_re=
al_hash =3D true;</span><br><span>                 multi_assign_peer_id(m, =
mi);</span><br><span>@@ -265,6 +265,28 @@</span><br><span> }</span><br><spa=
n> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Looks up an multi instance by its real address (IP and port)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m     multi cont=
ext</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param real  =
Address to look up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return      instance matching the address, NULL otherwise</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static struct multi_instance *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_real(struct mult=
i_context *m, struct mroute_addr *real)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct hash_element *he;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(hash, rea=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_=
bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    he =3D hash_lookup_fast(hash, bucket, real, hv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return he-&gt;value;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get a =
client instance based on real address=2E  If</span><br><span>  * the instan=
ce doesn&#39;t exist, create it while</span><br><span>  * maintaining real =
address hash table atomicity=2E</span><br><span>@@ -280,7 +302,6 @@</span><=
br><span> </span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;re=
al, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebu=
f=2Elen &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct hash_element *he;</span><br><span>         =
const uint64_t hv =3D hash_value(hash, &amp;real);</span><br><span>        =
 struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>    =
     uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -=
317,17 +338,13 @@</span><br><span>         }</span><br><span>         if (!=
v2 || peer_id_disabled)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            he =3D hash_lookup_fast(hash, buck=
et, &amp;real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    mi =3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            mi =3D multi_get_instance_udp_real(m, &am=
p;real);</span><br><span>         }</span><br><span> </span><br><span>     =
    /* we have no existing multi instance for this connection */</span><br>=
<span>         if (!mi)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            mi =3D handle_connection_attempt(m=
, sock, &amp;real, hv, bucket);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi =3D handle_connection_attempt(m, sock, &amp;real=
, bucket);</span><br><span>         }</span><br><span> </span><br><span> #i=
fdef ENABLE_DEBUG</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 172=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I37ade55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1725 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--NKlnRzIPo7g=--


--===============6963194862677294446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6963194862677294446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6963194862677294446==--

