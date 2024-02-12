Message-ID: <cc011236-9622-459d-ad86-ce50ccf9e3ac@...2525...>
Date: Mon, 12 Feb 2024 14:29:08 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20240209155109.110542-1-juliusz@...2525...>
 <5a267442-43f6-423a-9112-24b53cb5ca2e@...1227...>
 <6dd9197d-36e6-4694-8b9d-2e5d403c5835@...2525...>
 <ZcoU0nFXFAZzWLw6@...1296...>
From: Juliusz Sosinowicz <juliusz@...2525...>
In-Reply-To: <ZcoU0nFXFAZzWLw6@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] wolfssl: include "ssl.h" by
 "src/openvpn/ssl.h"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Gert,

that is the direction I went with the latest patch I sent over.

Sincerely
Juliusz Sosinowicz

On 12/02/2024 13:53, Gert Doering wrote:
> Hi,
>
> On Mon, Feb 12, 2024 at 10:57:41AM +0100, Juliusz Sosinowicz wrote:
>> commit 70b39f2bea9fd6e57f31e32b2041246731140cb2 has added the use of
>> ACK_SIZE and RELIABLE_ACK_SIZE in test_ssl.c. These are defined in
>> reliable.h which should be included through your ssl.h. Since our ssl.h is
>> being picked up, these never get defined and make check results in the
>> following error:
> Seems the unit test compile flags could use a bit of shuffling to
> have our local include first... and that should solve it (if nothing
> else breaks, just test_ssl.c)
>
> gert

