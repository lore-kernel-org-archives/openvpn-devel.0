Message-ID: <4EDCA110.9090307@...515...>
Date: Mon, 05 Dec 2011 12:46:40 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4ED8C741.9000502@...1114...>
In-Reply-To: <4ED8C741.9000502@...1114...>
Subject: Re: [Openvpn-devel] Suggesting a new patch review approach
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>
> Hi,
>
> We've had a very strict patch review regime since we moved over to git.
> We see that this regime does work, but it can take a very long time
> before patches are reviewed and ACKed for inclusion.  This long delay is
> something we are less happy about.
>
> So I'm suggesting a new approach here.  I've noticed that if there are
> issues with patches, they are usually NACKed rather fast.  But the
> explicit ACKs are not happening as fast.  And this is something I'd like
> to make take an advantage of.
>
> I'm suggesting that if there are patches which someone do find useful,
> which has not been accepted, they need to be ACKed.  But if I see that a
> patch is floating on the ML longer than 14 days without any responses and
> I on a cursory glance see that this patch can make some sense, I will
> apply this patch to the git tree.  These patches will not have any
> 'Acked-by' statement.
>
> If I see that a patch is relevant and want a second opinion about it, I
> will nag some concrete persons.  If they don't respond after 14 days, I
> will most likely add the patch, adding a 'Cc:' statement with their mail
> address.  This is to indicate in the commit log that the Cc'ed persons
> have been informed about this patch.
>
> If it turns out that a patch should not have been included, we will
> naturally revert the patch again, provided we get a reasonable
> explanation why it needs to be reverted.
>
> This is only a suggestion, but unless this causes a clear dissatisfaction
> in the community, I'd like to start using this new outline asap.
>

Hi,

I think this is definitely worth a shot for a number of reasons.
Currently it's too easy to leave patches lying in the INBOX, in hopes
that somebody else takes care of them first. This strategy obviously
makes sense from personal stress / time management perspective (I've
used it also on occasion). However, I fear this also means that this
"somebody" will probably be the same person more often than not. This,
in turn, means that others soon notice that this person can move things
forward by himself, and that they don't need to participate as much.
This could create a nasty self-feeding cycle.

I'm not sure if the above analysis is correct, but for whatever reason
our current ACK model has not worked as smoothly as we would have liked.
Also, most of the ACKs have been given by a small subset of developers,
whereas NACKs have a more even distribution. Also, a big percentage of
patches have been ACKed in public IRC meetings because of lack of
feedback on the mailing lists. This is suboptimal as only a handful of
people can attend the meetings (e.g. due to timezones).

I think the new model might motivate people to participate, as we all
want to keep crap out of OpenVPN to ensure it works great in the future
also. So, I say go for it, and if it does not work, revert back to the
old practice or figure out something else.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

PS. A very similar model to David's proposal is used elsewhere, e.g. in
Apache project(s) where it's called "Lazy Consensus":

<http://communitymgt.wikia.com/wiki/Lazy_consensus>

