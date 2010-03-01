Message-ID: <4B8C3496.6000206@...376...>
Date: Mon, 01 Mar 2010 22:41:42 +0100
From: Bernhard Schmidt <berni@...376...>
MIME-Version: 1.0
References: <20100228150546.GO9556@...1296...>	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>	<4B8A8DC9.3020502@...1114...>	<20100228221425.GT9556@...1296...>	<4B8AF4AD.8060402@...1114...>
	<hmhae1$p5k$1@...1312...> <4B8C30A2.5020200@...1114...>
In-Reply-To: <4B8C30A2.5020200@...1114...>
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Hi David,

>> It doesn't make a difference at the moment (since the patch came from
>> feat_ipv6_payload in the first place), but what's the general wish for
>> the future? What to rebase on?
>
> To be very honest, I'm very uncertain about what's best.  Because it
> will a lot of changes in multiple branches.  But as I'm able now to keep
> the bugfix2.1 branch pretty clean with only bugfixes, I begin to lean
> towards that you should consider to rebase on that branch.

Could you please have a look at git://git.birkenwald.de/openvpn.git 
test-rebase branch? The history of gert-ipv6 was starting to look a bit 
weird (duplicate commits with the same content), to I rebased it on your 
bugfix2.1 branch (and dropped the duplicate commits in the process). No 
difference in the content whatsoever and the history looks much better, 
but I'm not exactly sure whether this is the right thing to do.

Bernhard

