Sender: Vasiliy Kulikov <segooon@...277...>
Date: Tue, 13 Jan 2015 12:05:27 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150113090527.GA4452@...2009...>
References: <20150112085121.GA25193@...2009...>
	<1421063126.9231.7.camel@...1866...>
	<54B3C409.9080709@...1227...>
MIME-Version: 1.0
In-Reply-To: <54B3C409.9080709@...1227...>
Subject: Re: [Openvpn-devel] [PATCHv2] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: dcbw@...1347..., openvpn-devel@lists.sourceforge.net, David Woodhouse <dwmw2@...1866...>

On Mon, Jan 12, 2015 at 13:54 +0100, Arne Schwabe wrote:
> 
> Am 12.01.15 12:45, schrieb David Woodhouse:
> > On Mon, 2015-01-12 at 11:51 +0300, Vasily Kulikov wrote:
> >> This patch adds support for using certificates stored in the Mac OSX
> >> Keychain to authenticate with the OpenVPN server.  This works with
> >> certificates stored on the computer as well as certificates on hardware
> >> tokens that support Apple's tokend interface.  The patch is based on
> >> the Windows Crypto API certificate functionality that currently exists
> >> in OpenVPN.
> 
> I wonder why only certifcates and not ca certifcates. It would be
> logical to get all certifcates from the keychain.

A user tells keychain-mcd which keychain identity to use for openvpn.
The identity contains a certificate and a private key (might be
non-extractable).  CA is not related to this identity.  It can be added
to keychain-mcd and openvpn but a user should pass another certificate
match string for CA.

> >>
> >> This patch version implements management client which handles rsa_sign
> >> command for RSA offloading. 
> > FWIW we really ought to be supporting key types other than RSA by now.
> > But I appreciate that's not a new limitation and not your fault.
> 
> Well although rsa-sign at the momemnt probably only supports RSA (it is
> implemented using rsa_method iirc) the  API is not rsa specific. It is
> just: "Please sign this hash with the private key". In the case of an
> RSA certificate this happens to be RSA encrypt in ECB mode with PKCS#1
> padding.

Right.  And my patch is not specific to RSA too.  It uses generic Mac OS X
API which should work with any key type:

    SecIdentityCopyPrivateKey()
    SecKeyRawSign()

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

