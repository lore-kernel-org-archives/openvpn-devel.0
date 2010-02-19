Date: Fri, 19 Feb 2010 15:38:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100219143841.GS9556@...1296...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<7bb795fd1002190621oefc5e4dx9ccb19d55f0e7534@...278...>
Mime-Version: 1.0
In-Reply-To: <7bb795fd1002190621oefc5e4dx9ccb19d55f0e7534@...278...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
	openvpn-testing tree available)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: JuanJo Ciarlante <jjo+ml@...410...>
Cc: Openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Feb 19, 2010 at 03:21:34PM +0100, JuanJo Ciarlante wrote:
> > JJO's patch does more than that, he does DNS lookups to print the
> > DNS name for the IPv6 address in question.
>=20
> Wrong.
> From getaddrinfo(3):
>    """
>       If hints.ai_flags contains the AI_NUMERICHOST flag then the node
>       parameter must be a numerical network address.
>       The AI_NUMERICHOST flag suppresses any potentially  lengthy
>       network host address lookups.
>    """

Ah!  Learned something new today.  So what's the specific advantage of
using getnameinfo() instead of inet_ntop() instead?

(I've only ever used getnameinfo() if I really wanted to do DNS lookups).

> >=A0Now we enter religious
> > territory - *I* think that this is not a good thing.
>=20
> I can't more eagerly _agree_ on tossing out any reverse
> DNS lookups at this level.

OK, good.  Glad that this was just a misreading of the code.


> > The existing
> > code doesn't do reverse DNS lookups for IPv4 mroute printing, and so
> > the IPv6 code should behave similar to the IPv4 code, and not do DNS
> > either (also, depending on DNS lookup in this place might lead to
> > weird delays in unexpected situations). =A0But this is partly religious,
> > partly "follow the coding style of the existing code" stuff.
>=20
> IMO we should void using inet_ntop() and friends, personally
> I don't like locking around their lack of multi-threading.

Mmmh, ok.  I wasn't aware that inet_ntop() is not thread-safe.  (Looking
at the FreeBSD implementation, at least that one *is* thread-safe - no
static buffers, etc.).

If it is not thread-safe, it won't break anything in my code, though=20
(lucky me :-) ) - my use of it in print_in6_addr() is mutex-locked anyway,
due to the use of a static buffer there.

Is getnameinfo() *guaranteed* to be thread-safe?

Do you have a reference that documents that inet_ntop() and inet_pton()
are unsave to be used in a threaded context?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

