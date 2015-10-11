References: <1444571266-6598-1-git-send-email-arne@...1227...>
	<CAA1AbxJ+GvoaeAz4qhyzAN=MNr4wfm2cN_0TRweGzer8cnhCjw@...278...>
	<20151011174443.GN22054@...1296...>
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <561ACF7A.30400@...1114...>
Date: Sun, 11 Oct 2015 23:07:06 +0200
MIME-Version: 1.0
In-Reply-To: <20151011174443.GN22054@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Do not set the buffer size by default
 but rely on the operation system default.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 11/10/15 19:44, Gert Doering wrote:
[...snip...
> ChangeLog entries are good, but I disagree on the format (sorry) - what
> we have in ChangeLog *today* is basically "git shortlog $tag..$HEAD" 
> when doing a release - so I think we should not mix the "user visible
> changes" in here, but maintain a separate file, eg. "CHANGES(.rst, .md)", 
> for these.

Agreed!  I see that the files Samuli added regarding contribution have .rst.
I don't care if it is .rst or .md.  But lets keep the same extension/format
for CHANGES too.

> Alternative, rename ChangeLog to "GitShortlog.txt" and put the user visible
> changes into ChangeLog - but please do not mix.

Agreeing to the mixing.  I think we should keep ChangeLog as is, as I believe
that resembles the format used since the very beginning.  Even though the
verbosity have increased since we started using git and git shortlog.  Some
packagers or other interested may already have routines in place for grokking
through our current ChangeLog file.


-- 
kind regards,

David Sommerseth

