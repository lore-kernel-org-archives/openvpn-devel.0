Message-ID: <537EF8D7.6000108@...1435...>
Date: Fri, 23 May 2014 09:29:27 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <4061996.28260.1400689162655.JavaMail.root@...1893...>
	<537E6E68.4090005@...1856...>
In-Reply-To: <537E6E68.4090005@...1856...>
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
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 05/22/2014 11:38 PM, Steffan Karger wrote:
> On 21-05-14 18:19, Lisa Minogue wrote:
>> According to Debian Security Advisory DSA-2931-1 (http://www.debian.org/security/2014/dsa-2931) a bug in OpenSSL could result in a denial of service.
>>
>> Is OpenVPN 2.3.4 software (community edition, Microsoft Windows, Mac OS, *nix versions) affected by it?
> 
> Yes, if your OpenSSL is vulnerable, OpenVPN probably is too. I glanced
> over the code and the affected do_ssl3_write() seems to be in the normal
> TLS connection code path.

On a second look, OpenVPN is not vulnerable. The CVE explains:

"The do_ssl3_write function in s3_pkt.c in OpenSSL 1.x through 1.0.1g,
when SSL_MODE_RELEASE_BUFFERS is enabled."

But the patch to enable SSL_MODE_RELEASE_BUFFERS has not been merged yet
(but probably will, because is reduces memory usage significantly on
servers with many connections, see
https://community.openvpn.net/openvpn/ticket/157).

The advice is as usual:
 * Update your OpenSSL.
 * Use TLS auth as an extra layer of protection.

Regards,
-Steffan


