From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 7 May 2012 09:23:22 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9012D1B7431A@...1436...>
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
In-Reply-To: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> Sent: zondag 6 mei 2012 18:55
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] [RFC] Split plugins into their own
> repositories
>=20
> Hello,
>=20
> Now, I also have the courage to ask one more question regarding
> build....
>=20
> We currently have:
> - auth-pam
> - defer
> - down-root
> - examples
>=20
> Distribution wise it will be best to allow admin to install plugins as
> own package which requires openvpn, allowing select specific plugins,
> while each has own release cycle and versioning.
>=20
> I already made the openvpn-plugin.h available in /usr/include, so there
> is no real reason to keep the plugins in openvpn tree, as they can be
> complied using their own separate build system.
>=20
> for example, if we take RHEL, we can install the following to use the
> auth-pam plugin:
>=20
> openvpn
> openvpn-plugin-auth-pam
>=20
> To build plugin we need openvpn-devel.
>=20
> What do you say?
>=20
> BTW: next will be probably to split out the contrib... :)
>=20
> Alon
>=20

Aren't we going a little far in the whole splitting business? I though spli=
tting the build system off was already taking it a too far.=20

These plugin and contrib. directories are directly related to the current v=
ersion of OpenVPN. Having them in the same tree, especially one that has al=
ready been cleaned up by giving it a separate src directory.

My vote therefore goes towards keeping them inline!

Adriaan

