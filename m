From: "Vladislav Grishenko" <themiron.ru@...277...>
References: <20200903114455.29341-1-themiron@...2010...>
 <0ec2c2a7-61d5-69c6-76a4-af83c283c64c@...2080...>
 <020d01d68612$75dbca00$61935e00$@gmail.com>
 <4c221e26-be61-cda4-32a0-7350e7f0be2f@...2080...>
In-Reply-To: <4c221e26-be61-cda4-32a0-7350e7f0be2f@...2080...>
Date: Thu, 10 Sep 2020 00:02:43 +0500
Message-ID: <02dd01d686db$cd805db0$68811910$@gmail.com>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set
 without port argument
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
To: 'David Sommerseth' <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Ok, thank you for clarification

--
Best Regards, Vladislav Grishenko

> -----Original Message-----
> From: David Sommerseth <openvpn@...2080...>
> Sent: Wednesday, September 9, 2020 10:49 PM
> To: Vladislav Grishenko <themiron.ru@...277...>; openvpn-
> devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set w=
ithout
> port argument
>=20
> On 08/09/2020 21:01, Vladislav Grishenko wrote:
> > Hi David,
> >
> >> -----Original Message-----
> >> From: David Sommerseth <openvpn@...2080...>
> >> Sent: Tuesday, September 8, 2020 6:23 PM
> >> To: Vladislav Grishenko <themiron@...2010...>; openvpn-
> >> devel@lists.sourceforge.net
> >> Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be
> >> set without port argument
> >>
> >> On 03/09/2020 13:44, Vladislav Grishenko wrote:
> >>> According client-options.rst additional argumets ``port`` and
> >>> ``proto`` are both optional and it's allowed to have port absent and
> >>> protocol
> >> set:
> >>>     --remote args
> >>>       Examples:
> >>>          remote server.example.net tcp
> >>>
> >>> But when protocol is set without preceeding port argument, it is
> >>> being misparsed as a port with subsequent error:
> >>>     RESOLVE: Cannot resolve host address: server.example.net:tcp
> >>>     (Servname not supported for ai_socktype)
> >>>
> >>> Since protocol names are predefined and don't match service names,
> >>> fix this behavior by checking second argument for valid protocol firs=
t.
> >>>
> >> Uhm ... I'm leaning towards a NAK to this patch and would rather
> >> suggest updating the man page to be correct.  This is a mistake from
> >> my side when converting the man page to .rst files.  The example shoul=
d be:
> >>
> >>        remote server.example.net 1194 tcp
> >>
> >
> > Hum. Initially all variants were supported, by checking numeric port
> > and taking it as proto, if not numeric. Later port became string
> > servname and optional logic was lost.
>=20
> The man page history disagrees ... even though, it doesn't say this order=
 is
> explicit.
>=20
> 2.4 -
> <https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage#lbAG>
> 2.3 -
> <https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage#lbAG>
> 2.2 - <https://community.openvpn.net/openvpn/wiki/Openvpn22ManPage>
> 2.1 -
> <https://community.openvpn.net/openvpn/wiki/Openvpn21ManPage#lbAG>
>=20
> > Man pages still has all of them since that time:
> >> 	remote server.exmaple.net
> >> 	remote server.exmaple.net 1194
> >> 	remote server.exmaple.net tcp
>=20
> These lines comes from this commit:
> <https://github.com/OpenVPN/openvpn/commit/f500c49c8e0a77ce665b11f6a
> dbea4029cf3b85f>
>=20
> Where the last line (missing port number) is incorrect.
>=20
> I also don't see any commit changing the "remote" parsing in options.c in=
 the
> way you describe.  This section has just few changes over the years, but =
even
> back to changes 7-12 years ago, the second argument has always been
> processed as a port number and the third one protocol.  Both causing an e=
rror if
> it is not a valid value.  So putting protocol in the second argument woul=
d trigger
> an error in 2.1, 2.2, 2.3 and 2.4 as far as I can see.
>=20
> >
> > At first look there is no need for proto w/o port set,  why it can be
> > important? With support of server host & port discovery (DNS SRV RFC
> > 2782), port info is not required, only host and protocol make sense.
> > So I though about this one little step forward toward ~consistent
> > syntax. Does it makes any sense?
> I don't see why OpenVPN's --remote parsing needs to comply with DNS SRV R=
FC
> standards.  How is that related at all?  I know we have patches for addin=
g DNS
> SRV query support, but that doesn't imply passing this information via
> add_option(), does it?
>=20
> If you use --remote vpn.example.com --proto tcp .... that will already wo=
rk.
> What will not work is --remote vpn.example.com tcp
>=20
> Also, this will work in config files:
> -------------------------------
> port 5000
> proto udp
>=20
> <connection>
> remote vpn1.example.com
> </connection>
> <connetion>
> remote vpn2.example.com
> proto tcp
> </connection>
> -------------------------------
>=20
> All of these use cases makes sense, as it depends on a pre-set value.  Wh=
at does
> not make sense to me is to muddy a pretty clearly defined argument order =
which
> has been the standard since the beginning of OpenVPN.
>=20
>=20
> --
> kind regards,
>=20
> David Sommerseth
> OpenVPN Inc
>=20



