MIME-Version: 1.0
In-Reply-To: <20140209115057.GT16637@...1296...>
References: <52F6E3AF.1080400@...1030...>
	<20140209115057.GT16637@...1296...>
Date: Sun, 9 Feb 2014 14:41:58 +0100
Message-ID: <CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>
From: Mickael Chazaux <mickael.chazaux@...277...>
Subject: Re: [Openvpn-devel] --local, --lport and --bind
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2014-02-09 12:50 GMT+01:00 Gert Doering <gert@...1296...>:
> Hi,
>
> On Sun, Feb 09, 2014 at 02:10:56AM +0000, Dash Four wrote:
>> Currently, openvpn only accepts "bind" if both "lport" and "local"
>> options are specified. Why?
>>
>> Why can't I specify "local" to instruct openvpn to bind to a specific IP
>> address or interface and leave it to decide a (random) port it binds to
>> in the same way in which the "nobind" option currently functions? What
>> is the reason for this unnecessary restriction?
>
> If I'm not mistaken, "the C API" - bind() always takes an address *and*
> a port number, so you can't just bind to an address alone.  (You can bind
> to a port alone because there's INADDR_ANY for "take any address on the
> system", but there's no specific "ANY_PORT").  Arne, correct me if I'm wrong.
>
> I think OpenVPN *could* make use of the --multihome mechanism to specify
> a source address (--local) without binding - but the multitude of open
> issues in trac regarding --multihome suggests there's good reasons why
> this is not done today.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
>
> ------------------------------------------------------------------------------
> Managing the Performance of Cloud-Based Applications
> Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> Read the Whitepaper.
> http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
Hi,

Although it is not easy to find on the Internet, you can bind a client
socket to a specific IP adress, while setting the port as 0, meaning
"choose for me". This is the same behaviour as not calling "bind" at
all and leave the kernel the choice of the port and the IP address.
Evidence in the source here :
http://lxr.free-electrons.com/source/net/ipv4/af_inet.c#L175
Or more generally, in "TCP/IP Illustrated: The Implementation, Vol. 2
" by Gary R. Wright and W. Richard Stevens.

I sometimes use this mechanism (bind <myip> + lport = 0) in
combination with source routing to force an OpenVPN client out a
specific interface.

Cheers

Mickael

