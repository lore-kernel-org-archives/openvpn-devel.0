From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 4 Feb 2013 08:43:10 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
References: <510E43DE.20008@...1147...> <510E7997.8040909@...1114...>
In-Reply-To: <510E7997.8040909@...1114...>
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Jan Just Keijser <janjust@...1147...>

> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]
> Sent: zondag 3 februari 2013 15:52
> To: Jan Just Keijser
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
>=20
> On 03/02/13 12:02, Jan Just Keijser wrote:
> > hi,
> >
> > what is the second option to '--crl-verify' supposed to do? in
> > options.c it sets a flag SSLF_CRL_VERIFY_DIR which then triggers the
> > function 'verify_check_crl_dir'. However, this function does not seem
> > to do anything....
>=20
> Quickly looked at the code ... with the 'dir' flag (which sets
> SSLF_CRL_VERIFY_DIR), it's no longer a typical CRL file validation.  If
> you create (touch) a file in the defined directory with the file name
> matching a particular client's serial number; the connection will be
> denied.
>=20

Confirmed, with the footnote that this is a weird way of going about things=
.=20

I would like to suggest deprecating this option from 2.4 (or 2.3.1?) onward=
s, and forcing people to either:

 - Create an actual CRL file. This is not difficult. In general, people usi=
ng OpenVPN should be managing their own CA in the OpenVPN world.
 - Failing that, create a custom script to do this.

I'm always open for discussion, but imho this should not be core functional=
ity in OpenVPN.

Kind regards,
Adriaan


