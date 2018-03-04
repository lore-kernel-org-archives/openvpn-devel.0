References: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
 <20180304161716.GN69387@...1296...> <87d10jkctn.fsf@...2274...>
 <CAKuzo_iMnsbUsu9N7LDX+h9AYNrtmAvr2dY7iumrP0bVcXguPA@...278...>
 <87inab32gb.fsf@...2274...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e2f02ee6-d1f8-4b5e-f0ed-eab2afa2647f@...1856...>
Date: Mon, 5 Mar 2018 00:03:46 +0100
MIME-Version: 1.0
In-Reply-To: <87inab32gb.fsf@...2274...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] LibreSSL support in OpenVPN 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


On 04-03-18 23:23, Jeremie Courreges-Anglas wrote:
> On Sun, Mar 04 2018, Selva Nair <selva.nair@...277...> wrote:
>> Libressl developers break API compatibility with openssl in such
>> perverse ways that there are no easy ways to support it. Take, for
>> example, the patch I just sent out which checks for certain functions
>> instead of disabling using LIBRESSL_VERSION_NUMBER. It finds two "set"
>> functions defined in libressl but two related "get" ones are not
>> found. So the compat layer will get used for those. But there is no
>> guarantee that such mixed usage leads to logically correct code. In
>> fact, the compat layer functions for min/max proto-version are not the
>> same as those in openssl 1.1. Those are a work around meant for
>> cleanly handling multiple versions of openssl without using ifdefs all
>> over the code. If libressl has implemented those set functions as in
>> openssl 1.1, then those get functions from compat layer would not be
>> what you should be using, but that's what you will get.
> 
> I'd like to add more details here.
> 
> At the time LibreSSL added the setters (May 2017)[1], OpenSSL itself
> only provided said setters (since 2015)[2].  The getters were added to
> OpenSSL later (Sep 2017)[3].
> 
> [1] https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/lib/libssl/ssl.h.diff?r1=1.127&r2=1.128
> [2] https://github.com/openssl/openssl/commit/7946ab33cecce60afcc00afc8fc18f31f9e66bff
> [3] https://github.com/openssl/openssl/commit/3edabd3ccb7aac89af5a63cfb2378e33a8be05d7
> 
> So I don't think the current situation can be summed up as a plain
> oversight or bad design choice.

Which is exactly why using OPENSSL_VERSION to determine the available
API would be so much cleaner.  No horribly slow configure checks and
easier to maintain code.

LibreSSL made the design choice to deviate from the OpenSSL API and put
lies into OPENSSL_VERSION, and then expects products that support
openssl to deal with the mess.  Yes, I think that's a bad design choice.
 But that's not the point - I guess every project makes bad choices
every now and then.  As soon as our official support warning is merged,
I'm fine with continuing the current practice of accepting patches to
keep LibreSSL working as long as they don't pollute the code.  If
LibreSSL is moving towards implementing the parts of the OpenSSL 1.1 API
we need, that hopefully will be just a few small patches.

If they then also set their OPENSSL_VERSION to match the API version
they are trying to support, I'd not have much left to complain about ;-)

-Steffan

