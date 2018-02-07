Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
Date: Wed, 7 Feb 2018 21:41:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6JSschEwnS667BuF7ZoCfxGvRXWA1iFVs"
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6JSschEwnS667BuF7ZoCfxGvRXWA1iFVs
Content-Type: multipart/mixed; boundary="sNj7OAHcRpElKk7Dr2FjLjxgeNN4Pq5Lx";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)"
 <openvpn-users@lists.sourceforge.net>
Message-ID: <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
Subject: Re: [Openvpn-users] [Openvpn-devel] "Reconnect" button in openvpn-gui
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
In-Reply-To: <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>

--sNj7OAHcRpElKk7Dr2FjLjxgeNN4Pq5Lx
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/02/18 21:21, Selva Nair wrote:
>> Selva may correct me if I'm wrong, but my understanding of it when click=
ing
>> "Reconnect", the local OpenVPN process which caches the auth-token is st=
opped
>> and a new OpenVPN process is started.  The client should in this case as=
k for
>> username/password again.  So in this case, the server side should treat =
this
>> connection as a fresh connection with no initial state.
>=20
> GUI's reconnect button is wired to send a SIGHUP to the client openvpn
> process. The problem is that if auth-token is in use, the client
> openvpn.exe does not forget it it when restarting the connection by
> SIGHUP or SIGUSR1 -- I think it should but it doesn't. That leads to
> an AUTH_FAILED from server. The GUI has hard time distinguishing
> between reasons for AUTH_FAILED, so it just assumes that password
> verification failed and clears the saved password and prompts for a
> new one. Obviously users are not happy.

Ahh, thanks for the correction!

> In my view auth-token handling in openvpn.exe is broken at multiple level=
s:
>=20
> Client process:
> (i) it should not remember the token after a reconnect is issued

Agreed.  This should trigger retrieving new user input in regards to SIGHUP=
 at
least.  Not sure yet about SIGUSR1 though.  SIGHUP has a cleared semantic
though (hang-up).

> (ii) it should not remember the auth-token when auth-nocache is in
> effect --- without that there is no way for the GUI to take over
> handling auth-token. In my view auth-nocache is the only way
> openvpn.exe can stand aside and let the GUI take over all password
> handling. Unless we introduce a --management-auth-token flag.

Currently, OpenVPN will display the auth-token in the management interface
when received.  So the management interface should be able to capture it and
at least know that a token has been received.  But it should also have a
chance to override it.

> Else what's the use of sending the token to the management interface?

After a discussion with James in regards to the opposite problem with
NetworkManager.  NM would actually disconnect clients on each tunnel
renegotiation, as the auth-token was not cached by the NM-openvpn plugin.

We agreed the OpenVPN process was the owner of the token value, not the
management interface.  So commit 571165360db0392f was applied.  Now we at
least have a lot of more happy NM users :)

> Server process
> (iii) --gen-auth-token with an expiry just doesn't work -- we need to
> have a mechanism for the server to tell the client that the token has
> expired.

Agreed.  We've started looking into this.  But it will require a bigger API
overhaul to get the needed structs at the proper place where we can send the
"auth-token expired" message back to the client.  Those code paths involved,
both the send control channel message and the authentication functions have
quite different view to the session related structs.

>>> It looks like nobody uses that button.
>>>
>>> So, I asked several users, they confirmed they do not use Reconnect.
>> This is no good argument for me.  This is one specific setup with 1000 u=
sers.
>> It would be more valuable with 50 different setups having 20 users each.=
  Your
>> conclusion is based on a very homogeneous environment.
>=20
> Indeed. Actually I use that button frequently.
>=20
>>> After auth-token were introduced, when user press "Reconnect", it leads=
 to
>>> auth fail (saved password is forgotten),
>=20
> That reads as if introduction of auth-token broke reconnect. It did
> not. Only those users who have 2-factor turned on and use
> --gen-auth-token on the server are affected.

Yeah, I can see that being a bad combination.  We clearly didn't consider t=
he
"restart" scenario well enough.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--sNj7OAHcRpElKk7Dr2FjLjxgeNN4Pq5Lx--

--6JSschEwnS667BuF7ZoCfxGvRXWA1iFVs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJae2RnAAoJEIbPlEyWcf3ysj0QAKl6jdHXCoSNAkt7qDC0VIRm
XKbcLdtgIJmagPlLNm44KRQXFq9vPcVZgJpvPJ2QV9AInqU44ehhpbVkRjPsT51d
e4p9jr3i1IO9MBf2z09xO7Xt5CxB1CleTNj93an0YZOfxUOmtwjo/jpzru4icFKG
fDPGTLUO1Jm13xhHQy5JZQYoWVBK/yMneI7mMvTR8IAeYmcl2oHatob4VmTMk7MM
CBW4fXoVz6Ox1FB4N3ZZ0c7mpFlZWZm+vIueKtwRcL3/PKRR+CG6dyIBlB1w/X96
C9+NLmyL5isF16q2rSTGha3AIZ+MQJnQau+BQQr3uy8OoVC5fpR4mU36QJwmYmYH
lZnnL+YKlUq3RCSF6p34iC6z2Zs2h7t4esmaUddTjKwonYLSYpK15SSz+Rs2bDLt
lUVcPkfXNbYw41gbEd9UhhbEsUY/yLm9KSW2tFJJF35Cj0pUimJFLRNMOPEyqbOE
Wm9hZ3V+IBiumAJ2nquoPIWCV4pVxi+2KG7BKHYmMNLfoOtDwr/QzxbHc8nk03gS
2vadcx5Vub/rWqRr3SNnr6O8ubOge7ihqUJtY36Nm56xsVK70W3UpCeMTea34wkc
NIqZtYlMb8r6BPA6Eku1O32OHOn2IHKXBbhZgAUTxufxv2dKExwS+aWkz+PYBQz/
ya6q0vYXalSDcAwMYHXi
=94ZQ
-----END PGP SIGNATURE-----

--6JSschEwnS667BuF7ZoCfxGvRXWA1iFVs--

