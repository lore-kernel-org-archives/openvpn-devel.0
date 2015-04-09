Message-ID: <5526BCAF.2020807@...1227...>
Date: Thu, 09 Apr 2015 19:53:51 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20150225160718.GA6306@...2009...>
In-Reply-To: <20150225160718.GA6306@...2009...>
Subject: Re: [Openvpn-devel] [PATCH v4] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Vasily Kulikov <segoon@...2008...>, openvpn-devel@lists.sourceforge.net

Am 25.02.15 um 17:07 schrieb Vasily Kulikov:
> This patch adds support for using certificates stored in the Mac OSX
> Keychain to authenticate with the OpenVPN server.  This works with
> certificates stored on the computer as well as certificates on hardware
> tokens that support Apple's tokend interface.  The patch is based on
> the Windows Crypto API certificate functionality that currently exists
> in OpenVPN.
>
> This patch version implements management client which handles RSA-SIGN
> command for RSA offloading.  Also it handles new 'NEED-CERTIFICATE'
> request to pass a certificate from the keychain to OpenVPN.
>
> OpenVPN itself gets new 'NEED-CERTIFICATE" command which is called when
> --management-external-cert is used.  It is implemented as a multiline
> command very similar to an existing 'RSA-SIGN' command.
>
> The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.
>
> v4:
>  - added '--management-external-cert' argument
>  - keychain-mcd now parses NEED-CERTIFICATE argument if 'auto' is passed
>    as cmdline's identity template
>  - fixed typo in help output option name
>  - added '--management-external-cert' info in openvpn(8) manpage
>  - added 'certificate' command documentation into doc/management-notes.txt

Sorry taking soooo long. ACK to v4. (in the same way as v3, I reviewed
in the openvpn changes in detail and only briefly looked at the
keychain-mcd changes)

Are



