References: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
	<deb274b8-709f-9bec-40f3-279d75d114a0@...2070...>
	<20161030101616.GV28918@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1a5fa7e8-d359-9128-c9b5-bb7049339aef@...1227...>
Date: Sun, 30 Oct 2016 19:08:29 +0100
MIME-Version: 1.0
In-Reply-To: <20161030101616.GV28918@...1296...>
Subject: Re: [Openvpn-devel] dhcp-option DNS IPv6 server address for windows
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 30.10.16 um 11:16 schrieb Gert Doering:
> Hi,
> 
> On Sun, Oct 30, 2016 at 12:18:39PM +0300, ValdikSS wrote:
>> ?probably not only DHCPv6, but also Router Advertisement too. I doubt that DHCPv6 could be used without RA on Windows.
> 
> It's a somewhat multi-stage thing
> 
>  - first, define a new dhcp-option (like, "DNS6") that will take a
>    v6 address, and put it into the environment variables on the client
>    (so scripts and networkmanger etc. can pick it up and do the right 
>    thing wrt resolv.conf)
> 
>  - then, figure out how to inject this into windows - as far as I know, 
>    windows will always try to do DHCPv6, even if no RA seen, but this is
>    something easily tested.   Maybe it can be done without DHCPv6 by
>    just calling an API call ("hey, here's DNS info!") on recent systems,
>    maybe we need to implement a fake DHCPv6 server - someone needs to 
>    look into this, and come up with an implementation.
> 
> #1 could easily make 2.4, #2 is very likely to not make it.

#1 is also something I would like to have for Android.

Arne


