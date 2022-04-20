Message-ID: <a79d293a-9983-440f-14cf-fce2dace7dad@...2080...>
Date: Wed, 20 Apr 2022 10:38:46 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAF465zritiOYwQkFEdUG5Fr5+ZDVubwpcmMgF=4zU3n4q8bbvg@...278...>
 <CAF465zod1f6+jrUB+ZticpEwTAvr1YFFJ_jLKxoLeNG2LrieDQ@...278...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <CAF465zod1f6+jrUB+ZticpEwTAvr1YFFJ_jLKxoLeNG2LrieDQ@...278...>
Subject: Re: [Openvpn-devel] Fix links to client docs
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
To: David Schneider <schneidav81@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 19/04/2022 15:09, David Schneider wrote:
> Hello
> 
> This is my first contribution to this project.  As stated in the
> README patches should be sent to the mailing list.
> 
> Here is a small change to fix the wrong path to the client docs page.
> 
> Please let me know if the patch should be submitted in any other form.
> 

Thanks a lot!  This worked fine, I could easily do a 'git am' on your 
attachment.

I've applied your patch, but slightly adjusted the commit message.


commit b7d9bda52aee2f0577fd45e0adbf9ac3eaf8ae00
Author: David Schneider <schneidav81@...277...>
Date:   Tue Apr 19 14:48:39 2022 +0200

     docs: Fix incorrect doc paths in net.openvpn.v3.sessions docs

     Signed-off-by: David Schneider <schneidav81@...277...>
     Signed-off-by: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


