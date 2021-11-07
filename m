References: <20211107090138.3150187-1-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <94a71a6a-6a90-a753-f4e4-10b632a26849@...2507...>
Date: Sun, 7 Nov 2021 11:47:45 +0100
MIME-Version: 1.0
In-Reply-To: <20211107090138.3150187-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Completely remove DES checks
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

On 07/11/2021 10:01, Arne Schwabe wrote:
> We already removed the check in d67658fee for OpenSSL 3.0. This removes the
> checks entirely for all crypto libraries.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

Looks good to me!

Compiled and ran --test-crypto for DES/DES3, with mbedtls and OpenSSL 3.

