From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 23 Aug 2012 15:45:57 +0200
Message-ID: <3026659.dQ0z7Nl7Cc@...1745...>
In-Reply-To: <1345727389.42365.YahooMailNeo@...1744...>
References: <1345727389.42365.YahooMailNeo@...1744...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, "ammdispose-vpn@...109..." <ammdispose-vpn@...109...>

Hi

On Thu 23 08 2012 21:09:49 ammdispose-vpn@...109... wrote:
> So my idea was
> 1) Add a new option called script-dir
> 2) Frontend will not allow word "script-dir" in config file (so admin cant
> change it) 
> 3) script-dir will be passed on command line
> 
> This way admin can not run anything other than what I have put in
> script-dir. This also helps prevent accidentally run script in some other
> path.

As this is very specific to you frontend, why doesn't your frontend simple 
check the path names in the config for correctness before deploying it?

Regards
Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


