Message-ID: <405756E7.3090906@...180...>
From: pi <list@...180...>
MIME-Version: 1.0
Subject: [Openvpn-devel] no chance trying openvpn
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
Date: Tue Mar 16 11:34:13 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

I can really say "I'm not lucky with VPN solutions!!"


First, I tried superfreeswan then openswan then freeswan with kernel 
compiled for NAT-T support.
In lab, it worked. Over the internet it never worked.........
I had no good support neither answers to some of my questions (surely 
due to bugs)

I discovered today openvpn (tada.....),

first: impossible to install it on my redhat9.0
I always got the message

configure: checking for OpenSSL SSL Library and Header files...
checking openssl/ssl.h usability... no
checking openssl/ssl.h presence... no
checking for openssl/ssl.h... no
configure: error: OpenSSL SSL headers not found.

I have openssl installed on this system:
# rpm -qa|grep ssl
mod_ssl-2.0.40-21.9
openssl-devel-0.9.7a-20
openssl-0.9.7a-20

I post a message on this list but no answer  :-((
I tried to attach my config.log to this mail, but there's a limit of 40k/message.



Then I find a RPM package from dag's repository  
(http://dag.wieers.com/packages/openvpn/)
Installation is correct, but when I try to launch openvpn, I got the 
following in /var/log/messages:

Mar 16 20:30:05 moulinsart openvpn[2593]: OpenVPN 1.5.0 
i386-redhat-linux [SSL] [LZO] [PTHREAD] built on Nov 25 2003
Mar 16 20:30:05 moulinsart openvpn[2593]: Static Encrypt: Cipher 
'BF-CBC' initialized with 128 bit key
Mar 16 20:30:05 moulinsart openvpn[2593]: Static Encrypt: Using 160 bit 
message hash 'SHA1' for HMAC authentication
Mar 16 20:30:05 moulinsart openvpn[2593]: Static Decrypt: Cipher 
'BF-CBC' initialized with 128 bit key
Mar 16 20:30:05 moulinsart openvpn[2593]: Static Decrypt: Using 160 bit 
message hash 'SHA1' for HMAC authentication
Mar 16 20:30:05 moulinsart openvpn[2593]: LZO compression initialized
Mar 16 20:30:05 moulinsart modprobe: modprobe: Can't locate module 
char-major-10-200
Mar 16 20:30:05 moulinsart openvpn[2593]: Note: Cannot open TUN/TAP dev 
/dev/net/tun: No such device (errno=19)
Mar 16 20:30:05 moulinsart openvpn[2593]: Note: Attempting fallback to 
kernel 2.2 TUN/TAP interface
Mar 16 20:30:05 moulinsart openvpn[2593]: Cannot allocate TUN/TAP dev 
dynamically
Mar 16 20:30:05 moulinsart openvpn[2593]: Exiting
Mar 16 20:30:05 moulinsart openvpn:  failed
 
WHAT CAN I DO ???

Phil











