Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <2ec1296a-d633-2ad5-ea1a-ffc3b5668495@...2080...>
Date: Sun, 15 Jan 2017 10:59:07 -0800
Message-Id: <451FD5B4-9E9F-451B-8491-AC6D709CC64E@...277...>
References: <20170115061718.3218-1-praiskup@...1347...>
	<8e0e7b9b-3f54-88c4-6880-a3736a3a87ea@...2080...>
	<10918281.H3KHJINfQl@...2234...>
	<2ec1296a-d633-2ad5-ea1a-ffc3b5668495@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
	argument value
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
To: openvpn-devel@lists.sourceforge.net

A User's Perspective:
We've been doing just this since ovpn began allowing inline certs. Works gr=
eat! Recommend.=20

Marvin

Sent from my iPhone

> On Jan 15, 2017, at 9:53 AM, David Sommerseth <openvpn@...2080...> wrote:
>=20
>> On 15/01/17 14:52, Pavel Raiskup wrote:
>>> On Sunday, January 15, 2017 11:08:38 AM CET David Sommerseth wrote:
>>>> On 15/01/17 07:17, Pavel Raiskup wrote:
>>>> Adding a new --with-ca-bundle configure option.  It's argument is
>>>> used as default CA file when no --ca option is specified at
>>>> runtime.
>>>>=20
>>>> This option is primarily designed for systems where users are
>>>> allowed to manage trusted authorities for whole system (in one
>>>> consolidated file; usually implemented in 'ca-certificates'
>>>> package).
>>>>=20
>>>> Signed-off-by: Pavel Raiskup <praiskup@...1347...>
>>>> ---
>>>> configure.ac          | 5 +++++
>>>> src/openvpn/options.c | 9 +++++++++
>>>> 2 files changed, 14 insertions(+)
>>>=20
>>> As this was mentioned on a Red Hat Bugzilla (bz #1413343 [1]) as well,
>>> I'm reiterating my argument here for closing that bugzilla as notabug.
>>>=20
>>> I completely agree with Steffan, this is a NAK.  Such a feature would be
>>> a dreamscenario for The Great Firewall of China and similar national
>>> routing instances which implements complete network surveillance.  It
>>> would make it extremely trivial for them to implement a MITM OpenVPN
>>> server which would affect users not being aware of this issue.
>>>=20
>>> This feature would elude users configuring OpenVPN it is no problem
>>> using certificates from public CA issuers.  This is a VERY BAD idea!  We
>>> should help users configure OpenVPN in a secure way by default.  Not the
>>> opposite.
>>=20
>> Ack, I originally thought about this as tool to solve "packaging issue".
>> We have corporate-wide authority, and people usually have it stored in
>> bundle.  But I got the point, and such a shame mistake -- there's too ma=
ny
>> trusted CAs.
>=20
> I would recommend seeing the CA file being part of the configuration
> instead of a packaging detail.  And you can embedd the CA inside the
> configuration file ... just do this in the config:
>=20
>  <ca>
>  -----BEGIN CERTIFICATE-----
>  ....
>  ....
>  ....
>  -----END CERTIFICATE-----
>  </ca>
>=20
> This replaces the 'ca /path/to/ca.pem' line in the configuration file.
>=20
> Otherwise, for enterprises doing their own packaging ... it is also
> possible to install the OpenVPN CA file in /etc/pki/.... which is easily
> done with RPM files which again can be pushed out through internal
> repositories or Satellite.  The distributed configurations would then
> just need to use 'ca /etc/pki/tls/cert/openvpn-ca.pem'.
>=20
> It all depends on how often it is expected to distribute configuration
> files vs how often the CA certificate is renewed.
>=20
>=20
> --=20
> kind regards,
>=20
> David Sommerseth
> OpenVPN Technologies, Inc
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

