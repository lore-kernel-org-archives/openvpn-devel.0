From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
Subject: Re: [Openvpn-devel] no chance trying openvpn
References: <405756E7.3090906@...180...>
In-Reply-To: <405756E7.3090906@...180...>
MIME-Version: 1.0
Message-Id: <200403171916.00612@...187...>
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
Date: Wed Mar 17 09:17:04 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

    I have 'rpmbuild --rebuild'-ed dag's 1.5.0 .src.rpm and have it running with
Mandrake 8.2, RedHat 9 and Fedora Core 1. Then I tryed 1.6.0-test3,4,7, rc1,
rc2 and rc3 now. No problems rebuilding and running on all systems. I have not
added any aliases in /etc/sysconfig or whatever, only added configs files
in /etc/openvpn...

On Tuesday 16 March 2004 21:35, pi wrote:
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

Here they are:
[ pts/18:mr700@...185...:~ ]$ rpm -qa \*ssl\*
openssl-0.9.7a-20
mod_ssl-2.0.40-21.9
docbook-style-dsssl-1.76-8
openssl096b-0.9.6b-12
openssl-devel-0.9.7a-20
openssl096-0.9.6-23.9
openssl-perl-0.9.7a-20
[pts/18:mr700@...186...:~]$ rpm -q gcc
gcc-3.2.2-5

> 
> I post a message on this list but no answer  :-((
> I tried to attach my config.log to this mail, but there's a limit of 40k/message.
> 
> 
> 
> Then I find a RPM package from dag's repository  
> (http://dag.wieers.com/packages/openvpn/)

Yep, I just updated to newer sources and --rebuild-ed...

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
    See why tun does not load. Loda it by hand 'modprobe'. Do a
'rpmverify openssl-devel-0.9.7a-20' and so on to check your packages
and so on. There's something wrong with your system. For me it worked
without any problems with Mandrake 8.2, RedHat 9 and Fedora Core 1.
I tryed 1.4, 1.5, 1.6-test3,4,7, 1.6-rc1,rc2 and rc3 - no problem at all.
(I am still testing it, so I can update with every new test/rc, even
1.4 works with 1.6-rc3)

-- 
Regards,
  Doncho N. Gunchev    Registered Linux User #291323 at counter.li.org
  GPG-Key-ID: 1024D/DA454F79
  Key fingerprint = 684F 688B C508 C609 0371  5E0F A089 CB15 DA45 4F79

