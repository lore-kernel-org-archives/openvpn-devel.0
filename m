Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34230C4450F
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmnvc6Sx4NYdCodHwp+HhRY+8OLvB/VKA3dvggt2DtA=; b=Z7X/oolEB3YWCs51UgavDeqAup
	s9i9b0dQrNCplKYBulCdZgsr5zh6e9oMQYwdDjtwj2sxFIV5WkXPQrcgf7Z4nwt2sjcAeIX5Xxweo
	bqauNEe2h6ISmHKnP8cZYo8DvFzGyNKkXSVo8aS2HglK9ghaElcxwrom58Qs26usGajs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkckp-0004qi-DY;
	Fri, 17 Jul 2026 07:13:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkckn-0004qc-TH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 07:13:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f4gAWad2Vdy/HPYpnY1tcpb7GlKgZ1AbG4oncrUplYU=; b=gx8+F/yCRIBTdUbICV8AjjXG2t
 zHKQa1oVP3uIy2YVoQfwZKh6SjdjJlB0dIMtawP2yg0QoBQjwxxh4kboZTqno8oJvFWSxbk/ual9x
 LS4wpWsu5DjYT6omHiN4O4u1F75nP9TgtnTfszRv4pNXsm/zGP0ZlhIBw+1lgvyv9OH8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f4gAWad2Vdy/HPYpnY1tcpb7GlKgZ1AbG4oncrUplYU=; b=g
 BHapG9sBT+xg6bpjwR1SJ2PjPt6nVMeMOblf1I5Pn6QYAyj4Im1Mg8JF3sf1noHYiujztBoIL7b1A
 l2H1IoII0wt4uPmCo8FWve/Q5+jsUwOIiRvEI3zZmao4PR8J7s1s31zb5h+dMwR37bn0apFooQoy1
 Y9EKqbKJJpsAFpYk=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkckn-0006y5-U2 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 07:13:02 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so55711325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784272370; x=1784877170; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f4gAWad2Vdy/HPYpnY1tcpb7GlKgZ1AbG4oncrUplYU=;
 b=CDI3xopF8Z6ohPbUh5buMRtRuC305MgVmRHh9u9qKgE0JaHzxvEKBjKHZWegCeFJJE
 /s4n89BdYOLWYKbEYnWuKS7sjQNn9vgfUmCZQSd5dvwYLDMkrrCSZCH1eNIjGO12wxdB
 cdNRTIdv5ZSYlmHUjzddrALlqOuwlevu3NCWIKLMdY/MKz4pDYiD9jd+XKg+TJuNaDkc
 o2oPTm5FhwFLpX+SEbafFy41HywJY9DCLw4NBfs6+W0+kkRCXvnpsU/yd+iUO/Um76BJ
 6EjMWgI+vCBIGp81zai1xLWzp2d9F4bk3VEHcAQD1o8xEQyaVZREu9FjsABIi0YjU4/c
 vu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784272370; x=1784877170;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f4gAWad2Vdy/HPYpnY1tcpb7GlKgZ1AbG4oncrUplYU=;
 b=Ci3XO08krzUF29ET+5Hexr4S7g3plqtaP/kUFeMA1nQy4scYs0DLE3LYIFD0mHQW41
 RWq/OSwrbEJ8wr4Ran9UliR7+GKQwGNTHRA4TlhgPGWAvGStaB/G9TtarSLgNvoGQpkC
 5VWAPuz+hKoIcVYdHQdL+Vbwk5UC+pGX/lm94nzG/rfZS/jUbLo9O+tpeMfUz0IVs+Pp
 52vLkglsFDQIkXGmunRLSSbr5asu6ksfHfRhpdkjMLTl/vwc47w+paGU+KvdCoJwmIqR
 q07NN5+ORO1G/DV+iwgQ/xezcKhPXNAKuk7ZGXxaXm2OGwiFuyqmxK0+D8rciLeNv7B3
 Td7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyFHzcQv1SAzRKu7y7527HhvMg1kOTOQe9Em2+my2RRblUOFwQrhzkLUArx078C0t/iumVpeVzixwf3Ibl@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxZis15i3yn+QXrd1rlvlN8MuMbtY+QbyAw8poH2+YQEhe9xoOT
 RT9KbOPC4DK+qnIMXS0zHUb6vPbebzI3JSwopzTz5KB6k/DprE7sfq8SzAHoGjRro2IITyGpwLP
 oM4HTGST5YDeY37QkJJ+Z/HIKDE/bee2CtMxYokSw5l9BQW8IWmEzxBjJ2ist06t8TBYa
X-Gm-Gg: AfdE7cnK7O/k+A1xN8qlq+p8HtESEHs4vAby1eiig/aU0WfpS9gjGFtrJ9fpaUcMOCC
 DgWumEKWXinElSnRhKXLCoLRkoi8GFgR2aD0wSephLHDE48Xn1VJXzm5D2KA5qoQffIBDROOM4W
 GclId+VyO46LkpCkVtQTVaw4t6f9xU16De0/h+qqayX607Zh9IiIjTYf+P/o1gESZILZ1TRxqvr
 RegPf2DMPT3zRaE5ASA9p70E6nuqnqTPoyDs5ehlZt1ctE+svObCzWBGnitZ40xfgbVFZCIno70
 JS3eTv2WJQ0G/Z2rjAJSBwU7zrTUdVXBABJX0ulnf0CIYGKD4Z7bIJWXc3QPxQOB36vzr5r/fXf
 ziqktBdzKKGeMUFR61H+WrmTYA04AsQ9mQMD4Pz+KaD8jat87+lLMeKyg642BseI+88sAkw4Vp4
 zRqrtvg7Qtks8qkKi2I3HTfK0Sm6q3a2JTVDjqdN3GBFej/XoUGA/stbdVDE9C7MdcMjKZE00z4
 LFieb4b1ODzBMDqEdfbgLIZ47KjUIAMi4hrU93a7YXb5kzlNgMAPhzTUBVpYGtYMtQIweFqIJ8Y
 yEU=
