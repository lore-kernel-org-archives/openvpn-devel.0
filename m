MIME-Version: 1.0
In-Reply-To: <2e8cdc1d-ac4b-13bd-a16e-7888a84b22b2@...1856...>
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <2e8cdc1d-ac4b-13bd-a16e-7888a84b22b2@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 20 Jan 2018 13:36:48 -0500
Message-ID: <CAKuzo_hybNZf4tC+SZFVL4sRH9y6KnwkMG8QOdJ4KrET71RX_Q@...278...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sat, Jan 20, 2018 at 1:24 PM, Steffan Karger <steffan@...1856...> wrote:
> Hi,
>
> On 20-01-18 18:22, Selva Nair wrote:
>> Does openvpn-vagrant include any VM provisioning with openssl-0.9.8?
>> Until recently I had access to a few old debian boxes but now all
>> updated and 0.9.8 testing is getting harder.
>
> To test against various openssl versions, I statically compile against
> them, like this:
>
> git clone https://github.com/openssl/openssl.git --branch
> OpenSSL_0_9_8-stable
> git clone https://github.com/OpenVPN/openvpn.git --branch release/2.4
>
> (cd openssl && ./config -v -d no-shared && make build_libs)
>
> cd openvpn
>
> autoreconf -vif
>
> OPENSSL_CFLAGS="-I$(pwd)/../openssl/include" \
> OPENSSL_LIBS="-L$(pwd)/../openssl -lssl -lcrypto -lpthread -ldl" \
> ./configure --enable-strict
>
> make check

Something is similar is what I do but just moved my test system to a new machine
and was looking for an "fancier" approach. Actually once set-up this is easy,
so I'll go this route.

I thought vagrant is cool though I have hard time using anything fancier than
vi, so should continue to stay away :)

To respond to Gert's question, debian version I used to use was squeeze
(debian 6) but I don't think its anymore available anywhere.

Selva

