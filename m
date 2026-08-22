Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98EDC5B572
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sAZ5FAzTG2+butDgG0u1ku82bFBvsLDGNUvVor/x5ec=; b=HHc7X7jtfOMbmoNLgAo1kKmTzR
	EHn8jcpEXvidLZdANmvv9E+dGAAPZvqQPMcALwBG0zCBGxk/WR6u+MgUFmMw6z97VyMTz4lMV0xWD
	8a2Jq//HPvLWI6bAlfNNL/CCp+FHrWzH7u+GgqcUo/Z/73W7q8UvTYCy5a/ZArjfknoI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxo4M-00023M-B2;
	Sat, 22 Aug 2026 15:55:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxo42-00022j-Po
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 15:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=C4HauEFB8CISD4X2QbjoCmHGCBp4e+DCa4a67b2Hw0c=; b=hKYWNUWAgZ9y3p1dh20ACghfUz
 1+liVeoiE3ZsATICAyOqrQUKLsXdxNN48E7WSg9rIKpWMS90cPShuYEXYJFg+5Ml1h2nFUqLZMIEP
 +XAbsjK7V0NKgpV08i788sXJ0/x5RGrpRhxxIvcH6IMOMsKxSGMZnF5UVZb0OkoVPwMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=C4HauEFB8CISD4X2QbjoCmHGCBp4e+DCa4a67b2Hw0c=; b=T
 NwtBpUiwIWdWAn2Qucqe+wk/YGVdy5SJO56b30ugMb7TtCabY2uOSbRkNW1KBz1jWwwhzDgUFiuZy
 npljGbq72BW/gv0uM1+5hY1nLUqdb7IQmOTs/eWAPQADBAvRWXP2fzW1jw5yGe49YA7ujJbtrCjdf
 KMOkJPJmLVSL3r1w=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxo3p-0003HY-4t for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 15:55:10 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso387395566b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 22 Aug 2026 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787414102; x=1788018902; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C4HauEFB8CISD4X2QbjoCmHGCBp4e+DCa4a67b2Hw0c=;
 b=R+W08O3/dX5ZX3PXrDSfrzaklj04vnvbLNpEBe9xviJDEg5lAakPJxP8SECwNZC3CP
 m67k9GJMJgF2YmfR4ek/YFPXw6dkj934C4a+UTSj0mCGNiXt1V8/jDeN9Xo3Jg1AvQ7q
 PbbEU0oYr//ydBX3XBuhrf98cBa6M1miGg6EUiMqZOl0gqGgYzAxAthNx7vNDttw4zhn
 8/VcayYPwqUWtikiKVoUJS2cSU4wxWGFxqERLRyX3tIYK92/RGXCfQK9sq4yPPsf7iE9
 bwdCMP1nDZ0C+E6JX46KbbL7fhYFXeEvComPuE5U1fLxGzEQhfwKe/Dd36KQZzA0GT0y
 q8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787414102; x=1788018902;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=C4HauEFB8CISD4X2QbjoCmHGCBp4e+DCa4a67b2Hw0c=;
 b=KajSwAC2g9j3GYdaOUyO7QSAYQVyMbuticRWZ+f5ra6MtUJnQ8M3E2LyQRnDX4EVbQ
 63vTBBdmFIHudsd6E8ZKCZB8egJZzaWOwxWq+gxmDEWbvJW3MOoeOYaNXterKMnX+4gw
 1Eat7sJDdFLucO8Ft/uD15qJiySK/KlqZZ6Clxg0qqF4ebUkkV/GoaGMX83QLvK0z+7R
 5HtpQPCubpQavnYcSmHeKD2Q+mGZY76t28xS2WfC8gHIpIQS/DFW3Ewz/SUoLXaRjl3p
 uI3rVGjXBGclxI8kaV3ztDDGhhnkVogcOwnIG/lNJp8Fjb3daR1limUk6wWixgOqvnmp
 10yg==
