References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-8-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <b28b48c8-5e21-b628-b992-187f0fe52402@...2507...>
Date: Fri, 22 Oct 2021 19:08:28 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-8-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 07/21] [OSSL 3.0] Remove DES key
 fixup code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> This code mainly sets the parity bits in the DES keys. As mbed TLS and
> OpenSSL already ignore these bits in the DES key and since DES is
> deprecated, remove this special DES code that is not even needed by
> the libraries.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

Makes sense, why should we care about the parity bits when no-one else does?

Compiled and ran --test-crypto for DES/DES3 with OpenSSL 3.1.0, 1.1.1 
and mbedtls 2.26.

