References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
	<7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
	<cbab7858-a753-d599-97ec-782f1b686f99@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5179a07a-36da-4f6e-9707-4b8ded923d89@...515...>
Date: Tue, 7 Feb 2017 16:27:36 +0200
MIME-Version: 1.0
In-Reply-To: <cbab7858-a753-d599-97ec-782f1b686f99@...2080...>
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
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>, chipitsine@...277...

On 07/02/2017 15:03, David Sommerseth wrote:
> On 07/02/17 11:09, Samuli Sepp=E4nen wrote:
>> Actually, that was just the line length for _code_, not for commit
>> messages. So the only indirect guideline for Git commit message line
>> length was
>
> Correct.
>
>> "The maximum length of the line differs between projects, it's usually
>> somewhere between 50 and 78 characters"
>>
>> which was on this page:
>>
>> <http://who-t.blogspot.fi/2009/12/on-commit-messages.html>
>>
>> The "seven rules" URL David linked to says the following:
>>
>> * Limit the subject line to 50 characters
>> * Wrap the body at 72 characters
>>
>> I can't recall us ever agreeing to such limits.
>
> That is actually a pretty much a de-facto standard among all git users.
> The subject line at 50 chars is because it makes git shortlog, git log
> --oneline and similar tools produce reasonable outputs which keeps the
> total line length, including indenting, within 78 characters.
>
> In addition github, gitlab, gerrit, etc will also truncate subject lines
> which are longer than 50 characters.
>
> Similarly the body wrapping at 72, is to account for a similar indenting
> which git does when presenting the body message text.
>
> And it just takes a quick look at our git log to see that we try to stay
> beyond that limit.  We do sometimes exceed 50 characters, and we let
> that pass silently.  But more than 3 times longer, then something must
> be done.
>
>

I rewrote the DevelopDocumentation page:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentationNew>

Changes in a nutshell:

- Most of the verbose but useful stuff was moved to separate page
- Some totally outdated content was removed (FRP, release process, etc)
- Redundant content was removed

Does the new page look like a reasonable starting point for _new_=20
developers?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

