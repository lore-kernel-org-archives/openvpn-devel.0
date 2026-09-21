Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E32FC982ED
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PWXD1dSIBklMN0UoV/VLO/FXGOSbs9+dN3CleG1oxwg=; b=Fz7+VZcnk/8eT9KfVxczGIDXhO
	kfbqQ/omlNLuCY6Op8evXGsJDRlJ+u1Ks1Ctz07+Ws9Q/J5R7hgfqlffr+zHTIPWV4iWzdLZ3+sPK
	Qd3uN6vP02F4U0IbEoLGlkiLxb8C9aNkFD/imXarYFrXTzWHq1VeBH1V7B8y9ROuhraE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8ncu-00022V-V2;
	Mon, 21 Sep 2026 23:40:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1x8nci-00022B-IR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 23:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xSpd7GpzoQrFS9GZ2VLKqxjLYtmLaAJ3XUOnJFqgzjo=; b=kM19J1b0QvQQmUTalnjZbn3u+6
 D69fr59uTgBlCNUU++3DODpK6HxMcCtI/WREwhZwLa4RAbxA6r20hv/Q2vrccQJhob30EIUXJBlFJ
 I/AqH2HLAxokMMbJwH8d/wCTG4DElo9KIOcwKcTvY0qnT5rjwylfPTrXGozmec7oHeSU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xSpd7GpzoQrFS9GZ2VLKqxjLYtmLaAJ3XUOnJFqgzjo=; b=BvFJY44Y9O1oCekho7sXJCohP9
 9Ar7JrhCmwRU6i7XyjBemLIFcJ5ZWfOCAoGRAdW2lUQtyJ5mAoX30Oqrq6v50HQt2uwEwlzszFgmm
 +CIQKphbCdOMoVzy0+KHtS1uVEkm6+HmgxIWXyoRQ4Cdu5B90xodZhDCkqAnfYhnqbZw=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8ncX-0004Al-Gq for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 23:40:27 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hpfq55MnVz8sbs;
 Tue, 22 Sep 2026 01:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1790034017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSpd7GpzoQrFS9GZ2VLKqxjLYtmLaAJ3XUOnJFqgzjo=;
 b=qqD5o1d0koo6WUk+0aBK4Gp/s2DvWUn7lu9gDexmdE7cGmFqbYPcH1XFhR/yxVKoBH36OO
 vanfOdj7/EbE92NBDy1BTb0+stRfaMDi7AfLPuYkuxx/GWT5SZnhFV7maNRgiUoqrB5zqR
 2Uc3XlaSWFTBDFrZkuHjkdM5Z0ZtCBgtX7VKafrkvNe8PGSkxOPLFAV7qlcjDpOxZYkh7M
 vo3QuWGmW/CcLaLgpDEYP7pzNVZZ+gzs1fnSLkttADyjyRuka6/Rp8YyqpV33DIdtRf4wv
 l4CLs5yDaL8nRuAGss74T6TsxYxq+gBcQDmPxVjA8EuWtwDDds6n3gqh4GL6zw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <eac0bdda-628c-4c0c-82ac-9184c1d602ad@unstable.cc>
Date: Tue, 22 Sep 2026 01:40:14 +0200
MIME-Version: 1.0
To: Marco Baffo <marco@mandelbit.com>, openvpn-devel@lists.sourceforge.net,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20260729153815.2637139-1-marco@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260729153815.2637139-1-marco@mandelbit.com>
X-Rspamd-Queue-Id: 4hpfq55MnVz8sbs
X-Headers-End: 1x8ncX-0004Al-Gq
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v3 1/4] ovpn: support
 operations on interfaces in foreign netns
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Sabrina,

I hope you're doing well!

Do you have any strong opinion on this patchset?
I was eventually hoping to get it to net-next, because it would simplify 
userspace a bit, when dealing with network namespaces.

Please, let me know what you think.

Thanks a lot!

Regards,

