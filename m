MIME-Version: 1.0
References: <1521522224-18829-1-git-send-email-selva.nair@...277...>
 <1521522224-18829-2-git-send-email-selva.nair@...277...>
 <CAKuzo_iZtshFKPdFBwnLHP2Z9_rdKRsZ_jLxPiVyhkNq9xu1iw@...278...>
 <20200513163619.GH1431@...1296...>
In-Reply-To: <20200513163619.GH1431@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 13 May 2020 13:44:59 -0400
Message-ID: <CAKuzo_gNp+3UDB_48d9vR43SnivSLk8ytsZtaKqLQO4uJOyTQA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Allow repeated cycles through
 remotes when management-query-remote is in use
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

On Wed, May 13, 2020 at 12:36 PM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Sun, Jun 09, 2019 at 03:33:55PM -0400, Selva Nair wrote:
> > Ref: https://patchwork.openvpn.net/project/openvpn2/list/?series=201
> >
> > These patches were meant to help implement choosing the remote through
> > the GUI. I may not find time for that but the patches by themselves
> > are still relevant.
> >
> > If there is some interest I'll rebase to master.
>
> I'm working my way through the patch queue these days, and now I'm
> at this one :-)
>
> Can you elaborate a bit how this would work, and how much work on the
> GUI side would be needed?  (And, yes, a rebased patch :) ).

From what I can recall...

Two points to note:

(i) With multiple remotes, openvpn exits if no successful connection
could be made after two cycles through all remotes (undocumented?) .
(ii) When --management-query-remote is used, the core presents one
remote at a time and the user has to make a choice to skip, accept or
replace without knowing which remotes are available.

Now, for a user-friendly implementation of selecting the remote from a
GUI dialog, the plan is to silently cycle through all remotes, make a
list and then allow the user to make a selection from the list. This
will be aided by having a safe way to cycle through all remotes
multiple times without the core exiting --- arguably, one cycle is
enough to make a list and the list building is complete when the
second cycle starts. But it would be much easier to do this without
having to worry about the core exiting unexpectedly. The GUI knows how
to restart or terminate the core exit if need be.

The behaviour is unchanged if management-query-remote is not in use.

The patch also changes the way failed connections are counted: skipped
remotes should not be counted as failed as that count is used in the
back-off logic.

Selva

