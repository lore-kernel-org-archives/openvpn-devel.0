Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBCBC55168
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=unkiZHEmxn44Ja4vqdvj/x9/0Zj6SoG5pqTIL367rGY=; b=bvvjLPR544amq0fsWopy0FQNxS
	bsqiHD+cPceALZCSPQztBxjXkgQTYy+x2fMvx8qxMtDzQFmTOm/m9P8QJdtOhv7J088SiGxKoYz8i
	l92OOMbjGlbHcKbPICm8uUE9yWohN4SW4MACPp5BUOTlnCGtpP4bVYhogTqeUGmBco+E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPUZ-00010g-Nk;
	Thu, 30 Jul 2026 12:04:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPUY-00010F-A7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GgXCerdSIY0Lwq0qVzj+jVpbtbjQ7lQxvO9FMNVnc6s=; b=Lhwk2rzUVE3TSkMIKAU+7bax41
 58x5xR4qpdnSVuySSWQKwu3fgKUgtRaTpbUZRiGOx1IQ+EYWsj8eCglIUzsmbq9U+yqRkOs7fatHz
 5EcHcHSJO37yxlCv6yvnPu8AInNfzQbv1WpIG7k9Ez5RtIYvnk8LQerjZXFCJGEpflS0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GgXCerdSIY0Lwq0qVzj+jVpbtbjQ7lQxvO9FMNVnc6s=; b=k
 P66flt5FI9zNqHh9vSUV40o8Oh/Xdr7DHWXkLw2IzRT2cF7gQLOKjdNqEI2Uqo5I9qurUMjNfve+T
 8CTT0wsUhRn791Z4bAvfYmCKasVf3qPF2QqTMdqu0SUQFvifZtVXafHHfNkSiAduM/obZu+H/vCx5
 UfSutxTqcVi6hOr4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPUX-0008R5-AK for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:03 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso669989f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785413035; x=1786017835; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GgXCerdSIY0Lwq0qVzj+jVpbtbjQ7lQxvO9FMNVnc6s=;
 b=EKHA7VJB4Pmd3uzJ5S++PFFwQNkdiR9kfKsFpXab8jgMW4W7yetGXE8n/XQlKkNUNE
 zrymZQJpnQN/8pgUtc4erF+ef/j3BH+Br4RLEPccAoHZ9TXMrhAP+vB5K6TPLyCjtq0w
 +jRT3PSJUNzE5V176OGCmcxJBaIOzbYE7b9R0HKtRwGfxqVeF8umlMcvs9wBxnrxDGAv
 QHYhBRJmuhkG2mPO3PQcjgHdNibaLu2dsoiwUSAV+Us875xvUTsumfUDQukmwufu7Z4T
 291O67M6G5qmxUkv/plcTQmt12LW6RbnweBNFzijna/Og0DDs4J0mU6yYZnCI85zUvAl
 YThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785413035; x=1786017835;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GgXCerdSIY0Lwq0qVzj+jVpbtbjQ7lQxvO9FMNVnc6s=;
 b=rxG9nNlc+o7Ykoo0KdyEUAHpcPg1m5nx/wrLJjx1evU6TDLpwLXXE8cxsYYFCEiCjW
 6OqQL23FW3OpVwlX7TcBM9mwXnTP5LUET8ViVXhyuLhe47hjFQK94NNGkq0D8tKlF9h6
 5mF+YhA6r6VjZMW2xP+Mg9UbCzfFWehh7rrCo2E8A7xSwH56Stqe3GoE3DXRiStNRO7d
 4Ri18zV5Xfey72vf+fHEHRkQJ48ETvFR+yTi/WAB5hL1YklLXuYaxnoXQkvZxkYWoM4T
 L8/20rNzS0YfDD3YVkCFVx2kSqYpzCS3I+0AZHQHIJ+sX4XKbqMVYIc0C8FU80LbjLDl
 UioA==
X-Gm-Message-State: AOJu0YxFzRLQkYeZqYsKohhAJKGobHmYNOjET0cGvg4Z1NvHSxk+9Lo0
 TntUSRPaQRLZUUQSDj4RnBK83QrrIE18rAQdGzKqCVSm4mGSmKC0tNooDG9182TISaODSa0WKJ5
 laJrQnAYTlNRnWHUoVS2lh1CWg0ZxeJ5U7pJM5TevVR/TVaxa1uyEeGMZUOVPu8BHVODq+w+P6a
 AS/jM5rQ==
