References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
Date: Tue, 7 Feb 2017 12:09:45 +0200
MIME-Version: 1.0
In-Reply-To: <13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] github: Add PR template with
 contributor related information
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <davids@...515...>, chipitsine@...277...
Cc: openvpn-devel@lists.sourceforge.net

On 07/02/2017 11:06, Samuli Sepp=E4nen wrote:
> On 06/02/2017 12:44, David Sommerseth wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I have ACKed and applied this, just to get this one resolved.  But I am =
very
>> disappointed that you have yet again completely ignored the guidelines
>> described in the URL[1] already provided to you - which describes how a =
patch
>> and commit message should look like.
>>
>> In fact - your SUBJECT line was 167 characters long, _including_ a URL. =
 It
>> did not even have a proper body message.  *sigh*
>
> The 80 character limit is only documented here:
>
> <https://community.openvpn.net/openvpn/wiki/CodeStyle>
>

Actually, that was just the line length for _code_, not for commit=20
messages. So the only indirect guideline for Git commit message line=20
length was

"The maximum length of the line differs between projects, it's usually=20
somewhere between 50 and 78 characters"

which was on this page:

<http://who-t.blogspot.fi/2009/12/on-commit-messages.html>

The "seven rules" URL David linked to says the following:

* Limit the subject line to 50 characters
* Wrap the body at 72 characters

I can't recall us ever agreeing to such limits.

Let's agree on what we want and then document it properly.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> This is a fairly new page and not linked to from anywhere. On top of
> that the page says that "This coding style is not final and not yet in
> effect."
>
> Moreover, our developer documentation is quite a mess right now:
>
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
> <https://community.openvpn.net/openvpn/wiki/Contributing>
>
> For example, the DeveloperDocumentation page links to here:
>
> <https://community.openvpn.net/openvpn/wiki/CodingConventions>
>
> That page is a stub with very little and possibly outdated/false
> information. Then we have
>
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Format=
ting>
>
> which says we use "GNU coding style". And then we have the actual 2.4
> code style instructions here:
>
> <https://community.openvpn.net/openvpn/wiki/CodeStyle>
>
> There is a fairly well-hidden link on the DeveloperDocumentation page to
> these Git commit message instructions:
>
> <http://who-t.blogspot.com/2009/12/on-commit-messages.html>
>
> I think that blog posting is too verbose. The essential information,
> such as the "seven rules" you linked to should be directly on the
> DeveloperDocumentation page, with links to the original documents.
>
> I don't want to argue whether Ilya should know the 80 character limit or
> not. But how can we expect _new_ developers to get our rules if they are
> not documented properly or if documentation is contradictory? Or if the
> documentation is hidden as well as the CodeStyle page?
>
> I will create a copy of the DeveloperDocumentation page and clean that
> one up. Then I will send a link so that others can have a look.
>



