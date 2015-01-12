Message-ID: <54B3C409.9080709@...1227...>
Date: Mon, 12 Jan 2015 13:54:33 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20150112085121.GA25193@...2009...>
	<1421063126.9231.7.camel@...1866...>
In-Reply-To: <1421063126.9231.7.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCHv2] Mac OS X Keychain management client
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
To: David Woodhouse <dwmw2@...1866...>, Vasily Kulikov <segoon@...2008...>
Cc: dcbw@...1347..., openvpn-devel@lists.sourceforge.net


Am 12.01.15 12:45, schrieb David Woodhouse:
> On Mon, 2015-01-12 at 11:51 +0300, Vasily Kulikov wrote:
>> This patch adds support for using certificates stored in the Mac OSX
>> Keychain to authenticate with the OpenVPN server.  This works with
>> certificates stored on the computer as well as certificates on hardware
>> tokens that support Apple's tokend interface.  The patch is based on
>> the Windows Crypto API certificate functionality that currently exists
>> in OpenVPN.

I wonder why only certifcates and not ca certifcates. It would be
logical to get all certifcates from the keychain.
>>
>> This patch version implements management client which handles rsa_sign
>> command for RSA offloading. 
> FWIW we really ought to be supporting key types other than RSA by now.
> But I appreciate that's not a new limitation and not your fault.

Well although rsa-sign at the momemnt probably only supports RSA (it is
implemented using rsa_method iirc) the  API is not rsa specific. It is
just: "Please sign this hash with the private key". In the case of an
RSA certificate this happens to be RSA encrypt in ECB mode with PKCS#1
padding.

I am not sure if there is an equivalent of rsa_method for EC in OpenSSL
or if you have to use the engine functionality of OpenSSL for EC.
> It would be interesting to get feedback from those working on
> NetworkManager-openvpn, which may well want to use this API to allow key
> operations to happen in the user's session while OpenVPN is running as
> root.


