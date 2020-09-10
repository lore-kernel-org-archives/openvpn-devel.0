References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
Date: Thu, 10 Sep 2020 14:11:50 +0200
MIME-Version: 1.0
In-Reply-To: <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Arne,

I understand your concern and apologize for the delay. We have been busy 
with the release of wolfSSL 4.5.0. I will make sure that the fixes 
necessary for OpenVPN support will be prioritized.

Sincerely
Juliusz

On 10/09/2020 12:18, Arne Schwabe wrote:
> Am 22.07.20 um 16:02 schrieb Juliusz Sosinowicz:
>> Hi Arne,
>>
>> thank you for your feedback. I tested the patch on the latest master
>> version at the time of writing and it looks like these requirements were
>> added in the last week which is why I wasn't able to address them
>> before.I will look into the new issues and get back to you when they are
>> fixed.
>>
>> I agree that most of these functions only require exposing existing
>> functionality on our side.
> We already progressed to OpenVPN 2.5-beta4 now. I think it is fair to
> say that WolfSSL missed the window to be included in 2.5.0. And seeing
> that these rather simple fixes take now over 1,5months does not exactly
> inspire confidence that WolfSSL is committed to maintaining OpenVPN support.
>
> Arne
>
>