X-Gm-Gg: AR+sD11bDp0utz4mqy9vJDGwgRlk5A0uaamoDQEV3A4r1Z9fmA70Vqa6wGW6J/tNkB+
 IG01rmTSy9p1chH8Asuop585W+pqTBdhrVSij/oysNqahC/CxNQbyEuSQzvwH7p7Kxp0HRrxWnY
 Dg7bDAzfwU7vWHdv7vge7zezoVc4VYR1f94K8Z/c2MPAciu7+o6DTqSzqjhyrgrsjCKpw8H78nH
 lWFOKh753BFoPWceQQKfSjGddkhK+iTeoBJgfocPrbX3Ojk8/1gcPLwcyUFmbcrJ/28AgKpCopu
 04bJWympeL6HxXU+4Gj1xH7VrlntenbdZp63EJI1O4813qp0hJpw/xWQSacGXhrWqXH88RNwf+a
 oeuyC/Htr1kUuWKGXdEnABmLj/LGFzA1tO71tZ+BKGXuMOHjSclogHV8gzaFpnDYmAAOf9JCAXb
 GYOPcJ1Puxznbz2l5q/AXf+46twkM8t0rEXg++SWDBjCnylX7IYYbtDJyEkqLi4Pl44IQgQ+ofq
 0bWpIXr9V2CuM3n/37Hj1vOMh7W4in9m9Rq6hbH0wWv1ozW9+o19Xt02xO2UJyfnbj8xYUIsfES
 3oESX/BsqHVMaFs//M2CSPAFGekaBsvVAGJyPkJ0UqMdiGCmLBn0jeGQlw1ZIg==
X-Received: by 2002:a05:6000:46cf:b0:47f:964f:870a with SMTP id
 ffacd0b85a97d-47fcbcc119fmr56054f8f.27.1785413034506; 
 Thu, 30 Jul 2026 05:03:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc877dafasm5372606f8f.0.2026.07.30.05.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:03:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:03:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 9b3bccb8686ba63bad666d1dfc6f621a2b72f2d5
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a409f8209872278fb5d90471d3f59e86c215e53e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPUX-0008R5-AK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_udp_real method
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
Content-Type: multipart/mixed; boundary="===============0320761490492325123=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0320761490492325123==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ov2EaacHJpM="; charset=UTF-8

--ov2EaacHJpM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1725?usp=3Demail

