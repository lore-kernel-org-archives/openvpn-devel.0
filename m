MIME-Version: 1.0
References: <20210522033232.20548-1-selva.nair@...277...>
 <20210522033232.20548-3-selva.nair@...277...>
 <CAGyAFMXxsv7dcubA6QLr9G4onU+87N74_8_181fwup2Sm+Wb0A@...278...>
 <CAKuzo_jgcJH_mA=Cry9oidB4k5=EqEkkPQeWhza9E4TROt+TLQ@...278...>
In-Reply-To: <CAKuzo_jgcJH_mA=Cry9oidB4k5=EqEkkPQeWhza9E4TROt+TLQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 May 2021 14:03:30 -0400
Message-ID: <CAKuzo_g4eD2LpnpRzLkM0GDZD8ight=ARH9O4-GaT5VVXgcURw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Print format spec changes for
 tapctl and openvpnmscia
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

When _DEBUG is defined openvpnmsica builds okay using MSVC, but fails
on mingw (before and after this patch) with errors like

openvpnmsica.c:410:17: error: =E2=80=98L__FUNCTION__=E2=80=99 undeclared (f=
irst use in
this function); did you mean =E2=80=98NLS_FUNCTION=E2=80=99?
     debug_popup(TEXT(__FUNCTION__));

I have left it to be handled by a separate patch.

On gcc (and mingw) __FUNCTION__ =3D=3D function-name is not a macro and
TEXT(__FUCNTION__) that expands to L__FUNCTION__ is undefined.

We do not really need to convert __FUNCTION__ to wide string for debug
printing so I suggest to fix this by using it as is with %hs as the
print spec for both UNICODE and ANSI builds. No TEXT() required.

If that's okay I'll submit a patch.

The alternative is to use __FUNCTIONW__ when UNICODE is defined, but
it will complicate the logic for no reason.

We have no plans of using =CF=83 , =C2=B5 and =E2=84=B5=E2=82=92 in functio=
n names any time soon, do we :)

Selva

