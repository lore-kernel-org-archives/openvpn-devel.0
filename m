From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 11 Dec 2015 21:41:56 +0200
Message-ID: <566B2704.8070500@...277...>
References: <1447079709-17806-1-git-send-email-lstipakov@...277...>
	<20151109145555.GE24952@...1296...> <5642F6B7.7090902@...277...>
	<20151111081604.GU24952@...1296...>
Mime-Version: 1.0
In-Reply-To: <20151111081604.GU24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

>> So, if we want to use index also for "add/del route", I'd gently modify
>> add/del_route_ipv6 and make it use "interface=<idx>" (without breaking
>> "vpn server special route" case).
>
> For consistency, I think we should do that.  What I'd avoid is to do
> the adapter_index lookup for every single route - which would imply adding
> the index to struct tuntap_options or something like that which is
> available in add/del_route[_ipv6]() already.  But this is less elegant
> than I hoped for, and might have to look different for 2.3 and master.

Adding the index - you probably meant to "struct tuntap"?

Master has member "adapter_index", which seems to be used for "special 
case", release/2.3 does not have that.

Do you think it is safe to store adapter index there (would have to add 
it to 2.3) without breaking "special case"? I personally not so sure, 
since that "adapter_index" is obtained via "adapter_index_of_ip" in 
tun.c, which looks quite different from "get_adapter_index_flexible".

We might have a semantic problem here.

-Lev





