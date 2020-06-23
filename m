Message-ID: <1592936237.4768.43.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Tue, 23 Jun 2020 11:17:17 -0700
In-Reply-To: <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
 <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
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
To: =?UTF-8?Q?=D0=98=D0=BB=D1=8C=D1=8F_=D0=A8=D0=B8=D0=BF=D0=B8=D1=86?= =?UTF-8?Q?=D0=B8=D0=BD?= <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, 2020-06-23 at 21:43 +0500, Илья Шипицин wrote:
> as far as I understand, openssl-1.0.2 does not support engines ?

No, it does.  Engines were a pre 0.9.8 thing.  I support openssl in my
builds for the TPM engine down to 1.0.1

However, the failure:

> Key mismatch not detected
> 
> FAIL: check_engine_keys.sh
> 
> ====================================================
> 
> 1 of 1 test failed
> 
> Please report to openvpn-users@lists.sourceforge.net
> 
> ====================================================

Is because an expected message isn't found in the output.  I think it's
this:

   # first off check we died because of a key mismatch.  If this doesn't
   # pass, suspect openssl of returning different messages and update the
   # test accordingly
   grep -q 'X509_check_private_key:key values mismatch' log.txt || { echo "Key mismatch not detected"; exit 1; }

   If I could get hold of log.txt that would confirm that the test is
   outputting something slightly different from what's expected.

   I did run this test on openssl-1.0.2j (I keep a copy of
   openSUSE_Leap_42.3 around precisely for this openssl testing) but it
   ran just fine. so there's clearly something different about the 1.0.2u
   you're using (might be a locale issue?).

   James


