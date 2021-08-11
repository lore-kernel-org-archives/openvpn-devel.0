References: <20210805180950.838612-1-arne@...1227...>
 <ca592ce5-3123-35df-7533-f7dc79740cef@...2181...>
 <YRPH/+6urQNXMAlv@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <15cedae7-c34a-1fa9-5ddf-32b265058d11@...2181...>
Date: Wed, 11 Aug 2021 14:58:45 +0200
MIME-Version: 1.0
In-Reply-To: <YRPH/+6urQNXMAlv@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Modernise OpenVPN defaults and
 introduce '--compat-mode'
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
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 11/08/2021 14:52, Gert Doering wrote:
> Hi,
> 
> On Wed, Aug 11, 2021 at 09:29:22AM +0200, Antonio Quartulli wrote:
>> Wouldn't it be better to have one patch of reach default behaviour being
>> charged with a concise but focused explanation as to why that default is
>> being changed?
>>
>> After those patches, then another patch could come in implementing
>> compat-mode.
> 
> NAK to the proposed approach, because that would give us incompatible
> (and unfixable-incompatible) versions in between.

True - your objection makes sense.

> 
> I am open to splitting this patch, but would turn it around
> 
>  - compat-mode comes *first*, with an option that basically "does nothing"
> 
>  - each change to a default setting brings in the required compat-mode
>    adjustments
> 
> but I can live with "all in a single commit", provided the commit message
> (+ Changes.rst) is clear enough on the "what and why".

If the documentation coming with the patch (especially the commit
message) is clear enough, then one patch is good for me as well.

Ideally we really want to be able to read "this changed from X to Y,
because bla bla bla". Just as if we have to read this in 2 years from
now and want to know why we did that.

Regards,

-- 
Antonio Quartulli

