Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9854CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pyNtWcEoJzrMlZyHLLqHu6ibqUd0ttzTdK6S294Zk/Y=; b=bqTNoRFYprqvEnq7Th8kCDbN8W
	Y5yeZj6U+IjV4ozZBC6/NWXFyHfOHHKI97E6Z9hnJiFGaIpI9Mv4CiW4IYjBW9EjuniEbRHHJJJ+D
	s3kHoG1dYdAW8mDoVS6KZbZ7TwO2EdSHLBY1GXXUCF1IsJ65ceuMYheGIgx78ezw4JMw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIS2J-0000Vm-Hr;
	Sun, 18 Oct 2026 14:38:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIS2J-0000Vd-0T
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NPpm3zDkkVSZs45LbKytNXGTSu54DfdAecTE9Im1IGU=; b=idDtD8vYgiKD/idwGontruWFL8
 8qMuy9rwHnPWZfJOAwClkG/RtWK+To/N+gQq2BmxqvNzQ+D1mDQyGDzhSinjo8oLbKbVoMZr5MxHa
 FyVaLcXy2iz8L//JSwix0y1wpF0E16unLvPOyn18tallouO3mmxEC4+GQvUTj6MmOriQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NPpm3zDkkVSZs45LbKytNXGTSu54DfdAecTE9Im1IGU=; b=f
 vgZoas8Tg8fnMuJ8c+mdtn1cUvlUG5l82xxJIyiefD6eGIkg85Z89RG85BLkP+QXO/THGkx+qcYx1
 VE0VSUbYjs0HSL6QWMqKwtSimI5ZLjR39OADI5BOuYk543KDekspb+zoVtvuuYZR5ZQkcPWG3JSPh
 5gWvgEVm/uAoW0Dc=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIS2I-00007f-75 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:38:54 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso618420f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792334328; x=1792939128; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NPpm3zDkkVSZs45LbKytNXGTSu54DfdAecTE9Im1IGU=;
 b=ejjELxacOzihhhucGlxtWwR/IcF+nuaAL/YOhb++KGW8+L9j6tzRU9HmonbjM4n8zO
 HgbliEEBM1+h/bjy9Vl58H1sNTPZ15eRMvDaG7PMDvSUPVVUmM+M66MazzcBeS4Qiu9X
 9Jq6RWL6KR82vt/agQt4eOXnqCokOJhcLUXvBKit9AT/pgjYu8Bj9ltBOPFyJTZfwq4Y
 UZqNiYQEjsuF+fhX1aJNIB2uBsVfuPRH/W/aFDUnKMNmeEXXkWJ1zY5eJ9rb8skwKjJF
 tcaA/tphWol8/KedEFC4Nq1+RZkhEOT+FKlFqIg1kfa7TVMsr0p0xNVTJJQtHpy1OL/T
 lMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792334328; x=1792939128;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NPpm3zDkkVSZs45LbKytNXGTSu54DfdAecTE9Im1IGU=;
 b=s8GD6MWZMcOgoGaHrbGescqAY8v+t8GDcKPNXRWsY448VdZ/tbI+UXvjxMj7XCA49B
 0bWIaX5F7f1nvBEJpOJ5DaV0ow+NF7373h8rXpbIKTg+9HNxSz1EsoD8i9EokWCdz60H
 MN0KF8blTS+OB2igQbEYf3KOiucKiPgtseGaAT+8gcqK3zX3rfb7YaovJqZwKfNmt0/x
 JlbmwZL1rSmaq+w7rN9FagHo8S5pQvT34vAwsLLuNO92txsc3FB70ocsgyat+V1AZMbl
 msvdCTAT3Gb4L5F4IqwNShyOrlurnYLSUTuQP6Rp7+gUeNWD3G6xrt53EsCaGEdeM2Or
 pcAA==
X-Gm-Message-State: AFq9FYKLRZcCDZ4fSeaRTII9YQzTKQ436nzmP/fuc91QMlzfXUzbaKac
 wVum4zWMD0C3FzOGx2Ufmdq+YzNSMkQRJo1jbMB5RhU2/N/9NkfUJ1RMBGyH/tDS7IElCJ7mC+X
 Qe5Xe00C+2gN2+0Z2QzjnjH2gVgbkFRSL8aCkwyDhW6z1X81kXVJ7RfTDzzHfpUeuwbzO
