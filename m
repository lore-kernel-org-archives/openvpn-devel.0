MIME-Version: 1.0
In-Reply-To: <57209BDF.4030202@...1227...>
References: <1460918143-408-1-git-send-email-steffan@...1856...>
	<57209BDF.4030202@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 27 Apr 2016 21:55:39 +0200
Message-ID: <CAA1Abx+AOw9ekvzxzW4YkF6x-K2S2rZ_Ne_z_PLaGaJJBgAG0Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Migrate to mbed TLS 2.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, Apr 27, 2016 at 1:00 PM, Arne Schwabe <arne@...1227...> wrote:
> Am 17.04.16 um 21:35 schrieb Steffan Karger:
>>  #ifdef HAVE_AEAD_CIPHER_MODES
>
> Are there  actually mBedTLS >=2.0 without this?

It's possible to compile mbed TLS without GCM, yes.  Though I could
imagine getting rid of HAVE_AEAD_CIPHER_MODES, and just fail if GCM
support is missing.  If there are more in favour of that approach,
I'll either send a v2, or a follow-up patch.

> P.S.: This was probably one of the most boring reviews I did (for most
> part of the changes).

Hehe, yes, I can imagine.  Writing this patch wasn't exactly exciting
either ;)  Let's hope mbed TLS sticks to this naming scheme for a
while...

-Steffan

