Message-ID: <d363a86d-088a-e81f-aed8-77f22f698397@...1227...>
Date: Fri, 4 Feb 2022 20:12:26 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211006180644.3081219-1-arne@...1227...>
 <20211105150742.2909443-1-arne@...1227...>
 <4407050c-4304-9112-7cb2-7a8489aaa315@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <4407050c-4304-9112-7cb2-7a8489aaa315@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] Default to --cipher BF-CBC if not
 set and compat-mode < 2.4.0
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 04.02.22 um 17:51 schrieb Antonio Quartulli:
> Hi,
> 
> On 05/11/2021 16:07, Arne Schwabe wrote:
>> When we try to make a configuration compatible to a version earlier
>> than 2.4.0 we probably need to have a --cipher configured since NCP
>> is not available. In configuration where --cipher is not specified
>> we default to BF-CBC to support these old clients.
>>
>> Note that with OpenSSL 3.0 you will also need to enable the legacy
>> provider otherwise we bail out since BF-CBC is no longer supported.
>>
>> Also move the condition so BF-CBC gets included in the data-ciphers
>> list.
>>
>> Patch v2: move the comment to a better place.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Reviewed-by: Antonio Quartulli <a@...2181...>
> 
> Unfortunately I cannot fully ACK this patch because I'd need to compile 
> 2.3 to run a test, but this turned to be a mission impossible (due to 
> OpenSSL compatibility issues).
> 
> The change makes sense and it should do what we expect.
> 
> If anybody wants to test against an openvpn2.3 peer is most welcome.

A 2.4 client with ncp-disable should work nicely as well. We just do not 
make ourselves compatible with 2.4.0 with ncp-disable if you select 
2.4.0, you need 2.3.0 for that.

Arne