X-Gm-Gg: AYBFou2EUTrB8wfK1DS0bvq/nZP5xN4SAjlPk5gRzMyGHTgmJx1lA2u24Zz8V1zmYHj
 jlQrORn67Rt+mFhb3HpAqs1ARpmb1rGOxi80XR2fhGvL/0gvsl95F9h3L+l9lwlpktM8rvp3ipn
 ZMj9xmE127eSgLsWW+UtqXLC4YYNEOCX9A0rzoklPxMol3VJ6PIjK1cJlo4SJ378qREDm7OJgVV
 JLKKVwfytJFafXvuUuCWXeTULpjHKkaCmWCiBLIgeIReytLitspYXL0m4E6AJw8oqBn7TFMtRE+
 YZiFrGmhDKE0zpUc/6HvjKCuj2UK1KcvERhIfv60pZ6oEKZzIDpFWNjrF2j5UIRZLNbcWJM6ODb
 sVmysWfrxVp1eABsSO8AkyLTMAjscF0LDZYzxsuXa1cENKfBHrclK10zzGtReyPzIclyp8LcNu+
 FSnvTqIRPpbrBm77cGR+g4pIoFOUdxmr5AvI0NwknRV55MAKhY30xCBsvc4yR5GcLolZEZE1DPt
 re0UdJLvm7ku3B2h5JJG6J/Xmyu3SCz9nnL5luzzWqUlI4xErE6MrhczgXvmGj7ZUNlqHlCqi7A
 zVyPb664DzbP4S+xLVwXYvXAImQhhBP7OXgZ5KMMuAdygxcX8sA74TYEkbpW
X-Received: by 2002:a05:6000:2281:b0:48e:82f:48fc with SMTP id
 ffacd0b85a97d-48e082f4b1cmr9937711f8f.31.1792334327441; 
 Sun, 18 Oct 2026 07:38:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471b06sm19180622f8f.5.2026.10.18.07.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:38:47 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 14:38:46 +0000
To: Steffan Karger <steffan@karger.me>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73
X-Gerrit-Change-Number: 2009
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2009?usp=email>
X-Gerrit-Commit: 1b0bd8c6f60df96356e956b9982550902a622c5a
In-Reply-To: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
References: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkkzNTEzNTYzZjE5OWUxYzVhYzk4MjE5YTUyNzY5NWU0MDU0MGE5ZjczQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0686331cbca9285fd15b6767db237cc9d38a73f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIS2I-00007f-75
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 Don't apply server extensions to CSRs
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5497885235218926395=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5497885235218926395==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1EKn8oGozXg="; charset=UTF-8

--1EKn8oGozXg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Steffan Karger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009=
?usp=3Demail )

The following approvals got outdated and were removed:
Code=
-Review+2 by R=C4=83zvan Cojocaru


Change subject: gen-sample-keys=2Esh: D=
on't apply server extensions to CSRs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

gen-sample-keys=2Esh: Don't apply server extensio=
ns to CSRs

Newer OpenSSL versions refuse to add authorityKeyIdentifier wit=
h
issuer:always to a CSR, since there is no issuer certificate yet=2E The
e=
xtensions are already applied when signing with 'openssl ca', so drop
them =
from the 'openssl req' calls=2E

