Message-ID: <4F513AF2.7000106@...1030...>
Date: Fri, 02 Mar 2012 21:26:10 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>	<20120229154604.GA7024@...1296...>	<CAP+U6t+pQXzvU-kGWDSZo6cQB6mf+LPd3LyLaowdB0xakbzjAQ@...278...>	<1677482.aKjq4FLfA1@...1526...>
	<20120302145712.GE1359@...1296...>
In-Reply-To: <20120302145712.GE1359@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
Cc: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> I've used "--route-nopull" together with specific "--route" statements
> to work around VPN setups that didn't work under specific circumstances
> (the server pushes a heap of routes, some of which caused problems in
> my setup [*], and I only wanted to reach a specific subnet via the VPN).
>   
+1

I've done exactly the same thing for exactly the same reasons, though I 
also use setcon as well (I have my own SELinux policy, so it makes sense 
for my own configuration/interfaces used).


