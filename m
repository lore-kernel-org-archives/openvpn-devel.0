MIME-Version: 1.0
In-Reply-To: <201802201223.w1KCNrwC066890@...2054...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <201802201223.w1KCNrwC066890@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 20 Feb 2018 09:47:43 -0500
Message-ID: <CAKuzo_jfNBA2MrsSmhVGp+muGBHP61VdGbY92p7uEQbVtWePvw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Ensure strings read from
 registry are null-terminated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Feb 20, 2018 at 7:23 AM, Gert Doering <gert@...1296...> wrote:
> Acked-by: Gert Doering <gert@...1296...>
>
> "Because it makes sense" (checked with the Windows API documentation, and
> compile-tested on ubuntu 16.04).
>
> Your patch has been applied to the master and release/2.4 branch.
>
> There was one issue with your patch that you might want to look into - it
> seems to be based on a private branch that has a "#define REG_KEY" which
> does not exist in my tree, and which I could not find any references to
> on the mailing list either.  It broke applying the patch as it appeared
> in patch context - but since none of the actual code line reference this,
> I decided to apply the patch nonetheless (it has been lingering for way
> too long already).

That line got removed by the following commit (multiple service instances):

commit f3fec49b1c916a701058ef2445b4c07005c30673
Author: Simon Rozman <simon@...2293...>
Date:   Sun Dec 3 22:16:54 2017 +0100
openvpnserv: Add support for multi-instances

So it was a rebase conflict. I scanned through the patch as applied
and all look ok.

Thanks,

Selva

