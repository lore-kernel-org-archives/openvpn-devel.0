References: <20180620044650.18041-1-rosenp@...277...>
 <20180620050012.GR57262@...1296...>
 <CAKh=nwE8OzcA1e7et3Xc=MtdanG4SBc7vAFaFGC=7T4_CmsP9w@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <738a88ee-02be-1a73-2537-a06c6e673894@...1227...>
Date: Wed, 20 Jun 2018 14:59:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAKh=nwE8OzcA1e7et3Xc=MtdanG4SBc7vAFaFGC=7T4_CmsP9w@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix compilation with
 deprecated APIs disabled on 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Emmanuel Deloget <logout@...260...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 20.06.18 um 14:40 schrieb Emmanuel Deloget:
> Hello Rosen,
> 
> On Wed, Jun 20, 2018 at 7:00 AM Gert Doering <gert@...1296...> wrote:
>>
>> Hi,
>>
>> On Tue, Jun 19, 2018 at 09:46:50PM -0700, Rosen Penev wrote:
>>> Signed-off-by: Rosen Penev <rosenp@...277...>
>>> ---
>>>  src/openvpn/crypto_openssl.c     |  9 +++++++++
>>>  src/openvpn/ssl_openssl.c        | 32 +++++++++++++++++++++++++++++++-
>>>  src/openvpn/ssl_verify_openssl.c |  1 +
>>>  3 files changed, 41 insertions(+), 1 deletion(-)
> 
> Can you give a better explanation of the issue ? (I'm sorry, I try to
> follow the discussions on the ML, but I'm kind of slow (and busy,
> which does not help)).

For function that are different in OpenSSL 1.0 and 1.1 we put them into
the compat_openssl.h instead of adding ifdefs in the code.

Most time we implement the new function name with the old API to have
only the new API in OpenVPN itself. E.g. SSLeay_version would be
implemented via OpenSSL_version


And while I am here:

>  #if OPENSSL_VERSION_NUMBER >= 0x10002000L
>          /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
>           * loading */
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L
>          SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
> +#endif
>          return;
>  #else

That ifdef removal needs a bit more explaination (e.g. that function
being a dummy with compat layer).

Arne

