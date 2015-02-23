Message-ID: <54EB243C.1000706@...1227...>
Date: Mon, 23 Feb 2015 13:59:40 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>	
	<20150215220144.GP8134@...1296...>
	<20150223080402.GA5068@...2009...>	 <54EAE4AF.8010009@...1227...>
	<1424696107.5437.209.camel@...1866...>
In-Reply-To: <1424696107.5437.209.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net


Am 23.02.15 um 13:55 schrieb David Woodhouse:
> On Mon, 2015-02-23 at 09:28 +0100, Arne Schwabe wrote:
>> Am 23.02.15 um 09:04 schrieb Vasily Kulikov:
>>>     management-external-cert 'macosx-keychain:SUBJECT:c=US'
>>>
>>> With the approach in patch v3 a user has to start openvpn with the
>>> config file, start keychain-mcd, and pass identity template as an
>>> argument to keychain-mcd.
>>>
>>> What do you think of the change?
>> I like the idea. You could  make the macos-keychain in the string optional.
> I wouldn't make it optional. Keep it URI-like, with 'macos-keychain' as
> the URI scheme.
>
> We'll also want to support pkcs11: and file: URIs. In both cases we will
> have the same issue, with objects accessible only by a user *other* than
> the user that OpenVPN runs as.
>
> GnuTLS HEAD also has support for CNG under Windows, and a system:id=XXX
> URI format to specify keys therein. We might even want to support an
> agent using that too.
>
> If any URI scheme is going to be the default, and specifying it is going
> to be optional. I'd probably suggest that it be the file: scheme. But
> better still, just don't have a default. Certainly not macos-keychain :)
>
> It might also be worth looking to see if the URI format we're using for
> the macos-keychain: URIs could be made more similar to the PKCS#11 URI
> standard.
>
All fine. My rationale was like, if I want a certificate with a certain
SUBJECT (e.g. CN=schwabe@...2017...) etc. it should not matter for men
wether I get it from OS X, Windows or Android Certificate store.

Arne

