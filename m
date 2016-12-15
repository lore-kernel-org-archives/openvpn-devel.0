References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
	<3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
	<CAKuzo_gFnsY-6nsEsP_jPmfXLrJs0mDj-9fhwKQC-12TwfVAYg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <989fe285-59a8-ad15-4e1d-1f25486dfe1e@...2080...>
Date: Thu, 15 Dec 2016 14:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gFnsY-6nsEsP_jPmfXLrJs0mDj-9fhwKQC-12TwfVAYg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kWeq5ufupOvT7OSp9dlGIA02CWUsSaJPm"
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kWeq5ufupOvT7OSp9dlGIA02CWUsSaJPm
Content-Type: multipart/mixed; boundary="t045grW0qNCap6OMkLpfmO1cbkcWlqrqn";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <989fe285-59a8-ad15-4e1d-1f25486dfe1e@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
	<3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
	<CAKuzo_gFnsY-6nsEsP_jPmfXLrJs0mDj-9fhwKQC-12TwfVAYg@...278...>
In-Reply-To: <CAKuzo_gFnsY-6nsEsP_jPmfXLrJs0mDj-9fhwKQC-12TwfVAYg@...278...>

--t045grW0qNCap6OMkLpfmO1cbkcWlqrqn
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/12/16 06:09, Selva Nair wrote:
>=20
> On Wed, Dec 14, 2016 at 4:18 PM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>     On 13/12/16 22:42, David Sommerseth wrote:
>     >
>     > Hi all,
>     >
>     > So the first phase of the great reformatting is on its way.  I have
>     > just pushed out a reformatting branch to the following
>     > repositories:
>     >
>     > https://github.com:OpenVPN/openvpn.git
>     > https://gitlab.com:openvpn/openvpn.git
>     > git://git.code.sf.net/p/openvpn/openvpn
>     <http://git.code.sf.net/p/openvpn/openvpn>
>     >
>=20
>     An updated reformatting branch have been pushed out.  If you have
>     already fetched the it, git will most likely complain as to make
>     these tests flow reasonably well without cluttering the git tree
>     too much we have used forced pushes on this branch.
>=20
>     And again, the The Great Reformatting patch is PGP signed as well,
>     which can be verified with 'git log --show-signature'.  The
>     signing key is 0x86CF944C9671FDF2, which is the same as this mail
>     is signed with.
>=20
>=20
> The reformatting looks pretty good for an automated process. The result
> agrees with independently running the script on master.
>=20
> The only issue I noticed is that some functions, for loops and switch
> statements have their opening braces on the same line
> ssl.c line 272, tun.c line 697 and many such in the several files.
> (try grep ") {$"  *.c).
>=20
> Probably needed nl_switch_brace, nl_fcall_brace etc in the config --
> urgh.. Too many options is a blessing and bane at the same time..

Agreed.  I think that we can do some minor reformatting changes later on
if we decide to change some more options.  Those reformatting changes
will most likely not be as invasive as this one has been.

> This is not a show stopper for me. Could be handled manually in future
> edits when code in the vicinity is touched..

I will now write a new script which patch contributors should run
against modified files before committing and submitting.  This should
hopefully make it better in the long run.  But with that in mind, we
will need to re-run the reformat-all.sh script each time we decide to
modify uncrustify options.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--t045grW0qNCap6OMkLpfmO1cbkcWlqrqn--

--kWeq5ufupOvT7OSp9dlGIA02CWUsSaJPm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUpQGAAoJEIbPlEyWcf3yAYgQAKzJO9Gh6dyqI1AZV6U52uaV
KtWQQMACpiqV3+BgefH5YUgn3RZsNUQpbap5WUD9q1zJFFaspyL9vWzj3m3pCS1g
/PQ9wZuaIUqIIDF1XrEuL4oVyP7+A1n/ZPJwY4sUsYEQEw5KwITq6zWkgqUQHG2M
ruzlbVjwh7I/QIRVMfOfnpICqq94PWB6wrBPq0Aoo0k0PLHrXEMIZ9qkdjJWSTDB
Z1GgND1C3O85Hx6dw4Xf+kaRlZs5fzE65tHzqJ/1KL/VUzvRT/MQM/UqVapCypPQ
p6ywkjRj6bvBnU9WfqVI7ckAO5HpZ/fGdE82t1BIBzlmS3jx9LrWz4Anp3toGYJF
w0+K8ufSpJhvv798Nn8WJAYdxl/JSI57v/VbqgoUWh+ovd46gNb0/jmy2xkyMz3e
iTVbLgzeihFiNukqMlV5zqDLPb3Qse2VTce13UPk7IA07K5mjL9s5a0acw1qI/rl
YrdR/xBx526EZk9IxpA/MoGSX9X9uH6SjCbM+fNlWRmN6w0my29zxRbI5uZKsjWc
/dzh3guu5KClL/R6FsiPyMEEY/liLEtvg/q5A3e45Bj8lvqisuaZyjSCqpRetK9A
7P4IUUEHpez7AznqwBvtDNs10LKEmwPMlBVyysFvqiZCnizmaszHOw7jaDJIV4tx
IB9ozbvgTY0vIN5Qdq/k
=FvnY
-----END PGP SIGNATURE-----

--kWeq5ufupOvT7OSp9dlGIA02CWUsSaJPm--

