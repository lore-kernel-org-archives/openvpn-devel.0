Message-ID: <20100828225122.27602.qmail@...1287...>
Date: Sun, 29 Aug 2010 00:51:22 +0200
From: Peter Stuge <peter@...1287...>
References: <4C77640D.6000708@...515...> <20100828024617.942.qmail@...1287...>
	<AANLkTinftXxDOX4J=njhby1oEKRtZUZGb57EgPdMiGsz@...278...>
	<20100828045408.17377.qmail@...1287...>
	<AANLkTi=rBnxNCQ5cEq5aBpaAN74NN_uE1BxxyCt0yO8t@...278...>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=rBnxNCQ5cEq5aBpaAN74NN_uE1BxxyCt0yO8t@...278...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Alon Bar-Lev wrote:
> I am not sure ELF is capable of mixing static/dynamic in same module.
> I had this problem in several cases, at the end, dynamic glibc was
> used.

I'm not sure what the problem would be.

I think a static binary should be able to dlopen a .so fine at least
if it the .so doesn't link dynamically to anything else, but maybe
even then?


//Peter

