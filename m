MIME-Version: 1.0
In-Reply-To: <87d10jkctn.fsf@...2274...>
References: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
 <20180304161716.GN69387@...1296...> <87d10jkctn.fsf@...2274...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 4 Mar 2018 13:55:49 -0500
Message-ID: <CAKuzo_iMnsbUsu9N7LDX+h9AYNrtmAvr2dY7iumrP0bVcXguPA@...278...>
Subject: Re: [Openvpn-devel] LibreSSL support in OpenVPN 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Mina Barret <mina.barret@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Mar 4, 2018 at 11:47 AM, Jeremie Courreges-Anglas
<jca@...2272...> wrote:
> On Sun, Mar 04 2018, Gert Doering <gert@...1296...> wrote:
>
> [...]
>
>> "Please note that LibreSSL is not a supported crypto backend. We
>>  accept patches and we do test on OpenBSD 6.0 which comes with
>>  LibreSSL, but if newer versions of LibreSSL break API compatibility
>>  we do not take responsibility to fix that."
>>
>>
>> I think a patch adding these LIBRESSL_VERSION checks has a reasonable
>> chance of being ACKed and merged :-) - but LibreSSL support stuff has
>> to come from some who cares, so Steffan or Antonio are not going to
>> go out and check patches for "will it break LibreSSL?"...
>
> I don't think adding "&& !defined(LIBRESSL_VERSION_NUMBER)" in more
> places would be a good idea.  Those checks would do more harm than good
> in the long run, preventing the use of new interfaces when they get
> implemented by LibreSSL.  Better use function availability checks IMHO.

Libressl developers break API compatibility with openssl in such
perverse ways that there are no easy ways to support it. Take, for
example, the patch I just sent out which checks for certain functions
instead of disabling using LIBRESSL_VERSION_NUMBER. It finds two "set"
functions defined in libressl but two related "get" ones are not
found. So the compat layer will get used for those. But there is no
guarantee that such mixed usage leads to logically correct code. In
fact, the compat layer functions for min/max proto-version are not the
same as those in openssl 1.1. Those are a work around meant for
cleanly handling multiple versions of openssl without using ifdefs all
over the code. If libressl has implemented those set functions as in
openssl 1.1, then those get functions from compat layer would not be
what you should be using, but that's what you will get.

So IMO, it may be more worthwhile for those invested in libressl to
convince the developers to make more sane decisions. Either they want
libressl to be a better openssl or a different crypto library. They
can't behave as neither and both at the same time and expect
users/developers to work around their personal opinions of what
openssl should be.

Selva

