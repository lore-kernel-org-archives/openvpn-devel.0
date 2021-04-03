References: <20210325000121.10331-2-arne@...1227...>
 <20210401123751.31756-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b5310f10-05db-bb8f-d2a9-f616e6752e91@...2181...>
Date: Sat, 3 Apr 2021 11:06:54 +0200
MIME-Version: 1.0
In-Reply-To: <20210401123751.31756-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Remove deprecated option '--keysize'
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

On 01/04/2021 14:37, Arne Schwabe wrote:
> This option has been deprecated in OpenVPN 2.4 and the ciphers that allow
> using this option fall all into the SWEET32 category of ciphers with
> 64 bit block size.
> 
> Patch V2: Remove superflous check in OpenSSL codepath to check keysize

Thanks for removing the extra check.

> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Compile tested on Linux against:
* OpenSSL 1.1.1
* OpenSSL 1.0.1
* OpenSSL 1.0.2
* mbedTLS 2.26.0
* mbedTLS 2.20.0
* mbedTLS 2.10.0

Windows+OpenSSL-1.1.1 compiled too (mingw).

Basic connection tests (master vs master and master vs 2.5) performed
with OpenSSL 1.1.1 and mbedTLS 2.26.0 on Linux.


Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

