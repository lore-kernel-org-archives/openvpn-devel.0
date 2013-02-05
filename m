Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
Date: Tue, 5 Feb 2013 07:10:05 -0600
Message-Id: <14D2E909-8BF3-42BC-A2CA-080719227E09@...1286...>
References: <510E43DE.20008@...1147...> <510E7997.8040909@...1114...>
	<1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I think this option should remain.  This is useful for temporarily disablin=
g users for VPNs that don't incorporate user/pass authentication.  I am opp=
osed to deprecating this function.


-----
Eric F Crist



On Feb 4, 2013, at 01:43:10, Adriaan de Jong <dejong@...1435...> wrote:

>> -----Original Message-----
>> From: David Sommerseth [mailto:openvpn.list@...1114...]
>> Sent: zondag 3 februari 2013 15:52
>> To: Jan Just Keijser
>> Cc: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
>>=20
>> On 03/02/13 12:02, Jan Just Keijser wrote:
>>> hi,
>>>=20
>>> what is the second option to '--crl-verify' supposed to do? in
>>> options.c it sets a flag SSLF_CRL_VERIFY_DIR which then triggers the
>>> function 'verify_check_crl_dir'. However, this function does not seem
>>> to do anything....
>>=20
>> Quickly looked at the code ... with the 'dir' flag (which sets
>> SSLF_CRL_VERIFY_DIR), it's no longer a typical CRL file validation.  If
>> you create (touch) a file in the defined directory with the file name
>> matching a particular client's serial number; the connection will be
>> denied.
>>=20
>=20
> Confirmed, with the footnote that this is a weird way of going about thin=
gs.=20
>=20
> I would like to suggest deprecating this option from 2.4 (or 2.3.1?) onwa=
rds, and forcing people to either:
>=20
> - Create an actual CRL file. This is not difficult. In general, people us=
ing OpenVPN should be managing their own CA in the OpenVPN world.
> - Failing that, create a custom script to do this.
>=20
> I'm always open for discussion, but imho this should not be core function=
ality in OpenVPN.
>=20
> Kind regards,
> Adriaan
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_d2d_jan
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


