MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
 <20181031165222.5997-1-arne@...1227...>
 <CAA1Abx+ghos2h8qatMhon+ojAUX18MKTbz+W_3T4TfVOGXLTww@...278...>
 <5b5ee028-92f9-3f0a-f50d-95d6280b8792@...1227...>
 <E1gUp29-00014b-NB@...2479...>
In-Reply-To: <E1gUp29-00014b-NB@...2479...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 6 Dec 2018 10:38:59 -0500
Message-ID: <CAKuzo_jqGwNFQp6UhjyLg4BvLyA5XmXyx0p+1FviPZX+Y5nvHg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Make tls_version_max return the
 actual maximum version
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Dec 6, 2018 at 3:29 AM Steffan Karger <steffan.karger@...1435...> wrote:
>
> On 05-12-18 15:09, Arne Schwabe wrote:
> > Am 05.12.18 um 11:51 schrieb Steffan Karger:
> >> On Wed, 31 Oct 2018 at 17:53, Arne Schwabe <arne@...1227...> wrote:
> >>> Before OpenSSL 1.1.1 there could be no mismatch between
> >>> compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need
> >>> runtime detection to detect the actual best TLS version supported.
> >>>
> >>> Allowing this runtime detection also allows removing some of the
> >>> TLS 1.3/OpenSSL 1.1.1 #ifdefs
> >>>
> >>> Without this patch tls-min-version 1.3 or-highest will actually
> >>> downgrade to TLS 1.3 in the "compiled with 1.1.0 and linked against
> >>> 1.1.1" scenario.
> >>
> >> "Downgrade to TLS 1.2", I guess?
> >>
> >> But more fundamental: do want to support runtime-upgrading the TLS
> >> library? Are we sure that this is the only place where this will
> >> create unexpected behaviour? Does it even make sense to upgrade a
> >> dependency to a version that contains all sorts of API/ABI changes and
> >> then expect that you do not have to recompile? Honest questions; I
> >> don't understand why one would want or do this.
> >
> > I think on some installation, especially when the user compiled OpenVPN
> > him/herself, we just need to live with the fact that the OpenSSL library
> > got upgraded from OpenSSL 1.1.0 to OpenSSL 1.1.1.
> >
> > But one art of decting the newer library here is that we can bail out on
> > some of the corner cases instead of continuing, like refusing external
> > auth if the OpenSSL libary is too new.
> >
> > I still think is an unsupported scenario and we might add an warning
> > message aka like
> >
> > "Detected OpenSSL 1.1.1 but compiled against OpenSSL 1.1.0, recompile to
> > use all OpenSSL 1.1.1 features"
>
> Do you mean "add a warning message *in addition to* the patch
> workarounds", or "add a warning message "instead of* the patch workarounds"?
>
> I'm definitely in favour of adding the warning, but would need to think
> a bit more about whether adding the workarounds will give net-positive
> results.

I was of the view that we should support upgrade to OpenSSL 1.1.1
without recompiling, but on closer encounters with 1.1.1, I have a
change of mind.

In our case, the only real problem is: if OpenSSL 1.1.1 is in use at
run time, external certificate support is broken and needs fixing. But
does that need this patch? Two cases to consider:

(i) compiled against 1.1.0 but the dynamic linker loads 1.1.1
(ii) compiled and run against 1.1.1

For fixing "management-external-cert", case (i) may need this but case
(ii) doesn't. That said, the ABI compat between 1.1.0 and 1.1.1 that
OpenSSL claims has caveats, so we need not promote use case (i). Just
warn this may not work and let things fail if and when it fails.

Even in case of (ii) my view is that we should just let external
signing fail if the management client is not capable of handling the
signature request (cases where the data is either prepadded or
requires PSS padding). Such an approach still requires some changes to
the code to support non PKCS1 padding but that's the topic of a
different set of patches.

Selva

Selva

