References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-9-git-send-email-steffan.karger@...1435...>
 <4d7513af-8331-af07-463b-4a70d8489f25@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <88c110d6-f507-6113-0467-887b0471b5a6@...1856...>
Date: Fri, 22 Jun 2018 08:40:33 +0200
MIME-Version: 1.0
In-Reply-To: <4d7513af-8331-af07-463b-4a70d8489f25@...2181...>
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
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 15-06-18 09:46, Antonio Quartulli wrote:
> 
> 
> On 08/12/17 20:07, Steffan Karger wrote:
>> To avoid having to include misc.c - which is a dependency mess - in the
>> tls-crypt unit tests, move file-handing related functions to platform.c
>> (which is where other file-related functions already reside).
>>
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> 
> I have applied this patch right after the one about PEM and it triggered
> the following:
> 
> Falling back to patching base and 3-way merge...
> 
> How about rebasing it before the actual tls-crypt-v2 patches so that it
> could be applied earlier and shrink down this patchset?
> 
> 
> On top of that, would you please extend the commit message a little bit
> to include the fact that you are adding a new mock'd component
> (get_random) needed by the tls-crypt unit-test?
> 
> Actually....If I understand correctly, this new mock'd component will
> only be used when the other patches will be merged too.
> Therefore, I guess this patch could be divided in 2: one part being the
> code move and the second part being the introduction of the mock'd
> component. The latter may directly be included in the patch adding the
> tls-crypt unit-test.
> 
> What do you think?

I think you have a good point.  I'll reorder, split and merge.

> Other than this, the patch looks good.
> Checked with "git show --color-moved=zebra" to ensure that the code
> being moved wasn't modified.
> 
> And +1 for this patch for cleaning up the misc.c mess some more.

Thanks!

-Steffan

