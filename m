References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-2-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <2e5f0de8-1b32-34a6-9041-716526bd77d1@...2507...>
Date: Wed, 20 Oct 2021 20:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 01/21] [OSSL 3.0] Use new EVP_MAC API
 for HMAC implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> The old API is deprecated in OpenSSL 3.0 and the new API does not yet
> exist in OpenSSL 1.1. Emulating the new API would be more complex than
> just having two implementations. So this switches to a new hmac
> implementation for OpenSSL 3.0.
> 
> Unfortunately the new API does not have an easy to reset an HMAC, so we need
> to keep the key around to emulate a reset functionality.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

Looked at the code, compiled with OpenSSL 3.1.0 and 1.1.1, and ran 
--test-crypto for both.

Small typo in commit message: "does not have an easy to reset", probably 
should be "easy way to reset".

