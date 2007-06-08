Message-ID: <9e0cf0bf0706081021i327fd9a4xcb34ea06921e8c0e@...278...>
Date: Fri, 8 Jun 2007 20:21:04 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <3bca39c60706080711w3c072bcbs17ebd0a8e504b24f@...278...>
MIME-Version: 1.0
References: <3bca39c60706080647y13802064m35827220ba1b2ab6@...278...>
	<9e0cf0bf0706080654o477baec5m6593996efadd7c37@...278...>
	<3bca39c60706080711w3c072bcbs17ebd0a8e504b24f@...278...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Richard Hartmann <richih.nospam@...1030...>
Cc: openvpn-devel@lists.sourceforge.net

Well... you keep saying that you know what you are doing... So please
explain me....
1. What happens if no card is inserted at startup?
2. What happens if the card is removed?
3. What happens if the card is removed and inserted?
4. What happens if the wrong card is inserted?

Smartcards are dynamic in nature, and in order to automate this, you
must really know what you are doing. Simply specifying static PIN is
really not enough.

So if you really know what you are doing, the management API is the
place to automate the process. You can read the token name and decide
which PIN to use, you can also deal with token remove and insert.

I don't have a clue why you use netcat and not perl script I
offered... But I am sure that if you know what you are doing you can
solve this issue.

Replacing GINA seems as a good idea, but this is not the right way to
go... If you wish to contribute to other users, a RAS provider for
OpenVPN is a solution that all Windows users wait for... RAS is the
standard way to look at OpenVPN, so you "dial" during logon.

Best Regards,
Alon Bar-Lev.

On 6/8/07, Richard Hartmann <richih.nospam@...1030...> wrote:
> Hi Alon,
>
>
> > This is not wise in term of security.
>
> This depends on the use case and the requirements. If there was a way
> to have the user enter their PIN before logging into Windows, I would
> gladly use that.
> Furthermore, the method I described is still more secure than any
> solution based on certificates and keys which are stored on the hard
> drive. With a token, the cert/key exist exactly _once_. Both a
> keylogger and a trojan would be useless against my setup. The _only_
> attack vector involves physical access to the token. If someone steals
> the token, the end user will not be able to log in and complain to IT.
> Thus, any stolen certificate can be disabled within days, if not
> hours.
> In the classic case, there is no way to be certain if your locally
> stored certificate and key along with the passphrases are in the hands
> of others.
>
> > So I am sorry, but I don't think this should be supported.
>
> If you look at --askpass via file, you can see how this problem can be
> solved: Offer it to people who pass the test of being able to compile
> OpenVPN. They either know what they do or they really do not deserve
> otherwise.
>
>
> > Especially when you can achieve the same via the management interface.
>
> If by management interface you mean the netcat hack I am using, this
> does not work as desired, yet. While I can flawlessly start my batch
> files on a running Windows system and connect automagically, every
> attempt to make this work as a Windows system service failed with a
> timeout on the server's side. I can only presume that the netcat trick
> is not working, for some reason.
>
>
> If you can give me any insights on how to avoid that (or how to pass
> the PIN as a remote connection password, as I am thinking about
> replacing the system service with a remote connection, which plays
> nicely with Windows' GINA), I would be honestly thankful to hear about
> this, though.
>
>
> Best regards,
> Richard
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

