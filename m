MIME-Version: 1.0
In-Reply-To: <11052645.930865.1405935348844.JavaMail.root@...1893...>
References: <11052645.930865.1405935348844.JavaMail.root@...1893...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 21 Jul 2014 13:24:53 +0200
Message-ID: <CAA1Abx+R_ARom8UBH2z-qRz0bqwq7==vT5KY93OWCgeQQc=ShA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Lisa Minogue <lminogue@...1892...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Lisa,

On Mon, Jul 21, 2014 at 11:35 AM, Lisa Minogue <lminogue@...1892...> wrote:
> do you have plans to replace OpenSSL with PolarSSL or LibreSSL? And how soon will new bundles of OpenVPN software be released that incorporate OpenSSL alternatives?

OpenVPN is already capable of using PolarSSL instead of OpenSSL, see
http://community.openvpn.net/openvpn/wiki/UsingPolarSSL. I don't know
of any 'regular' OpenVPN software releases that use PolarSSL, but
there is OpenVPN-NL (https://openvpn.fox-it.com) that uses PolarSSL.

LibreSSL has just been ported to Linux. As soon as it becomes mature
and readily available in distros, I think it would be nice to add it
as an option for OpenVPN, but afaik there are currently no concrete
plans to do so.

-Steffan

