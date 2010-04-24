From: <openvpn@...1315...>
Date: Sat, 24 Apr 2010 09:34:46 -0500
Message-id: <1272119686837120500@...1315...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=2432597625083128246516424839752072265147=axigen==="
Subject: Re: [Openvpn-devel] Status Message Missing IP Address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=2432597625083128246516424839752072265147=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



Hi,

This makes sense to me on the server side, but I'm running the management i=
nterface on the client ... why would it not know (or at least report) it's =
IP address?

Thanks,
... Russell



-----Original Message-----
From: David Sommerseth [openvpn.list@...1114...]=20
Sent: Saturday, April 24, 2010 5:08 AM
To: openvpn@...1315...
Cc: openvpn-users@lists.sourceforge.net; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Status Message Missing IP Address

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/04/10 06:54, openvpn@...1315... wrote:
>=20
> Hi,
>=20
> I have found what seems to be an interesting feature (bug) of the
> management interface =E2=80=93 as I have been using it to write a connect=
ion
> monitor application.
>=20
> Up until recently I have been using the server-bridge command on the
> server, and setting up a bridge (allowing OpenVPN to assign the IP
> address). When I did this the management interface on the client
> reported the IP address that it was assigned (both in real-time or
> manual state commands). However, now I have changed the server
> configuration file to allow the local DHCP server (router) to assign the
> client IP address. While this works fine, and the client connection is
> functional, the management interface no longer reports the client IP
> address.
>=20
> Is this a known (or for some reason planned) mode of operation?

Without having looked at the code, I would say this sounds reasonable.
As OpenVPN would not care about which IP address is being used when it
does not provide the IP address itself. The only reason OpenVPN would
do that is to avoid giving out the same IP address to several clients.
The rest of OpenVPN's task is to pass the traffic coming from the
UDP/TCP port on the Internet side, encrypt/decrypt the data and put it
into the TAP interface (in your case).

Having that said, it can be done some research on how the "learn
address" state is implemented and how that state is used when OpenVPN is
not assigning the VPN IP addresses.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvSwx0ACgkQDC186MBRfrqT8QCfWhQGeVhp6Fm2CjF7jJ46Tdk8
wqcAn09kxxP+efeuZOoUTenph02+zwOW
=3DBWfu
-----END PGP SIGNATURE-----

--===axigen=2432597625083128246516424839752072265147=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><BR>
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">Hi,<BR><BR>This make=
s sense to me on the server side, but I'm running the management interface =
on the client ... why would it not know (or at least report) it's IP addres=
s?<BR><BR>Thanks,<BR>... Russell<BR><BR><BR><BR>-----Original Message-----<=
BR>From: David Sommerseth [<A href=3D"mailto:openvpn.list@...1114..." targe=
t=3D_blank>openvpn.list@...1114...</A>] <BR>Sent: Saturday, April 24, 2010 =
5:08 AM<BR>To:<A href=3D"mailto:%20openvpn@...1315..." target=3D_blank> ope=
nvpn@...1315...</A><BR>Cc:<A href=3D"mailto:%20openvpn-users@...1357...=
rge.net" target=3D_blank> openvpn-users@lists.sourceforge.net</A>;<A href=
=3D"mailto:%20openvpn-devel@lists.sourceforge.net" target=3D_blank> openvpn=
-devel@lists.sourceforge.net</A><BR>Subject: Re: [Openvpn-devel] Status Mes=
sage Missing IP Address<BR><BR>-----BEGIN PGP SIGNED MESSAGE-----<BR>Hash: =
SHA1<BR><BR>On 24/04/10 06:54,<A href=3D"mailto:%20openvpn@...1315..." targ=
et=3D_blank> openvpn@...1315...</A> wrote:<BR>&gt; <BR>&gt; Hi,<BR>&gt; <BR=
>&gt; I have found what seems to be an interesting feature (bug) of the<BR>=
&gt; management interface =E2=80=93 as I have been using it to write a conn=
ection<BR>&gt; monitor application.<BR>&gt; <BR>&gt; Up until recently I ha=
ve been using the server-bridge command on the<BR>&gt; server, and setting =
up a bridge (allowing OpenVPN to assign the IP<BR>&gt; address). When I did=
 this the management interface on the client<BR>&gt; reported the IP addres=
s that it was assigned (both in real-time or<BR>&gt; manual state commands)=
. However, now I have changed the server<BR>&gt; configuration file to allo=
w the local DHCP server (router) to assign the<BR>&gt; client IP address. W=
hile this works fine, and the client connection is<BR>&gt; functional, the =
management interface no longer reports the client IP<BR>&gt; address.<BR>&g=
t; <BR>&gt; Is this a known (or for some reason planned) mode of operation?=
<BR><BR>Without having looked at the code, I would say this sounds reasonab=
le.<BR>As OpenVPN would not care about which IP address is being used when =
it<BR>does not provide the IP address itself. The only reason OpenVPN would=
<BR>do that is to avoid giving out the same IP address to several clients.<=
BR>The rest of OpenVPN's task is to pass the traffic coming from the<BR>UDP=
/TCP port on the Internet side, encrypt/decrypt the data and put it<BR>into=
 the TAP interface (in your case).<BR><BR>Having that said, it can be done =
some research on how the "learn<BR>address" state is implemented and how th=
at state is used when OpenVPN is<BR>not assigning the VPN IP addresses.<BR>=
<BR><BR>kind regards,<BR><BR>David Sommerseth<BR>-----BEGIN PGP SIGNATURE--=
---<BR>Version: GnuPG v1.4.10 (GNU/Linux)<BR>Comment: Using GnuPG with Fedo=
ra - <A href=3D"http://server:8080/redir.hsp?url=3D%68%74%74%70%3A%2F%2F%65=
%6E%69%67%6D%61%69%6C%2E%6D%6F%7A%64%65%76%2E%6F%72%67%2F" target=3D_blank>=
http://enigmail.mozdev.org/</A><BR><BR>iEYEARECAAYFAkvSwx0ACgkQDC186MBRfrqT=
8QCfWhQGeVhp6Fm2CjF7jJ46Tdk8<BR>wqcAn09kxxP+efeuZOoUTenph02+zwOW<BR>=3DBWfu=
<BR>-----END PGP SIGNATURE-----<BR></DIV></body></html>=

--===axigen=2432597625083128246516424839752072265147=axigen===--


