References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
 <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
 <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
 <898155c6-85f3-c9ce-145d-30673825e3f7@...1227...>
 <CAKuzo_gmS8j5KcxoRq8uR27Ocj4W4z0eKOLVUrF2WWQ8-+afgw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <58ade119-6398-0bac-990b-442d5819b1f9@...1227...>
Date: Sat, 18 Sep 2021 01:33:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gmS8j5KcxoRq8uR27Ocj4W4z0eKOLVUrF2WWQ8-+afgw@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Summary of the community meeting (15th
 September 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>     > If Arne is adding a provider implementation for this, maybe I
>     > should hold off?
> 
>     I am currently trying to get together a "small" provider by adapting
>     code from https://github.com/tpm2-software/tpm2-openssl
>     <https://github.com/tpm2-software/tpm2-openssl>. My provider
>     implmentation is already 600 lines of code since you need a lot of
>     boiler plate code. But the whole documentation of provider API is not as
>     great as it could be. You get documentation of all the function but you
>     to figure yourself how all that fits together.
> 
> 
> OpenSSL has always been like that isn't it -- one could never
> write anything based on docs alone.  I have seen the tpm2 code. That,
> along with the built-in provider implementations in OpenSSL, seems to
> fill some of the gaps in documentation. There were also some discussions
> and questions in OpenSSL repo (issues) when the tpm2 guys were
> developing it. But I haven't seen any code that deals with non-default
> providers in the SSL context, especially when one wants to mix providers
> (default for most things + custom for keymgmt & signature only).
> 
>     I hope to have something ready at the end of the month.
> 
> 
> For a working patch I'll also take a similar amount of time. Depending
> on how it goes,  I'll wait, or post my feature branch for discussion.
> I'm totally open, and we do not have to go with my approach even if I
> come up with something. In any case, some discussion may be
> useful/required to make the basic framework re-usable for all "external
> key" situations.
> 
If you want to have a look at my effort. I push my WIP here:
https://github.com/schwabe/openvpn/commits/dco

but currently it is really only mostly boilerplate stuff to figure out
what OpenSSL really wants from me and what I need to do make it happy.
Currently it calls some methods but none of which returns an error or I
am missing something. I will probably need to deep dive in OpenSSL's own
source code and figure out what is happening but that will probably have
to wait till next week:

PROVIDER INIT
provider init
extpki_get_reason_strings
query operation: 22
extpki_unquery_operation
extpki_object_open: STORE/OBJECT OPEN
STORE/OBJECT SET_PARAMS, expected type: private key (4)
STORE/OBJECT EOF
STORE/OBJECT CLOSE

Could not read key from extpki:1234
extpki_teardown


Arne

