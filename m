Message-ID: <436739A2.7020702@...486...>
From: Albert Siersema <appie@...486...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] pkcs11-protected-authentication not working in
 2.1beta4 ?
References: <43662220.3000807@...486...> <43665747.5000502@...277...>
In-Reply-To: <43665747.5000502@...277...>
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
Date: Tue Nov  1 01:47:58 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Hello Alon,

>> Using (--)askpass works fine too when connecting with openvpn but
> Does it also popup PIN dialog?
No, it reads from stdin which makes it impossible to run openvpn as a
MSWindows service.
I was hoping the pkcs11 code would be helpful in that department as using
the cryptoapi and running as a service won't work. Probably because the
service runs as System and tries to retrieve it from the wrong cert store.
Running the service as another user won't help either ?! :-(

Anyone who has an idea how to tackle this ?
Basically I want to store the certificate on a smartcard and be able to
run openvpn as a service (e.g. start/stopping it through net start/stop
openvpnservice).

> PKCS#11 protected authentication is not implemented by most of PKCS#11
> providers, it is used in biometric environment or when external keypad
> is available. Are you sure your provider support protected authentication?
I haven't got a clue as of yet. I'm not really a Windows user myself so it
took me quite a while to figure out what to supply as a provider. In the end
I looked in the firefox preferences :) but there's probably a win32 CLI tool
somewhere that can list the various pkcs11 resources and info.

Cheers,
Albert
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDZzmiKltZixSsH2QRAz6IAJ41gKLFO0K7YQTK3VyZLWBXxleHfgCeP/eS
BPzRYQr2muYQnZQjE7FwBTo=
=B992
-----END PGP SIGNATURE-----

