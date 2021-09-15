References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
 <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
 <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <898155c6-85f3-c9ce-145d-30673825e3f7@...1227...>
Date: Wed, 15 Sep 2021 17:02:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
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

Am 15.09.21 um 16:36 schrieb Selva Nair:
> Hi,
>  
> 
>     Plaisthos is preparing patches that drop support for the APIs that are
>     deprecated in OpenSSL 3.0.
> 
>     Agreed that the OpenSSL 3.0 patches should be master only, so only 2.6
>     will have full OpenSSL 3.0 support with external key support and
>     without
>     compiler warnings. 
> 
>  
> Good to see some discussion on OpenSSL 3.0 support. I'm working on
> converting "cryptoapicert" to use a custom built-in provider. In fact,
> the provider framework could be common for all external keys
> (cryptoapicert, management-external-key and pkcs11) with only the key
> loading and signing ops redirected to respective backends. 

Depending on far you have come, you might be ahead of me. I didn't know
that you are already working on that.

> If Arne is adding a provider implementation for this, maybe I
> should hold off?

I am currently trying to get together a "small" provider by adapting
code from https://github.com/tpm2-software/tpm2-openssl. My provider
implmentation is already 600 lines of code since you need a lot of
boiler plate code. But the whole documentation of provider API is not as
great as it could be. You get documentation of all the function but you
to figure yourself how all that fits together.

I hope to have something ready at the end of the month.

Arne

