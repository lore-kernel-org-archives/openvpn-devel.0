Message-ID: <3bcdf0b1-e8e8-a00c-93e1-a553312502b8@...2181...>
Date: Mon, 27 Jun 2022 13:32:03 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-6-a@...2181...>
 <1b657825-faa9-ea35-fb12-84a940c1e0ba@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <1b657825-faa9-ea35-fb12-84a940c1e0ba@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 05/25] dco: let open_tun_generic handle
 the DCO case
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 27/06/2022 13:09, Arne Schwabe wrote:
> Am 24.06.22 um 10:37 schrieb Antonio Quartulli:
>> +                int ret = open_tun_dco(tt, ctx, dynamic_name);
>> +                if (ret == -EEXIST)
>> +                {
>> +                    msg(M_INFO, "TUN/TAP device %s exists previously, 
>> keep at program end",
>> +                        dynamic_name);
>> +                    tt->persistent_if = true;
>> +                }
> 
> 
> I think here the error message is really confusing. What does "keep at 
> program end" mean? And if we fail at opening DCO tun device why do we 
> talk about a TUN/TAP device and not about DCO?

IIRC I simply took this message from "the same scenario but without 
DCO", so the text was already bad :-D

But I agree we can improve it.

Thanks!

> 
> Arne
> 

-- 
Antonio Quartulli

