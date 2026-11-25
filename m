Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A743606A32E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fbosaG72;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IhP8tTQt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SEUJO9hu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T8Arin4M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WSewbgU74sQvGFbedciFCSzRuj15mfltG3zPPfVN1nk=; b=fbosaG72V6v+nze828gL0Pi93e
	lMooXVwjh0JHEXws2HNe3fZaeuRUR98DHjraY/jQCqqDhH7Hsrgbft5h5YifcWVeCpbj1RL04rFLq
	b+WpGhCM3J7d65JleYYVOKGADR6Ao3j3tSPbMZdQ9lWm8F+DJvALd5GO38xXJmHUoqMI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWG7U-000000003Fh-2xSP;
	Wed, 25 Nov 2026 16:45:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWG6s-000000003ED-1w9S
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=54sH9bBgQUjL6/qO7pTTJ0H1lwvcSbK/9gjXHksy8xI=; b=IhP8tTQtmXupWkcNJ1QZ94CTUe
 pSUFOP35a2HzEfops1meXDEW1B7sYoI/lvw6zYdToZmd4rMv/AFNohy/NCdLXu4fcV2QGhsTDYfjt
 x9zUEsLtyAHlMsouwA7so+ryrj/LcGzQFOFlnbgFe3VM3O9OwevNnieJDo75jHqGH1EM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=54sH9bBgQUjL6/qO7pTTJ0H1lwvcSbK/9gjXHksy8xI=; b=SEUJO9huYflEzzaVOFPZAXVEYp
 IzQ0d4166ISOTXdJSaas2499j2hY4sYYEa39XwxxrjwP6yU0SbdrfitEDFEZDJWoq3tzdE2eAg2gQ
 hIRlqx1AyFRId4XVFU6N+1a3faM/UnCKE4PZcpAeU4q2XM+IVpGghj+FJ9XiumnguHrU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWG6r-000000004nT-17us for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:41 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so55000475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795625075; x=1796229875; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=54sH9bBgQUjL6/qO7pTTJ0H1lwvcSbK/9gjXHksy8xI=;
 b=T8Arin4MLZJdpBh3M8YMM9dMt9UdVNW9lISxpOlmtJeg2CD8QWvKK0PbG2QkH1UMQP
 rqQQ97WS3XUDYksghNs8uFbxBxMIfdG6kBUplZoWeIZWHw2RvaGYc+scU70zXNG/3BFM
 r4GWsFoo/z3NN+M7Um0YKVsz7xF4KLy2WqLtErb89/UCYHFDEi4GpmYGmPbuNXPfHIHy
 DQrl2AIhRQJ11JKa8ypwiYJN7gwXk9F1fNf6Qx8n7zToa8S4Ztq2NTjuvo5+jfV58zKR
 ccH5FyCkhBDxdEOTcD70llooa7FH80pXANRCxCg9hslP10pCYs9XgZrVYYKiN31f8O3y
 ss9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795625075; x=1796229875;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=54sH9bBgQUjL6/qO7pTTJ0H1lwvcSbK/9gjXHksy8xI=;
 b=XPxW90P/ij5x7IX7Z34nPkzv2Sp2h9C+AFuJ1pKMz15sv7/tIPqReXzOtT7svlwKv5
 XRLQ6q/KZHVJ3smEQx4ta9HXTNM8XM0Hm3IRyIYC4K285WM34zuBiidES6o3RvG2L4ZB
 uUrrQn+Fg3SCu12wo263o2l+Csh4ZqMPXgh55hjgeRs4F03I7vj6g3s79nRnIFGz0YDL
 sX+rJw3CjvEg5G8/MPz3eNBrAnSKwb/gsCpVFQvxYYedkkh723hPHZMNZ7ZEYwSpoopB
 Jsu0J/pBSsabeBBOPkqMCcwXS+VmfEof0711TaATIZjunfF5pmi1KZpu/0nKvgS9F0bS
 UsVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFCaTad8whZGFwR9qKC8OEHm/k5hDfSsChiXQvEPyA8h1EpSII7Ld1fQUO0pOacOqsniGVw9qwVGWuXdoM5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+0cjhcFxDNj+sFLitfiQ32WxB+cq4tNmOQMLOUxq5W8DbZX79B
 RNU6QLwJcLQS0OQCB02ECtp6E60i7nn6CitWn2gLUzBJ6zK+0GU3AK2CEu3FMSogPWLQ0xWGXMv
 fCSUlOpQeJ69LVhiRTt7xfDymdAdEw5Jcx4Lasf/f8dUHaR7kLm6WqHSS8FxnJBlvf/Pl
