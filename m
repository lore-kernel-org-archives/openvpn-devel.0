Message-ID: <20101214194612.17985.qmail@...1287...>
Date: Tue, 14 Dec 2010 20:46:12 +0100
From: Peter Stuge <peter@...1287...>
References: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>
	<1292286924.6222.3.camel@...1259...>
	<AANLkTikhRr-YhNP4OaZM8kCJ++-OcKh=eQ9jAeedxjNj@...278...>
	<4D07AEC7.3010408@...1114...>
	<AANLkTik0razPaAEqNSNEYgsoH_sczjUSj7fbgVsVraYy@...278...>
MIME-Version: 1.0
In-Reply-To: <AANLkTik0razPaAEqNSNEYgsoH_sczjUSj7fbgVsVraYy@...278...>
Subject: Re: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Vineet Kumar wrote:
> Are there ways around that : making telnet accept multiple sessions?

You could serialize your administrative requests somehow and only
ever have one entity use the admin interface.


//Peter

