Message-ID: <7781365e-5c2f-ad38-d08f-151cc1a7f3d8@...1227...>
Date: Sat, 29 Jan 2022 20:05:29 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-3-arne@...1227...> <YfPQVunkBAhZWuXC@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YfPQVunkBAhZWuXC@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3 02/14] Fix mssfix and frame
 calculation in CBC mode
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
Cc: openvpn-devel@lists.sourceforge.net

Am 28.01.22 um 12:15 schrieb Gert Doering:
> Hi,
> 
> On Sat, Jan 01, 2022 at 05:25:20PM +0100, Arne Schwabe wrote:
>> This commit fixes the MSS calculation in CBC mode. This fix has two parts:
>>
>> - Added rounding to a multiple of block size during calculation of overhead
>> - In CBC mode the packet ID is part of the plaintext (or payload) rather
>>    than part of the header (like for AEAD), adjust the functions to
>>    correctly reflect this.
>>
>> OCC link calculation is not affected since it ignores rounding of CBC
>> block size completely.
> 
> I've done a bit of whacking of this, and it is still not fully right,
> unfortunately.
> 
> The short form is
> 
>    - BF-CBC, LZ4, --mssfix 1000, over IPv4
>       v4 TCP -> MSS 923, resulting UDP payload <= 1008 bytes
>       v6 TCP -> MSS 903, resulting UDP payload <= 1008 bytes
>   - BF-CBC, LZ4, --mssfix 1000, over IPv6
>       v4 TCP -> MSS 923, resulting UDP payload <= 1008 bytes
>       v6 TCP -> MSS 903, resulting UDP payload <= 1008 bytes
>       [so this is clearly wrong!]
> 
>   - BF-CBC, comp no, --mssfix 1000, over IPv4
>       v4 TCP -> MSS 923, resulting UDP payload <= 1000 bytes
>       [can't test v6 inside in this particular server instance]
> 
> so, something is wrong with the rounding and the compression opcode
> in CBC mode.  With "comp no" the resulting packets are correct (UDP payload
> <= 1000 bytes), with "comp lz4" - doing the framing, but not doing
> actual compression - UDP payload exceeds --mssfix config.

I looked into this. This is still an artefact from our workaround that 
we do not recalculate frame parameter if the cipehr does not change 
after push. So if something else is pushed that changes the frame 
parameter like compression, we continue to use the old parameter and 
this the behaviour we are seeing.

The workaround is eventually removed in the patch set but not in this 
patch. To test here either already put the compress option in the config 
before or artificially use a different cipher to force teh recalculation.

Arne


