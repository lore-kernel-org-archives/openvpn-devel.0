Message-ID: <01682a4d-b156-4507-e44d-ce87d14d477a@...2181...>
Date: Wed, 14 Sep 2022 16:47:31 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <Yx5JdRcEXh2tTqPE@...1296...>
 <20220912091057.752-1-lstipakov@...277...>
 <YyHfQIvhNIItXw7h@...2685...>
 <CAGyAFMUXWrOoWE+3PmY5GWVT3X0BMFLkomU9pWvw0K09foEp-A@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAGyAFMUXWrOoWE+3PmY5GWVT3X0BMFLkomU9pWvw0K09foEp-A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use DCO on Windows by default
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
To: Lev Stipakov <lstipakov@...277...>, Frank Lichtenheld <frank@...2641...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

On 14/09/2022 16:41, Lev Stipakov wrote:
> Hi,
> 
>> One general question about the patch: Whenever we have
>> defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
>> in the DCO code, couldn't we just remove it completely?
>> Since this is bascially "every time" anyway, isn't it?
> 
> Well, almost. There is also Mac and some other platforms which do not have DCO.
> 

but we could still use "ifdef ENABLE_DCO" instead of the OR of those 3, no?

Cheers,

> We could likely get rid of those defines if we add disable_dco into
> platform-specific tuntap_options
> structures. Would it be better to have disable_dco member, assuming
> platform doesn't support dco?
> 

-- 
Antonio Quartulli