to look at the new patch set (#15)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Extract multi_get_instance_udp_real method
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract multi=
_get_instance_udp_real method

This is just a small refactoring to make the=
 code a little bit
better organised=2E

Change-Id: I37ade55d7674c68dd98cf4d=
fde35c4ad42e20d39
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M sr=
c/openvpn/mudp=2Ec
1 file changed, 25 insertions(+), 8 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1725/15

d=
iff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index b64cdd7=2E=2E=
596a458 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -20=
5,7 +205,6 @@
 handle_connection_attempt(struct multi_context *m,
         =
                  struct link_socket *sock,
                           stru=
ct mroute_addr *real,
-                          const uint64_t hv,
       =
                    struct hash_bucket *bucket)
 {
     struct hash *hash =
=3D m->hash;
@@ -236,6 +235,7 @@
             mi =3D multi_create_instance(=
m, real, sock);
             if (mi)
             {
+                const =
uint64_t hv =3D hash_value(hash, real);
                 hash_add_fast(hash=
, bucket, &mi->real, hv, mi);
                 mi->did_real_hash =3D true;
=
                 multi_assign_peer_id(m, mi);
@@ -265,6 +265,28 @@
 }
 
 /*=
*
+ * Looks up an multi instance by its real address (IP and port)
+ * @par=
am m     multi context
+ * @param real  Address to look up
+ * @return     =
 instance matching the address, NULL otherwise
+ */
+static struct multi_in=
stance *
+multi_get_instance_udp_real(struct multi_context *m, struct mrout=
e_addr *real)
+{
+    struct hash *hash =3D m->hash;
+    struct hash_eleme=
nt *he;
+    const uint64_t hv =3D hash_value(hash, real);
+    struct hash=
_bucket *bucket =3D hash_bucket(hash, hv);
+    he =3D hash_lookup_fast(has=
h, bucket, real, hv);
+    if (he)
+    {
+        return he->value;
+    }=

+    return NULL;
+}
+
+
+/**
  * Get a client instance based on real addr=
ess=2E  If
  * the instance doesn't exist, create it while
  * maintaining =
real address hash table atomicity=2E
@@ -280,7 +302,6 @@
 
     if (mroute_=
extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=
=2Ec2=2Ebuf=2Elen > 0)
     {
-        struct hash_element *he;
         co=
nst uint64_t hv =3D hash_value(hash, &real);
         struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);
         uint8_t *ptr =3D BPTR(&m->top=2Ec=
2=2Ebuf);
@@ -317,17 +338,13 @@
         }
         if (!v2 || peer_id_disa=
bled)
         {
-            he =3D hash_lookup_fast(hash, bucket, &real, =
hv);
-            if (he)
-            {
-                mi =3D (struct mu=
lti_instance *)he->value;
-            }
+            mi =3D multi_get_inst=
ance_udp_real(m, &real);
         }
 
         /* we have no existing multi=
 instance for this connection */
         if (!mi)
         {
-            =
mi =3D handle_connection_attempt(m, sock, &real, hv, bucket);
+            =
mi =3D handle_connection_attempt(m, sock, &real, bucket);
         }
 
 #if=
def ENABLE_DEBUG

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1725?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number: 1725
Gerrit=
-PatchSet: 15
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>

--ov2EaacHJpM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #15</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>The change is n=
o longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Extract multi_get_instance_udp_real method<br><br>This is just a =
small refactoring to make the code a little bit<br>better organised=2E<br><=
br>Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39<br>Signed-off-by: A=
rne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>=
1 file changed, 25 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1725/1=
5</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><b=
r><span>index b64cdd7=2E=2E596a458 100644</span><br><span>--- a/src/openvpn=
/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -20=
5,7 +205,6 @@</span><br><span> handle_connection_attempt(struct multi_conte=
xt *m,</span><br><span>                           struct link_socket *sock,=
</span><br><span>                           struct mroute_addr *real,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                          c=
onst uint64_t hv,</span><br><span>                           struct hash_bu=
cket *bucket)</span><br><span> {</span><br><span>     struct hash *hash =3D=
 m-&gt;hash;</span><br><span>@@ -236,6 +235,7 @@</span><br><span>          =
   mi =3D multi_create_instance(m, real, sock);</span><br><span>           =
  if (mi)</span><br><span>             {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                const uint64_t hv =3D hash_value(hash,=
 real);</span><br><span>                 hash_add_fast(hash, bucket, &amp;m=
i-&gt;real, hv, mi);</span><br><span>                 mi-&gt;did_real_hash =
=3D true;</span><br><span>                 multi_assign_peer_id(m, mi);</sp=
an><br><span>@@ -265,6 +265,28 @@</span><br><span> }</span><br><span> </spa=
n><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Looks up an multi instance by its real address (IP and port)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param m     multi context</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param real  Address =
to look up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n      instance matching the address, NULL otherwise</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static struct multi_instance *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_get_instance_udp_real(struct multi_conte=
xt *m, struct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct hash_element *he;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(hash, real);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket =
*bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    he =3D hash_lookup_fast(hash, bucket, real, hv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return he-&gt;value;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get a client i=
nstance based on real address=2E  If</span><br><span>  * the instance doesn=
&#39;t exist, create it while</span><br><span>  * maintaining real address =
hash table atomicity=2E</span><br><span>@@ -280,7 +302,6 @@</span><br><span=
> </span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp=
;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen =
&gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct hash_element *he;</span><br><span>         const ui=
nt64_t hv =3D hash_value(hash, &amp;real);</span><br><span>         struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>         uin=
t8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -317,17 +=
338,13 @@</span><br><span>         }</span><br><span>         if (!v2 || pe=
er_id_disabled)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            he =3D hash_lookup_fast(hash, bucket, &amp=
;real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi =
=3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mi =3D multi_get_instance_udp_real(m, &amp;real)=
;</span><br><span>         }</span><br><span> </span><br><span>         /* =
we have no existing multi instance for this connection */</span><br><span> =
        if (!mi)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            mi =3D handle_connection_attempt(m, sock,=
 &amp;real, hv, bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            mi =3D handle_connection_attempt(m, sock, &amp;real, bucke=
t);</span><br><span>         }</span><br><span> </span><br><span> #ifdef EN=
ABLE_DEBUG</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ad=
e55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1725 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ov2EaacHJpM=--


--===============0320761490492325123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0320761490492325123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0320761490492325123==--

