Message-ID: <4AD4C0BE.4090709@...1114...>
Date: Tue, 13 Oct 2009 20:02:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <BLU0-SMTP4766D046DAC27387E8F14BBC90@...512...>	<4AD494F3.30805@...41...>
	<BLU0-SMTP94F951A9B55CEC1F31E476BBC70@...512...>
In-Reply-To: <BLU0-SMTP94F951A9B55CEC1F31E476BBC70@...512...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: The Zep Man <the_zep_man@...160...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/10/09 19:28, The Zep Man wrote:
> James Yonan wrote:
>> The best way to programmatically supply the username/password on the 
>> client side is to use the OpenVPN management interface.
>>
>> James
> 
> And the worst way is by using a file on a disk (which is why it is 
> disabled by default on compilation time). How about something in 
> between? Something that is perhaps also easier to use from scripts, 
> while still being secure in certain environments (like Windows)? The 
> management interface requires a TCP port, which requires extra 
> programming to use. It could also conflict with some firewalls (even 
> when used on the loopback interface). Why bother with the entire 
> management interface if the only thing you want is to simply insert a 
> username and password with reasonable security?
> 
> I'm not saying that the management interface is bad. However, a somewhat 
> trivial function like username/password insertion should be easier. It's 
> accepted that OpenVPN as a server uses the environment to parse incoming 
> usernames/passwords to other programs. Why can't OpenVPN also accept a 
> username and password from the environment?
> 

Am I missing something here or?  openvpn does support this already, but
I'm doing it via a C plug-in ...

<http://www.eurephia.net/doxygen/eurephia-devel/eurephia_8c_source.html#l00348>

In line 348 the username is extracted via a GETENV_USERNAME() macro, and
in line 377 GETENV_PASSWORD() is used to grab the password.  That's
taken from the environment table.

But it might be that it's not exported to the shell if you are using the
script interface.

I haven't studied the openvpn code to see if this goes for the script
interface ... but if it really is missing, it shouldn't be that hard to
fix.  On the otherhand, if it is difficult, writing your own script
runner as a plug-in is definitely not an impossible task.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkrUwLoACgkQDC186MBRfrrmaACgoYiHmwBrExYTsHlEQZs+/8d5
dxIAn2D9K+oE6Glh28C1weYuy4Rk9rLD
=zBhV
-----END PGP SIGNATURE-----

