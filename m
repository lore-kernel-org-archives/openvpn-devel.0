Message-ID: <b4dcc2b0-7be2-b0cc-6cbb-35824cf01ba0@...1227...>
Date: Fri, 17 Dec 2021 10:31:43 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211207170211.3275837-1-arne@...1227...>
 <20211214150903.4119175-1-arne@...1227...>
 <1565170174.1461018.1639669895740@...2642...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <1565170174.1461018.1639669895740@...2642...>
Subject: Re: [Openvpn-devel] [PATCH v2 07/21] Add helper functions to
 calculate header/payload sizes
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net


>> +
>> +    /* For figuring out the crypto overhead, we need to use the real payload
>> +     * including all extra headers that also get encrypted */
>> +    header_size += calculate_crypto_overhead(kt, packet_id,
>> +                                             packet_id_long_form,
>> +                                             payload_size, occ);
> 
> My question was why you mention "extra headers" here but that doesn't seem to be reflected
> in the code itself. After looking further into the code it seems to me that you allude here
> to the frame_caculate_payload_overhead function? But you don't use it here, you assume that
> the caller of this function already called it. So maybe instead of putting this comment here
> it would be better to put that into the documentation of this function in the header?

Ah sorry, I overlooked that. A better comment would be:

  /* For figuring out the crypto overhead, we need to use the real 
payload size including the extra headers that also get encrypted as part 
of the payload like compression and fragmentation header */

Anr

