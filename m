MIME-Version: 1.0
In-Reply-To: <1424697012.5437.212.camel@...1866...>
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>
	<20150215220144.GP8134@...1296...> <20150223080402.GA5068@...2009...>
	<54EAE4AF.8010009@...1227...>
	<1424696107.5437.209.camel@...1866...>
	<54EB243C.1000706@...1227...>
	<1424697012.5437.212.camel@...1866...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 23 Feb 2015 08:58:48 -0500
Message-ID: <CAEsd45R_Z2-0kNtoiMHxS_q1z7Ghd8s46mXUSZvJt03-+1FEmw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Woodhouse <dwmw2@...1866...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, Feb 23, 2015 at 8:10 AM, David Woodhouse <dwmw2@...1866...> wrote:
> On Mon, 2015-02-23 at 13:59 +0100, Arne Schwabe wrote:
>>
>> All fine. My rationale was like, if I want a certificate with a certain
>> SUBJECT (e.g. CN=schwabe@...2017...) etc. it should not matter for men
>> wether I get it from OS X, Windows or Android Certificate store.
>
> The canonical way of representing that would be
>  pkcs11:object=schwabe@...2017...

That representation loses the "CN=" (and maybe doesn't allow for
additional search options -- I'm not sure).

OpenVPN already has an entire set of options that deal with PKCS-11.
This patch is a completely different, parallel way of dealing with
certificates, so I'm not sure why a "pkcs11:" scheme is needed. I
probably would not implement it in Tunnelblick myself.

There are two things here: (A) what this "select" string is and (B)
where/how to find the cert.

As to "what this 'select' string is" -- well, for "future-proofing", I
would want it to be labeled as a selection string in case we want to
pass something else at some time in the future.

Adding a scheme makes sense to me -- the "file:" scheme looks
interesting, but it isn't part of this patch. But I think the scheme
should be optional, so the configuration could include (the
platform-independent):

     --management-external-keychain select:CN=schwabe@...2017...

and have it use the Keychain on OS X, Android Certificate Store on
Android, something-I-don't-know on Windows, etc.

The tricky aspect of that is that the default would really depend on
the management interface software, which really means it depends on
the GUI. It is conceivable that two GUIs for the same platform could
have different defaults (although I assume both Tunnelblick and
Viscosity would use Keychain as the default, accessing it with
keychain-mcd).

