References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
 <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
 <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
 <898155c6-85f3-c9ce-145d-30673825e3f7@...1227...>
 <CAKuzo_gmS8j5KcxoRq8uR27Ocj4W4z0eKOLVUrF2WWQ8-+afgw@...278...>
 <58ade119-6398-0bac-990b-442d5819b1f9@...1227...>
 <CAKuzo_hEv7yOoLnpuxeQPTugV=NNNyBFCUKMdGe4D_H9MA9mew@...278...>
 <CAKuzo_hx1iiZx29Gzz3AG2ZA7vXwf13nMrGaQoo9FGt0roEejw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cb19a53b-a541-3bd0-8290-758355a4a02b@...1227...>
Date: Sat, 18 Sep 2021 21:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hx1iiZx29Gzz3AG2ZA7vXwf13nMrGaQoo9FGt0roEejw@...278...>
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


> https://github.com/selvanair/openvpn/tree/xkey-provider-v2
> <https://github.com/selvanair/openvpn/tree/xkey-provider-v2>
> 
> It should build on linux without errors, though with lots of deprecation
> warnings in old files. The executable will work and allow one to test
> key loading and some of other internals by running as tls-client with a
> normal key in a file -- not inlined key or external key. The key will
> get loaded into the provider and treated as opaque and still pass
> signature etc.. This is only for testing. See the last commit message
> for some details on this.

I won't have time on the weekend to look at it but I will definitively
take a look next week. But that sounds very promising.

> 
> Build with --enable debug. Note that the last commit made for testing
> will break signing with external keys until callbacks are connected plus
> some more.
> 
> I should have a more complete version ready to hook up with
> backend callbacks by the end of the weekend.
> 
> I skimmed through your branch. You need keymgmt_load to get the loading
> through store to work. As for other ops, implementing
> signature_sign_init and sign are not enough -- one needs digest_verify
> methods and digest_sign methods as well. This is because ssl-ctx has to
> be created in the context of our provider for sign to work, but then all
> public key ops also get delegated to us.  It took a while for me to sort
> that out.
> 
> Unfortunately this provider framework makes us write a metric ton of
> glue code code.

I noticed .....
> 
> Please feel free to nit-pick or otherwise-pick on the code.
> 

For the deprecation warnings. The commits are on my working branch as
well: https://github.com/schwabe/openvpn/commits/dco Cherry pick the
ones with [OSSL 3.0] tag in front of them. They are the commits that
remove the deprecations.

I currently don't have a dedicated branch for them, sorry.

Arne