Change-Id: I3513563f199e1c5ac98219a527695e=
40540a9f73
Signed-off-by: Steffan Karger <steffan@karger=2Eme>
Acked-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2009
Message-Id: <20261018070320=2E15749-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39973=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M sample/sample-keys/gen-sample-keys=2Esh
1 file changed, =
1 insertion(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/09/2009/2

diff --git a/sample/sample-keys/gen-sam=
ple-keys=2Esh b/sample/sample-keys/gen-sample-keys=2Esh
index fa5f697=2E=2E=
e5a11f5 100755
--- a/sample/sample-keys/gen-sample-keys=2Esh
+++ b/sample/s=
ample-keys/gen-sample-keys=2Esh
@@ -31,7 +31,7 @@
     -config openssl=2Ecn=
f
 
 # Create server key and cert
-openssl req -new -nodes -config openssl=
=2Ecnf -extensions server \
+openssl req -new -nodes -config openssl=2Ecnf =
\
     -keyout sample-ca/server=2Ekey -out sample-ca/server=2Ecsr \
     -s=
ubj "/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server/emailAddress=3Dme@my=
host=2Emydomain"
 openssl ca -batch -config openssl=2Ecnf -extensions serve=
r \
@@ -66,7 +66,6 @@
 openssl dsaparam -out sample-ca/dsaparams=2Epem 2048=

 
 openssl req -new -newkey dsa:sample-ca/dsaparams=2Epem -nodes -config o=
penssl=2Ecnf \
-    -extensions server \
     -keyout sample-ca/server-dsa=
=2Ekey -out sample-ca/server-dsa=2Ecsr \
     -subj "/C=3DKG/ST=3DNA/O=3DOp=
enVPN-TEST/CN=3DTest-Server-DSA/emailAddress=3Dme@myhost=2Emydomain"
 opens=
sl ca -batch -config openssl=2Ecnf -extensions server \
@@ -82,7 +81,6 @@
 =
openssl ecparam -out sample-ca/secp256k1=2Epem -name secp256k1
 
 openssl r=
eq -new -newkey ec:sample-ca/secp256k1=2Epem -nodes -config openssl=2Ecnf \=

-    -extensions server \
     -keyout sample-ca/server-ec=2Ekey -out samp=
le-ca/server-ec=2Ecsr \
     -subj "/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DT=
est-Server-EC/emailAddress=3Dme@myhost=2Emydomain"
 openssl ca -batch -conf=
ig openssl=2Ecnf -extensions server \

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2009?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73
Gerrit-Cha=
nge-Number: 2009
Gerrit-PatchSet: 2
Gerrit-Owner: Steffan Karger <steffan@k=
arger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--1EKn8oGozXg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Stef=
fan Karger=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
009?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
en-sample-keys=2Esh: Don&#39;t apply server extensions to CSRs<br><br>Newer=
 OpenSSL versions refuse to add authorityKeyIdentifier with<br>issuer:alway=
s to a CSR, since there is no issuer certificate yet=2E The<br>extensions a=
re already applied when signing with &#39;openssl ca&#39;, so drop<br>them =
from the &#39;openssl req&#39; calls=2E<br><br>Change-Id: I3513563f199e1c5a=
c98219a527695e40540a9f73<br>Signed-off-by: Steffan Karger &lt;steffan@karge=
r=2Eme&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009<br>Message-Id: &l=
t;20261018070320=2E15749-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39973=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M sample/sample-keys/gen-sample-keys=2Esh<br>1 file changed, 1 insertion(+=
), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/09/2009/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sample/sa=
mple-keys/gen-sample-keys=2Esh b/sample/sample-keys/gen-sample-keys=2Esh</s=
pan><br><span>index fa5f697=2E=2Ee5a11f5 100755</span><br><span>--- a/sampl=
e/sample-keys/gen-sample-keys=2Esh</span><br><span>+++ b/sample/sample-keys=
/gen-sample-keys=2Esh</span><br><span>@@ -31,7 +31,7 @@</span><br><span>   =
  -config openssl=2Ecnf</span><br><span> </span><br><span> # Create server =
key and cert</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openssl r=
eq -new -nodes -config openssl=2Ecnf -extensions server \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+openssl req -new -nodes -config opens=
sl=2Ecnf \</span><br><span>     -keyout sample-ca/server=2Ekey -out sample-=
ca/server=2Ecsr \</span><br><span>     -subj &quot;/C=3DKG/ST=3DNA/O=3DOpen=
VPN-TEST/CN=3DTest-Server/emailAddress=3Dme@myhost=2Emydomain&quot;</span><=
br><span> openssl ca -batch -config openssl=2Ecnf -extensions server \</spa=
n><br><span>@@ -66,7 +66,6 @@</span><br><span> openssl dsaparam -out sample=
-ca/dsaparams=2Epem 2048</span><br><span> </span><br><span> openssl req -ne=
w -newkey dsa:sample-ca/dsaparams=2Epem -nodes -config openssl=2Ecnf \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    -extensions server \</=
span><br><span>     -keyout sample-ca/server-dsa=2Ekey -out sample-ca/serve=
r-dsa=2Ecsr \</span><br><span>     -subj &quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-=
TEST/CN=3DTest-Server-DSA/emailAddress=3Dme@myhost=2Emydomain&quot;</span><=
br><span> openssl ca -batch -config openssl=2Ecnf -extensions server \</spa=
n><br><span>@@ -82,7 +81,6 @@</span><br><span> openssl ecparam -out sample-=
ca/secp256k1=2Epem -name secp256k1</span><br><span> </span><br><span> opens=
sl req -new -newkey ec:sample-ca/secp256k1=2Epem -nodes -config openssl=2Ec=
nf \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    -extensions s=
erver \</span><br><span>     -keyout sample-ca/server-ec=2Ekey -out sample-=
ca/server-ec=2Ecsr \</span><br><span>     -subj &quot;/C=3DKG/ST=3DNA/O=3DO=
penVPN-TEST/CN=3DTest-Server-EC/emailAddress=3Dme@myhost=2Emydomain&quot;</=
span><br><span> openssl ca -batch -config openssl=2Ecnf -extensions server =
\</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2009?usp=3Demail">change 2009</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I3513563f199e1c5ac98219a527695=
e40540a9f73 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2009 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=2Eme&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--1EKn8oGozXg=--


--===============5497885235218926395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5497885235218926395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5497885235218926395==--

