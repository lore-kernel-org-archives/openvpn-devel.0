Message-ID: <4EDCBAA8.4080104@...515...>
Date: Mon, 05 Dec 2011 14:35:52 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4ED8C741.9000502@...1114...> <4EDCA110.9090307@...515...>
	<1CED409804E2164C8104F9E623B08B90128AA72499@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90128AA72499@...1436...>
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> -----Original Message-----
>> From: Samuli Sepp=E4nen [mailto:samuli@...515...]
>> Sent: maandag 5 december 2011 11:47
>> To: David Sommerseth
>> Cc: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] Suggesting a new patch review approach
>>
>>
>>> Hi,
>>>
>>> We've had a very strict patch review regime since we moved over to
>> git.
>>> We see that this regime does work, but it can take a very long time
>>> before patches are reviewed and ACKed for inclusion.  This long delay
>>> is something we are less happy about.
>>>
>>> So I'm suggesting a new approach here.  I've noticed that if there
>> are
>>> issues with patches, they are usually NACKed rather fast.  But the
>>> explicit ACKs are not happening as fast.  And this is something I'd
>>> like to make take an advantage of.
>>>
>>> I'm suggesting that if there are patches which someone do find
>> useful,
>>> which has not been accepted, they need to be ACKed.  But if I see
>> that
>>> a patch is floating on the ML longer than 14 days without any
>>> responses and I on a cursory glance see that this patch can make some
>>> sense, I will apply this patch to the git tree.  These patches will
>>> not have any 'Acked-by' statement.
>>>
>>> If I see that a patch is relevant and want a second opinion about it,
>>> I will nag some concrete persons.  If they don't respond after 14
>>> days, I will most likely add the patch, adding a 'Cc:' statement with
>>> their mail address.  This is to indicate in the commit log that the
>>> Cc'ed persons have been informed about this patch.
>>>
>>> If it turns out that a patch should not have been included, we will
>>> naturally revert the patch again, provided we get a reasonable
>>> explanation why it needs to be reverted.
>>>
>>> This is only a suggestion, but unless this causes a clear
>>> dissatisfaction in the community, I'd like to start using this new
>> outline asap.
>> Hi,
>>
>> I think this is definitely worth a shot for a number of reasons.
>> Currently it's too easy to leave patches lying in the INBOX, in hopes
>> that somebody else takes care of them first. This strategy obviously
>> makes sense from personal stress / time management perspective (I've
>> used it also on occasion). However, I fear this also means that this
>> "somebody" will probably be the same person more often than not. This,
>> in turn, means that others soon notice that this person can move things
>> forward by himself, and that they don't need to participate as much.
>> This could create a nasty self-feeding cycle.
>>
>> I'm not sure if the above analysis is correct, but for whatever reason
>> our current ACK model has not worked as smoothly as we would have
>> liked.
>> Also, most of the ACKs have been given by a small subset of developers,
>> whereas NACKs have a more even distribution. Also, a big percentage of
>> patches have been ACKed in public IRC meetings because of lack of
>> feedback on the mailing lists. This is suboptimal as only a handful of
>> people can attend the meetings (e.g. due to timezones).
>>
>> I think the new model might motivate people to participate, as we all
>> want to keep crap out of OpenVPN to ensure it works great in the future
>> also. So, I say go for it, and if it does not work, revert back to the
>> old practice or figure out something else.
>
> I agree that a different patch approach might help. I haven't got much ex=
perience in submitting single smaller patches, but it took a long time to g=
o through all of the patches in the PolarSSL queue. The solution we used fo=
r this was to perform analysis of the patches online on IRC. This worked we=
ll, but had the disadvantage that everyone involved needs to be online at t=
he same time.
>
> A model that seems to be successful in some other projects is the use of =
gerrit for code review. Is that something that we could experiment with? At=
 the very least, it would make offline discussions a little easier by allow=
ing you to comment directly on certain blocks of code. Gerrit might also mo=
tivate more people to participate, since it makes reviewing a little more i=
nteractive.
>
> Adriaan
I think for really large patchsets (e.g. PolarSSL) the IRC is actually
pretty good. There's often quite a lot of communication involved when
reviewing patches (e.g. "why is this doing this like this?"), so
reviewing 100 patches on the ml would be painful if not impossible.

David spoke of Gerrit and if it helps with patch review I'm all for it.
In fact, I more or less promised to set it up after the 2.3 release.

One thing I forgot to ask about... should we still require an ACK for
all patches that go to "stable" release branches? Or should we include
any "silently approved" fixes from "master" without further discussion?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


