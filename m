Message-ID: <c561e353-4cb2-a584-65c4-50ffd6068ef0@...2712...>
Date: Thu, 9 Feb 2023 22:09:45 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230209153658.24001-1-ynezz@...2710...>
 <b187a379-2bc1-6a7b-9bb6-a53fb1358c4f@...2712...>
 <Y+VLn5pTX3a3y08t@...1296...>
From: Mykhailo Mishchenko <mdmisch@...2712...>
In-Reply-To: <Y+VLn5pTX3a3y08t@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] get_addr_generic: fix server crash in
 freeaddrinfo on musl libc
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

On 09.02.23 21:38, Gert Doering wrote:

> CNs with commas in them are a long-standing issue, because OpenVPN
> doesn't know how to deal with them.  So, don't do that.
Ugh... Sometimes it is just not realistic to reissue certificates. :(
It would be great to at least have it mentioned in BUGS section of the 
man page.

On 09.02.23 21:38, Gert Doering wrote:
> (There is an old Trac ticket about it, but nobody went out and fixed
> the code yet - which is tricky, as you can't just change the format
> of ifconfig-pool-persist without breaking existing setups)

I would escape the comma with backslash, for example. It would only 
break those setups, which are already broken because they have a comma 
in a CN of a client certificate. But maybe there are reasons why this is 
also problematic, and I just don't know about them.

Mykhailo


