From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 and udev
In-Reply-To: <20041017170327.GG5221@...30...>
Message-ID: <Pine.LNX.4.61.0410172044001.23798@...210...>
References: <20041017102652.GC1621@...30...> <twig.1098020193.10343@...41...>
 <20041017161506.GC5221@...30...> <20041017170327.GG5221@...30...>
MIME-Version: 1.0
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
Date: Sun Oct 17 11:54:13 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 17 Oct 2004, Alberto Gonzalez Iniesta wrote:

>>> Incidentally, the error shown in the bug report looks like he is trying to
>>> make a tunnel between 1.6 and 2.0 using incompatible key-method parameters.
>>> He needs to set --key-method 2 on the 1.6 side.
>>
>>
>> Has this changed between 1.6 and 2 beta11?
>> The man page says --key-method defaults to 1 and the ChangeLog does not say otherwise.
>> I don't think this guy changed that to 2 just after he upgraded the
>> package. I'll ask him anyway, yo never know...
>> Could a problem with the TUN/TAP driver confuse the --key-method handling code?
>>
>
> James, as you may see in here [1] now, it seems that setting
> --key-method to 1 in the OpenVPN 2 side, solved the problem. Maybe that
> changed but it's not documented? Or there's something weird going on?

It is documented, but probably not where you looked :-)

1.6 defaults to key-method 1, while 2.0 defaults to key-method 2.

I found it documented in the following two places:

The 2.0 Release Notes. [1]
The Compatibility Notes. [2]

[1] http://openvpn.sourceforge.net/20notes.html
[2] http://openvpn.sourceforge.net/compat.html

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail

