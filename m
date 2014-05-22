Message-ID: <537E6E68.4090005@...1856...>
Date: Thu, 22 May 2014 23:38:48 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <4061996.28260.1400689162655.JavaMail.root@...1893...>
In-Reply-To: <4061996.28260.1400689162655.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] Is OpenVPN 2.3.4 (community edition) affected
 by OpenSSL's bug?
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

On 21-05-14 18:19, Lisa Minogue wrote:
> According to Debian Security Advisory DSA-2931-1 (http://www.debian.org/security/2014/dsa-2931) a bug in OpenSSL could result in a denial of service.
> 
> Is OpenVPN 2.3.4 software (community edition, Microsoft Windows, Mac OS, *nix versions) affected by it?

Yes, if your OpenSSL is vulnerable, OpenVPN probably is too. I glanced
over the code and the affected do_ssl3_write() seems to be in the normal
TLS connection code path.

-Steffan

