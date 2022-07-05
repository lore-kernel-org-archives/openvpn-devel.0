Message-ID: <3baf9d95-2d8b-d2b5-cbdb-411d75c3afd9@...1227...>
Date: Tue, 5 Jul 2022 17:14:18 +0200
MIME-Version: 1.0
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-15-a@...2181...> <5439977.94X2OUf111@...2664...>
 <e91f8966-1280-9263-be1f-b195a681c13c@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <e91f8966-1280-9263-be1f-b195a681c13c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 14/25] dco: implement dco support for
 p2mp/server code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net


Am 05.07.2022 um 16:53 schrieb Antonio Quartulli:
> Hi,
>
> On 05/07/2022 14:31, Heiko Hund wrote:
>> On Freitag, 24. Juni 2022 10:37:58 CEST Antonio Quartulli wrote:
>>> +    uint8_t *ptr = BPTR(&dco->dco_packet_in);
>>> +    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
>>> +    if (op == P_DATA_V2 || op == P_DATA_V2)
>>
>> This looks odd. Seems you wanted to check for a second opcode, or is it
>> obsolete?
>
> we wanted want to bail out on DATA packets - not sure why this was 
> repeated twice. Removing one check.
>

The first one should be P_DATA_V1


Arne


