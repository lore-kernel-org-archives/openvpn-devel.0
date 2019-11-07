References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
 <20191107122743.GQ40538@...1296...>
 <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <e2068c1e-739e-6cc7-06bc-f2c7d99dc39e@...277...>
Date: Thu, 7 Nov 2019 13:32:23 +0000
MIME-Version: 1.0
In-Reply-To: <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07/11/2019 12:42, Lev Stipakov wrote:
> Hi,
> 
> 
>> I'm a bit unhappy with that one, as it changes behaviour for all
>> non-windows
>> builds (including all the openssl build output even if it succeeds).
>>
> 
> The only place it changes behavior is this
> 
>   install:
>     - if [ ! -z "${CHOST}" ]; then unset CC; fi
> -  - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
> +  - .travis/build-deps.sh
> 
> I don't see it as an issue to print output when building dependencies. The
> reason why
> it is done is that travis aborts build if there is no output for more than
> 10 minutes.
> 

Can travis be instructed to wait longer ?

