Message-ID: <4CDBFE7B.5030403@...1147...>
Date: Thu, 11 Nov 2010 15:32:27 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] VERY weird interaction between openvpn and
	opensc-pkcs11
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi all,

I just spent almost a day debugging a very weird interaction between 
OpenVPN 2.1 and opensc-pkcs11 :

Hardware:
a Feitian ePass smartcard with an Omnikey CardMan 3121 card reader

Software:
openvpn 2.1.3
opensc 0.12.0 (not officially released yet)
pkcs11-helper 1.07
linux 2.6.34 64bit kernel (fc13)

Here's what happens:

openvpn starts up, queries me for the PKCS11 prompt, connection is 
established alright.
When I look at the log file (with 'verb 99') I see that the pkcs11 
function __pkcs11h_forkFixup is called several times, with a different 
pid=%d value every time. This is bad, as it causes opensc-pkcs11 to 
reload the card every time (it calls C_Finalize then C_Initialize). This 
operation is very expensive.
During key renegotiation it gets even worse, as openvpn prompts me for 
the PIN again and connectivity is lost until I enter the PIN.

Now here's the weirdest part:

the __pkcs11h_forkFixup function is called after the invocation of an 
external program (e.g. /sbin/ip link , /sbin/ip/addr add etc). If I use
  script-security 2 system
the openvpn_execve function uses 'system()' calls to start these 
programs and the problem goes away !

So it seems that openvpn's openvpn_execve fork+waitpid function causes 
the program pid to change every time, triggering the reset of the pkcs11 
interface !

What shall we do about this?

cheers,

JJK / Jan Just Keijser






