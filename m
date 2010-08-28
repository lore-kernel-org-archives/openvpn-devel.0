MIME-Version: 1.0
In-Reply-To: <20100828045408.17377.qmail@...1287...>
References: <4C77640D.6000708@...515...> <20100828024617.942.qmail@...1287...>
	<AANLkTinftXxDOX4J=njhby1oEKRtZUZGb57EgPdMiGsz@...278...>
	<20100828045408.17377.qmail@...1287...>
Date: Sat, 28 Aug 2010 11:09:26 +0300
Message-ID: <AANLkTi=rBnxNCQ5cEq5aBpaAN74NN_uE1BxxyCt0yO8t@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I am not sure ELF is capable of mixing static/dynamic in same module.
I had this problem in several cases, at the end, dynamic glibc was
used.

On 8/28/10, Peter Stuge <peter@...1287...> wrote:
> Alon Bar-Lev wrote:
>> > > Did some testing to see if creating a static binary would be
>> > > trivial. As it was not,
>> >
>> > Why wasn't it? Please share details from the testing.
>>
>> I guess the modules, pkcs11 and other components that uses dlopen
>> should be disabled in openvpn.
>
> Well, as a first step it would be nice to build the openvpn binary
> statically. Even if it still uses dlopen e.g. for p11.
>
>
> //Peter
>
> ------------------------------------------------------------------------------
> Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
> Be part of this innovative community and reach millions of netbook users
> worldwide. Take advantage of special opportunities to increase revenue and
> speed time-to-market. Join now, and jumpstart your future.
> http://p.sf.net/sfu/intel-atom-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

