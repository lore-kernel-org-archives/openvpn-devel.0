References: <20160716181726.GQ78279@...1296...>
	<1468696381.29435.18578.36594@...2154...>
	<20160716202207.GT78279@...1296...>
From: debbie10t <debbie10t@...277...>
Message-ID: <578A9CED.2090702@...277...>
Date: Sat, 16 Jul 2016 21:45:33 +0100
MIME-Version: 1.0
In-Reply-To: <20160716202207.GT78279@...1296...>
Subject: Re: [Openvpn-devel] net6_gateway feature request
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



On 16/07/16 21:22, Gert Doering wrote:
>> Ok, here we go.
>> >Private network is just an example. Real case is: I have two openvpn's. One for work and one my personal. My personal OpenVPN to hosters VPS always ON, so all my internet traffic i encrypted.
>> >But when I enable OpenVPN from my work, it becomes OpenVPN over OpenVPN (work vpn over my personal one). I just want to avoid OpenVPN over OpenVPN :)
> OK, that makes more sense - in both OpenVPN configs, you want to ensure
> that the*other*  VPN server is routed via net_gateway(6).  Indeed,
> convincing :-)

If you *are* the client then you can customise your config & environment
per site with (eg) --setenv my_route_net6_gateway blah:blah:blah::x



