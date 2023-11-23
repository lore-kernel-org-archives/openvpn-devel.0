Message-ID: <113dd511-7ee5-1bde-57cb-3aa9f8b00dcb@...2108...>
Date: Thu, 23 Nov 2023 08:41:01 +0100
MIME-Version: 1.0
Content-Language: en-GB, nb-NO
References: <20231122143110.58520-1-dazo+openvpn@...2108...>
 <ZV53yiEO_4y2TvGy@...1296...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <ZV53yiEO_4y2TvGy@...1296...>
Subject: Re: [Openvpn-devel] [PATCH release/2.6] Remove --tls-export-cert
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 22/11/2023 22:51, Gert Doering wrote:
> Hi,
> 
> On Wed, Nov 22, 2023 at 03:31:10PM +0100, David Sommerseth wrote:
>> From: David Sommerseth <davids@...515...>
>>
>> As OpenVPN 2.6+ is doing some adoptions to the license text, all
>> prior contributors need to accept this new text.  Unfortunately, Mathieu
>> Giannecchini who implemented the --tls-export-cert feature did not
>> respond at all.  Without an explicit acceptance we need to remove this
>> feature to avoid potential legal complications.
>>
>> If this is still a wanted feature, it will need to be re-implemented
>> from scratch.
> 
> Is this significantly different from the "master" patch that it needs
> an extra 2.6 patch?
> 
> (So now I have 4 patches to deal with, not "1 that goes to master +
> release/2.6"...)
The "second set" should just be offset changes between master and 
release/2.6.  I did it that way so you wouldn't need to be worried about 
any merge conflicts.  It is based on the latest heads of master and 
release/2.6.

If you want to just cherry-pick the master patches for 2.6, that's all 
fine by me.  Also if you want to squash them into a single commit as well.

These patches are purely intended to ease the merging process, as in "no 
conflicts expected".  And to indicate that this is both master + 
release/2.6 material.

The main reason I overlooked the x509_write_pem() function was that 
Adriaan de Jong refactored out that functionality from the main feature 
function into a dedicated function back in the days with the SSL/TLS 
refactoring to support PolarSSL.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



