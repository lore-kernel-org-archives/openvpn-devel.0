From: Steffan Karger <steffan@...1856...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-9-git-send-email-steffan.karger@...1435...>
 <4d7513af-8331-af07-463b-4a70d8489f25@...2181...>
 <88c110d6-f507-6113-0467-887b0471b5a6@...1856...>
Message-ID: <b838ba92-0719-21fd-ca81-73929b111f0c@...1856...>
Date: Fri, 22 Jun 2018 08:52:34 +0200
MIME-Version: 1.0
In-Reply-To: <88c110d6-f507-6113-0467-887b0471b5a6@...1856...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 08/10] Move file-related functions from
 misc.c to platform.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 22-06-18 08:40, Steffan Karger wrote:
> On 15-06-18 09:46, Antonio Quartulli wrote:
>> Actually....If I understand correctly, this new mock'd component will
>> only be used when the other patches will be merged too.
>> Therefore, I guess this patch could be divided in 2: one part being the
>> code move and the second part being the introduction of the mock'd
>> component. The latter may directly be included in the patch adding the
>> tls-crypt unit-test.
>>
>> What do you think?
> 
> I think you have a good point.  I'll reorder, split and merge.

Hm, not that easy actually.  The file functions themselves use
get_random, to produce a random filename for the temp files.  So just
reorder, not split/merge.  I'll add a note about this in the commit message.

-Steffan

