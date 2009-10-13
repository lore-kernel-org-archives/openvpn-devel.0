Message-ID: <BLU0-SMTP94F951A9B55CEC1F31E476BBC70@...512...>
Date: Tue, 13 Oct 2009 19:28:07 +0200
From: The Zep Man <the_zep_man@...160...>
MIME-Version: 1.0
References: <BLU0-SMTP4766D046DAC27387E8F14BBC90@...512...>
	<4AD494F3.30805@...41...>
In-Reply-To: <4AD494F3.30805@...41...>
Subject: Re: [Openvpn-devel] Feature request: Client-side username/password
 retrieval using environment variables
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
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> The best way to programmatically supply the username/password on the 
> client side is to use the OpenVPN management interface.
> 
> James

And the worst way is by using a file on a disk (which is why it is 
disabled by default on compilation time). How about something in 
between? Something that is perhaps also easier to use from scripts, 
while still being secure in certain environments (like Windows)? The 
management interface requires a TCP port, which requires extra 
programming to use. It could also conflict with some firewalls (even 
when used on the loopback interface). Why bother with the entire 
management interface if the only thing you want is to simply insert a 
username and password with reasonable security?

I'm not saying that the management interface is bad. However, a somewhat 
trivial function like username/password insertion should be easier. It's 
accepted that OpenVPN as a server uses the environment to parse incoming 
usernames/passwords to other programs. Why can't OpenVPN also accept a 
username and password from the environment?

Zep

