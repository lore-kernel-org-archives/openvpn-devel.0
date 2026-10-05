Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1941CA5FFD
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S3v4opGrkhts+asTsRMJHXHR5FVI+vS/O2sRNVofg4w=; b=aPXgtoRqRwTEcFZzyw2/V8CxUK
	/JXTlkPqZKaXnh2JEvToDRrYVPEZqqQiPaabE/er9mMiZfI8EpcuvpD/PslKAwEGkjXB2iSeLwycU
	AIbO6274lFb64kL4Q+I+uZdvSM5r7zn1zFfhEERmAzQxzxkGJc7JQPchXM188R1bTrwI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDbtg-0007c5-FY;
	Mon, 05 Oct 2026 06:10:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDbtf-0007bz-Eb
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 06:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nvLkE4MBfY4zbQy8essLqRd4faebK/1J/6K+ELzfjro=; b=AxhGnpFeQcGjDLvUsnnLFVbRcu
 iJX7FjW0bIUXG62HnxgL6uDErCHcTsabjWeHv17BA4QpQ/jktynpj8QTEPLMO+n9r7lc915MTVav2
 lqneYBqhQtGG9Mmm999V6eanu0a3Ubvc/soPf0NL7mfsylwFHnUVHodBPaDcsQq3jDbQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nvLkE4MBfY4zbQy8essLqRd4faebK/1J/6K+ELzfjro=; b=S
 KgXC+bvCpRg8De2ebpehDb3h9ynaB+oElMsgswbwGDq0aq/xlwmLVThHDYAKtHMQcjHC60OkQ/Km2
 193k6MLPXswKJG62X1QJVlhyr46e6kktZj4QrKPhkUySdXGLVOUa2jCAVO/k/xh1V/IYB10ITSAv7
 D7X3R+1ranSClCPk=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDbte-00063o-Dr for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 06:09:59 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso11612205e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791180592; x=1791785392; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nvLkE4MBfY4zbQy8essLqRd4faebK/1J/6K+ELzfjro=;
 b=UxOhYosHmSyed/Mf5Qon3aeKvWDiL45/FI+8PAesrtJ8Z7fE6Ezrlo+/7u3xH1MU67
 6+9xuPypLGI4iIOYxgl24vEa/MSxJqk5g+vm2H2E0GiiC/hhfksivDpgGoBc9UmxMiEI
 HaYBQJIMTOIafIkxd3jRpZEJhhns8ujNgtq/Br84sJOiqAACzHr0ux8t3MK8Lc3ReelA
 Hqao+SF78uw6j9OSszzOUb5ARyv8CiyONrRTJf5tCTeA4qFmbJ5+H3dJyLnA/HyOt6Mx
 lkSZiu1u6yUrnqi3hX+Hp44ejS3M+m1FUYm2MvgotYtFL2Aw+ASd7Im3l7z4Qa5MOL30
 JXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791180592; x=1791785392;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nvLkE4MBfY4zbQy8essLqRd4faebK/1J/6K+ELzfjro=;
 b=qS4LlblkoUwOJZ/QrFLh6nIEh6Qfu5EjP98ss8DEE6LAkYdOrd4X+5qYSNJvcFhlO8
 stUgY5HUPjqdz3RCjdsF3SYxfz6CiXGalpZyEMeAm4WqDpPrfMi9VNGBfbV+B5342b7N
 NP5xS74tOiE+PaqWPSoOCddxI1Lqpq3yTs8lBpuls1o8aJTHlOB2F+4ypa5ssqCc1K7C
 gau8Cp0mQ02MZBO/Ayy1U8kAlGIQO6zGF/KUzC4Hxb6oJSdaNFXJtSjzf45R2sUv6ThN
 3Uh3nwn4M208N7Qv+lLttK5fg53xAGm/wA2QupIn2RUQLQKRAcTEcRSJGpa2ZRUzmbRX
 TujA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYqmiCchgdr1VpmoW9xSp7TsyX3NZRrvwmlH7yohFUpyCnA0EAn64Pw+6f+IVoEqAfM0xRNjRguIocuCQJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++kAmmnZvPWdMt9+V+ayyVV9caAfD6dAQ9i9tzf5NLfIFTzSSrRl
 W4Vqpa/CxgwW1wn2dtuzThK1I/tix/ubkSFHVPOnJaDhFDTMmFiOHXA6BWGmqMeMdQTiT2uUFXN
 +YlImwpxaEoxZkRYp76TgvsaUepGz+9XS3qmtJkUuaaA2FvWth50rMCXozeelQ1/1mwFR
X-Gm-Gg: AYBFou2SH8AwRSXcW3Vu2/ib6SCJg+s6WpszPhv2KCCkXhi4xPW2wM08r/YdToiUM9R
 0ymZgECZIIgrUNUPDlbUQFUewq06yVDhE4MHxkuxpQMyuIIHuKbRl8wrByHgwUGOcKgLuR7oczB
 vCNnvGS957W054i8a+Xl3KYPAk7BrvsvQeKvUBf4mKnVo4d0fzC2LhEhSXQsACDKqPwQ4faBIya
 Ec5LpX9xXrDHXPhe143Wam4wEYGL0P6PqsogLm/TSZcyiDnekEhbyOGIVrCxAbcd9pVpKqpiI/0
 eH/QdkxZDiyLFJ0C3mTVOJLaNnA+z+gABbZlX1Pl73W92mmdIL/TOc/R+vRn6wCDQ5C9h6yHd1d
 1Lq8Q4e7nnnR96ensbpwAc8USq6sqoQUlmOWMreLwW1r3xkTscqI78m0ayVyxRTCeLfX9bcr50U
 pveyH6MTin1+hM1KuRJguBQ9jFIK0CWblSZH1+dy1KFpQtB7mHs7LJdZ4Ixd/2BTps7vP0VNLa8
 xPmKQCW6stqu4TerlknKBzZSzJi/isGLJEKs+JTQh1OytyKNP1se0E5w16SXSy0Ne9VLKpqp8Wa
 9MxeeBtJdNNlQyKd50d2rIwcs9jnZ/9ZEdc5yDhpp0wUHb4pXDAqQO0/DVTw
