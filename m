Message-ID: <55E432F8.5040204@...1147...>
Date: Mon, 31 Aug 2015 12:56:56 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
In-Reply-To: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
Subject: Re: [Openvpn-devel] Disable TLS for mode server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Valentin Sawadski <valentin@...2062...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Valentin,

Valentin Sawadski wrote:
> Hello,
>
> I'm looking for a way to remove any encryption or MAC from OpenVPN in
> "--mode server".
>
> Since I'm new to the OpenVPN code base my starting point right now
> will be patching "options.c" to allow "--mode server" without TLS.
> Will this already be enough to make it work or is TLS tightly
> integrated into the workings of the mode?
>
> Thanks for any pointers!
>   

you don't need to run openvpn using '--mode server' at all. If you run a 
poin-to-point connection like this

  openvpn --ifconfig 10.200.0.1 10.200.0.2 --dev tun --proto udp 
--cipher none --auth none

  openvpn --ifconfig 10.200.0.2 10.200.0.1 --dev tun --proto udp 
--cipher none --auth none --remote <remote host>

then you'll end up with a fully plaintext tunnel.
If you insist on using (useless) certificates and some form of "--mode 
server" then I'd suggest using

  --mode server   --tls-cipher NONE --cipher none --auth none


this should also disable the TLS cipher as well.
IOW, no code changes should be needed at all :)

HTH,

JJK


