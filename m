References: <20210305141352.21847-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a49bbbe0-c92b-abd9-ac60-000d7b31717f@...2181...>
Date: Sat, 6 Mar 2021 21:56:36 +0100
MIME-Version: 1.0
In-Reply-To: <20210305141352.21847-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6] Prefer TLS libraries TLS PRF
 function, fix OpenVPN in FIPS mode
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 05/03/2021 15:13, Arne Schwabe wrote:
> This moves from using our own copy of the TLS1 PRF function to using
> TLS library provided function where possible. This includes currently
> OpenSSL 1.1.0+ and mbed TLS 2.18+.
> 
> For the libraries where it is not possible to use the library's own
> function, we still use our own implementation. mbed TLS will continue
> to use our own old PRF function while for OpenSSL we will use a
> adapted version from OpenSSL 1.0.2t code. The version allows to be
> used in a FIPS enabled environment.
> 
> The old OpenSSL and mbed TLS implementation could have shared some
> more code but as we will eventually drop support for older TLS
> libraries, the separation makes it easier it remove that code
> invdidually.
> 
> In FIPS mode MD5 is normally forbidden, the TLS1 PRF1 function we
> use, makes uses of MD5, which in the past has caused OpenVPN to segfault.
> The new implementation for OpenSSL version of our custom implementation
> has added the special flags that tell OpenSSL that this specific use
> of MD5 is allowed in FIPS mode.
> 
> No FIPS conformitiy testing etc has been done, this is only about
> allowing OpenVPN on a system where FIPS mode has been enabled system
> wide (e.g. on RHEL derivates).
> 
> Patch v4: Handle the unlikely case that PRF generation fails. More formatting
>           fixes.
> Patch v5: v4 with the formatting fixes actually commited. sigh.
> 
> Patch v6: More formatting fixes, make OpenSSL fucntion return bool instead
>           of int.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>


It looks good and passes my basic tests.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

