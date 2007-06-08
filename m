Message-ID: <3bca39c60706080711w3c072bcbs17ebd0a8e504b24f@...278...>
Date: Fri, 8 Jun 2007 16:11:05 +0200
From: "Richard Hartmann" <richih.nospam@...1030...>
In-Reply-To: <9e0cf0bf0706080654o477baec5m6593996efadd7c37@...278...>
MIME-Version: 1.0
References: <3bca39c60706080647y13802064m35827220ba1b2ab6@...278...>
	<9e0cf0bf0706080654o477baec5m6593996efadd7c37@...278...>
Subject: Re: [Openvpn-devel] feature request: ability to pass pkcs#11 PIN
	via command line/config
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi Alon,


> This is not wise in term of security.

This depends on the use case and the requirements. If there was a way
to have the user enter their PIN before logging into Windows, I would
gladly use that.
Furthermore, the method I described is still more secure than any
solution based on certificates and keys which are stored on the hard
drive. With a token, the cert/key exist exactly _once_. Both a
keylogger and a trojan would be useless against my setup. The _only_
attack vector involves physical access to the token. If someone steals
the token, the end user will not be able to log in and complain to IT.
Thus, any stolen certificate can be disabled within days, if not
hours.
In the classic case, there is no way to be certain if your locally
stored certificate and key along with the passphrases are in the hands
of others.

> So I am sorry, but I don't think this should be supported.

If you look at --askpass via file, you can see how this problem can be
solved: Offer it to people who pass the test of being able to compile
OpenVPN. They either know what they do or they really do not deserve
otherwise.


> Especially when you can achieve the same via the management interface.

If by management interface you mean the netcat hack I am using, this
does not work as desired, yet. While I can flawlessly start my batch
files on a running Windows system and connect automagically, every
attempt to make this work as a Windows system service failed with a
timeout on the server's side. I can only presume that the netcat trick
is not working, for some reason.


If you can give me any insights on how to avoid that (or how to pass
the PIN as a remote connection password, as I am thinking about
replacing the system service with a remote connection, which plays
nicely with Windows' GINA), I would be honestly thankful to hear about
this, though.


Best regards,
Richard

