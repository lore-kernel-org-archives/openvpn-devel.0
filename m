Message-ID: <4368D5B8.9040204@...486...>
From: Albert Siersema <appie@...486...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] pkcs11-protected-authentication not working in
 2.1beta4 ?
References: <43662220.3000807@...486...> <43665747.5000502@...277...> <436739A2.7020702@...486...> <4367A449.8000105@...277...>
In-Reply-To: <4367A449.8000105@...277...>
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
Date: Wed Nov  2 07:07:06 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

> Strange... I don't understand what is the difference between the
> --show-pkcs11-* and the --askpass...
> Just to make sure... --show-pkcs11-slots prompt for PIN???
Yes it pops up the PIN dialog window (GUI) from the safesign middleware so
to speak.
askpass shows a prompt on stdout and reads from stdin.

> But it does!
> Use the management interface.
> Put the following in your configuration file:
> 
> management hold
> management 127.0.0.1 8887
> management-query-passwords

Yes, just what I thought :) After browsing through the beta4 source and
manual pages 'n all I saw this one as well. It has potential but for it to
be useful to a mere user (i.e. less computer literate people) a kind of GUI
wrapper has to be written. I was thinking about this along the lines of
combining it with something like:
inactive 1800
ping 10
ping-exit 60
explicit-exit-notify
tls-exit
Then writing a script or such that starts the openvpn service, connects to
the management interface, pops up a GUI dialog to ask the user for the PIN,
then sending it through the management interface.
Should be feasable. Thing is, i'm not a Windows programming-person but maybe
I can think up something simpler.

> Now start your service.
> Insert your smartcard.
> Run "telnet localhost 8887"
> 
> Enter the following commands:
> hold release
> password "XXXX token" pin

> I will write a simple perl script that does it for you soon...
If I come up with a non-perl but GUI-y like solution i'll post it to the
list as well.

Albert
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDaNW4KltZixSsH2QRA+8PAKCN1F7QLHXThxvbpBe4f5MNZlYTawCgi8/y
vvbSeYvC7AbnwofDnDtNNqQ=
=6Lvn
-----END PGP SIGNATURE-----

