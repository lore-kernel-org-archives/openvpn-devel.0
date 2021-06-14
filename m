References: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
 <50df7743-5541-40dd-c2ea-f81e3ad9c29c@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <3ba00502-4919-b866-451f-0ae215e6a170@...2181...>
Date: Mon, 14 Jun 2021 03:01:57 +0200
MIME-Version: 1.0
In-Reply-To: <50df7743-5541-40dd-c2ea-f81e3ad9c29c@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] TLS Error: local/remote TLS keys are out of sync
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 14/06/2021 02:56, Arne Schwabe wrote:
> Am 14.06.21 um 02:24 schrieb Antonio Quartulli:
>> @Arne, ideas?
>>
> 
> Yes. When reneg-sec is below 60 or 120 (would need to double check), you
> need that value on both server and client since otherwise the timeouts
> for changing active keys mismatch as the value is 60s normally but
> changes if reneg-sec goes below that value.

Isn't it relevant that the server is able to fix itself in around 5/6
seconds? It does not need to wait for the full 60s to get back in sync.

From the log it also seems like the key with the new ID has been
installed, but the state has not been switched.


Regards,



-- 
Antonio Quartulli

