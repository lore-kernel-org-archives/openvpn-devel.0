Message-ID: <43CBB8F4.8060800@...486...>
From: Albert Siersema <appie@...486...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Re: OpenVPN and eToken (on windows).
References: <605203017.20060102170037@...450...> <43B9409E.4090903@...277...>	 <181840658.20060110042715@...450...> <43C37B3E.1090204@...277...>	 <758887784.20060110165806@...450...> <43C3C0FE.40009@...277...>	 <1056907489.20060110185322@...450...> <43C40194.807@...277...>	 <43C5211A.8010709@...486...> <9e0cf0bf0601110723l2ea296bv2a92580894ab5de5@...278...>
In-Reply-To: <9e0cf0bf0601110723l2ea296bv2a92580894ab5de5@...278...>
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
Date: Mon Jan 16 07:18:12 2006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: mts.spb.suxx@...450..., openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

>>>They can simply replace it with a different CA certificate, so that you
>>>authenticate to a server that claims to be your server but actually is a
>>>different server that have the same certificate name as your server but
>>>was issued by the CA that replaced your CA on the token.
>>
>>But doesn't storing the CA cert on the local hard drive expose you the
>>very same problem ? And the hard drive is always accessable, there's no
>>authentication to access it once you're running from it.
>>(or am i missing the point here ?)
> 
> 
> Let's say that you don't run as root or Administrator, openvpn daemon
> or service is using configuration file you cannot modify, this
> configuration file refers to a CA certificate that you cannot modify
> either. The result is that you can access only servers that suits
> system administrator policy, you cannot bridge your network to foreign
> site.
> 
> Modify this configuration requires something you don't have
> (Administrative permission), altering the token requires something you
> have (PIN).
> 
> Moreover, modifying the token exposes you where-ever you go, breaking
> into a specific machine exposes you only in this machine.

Correct, not to nitpick, but rather to be complete about the requirements:
that does mean you'd need openvpn 2.1 (especially for MSWindows) and it's
management interface. Otherwise running openvpn as a service under lower
privileges won't work. And moreover: setting the correct ACLs in the filesystem.
Which is not something a lot of MSWindows users (or admins for that matter)
seem to be doing.

This issue might be a good one for in the FAQ under the heading of
tightening security. If the 2.1 codebase goes stable/mainstream that is.

Albert
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDy7j0KltZixSsH2QRA4XQAJ9Gy0Ni/vcK1bpdbW0ZydF9J60RxwCfb+Nh
JpD6PjXoeZaddNLYHncv1kI=
=1kAt
-----END PGP SIGNATURE-----

