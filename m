From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvsk8kkuci.fsf-monnier+inbox@...1269...>
References: <4B88110D.3020501@...1114...>
	<jwvzl2vr3aw.fsf-monnier+inbox@...1269...>
	<4B8A59A2.6050601@...1114...>
	<jwvk4txceyv.fsf-monnier+inbox@...1269...> <1267418331.30675.4@...1207...>
Date: Mon, 01 Mar 2010 09:12:03 -0500
In-Reply-To: <1267418331.30675.4@...1207...> (Karl O. Pinc's message of "Sun, 28 Feb
	2010 22:38:51 -0600")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all
	IPs (second round)
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: Openvpn-devel@lists.sourceforge.net

>> If someone could give at least some vaguely plausible scenario,
>> that'd help.
> Maybe there's more than one tunnel and there's some stupid
> load balancing going on using a hosts file?  (Along with
> deleting all non-vpn routes.)

[ Setting aside the fact that using OpenVPN's broken handling of
  multi-FQDN to implement this is far from the only option. ]

I'm not even sure *how* this could work: how would you ensure that the
different tunnels happen to (together) route all IPs rather than all
chosing the same IP (for example)?


        Stefan