X-Gm-Gg: AZFdTZcP331myNTk9U9ntMPca9WtonIqwiEWGIpyW/hVoEphVrjZte6th5V9Rhk9Ihg
 nqycs2W+BsYucO9OT7rXHENy6LBMuWNxJReH6SNG4BOoudulpN3p6pOtnEE1AviMDMesOafjWXE
 ULcOL6Mg4gp0y9Qp13R85jnU8/T7k0fTehJyM7m7wrjhmuzB94LaWbZIqs1tHtfOTCqHqY/I7t6
 LfH0kndmdgsIu1/ittzUcaoGhwdHZVuJVvU8gev1YcCId76vjoUCtdR4MjOlYCJqBGlVhqYD6zb
 QqFTTKEGynKDOOaObHFQYQlK/zb2EFSVbvl+hwqyj2G+SW7wngsZex8+njZircYhv97TT0KoaTg
 1bfDDYxfLJJ0xzqHIbVnKElE8bQJdSYtwUtYfE0iSUnRg/eWDH3Ze2VGmEx43fe7/8PpZz8YTOi
 D8NCYTeQD8w8LM7kALuut3pJlFrVqJWxcpLO5emcmwb7AuFHFdPhePiRM10/+GUhnGx3py+w3eE
 ruxgUo594bf6rSbadeZoye3ewij+w+7/33S7DnxBpsxnNIQIkXn2RdQxrK6XfcjfAWiczZr9t2n
 R92unxrcuDm2T9U1FCUZf8mJ85VFX4DKtVvJhx7trmJewQy9aJo6wxNamRxpYLH3T9sWeTeaNTj
 uI9o1uLojWt9CLMtlpZg6vklwI9tC+/8OaTDl2SxmJodiKYgoo6yhgasavPnEQF5K+qEBQnf8X5
 jqE7S9E+zPlun+4es=
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4bb887c9fbamr390948625e9.3.1795625074578; 
 Wed, 25 Nov 2026 08:44:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dcf9sm35083081f8f.32.2026.11.25.08.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:44:34 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:44:33 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
X-Gerrit-Change-Number: 2337
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2337?usp=email>
X-Gerrit-Commit: c73bdd7387f097c1ffb421456a21a923fcb01f8d
In-Reply-To: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
References: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTI5Nzg2MDAwLkljYjkxM2Q2ZTg5MDYwN2M3OWE0NWEwZTYzZTlhMWJhNDQxNTFlOGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5119f530de1d6d8eac64af28c15af4e6f8dc2c9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWG6r-000000004nT-17us
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4627307739111158387=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4627307739111158387==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jvgjqvgseic="; charset=UTF-8

--Jvgjqvgseic=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2337?usp=3Demail )

Change subject: list: drop redundant check =
in hash_iterator_next()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

list: drop redundant check in hash_iterator_next()

hi->elem is =
set from b->list, which was just checked to be non-NULL=2E

Change-Id: Icb9=
13d6e890607c79a45a0e63e9a1ba44151e8e2
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337
Message-Id: <20261=
124142352=2E20244-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41884=2Ehtml
Signed-off-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/list=2Ec
1 fil=
e changed, 3 insertions(+), 6 deletions(-)




diff --git a/src/openvpn/lis=
t=2Ec b/src/openvpn/list=2Ec
index dcd59d7=2E=2E505be30 100644
--- a/src/op=
envpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -294,12 +294,9 @@
            =
 {
                 hash_iterator_lock(hi, b);
                 hi->elem =
=3D b->list;
-                if (hi->elem)
-                {
-           =
         ret =3D hi->elem;
-                    hash_iterator_advance(hi);
=
-                    break;
-                }
+                ret =3D hi-=
>elem;
+                hash_iterator_advance(hi);
+                break;
=
             }
         }
     }

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2337?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
Gerrit-Change-Number=
: 2337
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--Jvgjqvgseic=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2337?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">list: drop redundant check in hash=
_iterator_next()<br><br>hi-&gt;elem is set from b-&gt;list, which was just =
checked to be non-NULL=2E<br><br>Change-Id: Icb913d6e890607c79a45a0e63e9a1b=
a44151e8e2<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337<br>Message-Id: &lt;20261=
124142352=2E20244-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41884=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/list=2Ec<br>1 file changed, 3 insertions(+), 6 deletions(-)<br><br><=
/pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br=
><span>index dcd59d7=2E=2E505be30 100644</span><br><span>--- a/src/openvpn/=
list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -294=
,12 +294,9 @@</span><br><span>             {</span><br><span>              =
   hash_iterator_lock(hi, b);</span><br><span>                 hi-&gt;elem =
=3D b-&gt;list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          if (hi-&gt;elem)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    ret =3D hi-&gt;elem;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    hash_iterator_advance(hi);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    break;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                ret =3D hi-=
&gt;elem;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      hash_iterator_advance(hi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                break;</span><br><span>             }</span><b=
r><span>         }</span><br><span>     }</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Demail">ch=
ange 2337</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2337 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--Jvgjqvgseic=--


--===============4627307739111158387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4627307739111158387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4627307739111158387==--

