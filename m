References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
	<6256c846-ca60-be4f-7122-60465374a322@...515...>
	<7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
Date: Thu, 2 Feb 2017 10:27:53 +0200
MIME-Version: 1.0
In-Reply-To: <7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>

On 31/01/2017 15:49, David Sommerseth wrote:
> On 30/01/17 13:34, Samuli Sepp=C3=A4nen wrote:
>> I agree with you on keeping the pull request template minimal and having
>> the more fine-grained information in Trac.
>>
>> ACK.
>
> Don't get me wrong!  I agree we should keep the template minimal.  But I
> yet have to see a developer full of enthusiasm with a fix ready, who
> just clicked "Send pull request!" who will actually instantly go reading
> further.  And especially when the information need is fairly
> comprehensive and not even directly in the first URL being listed.
>
> In fact the first place where the patch process is described is here:
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Commun=
itypatchesandtheacceptanceprocessofthesepatches>.
>  That is "hidden" in the middle of the wiki on the second URL.  And the
> first URL provides just a link to the same DeveloperDocumentation wiki pa=
ge.
>
> So I kindly ask you to reconsider the text more carefully once more.
>
> From my experience, to get the best success, provide the most critical
> and as accurate information as quickly as possible.  Once things are
> behind one URL you need to visit, many ignores it.  If you need to read
> through more text on that URL, even more will fall off.  But provide
> links to the more verbose documentation, as some will read it if the
> first 2-3 sentences sounds intriguing and the contributor have time to
> be curious.
>
> Most developers are lazy beasts ... they just want their patches out
> ASAP, and documentation are too easily ignored.
>
>

Well, I asked if anyone had any comments regarding the PR template text,=20
and nobody did. Except when it was ACKed, of course :).

I think we need to lure GitHub people into sending patches to the=20
mailing list. If we describe the full process in the pull request=20
template, many will just say "meh, too difficult". Once they've sent=20
their patch to the list they're quite far already, and are unlikely to=20
quit if we ask them to make minor changes.

So what about this:

---

# Thank you for your contribution

You are welcome to open PR, but they are used for discussion only. All
patches must eventually go to the openvpn-devel mailing list for review:

* https://lists.sourceforge.net/lists/listinfo/openvpn-devel

Please send your patch using=20
[git-send-email](https://git-scm.com/docs/git-send-email). For example=20
to send your latest commit to the list:

     $ git-send-email --to=3Dopenvpn-devel@lists.sourceforge.net HEAD~1

For details, see these Wiki articles:

* https://community.openvpn.net/openvpn/wiki/Contributing
* https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation

---

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

