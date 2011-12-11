Date: Sun, 11 Dec 2011 15:16:09 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20111211203701.GH18948@...1296...> (from
	gert@...1296... on Sun Dec 11 14:37:02 2011)
Message-Id: <1323638169.31975.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
 over to platform provided basename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

On 12/11/2011 02:37:02 PM, Gert Doering wrote:

> Of course nobody wants to reimplement all library functions (except=20
> djb, maybe, but we do not want to go there), but given some functions=20
> with sufficiently vague or messy calling semantics, having a better=20
> defined local implementation can improvide the code a lot.

I'm sorry if this is injecting noise into the conversation
but I cannot resist commenting.

I don't know the answer, but I do know the question: Improve
the code when?  The old adage is "standard is better than better"
comes to mind.  If the code is calling basename all the time
then it makes sense to improve it.  If we're talking about
saving a few microseconds here or there on startup or shutdown
I'd question whether yet another interface, better or not,
makes sense.  Likewise, if there's a problem that needs to
be fixed, say, people are introducing bugs, then by all
means it needs fixing.  Otherwise, if it ain't broke....

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


