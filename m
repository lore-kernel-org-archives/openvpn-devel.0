Message-ID: <9fa83f54-cdd1-f2ca-38c5-f601b3c3b45c@...2666...>
Date: Tue, 29 Mar 2022 16:14:58 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329053709.19462-1-info@...2666...>
 <YkLfTY6hyQzy9QW7@...1296...>
From: Michael Baentsch <info@...2666...>
In-Reply-To: <YkLfTY6hyQzy9QW7@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Enable usage of TLS groups not
 identified by a NID in OpenSSL 3
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

Am 29.03.22 um 12:28 schrieb Gert Doering:
> Hi,
>
> On Tue, Mar 29, 2022 at 07:37:09AM +0200, Michael Baentsch wrote:
>> From: Michael <57787676+baentsch@...2243...>
>>
>> OpenSSL3 prefers to specify groups (including EC groups) with names
>> instead of NID to allow also groups provided by providers.
>> This commit also removes the mapping of secp256r1 to prime256v1 for
>> the OpenSSL3 code path as OpenSSL 3.0 recognises secp256r1.1
>> ---
> If Arne is fine with the actual change, I think the commit message
> is good to go.  The "From:" line (which is what git recorded as author)
> is a bit weird - if you're fine with that, I'll use your e-mail From:
> instead, also for the "signed-off-by:" header.

What do you consider weird in there? My name is Michael and I prefer to 
not use a real email address in git commit messages:

<57787676+baentsch@...2243...> is the ID github assigned 
to my "baentsch" github ID .

But then again, OpenVPN is not using github, so linking to that ID won't 
work anyway...

So, OK, go ahead and use "Michael Baentsch (info@...2666...)" as From:

>
> (The exact meaning of the signed-off-by: is a bit fuzzy to me - our
> developer docs say "patch is ready to be applied", but they also say
> "if it is missing, the value of From: is used".  Some other voices
> interpret it as "yes, I've read the project guidelines and license,
> and agree to them"...)
>
> gert

Thanks in advance,

--Michael


