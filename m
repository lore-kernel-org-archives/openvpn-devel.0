From: Michael Hieb <michael_hieb@...183...>
Message-Id: <20040316145421.06d2d129.michael_hieb@...183...>
In-Reply-To: <405756E7.3090906@...180...>
References: <405756E7.3090906@...180...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] no chance trying openvpn
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Mar 16 13:16:39 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: pi <list@...180...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

I have to tell you my experience on SuSE distro(s) [Sparc & Intel] worked like
a charm. Perhaps if you look at the configure options you can help configure
find the ssl headers. For example...

fuego:/tmp/openvpn-1.6_beta1 # ./configure --help
[snip...]
Optional Packages:
  --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  --with-ssl-headers=DIR  Crypto/SSL Include files location
  --with-ssl-lib=DIR      Crypto/SSL Library location
[snip...]

Also googling shows you are not alone in having this problem on Redhat, e.g.
http://www.google.com/search?hl=en&lr=&ie=UTF-8&oe=UTF-8&q=redhat+%22checking+for+openssl%2Fssl.h...+no%22&btnG=Google+Search

Good luck...

On Tue, 16 Mar 2004 20:35:03 +0100
pi <list@...180...> wrote:

> I can really say "I'm not lucky with VPN solutions!!"
> 
> 
> First, I tried superfreeswan then openswan then freeswan with kernel 
> compiled for NAT-T support.
> In lab, it worked. Over the internet it never worked.........
> I had no good support neither answers to some of my questions (surely 
> due to bugs)
> 
> I discovered today openvpn (tada.....),
> 
> first: impossible to install it on my redhat9.0
> I always got the message
> 
> configure: checking for OpenSSL SSL Library and Header files...
> checking openssl/ssl.h usability... no
> checking openssl/ssl.h presence... no
> checking for openssl/ssl.h... no
> configure: error: OpenSSL SSL headers not found.
> 
> I have openssl installed on this system:
> # rpm -qa|grep ssl
> mod_ssl-2.0.40-21.9
> openssl-devel-0.9.7a-20
> openssl-0.9.7a-20
> 
> I post a message on this list but no answer  :-((
> I tried to attach my config.log to this mail, but there's a limit of 40k/message.
> 
> 
> 
> Then I find a RPM package from dag's repository  
> (http://dag.wieers.com/packages/openvpn/)
> Installation is correct, but when I try to launch openvpn, I got the 
> following in /var/log/messages:
> 
> Mar 16 20:30:05 moulinsart openvpn[2593]: OpenVPN 1.5.0 
> i386-redhat-linux [SSL] [LZO] [PTHREAD] built on Nov 25 2003
> Mar 16 20:30:05 moulinsart openvpn[2593]: Static Encrypt: Cipher 
> 'BF-CBC' initialized with 128 bit key
> Mar 16 20:30:05 moulinsart openvpn[2593]: Static Encrypt: Using 160 bit 
> message hash 'SHA1' for HMAC authentication
> Mar 16 20:30:05 moulinsart openvpn[2593]: Static Decrypt: Cipher 
> 'BF-CBC' initialized with 128 bit key
> Mar 16 20:30:05 moulinsart openvpn[2593]: Static Decrypt: Using 160 bit 
> message hash 'SHA1' for HMAC authentication
> Mar 16 20:30:05 moulinsart openvpn[2593]: LZO compression initialized
> Mar 16 20:30:05 moulinsart modprobe: modprobe: Can't locate module 
> char-major-10-200
> Mar 16 20:30:05 moulinsart openvpn[2593]: Note: Cannot open TUN/TAP dev 
> /dev/net/tun: No such device (errno=19)
> Mar 16 20:30:05 moulinsart openvpn[2593]: Note: Attempting fallback to 
> kernel 2.2 TUN/TAP interface
> Mar 16 20:30:05 moulinsart openvpn[2593]: Cannot allocate TUN/TAP dev 
> dynamically
> Mar 16 20:30:05 moulinsart openvpn[2593]: Exiting
> Mar 16 20:30:05 moulinsart openvpn:  failed
>  
> WHAT CAN I DO ???
> 
> Phil
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users

