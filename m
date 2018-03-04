References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...> <8760a6kjwc.fsf@...2274...>
 <87vai5kj4z.fsf@...2274...>
 <551aeb2a-1ea1-9c3b-06dd-ead9fc809340@...1856...>
 <87muzn650h.fsf@...2274...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c94fa7e7-204d-b27c-251a-46cfcfc24e45@...1856...>
Date: Mon, 5 Mar 2018 00:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <87muzn650h.fsf@...2274...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile
 option for mbedtls builds
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

Hi,

On 04-03-18 19:59, Jeremie Courreges-Anglas wrote:
> On Thu, Dec 14 2017, Steffan Karger <steffan@...1856...> wrote:
> 
> [...]
> 
>> NAK.
>>
>> Looking at this patch again I realize I have misunderstood the
>> intentions when first looking at it.  I thought LibreSSL *did* have an
>> SSL_CTX_get0_certificate() and this patch would make us use it (instead
>> of the workaround in the #else).  But this is just about replacing the
>> version check with a configure check.
> 
> Are you still opposed to such a diff (updated version attached), now
> that LibreSSL HEAD provides SSL_CTX_get0_certificate?

Yes, I'd rather not use the workaround if not needed.  Still not very
happy about the approach though.  Why not simply add || LIBRESSL_VERSION
> x.y.z ?

>> I oppose that change because it
>> hides information I want to have:  "what code can be purged when we drop
>> support for openssl 1.0 and libressl?".
> 
> Maybe there's another way to encode that information?  Like,
> consistently formatted comments describing the first OpenSSL (and
> LibreSSL) releases that provided a function?

Yes, we could do that.  But if we're going to put that info into the
code anyway, why not just use the define?

-Steffan

