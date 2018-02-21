MIME-Version: 1.0
In-Reply-To: <CAFHpkQGwrOTkOy0UDNUkAa3m4YZeUb7ZpKRjFWaj50KaAX47_Q@...278...>
References: <CAFHpkQGwrOTkOy0UDNUkAa3m4YZeUb7ZpKRjFWaj50KaAX47_Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 21 Feb 2018 12:03:16 -0500
Message-ID: <CAKuzo_gdOZq1m_fmV6NA2uM7+_5v-R9Pbsgut=C5yELx7bEp+g@...278...>
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

On Tue, Feb 20, 2018 at 10:10 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> Hello,
>
> is there any step-by-step example of implementing either static or dynamic
> challenge response ?

Static is easy:
On client: add --static-challenge "Enter OTP" 1 to the client config.
On server, merge my auth-pam plugin patch :)
https://patchwork.openvpn.net/patch/212/
and see the commit message for examples on using the plugin

Dynamic is even easier on the client side, if Windows -- just use
OpenVPN Windows GUI
But for server side, the only way I know is to consult the
management-notes.txt and implement a custom setup using
management-client-auth.

Selva

