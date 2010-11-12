Message-ID: <4CDD0662.8010605@...1147...>
Date: Fri, 12 Nov 2010 10:18:26 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTinA0-1sAsFh0oo-cmREc+qUBE-2X8d-E7vSVf+s@...278...>
In-Reply-To: <AANLkTinA0-1sAsFh0oo-cmREc+qUBE-2X8d-E7vSVf+s@...278...>
Subject: Re: [Openvpn-devel] Architecture diagram & Theory of Operation
	documents
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

john s wolter wrote:
> I'm writing in response to this posting subject..
> "Re: [Openvpn-devel] VERY weird interaction between openvpn and 
> opensc-pkcs11"
>
> When it comes to debugging problems inside OpenVPN and other FOSS 
> software there is a lack of design information.  Architecture diagram 
> & Theory of Operation documents are a minimum starting point for those 
> not directly involved in development.  Do you have a link to these 
> documents?
>
> These documents will greatly improve the way OpenVPN works and how it 
> should be install and debugged.
>
Though I agree that more design/development documentation on how OpenVPN 
is supposed to work might be handy I have to disagree with this; any 
kind of architecture diagram, UML diagram, or whatever would not have 
helped to find this bug, as it's an implementation issue, not a design 
issue.

IMHO requiring design specifications and architecture diagrams is a very 
good way of discussing how things should be designed without actually 
building them. I'd much rather have something that works well (like 
OpenVPN) but might not have an architecture diagram than the other way 
round.

cheers,

JJK

PS I am not directly involved in the development of openvpn :)

>
>
>
> On Thu, Nov 11, 2010 at 9:32 AM, Jan Just Keijser <janjust@...1147... 
> <mailto:janjust@...1147...>> wrote:
>
>     hi all,
>
>     I just spent almost a day debugging a very weird interaction between
>     OpenVPN 2.1 and opensc-pkcs11 :
>
>     Hardware:
>     a Feitian ePass smartcard with an Omnikey CardMan 3121 card reader
>
>     Software:
>     openvpn 2.1.3
>     opensc 0.12.0 (not officially released yet)
>     pkcs11-helper 1.07
>     linux 2.6.34 64bit kernel (fc13)
>
>     Here's what happens:
>
>     openvpn starts up, queries me for the PKCS11 prompt, connection is
>     established alright.
>     When I look at the log file (with 'verb 99') I see that the pkcs11
>     function __pkcs11h_forkFixup is called several times, with a different
>     pid=%d value every time. This is bad, as it causes opensc-pkcs11 to
>     reload the card every time (it calls C_Finalize then
>     C_Initialize). This
>     operation is very expensive.
>     During key renegotiation it gets even worse, as openvpn prompts me for
>     the PIN again and connectivity is lost until I enter the PIN.
>
>     Now here's the weirdest part:
>
>     the __pkcs11h_forkFixup function is called after the invocation of an
>     external program (e.g. /sbin/ip link , /sbin/ip/addr add etc). If
>     I use
>      script-security 2 system
>     the openvpn_execve function uses 'system()' calls to start these
>     programs and the problem goes away !
>
>     So it seems that openvpn's openvpn_execve fork+waitpid function causes
>     the program pid to change every time, triggering the reset of the
>     pkcs11
>     interface !
>
>     What shall we do about this?
>
>     cheers,
>
>     JJK / Jan Just Keijser
>
>
>
>
>


