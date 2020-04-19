References: <20200416113930.15192-1-arne@...1227...>
 <20200416113930.15192-3-arne@...1227...>
 <5e764697-b61e-7115-7e3c-fcc7bf0407e7@...2181...>
 <20200419102725.GA1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <33b3339e-f90c-e35d-5921-f937fb07acd8@...2181...>
Date: Sun, 19 Apr 2020 14:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <20200419102725.GA1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] After the last big formatting
 patch a number of changes have been commited that do not conform with our
 style/uncrustify config. This has lead to the problem that running
 uncrustify on before sending PR some of the changes made by uncrustify need
 to be backed out again.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 19/04/2020 12:27, Gert Doering wrote:
> Hi,
> 
> On Fri, Apr 17, 2020 at 05:01:29PM +0200, Antonio Quartulli wrote:
>>> -    char* ret = management_query_multiline_flatten(man,
>>> -            (char *)buf_bptr(&buf_data), prompt, desc,
>>> -            &man->connection.ext_key_state, &man->connection.ext_key_input);
>>> +    char *ret = management_query_multiline_flatten(man,
>>> +                                                   (char *)buf_bptr(&buf_data), prompt, desc,
>>
>> why not moving some arguments on the first line ? One or two should fit.
>> (IMHO it can be done in this patch - it's still about restyling)
> 
> The point of a "this is what uncrustify produces" patch is to produce
> something which is immutable on future runs of uncrustify - so we can
> check *new* code, without having to ignore other stuff that uncrustify
> wants to change every time.
> 
> So, running uncrustify, and then changing things for a nicer look is
> not solving the underlying issue.
> 

fully agreed. but in this case uncrustify is just fixing the alignment -
moving the arguments above would not make uncrustify unhappy because all
rules would still be respected.


Regards,

-- 
Antonio Quartulli

