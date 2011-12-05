Message-ID: <4EDCD032.4090105@...1114...>
Date: Mon, 05 Dec 2011 15:07:46 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4ED8C741.9000502@...1114...> <4EDCA110.9090307@...515...>
	<1CED409804E2164C8104F9E623B08B90128AA72499@...1436...>
	<4EDCBAA8.4080104@...515...>
In-Reply-To: <4EDCBAA8.4080104@...515...>
Subject: Re: [Openvpn-devel] Suggesting a new patch review approach
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/12/11 13:35, Samuli Sepp=E4nen wrote:
>=20
>>> -----Original Message----- From: Samuli Sepp=E4nen
>>> [mailto:samuli@...515...] Sent: maandag 5 december 2011 11:47=20
>>> To: David Sommerseth Cc: openvpn-devel@lists.sourceforge.net=20
>>> Subject: Re: [Openvpn-devel] Suggesting a new patch review
>>> approach
>>>=20
>>>=20
>>>> Hi,
>>>>=20
>>>> We've had a very strict patch review regime since we moved over
>>>> to
>>> git.
>>>> We see that this regime does work, but it can take a very long
>>>> time before patches are reviewed and ACKed for inclusion.  This
>>>> long delay is something we are less happy about.
>>>>=20
>>>> So I'm suggesting a new approach here.  I've noticed that if
>>>> there
>>> are
>>>> issues with patches, they are usually NACKed rather fast.  But
>>>> the explicit ACKs are not happening as fast.  And this is
>>>> something I'd like to make take an advantage of.
>>>>=20
>>>> I'm suggesting that if there are patches which someone do find
>>> useful,
>>>> which has not been accepted, they need to be ACKed.  But if I
>>>> see
>>> that
>>>> a patch is floating on the ML longer than 14 days without any=20
>>>> responses and I on a cursory glance see that this patch can make
>>>> some sense, I will apply this patch to the git tree.  These
>>>> patches will not have any 'Acked-by' statement.
>>>>=20
>>>> If I see that a patch is relevant and want a second opinion
>>>> about it, I will nag some concrete persons.  If they don't
>>>> respond after 14 days, I will most likely add the patch, adding
>>>> a 'Cc:' statement with their mail address.  This is to indicate
>>>> in the commit log that the Cc'ed persons have been informed
>>>> about this patch.
>>>>=20
>>>> If it turns out that a patch should not have been included, we
>>>> will naturally revert the patch again, provided we get a
>>>> reasonable explanation why it needs to be reverted.
>>>>=20
>>>> This is only a suggestion, but unless this causes a clear=20
>>>> dissatisfaction in the community, I'd like to start using this
>>>> new
>>> outline asap. Hi,
>>>=20
>>> I think this is definitely worth a shot for a number of reasons.=20
>>> Currently it's too easy to leave patches lying in the INBOX, in
>>> hopes that somebody else takes care of them first. This strategy
>>> obviously makes sense from personal stress / time management
>>> perspective (I've used it also on occasion). However, I fear this
>>> also means that this "somebody" will probably be the same person
>>> more often than not. This, in turn, means that others soon notice
>>> that this person can move things forward by himself, and that they
>>> don't need to participate as much. This could create a nasty
>>> self-feeding cycle.
>>>=20
>>> I'm not sure if the above analysis is correct, but for whatever
>>> reason our current ACK model has not worked as smoothly as we
>>> would have liked. Also, most of the ACKs have been given by a
>>> small subset of developers, whereas NACKs have a more even
>>> distribution. Also, a big percentage of patches have been ACKed in
>>> public IRC meetings because of lack of feedback on the mailing
>>> lists. This is suboptimal as only a handful of people can attend
>>> the meetings (e.g. due to timezones).
>>>=20
>>> I think the new model might motivate people to participate, as we
>>> all want to keep crap out of OpenVPN to ensure it works great in
>>> the future also. So, I say go for it, and if it does not work,
>>> revert back to the old practice or figure out something else.
>>=20
>> I agree that a different patch approach might help. I haven't got
>> much experience in submitting single smaller patches, but it took a
>> long time to go through all of the patches in the PolarSSL queue.
>> The solution we used for this was to perform analysis of the patches
>> online on IRC. This worked well, but had the disadvantage that
>> everyone involved needs to be online at the same time.
>>=20
>> A model that seems to be successful in some other projects is the
>> use of gerrit for code review. Is that something that we could
>> experiment with? At the very least, it would make offline
>> discussions a little easier by allowing you to comment directly on
>> certain blocks of code. Gerrit might also motivate more people to
>> participate, since it makes reviewing a little more interactive.
>>=20
>> Adriaan
> I think for really large patchsets (e.g. PolarSSL) the IRC is
> actually pretty good. There's often quite a lot of communication
> involved when reviewing patches (e.g. "why is this doing this like
> this?"), so reviewing 100 patches on the ml would be painful if not
> impossible.

Agreed.

> David spoke of Gerrit and if it helps with patch review I'm all for
> it. In fact, I more or less promised to set it up after the 2.3
> release.

I think we should seriously look at Gerrit ... but agree it will need to
be after 2.3.  I hope this can increase the involvement - however, I'm
not too optimistic.  However, Gerrit can hopefully make it even easier to
avoid missing/loosing patches, just because they "drowned" in a lot of
mails on the ML.

> One thing I forgot to ask about... should we still require an ACK for=20
> all patches that go to "stable" release branches? Or should we
> include any "silently approved" fixes from "master" without further
> discussion?

Patches doesn't necessarily go completely un-acked automatically into the
git tree.  And this is the flaw in my proposal.  As I'm currently the one
gatekeeping the git tree, my opinion does influence these un-acked
patches a lot.

I don't think I said *all* patches would go into the tree without any
reason.  What I said was that if *I* find un-acked patches reasonable to
include, I would do so - skipping the official ACK *if* the patch would
be laying 14 days on the mailing list without any response.  For patches
laying that long and which I don't find any argument/reason for to
include, I would in most cases respond with a NACK and a reason why.  But
there are no guarantees.

So it would be some kind of "semi-review", but I would not personally put
my head on the block defending these included but un-acked patches.  A
little glitch/bug which would not be fixed reasonably quick, and I would
just as easy revert these patches and then just forget about them again.

Patches which are ACKed, would however have a harder time being reverted
and kicked-out, just because they have been reviewed more formally.
Hopefully patch author and reviewers are at least able to help out fixing
issues reasonably fast before it gets too annoying for the rest of us.

So bottom line:
  * Get your patches ACKed, and it will go into the tree quite easily; it
    will even stay there longer if there are issues.  But it is _expected_
    that you (patch author and reviewer) are _responsive_ if there are
    issues with your patches.

  * If there are no ACKs, you might or you might not get your patches into
    the tree (no guarantee); and it might be kicked out without much grace
    time for fixes.

But I promise I will try to include developers I've been much in contact
with in the community if I see there are patches they most likely will
understand better.  Those developers mostly hangout on our IRC channel.
(And we have plenty of space and room for more people who wants to get
involved)  If they don't the ACK patch, there is no guarantee - it might
or might not be included.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7c0DAACgkQDC186MBRfroX6ACfZ11a8OhOjG97P0A8h5q/aXS3
YgwAoJuIJIPGjn1AtAadVOx61UpYPUkf
=3DcqJY
-----END PGP SIGNATURE-----

