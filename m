MIME-Version: 1.0
In-Reply-To: <BL0PR2101MB1058B54974E36CD4C13895D8AB540@...2440...>
References: <BL0PR2101MB1058B54974E36CD4C13895D8AB540@...2440...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Jul 2018 13:34:44 -0400
Message-ID: <CAKuzo_jyciOdtTjz1Y2b_qsedPqoN2GM5yaGkNCJ9eGGO6GaPQ@...278...>
Subject: Re: [Openvpn-devel] Incoming: patches for the dialer feature
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Jul 25, 2018 at 1:01 PM, Kevin Kane via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
> Ok, I=E2=80=99ve gotten clearance to contribute the dialer feature from M=
icrosoft=E2=80=99s
> OpenVPN fork back upstream. As previously discussed, this feature isn=E2=
=80=99t
> production-ready because the integration I did was quick and dirty =E2=80=
=93 it
> mainly just sends commands to a running OpenVPN-GUI process in the same w=
ay
> as the context menu already does, with some fragile logic to locate the
> running OpenVPN process.
>
>
>
> That being said, the spelunking I did to hook up the plumbing with the
> Windows shell may prove useful in the future for something more fleshed o=
ut,
> and so I=E2=80=99m offering this up in case you=E2=80=99d all like to do =
something more
> involved with it.

Yeah, this is a good starting point for hooking to the GUI, hopefully
someone will do the "fleshing out" to make it more useful.

Do we have an experimental branch where we could add this so that we do
not lose track of it?

Selva

