MIME-Version: 1.0
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
 <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
 <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
 <898155c6-85f3-c9ce-145d-30673825e3f7@...1227...>
 <CAKuzo_gmS8j5KcxoRq8uR27Ocj4W4z0eKOLVUrF2WWQ8-+afgw@...278...>
 <58ade119-6398-0bac-990b-442d5819b1f9@...1227...>
 <CAKuzo_hEv7yOoLnpuxeQPTugV=NNNyBFCUKMdGe4D_H9MA9mew@...278...>
 <CAKuzo_hx1iiZx29Gzz3AG2ZA7vXwf13nMrGaQoo9FGt0roEejw@...278...>
 <cb19a53b-a541-3bd0-8290-758355a4a02b@...1227...>
In-Reply-To: <cb19a53b-a541-3bd0-8290-758355a4a02b@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 22 Sep 2021 11:40:00 -0400
Message-ID: <CAKuzo_i0FXxX6EUPbSyrA+Z+iePco1Gag04SovCwe8v50hkNbg@...278...>
Content-Type: multipart/alternative; boundary="00000000000000be2005cc975fe2"
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--00000000000000be2005cc975fe2
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 18, 2021 at 3:22 PM Arne Schwabe <arne@...1227...> wrote:

>
> > https://github.com/selvanair/openvpn/tree/xkey-provider-v2
> > <https://github.com/selvanair/openvpn/tree/xkey-provider-v2>
> >
> > It should build on linux without errors, though with lots of deprecation
> > warnings in old files. The executable will work and allow one to test
> > key loading and some of other internals by running as tls-client with a
> > normal key in a file -- not inlined key or external key. The key will
> > get loaded into the provider and treated as opaque and still pass
> > signature etc.. This is only for testing. See the last commit message
> > for some details on this.
>
> I won't have time on the weekend to look at it but I will definitively
> take a look next week. But that sounds very promising.
>
> >
> > Build with --enable debug. Note that the last commit made for testing
> > will break signing with external keys until callbacks are connected plus
> > some more.
> >
> > I should have a more complete version ready to hook up with
> > backend callbacks by the end of the weekend.
> >
> > I skimmed through your branch. You need keymgmt_load to get the loading
> > through store to work. As for other ops, implementing
> > signature_sign_init and sign are not enough -- one needs digest_verify
> > methods and digest_sign methods as well. This is because ssl-ctx has to
> > be created in the context of our provider for sign to work, but then all
> > public key ops also get delegated to us.  It took a while for me to sort
> > that out.
> >
> > Unfortunately this provider framework makes us write a metric ton of
> > glue code code.
>
> I noticed .....
> >
> > Please feel free to nit-pick or otherwise-pick on the code.
> >
>
>
Updated & improved version with commits broken into smaller chunks is here

https://github.com/selvanair/openvpn/pull/new/xkey-provider-v3

I'm ready to submit the patches to the list for review. As I touch only one
or two contexts in the core I haven't rebased to your OpenSSL 3.0
deprecation patches. Any minor conflicts should be easy to fix.

Thanks,

Selva

--00000000000000be2005cc975fe2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 18, 2021=
 at 3:22 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...2068...=
7...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
&gt; <a href=3D"https://github.com/selvanair/openvpn/tree/xkey-provider-v2"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/selvanair/openvpn/=
tree/xkey-provider-v2</a><br>
&gt; &lt;<a href=3D"https://github.com/selvanair/openvpn/tree/xkey-provider=
-v2" rel=3D"noreferrer" target=3D"_blank">https://github.com/selvanair/open=
vpn/tree/xkey-provider-v2</a>&gt;<br>
&gt; <br>
&gt; It should=C2=A0build on linux without errors, though with lots of depr=
ecation<br>
&gt; warnings in old files. The executable will work and allow one to test<=
br>
&gt; key loading and some of other internals by running as tls-client with =
a<br>
&gt; normal key in a file -- not inlined key or external key. The key will<=
br>
&gt; get loaded into the provider and treated as opaque and still pass<br>
&gt; signature etc.. This is only for testing. See the last commit message<=
br>
&gt; for some details on this.<br>
<br>
I won&#39;t have time on the weekend to look at it but I will definitively<=
br>
take a look next week. But that sounds very promising.<br>
<br>
&gt; <br>
&gt; Build with --enable debug. Note that the last commit made for testing<=
br>
&gt; will break signing=C2=A0with external keys until callbacks are connect=
ed plus<br>
&gt; some more.<br>
&gt; <br>
&gt; I should have a more complete version ready to hook up with<br>
&gt; backend=C2=A0callbacks by the end of the weekend.<br>
&gt; <br>
&gt; I skimmed through your branch. You need keymgmt_load to get the loadin=
g<br>
&gt; through store to work. As for other=C2=A0ops, implementing<br>
&gt; signature_sign_init and sign are not enough -- one needs digest_verify=
<br>
&gt; methods and digest_sign methods as well. This is because=C2=A0ssl-ctx =
has to<br>
&gt; be created in the context of our provider for sign to work, but then a=
ll<br>
&gt; public key ops also get delegated to us.=C2=A0 It took a while for me =
to sort<br>
&gt; that out.<br>
&gt; <br>
&gt; Unfortunately this provider framework makes us write a metric ton of<b=
r>
&gt; glue code code.<br>
<br>
I noticed .....<br>
&gt; <br>
&gt; Please feel free to nit-pick or otherwise-pick on the code.<br>
&gt; <br>
<br></blockquote><div><br></div><div>Updated &amp; improved version with co=
mmits broken into smaller chunks is here</div><div><br></div><div><a href=
=3D"https://github.com/selvanair/openvpn/pull/new/xkey-provider-v3">https:/=
/github.com/selvanair/openvpn/pull/new/xkey-provider-v3</a></div><div>=C2=
=A0</div><div>I&#39;m ready to submit the patches to the list for review. A=
s I touch only one or two contexts in the core I haven&#39;t rebased to you=
r OpenSSL 3.0 deprecation patches. Any minor conflicts should be easy to fi=
x.<br></div><div><br></div><div>Thanks,</div><div><br></div><div>Selva</div=
></div></div></div>

--00000000000000be2005cc975fe2--

