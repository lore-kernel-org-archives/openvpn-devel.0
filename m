Message-ID: <55CB1B6B.8010404@...1227...>
Date: Wed, 12 Aug 2015 12:09:47 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <55CA09E0.3020503@...2052...>	<20150811191949.GJ382@...1296...>	<55CB0817.4010503@...2052...>
	<55CB0B2C.2090605@...2053...>
In-Reply-To: <55CB0B2C.2090605@...2053...>
Subject: Re: [Openvpn-devel] SRV record support
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
To: Markus Grundmann <markus@...2053...>, openvpn-devel@lists.sourceforge.net



Am 12.08.15 um 11:00 schrieb Markus Grundmann:
> Hi,
>
> I'm not a OpenVPN developer but the support of SRV records is a good
> idea. A client configuration works without a predefined VPN server and
> port and whenever you move your VPN server to another location or
> network. Only a domain must defined that contain the right service
> record. I think it sound's very good or?!
>
> -
Yes but changing AAAA/A of opnvpn.company.com or IN SRV of
openvpn.company.com is not such a big difference.

At the moment a config with just

client
remote openvpn.company.com

does not work (you need at least specificy a ca and an authentification
method etc...), so the main advantage of SRV records, which is just
specify your domain and the software will automatically figure out
server etc. does not
apply here.

Arne

