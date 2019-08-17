References: <20190816204945.7937-1-a@...2181...>
 <20190817064836.GS1349@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <38e3b7fc-d99c-354b-337e-0d9295b91a24@...1227...>
Date: Sat, 17 Aug 2019 19:56:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190817064836.GS1349@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: fix segfault by calling
 mbedtls_cipher_free() in cipher_ctx_free()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Am 17.08.2019 um 08:48 schrieb Gert Doering:
> Hi,
>
> On Fri, Aug 16, 2019 at 10:49:45PM +0200, Antonio Quartulli wrote:
>> Commit ("openssl: Fix compilation without deprecated OpenSSL 1.1 APIs")
>> has removed the cipher_ctx_cleanup() API, as it is not anymore required
>> to be a distinct call. However, while doing so it also touched the
>> mbedtls backend in a wrong way causing a systematic segfault upon connec=
tion.
>>
>> Basically mbedtls_cipher_free(ctx) was moved from the defunct cipher_ctx=
_cleanup()
>> to md_ctx_free(), while it was supposed to go into cipher_ctx_free().
>> This was clearly wrong as also the type of the ctx variable was not
>> correct anymore.
>>
>> Fix this mistake by actually moving mbedtls_cipher_free(ctx) to
>> cipher_ctx_free().
> This looks reasonable, the explanation makes sense and it pacifies
> buildbot (gave this a test run on all the bots, and we're back to
> "t_client test 1 fails on ubuntu+fedora29", and no more crashes).
>
> So I'm good with it, though I'd welcome a confirmation from Arne
> or Steffan.

Yeah, sorry that looks like a very stupid mistake from my side :(

Acked-By: Arne Schwabe <arne@...1227...>



