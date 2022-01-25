Message-ID: <a6e91d1f-1bad-b96f-0f6e-5855601b4ba0@...2181...>
Date: Tue, 25 Jan 2022 21:34:12 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220121185752.14138-1-selva.nair@...277...>
 <61752087-04ba-c571-9ee6-b366adb54c68@...2181...>
 <52435b2a-a5b0-198f-284c-c229ceb1512e@...1227...>
 <8ee7b45d-9229-b107-0bfd-8b5b77e95537@...2181...>
 <CAKuzo_hoSDMFbs3eFgmM7W5dDXsvmLYeJQgn0tChk6ZkmfGA5w@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKuzo_hoSDMFbs3eFgmM7W5dDXsvmLYeJQgn0tChk6ZkmfGA5w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not error when md_kt_size() is
 called with mdname="none"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 25/01/2022 18:01, Selva Nair wrote:
> Hi,
> 
> On Tue, Jan 25, 2022 at 11:35 AM Antonio Quartulli <a@...2181... 
> <mailto:a@...2181...>> wrote:
> 
>     Hi,
> 
>     On 25/01/2022 17:30, Arne Schwabe wrote:
>      > Am 25.01.22 um 17:27 schrieb Antonio Quartulli:
>      >> Hi,
>      >>
>      >> On 21/01/2022 19:57, selva.nair@...277...
>     <mailto:selva.nair@...277...> wrote:
>      >>> diff --git a/src/openvpn/crypto_openssl.c
>     b/src/openvpn/crypto_openssl.c
>      >>> index 35fb0052..b93c680a 100644
>      >>> --- a/src/openvpn/crypto_openssl.c
>      >>> +++ b/src/openvpn/crypto_openssl.c
>      >>> @@ -1073,6 +1073,10 @@ md_kt_name(const char *mdname)
>      >>>   unsigned char
>      >>>   md_kt_size(const char *mdname)
>      >>>   {
>      >>> +    if (!strcmp("none", mdname))
>      >>
>      >> Since we have it implemented, can we use streq() here?
>      >>
>      >> Cheers,
>      >>
>      >
>      > streq is mainly used in option.c only, almost all other codes uses
>      > strcmp insteads, so not really that strong of an argument.
> 
>     I thought options.c was part of this project too :-D
>     To be honest, I think streq() is not really useful, but then we should
>     either use it consistently or just drop it.
> 
>     I am in favour of dropping it because including options.h in other .c
>     files can be quite a nightmare and you don't want that just to use
>     streq().
> 
>     So I guess we can live with this patch, but should we put on the agenda
>     wiping streq() for good?
> 
> 
> "live with" ? When did strcmp() become a pariah?

Sorry, I didn't mean to have an offensive behaviour. Maybe I chose the 
wrong language.

What I meant was: since we already have a mix of strcmp and streq in the 
code and since Arne sounded reluctant to suggest changing this patch, I 
basically wanted to agree with keeping this patch as is. (read "live 
with" as "accept" or "ack").

> 
> Though strcmp()'s naming and return value are arguably not intuitive, we 
> are all used to it. That said, we have 472 uses of streq(), so let it 
> be. Just do not require that one should be preferred over the other.
> 

I am all in favour of simply using strcmp. It's just that our code is a 
partial mix up and that is not nice (imho). This is why I suggested that 
we should put on the agenda wiping streq entirely and be done with it.

> Consistency is a good goal, but let's not be pedantic about it.

True, but, if not pursued, consistency easily become inconsistency and 
at some point we are forced to clean things up.

Now, the streq/strcmp dilemma is just a marginal thing compared to other 
inconsistencies we have and I did not want to make a big deal about it.
Sorry if it sounded so.


Cheers,


-- 
Antonio Quartulli

