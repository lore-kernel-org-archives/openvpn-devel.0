MIME-Version: 1.0
In-Reply-To: <105bf86c-4cd3-ba94-3141-e5979faaf507@...2080...>
References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<95391fd4-7b2f-389c-3752-4123d016286d@...68...>
	<CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
	<d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>
	<105bf86c-4cd3-ba94-3141-e5979faaf507@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 15 Oct 2016 12:35:28 +0200
Message-ID: <CAA1AbxKH6m8xrzfZKUQoXLXc8=rNBcChczmpW+yKNK4pzvViPA@...278...>
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
	releases?
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 15 October 2016 at 12:11, David Sommerseth
<openvpn@...2080...> wrote:
> On 15/10/16 11:01, Matthias Andree wrote:
>> Am 14.10.2016 um 21:51 schrieb Steffan Karger:
>>>
>>> On 14 Oct 2016 9:14 p.m., "Matthias Andree" <matthias.andree@...68...
>>> <mailto:matthias.andree@...68...>> wrote:
>>> >
>>> > Am 14.10.2016 um 17:28 schrieb Samuli Sepp=C3=A4nen:
>>>
>>> > > Would 2.3.12 -> 2.4-alpha1 be too big an upgrade?
>>> > >
>>> > Yes, definitely. Please create a separate distribution for .deb packa=
ges
>>> > derived from pre-releases.
>>>
>>> Indeed. We shouldn't upgrade people who are expecting stable releases
>>> to alpha versions.
>>>
>> One more somewhat more constructive note:
>> Oracle have been naming their VirtualBox packages such that they
>> included the minor version in the NAME.
>> So the package name would be openvpn-2.3 or openvpn-2.4 for us, which
>> creates redundancy as the actual version is added (openvpn-2.3-2.3.12),
>> but it prevents moving users between release branches.
>>
>> Alpha/beta releases and perhaps the early release candidates should
>> still also be marked in a separate "unstable" 'distribution'.
>
> That's a clever thing, and is also done in the Fedora/RHEL world too.
> However there are some pitfalls which is needed to beware of.
>
> You either need to
>
> a) have the files installed in a way so they don't collide.  Then
>    use some tools (like 'alternatives' in the Fedora/RHEL world) to
>    switch between which version being system default

Yes, this is great.  Quite a few packages in the debian/ubuntu world
do this too.  Particularly handy if there's also a virtual package
that just installs the most recent stable version, so that I don't end
up with an eol version without noticing.  (E.g. there are packages
openvpn-2.3, openvpn-2.4 and openvpn, where openvpn is a dummy that
right now depends on openvpn-2.3, and as soon as 2.4 becomes stable
depends on openvpn-2.4.)

> b) Have the package exclude each other to block both being installed
>    at the same time.

Slightly easier for the maintainer, but a lot less useful than a) for the u=
ser.

-Steffan

