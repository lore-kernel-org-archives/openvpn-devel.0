Message-ID: <b1504d9e-32af-28d5-7279-43034a2f3129@...1227...>
Date: Wed, 8 Feb 2023 12:16:50 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230204004512.250271-2-selva.nair@...277...>
 <20230204064010.257925-1-selva.nair@...277...>
 <20230204064010.257925-2-selva.nair@...277...>
 <74a4194f-2d86-2bce-195b-0cae9f294597@...1227...>
 <CAKuzo_g3LBd0Ss7DN7MT-D8040FvRUs__093RXG7sWAJAhOxaw@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_g3LBd0Ss7DN7MT-D8040FvRUs__093RXG7sWAJAhOxaw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Add a unit test for functions in
 cryptoapi.c
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
Cc: openvpn-devel@lists.sourceforge.net

Am 08.02.23 um 02:05 schrieb Selva Nair:
> Hi,
> 
> On Tue, Feb 7, 2023 at 7:18 PM Arne Schwabe <arne@...1227... 
> <mailto:arne@...1227...>> wrote:
> 
>     Am 04.02.23 um 07:40 schrieb selva.nair@...277...
>     <mailto:selva.nair@...277...>:
>      > From: Selva Nair <selva.nair@...277... <mailto:selva.nair@...277...>>
>      >
>      > - Though named cryptoapi_testdriver, right now this only tests
>      >    parsing of thumbprint specified as a selector for --cryptioapicert
>      >    option. More tests coming..
>      >
>      > v2: a line that belongs here was mistakenly included in the previous
>      > commit. Corrected.
>      >
>      > Signed-off-by: Selva Nair <selva.nair@...277...
>     <mailto:selva.nair@...277...>>
> 
>     While a good step, this still has problems. With OpenSSL 1.1.1 it still
>     tries to run the check-engine.sh script and unsurprisingly fails:
> 
>     ---- begin log.txt ----
>     ./check_engine_keys.sh: 25: ../../../src/openvpn/openvpn: not found
>     --- end log.txt ---
>     Key mismatch not detected
>     FAIL: check_engine_keys.sh
> 
>     This can be fixed by:
> 
>     --- a/tests/unit_tests/engine-key/Makefile.am
>     +++ b/tests/unit_tests/engine-key/Makefile.am
>     @@ -12,7 +12,9 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
>               top_srcdir="$(top_srcdir)"; \
>               export srcdir builddir top_builddir top_srcdir;
> 
>     +if !CROSS_COMPILING
>        TESTS = check_engine_keys.sh
>     +endif
>        check_engine_keys.sh: $(conffiles)
> 
>        CLEANFILES = \
> 
> 
> Thanks for this. I added this to 2/3 where it belongs and submitted it 
> as v3 2/3. With that, this patch should be okay as is.
> 
> For those not following closely, this patch  should be applied after the 
> cryptoapi patch set where the function being tested here is introduced.
> 
> Selva

No, I think this that is independent. This is about the engine keys 
support added by James Bottomley.  I needed and tested this patch 
without the cryptoapi patch.

Arne

