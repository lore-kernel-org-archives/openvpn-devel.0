References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
 <4f9a99ba-031d-43c7-c17f-8f842a519ddd@...1147...>
 <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
Date: Thu, 8 Apr 2021 17:30:52 +0200
MIME-Version: 1.0
In-Reply-To: <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 08/04/21 16:55, Arne Schwabe wrote:
> Am 08.04.21 um 16:36 schrieb Jan Just Keijser:
>> Hi,
>>
>> On 08/04/21 16:02, Arne Schwabe wrote:
>>> NCP has proven to be stable and apart from the one VPN Provider doing
>>> hacky things with homebrewed NCP we have not had any reports about
>>> ncp-disable being required. Remove ncp-disable to simplify code paths.
>>>
>>> Note: This patch breaks client without --pull. The follow up patch
>>> for P2P NCP will restore that. But to avoid all the NCP/non-NCP special
>>> cases to be implemented in P2P. P2P will directly switch from always
>>> non-NCP to always NCP.
>> I would Feature-NAK this :   disabling NCP is a valuable option. IMHO.
> I disagree here. NCP in 2.5 is mature mature enough that disabling NCP
> is not necessary any more. If you have any evidence otherwise, please
> explain a bit more since I personally don't see the value in it.

I don't have any evidence with 2.5 right now but this is just a matter 
of use/principle to me: I can very well see that I would like to have a 
setup *without* NCP as I simply do not need it (e.g. my cipher is 
hardwired to aes-256-gcm)  and in that case I don't *want* NCP to ensure 
my setup is 100% predictable.

Disabling this option means you give me less control over the setup and 
I don't like that, thus Feature-NAK.
>> Also, is the MTU calculation part on the server side now done
>> correctly?    I remember that with 2.4 the server would subtract (or
>> add, depending on point of iew) far too many bytes to handle NCP
>
> Not fully yet but the case where NCP cipher == original cipher has a
> workaround.
>
>
I'd say that removing the ability to disable NCP  can happen *only* when 
all negative side-effects of enabling it have been mitigated fully.  On 
a slow link the NCP overhead can be quite disastrous and not just during 
connection setup, but during the *whole* session. To me, yet another 
reason for Feature-NAK

JJK


