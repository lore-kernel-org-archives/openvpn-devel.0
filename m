References: <10719981480674741@...2206...>
From: debbie10t <debbie10t@...277...>
Message-ID: <8e0f7ca4-a790-2143-ccfa-8e6ab6114955@...277...>
Date: Fri, 2 Dec 2016 12:55:25 +0000
MIME-Version: 1.0
In-Reply-To: <10719981480674741@...2206...>
Subject: Re: [Openvpn-devel] Enable FIPS encryption
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 02/12/16 10:32, boxartst@...1411... wrote:
> Hi!
>
> I would like to know if it's possible to enable fips  enabled encryption on my vpn server?
> Here is a link to fips user guide https://www.openssl.org/docs/fips/UserGuide-2.0.pdf .
> It looks like I'd have to change source code and compile it myself to make it FIPS compliant.
> Any help or advice would be very much appreciated.
>

Without very much effort it is possible to build openvpn with openssl
FIPS support on CentOS7:

OpenVPN 2.4_beta2 [git:master/1c587a1112220618+] 
x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] 
[MH/PKTINFO] [AEAD] built on Dec  1 2016
library versions: OpenSSL 1.0.1e-fips 11 Feb 2013, LZO 2.06

OpenSSL 1.0.1e-fips appears to be the default openssl developer library
in CentOS7.

I do not know enough about FIPS certification to advise if *only* this
change is sufficient to cover you for real world certification.

Regards

