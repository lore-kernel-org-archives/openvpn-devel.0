Resent-Message-ID: <20180222050426.GA29172@...2378...>
Resent-To: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFP-eenz54yLirF0aYhMD5YonGmGMG+vpo3xmqXtEftbQ@...278...>
References: <CAFHpkQGwrOTkOy0UDNUkAa3m4YZeUb7ZpKRjFWaj50KaAX47_Q@...278...>
 <CAKuzo_gdOZq1m_fmV6NA2uM7+_5v-R9Pbsgut=C5yELx7bEp+g@...278...>
 <CAFHpkQFP-eenz54yLirF0aYhMD5YonGmGMG+vpo3xmqXtEftbQ@...278...>
Date: Wed, 21 Feb 2018 22:52:51 -0500
Message-ID: <CAKuzo_jcezyJ0OjRGwS0p==b-2gGUMhABsFtCSaa8P61MYvVvA@...278...>
From: Selva Nair <selva.nair@...277...>
Subject: Re: [Openvpn-devel] challenge/response example ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Feb 21, 2018 at 10:18 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>
> 2018-02-21 22:03 GMT+05:00 Selva Nair <selva.nair@...277...>:
>>
>> Hi,
>>
>> On Tue, Feb 20, 2018 at 10:10 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>> wrote:
>> > Hello,
>> >
>> > is there any step-by-step example of implementing either static or
>> > dynamic
>> > challenge response ?
>>
>> Static is easy:
>> On client: add --static-challenge "Enter OTP" 1 to the client config.
>> On server, merge my auth-pam plugin patch :)
>
>
>
> if static challenge is handled via pam, so ... there's only true/false ?
> I mean, is there a way to tell a user "your password is wrong" or "passwo=
rd
> is good, but response is wrong" ?

The usual practice with PAM is not to indicate that the user input is
partially correct as that leaks information to an attacker.  Of course
you can set it up in a less secure way. But avoid it unless you have a
strong reason.

In case of openvpn, anyway there is no easy way[*] to pass back such
info from server to client, so auth either succeeds or fails.

Selva

[*] Its possible to send back an AUTH_FAIL reason, but currently only
supported by --management-client-auth (not by auth scripts or plugins)
and used only to trigger dynamic challenge.

