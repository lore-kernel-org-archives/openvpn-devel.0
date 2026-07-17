Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE3EC44507
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3LAzb98EtUbkG+Uz6yP5UZbTIYIS6CNC+/vDonLonWU=; b=WphLDpLzdQzBbBXVO3R6jYnvXU
	rrOWkEWkS21l+Wa01sCISNsYtuprovkhChh+apkrJluvR51EaKxvFmiZyKzpK4FzP/Z8HiKUp4Zpl
	/EYOIvqS/uoOEl+PvYFfAy6X9E0zvxRHpaR4ZwFm1C7bRi4WjETcZBkJ1nhGs0JgZp0E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkckj-000313-6y;
	Fri, 17 Jul 2026 07:12:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkcki-00030t-H6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 07:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=12FQLBIGQD3aWOKzNwcv1Kb2/13YRNepSVqnXKMT4Ys=; b=SoqRDyVIoxWhbaBFWLu0yeSkfZ
 lqXaw0tIBTede+QecYyx3iDzuGKQKTAnlCcj4c6HhAWqOl4emQjwsaf7Yvkhmqbtg9nAWg4DDKC62
 tnM/tSH+zXrlBhX5cl4xHuGCEIdp2vQlGMfrOpJegEAa2Hf/JPvVTYLcxv4I0TkVZ4hY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=12FQLBIGQD3aWOKzNwcv1Kb2/13YRNepSVqnXKMT4Ys=; b=f
 vCLmfHIjCazU/B50a9xQcKO1XfMBG2ocM6c69u14L5rR2E2/fccNkPGECUMG5wMf4vmGHl1aGhT5e
 5V5QlZuQhPVay7UhrpRUTCL7nn8q0pCiQuJ4dhodmzDDq6z1V4gTIEIS+ZKQ5EJJUzvxWMieb2WMB
 G1ZaFBR5akc942gU=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkckh-0006xp-7q for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 07:12:57 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so21158075e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 00:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784272369; x=1784877169; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=12FQLBIGQD3aWOKzNwcv1Kb2/13YRNepSVqnXKMT4Ys=;
 b=Mc47TW++vZg7//yderOPQBgd/aias0aMYf4LrAQah4da0m2ywrWW4REPWlHO+7nzYu
 rGenb2cW8ZRzRdECmKrgeTQwl4/3Lc85ZpxUFhhIXxvcKHMcOaAwB3k83KpFpJHR6FgW
 O2rc9ATsARrP8xjt3OqUBLJABA+0zYa2RipwwK4Ilystz8Rjg5hClozkek6rp7wEgBIP
 7h/TulA1zRsUhPA5UwQcTdOG/l2xowwQykteMG/3uau48LhXLJro06T8HJDhOgs2TvR2
 E24eh0PutLRAa/H+ezM2zNzrDw9gxUKXl6WKIcTnn5W22n/WOjyjcEYEWuqt7f+rYnVS
 cwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784272369; x=1784877169;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=12FQLBIGQD3aWOKzNwcv1Kb2/13YRNepSVqnXKMT4Ys=;
 b=TfjSSsHzFt07yJ1mRlsXUjROD1RY7/cmbO4IhYHI/PbKFUDW7jVqYElkgUN41WjEcy
 56lxhwpjzwajLjQUojfgUbzu5FVNK7/w2MWbwOTkp4R8yF6PKq7S3D0Cvvk0PIYqLJ1b
 EWkrVV83+/AQTSqZxH++b/5Br8SRSf8VbwryoYQCEH08wdhiiP8DLuYdhseLGIgL2ur7
 kY1cG09tv+c5zGhcke9UbnO5aeje+hnxNtX+vqxjIEY0w/RBhncgJPSGylACKTsFIIYz
 88kgnUkLJlkNe1MNF2O44yTrFzvN3cAY3bX89WLawdd9tOWNWdyD/yj7sCohsuIYECcx
 tGMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEnszs2SBbVNYVw0cg48CTxjBBNzTS+cV8K5apQ/C7SSvfsZU2N0UTGuUsPBUGqqxOuHcWCfUhDQ8ghLBQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzo7FDHixlqIKJrVziBVNFYXPO50qqNRw+b1deVmkqX8AjZnAmv
 ck6JH+B6OF99VEMSO8Wpw0eak15Oywwfzf5KJHFQO+T+ShaQgW29HhohdudZyEBYZouOFynG3gj
 pk6BftD8Nwgimu7TFsqQi5wkcHBxi2iDwa8eDdgduL2wGkDvRCDOdGLYodksGb+vA/wcT
X-Gm-Gg: AfdE7cldHtZodhbp4Y1Rigu4SyzusCD2CB29lLgz3LgbsaSf8ifQRVoeQyDuq/BL69/
 hkJGGaJhQOBLlNKJu09drqmXN1Us1N/Leg8if3cAcXkrtKQF7KldYuWM+bWFplS5aCN/RE6VNv/
 jiGGyZClwlVGBcyi9b2caFQ8ru4sGQwS6ydwZfLrAI0iMiiJKT0b8kSVOAeVFfwp9hQ51ttJv5r
 BJgap5Bzo6vKrj8hNw8L2KEwYQJsQjxAOtxXylx470SL7NeNVk3Ib7Rs5ymQGoG/wMYQSlGo3gu
 5MP62xTc5DEALCYmX2vIfcoA+Cf3YeyD8ER+KYEOt4V1yFsevEaaX7w8LtyYF3KfX3Y/CJLksY3
 MieyZMHxR35GmWmdtn+bUEdMQip/8hp6F/sX2+MP0m+rfTAXLbXSklzvTCHBfjsf6e351u2cUe2
 sxgEHZurKjwvQT/3kLYYLGAY+M+0xnMjfdOvciPjcBVSlwZ4BPlekEplO9aXiFGS8zUWIqaDgXO
 UWcB+ReQULL33UZ0StOzpXkAQaDpvlg1nN1akGMjm6zaXjHZaF32g3qMssBZQeUnr9h
