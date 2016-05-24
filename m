MIME-Version: 1.0
In-Reply-To: <5742C2E1.2060407@...515...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
	<20160522124546.GA53051@...1296...> <5742C2E1.2060407@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 24 May 2016 09:31:09 +0200
Message-ID: <CAA1AbxLFdnrxw-2nVYrKfUZ4CbPgfjR5=zYWLcqfhcdGkktVJw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, May 23, 2016 at 10:44 AM, Samuli Sepp=C3=A4nen <samuli@...515...> w=
rote:
> Yes. I think a separate testing branch with more liberal commit rights
> combined with pulling from GitHub makes sense. I'm not sure what happens
> at the buildslaves if we decide rewind history - rewinding would be
> quite useful when working with pure testing branches in that we could
> make "testing" track master and whenever a bad patch is found, simply
> rewind back to the last known-good state.

Isn't this what github pull requests + travis is supposed to give us?
Of course, that currently only covers a rather small part (much less
than the buildbot tests), but it's not that hard to expand that to at
least a decent number of compile variations.  That would give us
useful smoke tests before looking at a single line of code.

(May I remind the list of
http://thread.gmane.org/gmane.network.openvpn.devel/10865, which got
some comments from ciphitsine (see
http://thread.gmane.org/gmane.network.openvpn.devel/11557/focus=3D11585),
but was never really ACK'ed and applied.)

-Steffan

