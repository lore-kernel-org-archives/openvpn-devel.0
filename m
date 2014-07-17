Message-ID: <53C78ADE.8010005@...1435...>
Date: Thu, 17 Jul 2014 10:35:42 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <24586198.798006.1405584918282.JavaMail.root@...1893...>
In-Reply-To: <24586198.798006.1405584918282.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] OpenVPN and OpenVPN-NL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07/17/2014 10:15 AM, Lisa Minogue wrote:
> I happened to read some information about OpenVPN-NL.
> 
> According to https://openvpn.fox-it.com/background.html a Dutch government agency is of the opinion that among many other reasons, OpenVPN allows insecure configurations.
> 
> Would OpenVPN developers like to investigate the Dutch government agency's claim and perhaps improve OpenVPN 2.3.4-I002?

No need to investigate, I'm the one maintaining OpenVPN-NL for the Dutch
government at Fox-IT.

Regular OpenVPN offers a lot of configuration options, amongst which
option like 'disable encryption', 'disable authentication'. OpenVPN-NL
explicitly disables those options, as it aims purely on a market using
OpenVPN as a security product. OpenVPN itself however seems to be used
as a pure virtual networking product too, where these options can be useful.

Furthermore, a lot of the changes that were made by us for OpenVPN-NL
(notably, support for the PolarSSL backend), have already been
integrated upstream.

-Steffan

