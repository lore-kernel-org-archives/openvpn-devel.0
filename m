Message-ID: <9e0cf0bf0706080654o477baec5m6593996efadd7c37@...278...>
Date: Fri, 8 Jun 2007 16:54:09 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <3bca39c60706080647y13802064m35827220ba1b2ab6@...278...>
MIME-Version: 1.0
References: <3bca39c60706080647y13802064m35827220ba1b2ab6@...278...>
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

As you figured it out... This is not wise in term of security.
So I am sorry, but I don't think this should be supported.
Especially when you can achieve the same via the management interface.

Best Regards,
Alon Bar-Lev.

On 6/8/07, Richard Hartmann <richih.nospam@...1030...> wrote:
> Hi all,
>
>
> I am setting up a test case where the user is supposed to plug in his
> USB token before booting. Once he boots up and prior to him logging in
> to Windows, I need to establish an OpenVPN connection to our
> aggregator.
>
> To do this, I am using a 'solution' where I abuse a netcat connection
> to cat the PIN to the token into OpenVPN. My request would be to do
> one or more of the following:
>
>
> 1) Make OpenVPN aware that it could use the passphrase received via
> --askpass not only as private key _passphrase_, but as private key
> _PIN_. (One could argue that this is a bug)
>
> 2) Offer --askpin [file], same as --askpass
>
> 3) Offer not only pkcs11-pin-cache, but also pkcs11-pin-value or similar
>
>
> I am fully aware that this is a potential security risk and thus I
> would suggest using the same approach as with using --askpass via
> file: Make it a compile time option. In 99% of the cases, you do _not_
> want the user to be able to do it this way. But when someone really
> knows what he does, why he does and is aware of the implications,
> there should be a way to make this work without pain.
>
> FYI, I am using 2.1 RC 4. If this issue has been addressed in head,
> please let me know. Also, if this is the wrong place for this, please
> tell me where to direct feature requests, I could not find any other
> place.
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

