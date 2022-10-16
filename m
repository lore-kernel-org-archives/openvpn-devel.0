Message-ID: <f9ad8227-23d4-5b17-5f44-37112db4befd@...1227...>
Date: Sun, 16 Oct 2022 17:51:48 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
 <20221011110126.1798114-1-arne@...1227...> <Y0l/IPVu988ffsYd@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y0l/IPVu988ffsYd@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Change explicit exit notification to be
 a SIGUSR1 instead of a SIGTERM signal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


> 
> If we care about logging, I think we should do the signal remap in
> multi_close_instance_on_signal()  (... which already remaps SIGUSR1
> by means of remap_signal(), but only if c->options.remap_sigusr1 is
> set).
> 
> OTOH, maybe it should just *not* call remap_signal(), as the per-instance
> signals and the global signals do different things, and always remap
> SIGUSR1-in-instance to SIGTERM...
> 
> 
> What I do not think will make us happy in future is the extra
> conditionals in v2...

A completely different effect screwed up my testing and lead to believe 
that signals are handled different in p2p and p2mp. There is different 
behaviour in p2p and p2mp but it is triggered by the HMAC cookie 
approach that only p2mp has. Detailed explaination is in the code in 
patch v3.

Arne

