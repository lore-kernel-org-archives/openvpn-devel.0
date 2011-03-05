MIME-Version: 1.0
In-Reply-To: <4D717DB0.3030107@...1030...>
References: <4D713CD3.3000606@...515...>
	<AANLkTin4QkZ36mi7qHyB9R+i1FdQJi66mi6nhhvYMWmN@...278...>
	<4D716245.6040500@...1114...>
	<4D717DB0.3030107@...1030...>
Date: Sat, 5 Mar 2011 08:48:38 +0200
Message-ID: <AANLkTikYoeusGQ3yFcCN9QrrAPWknAngoqiv5iWRD+Y3@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-RC released
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
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sat, Mar 5, 2011 at 2:02 AM, Mr Dash Four
<mr.dash.four@...1030...> wrote:
> Speaking of which, I also proposed a (rather trivial) patch which enables
> cross compilation of a number of OpenVPN plugins (that patch is attached
> again) as in the 2.1.4 version that was not possible.

I think you should leave the -O2 as default to CFLAGS.

CFLAGS=-O2

Can be overridden by:

make CFLAGS="-O0"