X-Received: by 2002:a05:600c:e548:10b0:493:b91c:6bf with SMTP id
 5b1f17b1804b1-4954a40e11dmr9228135e9.18.1784272370201; 
 Fri, 17 Jul 2026 00:12:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3e56fsm27694615e9.5.2026.07.17.00.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 00:12:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 07:12:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: f8b15dad1258d6cf71ffa16f67efd9f8b57b9727
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c44a787bd2a1b90256f6484d116e97a1f436363c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkckn-0006y5-U2
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2450198773321898711=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2450198773321898711==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HgoUOnHebl8="; charset=UTF-8

--HgoUOnHebl8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1789?usp=3Demail )

Change subject: proto: correct 802=2E1Q length chec=
k in is_ipv_X
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


proto: correct 802=2E1Q length check in is_ipv_X

Github: OpenVPN/openvpn=
#1044

This has also been reported twice as a security relevant bug, but
on=
ly later than the original finding - and it isn't=2E

While --client-nat wo=
uld modify a 32bit integer "after the packet"
(the place where an IPv4 addr=
ess would be, in a well-formed packet),
the underlying buffer is always max=
-frame sized, and we never look
at the "modified integer" afterwards, so th=
ere are no consequences
warranting allocation of a CVE ID=2E

Signed-off-by=
: rootvector2 <dxbnaveed=2Ek@gmail=2Ecom>
Acked-by: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789
Reported-By: =E7=
=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)
Reported-By: Yu Zhang Wong =
<wongyuzhang45@gmail=2Ecom>
Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42=
fa8fe
Message-Id: <20260715202210=2E9010-1-gert@greenie=2Emuc=2Ede>
URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
7652=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpn/proto=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)




diff -=
-git a/src/openvpn/proto=2Ec b/src/openvpn/proto=2Ec
index 13fe0a5=2E=2E785=
c021 100644
--- a/src/openvpn/proto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -70,=
7 +70,7 @@
         if (proto =3D=3D htons(OPENVPN_ETH_P_8021Q))
         {=

             const struct openvpn_8021qhdr *evh;
-            if (BLENZ(bu=
f) < sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))
+       =
     if (BLENZ(buf) < sizeof(struct openvpn_8021qhdr) + sizeof(struct openv=
pn_iphdr))
             {
                 return false;
             }

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8219c6295acf28ff10ddb2fc=
c285f813c42fa8fe
Gerrit-Change-Number: 1789
Gerrit-PatchSet: 3
Gerrit-Owner=
: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>

--HgoUOnHebl8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1789?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">proto: correct 802=2E1Q length check in is=
_ipv_X<br><br>Github: OpenVPN/openvpn#1044<br><br>This has also been report=
ed twice as a security relevant bug, but<br>only later than the original fi=
nding - and it isn&#39;t=2E<br><br>While --client-nat would modify a 32bit =
integer &quot;after the packet&quot;<br>(the place where an IPv4 address wo=
uld be, in a well-formed packet),<br>the underlying buffer is always max-fr=
ame sized, and we never look<br>at the &quot;modified integer&quot; afterwa=
rds, so there are no consequences<br>warranting allocation of a CVE ID=2E<b=
r><br>Signed-off-by: rootvector2 &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>Acked=
-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Antonio Q=
uartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1789<br>Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (w=
ww=2Eaipyaipy=2Ecom)<br>Reported-By: Yu Zhang Wong &lt;wongyuzhang45@gmail=
=2Ecom&gt;<br>Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe<br>Messa=
ge-Id: &lt;20260715202210=2E9010-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg376=
52=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/proto=2Ec<br>1 file changed, 1 insertion(+), 1 deleti=
on(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/proto=2Ec b/src/openvpn/pro=
to=2Ec</span><br><span>index 13fe0a5=2E=2E785c021 100644</span><br><span>--=
- a/src/openvpn/proto=2Ec</span><br><span>+++ b/src/openvpn/proto=2Ec</span=
><br><span>@@ -70,7 +70,7 @@</span><br><span>         if (proto =3D=3D hton=
s(OPENVPN_ETH_P_8021Q))</span><br><span>         {</span><br><span>        =
     const struct openvpn_8021qhdr *evh;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (BLENZ(buf) &lt; sizeof(struct openvpn_et=
hhdr) + sizeof(struct openvpn_iphdr))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (BLENZ(buf) &lt; sizeof(struct openvpn_802=
1qhdr) + sizeof(struct openvpn_iphdr))</span><br><span>             {</span=
><br><span>                 return false;</span><br><span>             }</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">change 1789</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I8219c6295acf28ff10ddb2=
fcc285f813c42fa8fe </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1789 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--HgoUOnHebl8=--


--===============2450198773321898711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2450198773321898711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2450198773321898711==--