X-Received: by 2002:a05:600c:3143:b0:492:7142:f46e with SMTP id
 5b1f17b1804b1-4954a3d0cd7mr14712715e9.2.1784272368356; 
 Fri, 17 Jul 2026 00:12:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b893dsm26877945e9.8.2026.07.17.00.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 00:12:47 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 07:12:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: f8b15dad1258d6cf71ffa16f67efd9f8b57b9727
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c44a787bd2a1b90256f6484d116e97a1f436363c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkckh-0006xp-7q
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2070603630491442281=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2070603630491442281==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OhfPyCytLPU="; charset=UTF-8

--OhfPyCytLPU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello ordex, plaisthos, 

I'd like you to reexamine a change=2E Please visi=
t

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail

to look =
at the new patch set (#3)=2E

The following approvals got outdated and were=
 removed:
Code-Review+2 by ordex, Code-Review+2 by plaisthos


Change subje=
ct: proto: correct 802=2E1Q length check in is_ipv_X
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

proto: correct 802=2E1Q length che=
ck in is_ipv_X

Github: OpenVPN/openvpn#1044

This has also been reported t=
wice as a security relevant bug, but
only later than the original finding -=
 and it isn't=2E

While --client-nat would modify a 32bit integer "after th=
e packet"
(the place where an IPv4 address would be, in a well-formed packe=
t),
the underlying buffer is always max-frame sized, and we never look
at t=
he "modified integer" afterwards, so there are no consequences
warranting a=
llocation of a CVE ID=2E

Signed-off-by: rootvector2 <dxbnaveed=2Ek@gmail=
=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Anton=
io Quartulli <antonio@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1789
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaip=
yaipy=2Ecom)
Reported-By: Yu Zhang Wong <wongyuzhang45@gmail=2Ecom>
Change-=
Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
Message-Id: <20260715202210=
=2E9010-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg37652=2Ehtml
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/proto=2Ec
1 file changed=
, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/89/1789/3

diff --git a/src/openvpn/proto=2Ec b/s=
rc/openvpn/proto=2Ec
index 13fe0a5=2E=2E785c021 100644
--- a/src/openvpn/pr=
oto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -70,7 +70,7 @@
         if (proto =
=3D=3D htons(OPENVPN_ETH_P_8021Q))
         {
             const struct ope=
nvpn_8021qhdr *evh;
-            if (BLENZ(buf) < sizeof(struct openvpn_eth=
hdr) + sizeof(struct openvpn_iphdr))
+            if (BLENZ(buf) < sizeof(s=
truct openvpn_8021qhdr) + sizeof(struct openvpn_iphdr))
             {
    =
             return false;
             }

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
Gerrit-C=
hange-Number: 1789
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@greenie=2Em=
uc=2Ede>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--OhfPyCytLPU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by ordex, C=
ode-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">proto: correct 802=2E1Q length c=
heck in is_ipv_X<br><br>Github: OpenVPN/openvpn#1044<br><br>This has also b=
een reported twice as a security relevant bug, but<br>only later than the o=
riginal finding - and it isn&#39;t=2E<br><br>While --client-nat would modif=
y a 32bit integer &quot;after the packet&quot;<br>(the place where an IPv4 =
address would be, in a well-formed packet),<br>the underlying buffer is alw=
ays max-frame sized, and we never look<br>at the &quot;modified integer&quo=
t; afterwards, so there are no consequences<br>warranting allocation of a C=
VE ID=2E<br><br>Signed-off-by: rootvector2 &lt;dxbnaveed=2Ek@gmail=2Ecom&gt=
;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by:=
 Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1789<br>Reported-By: =E7=AB=A0=E9=B1=BC=
=E5=93=A5 (www=2Eaipyaipy=2Ecom)<br>Reported-By: Yu Zhang Wong &lt;wongyuzh=
ang45@gmail=2Ecom&gt;<br>Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8=
fe<br>Message-Id: &lt;20260715202210=2E9010-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg37652=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/proto=2Ec<br>1 file changed, 1 insertion=
(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/89/1789/3</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/proto=2Ec b/src/openvpn/proto=2Ec</span><br><span>index 13fe0a5=2E=2E78=
5c021 100644</span><br><span>--- a/src/openvpn/proto=2Ec</span><br><span>++=
+ b/src/openvpn/proto=2Ec</span><br><span>@@ -70,7 +70,7 @@</span><br><span=
>         if (proto =3D=3D htons(OPENVPN_ETH_P_8021Q))</span><br><span>    =
     {</span><br><span>             const struct openvpn_8021qhdr *evh;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLENZ(buf=
) &lt; sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(buf)=
 &lt; sizeof(struct openvpn_8021qhdr) + sizeof(struct openvpn_iphdr))</span=
><br><span>             {</span><br><span>                 return false;</s=
pan><br><span>             }</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail"=
>change 1789</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1789 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--OhfPyCytLPU=--


--===============2070603630491442281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2070603630491442281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2070603630491442281==--

