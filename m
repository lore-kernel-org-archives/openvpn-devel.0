Message-ID: <53C02E63.9070909@...1856...>
Date: Fri, 11 Jul 2014 20:35:15 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...>
	<53BFA5AA.4070305@...1147...>	<53BFA759.7060307@...1227...>
	<53BFA9A0.3020605@...1147...>	<53BFACDE.9050609@...1227...>
	<53BFAF81.2080705@...1147...>	<53BFC22C.5010601@...1227...>
	<53BFF9BE.1090204@...1147...>	<20140711180758.GJ1118@...1296...>
	<53C02A4E.6040103@...1147...>
In-Reply-To: <53C02A4E.6040103@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 11-07-14 20:17, Jan Just Keijser wrote:
> on CentOS 5 I get
> 
> checking for SSL_OP_NO_TICKET flag in OpenSSL... no
> configure: error: OpenVPN 2.4+ requires SSL_OP_NO_TICKET in OpenSSL
> 
> which is logical as the "stock" openssl lib on CentOS 5 is openssl 0.9.8 
> ; to me, this breaks CentOS 5 builds, as I have no option nor desire to 
> build & install openssl 1.0 on them.

Hmm, I actually checked that 0.9.8 (the minimum version supported by
2.4) has SSL_OP_NO_TICKET. From the OpenSSL changelog:

"Changes between 0.9.8e and 0.9.8f  [11 Oct 2007]
[...]
If a client or server wishes to disable RFC4507 support then the option
SSL_OP_NO_TICKET can be set."

I expected distributions had incorporated that by now. Not sure whether
to add extra code here, or just declare it ancient and let distros/users
either backport newer OpenSSL or use 2.3.

-Steffan

