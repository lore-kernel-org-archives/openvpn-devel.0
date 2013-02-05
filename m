From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 5 Feb 2013 16:36:14 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901349CFC522@...1436...>
References: <510E43DE.20008@...1147...> <510E7997.8040909@...1114...>
	<1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
	<51111E7A.4000108@...1114...>
In-Reply-To: <51111E7A.4000108@...1114...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: James Yonan <james@...515...>

> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]
> Sent: dinsdag 5 februari 2013 16:00
> To: Adriaan de Jong
> Cc: openvpn-devel@lists.sourceforge.net; Jan Just Keijser; James Yonan
> Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
>=20
> On 04/02/13 08:43, Adriaan de Jong wrote:
> >> -----Original Message-----
> >> From: David Sommerseth [mailto:openvpn.list@...1114...]
> >> Sent: zondag 3 februari 2013 15:52
> >> To: Jan Just Keijser
> >> Cc: openvpn-devel@lists.sourceforge.net
> >> Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
> >>
> >> On 03/02/13 12:02, Jan Just Keijser wrote:
> >>> hi,
> >>>
> >>> what is the second option to '--crl-verify' supposed to do? in
> >>> options.c it sets a flag SSLF_CRL_VERIFY_DIR which then triggers
> the
> >>> function 'verify_check_crl_dir'. However, this function does not
> >>> seem to do anything....
> >>
> >> Quickly looked at the code ... with the 'dir' flag (which sets
> >> SSLF_CRL_VERIFY_DIR), it's no longer a typical CRL file validation.
> >> If you create (touch) a file in the defined directory with the file
> >> name matching a particular client's serial number; the connection
> >> will be denied.
> >>
> >
> > Confirmed, with the footnote that this is a weird way of going about
> things.
> >
> > I would like to suggest deprecating this option from 2.4 (or 2.3.1?)
> onwards, and forcing people to either:
> >
> >  - Create an actual CRL file. This is not difficult. In general,
> people using OpenVPN should be managing their own CA in the OpenVPN
> world.
> >  - Failing that, create a custom script to do this.
> >
> > I'm always open for discussion, but imho this should not be core
> functionality in OpenVPN.
>=20
> I agree that this directory based "CRL" with empty files shouldn't be a
> core part of OpenVPN.  This is in my eyes what --tls-verify scripts is
> supposed to solve.  I also agree with JJK, that implementing proper CA
> path support makes a lot of sense.  Even though PolarSSL lacks this
> support now, I believe Paul wouldn't instantly object a patch
> implementing a CA path support.
>=20
> However, I'm not sure it's a good idea to remove this feature in 2.4 or
> earlier.  There are people depending on this feature.  And it touches
> the same discussion topic we had at FOSDEM regarding --compat-names and
> --no-name-remapping.
>=20
> If removed, I would say it should be removed in OpenVPN 3.  We can
> start warning about it in 2.4.  However, I'd really like to have James
> feedback on this as well before we just decide to kill it off at a
> later release.  Just because I want to avoid the same
> situation/discussion as we had at FOSDEM.
>=20

I agree, that's why I suggested deprecation of this feature. We could even =
provide an example script that performs the same functionality.

About JJK's issue, I'm not sure whether Paul has support for loading all CR=
Ls in a directory planned, but it should be a small patch now that crt load=
ing exists.

As an aside, I'm working on a patch that moves CRL verification from OpenVP=
N into the SSL library (where it should be). Expect that within a few days.

Adriaan


