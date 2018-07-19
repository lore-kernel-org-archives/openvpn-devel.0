MIME-Version: 1.0
In-Reply-To: <CAEsd45Rd+5_NTeQ_E1C9wps89GWU6OfxQ5CdEFiN_HCO0=xaAQ@...278...>
References: <CAEsd45Rd+5_NTeQ_E1C9wps89GWU6OfxQ5CdEFiN_HCO0=xaAQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 18 Jul 2018 22:48:41 -0400
Message-ID: <CAKuzo_in_bBm1Y1rwU3rhFfuUP8o7j9iQH9vyjk9myT42tpBSg@...278...>
Subject: Re: [Openvpn-devel] Dynamic challenge/response questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Jul 18, 2018 at 7:46 PM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
> I'm trying to implement dynamic challenge/response in Tunnelblick and
> have some questions. I've been using the management-interface
> documentation [1] as my guide.
>
> 1. Is what the management interface sends something like (all on one line):
>
>>PASSWORD:Verification Failed: 'Auth' ['CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN:']
>
> and not just the challenge all by itself?

There are two messages involved:

1. First comes the fake auth failure message which contains the
challenge string. The format of this is as you have quoted above. The
single quoted string between the square brackets is what is actually
sent by the server. This should be parsed as

CRV1:flags:state_id:base64_username:challenge
(note that there is no colon at the end)

So in the above example
flags = R,E
state_id = Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6I
base64_username = Y3Ixh
challenge = Please enter token PIN:

In this case the last colon is a part of the challenge as its not a
part of the protocol.

As the daemon thinks auth failed, this will trigger a restart. On
restart the client openvpn daemon will prompt for username password as
usual. So

2. The usual auth prompt comes as

>PASSWORD:Need 'Auth' username
>PASSWORD:Need 'Auth' password

The GUI should remember that this prompt follows the
verification-failure message that contained a CRV1 challenge and be
ready to respond accordingly. And should be responded to in the same
format as usual user-auth response but this time with the decoded
username as username and the specially formatted challenge response
(see below) as the password.

> 2. Is the final ":" in the above part of the prompt to be shown to the
> user, or is it a delimiter showing the end of the prompt?

Yes

>
>
> 3. Is the response back to the management interface really like this:
>
> Username: cr1 ("Y3Ix" base64 decoded)
> Password: CRV1::Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l::8675309

No, the management-notes.txt is a bit less explicit here. Its only
indicating what username and password should be returned, not the
format of the reply. The response is in reply to the usual "Auth" username
and password prompts so should be formatted as

username "Auth" cr1
password "Auth" CRV1::Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l::8675309

where 8675309 is the response to the challenge provided by the user.

>
> I ask because the syntax for the username/password for a
> NON-challenge/response response back to the management interface is
>
> username "Auth" THE_USERNAME
> password "Auth" THE_PASSWORD
>
> which has "username" and "password" in lower-case and without the ":"s.

That description in management-notes.txt means that the text following
Username: should be passed back as username and the text following
Password: as password. It should be returned in the above format is
assumed to be understood  --- but, yes, that text could be made more explicit.

>
>
> 4. Can the Username and Password fields sent to the OpenVPN management
> interface be quoted (and must double-quotes within the fields be
> escaped), as with the NON-challenge/response response?

Internally, the username and password are parsed by openvpn the same
way whether its a simple user/password or user/password/challenge or
user/dynamic-challenge-response. That's why in all cases the format is
"username type THE_USERNAME" and "password type THE_PASSWORD". So,
quoting rules are the same in all three cases. The only difference is
THE_PASSWORD is a specially formatted string in case of static and
dynamic challenge responses.

The verification scripts on server side will pick the password apart to isolate
the challenge response but openvpn treats it as an opaque string. As with
everything received from the management, It does, however, pass through the
config parser which does quote processing and unescaping.

OpenVPN-GUI for windows uses this template for the format string to
construct the CRV1 "password" reply:

template = "password \"Auth\" \"CRV1::%s::%s\""

and pass the result though an escape processor before writing to the
management socket. Alternatively you can use single quotes to enclose
the 'THE_PASSWORD'.

Selva