X-Gm-Message-State: AFuF++n8tHbhERoM+EuOMez4A7D1QLQ6PnSfSXYoPulObQF2UPsGuQAY
 PHtYHbP8Nro73Z524FGx4IVIOU/P5vsHlKtd/iUO91zu/YFkLs83QHskwADq6Qp08qUFOFnx0jc
 4wQ7pLn7K0gOkYcW3ragnlf7WmnFNPNiC57pPqpn9avW6d5l0dPqjNs7pdtIJa3rPwo/l
X-Gm-Gg: AR+sD12bf6wlLkez835yp93VAXXUZhAY8+e038GsadoWGuMk7IjmAaf5rmQLNyMaLfz
 mbw3zFfu8qJZ4cneZS7bZbAcdN5k8ZO1j2TJu/bqulU2babG4RXVDQTkf2i/24zWPmg3oZyvvDo
 DhKon57WEQyVQv1sW0c4Cf1/q4nDnc4W5mrsiFRAl0X2S5oN5a+OJpnunboAtR5tnpb6SG1lS45
 IaKD7dml20o/iglEN99n27T7Rhxt0wTF0IS0MN1OWq5KlOroBsIhcqgMMxqON2LxGOlPZTaZ2RM
 Y2YubeBn5RlI0CiglE5FpLcb1UYiZqNrkG76IhdloyzQR9q3UNM0wFWGVdzOffabXZzyL1zBoHC
 vHo33q1L3/w8ku2r6OMRvsyg9hcoQmzxC3Mu2ZgtmfvbNSbxoYWFf+DnltEgx6PS0akgqgu/v/d
 AZWgUWfnhA/lvSycXm+iGWb1nCha4nFOxkFDBSGmuZCXfedu7tyNNNr0ugN4BCeLyFCvbYXl2U6
 RuJWQiZcyhUD6RX7Lr5pFAOyWCPAVpwx2oTTLH8EDyoY1o86M+sTtG1rtY6nZK+LyqCoiQYUPRF
 Av6hAb1qDG8L+mmsiyBYZRnBC7auL+NaIrGW0AL7goa6Nx+/H3mtjBpJ8PJCiA==
X-Received: by 2002:a17:907:c719:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c246dc5ba9emr1452421766b.6.1787414102406; 
 Sat, 22 Aug 2026 08:55:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295627sm358517866b.15.2026.08.22.08.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:55:01 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 22 Aug 2026 15:54:59 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4068bf8175c23151298d142dc920ab89f861a411
X-Gerrit-Change-Number: 1681
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1681?usp=email>
X-Gerrit-Commit: c797db6225755e6d7144d433ed55d3992d8ff141
In-Reply-To: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
References: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTk3NzUyMDAwLkk0MDY4YmY4MTc1YzIzMTUxMjk4ZDE0MmRjOTIwYWI4OWY4NjFhNDExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec263dbcfec03e456470ff3340f76a603306bf0f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxo3p-0003HY-4t
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clinat: do not
 adjust UDP checksum if zero
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8465446711952169006=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8465446711952169006==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="60bbPp8Anb0="; charset=UTF-8

--60bbPp8Anb0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: clinat: do not adjust UDP checksum if zero
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

clinat: do not adjust =
UDP checksum if zero

As per RFC768, when the UDP checksum is zero, it mean=
s
it was not computed by the source, therefore any NAT
processing along the=
 way should leave the checksum alone
and not update it=2E
Failing to do so =
would result in computing a bogus value=2E

At the same time, if the result=
 of updating a non-zero
checksum ends up being zero, as per the same RFC, w=
e must
store its one-complement (0xFFFF) as zero is reserved
for "checksum =
not computed", as mentioned above=2E

Ensure our Client NAT code follows bo=
th rules=2E

Github: closes OpenVPN/openvpn#1037
Reported-by: Jeff Salee <j=
eff@samjackson=2Ecom>
Change-Id: I4068bf8175c23151298d142dc920ab89f861a411
=
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1681
Message-Id: <20260821182442=2E13542-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg38581=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/clinat=2Ec
1 file changed, 17 insertions(+), 1 del=
etion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/81/1681/2

diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
=
index 32c1325=2E=2E3724022 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/op=
envpn/clinat=2Ec
@@ -258,7 +258,23 @@
         {
             if (BLENZ(ipb=
uf) >=3D sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))
    =
         {
-                ADJUST_CHECKSUM(accumulate, h->u=2Eudp=2Echeck)=
;
+                /* RFC 768: a UDP checksum of 0 means "no checksum compu=
ted"=2E
+                 * Do not run the incremental adjustment over a no=
n-checksum,
+                 * or we will write a bogus non-zero value int=
o the field=2E
+                 */
+                if (h->u=2Eudp=2Echeck=
)
+                {
+                    ADJUST_CHECKSUM(accumulate, h->u=
=2Eudp=2Echeck);
+
+                    if (!h->u=2Eudp=2Echeck)
+         =
           {
+                        /* RFC 768: a computed checksum of 0 =
must be transmitted
+                         * as 0xFFFF (one-complement),=
 because 0 is reserved for
+                         * "no checksum compute=
d"
+                         */
+                        h->u=2Eudp=2Echeck=
 =3D 0xFFFF;
+                    }
+                }
             }
     =
    }
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1681?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I406=
8bf8175c23151298d142dc920ab89f861a411
Gerrit-Change-Number: 1681
Gerrit-Pat=
chSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--60bbPp8Anb0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">clinat: do not adjust UDP check=
sum if zero<br><br>As per RFC768, when the UDP checksum is zero, it means<b=
r>it was not computed by the source, therefore any NAT<br>processing along =
the way should leave the checksum alone<br>and not update it=2E<br>Failing =
to do so would result in computing a bogus value=2E<br><br>At the same time=
, if the result of updating a non-zero<br>checksum ends up being zero, as p=
er the same RFC, we must<br>store its one-complement (0xFFFF) as zero is re=
served<br>for &quot;checksum not computed&quot;, as mentioned above=2E<br><=
br>Ensure our Client NAT code follows both rules=2E<br><br>Github: closes O=
penVPN/openvpn#1037<br>Reported-by: Jeff Salee &lt;jeff@samjackson=2Ecom&gt=
;<br>Change-Id: I4068bf8175c23151298d142dc920ab89f861a411<br>Signed-off-by:=
 Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1681<br>Message-Id: &lt;20260821182442=2E13542-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38581=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/clinat=2Ec<br>1 file=
 changed, 17 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1681/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><s=
pan>index 32c1325=2E=2E3724022 100644</span><br><span>--- a/src/openvpn/cli=
nat=2Ec</span><br><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -25=
8,7 +258,23 @@</span><br><span>         {</span><br><span>             if (=
BLENZ(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_u=
dphdr))</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                ADJUST_CHECKSUM(accumulate, h-&gt;u=2Eudp=
=2Echeck);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       /* RFC 768: a UDP checksum of 0 means &quot;no checksum computed&quo=
t;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   * Do not run the incremental adjustment over a non-checksum,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 * or we will w=
rite a bogus non-zero value into the field=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                if (h-&gt;u=2Eudp=2Echeck)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    ADJUST_C=
HECKSUM(accumulate, h-&gt;u=2Eudp=2Echeck);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    if (!h-&gt;u=2Eudp=2Echeck)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        /* RFC 768: a c=
omputed checksum of 0 must be transmitted</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                         * as 0xFFFF (one-complement)=
, because 0 is reserved for</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         * &quot;no checksum computed&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                         */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     h-&gt;u=2Eudp=2Echeck =3D 0xFFFF;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                }</span><br><span>             }</span=
><br><span>         }</span><br><span>     }</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
681?usp=3Demail">change 1681</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1681?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I4068bf8175c23151298d142dc920ab89f861a411 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1681 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--60bbPp8Anb0=--


--===============8465446711952169006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8465446711952169006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8465446711952169006==--