On 29/07/2026 17:38, Marco Baffo wrote:
> ovpn currently looks up the target interface in the network namespace
> associated with the netlink socket. This prevents a userspace process
> from controlling an ovpn interface located in another namespace.
> 
> Add the optional OVPN_A_TARGET_NETNSID attribute. When present, it
> identifies the namespace containing the target interface relative to the
> namespace of the requesting Netlink socket. Resolve the ID and perform
> the interface lookup there. When absent, preserve the existing lookup
> behavior.
> 
> Allow the attribute in all peer and key request policies, including
> peer dump requests.
> 
> Signed-off-by: Marco Baffo <marco@mandelbit.com>
> ---
> Changes in v3:
> - None.
> 
> Changes in v2:
> - Improved Doc.
> 
>   Documentation/netlink/specs/ovpn.yaml | 27 ++++++++++++++++
>   drivers/net/ovpn/netlink-gen.c        | 45 ++++++++++++++++-----------
>   drivers/net/ovpn/netlink.c            | 17 ++++++++++
>   include/uapi/linux/ovpn.h             |  1 +
>   4 files changed, 72 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
> index b0c782e59a32..1f0d4d6037c0 100644
> --- a/Documentation/netlink/specs/ovpn.yaml
> +++ b/Documentation/netlink/specs/ovpn.yaml
> @@ -337,12 +337,20 @@ attribute-sets:
>           type: nest
>           doc: Peer specific cipher configuration
>           nested-attributes: keyconf
> +      -
> +        name: target-netnsid
> +        type: s32
> +        doc: >-
> +          ID of the network namespace containing the ovpn interface, relative to
> +          the network namespace of the requesting Netlink socket
>     -
>       name: ovpn-peer-new-input
>       subset-of: ovpn
>       attributes:
>         -
>           name: ifindex
> +      -
> +        name: target-netnsid
>         -
>           name: peer
>           nested-attributes: peer-new-input
> @@ -352,6 +360,8 @@ attribute-sets:
>       attributes:
>         -
>           name: ifindex
> +      -
> +        name: target-netnsid
>         -
>           name: peer
>           nested-attributes: peer-set-input
> @@ -361,6 +371,8 @@ attribute-sets:
>       attributes:
>         -
>           name: ifindex
> +      -
> +        name: target-netnsid
>         -
>           name: peer
>           nested-attributes: peer-del-input
> @@ -370,6 +382,8 @@ attribute-sets:
>       attributes:
>         -
>           name: ifindex
> +      -
> +        name: target-netnsid
>         -
>           name: keyconf
>           nested-attributes: keyconf-get
> @@ -379,6 +393,8 @@ attribute-sets:
>       attributes:
>         -
>           name: ifindex
> +      -
> +        name: target-netnsid
>         -
>           name: keyconf
>           nested-attributes: keyconf-swap-input
> @@ -388,6 +404,8 @@ attribute-sets:
>       attributes:
>         -
>           name: ifindex
> +      -
> +        name: target-netnsid
>         -
>           name: keyconf
>           nested-attributes: keyconf-del-input
> @@ -405,6 +423,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - peer
>       -
>         name: peer-set
> @@ -417,6 +436,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - peer
>       -
>         name: peer-get
> @@ -429,6 +449,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - peer
>           reply:
>             attributes:
> @@ -437,6 +458,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>           reply:
>             attributes:
>               - peer
> @@ -451,6 +473,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - peer
>       -
>         name: peer-del-ntf
> @@ -469,6 +492,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - keyconf
>       -
>         name: key-get
> @@ -481,6 +505,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - keyconf
>           reply:
>             attributes:
> @@ -496,6 +521,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - keyconf
>       -
>         name: key-swap-ntf
> @@ -515,6 +541,7 @@ operations:
>           request:
>             attributes:
>               - ifindex
> +            - target-netnsid
>               - keyconf
>   
>       -
> diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
> index 2147cec7c2c5..3f513e3675a3 100644
> --- a/drivers/net/ovpn/netlink-gen.c
> +++ b/drivers/net/ovpn/netlink-gen.c
> @@ -118,55 +118,64 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
>   };
>   
>   /* OVPN_CMD_PEER_NEW - do */
> -static const struct nla_policy ovpn_peer_new_nl_policy[OVPN_A_PEER + 1] = {
> +static const struct nla_policy ovpn_peer_new_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_new_input_nl_policy),
>   };
>   
>   /* OVPN_CMD_PEER_SET - do */
> -static const struct nla_policy ovpn_peer_set_nl_policy[OVPN_A_PEER + 1] = {
> +static const struct nla_policy ovpn_peer_set_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_set_input_nl_policy),
>   };
>   
>   /* OVPN_CMD_PEER_GET - do */
> -static const struct nla_policy ovpn_peer_get_do_nl_policy[OVPN_A_PEER + 1] = {
> +static const struct nla_policy ovpn_peer_get_do_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
>   };
>   
>   /* OVPN_CMD_PEER_GET - dump */
> -static const struct nla_policy ovpn_peer_get_dump_nl_policy[OVPN_A_IFINDEX + 1] = {
> +static const struct nla_policy ovpn_peer_get_dump_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   };
>   
>   /* OVPN_CMD_PEER_DEL - do */
> -static const struct nla_policy ovpn_peer_del_nl_policy[OVPN_A_PEER + 1] = {
> +static const struct nla_policy ovpn_peer_del_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_del_input_nl_policy),
>   };
>   
>   /* OVPN_CMD_KEY_NEW - do */
> -static const struct nla_policy ovpn_key_new_nl_policy[OVPN_A_KEYCONF + 1] = {
> +static const struct nla_policy ovpn_key_new_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
>   };
>   
>   /* OVPN_CMD_KEY_GET - do */
> -static const struct nla_policy ovpn_key_get_nl_policy[OVPN_A_KEYCONF + 1] = {
> +static const struct nla_policy ovpn_key_get_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_get_nl_policy),
>   };
>   
>   /* OVPN_CMD_KEY_SWAP - do */
> -static const struct nla_policy ovpn_key_swap_nl_policy[OVPN_A_KEYCONF + 1] = {
> +static const struct nla_policy ovpn_key_swap_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_swap_input_nl_policy),
>   };
>   
>   /* OVPN_CMD_KEY_DEL - do */
> -static const struct nla_policy ovpn_key_del_nl_policy[OVPN_A_KEYCONF + 1] = {
> +static const struct nla_policy ovpn_key_del_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
>   	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
> +	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
>   	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_del_input_nl_policy),
>   };
>   
> @@ -178,7 +187,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_peer_new_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_peer_new_nl_policy,
> -		.maxattr	= OVPN_A_PEER,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   	{
> @@ -187,7 +196,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_peer_set_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_peer_set_nl_policy,
> -		.maxattr	= OVPN_A_PEER,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   	{
> @@ -196,14 +205,14 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_peer_get_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_peer_get_do_nl_policy,
> -		.maxattr	= OVPN_A_PEER,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   	{
>   		.cmd		= OVPN_CMD_PEER_GET,
>   		.dumpit		= ovpn_nl_peer_get_dumpit,
>   		.policy		= ovpn_peer_get_dump_nl_policy,
> -		.maxattr	= OVPN_A_IFINDEX,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>   	},
>   	{
> @@ -212,7 +221,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_peer_del_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_peer_del_nl_policy,
> -		.maxattr	= OVPN_A_PEER,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   	{
> @@ -221,7 +230,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_key_new_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_key_new_nl_policy,
> -		.maxattr	= OVPN_A_KEYCONF,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   	{
> @@ -230,7 +239,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_key_get_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_key_get_nl_policy,
> -		.maxattr	= OVPN_A_KEYCONF,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   	{
> @@ -239,7 +248,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_key_swap_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_key_swap_nl_policy,
> -		.maxattr	= OVPN_A_KEYCONF,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   	{
> @@ -248,7 +257,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
>   		.doit		= ovpn_nl_key_del_doit,
>   		.post_doit	= ovpn_nl_post_doit,
>   		.policy		= ovpn_key_del_nl_policy,
> -		.maxattr	= OVPN_A_KEYCONF,
> +		.maxattr	= OVPN_A_TARGET_NETNSID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
>   };
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 4c66c1ec497e..b70ecfaf46c8 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -38,6 +38,7 @@ ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
>   {
>   	struct ovpn_priv *ovpn;
>   	struct net_device *dev;
> +	struct net *target_net = NULL;
>   	int ifindex;
>   
>   	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_IFINDEX))
> @@ -45,12 +46,26 @@ ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
>   
>   	ifindex = nla_get_u32(info->attrs[OVPN_A_IFINDEX]);
>   
> +	if (info->attrs[OVPN_A_TARGET_NETNSID]) {
> +		/* Target netns IDs are relative to the requesting Netlink socket */
> +		target_net = get_net_ns_by_id(net, nla_get_s32(info->attrs[OVPN_A_TARGET_NETNSID]));
> +		if (!target_net) {
> +			NL_SET_ERR_MSG_MOD(info->extack,
> +					   "invalid target network namespace ID");
> +			NL_SET_BAD_ATTR(info->extack,
> +					info->attrs[OVPN_A_TARGET_NETNSID]);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		net = target_net;
> +	}
> +
>   	rcu_read_lock();
>   	dev = dev_get_by_index_rcu(net, ifindex);
>   	if (!dev) {
>   		rcu_read_unlock();
>   		NL_SET_ERR_MSG_MOD(info->extack,
>   				   "ifindex does not match any interface");
> +		put_net(target_net);
>   		return ERR_PTR(-ENODEV);
>   	}
>   
> @@ -59,12 +74,14 @@ ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
>   		NL_SET_ERR_MSG_MOD(info->extack,
>   				   "specified interface is not ovpn");
>   		NL_SET_BAD_ATTR(info->extack, info->attrs[OVPN_A_IFINDEX]);
> +		put_net(target_net);
>   		return ERR_PTR(-EINVAL);
>   	}
>   
>   	ovpn = netdev_priv(dev);
>   	netdev_hold(dev, tracker, GFP_ATOMIC);
>   	rcu_read_unlock();
> +	put_net(target_net);
>   
>   	return ovpn;
>   }
> diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
> index 06690090a1a9..3fdf24182df4 100644
> --- a/include/uapi/linux/ovpn.h
> +++ b/include/uapi/linux/ovpn.h
> @@ -85,6 +85,7 @@ enum {
>   	OVPN_A_IFINDEX = 1,
>   	OVPN_A_PEER,
>   	OVPN_A_KEYCONF,
> +	OVPN_A_TARGET_NETNSID,
>   
>   	__OVPN_A_MAX,
>   	OVPN_A_MAX = (__OVPN_A_MAX - 1)

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