X-Received: by 2002:a05:600c:3144:b0:4a0:174:579e with SMTP id
 5b1f17b1804b1-4a02769d069mr154198155e9.28.1791180591629; 
 Sun, 04 Oct 2026 23:09:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm249770335e9.4.2026.10.04.23.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 23:09:51 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 06:09:49 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: f92779b63f0595e83a0ae158f2dfee5ec2653376
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 06:09:49 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <53a2fece95cafbb41f60dad0c556aa78cba60a35-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDbte-00063o-Dr
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6699082843104537644=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6699082843104537644==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VreIiPF59Lw="; charset=UTF-8

--VreIiPF59Lw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, chugly, plaisthos=
=2E

R=C4=83zvan Cojocaru has posted comments on this change by chugly=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail )

Change subj=
ect: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review-1

(1 comment)

File=
 tests/unit_tests/openvpn/test_route=2Ec:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1946/comment/41a315c3_8e66aa9f?usp=3Demail :
PS4, Line 106:     =
 * use to tell "host route" from "network route"
Do they? In route=2Ec I se=
e:

```
    route_message_t msg =3D { =2Eheader =3D { (add ? msg_add_route =
: msg_del_route),
                                        sizeof(route_mess=
age_t), 0 },
                            =2Efamily =3D AF_INET,
           =
                 =2Eprefix=2Eipv4=2Es_addr =3D htonl(r->network),
         =
                   =2Egateway=2Eipv4=2Es_addr =3D htonl(r->gateway),
      =
                      =2Eiface =3D { =2Eindex =3D if_index, =2Ename =3D "" =
},
                            =2Emetric =3D (r->flags & RT_METRIC_DEFINED)=
 ? r->metric : -1 };

    netmask_to_netbits(r->network, r->netmask, &msg=
=2Eprefix_len);
    if (msg=2Eprefix_len =3D=3D -1)
    {
        msg=2Epre=
fix_len =3D 32;
    }

    return do_route_service(add, &msg, sizeof(msg), =
tt->options=2Emsg_channel);
```

Or in helper=2Ec:


```
        status =3D=
 netmask_to_netbits(o->server_network, o->server_netmask, &netbits);
      =
  if (!status)
        {
            msg(M_USAGE, "--server directive netwo=
rk/netmask combination is invalid");
        }

        if (netbits < 0)
  =
      {
            msg(M_USAGE, "--server directive netmask is invalid");
=
        }
```

These don't look like `-1` is used "to tell a host route fro=
m a network route"=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1946?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Gerrit-Change-Number: 1946
G=
errit-PatchSet: 4
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
G=
errit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 05 Oct=
 2026 06:09:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--VreIiPF59Lw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, chugly, plaisthos=2E </p>
<p>R=C4=
=83zvan Cojocaru has posted comments on this change by chugly=2E</p><p>Patc=
h set 4:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">Vie=
w Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/tes=
t_route=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/41a315c3_8e66aa9f?u=
sp=3Demail">Patch Set #4, Line 106:</a> <code style=3D"font-family:monospac=
e,monospace">     * use to tell &quot;host route&quot; from &quot;network r=
oute&quot;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Do they? In route=2Ec I see:</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br>=
    route_message_t msg =3D { =2Eheader =3D { (add ? msg_add_route : msg_de=
l_route),<br>                                        sizeof(route_message_t=
), 0 },<br>                            =2Efamily =3D AF_INET,<br>          =
                  =2Eprefix=2Eipv4=2Es_addr =3D htonl(r-&gt;network),<br>  =
                          =2Egateway=2Eipv4=2Es_addr =3D htonl(r-&gt;gatewa=
y),<br>                            =2Eiface =3D { =2Eindex =3D if_index, =
=2Ename =3D &quot;&quot; },<br>                            =2Emetric =3D (r=
-&gt;flags &amp; RT_METRIC_DEFINED) ? r-&gt;metric : -1 };</pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">    netmask_to_netbits(r-&gt;network, r-&gt;netmask, &amp;msg=2Eprefix_=
len);<br>    if (msg=2Eprefix_len =3D=3D -1)<br>    {<br>        msg=2Epref=
ix_len =3D 32;<br>    }</pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">    return do_route_service(add,=
 &amp;msg, sizeof(msg), tt-&gt;options=2Emsg_channel);<br>```</pre><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Or in h=
elper=2Ec:</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><br>```<br>        status =3D netmask_to_netbit=
s(o-&gt;server_network, o-&gt;server_netmask, &amp;netbits);<br>        if =
(!status)<br>        {<br>            msg(M_USAGE, &quot;--server directive=
 network/netmask combination is invalid&quot;);<br>        }</pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">        if (netbits &lt; 0)<br>        {<br>            msg(M_USAGE, &=
quot;--server directive netmask is invalid&quot;);<br>        }<br>```</pre=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">These don&#39;t look like `-1` is used &quot;to tell a host route from a =
network route&quot;=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I908=
5c55a7efefd31839b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=
=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@o=
penvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 06:09:=
49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--VreIiPF59Lw=--


--===============6699082843104537644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6699082843104537644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6699082843104537644==--

