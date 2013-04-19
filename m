Message-ID: <51711447.1060706@...1737...>
Date: Fri, 19 Apr 2013 10:54:15 +0100
From: Ed W <lists@...1737...>
MIME-Version: 1.0
References: <5170496A.6000000@...1737...>
	<20130418204455.GW29506@...1296...>
In-Reply-To: <20130418204455.GW29506@...1296...>
Subject: Re: [Openvpn-devel] Support for libsodium?
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 18/04/2013 21:44, Gert Doering wrote:
> Hi,
>
> On Thu, Apr 18, 2013 at 08:28:42PM +0100, Ed W wrote:
>> Hi, given the new abstractions to support PolarSSL, what
>> interest/resistance would there be to supporting libsodium?
>>       https://github.com/jedisct1/libsodium
> It took us quite some effort to reach the point where a polarssl-compiled
> openvpn would be able to talk to a (default-configured) openssl-openvpn,
> and I don't really see us using a crypto library that has none of the
> algorithms that we need for interoperability.
>
> But then, I'm not the crypto geek here, I'm just the janitor...

Just to be clear - the end result using libsodium would *not* speak to 
an openssl peer.  Only libsodium to libsodium would be supported.  
Essentially, libsodium is a very simple API which defines restricted 
choices for crypto alorithms and signing algorithms. The choices are at 
least finalists at various crypto competitions and therefore sensible 
(ie they have had at least sensible amounts of peer review)

So basically there is no requirement to negotiate crypto protocols, 
there is just one choice... (but the hope is that it's a good one and 
worth the reduction in code quantity)

Cheers

Ed W

